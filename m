Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbWGCQY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWGCQY2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 12:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbWGCQY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 12:24:28 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:27477 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP id S932094AbWGCQY1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 12:24:27 -0400
Subject: [Patch] statistics infrastructure - update 9
From: Martin Peschke <mp3@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: heiko.carstens@de.ibm.com, clg@fr.ibm.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 03 Jul 2006 18:24:22 +0200
Message-Id: <1151943862.2936.10.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I broke !CONFIG_STATISTICS. This is the fix.

drivers/s390/built-in.o(.text+0x67cae): In function
`zfcp_ccw_set_online':
zfcp_ccw.c: undefined reference to `statistic_create'
drivers/s390/built-in.o(.text+0x67cf0):zfcp_ccw.c: undefined reference
to `statistic_remove'
<snip>

Signed-off-by: Martin Peschke <mp3@de.ibm.com>
---

 include/linux/statistic.h |   63 +++++++++++++++++++++++++++++++++++++---------
 lib/statistic.c           |   10 -------
 2 files changed, 51 insertions(+), 22 deletions(-)

diff -urp a/include/linux/statistic.h b/include/linux/statistic.h
--- a/include/linux/statistic.h	2006-07-03 17:39:48.000000000 +0200
+++ b/include/linux/statistic.h	2006-07-03 17:37:24.000000000 +0200
@@ -125,6 +125,8 @@ struct statistic_interface {
 	void			*pull_private;
 };
 
+#ifdef CONFIG_STATISTICS
+
 extern int statistic_create(struct statistic_interface *, const char *);
 extern int statistic_remove(struct statistic_interface *);
 
@@ -133,12 +135,6 @@ extern void statistic_set(struct statist
 extern void _statistic_add(struct statistic *, int, s64, u64);
 extern void statistic_add(struct statistic *, int, s64, u64);
 
-#define _statistic_inc(stat, i, value) \
-	_statistic_add(stat, i, value, 1)
-
-#define statistic_inc(stat, i, value) \
-	statistic_add(stat, i, value, 1)
-
 /*
  * Clients are not supposed to call these directly.
  * The declarations are needed to allow optimisation of _statistic_add_as()
@@ -173,9 +169,8 @@ extern void statistic_add_sparse(struct 
  * You may want to use _statistic_inc_as() for (X, 1) data pairs.
  */
 static inline void _statistic_add_as(int type, struct statistic *stat, int i,
-		       s64 value, u64 incr)
+				     s64 value, u64 incr)
 {
-#ifdef CONFIG_STATISTICS
 	if (stat[i].state == STATISTIC_STATE_ON) {
 		switch (type) {
 		case STAT_CNTR_INC:
@@ -198,7 +193,6 @@ static inline void _statistic_add_as(int
 			break;
 		}
 	}
-#endif
 }
 
 /**
@@ -223,16 +217,61 @@ static inline void _statistic_add_as(int
  * You may want to use statistic_inc() for (X, 1) data pairs.
  */
 static inline void statistic_add_as(int type, struct statistic *stat, int i,
-		      s64 value, u64 incr)
+				    s64 value, u64 incr)
 {
-#ifdef CONFIG_STATISTICS
 	unsigned long flags;
 	local_irq_save(flags);
 	_statistic_add_as(type, stat, i, value, incr);
 	local_irq_restore(flags);
-#endif
 }
 
+#else /* !CONFIG_STATISTICS */
+/* These NOP functions unburden clients from handling !CONFIG_STATISTICS. */
+
+static inline int statistic_create(struct statistic_interface *interface,
+				   const char *name)
+{
+	return 0;
+}
+
+static inline int statistic_remove(struct statistic_interface *interface)
+{
+	return 0;
+}
+
+static inline void statistic_set(struct statistic *stat, int i,
+				 s64 value, u64 total)
+{
+}
+
+static inline void _statistic_add(struct statistic *stat, int i,
+				  s64 value, u64 incr)
+{
+}
+
+static inline void statistic_add(struct statistic *stat, int i,
+				 s64 value, u64 incr)
+{
+}
+
+static inline void _statistic_add_as(int type, struct statistic *stat, int i,
+				     s64 value, u64 incr)
+{
+}
+
+static inline void statistic_add_as(int type, struct statistic *stat, int i,
+				    s64 value, u64 incr)
+{
+}
+
+#endif /* CONFIG_STATISTICS */
+
+#define _statistic_inc(stat, i, value) \
+	_statistic_add(stat, i, value, 1)
+
+#define statistic_inc(stat, i, value) \
+	statistic_add(stat, i, value, 1)
+
 #define _statistic_inc_as(type, stat, i, value) \
 	_statistic_add_as(type, stat, i, value, 1)
 
diff -urp a/lib/statistic.c b/lib/statistic.c
--- a/lib/statistic.c	2006-07-03 17:39:48.000000000 +0200
+++ b/lib/statistic.c	2006-07-03 14:49:51.000000000 +0200
@@ -1454,7 +1454,6 @@ static struct statistic_discipline stati
  */
 int statistic_create(struct statistic_interface *interface, const char *name)
 {
-#ifdef CONFIG_STATISTICS
 	struct statistic *stat = interface->stat;
 	struct statistic_info *info = interface->info;
 	int i;
@@ -1491,7 +1490,6 @@ int statistic_create(struct statistic_in
 	mutex_lock(&statistic_list_mutex);
 	list_add(&interface->list, &statistic_list);
 	mutex_unlock(&statistic_list_mutex);
-#endif
 	return 0;
 }
 EXPORT_SYMBOL_GPL(statistic_create);
@@ -1510,7 +1508,6 @@ EXPORT_SYMBOL_GPL(statistic_create);
  */
 int statistic_remove(struct statistic_interface *interface)
 {
-#ifdef CONFIG_STATISTICS
 	struct statistic *stat = interface->stat;
 	struct statistic_info *info = interface->info;
 	int i;
@@ -1526,7 +1523,6 @@ int statistic_remove(struct statistic_in
 	debugfs_remove(interface->def_file);
 	debugfs_remove(interface->debugfs_dir);
 	interface->debugfs_dir = NULL;
-#endif
 	return 0;
 }
 EXPORT_SYMBOL_GPL(statistic_remove);
@@ -1548,10 +1544,8 @@ EXPORT_SYMBOL_GPL(statistic_remove);
  */
 void _statistic_add(struct statistic *stat, int i, s64 value, u64 incr)
 {
-#ifdef CONFIG_STATISTICS
 	if (stat[i].state == STATISTIC_STATE_ON)
 		stat[i].add(&stat[i], value, incr);
-#endif
 }
 EXPORT_SYMBOL_GPL(_statistic_add);
 
@@ -1572,12 +1566,10 @@ EXPORT_SYMBOL_GPL(_statistic_add);
  */
 void statistic_add(struct statistic *stat, int i, s64 value, u64 incr)
 {
-#ifdef CONFIG_STATISTICS
 	unsigned long flags;
 	local_irq_save(flags);
 	_statistic_add(stat, i, value, incr);
 	local_irq_restore(flags);
-#endif
 }
 EXPORT_SYMBOL_GPL(statistic_add);
 
@@ -1601,11 +1593,9 @@ EXPORT_SYMBOL_GPL(statistic_add);
  */
 void statistic_set(struct statistic *stat, int i, s64 value, u64 total)
 {
-#ifdef CONFIG_STATISTICS
 	struct statistic_discipline *disc = &statistic_discs[stat[i].type];
 	if (stat[i].state == STATISTIC_STATE_ON)
 		disc->set(&stat[i], value, total);
-#endif
 }
 EXPORT_SYMBOL_GPL(statistic_set);
 



