Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262201AbVAEBoa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262201AbVAEBoa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 20:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbVAEBo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 20:44:29 -0500
Received: from out008pub.verizon.net ([206.46.170.108]:37521 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S262187AbVAEBj5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 20:39:57 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org, dev-etrax@axis.com
Cc: starvik@axis.com, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050105014016.22177.76110.69303@localhost.localdomain>
In-Reply-To: <20050105014001.22177.28259.66716@localhost.localdomain>
References: <20050105014001.22177.28259.66716@localhost.localdomain>
Subject: [PATCH 2/2] cris: remove cli()/sti() in arch/cris/arch-v10/kernel/fasttimer.c
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [209.158.220.243] at Tue, 4 Jan 2005 19:39:56 -0600
Date: Tue, 4 Jan 2005 19:39:57 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-mm1-original/arch/cris/arch-v10/kernel/fasttimer.c linux-2.6.10-mm1/arch/cris/arch-v10/kernel/fasttimer.c
--- linux-2.6.10-mm1-original/arch/cris/arch-v10/kernel/fasttimer.c	2005-01-03 18:42:38.175748400 -0500
+++ linux-2.6.10-mm1/arch/cris/arch-v10/kernel/fasttimer.c	2005-01-04 20:21:49.052049939 -0500
@@ -148,8 +148,7 @@
 #define DEBUG_LOG(string, value) \
 { \
   unsigned long log_flags; \
-  save_flags(log_flags); \
-  cli(); \
+  local_irq_save(log_flags); \
   debug_log_string[debug_log_cnt] = (string); \
   debug_log_value[debug_log_cnt] = (unsigned long)(value); \
   if (++debug_log_cnt >= DEBUG_LOG_MAX) \
@@ -157,7 +156,7 @@
     debug_log_cnt = debug_log_cnt % DEBUG_LOG_MAX; \
     debug_log_cnt_wrapped = 1; \
   } \
-  restore_flags(log_flags); \
+  local_irq_restore(log_flags); \
 }
 #else
 #define DEBUG_LOG(string, value)
@@ -320,8 +319,7 @@
 
   D1(printk("sft %s %d us\n", name, delay_us));
 
-  save_flags(flags);
-  cli();
+  local_irq_save(flags);
 
   do_gettimeofday_fast(&t->tv_set);
   tmp = fast_timer_list;
@@ -395,7 +393,7 @@
 
   D2(printk("start_one_shot_timer: %d us done\n", delay_us));
 
-  restore_flags(flags);
+  local_irq_restore(flags);
 } /* start_one_shot_timer */
 
 static inline int fast_timer_pending (const struct fast_timer * t)
@@ -425,11 +423,10 @@
   unsigned long flags;
   int ret;
   
-  save_flags(flags);
-  cli();
+  local_irq_save(flags);
   ret = detach_fast_timer(t);
   t->next = t->prev = NULL;
-  restore_flags(flags);
+  local_irq_restore(flags);
   return ret;
 } /* del_fast_timer */
 
@@ -444,8 +441,7 @@
   struct fast_timer *t;
   unsigned long flags;
 
-  save_flags(flags);
-  cli();
+  local_irq_save(flags);
 
   /* Clear timer1 irq */
   *R_IRQ_MASK0_CLR = IO_STATE(R_IRQ_MASK0_CLR, timer1, clr);
@@ -462,7 +458,7 @@
   fast_timer_running = 0;
   fast_timer_ints++;
 
-  restore_flags(flags);
+  local_irq_restore(flags);
 
   t = fast_timer_list;
   while (t)
@@ -482,8 +478,7 @@
       fast_timers_expired++;
 
       /* Remove this timer before call, since it may reuse the timer */
-      save_flags(flags);
-      cli();
+      local_irq_save(flags);
       if (t->prev)
       {
         t->prev->next = t->next;
@@ -498,7 +493,7 @@
       }
       t->prev = NULL;
       t->next = NULL;
-      restore_flags(flags);
+      local_irq_restore(flags);
 
       if (t->function != NULL)
       {
@@ -515,8 +510,7 @@
       D1(printk(".\n"));
     }
 
-    save_flags(flags);
-    cli();
+    local_irq_save(flags);
     if ((t = fast_timer_list) != NULL)
     {
       /* Start next timer.. */
@@ -535,7 +529,7 @@
 #endif
           start_timer1(us);
         }
-        restore_flags(flags);
+        local_irq_restore(flags);
         break;
       }
       else
@@ -546,7 +540,7 @@
         D1(printk("e! %d\n", us));
       }
     }
-    restore_flags(flags);
+    local_irq_restore(flags);
   }
 
   if (!t)
@@ -748,13 +742,12 @@
 #endif
 
     used += sprintf(bigbuf + used, "Active timers:\n");
-    save_flags(flags);
-    cli();
+    local_irq_save(flags);
     t = fast_timer_list;
     while (t != NULL && (used+100 < BIG_BUF_SIZE))
     {
       nextt = t->next;
-      restore_flags(flags);
+      local_irq_restore(flags);
       used += sprintf(bigbuf + used, "%-14s s: %6lu.%06lu e: %6lu.%06lu "
                       "d: %6li us data: 0x%08lX"
 /*                      " func: 0x%08lX" */
@@ -768,14 +761,14 @@
                       t->data
 /*                      , t->function */
                       );
-      cli();
+      local_irq_save(flags);
       if (t->next != nextt)
       {
         printk(KERN_WARNING "timer removed!\n");
       }
       t = nextt;
     }
-    restore_flags(flags);
+    local_irq_restore(flags);
   }
 
   if (used - offset < len)
