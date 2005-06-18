Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261224AbVFRAUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbVFRAUL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 20:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbVFRAUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 20:20:10 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:49553 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261224AbVFRATz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 20:19:55 -0400
Date: Fri, 17 Jun 2005 17:20:22 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: dhowells@redhat.com, dipankar@in.ibm.com, ak@suse.de, akpm@osdl.org,
       maneesh@in.ibm.com
Subject: [RFC,PATCH] RCU: clean up a few remaining synchronize_kernel() calls
Message-ID: <20050618002021.GA2892@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.12-rc6-mm1 has a few remaining synchronize_kernel()s, some (but
not all) in comments.  This patch changes these synchronize_kernel()
calls (and comments) to synchronize_rcu() or synchronize_sched() as
follows:

o	arch/x86_64/kernel/mce.c mce_read(): change to synchronize_sched()
	to handle races with machine-check exceptions (synchronize_rcu()
	would not cut it given RCU implementations intended for hardcore
	realtime use.

o	drivers/input/serio/i8042.c i8042_stop(): change to
	synchronize_sched() to handle races with i8042_interrupt()
	interrupt handler.  Again, synchronize_rcu() would not cut it
	given RCU implementations intended for hardcore realtime use.

o	include/*/kdebug.h comments: change to synchronize_sched()
	to handle races with NMIs.  As before, synchronize_rcu()
	would not cut it...

o	include/linux/list.h comment: change to synchronize_rcu(),
	since this comment is for list_del_rcu().

o	security/keys/key.c unregister_key_type(): change to
	synchronize_rcu(), since this is interacting with RCU read side.

o	security/keys/process_keys.c install_session_keyring():
	change to synchronize_rcu(), since this is interacting with
	RCU read side.

Please let me know if there are any problems with any of these changes.

Signed-off-by: paulmck@us.ibm.com

---

 arch/x86_64/kernel/mce.c     |    2 +-
 drivers/input/serio/i8042.c  |    2 +-
 include/asm-i386/kdebug.h    |    2 +-
 include/asm-ppc64/kdebug.h   |    2 +-
 include/asm-sparc64/kdebug.h |    2 +-
 include/asm-x86_64/kdebug.h  |    2 +-
 include/linux/list.h         |    2 +-
 security/keys/key.c          |    2 +-
 security/keys/process_keys.c |    2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff -urpN -X dontdiff linux-2.6.12-rc6-mm1/arch/x86_64/kernel/mce.c linux-2.6.12-rc6-mm1-sksr/arch/x86_64/kernel/mce.c
--- linux-2.6.12-rc6-mm1/arch/x86_64/kernel/mce.c	Fri Jun 17 16:40:34 2005
+++ linux-2.6.12-rc6-mm1-sksr/arch/x86_64/kernel/mce.c	Fri Jun 17 16:47:51 2005
@@ -411,7 +411,7 @@ static ssize_t mce_read(struct file *fil
 	memset(mcelog.entry, 0, next * sizeof(struct mce));
 	mcelog.next = 0;
 
-	synchronize_kernel();	
+	synchronize_sched();	
 
 	/* Collect entries that were still getting written before the synchronize. */
 
diff -urpN -X dontdiff linux-2.6.12-rc6-mm1/drivers/input/serio/i8042.c linux-2.6.12-rc6-mm1-sksr/drivers/input/serio/i8042.c
--- linux-2.6.12-rc6-mm1/drivers/input/serio/i8042.c	Fri Jun 17 16:34:36 2005
+++ linux-2.6.12-rc6-mm1-sksr/drivers/input/serio/i8042.c	Fri Jun 17 16:44:26 2005
@@ -396,7 +396,7 @@ static void i8042_stop(struct serio *ser
 	struct i8042_port *port = serio->port_data;
 
 	port->exists = 0;
-	synchronize_kernel();
+	synchronize_sched();
 	port->serio = NULL;
 }
 
diff -urpN -X dontdiff linux-2.6.12-rc6-mm1/include/asm-i386/kdebug.h linux-2.6.12-rc6-mm1-sksr/include/asm-i386/kdebug.h
--- linux-2.6.12-rc6-mm1/include/asm-i386/kdebug.h	Tue Mar  1 23:38:25 2005
+++ linux-2.6.12-rc6-mm1-sksr/include/asm-i386/kdebug.h	Fri Jun 17 16:50:10 2005
@@ -18,7 +18,7 @@ struct die_args {
 };
 
 /* Note - you should never unregister because that can race with NMIs.
-   If you really want to do it first unregister - then synchronize_kernel - then free.
+   If you really want to do it first unregister - then synchronize_sched - then free.
   */
 int register_die_notifier(struct notifier_block *nb);
 extern struct notifier_block *i386die_chain;
diff -urpN -X dontdiff linux-2.6.12-rc6-mm1/include/asm-ppc64/kdebug.h linux-2.6.12-rc6-mm1-sksr/include/asm-ppc64/kdebug.h
--- linux-2.6.12-rc6-mm1/include/asm-ppc64/kdebug.h	Tue Mar  1 23:38:01 2005
+++ linux-2.6.12-rc6-mm1-sksr/include/asm-ppc64/kdebug.h	Fri Jun 17 16:48:29 2005
@@ -17,7 +17,7 @@ struct die_args {
 
 /*
    Note - you should never unregister because that can race with NMIs.
-   If you really want to do it first unregister - then synchronize_kernel -
+   If you really want to do it first unregister - then synchronize_sched -
    then free.
  */
 int register_die_notifier(struct notifier_block *nb);
diff -urpN -X dontdiff linux-2.6.12-rc6-mm1/include/asm-sparc64/kdebug.h linux-2.6.12-rc6-mm1-sksr/include/asm-sparc64/kdebug.h
--- linux-2.6.12-rc6-mm1/include/asm-sparc64/kdebug.h	Tue Mar  1 23:38:32 2005
+++ linux-2.6.12-rc6-mm1-sksr/include/asm-sparc64/kdebug.h	Fri Jun 17 16:55:26 2005
@@ -16,7 +16,7 @@ struct die_args {
 };
 
 /* Note - you should never unregister because that can race with NMIs.
- * If you really want to do it first unregister - then synchronize_kernel
+ * If you really want to do it first unregister - then synchronize_sched
  * - then free.
  */
 int register_die_notifier(struct notifier_block *nb);
diff -urpN -X dontdiff linux-2.6.12-rc6-mm1/include/asm-x86_64/kdebug.h linux-2.6.12-rc6-mm1-sksr/include/asm-x86_64/kdebug.h
--- linux-2.6.12-rc6-mm1/include/asm-x86_64/kdebug.h	Fri Jun 17 16:35:11 2005
+++ linux-2.6.12-rc6-mm1-sksr/include/asm-x86_64/kdebug.h	Fri Jun 17 16:48:56 2005
@@ -14,7 +14,7 @@ struct die_args { 
 }; 
 
 /* Note - you should never unregister because that can race with NMIs.
-   If you really want to do it first unregister - then synchronize_kernel - then free. 
+   If you really want to do it first unregister - then synchronize_sched - then free. 
   */
 int register_die_notifier(struct notifier_block *nb);
 extern struct notifier_block *die_chain;
diff -urpN -X dontdiff linux-2.6.12-rc6-mm1/include/linux/list.h linux-2.6.12-rc6-mm1-sksr/include/linux/list.h
--- linux-2.6.12-rc6-mm1/include/linux/list.h	Fri Jun 17 16:41:12 2005
+++ linux-2.6.12-rc6-mm1-sksr/include/linux/list.h	Fri Jun 17 16:49:47 2005
@@ -189,7 +189,7 @@ static inline void list_del(struct list_
  * list_for_each_entry_rcu().
  *
  * Note that the caller is not permitted to immediately free
- * the newly deleted entry.  Instead, either synchronize_kernel()
+ * the newly deleted entry.  Instead, either synchronize_rcu()
  * or call_rcu() must be used to defer freeing until an RCU
  * grace period has elapsed.
  */
diff -urpN -X dontdiff linux-2.6.12-rc6-mm1/security/keys/key.c linux-2.6.12-rc6-mm1-sksr/security/keys/key.c
--- linux-2.6.12-rc6-mm1/security/keys/key.c	Fri Jun 17 16:41:16 2005
+++ linux-2.6.12-rc6-mm1-sksr/security/keys/key.c	Fri Jun 17 16:51:46 2005
@@ -980,7 +980,7 @@ void unregister_key_type(struct key_type
 	spin_unlock(&key_serial_lock);
 
 	/* make sure everyone revalidates their keys */
-	synchronize_kernel();
+	synchronize_rcu();
 
 	/* we should now be able to destroy the payloads of all the keys of
 	 * this type with impunity */
diff -urpN -X dontdiff linux-2.6.12-rc6-mm1/security/keys/process_keys.c linux-2.6.12-rc6-mm1-sksr/security/keys/process_keys.c
--- linux-2.6.12-rc6-mm1/security/keys/process_keys.c	Fri Jun 17 16:41:16 2005
+++ linux-2.6.12-rc6-mm1-sksr/security/keys/process_keys.c	Fri Jun 17 16:51:26 2005
@@ -234,7 +234,7 @@ static int install_session_keyring(struc
 	ret = 0;
 
 	/* we're using RCU on the pointer */
-	synchronize_kernel();
+	synchronize_rcu();
 	key_put(old);
  error:
 	return ret;
