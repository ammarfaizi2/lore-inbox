Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270055AbUJTMJC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270055AbUJTMJC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 08:09:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270276AbUJTMHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 08:07:13 -0400
Received: from mx2.elte.hu ([157.181.151.9]:16059 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S270077AbUJTMD2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 08:03:28 -0400
Date: Wed, 20 Oct 2004 14:04:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
Message-ID: <20041020120434.GA6297@elte.hu>
References: <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <4176403B.5@stud.feec.vutbr.cz> <20041020105630.GB2614@elte.hu> <417645A4.7000802@stud.feec.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417645A4.7000802@stud.feec.vutbr.cz>
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

> Ingo Molnar wrote:
> >* Michal Schmidt <xschmi00@stud.feec.vutbr.cz> wrote:
> >>I'm getting these BUGs when I use netconsole with Real-Time Preemption
> >>(but netconsole works):
> >
> >
> >you are getting them because interrupts get disabled somewhere in the
> >path. Do your changes perhaps introduce a local_irq_save() or
> >local_irq_disable()?
> >
> 
> I'm attaching my sk98lin patch. It uses disable_irq(). It's inspired
> by 8139too.

disable_irq() should work fine though. (it doesnt disable local
interrupts, it only disables that particular irq line.) So something
else disabled interrupts - ah, netconsole.c itself. Does the patch below
fix things up for you?

	Ingo

--- linux/drivers/net/netconsole.c.orig
+++ linux/drivers/net/netconsole.c
@@ -73,7 +73,9 @@ static void write_msg(struct console *co
 	if (!np.dev)
 		return;
 
+#ifndef CONFIG_PREEMPT_REALTIME
 	local_irq_save(flags);
+#endif
 
 	for(left = len; left; ) {
 		frag = min(left, MAX_PRINT_CHUNK);
@@ -82,7 +84,9 @@ static void write_msg(struct console *co
 		left -= frag;
 	}
 
+#ifndef CONFIG_PREEMPT_REALTIME
 	local_irq_restore(flags);
+#endif
 }
 
 static struct console netconsole = {
