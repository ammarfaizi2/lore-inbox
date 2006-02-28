Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932432AbWB1TQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbWB1TQN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 14:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932441AbWB1TQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 14:16:13 -0500
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:627 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932432AbWB1TQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 14:16:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:From:To:Subject:Date:User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=B7faskCBMesirkWuMO9glQAt4cixwBfR2bzjZpOk4EtVGcZ8O4YR38O1AVXiCHLqzJcI9bOse9ugfkssnPtsIJUZu/kL0mqB4/knQbrZ9+IhEIJBDjRTHYcr8zvuw1VMxDecQThchkP1X2UV8p/vu7uA8Uqe7Eib/6B23riIeho=  ;
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rt17
Date: Tue, 28 Feb 2006 20:21:20 +0100
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602282021.21052.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the tasklet code was reworked too to be PREEMPT_RT friendly: the new PI 
> code unearthed a fundamental livelock scenario with PREEMPT_RT, and the 
> fix was to rework the tasklet code to get rid of the 'retrigger 
> softirqs' approach.

following patch re enables tasklet_hi.
needed by ALSA MIDI.

      Karsten


--- /tmp/softirq.c~	2006-02-28 20:17:03.000000000 +0100
+++ /tmp/softirq.c	2006-02-28 20:17:03.000000000 +0100
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
 
_

	

	
		
___________________________________________________________ 
Telefonate ohne weitere Kosten vom PC zum PC: http://messenger.yahoo.de
