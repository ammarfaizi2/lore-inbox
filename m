Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289815AbSCGBxJ>; Wed, 6 Mar 2002 20:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290228AbSCGBxC>; Wed, 6 Mar 2002 20:53:02 -0500
Received: from are.twiddle.net ([64.81.246.98]:19866 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S289815AbSCGBwn>;
	Wed, 6 Mar 2002 20:52:43 -0500
Date: Wed, 6 Mar 2002 17:52:03 -0800
From: Richard Henderson <rth@twiddle.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@transmeta.com, matthew@hairy.beasts.org, bcrl@redhat.com,
        david@mysql.com, wli@holomorphy.com, linux-kernel@vger.kernel.org,
        Hubertus Franke <frankeh@watson.ibm.com>
Subject: Re: [PATCH] Fast Userspace Mutexes III.
Message-ID: <20020306175203.A26064@twiddle.net>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	torvalds@transmeta.com, matthew@hairy.beasts.org, bcrl@redhat.com,
	david@mysql.com, wli@holomorphy.com, linux-kernel@vger.kernel.org,
	Hubertus Franke <frankeh@watson.ibm.com>
In-Reply-To: <E16hjZY-0001AV-00@wagner.rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E16hjZY-0001AV-00@wagner.rustcorp.com.au>; from rusty@rustcorp.com.au on Mon, Mar 04, 2002 at 02:55:36PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2002 at 02:55:36PM +1100, Rusty Russell wrote:
> +	/* If we take the semaphore from 1 to 0, it's ours. */
> +	while (!atomic_dec_and_test(count)) {
> +		if (signal_pending(current)) {
> +			retval = -EINTR;
> +			break;

This is not safe from wraparound.  Let one thread hold the
lock forever; let other threads keep trying to take the lock
while periodically getting SIGALRM.  Eventually one of the
spinning threads will incorrectly acquire the mutex.

On sparc32, atomic_t is only 24 bits wide, so it wouldn't
take very long at all to wrap.  It's slightly longer for 
the other platforms, but it can still happen.  And note
that even 64-bit platforms may be using a 32-bit atomic_t.

You really do need that cmpxchg loop.


r~
