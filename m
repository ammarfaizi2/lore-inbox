Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbUCCXDj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 18:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbUCCXDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 18:03:39 -0500
Received: from chaos.analogic.com ([204.178.40.224]:53633 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261231AbUCCXDg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 18:03:36 -0500
Date: Wed, 3 Mar 2004 18:07:05 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Linus Torvalds <torvalds@osdl.org>
cc: David Dillow <dave@thedillows.org>, Bill Davidsen <davidsen@tmr.com>,
       Roland Dreier <roland@topspin.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: poll() in 2.6 and beyond
In-Reply-To: <Pine.LNX.4.58.0403031442580.3000@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.53.0403031800230.14624@chaos>
References: <1vmPm-4lU-11@gated-at.bofh.it> <1vonq-6dr-37@gated-at.bofh.it>
  <1voGY-6vC-41@gated-at.bofh.it> <1vpjt-7dl-17@gated-at.bofh.it> 
 <1vpCV-7wY-41@gated-at.bofh.it> <1vpWa-7Py-19@gated-at.bofh.it> 
 <4045106D.8060902@tmr.com>  <Pine.LNX.4.53.0403021817050.9351@chaos>
 <1078286221.4302.23.camel@ori.thedillows.org> <Pine.LNX.4.53.0403031313270.12900@chaos>
 <Pine.LNX.4.58.0403031419280.3000@ppc970.osdl.org>
 <Pine.LNX.4.58.0403031442580.3000@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Mar 2004, Linus Torvalds wrote:

>
>
> On Wed, 3 Mar 2004, Linus Torvalds wrote:
> >
> > You should clear the "events pending" flag only when you literally remove
> > the event (ie at "read()" time, not at "poll()" time). Because the
> > select() code _will_ call down to the "poll()" functions multiple times if
> > it gets woken up for any bogus reason.
>
> Hmm.. The above is all still true and your poll() implementation is bad,
> but looking at your test program, the problematic case really shouldn't
> trigger (we should call poll()  multiple times only when it returns zero).
>
> To trigger that bug, you'd have to occasionally call poll() with the
> POLLIN bit clear in the incoming events, which your test program doesn't
> ever do.
>

Well, when I removed the local poll_flag, using only the global one,
and cleared it to zero after the long long was fetched under the lock
(in the read routine), my observed problems go away.

static size_t poll(struct file *fp, struct poll_table_struct *wait)
{
    DEB(printk(KERN_INFO"%s : poll() called\n", devname));
    poll_wait(fp, &pwait, wait);
    DEB(printk(KERN_INFO"%s : poll() returned\n", devname));
    return global_poll_flag;
}

static int read(struct file *fp, char *buf, size_t count, loff_t *ppos)
{
    long long tmp;
    size_t flags;
    spin_lock_irqsave(&rtc_lock, flags);
    tmp = rtc_tick;
    global_poll_flag = 0;
    spin_unlock_irqrestore(&rtc_lock, flags);
    if(copy_to_user(buf, &tmp, sizeof(tmp)))
        return -EFAULT;
    return sizeof(tmp);
}

> Anyway, you should move the clearing to read(), but there may well be
> something else going on too.
>
> What's the frequency you are programming the thing to send interrupts at?
>

2048 ticks/second, trivial to handle.

> 		Linus
> -


Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


