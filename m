Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbUCCWkp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 17:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbUCCWko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 17:40:44 -0500
Received: from chaos.analogic.com ([204.178.40.224]:50305 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261234AbUCCWiy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 17:38:54 -0500
Date: Wed, 3 Mar 2004 17:42:16 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Linus Torvalds <torvalds@osdl.org>
cc: David Dillow <dave@thedillows.org>, Bill Davidsen <davidsen@tmr.com>,
       Roland Dreier <roland@topspin.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: poll() in 2.6 and beyond
In-Reply-To: <Pine.LNX.4.58.0403031419280.3000@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.53.0403031737130.14503@chaos>
References: <1vmPm-4lU-11@gated-at.bofh.it> <1vonq-6dr-37@gated-at.bofh.it>
  <1voGY-6vC-41@gated-at.bofh.it> <1vpjt-7dl-17@gated-at.bofh.it> 
 <1vpCV-7wY-41@gated-at.bofh.it> <1vpWa-7Py-19@gated-at.bofh.it> 
 <4045106D.8060902@tmr.com>  <Pine.LNX.4.53.0403021817050.9351@chaos>
 <1078286221.4302.23.camel@ori.thedillows.org> <Pine.LNX.4.53.0403031313270.12900@chaos>
 <Pine.LNX.4.58.0403031419280.3000@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Mar 2004, Linus Torvalds wrote:

>
>
> On Wed, 3 Mar 2004, Richard B. Johnson wrote:
> >
> > are being quashed by those who just like to argue. Therefore,
> > I wrote some code that emulates the environment in which I
> > discovered the poll failure.
>
> No. I think you wrote some code that shows the bug you have.
>
> Your "poll()" function IS BUGGY.
>
> Look at this:
>
> 	static size_t poll(struct file *fp, struct poll_table_struct *wait)
> 	{
> 	    size_t poll_flag;
> 	    size_t flags;
> 	    DEB(printk(KERN_INFO"%s : poll() called\n", devname));
> 	    poll_wait(fp, &pwait, wait);
> 	    DEB(printk(KERN_INFO"%s : poll() returned\n", devname));
> 	    spin_lock_irqsave(&rtc_lock, flags);
> 	    poll_flag = global_poll_flag;
> ***	    global_poll_flag = 0;
> 	    spin_unlock_irqrestore(&rtc_lock, flags);
> 	    return poll_flag;
> 	}
>
> you are clearing your own flag that says "there are events pending", so if
> you call your "poll()" function twice, on the second time it will say
> "there are no events pending".
>

But I am clearing it under a spin-lock.

> You should clear the "events pending" flag only when you literally remove
> the event (ie at "read()" time, not at "poll()" time). Because the
> select() code _will_ call down to the "poll()" functions multiple times if
> it gets woken up for any bogus reason.

Oh wow. That is the BUG! I didn't know it could call in multiple times.

>
> See if that fixes anything.
>
> It may well be that 2.6.x calls down to the low-level driver "poll()"
> function more than it should. That would be a mis-feature, and worth
> looking at, but I think you should try to fix your test first, since right
> now the bug is questionable.
>
> 			Linus

And YES! If I clear the flag only after it is read. It "fixes" the
observed problem!

I don't know if it is a BUG or a FEATURE, but you put your
finger right on it!  Thanks.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


