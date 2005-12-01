Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbVLAACM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbVLAACM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 19:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbVK3X6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 18:58:48 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:24739
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751332AbVK3X6m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:58:42 -0500
Subject: [patch 40/43] rename del_ktimeout_sync() to del_ktimeout_sync()
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu, zippel@linux-m68k.org, george@mvista.com,
       johnstul@us.ibm.com
References: <20051130231140.164337000@tglx.tec.linutronix.de>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 01 Dec 2005 01:04:24 +0100
Message-Id: <1133395464.32542.484.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (ktimeout-rename-ktimeout_del_sync.patch)
- rename del_ktimeout_sync() to del_ktimeout_sync()

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/linux/ktimeout.h |    6 +++---
 include/linux/timer.h    |    2 +-
 kernel/ktimeout.c        |    8 ++++----
 3 files changed, 8 insertions(+), 8 deletions(-)

Index: linux/include/linux/ktimeout.h
===================================================================
--- linux.orig/include/linux/ktimeout.h
+++ linux/include/linux/ktimeout.h
@@ -89,13 +89,13 @@ static inline void ktimeout_add(struct k
 
 #ifdef CONFIG_SMP
   extern int ktimeout_try_to_del_sync(struct ktimeout *ktimeout);
-  extern int del_ktimeout_sync(struct ktimeout *ktimeout);
+  extern int ktimeout_del_sync(struct ktimeout *ktimeout);
 #else
 # define ktimeout_try_to_del_sync(t)	ktimeout_del(t)
-# define del_ktimeout_sync(t)		ktimeout_del(t)
+# define ktimeout_del_sync(t)		ktimeout_del(t)
 #endif
 
-#define del_singleshot_ktimeout_sync(t) del_ktimeout_sync(t)
+#define del_singleshot_ktimeout_sync(t) ktimeout_del_sync(t)
 
 extern void init_ktimeouts(void);
 extern void run_local_ktimeouts(void);
Index: linux/include/linux/timer.h
===================================================================
--- linux.orig/include/linux/timer.h
+++ linux/include/linux/timer.h
@@ -26,7 +26,7 @@
 #define next_timer_interrupt		ktimeout_next_interrupt
 #define add_timer			ktimeout_add
 #define try_to_del_timer_sync		ktimeout_try_to_del_sync
-#define del_timer_sync			del_ktimeout_sync
+#define del_timer_sync			ktimeout_del_sync
 #define del_singleshot_timer_sync	del_singleshot_ktimeout_sync
 #define init_timers			init_ktimeouts
 #define run_local_timers		run_local_ktimeouts
Index: linux/kernel/ktimeout.c
===================================================================
--- linux.orig/kernel/ktimeout.c
+++ linux/kernel/ktimeout.c
@@ -211,7 +211,7 @@ int __ktimeout_mod(struct ktimeout *ktim
 		/*
 		 * We are trying to schedule the timeout on the local CPU.
 		 * However we can't change timeout's base while it is running,
-		 * otherwise del_ktimeout_sync() can't detect that the timeout's
+		 * otherwise ktimeout_del_sync() can't detect that the timeout's
 		 * handler yet has not finished. This also guarantees that
 		 * the timeout is serialized wrt itself.
 		 */
@@ -353,7 +353,7 @@ out:
 }
 
 /***
- * del_ktimeout_sync - deactivate a timeout and wait for the handler to finish.
+ * ktimeout_del_sync - deactivate a timeout and wait for the handler to finish.
  * @ktimeout: the timeout to be deactivated
  *
  * This function only differs from ktimeout_del() on SMP: besides deactivating
@@ -369,7 +369,7 @@ out:
  *
  * The function returns whether it has deactivated a pending timeout or not.
  */
-int del_ktimeout_sync(struct ktimeout *ktimeout)
+int ktimeout_del_sync(struct ktimeout *ktimeout)
 {
 	for (;;) {
 		int ret = ktimeout_try_to_del_sync(ktimeout);
@@ -378,7 +378,7 @@ int del_ktimeout_sync(struct ktimeout *k
 	}
 }
 
-EXPORT_SYMBOL(del_ktimeout_sync);
+EXPORT_SYMBOL(ktimeout_del_sync);
 #endif
 
 static int cascade(tvec_base_t *base, tvec_t *tv, int index)

--

