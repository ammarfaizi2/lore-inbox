Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270460AbUJUIWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270460AbUJUIWv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 04:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270393AbUJUIVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 04:21:22 -0400
Received: from mx2.elte.hu ([157.181.151.9]:65190 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S270661AbUJUIPm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 04:15:42 -0400
Date: Thu, 21 Oct 2004 10:12:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
Message-ID: <20041021081215.GA21073@elte.hu>
References: <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <4176403B.5@stud.feec.vutbr.cz> <20041020105630.GB2614@elte.hu> <417645A4.7000802@stud.feec.vutbr.cz> <20041020120434.GA6297@elte.hu> <4176D9CC.5010107@stud.feec.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4176D9CC.5010107@stud.feec.vutbr.cz>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Michal Schmidt <xschmi00@stud.feec.vutbr.cz> wrote:

> That patch was not enough. The BUGs were still showing up the same as
> before. I tried to debug it myself. I've found an interesting thing in
> kernel/printk.c:release_console_sem(). There is the following
> sequence:
> 
>   spin_lock_irqsave(&logbuf_lock, flags);
>   /* ... some code ... */
>   spin_unlock(&logbuf_lock);
>   call_console_drivers(...);
>   local_irq_restore(flags);
> 
> I know very little about locking, but I didn't like this two-phased
> unlock. So I replaced it with a single spin_unlock_irqrestore. Patch
> attached. I'm almost certain that there is a reason for the two-phased
> unlocking and that this patch will break something, but so far it
> works for me.  netconsole now works without complaining.

ah, indeed. Note that this is still not enough - please try to add a
local_irq_enable() to netconsole.c's console-write function - does that
fix it equally well for you?

the reason is that if we crash within an irqs-off section then
netconsole will still be called with interrupts disabled and will
trigger the assert.

	Ingo
