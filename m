Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbTESJ5g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 05:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262140AbTESJ5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 05:57:36 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:20753 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262073AbTESJ5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 05:57:35 -0400
Date: Mon, 19 May 2003 11:10:28 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Rusty Russell <rusty@rustcorp.com.au>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [patch] futex requeueing feature, futex-requeue-2.5.69-D3
Message-ID: <20030519111028.B8663@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
	Ulrich Drepper <drepper@redhat.com>
References: <Pine.LNX.4.44.0305191103500.5653-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0305191103500.5653-100000@localhost.localdomain>; from mingo@elte.hu on Mon, May 19, 2003 at 11:31:51AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 19, 2003 at 11:31:51AM +0200, Ingo Molnar wrote:
> the solution to this problem is to not wake up the swarm of threads, but
> 'requeue' them from the CV-internal mutex to the user-supplied mutex. The
> attached patch adds the FUTEX_REQUEUE feature FUTEX_REQUEUE requeues N
> threads from futex address A to futex address B:
> 
> 	sys_futex(uaddr, FUTEX_REQUEUE, nr_wake, NULL, uaddr2);
> 
> the 'val' parameter to sys_futex (nr_wake) is the # of woken up threads.  
> This way glibc can wake up a single thread (which will take the
> user-mutex), and can requeue the rest, with a single system-call.

Urgg, yet another sys_futex extension.  Could you please split all
these totally different cases into separate syscalls instead?

> +				wake_up_all(&this->waiters);
> +				if (this->filp)
> +					send_sigio(&this->filp->f_owner, this->fd, POLL_IN);
> +			} else {
> +				unpin_page(this->page);
> +				__pin_page_atomic (page2);
> +				list_add_tail(i, head2);
> +				__attach_vcache(&this->vcache, uaddr2, current->mm, futex_vcache_callback);

Please linewrap after 80 lines, thanks.

> +	case FUTEX_REQUEUE:
> +		pos_in_page2 = uaddr2 % PAGE_SIZE;
> +
> +		/* Must be "naturally" aligned */
> +		if (pos_in_page2 % sizeof(u32))
> +			return -EINVAL;

Who guarantess that the alignment of u32 is always the same as it's size?

