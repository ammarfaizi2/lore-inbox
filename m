Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263046AbVCQLoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263046AbVCQLoL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 06:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263075AbVCQLno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 06:43:44 -0500
Received: from ozlabs.org ([203.10.76.45]:26261 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263052AbVCQKls (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 05:41:48 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16953.24354.930568.741311@cargo.ozlabs.ibm.com>
Date: Thu, 17 Mar 2005 21:42:42 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: Nathan Lynch <ntl@pobox.com>, anton@samba.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] PPC64 introduce pSeries_reconfig.[ch]
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move as much pSeries-specific DLPAR/hotplug code as possible into its
own file, which is built only when pSeries support is enabled in the
config.  This new file is intended to contain support code for the
"Dynamic Reconfiguration" option in the RISC Platform Architecture,
which encompasses both PCI hotplug and dynamic logical partitioning
(DLPAR).

This patch mostly just moves code around, but the device node addition
and removal API is slightly modified.  In this way, of_add_node and
of_remove_node are now responsible only for safely updating the device
tree and global list, without all the other stuff like proc entries
etc.  of_add_node and of_remove_node have been renamed to
of_attach_node and of_detach_node, respectively.

This also adds the definitions and api for a notifier chain which is
meant to be used by code that must act upon device node addition or
removal.  Patches to migrate code to the notifier api follow in this
series.

Signed-off-by: Nathan Lynch <ntl@pobox.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

 arch/ppc64/kernel/Makefile           |    2 
 arch/ppc64/kernel/pSeries_reconfig.c |  446 +++++++++++++++
 arch/ppc64/kernel/proc_ppc64.c       |  249 --------
 arch/ppc64/kernel/prom.c             |  156 -----
 include/asm-ppc64/pSeries_reconfig.h |   25 
 include/asm-ppc64/prom.h             |    4 
 6 files changed, 487 insertions(+), 395 deletions(-)

Index: linux-2.6.11-bk10/arch/ppc64/kernel/Makefile
===================================================================
--- linux-2.6.11-bk10.orig/arch/ppc64/kernel/Makefile	2005-03-14 21:28:14.000000000 +0000
+++ linux-2.6.11-bk10/arch/ppc64/kernel/Makefile	2005-03-14 22:06:42.000000000 +0000
@@ -31,7 +31,7 @@ obj-$(CONFIG_PPC_ISERIES) += iSeries_irq
 obj-$(CONFIG_PPC_MULTIPLATFORM) += nvram.o i8259.o prom_init.o prom.o mpic.o
 
 obj-$(CONFIG_PPC_PSERIES) += pSeries_pci.o pSeries_lpar.o pSeries_hvCall.o \
-			     pSeries_nvram.o rtasd.o ras.o \
+			     pSeries_nvram.o rtasd.o ras.o pSeries_reconfig.o \
 			     xics.o rtas.o pSeries_setup.o pSeries_iommu.o
 
 obj-$(CONFIG_EEH)		+= eeh.o
Index: linux-2.6.11-bk10/arch/ppc64/kernel/proc_ppc64.c
===================================================================
--- linux-2.6.11-bk10.orig/arch/ppc64/kernel/proc_ppc64.c	2005-03-14 21:28:14.000000000 +0000
+++ linux-2.6.11-bk10/arch/ppc64/kernel/proc_ppc64.c	2005-03-14 22:06:42.000000000 +0000
@@ -41,20 +41,6 @@ static struct file_operations page_map_f
 	.mmap	= page_map_mmap
 };
 
