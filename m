Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751656AbWANOa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656AbWANOa3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 09:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751758AbWANOa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 09:30:29 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:59330 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751656AbWANOa2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 09:30:28 -0500
Date: Sat, 14 Jan 2006 15:30:42 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Harald Welte <laforge@netfilter.org>, coreteam@netfilter.org,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: [patch 2.6.15-mm4] sem2mutex: netfilter x_table.c
Message-ID: <20060114143042.GA17675@elte.hu>
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

From: Ingo Molnar <mingo@elte.hu>

semaphore to mutex conversion.

the conversion was generated via scripts, and the result was validated
automatically via a script as well.

build tested.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
----

 net/netfilter/x_tables.c |   56 ++++++++++++++++++++++++-----------------------
 1 files changed, 29 insertions(+), 27 deletions(-)

Index: linux/net/netfilter/x_tables.c
===================================================================
--- linux.orig/net/netfilter/x_tables.c
+++ linux/net/netfilter/x_tables.c
@@ -21,10 +21,12 @@
 #include <linux/seq_file.h>
 #include <linux/string.h>
 #include <linux/vmalloc.h>
+#include <linux/mutex.h>
 
 #include <linux/netfilter/x_tables.h>
 #include <linux/netfilter_arp.h>
 
+
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Harald Welte <laforge@netfilter.org>");
 MODULE_DESCRIPTION("[ip,ip6,arp]_tables backend module");
