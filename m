Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbWCFMgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbWCFMgq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 07:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWCFMgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 07:36:46 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:58255 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932119AbWCFMgp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 07:36:45 -0500
Date: Mon, 6 Mar 2006 13:35:38 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: realtime-preempt patch-2.6.15-rt18 issues
Message-ID: <20060306123538.GA3844@elte.hu>
References: <45924.195.245.190.93.1141647094.squirrel@www.rncbc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45924.195.245.190.93.1141647094.squirrel@www.rncbc.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Rui Nuno Capela <rncbc@rncbc.org> wrote:

> Hi, Ingo,
> 
> I think I would let you know that I'm still on 2.6.15-rt16, which 
> works great for the most purposes, on all of my boxes.
> 
> My problem is that the current/latest of the realtime-preempt patch, 
> 2.6.15-rt18, has some showstoppers, at least for my day-to-day usage.

> The second issue seems to be related to the RTC and is not strictly 
> specific to -rt18. AFAICT, my experience goes far as the ALSA MIDI 
> sequencer is concerned (snd-seq-midi) and it badly shows whenever the 
> RTC timer is used (snd-rtctimer), moreover if its used by default 
> (i.e. CONFIG_SND_SEQ_RTCTIMER_DEFAULT=y).

does the patch below (from Karsten Wiese) solve the second problem?

	Ingo

-------

> the tasklet code was reworked too to be PREEMPT_RT friendly: the new 
> PI code unearthed a fundamental livelock scenario with PREEMPT_RT, and 
> the fix was to rework the tasklet code to get rid of the 'retrigger 
> softirqs' approach.

following patch re enables tasklet_hi. needed by ALSA MIDI.

      Karsten

--- linux/kernel/softirq.c.orig
+++ linux/kernel/softirq.c
@@ -351,13 +351,13 @@
 static DEFINE_PER_CPU(struct tasklet_head, tasklet_hi_vec) = { NULL };
 
 static void inline
-__tasklet_common_schedule(struct tasklet_struct *t, struct tasklet_head *head)
+__tasklet_common_schedule(struct tasklet_struct *t, struct tasklet_head *head, unsigned int nr)
 {
 	if (tasklet_trylock(t)) {
 		WARN_ON(t->next != NULL);
 		t->next = head->list;
 		head->list = t;
-		raise_softirq_irqoff(TASKLET_SOFTIRQ);
+		raise_softirq_irqoff(nr);
 		tasklet_unlock(t);
 	}
 }
@@ -367,7 +367,7 @@
 	unsigned long flags;
 
 	raw_local_irq_save(flags);
-	__tasklet_common_schedule(t, &__get_cpu_var(tasklet_vec));
+	__tasklet_common_schedule(t, &__get_cpu_var(tasklet_vec), TASKLET_SOFTIRQ);
 	raw_local_irq_restore(flags);
 }
 
@@ -378,7 +378,7 @@
 	unsigned long flags;
 
 	raw_local_irq_save(flags);
-	__tasklet_common_schedule(t, &__get_cpu_var(tasklet_hi_vec));
+	__tasklet_common_schedule(t, &__get_cpu_var(tasklet_hi_vec), HI_SOFTIRQ);
 	raw_local_irq_restore(flags);
 }
 