-#ifdef CONFIG_PPC_PSERIES
-/* routines for /proc/ppc64/ofdt */
-static ssize_t ofdt_write(struct file *, const char __user *, size_t, loff_t *);
-static void proc_ppc64_create_ofdt(void);
-static int do_remove_node(char *);
-static int do_add_node(char *, size_t);
-static void release_prop_list(const struct property *);
-static struct property *new_property(const char *, const int, const unsigned char *, struct property *);
-static char * parse_next_property(char *, char *, char **, int *, unsigned char**);
-static struct file_operations ofdt_fops = {
-	.write = ofdt_write
-};
-#endif
-
 /*
  * Create the ppc64 and ppc64/rtas directories early. This allows us to
  * assume that they have been previously created in drivers.
@@ -92,11 +78,6 @@ static int __init proc_ppc64_init(void)
 	pde->size = PAGE_SIZE;
 	pde->proc_fops = &page_map_fops;
 
-#ifdef CONFIG_PPC_PSERIES
-	if ((systemcfg->platform & PLATFORM_PSERIES))
-		proc_ppc64_create_ofdt();
-#endif
-
 	return 0;
 }
 __initcall(proc_ppc64_init);
@@ -145,233 +126,3 @@ static int page_map_mmap( struct file *f
 	return 0;
 }
 
-#ifdef CONFIG_PPC_PSERIES
-/* create /proc/ppc64/ofdt write-only by root */
-static void proc_ppc64_create_ofdt(void)
-{
-	struct proc_dir_entry *ent;
-
-	ent = create_proc_entry("ppc64/ofdt", S_IWUSR, NULL);
-	if (ent) {
-		ent->nlink = 1;
-		ent->data = NULL;
-		ent->size = 0;
-		ent->proc_fops = &ofdt_fops;
-	}
-}
-
-/**
- * ofdt_write - perform operations on the Open Firmware device tree
- *
- * @file: not used
- * @buf: command and arguments
- * @count: size of the command buffer
- * @off: not used
- *
- * Operations supported at this time are addition and removal of
- * whole nodes along with their properties.  Operations on individual
- * properties are not implemented (yet).
- */
-static ssize_t ofdt_write(struct file *file, const char __user *buf, size_t count,
-			  loff_t *off)
-{
-	int rv = 0;
-	char *kbuf;
-	char *tmp;
-
-	if (!(kbuf = kmalloc(count + 1, GFP_KERNEL))) {
-		rv = -ENOMEM;
-		goto out;
-	}
-	if (copy_from_user(kbuf, buf, count)) {
-		rv = -EFAULT;
-		goto out;
-	}
-
-	kbuf[count] = '\0';
-
-	tmp = strchr(kbuf, ' ');
-	if (!tmp) {
-		rv = -EINVAL;
-		goto out;
-	}
-	*tmp = '\0';
-	tmp++;
-
-	if (!strcmp(kbuf, "add_node"))
-		rv = do_add_node(tmp, count - (tmp - kbuf));
-	else if (!strcmp(kbuf, "remove_node"))
-		rv = do_remove_node(tmp);
-	else
-		rv = -EINVAL;
-out:
-	kfree(kbuf);
-	return rv ? rv : count;
-}
-
-static int do_remove_node(char *buf)
-{
-	struct device_node *node;
-	int rv = -ENODEV;
-
-	if ((node = of_find_node_by_path(buf)))
-		rv = of_remove_node(node);
-
-	of_node_put(node);
-	return rv;
-}
-
-static int do_add_node(char *buf, size_t bufsize)
-{
-	char *path, *end, *name;
-	struct device_node *np;
-	struct property *prop = NULL;
-	unsigned char* value;
-	int length, rv = 0;
-
-	end = buf + bufsize;
-	path = buf;
-	buf = strchr(buf, ' ');
-	if (!buf)
-		return -EINVAL;
-	*buf = '\0';
-	buf++;
-
-	if ((np = of_find_node_by_path(path))) {
-		of_node_put(np);
-		return -EINVAL;
-	}
-
-	/* rv = build_prop_list(tmp, bufsize - (tmp - buf), &proplist); */
-	while (buf < end &&
-	       (buf = parse_next_property(buf, end, &name, &length, &value))) {
-		struct property *last = prop;
-
-		prop = new_property(name, length, value, last);
-		if (!prop) {
-			rv = -ENOMEM;
-			prop = last;
-			goto out;
-		}
-	}
-	if (!buf) {
-		rv = -EINVAL;
-		goto out;
-	}
-
-	rv = of_add_node(path, prop);
-
-out:
-	if (rv)
-		release_prop_list(prop);
-	return rv;
-}
-
-static struct property *new_property(const char *name, const int length,
-				     const unsigned char *value, struct property *last)
-{
-	struct property *new = kmalloc(sizeof(*new), GFP_KERNEL);
-
-	if (!new)
-		return NULL;
-	memset(new, 0, sizeof(*new));
-
-	if (!(new->name = kmalloc(strlen(name) + 1, GFP_KERNEL)))
-		goto cleanup;
-	if (!(new->value = kmalloc(length + 1, GFP_KERNEL)))
-		goto cleanup;
-
-	strcpy(new->name, name);
-	memcpy(new->value, value, length);
-	*(((char *)new->value) + length) = 0;
-	new->length = length;
-	new->next = last;
-	return new;
-
-cleanup:
-	if (new->name)
-		kfree(new->name);
-	if (new->value)
-		kfree(new->value);
-	kfree(new);
-	return NULL;
-}
-
-/**
- * parse_next_property - process the next property from raw input buffer
- * @buf: input buffer, must be nul-terminated
- * @end: end of the input buffer + 1, for validation
- * @name: return value; set to property name in buf
- * @length: return value; set to length of value
- * @value: return value; set to the property value in buf
- *
- * Note that the caller must make copies of the name and value returned,
- * this function does no allocation or copying of the data.  Return value
- * is set to the next name in buf, or NULL on error.
- */
-static char * parse_next_property(char *buf, char *end, char **name, int *length,
-				  unsigned char **value)
-{
-	char *tmp;
-
-	*name = buf;
-
-	tmp = strchr(buf, ' ');
-	if (!tmp) {
-		printk(KERN_ERR "property parse failed in %s at line %d\n",
-		       __FUNCTION__, __LINE__);
-		return NULL;
-	}
-	*tmp = '\0';
-
-	if (++tmp >= end) {
-		printk(KERN_ERR "property parse failed in %s at line %d\n",
-		       __FUNCTION__, __LINE__);
-		return NULL;
-	}
-
-	/* now we're on the length */
-	*length = -1;
-	*length = simple_strtoul(tmp, &tmp, 10);
-	if (*length == -1) {
-		printk(KERN_ERR "property parse failed in %s at line %d\n", 
-		       __FUNCTION__, __LINE__);
-		return NULL;
-	}
-	if (*tmp != ' ' || ++tmp >= end) {
-		printk(KERN_ERR "property parse failed in %s at line %d\n",
-		       __FUNCTION__, __LINE__);
-		return NULL;
-	}
-
-	/* now we're on the value */
-	*value = tmp;
-	tmp += *length;
-	if (tmp > end) {
-		printk(KERN_ERR "property parse failed in %s at line %d\n",
-		       __FUNCTION__, __LINE__);
-		return NULL;
-	}
-	else if (tmp < end && *tmp != ' ' && *tmp != '\0') {
-		printk(KERN_ERR "property parse failed in %s at line %d\n",
-		       __FUNCTION__, __LINE__);
-		return NULL;
-	}
-	tmp++;
-
-	/* and now we should be on the next name, or the end */
-	return tmp;
-}
-
-static void release_prop_list(const struct property *prop)
-{
-	struct property *next;
-	for (; prop; prop = next) {
-		next = prop->next;
-		kfree(prop->name);
-		kfree(prop->value);
-		kfree(prop);
-	}
-
-}
-#endif	/* defined(CONFIG_PPC_PSERIES) */
Index: linux-2.6.11-bk10/arch/ppc64/kernel/pSeries_reconfig.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.11-bk10/arch/ppc64/kernel/pSeries_reconfig.c	2005-03-14 22:16:09.000000000 +0000
@@ -0,0 +1,446 @@
+/*
+ * pSeries_reconfig.c - support for dynamic reconfiguration (including PCI
+ * Hotplug and Dynamic Logical Partitioning on RPA platforms).
+ *
+ * Copyright (C) 2005 Nathan Lynch
+ * Copyright (C) 2005 IBM Corporation
+ *
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License version
+ *	2 as published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/kref.h>
+#include <linux/notifier.h>
+#include <linux/proc_fs.h>
+
+#include <asm/prom.h>
+#include <asm/pSeries_reconfig.h>
+#include <asm/uaccess.h>
+
+
+
+/*
+ * Routines for "runtime" addition and removal of device tree nodes.
+ */
+#ifdef CONFIG_PROC_DEVICETREE
+/*
+ * Add a node to /proc/device-tree.
+ */
+static void add_node_proc_entries(struct device_node *np)
+{
+	struct proc_dir_entry *ent;
+
+	ent = proc_mkdir(strrchr(np->full_name, '/') + 1, np->parent->pde);
+	if (ent)
+		proc_device_tree_add_node(np, ent);
+}
+
+static void remove_node_proc_entries(struct device_node *np)
+{
+	struct property *pp = np->properties;
+	struct device_node *parent = np->parent;
+
+	while (pp) {
+		remove_proc_entry(pp->name, np->pde);
+		pp = pp->next;
+	}
+
+	/* Assuming that symlinks have the same parent directory as
+	 * np->pde.
+	 */
+	if (np->name_link)
+		remove_proc_entry(np->name_link->name, parent->pde);
+	if (np->addr_link)
+		remove_proc_entry(np->addr_link->name, parent->pde);
+	if (np->pde)
+		remove_proc_entry(np->pde->name, parent->pde);
+}
+#else /* !CONFIG_PROC_DEVICETREE */
+static void add_node_proc_entries(struct device_node *np)
+{
+	return;
+}
+
+static void remove_node_proc_entries(struct device_node *np)
+{
+	return;
+}
+#endif /* CONFIG_PROC_DEVICETREE */
+
+/**
+ *	derive_parent - basically like dirname(1)
+ *	@path:  the full_name of a node to be added to the tree
+ *
+ *	Returns the node which should be the parent of the node
+ *	described by path.  E.g., for path = "/foo/bar", returns
+ *	the node with full_name = "/foo".
+ */
+static struct device_node *derive_parent(const char *path)
+{
+	struct device_node *parent = NULL;
+	char *parent_path = "/";
+	size_t parent_path_len = strrchr(path, '/') - path + 1;
+
+	/* reject if path is "/" */
+	if (!strcmp(path, "/"))
+		return ERR_PTR(-EINVAL);
+
+	if (strrchr(path, '/') != path) {
+		parent_path = kmalloc(parent_path_len, GFP_KERNEL);
+		if (!parent_path)
+			return ERR_PTR(-ENOMEM);
+		strlcpy(parent_path, path, parent_path_len);
+	}
+	parent = of_find_node_by_path(parent_path);
+	if (!parent)
+		return ERR_PTR(-EINVAL);
+	if (strcmp(parent_path, "/"))
+		kfree(parent_path);
+	return parent;
+}
+
+static struct notifier_block *pSeries_reconfig_chain;
+
+int pSeries_reconfig_notifier_register(struct notifier_block *nb)
+{
+	return notifier_chain_register(&pSeries_reconfig_chain, nb);
+}
+
+void pSeries_reconfig_notifier_unregister(struct notifier_block *nb)
+{
+	notifier_chain_unregister(&pSeries_reconfig_chain, nb);
+}
+
+static int pSeries_reconfig_add_node(const char *path, struct property *proplist)
+{
+	struct device_node *np;
+	int err = -ENOMEM;
+
+	np = kcalloc(1, sizeof(*np), GFP_KERNEL);
+	if (!np)
+		goto out_err;
+
+	np->full_name = kmalloc(strlen(path) + 1, GFP_KERNEL);
+	if (!np->full_name)
+		goto out_err;
+
+	strcpy(np->full_name, path);
+
+	np->properties = proplist;
+	OF_MARK_DYNAMIC(np);
+	kref_init(&np->kref);
+
+	np->parent = derive_parent(path);
+	if (IS_ERR(np->parent)) {
+		err = PTR_ERR(np->parent);
+		goto out_err;
+	}
+
+	err = notifier_call_chain(&pSeries_reconfig_chain,
+				  PSERIES_RECONFIG_ADD, np);
+	if (err == NOTIFY_BAD) {
+		printk(KERN_ERR "Failed to add device node %s\n", path);
+		err = -ENOMEM; /* For now, safe to assume kmalloc failure */
+		goto out_err;
+	}
+
+	of_attach_node(np);
+
+	add_node_proc_entries(np);
+
+	of_node_put(np->parent);
+
+	return 0;
+
+out_err:
+	if (np) {
+		of_node_put(np->parent);
+		kfree(np->full_name);
+		kfree(np);
+	}
+	return err;
+}
+
+/*
+ * Prepare an OF node for removal from system
+ * XXX move this to pSeries_iommu.c
+ */
+static void of_cleanup_node(struct device_node *np)
+{
+	if (np->iommu_table && get_property(np, "ibm,dma-window", NULL))
+		iommu_free_table(np);
+}
+
+static int pSeries_reconfig_remove_node(struct device_node *np)
+{
+	struct device_node *parent, *child;
+
+	parent = of_get_parent(np);
+	if (!parent)
+		return -EINVAL;
+
+	if ((child = of_get_next_child(np, NULL))) {
+		of_node_put(child);
+		return -EBUSY;
+	}
+
+	of_cleanup_node(np);
+
+	remove_node_proc_entries(np);
+
+	notifier_call_chain(&pSeries_reconfig_chain,
+			    PSERIES_RECONFIG_REMOVE, np);
+	of_detach_node(np);
+
+	of_node_put(parent);
+	of_node_put(np); /* Must decrement the refcount */
+	return 0;
+}
+
+/*
+ * /proc/ppc64/ofdt - yucky binary interface for adding and removing
+ * OF device nodes.  Should be deprecated as soon as we get an
+ * in-kernel wrapper for the RTAS ibm,configure-connector call.
+ */
+
+static void release_prop_list(const struct property *prop)
+{
+	struct property *next;
+	for (; prop; prop = next) {
+		next = prop->next;
+		kfree(prop->name);
+		kfree(prop->value);
+		kfree(prop);
+	}
+
+}
+
+/**
+ * parse_next_property - process the next property from raw input buffer
+ * @buf: input buffer, must be nul-terminated
+ * @end: end of the input buffer + 1, for validation
+ * @name: return value; set to property name in buf
+ * @length: return value; set to length of value
+ * @value: return value; set to the property value in buf
+ *
+ * Note that the caller must make copies of the name and value returned,
+ * this function does no allocation or copying of the data.  Return value
+ * is set to the next name in buf, or NULL on error.
+ */
+static char * parse_next_property(char *buf, char *end, char **name, int *length,
+				  unsigned char **value)
+{
+	char *tmp;
+
+	*name = buf;
+
+	tmp = strchr(buf, ' ');
+	if (!tmp) {
+		printk(KERN_ERR "property parse failed in %s at line %d\n",
+		       __FUNCTION__, __LINE__);
+		return NULL;
+	}
+	*tmp = '\0';
+
+	if (++tmp >= end) {
+		printk(KERN_ERR "property parse failed in %s at line %d\n",
+		       __FUNCTION__, __LINE__);
+		return NULL;
+	}
+
+	/* now we're on the length */
+	*length = -1;
+	*length = simple_strtoul(tmp, &tmp, 10);
+	if (*length == -1) {
+		printk(KERN_ERR "property parse failed in %s at line %d\n", 
+		       __FUNCTION__, __LINE__);
+		return NULL;
+	}
+	if (*tmp != ' ' || ++tmp >= end) {
+		printk(KERN_ERR "property parse failed in %s at line %d\n",
+		       __FUNCTION__, __LINE__);
+		return NULL;
+	}
+
+	/* now we're on the value */
+	*value = tmp;
+	tmp += *length;
+	if (tmp > end) {
+		printk(KERN_ERR "property parse failed in %s at line %d\n",
+		       __FUNCTION__, __LINE__);
+		return NULL;
+	}
+	else if (tmp < end && *tmp != ' ' && *tmp != '\0') {
+		printk(KERN_ERR "property parse failed in %s at line %d\n",
+		       __FUNCTION__, __LINE__);
+		return NULL;
+	}
+	tmp++;
+
+	/* and now we should be on the next name, or the end */
+	return tmp;
+}
+
+static struct property *new_property(const char *name, const int length,
+				     const unsigned char *value, struct property *last)
+{
+	struct property *new = kmalloc(sizeof(*new), GFP_KERNEL);
+
+	if (!new)
+		return NULL;
+	memset(new, 0, sizeof(*new));
+
+	if (!(new->name = kmalloc(strlen(name) + 1, GFP_KERNEL)))
+		goto cleanup;
+	if (!(new->value = kmalloc(length + 1, GFP_KERNEL)))
+		goto cleanup;
+
+	strcpy(new->name, name);
+	memcpy(new->value, value, length);
+	*(((char *)new->value) + length) = 0;
+	new->length = length;
+	new->next = last;
+	return new;
+
+cleanup:
+	if (new->name)
+		kfree(new->name);
+	if (new->value)
+		kfree(new->value);
+	kfree(new);
+	return NULL;
+}
+
+static int do_add_node(char *buf, size_t bufsize)
+{
+	char *path, *end, *name;
+	struct device_node *np;
+	struct property *prop = NULL;
+	unsigned char* value;
+	int length, rv = 0;
+
+	end = buf + bufsize;
+	path = buf;
+	buf = strchr(buf, ' ');
+	if (!buf)
+		return -EINVAL;
+	*buf = '\0';
+	buf++;
+
+	if ((np = of_find_node_by_path(path))) {
+		of_node_put(np);
+		return -EINVAL;
+	}
+
+	/* rv = build_prop_list(tmp, bufsize - (tmp - buf), &proplist); */
+	while (buf < end &&
+	       (buf = parse_next_property(buf, end, &name, &length, &value))) {
+		struct property *last = prop;
+
+		prop = new_property(name, length, value, last);
+		if (!prop) {
+			rv = -ENOMEM;
+			prop = last;
+			goto out;
+		}
+	}
+	if (!buf) {
+		rv = -EINVAL;
+		goto out;
+	}
+
+	rv = pSeries_reconfig_add_node(path, prop);
+
+out:
+	if (rv)
+		release_prop_list(prop);
+	return rv;
+}
+
+static int do_remove_node(char *buf)
+{
+	struct device_node *node;
+	int rv = -ENODEV;
+
+	if ((node = of_find_node_by_path(buf)))
+		rv = pSeries_reconfig_remove_node(node);
+
+	of_node_put(node);
+	return rv;
+}
+
+/**
+ * ofdt_write - perform operations on the Open Firmware device tree
+ *
+ * @file: not used
+ * @buf: command and arguments
+ * @count: size of the command buffer
+ * @off: not used
+ *
+ * Operations supported at this time are addition and removal of
+ * whole nodes along with their properties.  Operations on individual
+ * properties are not implemented (yet).
+ */
+static ssize_t ofdt_write(struct file *file, const char __user *buf, size_t count,
+			  loff_t *off)
+{
+	int rv = 0;
+	char *kbuf;
+	char *tmp;
+
+	if (!(kbuf = kmalloc(count + 1, GFP_KERNEL))) {
+		rv = -ENOMEM;
+		goto out;
+	}
+	if (copy_from_user(kbuf, buf, count)) {
+		rv = -EFAULT;
+		goto out;
+	}
+
+	kbuf[count] = '\0';
+
+	tmp = strchr(kbuf, ' ');
+	if (!tmp) {
+		rv = -EINVAL;
+		goto out;
+	}
+	*tmp = '\0';
+	tmp++;
+
+	if (!strcmp(kbuf, "add_node"))
+		rv = do_add_node(tmp, count - (tmp - kbuf));
+	else if (!strcmp(kbuf, "remove_node"))
+		rv = do_remove_node(tmp);
+	else
+		rv = -EINVAL;
+out:
+	kfree(kbuf);
+	return rv ? rv : count;
+}
+
+static struct file_operations ofdt_fops = {
+	.write = ofdt_write
+};
+
+/* create /proc/ppc64/ofdt write-only by root */
+static int proc_ppc64_create_ofdt(void)
+{
+	struct proc_dir_entry *ent;
+
+	if (!(systemcfg->platform & PLATFORM_PSERIES))
+		return 0;
+
+	ent = create_proc_entry("ppc64/ofdt", S_IWUSR, NULL);
+	if (ent) {
+		ent->nlink = 1;
+		ent->data = NULL;
+		ent->size = 0;
+		ent->proc_fops = &ofdt_fops;
+	}
+
+	return 0;
+}
+__initcall(proc_ppc64_create_ofdt);
Index: linux-2.6.11-bk10/arch/ppc64/kernel/prom.c
===================================================================
--- linux-2.6.11-bk10.orig/arch/ppc64/kernel/prom.c	2005-03-14 21:54:08.000000000 +0000
+++ linux-2.6.11-bk10/arch/ppc64/kernel/prom.c	2005-03-14 22:15:45.000000000 +0000
@@ -27,7 +27,6 @@
 #include <linux/spinlock.h>
 #include <linux/types.h>
 #include <linux/pci.h>
