Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262042AbVBBHGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262042AbVBBHGq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 02:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262171AbVBBHGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 02:06:45 -0500
Received: from mx1.elte.hu ([157.181.1.137]:21475 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262042AbVBBHG0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 02:06:26 -0500
Date: Wed, 2 Feb 2005 08:06:03 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Tom Rini <trini@kernel.crashing.org>, Bill Huey <bhuey@lnxw.com>,
       linux-kernel@vger.kernel.org, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc2-V0.7.36-04
Message-ID: <20050202070603.GA11605@elte.hu>
References: <20041214132834.GA32390@elte.hu> <20050104064013.GA19528@nietzsche.lynx.com> <20050104094518.GA13868@elte.hu> <20050107192651.GG5259@smtp.west.cox.net> <20050126080952.GC4771@elte.hu> <1107288076.18349.7.camel@krustophenia.net> <20050201201704.GA32139@elte.hu> <1107289878.18349.20.camel@krustophenia.net> <20050201204359.GA346@elte.hu> <1107301515.27870.29.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107301515.27870.29.camel@krustophenia.net>
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


* Lee Revell <rlrevell@joe-job.com> wrote:

> OK.  Rereading my old mail, it looks like there were some possibly
> unresolved false positives with the userspace atomicity debugger.
> 
> Here's one I get from alsaplayer.  Would more information be required
> to know if this is a false positive?

this is a false positive that only triggers if PREEMPT_RT is disabled. 
Does the patch below fix it? (i've also updated the -37-03 patch that
includes it.)

	Ingo

--- linux/lib/rwsem.c.orig
+++ linux/lib/rwsem.c
@@ -169,6 +169,8 @@ rwsem_down_failed_common(struct rw_semap
 
 	/* wait to be given the lock */
 	for (;;) {
+		unsigned long nosched_flag = current->flags & PF_NOSCHED;
+	
 		if ((sleep_state == TASK_INTERRUPTIBLE) &&
 						signal_pending(current)) {
 			spin_lock(&sem->wait_lock);
@@ -181,7 +183,10 @@ rwsem_down_failed_common(struct rw_semap
 		}
 		if (!waiter->task)
 			break;
+
+		current->flags &= ~PF_NOSCHED;
 		schedule();
+		current->flags |= nosched_flag;
 		set_task_state(tsk, sleep_state);
 	}
 
