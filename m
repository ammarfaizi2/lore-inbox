Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbWAYSAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbWAYSAT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 13:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbWAYSAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 13:00:19 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:53194 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751091AbWAYSAS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 13:00:18 -0500
Date: Wed, 25 Jan 2006 19:00:32 +0100
From: Ingo Molnar <mingo@elte.hu>
To: John Stultz <johnstul@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
Subject: [patch, validator] fix clocksource_lock deadlock
Message-ID: <20060125180032.GA11734@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

clocksource_lock is used in softirq-context via e.g.  
timeofday_periodic_hook() -> get_next_clocksource(), but the lock is not 
acquired in a softirq-safe manner - which could lead to deadlocks.

this bug was found via the lock validator i'm working on:

  ============================
  [ BUG: illegal lock usage! ]
  ----------------------------
  illegal {used-in-softirq} -> {enabled-softirqs} usage.
  swapper/1 [HC0[0]:SC0[0]:HE1:SE1] takes {clocksource_lock [u:21]}, at:
   [<c013f526>] register_clocksource+0x16/0xf0
  {used-in-softirq} state was registered at:
   [<c013f22d>] get_next_clocksource+0xd/0x40
  hardirqs last enabled at: [<c011d31a>] vprintk+0x28a/0x3e0
  softirqs last enabled at: [<c0122999>] irq_exit+0x39/0x50
  
  other info that might help in debugging this:
  ------------------------------
  | showing all locks held by: |  (swapper/1 [c30d7790, 125]): <none>
  ------------------------------
  
   [<c010432d>] show_trace+0xd/0x10
   [<c0104347>] dump_stack+0x17/0x20
   [<c01379b2>] print_usage_bug+0x1e2/0x200
   [<c013817d>] mark_lock+0x28d/0x2a0
   [<c0138835>] debug_lock_chain+0x6a5/0x10d0
   [<c013929d>] debug_lock_chain_spin+0x3d/0x60
   [<c026570d>] _raw_spin_lock+0x2d/0x90
   [<c04d88d8>] _spin_lock+0x8/0x10
   [<c013f526>] register_clocksource+0x16/0xf0
   [<c0681137>] init_pit_clocksource+0x57/0x90
   [<c01003fa>] init+0xfa/0x3e0
   [<c0100ef5>] kernel_thread_helper+0x5/0x10

the fix is to lock clocksource_lock in a softirq-safe way.

(with this patch applied, the timeofday code validates fine.)

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 kernel/time/clocksource.c |   31 +++++++++++++++++--------------
 1 files changed, 17 insertions(+), 14 deletions(-)

Index: linux/kernel/time/clocksource.c
===================================================================
--- linux.orig/kernel/time/clocksource.c
+++ linux/kernel/time/clocksource.c
@@ -48,6 +48,9 @@ extern struct clocksource clocksource_ji
 static struct clocksource *curr_clocksource = &clocksource_jiffies;
 static struct clocksource *next_clocksource;
 static LIST_HEAD(clocksource_list);
+/*
+ * May be used in softirq context too:
+ */
 static DEFINE_SPINLOCK(clocksource_lock);
 static char override_name[32];
 
@@ -70,12 +73,12 @@ late_initcall(clocksource_done_booting);
  */
 struct clocksource *get_next_clocksource(void)
 {
-	spin_lock(&clocksource_lock);
+	spin_lock_bh(&clocksource_lock);
 	if (next_clocksource && finished_booting) {
 		curr_clocksource = next_clocksource;
 		next_clocksource = NULL;
 	}
-	spin_unlock(&clocksource_lock);
+	spin_unlock_bh(&clocksource_lock);
 
 	return curr_clocksource;
 }
@@ -141,7 +144,7 @@ static int is_registered_source(struct c
  */
 void register_clocksource(struct clocksource *c)
 {
-	spin_lock(&clocksource_lock);
+	spin_lock_bh(&clocksource_lock);
 
 	/* check if clocksource is already registered */
 	if (is_registered_source(c)) {
@@ -152,7 +155,7 @@ void register_clocksource(struct clockso
 		/* select next clocksource */
 		next_clocksource = select_clocksource();
 	}
-	spin_unlock(&clocksource_lock);
+	spin_unlock_bh(&clocksource_lock);
 }
 
 EXPORT_SYMBOL(register_clocksource);
@@ -166,9 +169,9 @@ EXPORT_SYMBOL(register_clocksource);
  */
 void reselect_clocksource(void)
 {
-	spin_lock(&clocksource_lock);
+	spin_lock_bh(&clocksource_lock);
 	next_clocksource = select_clocksource();
-	spin_unlock(&clocksource_lock);
+	spin_unlock_bh(&clocksource_lock);
 }
 
 /**
@@ -183,9 +186,9 @@ sysfs_show_current_clocksources(struct s
 {
 	char *curr = buf;
 
-	spin_lock(&clocksource_lock);
+	spin_lock_bh(&clocksource_lock);
 	curr += sprintf(curr, "%s ", curr_clocksource->name);
-	spin_unlock(&clocksource_lock);
+	spin_unlock_bh(&clocksource_lock);
 
 	curr += sprintf(curr, "\n");
 
@@ -214,7 +217,7 @@ static ssize_t sysfs_override_clocksourc
 	if (count < 1)
 		return -EINVAL;
 
-	spin_lock(&clocksource_lock);
+	spin_lock_bh(&clocksource_lock);
 
 	/* copy the name given: */
 	memcpy(override_name, buf, count);
@@ -223,7 +226,7 @@ static ssize_t sysfs_override_clocksourc
 	/* try to select it: */
 	next_clocksource = select_clocksource();
 
-	spin_unlock(&clocksource_lock);
+	spin_unlock_bh(&clocksource_lock);
 
 	return count;
 }
@@ -241,14 +244,14 @@ sysfs_show_available_clocksources(struct
 	struct list_head *tmp;
 	char *curr = buf;
 
-	spin_lock(&clocksource_lock);
+	spin_lock_bh(&clocksource_lock);
 	list_for_each(tmp, &clocksource_list) {
 		struct clocksource *src;
 
 		src = list_entry(tmp, struct clocksource, list);
 		curr += sprintf(curr, "%s ", src->name);
 	}
-	spin_unlock(&clocksource_lock);
+	spin_unlock_bh(&clocksource_lock);
 
 	curr += sprintf(curr, "\n");
 
@@ -301,10 +304,10 @@ device_initcall(init_clocksource_sysfs);
  */
 static int __init boot_override_clocksource(char* str)
 {
-	spin_lock(&clocksource_lock);
+	spin_lock_bh(&clocksource_lock);
 	if (str)
 		strlcpy(override_name, str, sizeof(override_name));
-	spin_unlock(&clocksource_lock);
+	spin_unlock_bh(&clocksource_lock);
 	return 1;
 }
 