-#include <linux/proc_fs.h>
 #include <linux/stringify.h>
 #include <linux/delay.h>
 #include <linux/initrd.h>
@@ -1575,84 +1574,6 @@ void of_node_put(struct device_node *nod
 }
 EXPORT_SYMBOL(of_node_put);
 
-/**
- *	derive_parent - basically like dirname(1)
- *	@path:  the full_name of a node to be added to the tree
- *
- *	Returns the node which should be the parent of the node
- *	described by path.  E.g., for path = "/foo/bar", returns
- *	the node with full_name = "/foo".
- */
-static struct device_node *derive_parent(const char *path)
-{
-	struct device_node *parent = NULL;
-	char *parent_path = "/";
-	size_t parent_path_len = strrchr(path, '/') - path + 1;
-
-	/* reject if path is "/" */
-	if (!strcmp(path, "/"))
-		return NULL;
-
-	if (strrchr(path, '/') != path) {
-		parent_path = kmalloc(parent_path_len, GFP_KERNEL);
-		if (!parent_path)
-			return NULL;
-		strlcpy(parent_path, path, parent_path_len);
-	}
-	parent = of_find_node_by_path(parent_path);
-	if (strcmp(parent_path, "/"))
-		kfree(parent_path);
-	return parent;
-}
-
-/*
- * Routines for "runtime" addition and removal of device tree nodes.
- */
-#ifdef CONFIG_PROC_DEVICETREE
-/*
- * Add a node to /proc/device-tree.
- */
-static void add_node_proc_entries(struct device_node *np)
-{
-	struct proc_dir_entry *ent;
-
-	ent = proc_mkdir(strrchr(np->full_name, '/') + 1, np->parent->pde);
-	if (ent)
-		proc_device_tree_add_node(np, ent);
-}
-
-static void remove_node_proc_entries(struct device_node *np)
-{
-	struct property *pp = np->properties;
-	struct device_node *parent = np->parent;
-
-	while (pp) {
-		remove_proc_entry(pp->name, np->pde);
-		pp = pp->next;
-	}
-
-	/* Assuming that symlinks have the same parent directory as
-	 * np->pde.
-	 */
-	if (np->name_link)
-		remove_proc_entry(np->name_link->name, parent->pde);
-	if (np->addr_link)
-		remove_proc_entry(np->addr_link->name, parent->pde);
-	if (np->pde)
-		remove_proc_entry(np->pde->name, parent->pde);
-}
-#else /* !CONFIG_PROC_DEVICETREE */
-static void add_node_proc_entries(struct device_node *np)
-{
-	return;
-}
-
-static void remove_node_proc_entries(struct device_node *np)
-{
-	return;
-}
-#endif /* CONFIG_PROC_DEVICETREE */
-
 /*
  * Fix up the uninitialized fields in a new device node:
  * name, type, n_addrs, addrs, n_intrs, intrs, and pci-specific fields
@@ -1710,43 +1631,18 @@ out:
 }
 
 /*
- * Given a path and a property list, construct an OF device node, add
- * it to the device tree and global list, and place it in
- * /proc/device-tree.  This function may sleep.
+ * Plug a device node into the tree and global list.
  */
