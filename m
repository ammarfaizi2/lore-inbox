Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751318AbVLAABf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbVLAABf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 19:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbVK3X6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 18:58:52 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:21667
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751330AbVK3X6i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:58:38 -0500
Subject: [patch 38/43] rename add_ktimeout() to ktimeout_add()
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu, zippel@linux-m68k.org, george@mvista.com,
       johnstul@us.ibm.com
References: <20051130231140.164337000@tglx.tec.linutronix.de>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 01 Dec 2005 01:04:20 +0100
Message-Id: <1133395460.32542.482.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (ktimeout-rename-ktimeout_add.patch)
- rename add_ktimeout() to ktimeout_add()

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/linux/ktimeout.h |    4 ++--
 include/linux/timer.h    |    2 +-
 kernel/ktimeout.c        |   14 +++++++-------
 3 files changed, 10 insertions(+), 10 deletions(-)

Index: linux/include/linux/ktimeout.h
===================================================================
--- linux.orig/include/linux/ktimeout.h
+++ linux/include/linux/ktimeout.h
@@ -68,7 +68,7 @@ extern int ktimeout_mod(struct ktimeout 
 extern unsigned long ktimeout_next_interrupt(void);
 
 /***
- * add_ktimeout - start a ktimeout
+ * ktimeout_add - start a ktimeout
  * @ktimeout: the timeout to be added
  *
  * The kernel will do a ->function(->data) callback from the
@@ -81,7 +81,7 @@ extern unsigned long ktimeout_next_inter
  * Timers with an ->expired field in the past will be executed in the next
  * timeout tick.
  */
-static inline void add_ktimeout(struct ktimeout *ktimeout)
+static inline void ktimeout_add(struct ktimeout *ktimeout)
 {
 	BUG_ON(ktimeout_pending(ktimeout));
 	__ktimeout_mod(ktimeout, ktimeout->expires);
Index: linux/include/linux/timer.h
===================================================================
--- linux.orig/include/linux/timer.h
+++ linux/include/linux/timer.h
@@ -24,7 +24,7 @@
 #define __mod_timer			__ktimeout_mod
 #define mod_timer			ktimeout_mod
 #define next_timer_interrupt		ktimeout_next_interrupt
-#define add_timer			add_ktimeout
+#define add_timer			ktimeout_add
 #define try_to_del_timer_sync		try_to_del_ktimeout_sync
 #define del_timer_sync			del_ktimeout_sync
 #define del_singleshot_timer_sync	del_singleshot_ktimeout_sync
Index: linux/kernel/ktimeout.c
===================================================================
--- linux.orig/kernel/ktimeout.c
+++ linux/kernel/ktimeout.c
@@ -82,7 +82,7 @@ static inline void set_running_ktimeout(
 #endif
 }
 
-static void internal_add_ktimeout(tvec_base_t *base, struct ktimeout *ktimeout)
+static void internal_ktimeout_add(tvec_base_t *base, struct ktimeout *ktimeout)
 {
 	unsigned long expires = ktimeout->expires;
 	unsigned long idx = expires - base->ktimeout_jiffies;
@@ -228,7 +228,7 @@ int __ktimeout_mod(struct ktimeout *ktim
 	}
 
 	ktimeout->expires = expires;
-	internal_add_ktimeout(new_base, ktimeout);
+	internal_ktimeout_add(new_base, ktimeout);
 	spin_unlock_irqrestore(&new_base->t_base.lock, flags);
 
 	return ret;
@@ -251,7 +251,7 @@ void ktimeout_add_on(struct ktimeout *kt
   	BUG_ON(ktimeout_pending(ktimeout) || !ktimeout->function);
 	spin_lock_irqsave(&base->t_base.lock, flags);
 	ktimeout->base = &base->t_base;
-	internal_add_ktimeout(base, ktimeout);
+	internal_ktimeout_add(base, ktimeout);
 	spin_unlock_irqrestore(&base->t_base.lock, flags);
 }
 
@@ -265,11 +265,11 @@ void ktimeout_add_on(struct ktimeout *kt
  *
  * ktimeout_mod(ktimeout, expires) is equivalent to:
  *
- *  ktimeout_del(ktimeout); ktimeout->expires = expires; add_ktimeout(ktimeout);
+ *  ktimeout_del(ktimeout); ktimeout->expires = expires; ktimeout_add(ktimeout);
  *
  * Note that if there are multiple unserialized concurrent users of the same
  * timeout, then ktimeout_mod() is the only safe way to modify the interval,
- * since add_ktimeout() cannot modify an already running ktimeout.
+ * since ktimeout_add() cannot modify an already running ktimeout.
  *
  * The function returns whether it has modified a pending timeout or not.
  * (ie. ktimeout_mod() of an inactive timeout returns 0, ktimeout_mod() of an
@@ -398,7 +398,7 @@ static int cascade(tvec_base_t *base, tv
 		tmp = list_entry(curr, struct ktimeout, entry);
 		BUG_ON(tmp->base != &base->t_base);
 		curr = curr->next;
-		internal_add_ktimeout(base, tmp);
+		internal_ktimeout_add(base, tmp);
 	}
 	INIT_LIST_HEAD(head);
 
@@ -708,7 +708,7 @@ static void migrate_ktimeout(tvec_base_t
 		ktimeout = list_entry(head->next, struct ktimeout, entry);
 		detach_ktimeout(ktimeout, 0);
 		ktimeout->base = &new_base->t_base;
-		internal_add_ktimeout(new_base, ktimeout);
+		internal_ktimeout_add(new_base, ktimeout);
 	}
 }
 

--

