Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261402AbUKOCCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbUKOCCR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 21:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbUKOCCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 21:02:17 -0500
Received: from mail.shareable.org ([81.29.64.88]:56706 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261402AbUKOCCL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 21:02:11 -0500
Date: Mon, 15 Nov 2004 02:01:48 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: mingo@elte.hu, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au, ahu@ds9a.nl
Subject: Re: Futex queue_me/get_user ordering
Message-ID: <20041115020148.GA17979@mail.shareable.org>
References: <20041113164048.2f31a8dd.akpm@osdl.org> <20041114090023.GA478@mail.shareable.org> <20041114010943.3d56985a.akpm@osdl.org> <20041114092308.GA4389@mail.shareable.org> <4197FF42.9070706@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4197FF42.9070706@jp.fujitsu.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hidetoshi Seto wrote:
> >So I don't know if NPTL is buggy, but the pseudo-code given in the bug
> >report is (because of unconditional wake++), and so is the failure
> >example (because it doesn't use a mutex).
> 
> from glibc-2.3.3(RHEL4b2):
> 
>   31 int
>   32 __pthread_cond_signal (cond)
>   33      pthread_cond_t *cond;
>   34 {
>   35   /* Make sure we are alone.  */
>   36   lll_mutex_lock (cond->__data.__lock);
>   37
>   38   /* Are there any waiters to be woken?  */
>   39   if (cond->__data.__total_seq > cond->__data.__wakeup_seq)
>   40     {
>   41       /* Yes.  Mark one of them as woken.  */
>   42       ++cond->__data.__wakeup_seq;
>   43       ++cond->__data.__futex;
>   44
>   45       /* Wake one.  */
>   46       lll_futex_wake (&cond->__data.__futex, 1);
>   47     }
>   48
>   49   /* We are done.  */
>   50   lll_mutex_unlock (cond->__data.__lock);
>   51
>   52   return 0;
>   53 }
> 
> Ingo, is this buggy?
> 
> We should start again with a question:
>   Is this a kernel's bug or NPTL's bug?

Third possibility: your test is buggy.  Do you actually use a mutex in
your test when you call pthread_cond_wait, and does the waker hold it
when it calls pthread_cond_signal?

If you don't use a mutex as you are supposed to with condvars, then it
might not be a kernel or NPTL bug.  I'm not sure if POSIX-specified
behaviour is defined when you use condvars without a mutex.

If you do use a mutex (and you just didn't mention it), then the code
above is not enough to decide if there's an NPTL bug.  We need to look
at pthread_cond_wait as well, to see how it does the "atomic" wait and
mutex release.

-- Jamie