-int of_add_node(const char *path, struct property *proplist)
+void of_attach_node(struct device_node *np)
 {
-	struct device_node *np;
-	int err = 0;
-
-	np = kmalloc(sizeof(struct device_node), GFP_KERNEL);
-	if (!np)
-		return -ENOMEM;
-
-	memset(np, 0, sizeof(*np));
-
-	np->full_name = kmalloc(strlen(path) + 1, GFP_KERNEL);
-	if (!np->full_name) {
-		kfree(np);
-		return -ENOMEM;
-	}
-	strcpy(np->full_name, path);
-
-	np->properties = proplist;
-	OF_MARK_DYNAMIC(np);
-	kref_init(&np->kref);
-	of_node_get(np);
-	np->parent = derive_parent(path);
-	if (!np->parent) {
-		kfree(np);
-		return -EINVAL; /* could also be ENOMEM, though */
-	}
+	int err;
 
+	/* This use of finish_node will be moved to a notifier so
+	 * the error code can be used.
+	 */
 	err = finish_node(np, NULL, of_finish_dynamic_node, 0, 0, 0);
-	if (err < 0) {
-		kfree(np);
-		return err;
-	}
+	if (err < 0)
+		return;
 
 	write_lock(&devtree_lock);
 	np->sibling = np->parent->child;
@@ -1754,21 +1650,6 @@ int of_add_node(const char *path, struct
 	np->parent->child = np;
 	allnodes = np;
 	write_unlock(&devtree_lock);
-
-	add_node_proc_entries(np);
-
-	of_node_put(np->parent);
-	of_node_put(np);
-	return 0;
-}
-
-/*
- * Prepare an OF node for removal from system
- */
-static void of_cleanup_node(struct device_node *np)
-{
-	if (np->iommu_table && get_property(np, "ibm,dma-window", NULL))
-		iommu_free_table(np);
 }
 
 /*
@@ -1776,23 +1657,14 @@ static void of_cleanup_node(struct devic
  * a reference to the node.  The memory associated with the node
  * is not freed until its refcount goes to zero.
  */
-int of_remove_node(struct device_node *np)
+void of_detach_node(const struct device_node *np)
 {
-	struct device_node *parent, *child;
+	struct device_node *parent;
 
-	parent = of_get_parent(np);
-	if (!parent)
-		return -EINVAL;
-
-	if ((child = of_get_next_child(np, NULL))) {
-		of_node_put(child);
-		return -EBUSY;
-	}
+	write_lock(&devtree_lock);
 
-	of_cleanup_node(np);
+	parent = np->parent;
 
-	write_lock(&devtree_lock);
-	remove_node_proc_entries(np);
 	if (allnodes == np)
 		allnodes = np->allnext;
 	else {
@@ -1814,10 +1686,8 @@ int of_remove_node(struct device_node *n
 			;
 		prevsib->sibling = np->sibling;
 	}
+
 	write_unlock(&devtree_lock);
-	of_node_put(parent);
-	of_node_put(np); /* Must decrement the refcount */
-	return 0;
 }
 
 /*
Index: linux-2.6.11-bk10/include/asm-ppc64/prom.h
===================================================================
--- linux-2.6.11-bk10.orig/include/asm-ppc64/prom.h	2005-03-14 21:28:20.000000000 +0000
+++ linux-2.6.11-bk10/include/asm-ppc64/prom.h	2005-03-14 22:15:17.000000000 +0000
@@ -209,8 +209,8 @@ extern struct device_node *of_node_get(s
 extern void of_node_put(struct device_node *node);
 
 /* For updating the device tree at runtime */
-extern int of_add_node(const char *path, struct property *proplist);
-extern int of_remove_node(struct device_node *np);
+extern void of_attach_node(struct device_node *);
+extern void of_detach_node(const struct device_node *);
 
 /* Other Prototypes */
 extern unsigned long prom_init(unsigned long, unsigned long, unsigned long,
Index: linux-2.6.11-bk10/include/asm-ppc64/pSeries_reconfig.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.11-bk10/include/asm-ppc64/pSeries_reconfig.h	2005-03-14 22:06:42.000000000 +0000
@@ -0,0 +1,25 @@
+#ifndef _PPC64_PSERIES_RECONFIG_H
+#define _PPC64_PSERIES_RECONFIG_H
+
+#include <linux/notifier.h>
+
+/*
+ * Use this API if your code needs to know about OF device nodes being
+ * added or removed on pSeries systems.
+ */
+
+#define PSERIES_RECONFIG_ADD    0x0001
+#define PSERIES_RECONFIG_REMOVE 0x0002
+
+#ifdef CONFIG_PPC_PSERIES
+extern int pSeries_reconfig_notifier_register(struct notifier_block *);
+extern void pSeries_reconfig_notifier_unregister(struct notifier_block *);
+#else /* !CONFIG_PPC_PSERIES */
+static inline int pSeries_reconfig_notifier_register(struct notifier_block *nb)
+{
+	return 0;
+}
+static inline void pSeries_reconfig_notifier_unregister(struct notifier_block *nb) { }
+#endif /* CONFIG_PPC_PSERIES */
+
+#endif /* _PPC64_PSERIES_RECONFIG_H */
