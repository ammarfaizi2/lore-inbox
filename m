Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbUKOII7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbUKOII7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 03:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbUKOII6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 03:08:58 -0500
Received: from mail.shareable.org ([81.29.64.88]:63874 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261548AbUKOII4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 03:08:56 -0500
Date: Mon, 15 Nov 2004 08:08:36 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Futex queue_me/get_user ordering (was: 2.6.10-rc1-mm5 [u])
Message-ID: <20041115080835.GA22723@mail.shareable.org>
References: <200411142327_MC3-1-8EB1-E27D@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411142327_MC3-1-8EB1-E27D@compuserve.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
> On Sun, 14 Nov 2004 at 09:00:23 +0000 Emergency Services Jamie Lokier wrote:
> 
> >+       * The basic logical guarantee of a futex is that it blocks ONLY
> >+       * if cond(var) is known to be true at the time of blocking, for
> >+       * any cond.  If we queued after testing *uaddr, that would open
> >+       * a race condition where we could block indefinitely with
> >+       * cond(var) false, which would violate the guarantee.
> >+       *
> >+       * A consequence is that futex_wait() can return zero and absorb
> >+       * a wakeup when *uaddr != val on entry to the syscall.  This is
> >+       * rare, but normal.
> 
>    Why can't it absorb a wakeup and still return -EAGAIN when this happens?
>    IOW why not apply this patch to the original code?
> 
>   out_unqueue:
> -       /* If we were woken (and unqueued), we succeeded, whatever. */
> -       if (!unqueue_me(&q))
> -               ret = 0;
> +       unqueue_me(&q); /* ignore result from unqueue */
>   out_release_sem:
>         up_read(&current->mm->mmap_sem);
>         return ret;

Because the number of wakeups reported to FUTEX_WAKE must _exactly_
match the number of wakeups reported to FUTEX_WAIT.

They are like tokens, and for some data structures the return value
mustn't be lost or ignored, because that would break structure
invariants - such as the matching counters in the pthread condvars
which precipitated this thread.

>    ...and what is "Emergency Services", BTW?

My little joke, as I wouldn't have known about this if Andrew Morton
hadn't forwarded me the message asking about it (I've been away from l-k).

-- Jamie
