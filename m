Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292708AbSCGDgt>; Wed, 6 Mar 2002 22:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291081AbSCGDgk>; Wed, 6 Mar 2002 22:36:40 -0500
Received: from [202.135.142.194] ([202.135.142.194]:55057 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S292554AbSCGDg3>; Wed, 6 Mar 2002 22:36:29 -0500
Date: Thu, 7 Mar 2002 14:39:47 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Richard Henderson <rth@twiddle.net>
Cc: torvalds@transmeta.com, matthew@hairy.beasts.org, bcrl@redhat.com,
        david@mysql.com, wli@holomorphy.com, linux-kernel@vger.kernel.org,
        frankeh@watson.ibm.com
Subject: Re: [PATCH] Fast Userspace Mutexes III.
Message-Id: <20020307143947.000f51dd.rusty@rustcorp.com.au>
In-Reply-To: <20020306175203.A26064@twiddle.net>
In-Reply-To: <E16hjZY-0001AV-00@wagner.rustcorp.com.au>
	<20020306175203.A26064@twiddle.net>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Mar 2002 17:52:03 -0800
Richard Henderson <rth@twiddle.net> wrote:

> On Mon, Mar 04, 2002 at 02:55:36PM +1100, Rusty Russell wrote:
> > +	/* If we take the semaphore from 1 to 0, it's ours. */
> > +	while (!atomic_dec_and_test(count)) {
> > +		if (signal_pending(current)) {
> > +			retval = -EINTR;
> > +			break;
> 
> This is not safe from wraparound.  Let one thread hold the
> lock forever; let other threads keep trying to take the lock
> while periodically getting SIGALRM.  Eventually one of the
> spinning threads will incorrectly acquire the mutex.

Yes, this was noted.  And yes, it's about time we fixed sparc32
or threw it out of the tree.  But since the real problem here is
"lock held forever", so I don't care.

> You really do need that cmpxchg loop.

Well, not decrementing if count < 0 already also works (as seen in
later patches), and I'm not going to break those SMP 386s if I don't
have to.

Cheers!
Rusty.
PS. Will Alpha have to do any special magic with the mmap PROT_SEM flag?
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
