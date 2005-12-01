Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbVLAAAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbVLAAAp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 19:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbVK3X66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 18:58:58 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:15523
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751328AbVK3X6e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:58:34 -0500
Subject: [patch 34/43] rename del_ktimeout() to ktimeout_del()
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu, zippel@linux-m68k.org, george@mvista.com,
       johnstul@us.ibm.com
References: <20051130231140.164337000@tglx.tec.linutronix.de>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 01 Dec 2005 01:04:10 +0100
Message-Id: <1133395450.32542.477.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (ktimeout-rename-ktimeout_del.patch)
- rename del_ktimeout() to ktimeout_del()

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/linux/ktimeout.h |    6 +++---
 include/linux/timer.h    |    2 +-
 kernel/ktimeout.c        |   14 +++++++-------
 3 files changed, 11 insertions(+), 11 deletions(-)

Index: linux/include/linux/ktimeout.h
===================================================================
--- linux.orig/include/linux/ktimeout.h
+++ linux/include/linux/ktimeout.h
@@ -61,7 +61,7 @@ static inline int ktimeout_pending(const
 }
 
 extern void ktimeout_add_on(struct ktimeout *ktimeout, int cpu);
-extern int del_ktimeout(struct ktimeout * ktimeout);
+extern int ktimeout_del(struct ktimeout * ktimeout);
 extern int __mod_ktimeout(struct ktimeout *ktimeout, unsigned long expires);
 extern int mod_ktimeout(struct ktimeout *ktimeout, unsigned long expires);
 
@@ -91,8 +91,8 @@ static inline void add_ktimeout(struct k
   extern int try_to_del_ktimeout_sync(struct ktimeout *ktimeout);
   extern int del_ktimeout_sync(struct ktimeout *ktimeout);
 #else
-# define try_to_del_ktimeout_sync(t)	del_ktimeout(t)
-# define del_ktimeout_sync(t)		del_ktimeout(t)
+# define try_to_del_ktimeout_sync(t)	ktimeout_del(t)
+# define del_ktimeout_sync(t)		ktimeout_del(t)
 #endif
 
 #define del_singleshot_ktimeout_sync(t) del_ktimeout_sync(t)
Index: linux/include/linux/timer.h
===================================================================
--- linux.orig/include/linux/timer.h
+++ linux/include/linux/timer.h
@@ -20,7 +20,7 @@
 #define setup_timer			ktimeout_setup
 #define timer_pending			ktimeout_pending
 #define add_timer_on			ktimeout_add_on
-#define del_timer			del_ktimeout
+#define del_timer			ktimeout_del
 #define __mod_timer			__mod_ktimeout
 #define mod_timer			mod_ktimeout
 #define next_timer_interrupt		next_ktimeout_interrupt
Index: linux/kernel/ktimeout.c
===================================================================
--- linux.orig/kernel/ktimeout.c
+++ linux/kernel/ktimeout.c
@@ -265,7 +265,7 @@ void ktimeout_add_on(struct ktimeout *kt
  *
  * mod_ktimeout(ktimeout, expires) is equivalent to:
  *
- *  del_ktimeout(ktimeout); ktimeout->expires = expires; add_ktimeout(ktimeout);
+ *  ktimeout_del(ktimeout); ktimeout->expires = expires; add_ktimeout(ktimeout);
  *
  * Note that if there are multiple unserialized concurrent users of the same
  * timeout, then mod_ktimeout() is the only safe way to modify the interval,
@@ -293,17 +293,17 @@ int mod_ktimeout(struct ktimeout *ktimeo
 EXPORT_SYMBOL(mod_ktimeout);
 
 /***
- * del_ktimeout - deactive a timeout.
+ * ktimeout_del - deactive a timeout.
  * @ktimeout: the timeout to be deactivated
  *
- * del_ktimeout() deactivates a timeout - this works on both active and inactive
+ * ktimeout_del() deactivates a timeout - this works on both active and inactive
  * ktimeouts.
  *
  * The function returns whether it has deactivated a pending timeout or not.
- * (ie. del_ktimeout() of an inactive timeout returns 0, del_ktimeout() of an
+ * (ie. ktimeout_del() of an inactive timeout returns 0, ktimeout_del() of an
  * active timeout returns 1.)
  */
-int del_ktimeout(struct ktimeout *ktimeout)
+int ktimeout_del(struct ktimeout *ktimeout)
 {
 	ktimeout_base_t *base;
 	unsigned long flags;
@@ -321,7 +321,7 @@ int del_ktimeout(struct ktimeout *ktimeo
 	return ret;
 }
 
-EXPORT_SYMBOL(del_ktimeout);
+EXPORT_SYMBOL(ktimeout_del);
 
 #ifdef CONFIG_SMP
 /*
@@ -356,7 +356,7 @@ out:
  * del_ktimeout_sync - deactivate a timeout and wait for the handler to finish.
  * @ktimeout: the timeout to be deactivated
  *
- * This function only differs from del_ktimeout() on SMP: besides deactivating
+ * This function only differs from ktimeout_del() on SMP: besides deactivating
  * the timeout it also makes sure the handler has finished executing on other
  * CPUs.
  *

--

