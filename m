Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283902AbRLADKQ>; Fri, 30 Nov 2001 22:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281453AbRLADKH>; Fri, 30 Nov 2001 22:10:07 -0500
Received: from 209-161-7-161.bradetich.boi.fiberpipe.net ([209.161.7.161]:64147
	"EHLO beavis.ybsoft.com") by vger.kernel.org with ESMTP
	id <S281427AbRLADJz>; Fri, 30 Nov 2001 22:09:55 -0500
Subject: [PATCH] rename member variable count to disabled in struct
	tasklet_struct
From: Ryan Bradetich <rbradetich@uswest.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 30 Nov 2001 20:09:49 -0700
Message-Id: <1007176189.11991.16.camel@beavis>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In a previous email:
http://marc.theaimsgroup.com/?l=linux-kernel&m=100710086202226&w=2

I asked about the possibility of renaming the member variable count to
disabled in the struct tasklet_struct.  I didn't get any responses to my
question so I thought I'd try asking the question a different way :)

This patch does not make any functional changes to the kernel, but I do
believe it makes the tasklet code more readable.

I have tested this against the 2.4.16 kernel.

Thanks,

- Ryan

--- include/linux/interrupt.h   2001/11/09 23:37:14     1.9
+++ include/linux/interrupt.h   2001/12/01 02:09:32
@@ -104,7 +104,7 @@ struct tasklet_struct
 {
        struct tasklet_struct *next;
        unsigned long state;
-       atomic_t count;
+       atomic_t disabled;
        void (*func)(unsigned long);
        unsigned long data;
 };
@@ -171,7 +171,7 @@ static inline void tasklet_hi_schedule(s
 
 static inline void tasklet_disable_nosync(struct tasklet_struct *t)
 {
-       atomic_inc(&t->count);
+       atomic_inc(&t->disabled);
        smp_mb__after_atomic_inc();
 }
 
@@ -185,13 +185,13 @@ static inline void tasklet_disable(struc
 static inline void tasklet_enable(struct tasklet_struct *t)
 {
        smp_mb__before_atomic_dec();
-       atomic_dec(&t->count);
+       atomic_dec(&t->disabled);
 }
 
 static inline void tasklet_hi_enable(struct tasklet_struct *t)
 {
        smp_mb__before_atomic_dec();
-       atomic_dec(&t->count);
+       atomic_dec(&t->disabled);
 }
 
 extern void tasklet_kill(struct tasklet_struct *t);
--- kernel/softirq.c    2001/11/09 23:37:17     1.9
+++ kernel/softirq.c    2001/12/01 02:09:32
@@ -189,7 +189,7 @@ static void tasklet_action(struct softir
                list = list->next;
 
                if (tasklet_trylock(t)) {
-                       if (!atomic_read(&t->count)) {
+                       if (!atomic_read(&t->disabled)) {
                                if
(!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
                                        BUG();
                                t->func(t->data);
@@ -223,7 +223,7 @@ static void tasklet_hi_action(struct sof
                list = list->next;
 
                if (tasklet_trylock(t)) {
-                       if (!atomic_read(&t->count)) {
+                       if (!atomic_read(&t->disabled)) {
                                if
(!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
                                        BUG();
                                t->func(t->data);
@@ -247,7 +247,7 @@ void tasklet_init(struct tasklet_struct 
 {
        t->next = NULL;
        t->state = 0;
-       atomic_set(&t->count, 0);
+       atomic_set(&t->disabled, 0);
        t->func = func;
        t->data = data;
 }

