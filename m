Return-Path: <linux-kernel-owner+w=401wt.eu-S932422AbXAPG2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbXAPG2W (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 01:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbXAPG1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 01:27:55 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:44258 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932419AbXAPG1v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 01:27:51 -0500
Message-Id: <20070116063029.354790000@bull.net>
References: <20070116061516.899460000@bull.net>
User-Agent: quilt/0.45-1
Date: Tue, 16 Jan 2007 07:15:19 +0100
From: Nadia.Derbey@bull.net
To: linux-kernel@vger.kernel.org
Cc: Nadia Derbey <Nadia.Derbey@bull.net>
Subject: [RFC][PATCH 3/6] tunables associated kobjects
Content-Disposition: inline; filename=auto_tuning_kobjects.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 03/06]


Introduces the kobjects associated to each tunable and the sysfs registration


Signed-off-by: Nadia Derbey <Nadia.Derbey@bull.net>


---
 include/linux/akt.h         |   25 ++++-
 init/main.c                 |    1 
 kernel/autotune/Makefile    |    2 
 kernel/autotune/akt.c       |   86 +++++++++++++++++
 kernel/autotune/akt_sysfs.c |  214 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 324 insertions(+), 4 deletions(-)

Index: linux-2.6.20-rc4/include/linux/akt.h
===================================================================
--- linux-2.6.20-rc4.orig/include/linux/akt.h	2007-01-15 15:00:31.000000000 +0100
+++ linux-2.6.20-rc4/include/linux/akt.h	2007-01-15 15:08:41.000000000 +0100
@@ -48,6 +48,16 @@ typedef int (*auto_tune_fn)(int, struct 
 
 
 /*
+ * for sysfs support
+ */
+struct tunable_kobject {
+	struct kobject kobj;
+	struct auto_tune *tun;
+};
+
+
+
+/*
  * Structure used to describe the min / max values for a tunable inside the
  * auto_tune structure.
  * These values are type dependent and are used as high / low boundaries when
@@ -73,7 +83,12 @@ struct typed_value {
  * allocated for each registered tunable, and the associated kobject exported
  * via sysfs.
  *
- * The structure lock (tunable_lck) protects
+ * This structure may be accessed in 2 ways:
+ *   . directly from inside the kernel susbsystem that uses it (during tunable
+ *     automatic adjustment)
+ *   . from sysfs, while updating the kobject attributes
+ *
+ * In both cases, the structure lock (tunable_lck) is taken: it protects
  * against concurrent accesses to tunable and checked pointers
  *
  * A pointer to this structure is passed in to  the automatic adjustment
@@ -108,6 +123,7 @@ struct auto_tune {
 				/* and associated show / store routines) */
 	struct typed_value max;	/* max value the tunable can ever reach */
 				/* and associated show / store routines) */
+	struct tunable_kobject    tun_kobj;	/* used for sysfs support */
 	void *tunable;	/* address of the tunable to adjust */
 	void *checked;	/* address of the variable that is controlled by */
 			/* the tunable. This is the calling subsystem's */
@@ -158,6 +174,7 @@ static inline int is_tunable_registered(
 		.max	= {						\
 			.value		= { .val_##type = (_max), },	\
 		},							\
+		.tun_kobj	= { .tun = NULL, },			\
 		.tunable	= (_tun),				\
 		.checked	= (_chk),				\
 	}
@@ -211,9 +228,12 @@ static inline int activate_auto_tuning(i
 }
 
 
-
+extern void init_auto_tuning(void);
 extern int register_tunable(struct auto_tune *);
 extern int unregister_tunable(struct auto_tune *);
+extern int tunable_sysfs_setup(struct auto_tune *);
+extern ssize_t show_tuning_mode(struct auto_tune *, char *);
+extern ssize_t store_tuning_mode(struct auto_tune *, const char *, size_t);
 
 
 #else	/* CONFIG_AKT */
@@ -228,6 +248,7 @@ extern int unregister_tunable(struct aut
 #define register_tunable(a)                 0
 #define unregister_tunable(a)               0
 
+static inline void init_auto_tuning(void)   { }
 
 #endif	/* CONFIG_AKT */
 
Index: linux-2.6.20-rc4/init/main.c
===================================================================
--- linux-2.6.20-rc4.orig/init/main.c	2007-01-15 14:29:17.000000000 +0100
+++ linux-2.6.20-rc4/init/main.c	2007-01-15 15:09:27.000000000 +0100
@@ -614,6 +614,7 @@ asmlinkage void __init start_kernel(void
 	signals_init();
 	/* rootfs populating might need page-writeback */
 	page_writeback_init();
+	init_auto_tuning();
 	fork_late_init();
 #ifdef CONFIG_PROC_FS
 	proc_root_init();
Index: linux-2.6.20-rc4/kernel/autotune/Makefile
===================================================================
--- linux-2.6.20-rc4.orig/kernel/autotune/Makefile	2007-01-15 14:31:57.000000000 +0100
+++ linux-2.6.20-rc4/kernel/autotune/Makefile	2007-01-15 15:09:57.000000000 +0100
@@ -2,6 +2,6 @@
 # Makefile for akt
 #
 
-obj-y := akt.o
+obj-y := akt.o akt_sysfs.o
 
 
Index: linux-2.6.20-rc4/kernel/autotune/akt.c
===================================================================
--- linux-2.6.20-rc4.orig/kernel/autotune/akt.c	2007-01-15 14:51:54.000000000 +0100
+++ linux-2.6.20-rc4/kernel/autotune/akt.c	2007-01-15 15:13:31.000000000 +0100
@@ -26,6 +26,8 @@
  *   FUNCTIONS:
  *              register_tunable           (exported)
  *              unregister_tunable         (exported)
+ *              show_tuning_mode           (exported)
+ *              store_tuning_mode          (exported)
  */
 
 #include <linux/init.h>
@@ -36,6 +38,8 @@
 
 
 
+#define AKT_AUTO   1
+#define AKT_MANUAL 0
 
 
 
@@ -54,6 +58,8 @@
  */
 int register_tunable(struct auto_tune *tun)
 {
+	int rc = 0;
+
 	if (tun == NULL) {
 		printk(KERN_ERR "\tBad tunable structure pointer (NULL)\n");
 		return -EINVAL;
@@ -84,7 +90,10 @@ int register_tunable(struct auto_tune *t
 		return -EINVAL;
 	}
 
-	return 0;
+	if (!(rc = tunable_sysfs_setup(tun)))
+		tun->flags |= TUNABLE_REGISTERED;
+
+	return rc;
 }
 
 
@@ -117,6 +126,81 @@ int unregister_tunable(struct auto_tune 
 }
 
 
+/*
+ * FUNCTION:    Get operation called by tunable_attr_show (i.e. when the file
+ *              /sys/tunables/<tunable>/autotune is displayed).
+ *              Outputs "1" if the corresponding tunable is automatically
+ *              adjustable, "0" else
+ *
+ * RETURN VALUE: >0 : output string length (including the '\0')
+ *               <0 : failure
+ */
+ssize_t show_tuning_mode(struct auto_tune *tun_addr, char *buf)
+{
+	int valid;
+
+	if (tun_addr == NULL) {
+		printk(KERN_ERR
+			" show_tuning_mode(): tunable address is invalid\n");
+		return -EINVAL;
+	}
+
+	spin_lock(&tun_addr->tunable_lck);
+
+	valid = is_auto_tune_enabled(tun_addr);
+
+	spin_unlock(&tun_addr->tunable_lck);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", valid);
+}
+
+
+/*
+ * NAME:        store_tuning_mode
+ *
+ * FUNCTION:    Set operation called by tunable_attr_store (i.e. when a
+ *              string is stored into /sys/tunables/<tunable>/autotune).
+ *              "1" makes the corresponding tunable automatically adjustable
+ *              "0" makes the corresponding tunable manually adjustable
+ *
+ * PARAMETERS: count: input buffer size (including the '\0')
+ *
+ * RETURN VALUE: >0: number of characters used from the input buffer
+ *               <= 0: failure
+ */
+ssize_t store_tuning_mode(struct auto_tune *tun_addr, const char *buffer,
+			size_t count)
+{
+	int new_value;
+	int rc;
+
+	if ((rc = sscanf(buffer, "%d", &new_value)) != 1)
+		return -EINVAL;
+
+	if (new_value != AKT_AUTO && new_value != AKT_MANUAL)
+		return -EINVAL;
+
+	if (tun_addr == NULL) {
+		printk(KERN_ERR
+			" store_tuning_mode(): NULL pointer  passed in\n");
+		return -EINVAL;
+	}
+
+	spin_lock(&tun_addr->tunable_lck);
+
+	switch (new_value) {
+	case AKT_AUTO:
+		tun_addr->flags |= AUTO_TUNE_ENABLE;
+		break;
+	case AKT_MANUAL:
+		tun_addr->flags &= ~AUTO_TUNE_ENABLE;
+		break;
+	}
+
+	spin_unlock(&tun_addr->tunable_lck);
+
+	return strnlen(buffer, PAGE_SIZE);
+}
 
 
 EXPORT_SYMBOL_GPL(register_tunable);
Index: linux-2.6.20-rc4/kernel/autotune/akt_sysfs.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.20-rc4/kernel/autotune/akt_sysfs.c	2007-01-15 15:14:55.000000000 +0100
@@ -0,0 +1,214 @@
+/*
+ * linux/kernel/autotune/akt_sysfs.c
+ *
+ * Automatic Kernel Tunables for Linux
+ * sysfs bindings for AKT
+ *
+ * Copyright (C) 2006 Bull S.A.S
+ *
+ * Author: Nadia Derbey <Nadia.Derbey@bull.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+/*
+ * FUNCTIONS:
+ *            tunable_attr_show      (static)
+ *            tunable_attr_store     (static)
+ *            tunable_sysfs_setup
+ *            add_tunable_attrs      (static)
+ *            init_auto_tuning
+ */
+
+
+#include <linux/init.h>
+#include <linux/stat.h>
+#include <linux/module.h>
+#include <linux/akt.h>
+
+
+
+
+struct tunable_attribute {
+	struct attribute attr;
+	ssize_t (*show)(struct auto_tune *, char *);
+	ssize_t (*store)(struct auto_tune *, const char *, size_t);
+};
+
+#define TUNABLE_ATTR(_name, _mode, _show, _store)	\
+struct tunable_attribute tun_attr_##_name = __ATTR(_name, _mode, _show, _store)
+
+
+static TUNABLE_ATTR(autotune, S_IWUSR | S_IRUGO, show_tuning_mode,
+		store_tuning_mode);
+
+static struct tunable_attribute *tunable_sysfs_attrs[] = {
+	&tun_attr_autotune,	/* to (de)activate auto tuning */
+	NULL,
+};
+
+
+
+#define to_tunable_kobj(obj)  container_of(obj, struct tunable_kobject, kobj)
+#define to_tunable(obj)       container_of(obj, struct auto_tune, tun_kobj)
+#define to_tunable_attr(_attr)	\
+	container_of(_attr, struct tunable_attribute, attr)
+
+
+static int add_tunable_attrs(struct auto_tune *);
+
+
+/*
+ * FUNCTION:    show method for the tunables subsystem
+ *              Forwards any read call to the show method of the attribute
+ *              owner
+ *
+ * PARAMETERS:  attr: can be one of
+ *                 . tun_attr_autotune
+ *                 . tun_attr_min
+ *                 . tun_attr_max
+ *
+ * RETURN VALUE: number of bytes printed into the buffer
+ *               <0 if failure
+ */
+static ssize_t tunable_attr_show(struct kobject *kobj,
+				struct attribute *attr,
+				char *buf)
+{
+	struct tunable_attribute *tun_attr = to_tunable_attr(attr);
+	struct tunable_kobject *tkobj = to_tunable_kobj(kobj);
+	struct auto_tune *tunable = to_tunable(tkobj);
+	ssize_t count = -EIO;
+
+	if (tun_attr->show)
+		count = tun_attr->show(tunable, buf);
+	return count;
+}
+
+
+/*
+ * FUNCTION:    store method for the tunables subsystem
+ *              Forwards any write call to the store method of the attribute
+ *              owner
+ *
+ * PARAMETERS: attr: can be one of
+ *                 . tun_attr_autotune
+ *                 . tun_attr_min
+ *                 . tun_attr_max
+ *
+ * RETURN VALUE: number of bytes used from the buffer
+ *               <0 if failure
+ */
+static ssize_t tunable_attr_store(struct kobject *kobj,
+				struct attribute *attr,
+				const char *buf,
+				size_t count)
+{
+	struct tunable_attribute *tun_attr = to_tunable_attr(attr);
+	struct tunable_kobject *tkobj = to_tunable_kobj(kobj);
+	struct auto_tune *tunable = to_tunable(tkobj);
+	ssize_t ret = -EIO;
+
+	if (tun_attr->store)
+		ret = tun_attr->store(tunable, buf, count);
+	return ret;
+}
+
+
+static struct sysfs_ops tunables_sysfs_ops = {
+	.show	= tunable_attr_show,
+	.store	= tunable_attr_store,
+};
+
+
+static struct kobj_type tunables_ktype = {
+	.sysfs_ops	= &tunables_sysfs_ops,
+};
+
+
+decl_subsys(tunables, &tunables_ktype, NULL);
+
+
+/*
+ * FUNCTION:    Registers one tunable into sysfs
+ *              (called by register_tunable())
+ *              The tunable is a kobject with 3 attributes:
+ *                 min (rw): enables to play with the min tunable value
+ *                 max (rw): enables to play with the max tunable value
+ *                 autotune (rw): enables to (de)activate the auto tuning for
+ *                                that tunable
+ *
+ * RETURN VALUE: 0 if tunable has been successfully registered
+ *               <0 else
+ */
+
+#define tunable_kobj(t) t->tun_kobj.kobj
+
+int tunable_sysfs_setup(struct auto_tune *tunable)
+{
+	int err = 0;
+
+	memset(&(tunable_kobj(tunable)), 0, sizeof(tunable_kobj(tunable)));
+	if ((err = kobject_set_name(&(tunable_kobj(tunable)), "%s",
+							tunable->name)))
+		return err;
+
+	kobj_set_kset_s(&(tunable->tun_kobj), tunables_subsys);
+	tunable->tun_kobj.tun = tunable;
+
+	if ((err = kobject_register(&(tunable_kobj(tunable)))))
+		return err;
+
+	if ((err = add_tunable_attrs(tunable)))
+		kobject_unregister(&(tunable_kobj(tunable)));
+
+	return err;
+}
+
+
+/*
+ * FUNCTION:    adds the set of predefined attributes for a tunable being
+ *              registered (called by tunable_sysfs_setup())
+ *
+ * RETURN VALUE: 0 if akt has been successfully registered
+ *               <0 else
+ */
+static int add_tunable_attrs(struct auto_tune *tunable)
+{
+	struct tunable_attribute *attr;
+	int error = 0;
+	int i;
+
+	for (i = 0; (attr = tunable_sysfs_attrs[i]) && !error; i++) {
+		error = sysfs_create_file(&(tunable_kobj(tunable)),
+			&(attr->attr));
+	}
+
+	return error;
+}
+
+
+/*
+ * FUNCTION:    akt subsystem initialization
+ *
+ * RETURN VALUE: 0 always
+ */
+void __init init_auto_tuning(void)
+{
+	int error = subsystem_register(&tunables_subsys);
+
+	if (error)
+		printk(KERN_ERR "Failed registering tunables subsystem\n");
+}

--