@@ -32,7 +34,7 @@ MODULE_DESCRIPTION("[ip,ip6,arp]_tables 
 #define SMP_ALIGN(x) (((x) + SMP_CACHE_BYTES-1) & ~(SMP_CACHE_BYTES-1))
 
 struct xt_af {
-	struct semaphore mutex;
+	struct mutex mutex;
 	struct list_head match;
 	struct list_head target;
 	struct list_head tables;
@@ -58,11 +60,11 @@ xt_register_target(int af, struct xt_tar
 {
 	int ret;
 
-	ret = down_interruptible(&xt[af].mutex);
+	ret = mutex_lock_interruptible(&xt[af].mutex);
 	if (ret != 0)
 		return ret;
 	list_add(&target->list, &xt[af].target);
-	up(&xt[af].mutex);
+	mutex_unlock(&xt[af].mutex);
 	return ret;
 }
 EXPORT_SYMBOL(xt_register_target);
@@ -70,9 +72,9 @@ EXPORT_SYMBOL(xt_register_target);
 void
 xt_unregister_target(int af, struct xt_target *target)
 {
-	down(&xt[af].mutex);
+	mutex_lock(&xt[af].mutex);
 	LIST_DELETE(&xt[af].target, target);
-	up(&xt[af].mutex);
+	mutex_unlock(&xt[af].mutex);
 }
 EXPORT_SYMBOL(xt_unregister_target);
 
@@ -81,12 +83,12 @@ xt_register_match(int af, struct xt_matc
 {
 	int ret;
 
-	ret = down_interruptible(&xt[af].mutex);
+	ret = mutex_lock_interruptible(&xt[af].mutex);
 	if (ret != 0)
 		return ret;
 
 	list_add(&match->list, &xt[af].match);
-	up(&xt[af].mutex);
+	mutex_unlock(&xt[af].mutex);
 
 	return ret;
 }
@@ -95,9 +97,9 @@ EXPORT_SYMBOL(xt_register_match);
 void
 xt_unregister_match(int af, struct xt_match *match)
 {
-	down(&xt[af].mutex);
+	mutex_lock(&xt[af].mutex);
 	LIST_DELETE(&xt[af].match, match);
-	up(&xt[af].mutex);
+	mutex_unlock(&xt[af].mutex);
 }
 EXPORT_SYMBOL(xt_unregister_match);
 
@@ -114,21 +116,21 @@ struct xt_match *xt_find_match(int af, c
 	struct xt_match *m;
 	int err = 0;
 
-	if (down_interruptible(&xt[af].mutex) != 0)
+	if (mutex_lock_interruptible(&xt[af].mutex) != 0)
 		return ERR_PTR(-EINTR);
 
 	list_for_each_entry(m, &xt[af].match, list) {
 		if (strcmp(m->name, name) == 0) {
 			if (m->revision == revision) {
 				if (try_module_get(m->me)) {
-					up(&xt[af].mutex);
+					mutex_unlock(&xt[af].mutex);
 					return m;
 				}
 			} else
 				err = -EPROTOTYPE; /* Found something. */
 		}
 	}
-	up(&xt[af].mutex);
+	mutex_unlock(&xt[af].mutex);
 	return ERR_PTR(err);
 }
 EXPORT_SYMBOL(xt_find_match);
@@ -139,21 +141,21 @@ struct xt_target *xt_find_target(int af,
 	struct xt_target *t;
 	int err = 0;
 
-	if (down_interruptible(&xt[af].mutex) != 0)
+	if (mutex_lock_interruptible(&xt[af].mutex) != 0)
 		return ERR_PTR(-EINTR);
 
 	list_for_each_entry(t, &xt[af].target, list) {
 		if (strcmp(t->name, name) == 0) {
 			if (t->revision == revision) {
 				if (try_module_get(t->me)) {
-					up(&xt[af].mutex);
+					mutex_unlock(&xt[af].mutex);
 					return t;
 				}
 			} else
 				err = -EPROTOTYPE; /* Found something. */
 		}
 	}
-	up(&xt[af].mutex);
+	mutex_unlock(&xt[af].mutex);
 	return ERR_PTR(err);
 }
 EXPORT_SYMBOL(xt_find_target);
@@ -214,7 +216,7 @@ int xt_find_revision(int af, const char 
 {
 	int have_rev, best = -1;
 
-	if (down_interruptible(&xt[af].mutex) != 0) {
+	if (mutex_lock_interruptible(&xt[af].mutex) != 0) {
 		*err = -EINTR;
 		return 1;
 	}
@@ -222,7 +224,7 @@ int xt_find_revision(int af, const char 
 		have_rev = target_revfn(af, name, revision, &best);
 	else
 		have_rev = match_revfn(af, name, revision, &best);
-	up(&xt[af].mutex);
+	mutex_unlock(&xt[af].mutex);
 
 	/* Nothing at all?  Return 0 to try loading module. */
 	if (best == -1) {
@@ -290,20 +292,20 @@ struct xt_table *xt_find_table_lock(int 
 {
 	struct xt_table *t;
 
-	if (down_interruptible(&xt[af].mutex) != 0)
+	if (mutex_lock_interruptible(&xt[af].mutex) != 0)
 		return ERR_PTR(-EINTR);
 
 	list_for_each_entry(t, &xt[af].tables, list)
 		if (strcmp(t->name, name) == 0 && try_module_get(t->me))
 			return t;
-	up(&xt[af].mutex);
+	mutex_unlock(&xt[af].mutex);
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(xt_find_table_lock);
 
 void xt_table_unlock(struct xt_table *table)
 {
-	up(&xt[table->af].mutex);
+	mutex_unlock(&xt[table->af].mutex);
 }
 EXPORT_SYMBOL_GPL(xt_table_unlock);
 
@@ -343,7 +345,7 @@ int xt_register_table(struct xt_table *t
 	int ret;
 	struct xt_table_info *private;
 
-	ret = down_interruptible(&xt[table->af].mutex);
+	ret = mutex_lock_interruptible(&xt[table->af].mutex);
 	if (ret != 0)
 		return ret;
 
@@ -369,7 +371,7 @@ int xt_register_table(struct xt_table *t
 
 	ret = 0;
  unlock:
-	up(&xt[table->af].mutex);
+	mutex_unlock(&xt[table->af].mutex);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(xt_register_table);
@@ -378,10 +380,10 @@ void *xt_unregister_table(struct xt_tabl
 {
 	struct xt_table_info *private;
 
-	down(&xt[table->af].mutex);
+	mutex_lock(&xt[table->af].mutex);
 	private = table->private;
 	LIST_DELETE(&xt[table->af].tables, table);
-	up(&xt[table->af].mutex);
+	mutex_unlock(&xt[table->af].mutex);
 
 	return private;
 }
@@ -445,7 +447,7 @@ static void *xt_tgt_seq_start(struct seq
 	if (!list)
 		return NULL;
 
-	if (down_interruptible(&xt[af].mutex) != 0)
+	if (mutex_lock_interruptible(&xt[af].mutex) != 0)
 		return NULL;
 	
 	return xt_get_idx(list, seq, *pos);
@@ -474,7 +476,7 @@ static void xt_tgt_seq_stop(struct seq_f
 	struct proc_dir_entry *pde = seq->private;
 	u_int16_t af = (unsigned long)pde->data & 0xffff;
 
-	up(&xt[af].mutex);
+	mutex_unlock(&xt[af].mutex);
 }
 
 static int xt_name_seq_show(struct seq_file *seq, void *v)
@@ -606,7 +608,7 @@ static int __init xt_init(void)
 		return -ENOMEM;
 
 	for (i = 0; i < NPROTO; i++) {
-		init_MUTEX(&xt[i].mutex);
+		mutex_init(&xt[i].mutex);
 		INIT_LIST_HEAD(&xt[i].target);
 		INIT_LIST_HEAD(&xt[i].match);
 		INIT_LIST_HEAD(&xt[i].tables);
