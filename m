Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278042AbRKKP7k>; Sun, 11 Nov 2001 10:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277176AbRKKP7b>; Sun, 11 Nov 2001 10:59:31 -0500
Received: from [80.72.64.86] ([80.72.64.86]:20097 "HELO
	merlin.xternal.fadata.bg") by vger.kernel.org with SMTP
	id <S278042AbRKKP7V>; Sun, 11 Nov 2001 10:59:21 -0500
To: Mathijs Mohlmann <mathijs@knoware.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix loop with disabled tasklets
From: Momchil Velikov <velco@fadata.bg>
Date: 11 Nov 2001 17:56:22 +0200
Message-ID: <87hes1qp21.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mathijs,

You may want to have a look at the following patches (tested by visual
inspection):

--- softirq.c.orig	Sun Nov 11 16:42:14 2001
+++ softirq.c	Sun Nov 11 16:59:44 2001
@@ -188,22 +188,17 @@ static void tasklet_action(struct softir
 
 		list = list->next;
 
+		if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
+			BUG();
+
 		if (tasklet_trylock(t)) {
-			if (!atomic_read(&t->count)) {
-				if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
-					BUG();
+			if (!atomic_read(&t->count))
 				t->func(t->data);
-				tasklet_unlock(t);
-				continue;
-			}
 			tasklet_unlock(t);
+			continue;
 		}
 
-		local_irq_disable();
-		t->next = tasklet_vec[cpu].list;
-		tasklet_vec[cpu].list = t;
-		__cpu_raise_softirq(cpu, TASKLET_SOFTIRQ);
-		local_irq_enable();
+		tasklet_schedule(t);
 	}
 }
 
@@ -222,22 +217,17 @@ static void tasklet_hi_action(struct sof
 
 		list = list->next;
 
+		if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
+			BUG();
+
 		if (tasklet_trylock(t)) {
-			if (!atomic_read(&t->count)) {
-				if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
-					BUG();
+			if (!atomic_read(&t->count))
 				t->func(t->data);
-				tasklet_unlock(t);
-				continue;
-			}
 			tasklet_unlock(t);
+			continue;
 		}
 
-		local_irq_disable();
-		t->next = tasklet_hi_vec[cpu].list;
-		tasklet_hi_vec[cpu].list = t;
-		__cpu_raise_softirq(cpu, HI_SOFTIRQ);
-		local_irq_enable();
+		tasklet_hi_schedule(t);
 	}
 }
 

--- interrupt.h.orig	Sun Nov 11 16:49:05 2001
+++ interrupt.h	Sun Nov 11 17:28:08 2001
@@ -185,13 +185,15 @@ static inline void tasklet_disable(struc
 static inline void tasklet_enable(struct tasklet_struct *t)
 {
 	smp_mb__before_atomic_dec();
-	atomic_dec(&t->count);
+	if (atomic_dec_and_test(&t->count))
+		tasklet_schedule(t);
 }
 
 static inline void tasklet_hi_enable(struct tasklet_struct *t)
 {
 	smp_mb__before_atomic_dec();
-	atomic_dec(&t->count);
+	if (atomic_dec_and_test(&t->count))
+		tasklet_hi_schedule(t);
 }
 
 extern void tasklet_kill(struct tasklet_struct *t);

Regards,
-velco
