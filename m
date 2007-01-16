Return-Path: <linux-kernel-owner+w=401wt.eu-S932411AbXAPGd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbXAPGd6 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 01:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbXAPG2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 01:28:25 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:44266 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932421AbXAPG1x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 01:27:53 -0500
Message-Id: <20070116063030.317602000@bull.net>
References: <20070116061516.899460000@bull.net>
User-Agent: quilt/0.45-1
Date: Tue, 16 Jan 2007 07:15:21 +0100
From: Nadia.Derbey@bull.net
To: linux-kernel@vger.kernel.org
Cc: Nadia Derbey <Nadia.Derbey@bull.net>
Subject: [RFC][PATCH 5/6] per namespace tunables
Content-Disposition: inline; filename=per_namespace_tunables.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 05/06]


This patch introduces all that is needed to process per namespace tunables.


Signed-off-by: Nadia Derbey <Nadia.Derbey@bull.net>


---
 include/linux/akt.h   |   12 +++++++
 kernel/autotune/akt.c |   80 ++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 73 insertions(+), 19 deletions(-)

Index: linux-2.6.20-rc4/include/linux/akt.h
===================================================================
--- linux-2.6.20-rc4.orig/include/linux/akt.h	2007-01-15 15:21:47.000000000 +0100
+++ linux-2.6.20-rc4/include/linux/akt.h	2007-01-15 15:31:44.000000000 +0100
@@ -154,6 +154,7 @@ struct auto_tune {
  */
 #define AUTO_TUNE_ENABLE  0x01
 #define TUNABLE_REGISTERED  0x02
+#define TUNABLE_IPC_NS      0x04
 
 
 /*
@@ -204,6 +205,8 @@ static inline int is_tunable_registered(
 	}
 
 
+#define DECLARE_TUNABLE(s)	struct auto_tune s;
+
 #define DEFINE_TUNABLE(s, thr, min, max, tun, chk, type)		\
 	struct auto_tune s = TUNABLE_INIT(#s, thr, min, max, tun, chk, type)
 
@@ -215,6 +218,13 @@ static inline int is_tunable_registered(
 		(s).max.abs_value.val_##type = _max;	\
 	} while (0)
 
+#define init_tunable_ipcns(ns, s, thr, min, max, tun, chk, type)	\
+	do {								\
+		DEFINE_TUNABLE(s, thr, min, max, tun, chk, type);	\
+		s.flags |= TUNABLE_IPC_NS;				\
+		ns->s = s;						\
+	} while (0)
+
 
 static inline void set_autotuning_routine(struct auto_tune *tunable,
 					auto_tune_fn fn)
@@ -269,7 +279,9 @@ extern ssize_t store_tunable_max(struct 
 #else	/* CONFIG_AKT */
 
 
+#define DECLARE_TUNABLE(s)
 #define DEFINE_TUNABLE(s, thresh, min, max, tun, chk, type)
+#define init_tunable_ipcns(ns, s, th, m, M, tun, chk, type)  do { } while (0)
 #define set_tunable_min_max(s, min, max, type)   do { } while (0)
 #define set_autotuning_routine(s, fn)            do { } while (0)
 
Index: linux-2.6.20-rc4/kernel/autotune/akt.c
===================================================================
--- linux-2.6.20-rc4.orig/kernel/autotune/akt.c	2007-01-15 15:25:35.000000000 +0100
+++ linux-2.6.20-rc4/kernel/autotune/akt.c	2007-01-15 15:37:16.000000000 +0100
@@ -32,6 +32,7 @@
  *              store_tunable_min          (exported)
  *              show_tunable_max           (exported)
  *              store_tunable_max          (exported)
+ *              get_ns_tunable             (static)
  */
 
 #include <linux/init.h>
@@ -45,6 +46,8 @@
 #define AKT_AUTO   1
 #define AKT_MANUAL 0
 
+static struct auto_tune *get_ns_tunable(struct auto_tune *);
+
 
 
 /*
@@ -142,6 +145,7 @@ int unregister_tunable(struct auto_tune 
 ssize_t show_tuning_mode(struct auto_tune *tun_addr, char *buf)
 {
 	int valid;
+	struct auto_tune *which;
 
 	if (tun_addr == NULL) {
 		printk(KERN_ERR
@@ -149,11 +153,13 @@ ssize_t show_tuning_mode(struct auto_tun
 		return -EINVAL;
 	}
 
-	spin_lock(&tun_addr->tunable_lck);
+	which = get_ns_tunable(tun_addr);
+
+	spin_lock(&which->tunable_lck);
 
-	valid = is_auto_tune_enabled(tun_addr);
+	valid = is_auto_tune_enabled(which);
 
-	spin_unlock(&tun_addr->tunable_lck);
+	spin_unlock(&which->tunable_lck);
 
 	return snprintf(buf, PAGE_SIZE, "%d\n", valid);
 }
@@ -176,6 +182,7 @@ ssize_t store_tuning_mode(struct auto_tu
 			size_t count)
 {
 	int new_value;
+	struct auto_tune *which;
 	int rc;
 
 	if ((rc = sscanf(buffer, "%d", &new_value)) != 1)
@@ -190,18 +197,20 @@ ssize_t store_tuning_mode(struct auto_tu
 		return -EINVAL;
 	}
 
-	spin_lock(&tun_addr->tunable_lck);
+	which = get_ns_tunable(tun_addr);
+
+	spin_lock(&which->tunable_lck);
 
 	switch (new_value) {
 	case AKT_AUTO:
-		tun_addr->flags |= AUTO_TUNE_ENABLE;
+		which->flags |= AUTO_TUNE_ENABLE;
 		break;
 	case AKT_MANUAL:
-		tun_addr->flags &= ~AUTO_TUNE_ENABLE;
+		which->flags &= ~AUTO_TUNE_ENABLE;
 		break;
 	}
 
-	spin_unlock(&tun_addr->tunable_lck);
+	spin_unlock(&which->tunable_lck);
 
 	return strnlen(buffer, PAGE_SIZE);
 }
@@ -218,6 +227,7 @@ ssize_t store_tuning_mode(struct auto_tu
 ssize_t show_tunable_min(struct auto_tune *tun_addr, char *buf)
 {
 	ssize_t rc;
+	struct auto_tune *which;
 
 	if (tun_addr == NULL) {
 		printk(KERN_ERR
@@ -225,11 +235,13 @@ ssize_t show_tunable_min(struct auto_tun
 		return -EINVAL;
 	}
 
-	spin_lock(&tun_addr->tunable_lck);
+	which = get_ns_tunable(tun_addr);
 
-	rc = tun_addr->min.show(tun_addr, buf);
+	spin_lock(&which->tunable_lck);
 
-	spin_unlock(&tun_addr->tunable_lck);
+	rc = which->min.show(which, buf);
+
+	spin_unlock(&which->tunable_lck);
 
 	return rc;
 }
@@ -248,6 +260,7 @@ ssize_t store_tunable_min(struct auto_tu
 			size_t count)
 {
 	ssize_t rc;
+	struct auto_tune *which;
 
 	if (tun_addr == NULL) {
 		printk(KERN_ERR
@@ -255,11 +268,13 @@ ssize_t store_tunable_min(struct auto_tu
 		return -EINVAL;
 	}
 
-	spin_lock(&tun_addr->tunable_lck);
+	which = get_ns_tunable(tun_addr);
+
+	spin_lock(&which->tunable_lck);
 
-	rc = tun_addr->min.store(tun_addr, buf, count);
+	rc = which->min.store(which, buf, count);
 
-	spin_unlock(&tun_addr->tunable_lck);
+	spin_unlock(&which->tunable_lck);
 
 	return rc;
 }
@@ -276,6 +291,7 @@ ssize_t store_tunable_min(struct auto_tu
 ssize_t show_tunable_max(struct auto_tune *tun_addr, char *buf)
 {
 	ssize_t rc;
+	struct auto_tune *which;
 
 	if (tun_addr == NULL) {
 		printk(KERN_ERR
@@ -283,11 +299,13 @@ ssize_t show_tunable_max(struct auto_tun
 		return -EINVAL;
 	}
 
-	spin_lock(&tun_addr->tunable_lck);
+	which = get_ns_tunable(tun_addr);
 
-	rc = tun_addr->max.show(tun_addr, buf);
+	spin_lock(&which->tunable_lck);
 
-	spin_unlock(&tun_addr->tunable_lck);
+	rc = which->max.show(which, buf);
+
+	spin_unlock(&which->tunable_lck);
 
 	return rc;
 }
@@ -306,6 +324,7 @@ ssize_t store_tunable_max(struct auto_tu
 			size_t count)
 {
 	ssize_t rc;
+	struct auto_tune *which;
 
 	if (tun_addr == NULL) {
 		printk(KERN_ERR
@@ -313,15 +332,38 @@ ssize_t store_tunable_max(struct auto_tu
 		return -EINVAL;
 	}
 
-	spin_lock(&tun_addr->tunable_lck);
+	which = get_ns_tunable(tun_addr);
+
+	spin_lock(&which->tunable_lck);
 
-	rc = tun_addr->max.store(tun_addr, buf, count);
+	rc = which->max.store(which, buf, count);
 
-	spin_unlock(&tun_addr->tunable_lck);
+	spin_unlock(&which->tunable_lck);
 
 	return rc;
 }
 
 
+/*
+ * FUNCTION:    This routine gets the actual auto_tune structure for the
+ *              tunables that are per namespace (presently only ipc ones).
+ *
+ * RETURN VALUE: pointer to the tunable structure for the current namespace
+ */
+static struct auto_tune *get_ns_tunable(struct auto_tune *p)
+{
+	if (p->flags & TUNABLE_IPC_NS) {
+		char *shift = (char *) p;
+		struct ipc_namespace *ns = current->nsproxy->ipc_ns;
+
+		shift = (shift - (char *) &init_ipc_ns) + (char *) ns;
+
+		return (struct auto_tune *) shift;
+	}
+
+	return p;
+}
+
+
 EXPORT_SYMBOL_GPL(register_tunable);
 EXPORT_SYMBOL_GPL(unregister_tunable);

--
