Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130662AbRBLGvi>; Mon, 12 Feb 2001 01:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130738AbRBLGv2>; Mon, 12 Feb 2001 01:51:28 -0500
Received: from nat-hdqt.valinux.com ([198.186.202.17]:62199 "EHLO
	tytlal.z.streaker.org") by vger.kernel.org with ESMTP
	id <S130662AbRBLGvM>; Mon, 12 Feb 2001 01:51:12 -0500
Date: Sun, 11 Feb 2001 22:49:24 -0800
From: Chip Salzenberg <chip@valinux.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] inter_module_* backport to 2.2.18
Message-ID: <20010211224924.A883@valinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The inter_module_* feature of 2.4 is neat ... so neat that tpctl-2.0
actually requires it.  I figured it would be easier to backport the
feature rather than to make tpctl get along without it.  The backport
was quite clean.  Perhaps you'll want to include it in 2.2.19....

Index: include/linux/module.h
--- include/linux/module.h	2000/09/13 15:32:25	1.2
+++ include/linux/module.h	2001/02/12 06:28:27
@@ -9,4 +9,5 @@
 
 #include <linux/config.h>
+#include <linux/list.h>
 
 #ifdef __GENKSYMS__
@@ -148,4 +149,38 @@ static inline unsigned long get_module_s
 extern unsigned long get_module_symbol(char *, char *);
 #endif
+
+/* Generic inter module communication.
+ *
+ * NOTE: This interface is intended for small amounts of data that are
+ *       passed between two objects and either or both of the objects
+ *       might be compiled as modules.  Do not over use this interface.
+ *
+ *       If more than two objects need to communicate then you probably
+ *       need a specific interface instead of abusing this generic
+ *       interface.  If both objects are *always* built into the kernel
+ *       then a global extern variable is good enough, you do not need
+ *       this interface.
+ *
+ * Keith Owens <kaos@ocs.com.au> 28 Oct 2000.
+ */
+
+#ifdef __KERNEL__
+#define HAVE_INTER_MODULE
+extern void inter_module_register(const char *, struct module *, const void *);
+extern void inter_module_unregister(const char *);
+extern const void *inter_module_get(const char *);
+extern const void *inter_module_get_request(const char *, const char *);
+extern void inter_module_put(const char *);
+
+struct inter_module_entry {
+	struct list_head list;
+	const char *im_name;
+	struct module *owner;
+	const void *userdata;
+};
+
+extern int try_inc_mod_count(struct module *mod);
+#endif /* __KERNEL__ */
+
 #if defined(MODULE) && !defined(__GENKSYMS__)
 

Index: kernel/ksyms.c
--- kernel/ksyms.c	2001/01/22 22:40:58	1.5.4.11
+++ kernel/ksyms.c	2001/02/12 06:28:29
@@ -94,4 +94,11 @@ EXPORT_SYMBOL(get_module_symbol);
 EXPORT_SYMBOL(get_options);
 
+EXPORT_SYMBOL(inter_module_register);
+EXPORT_SYMBOL(inter_module_unregister);
+EXPORT_SYMBOL(inter_module_get);
+EXPORT_SYMBOL(inter_module_get_request);
+EXPORT_SYMBOL(inter_module_put);
+EXPORT_SYMBOL(try_inc_mod_count);
+
 /* process memory management */
 EXPORT_SYMBOL(do_mmap);

Index: kernel/module.c
--- kernel/module.c	2000/09/28 08:20:09	1.1.14.1
+++ kernel/module.c	2001/02/12 06:28:32
@@ -2,7 +2,10 @@
 #include <linux/mm.h>
 #include <linux/module.h>
+#include <linux/kmod.h>
 #include <asm/uaccess.h>
+#include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/smp_lock.h>
+#include <linux/spinlock.h>
 #include <asm/pgtable.h>
 #include <linux/init.h>
@@ -52,4 +55,171 @@ static struct module kernel_module =
 struct module *module_list = &kernel_module;
 
+#endif	/* CONFIG_MODULES */
+
+/* inter_module functions are always available, even when the kernel is
+ * compiled without modules.  Consumers of inter_module_xxx routines
+ * will always work, even when both are built into the kernel, this
+ * approach removes lots of #ifdefs in mainline code.
+ */
+
+static struct list_head ime_list = LIST_HEAD_INIT(ime_list);
+static spinlock_t ime_lock = SPIN_LOCK_UNLOCKED;
+static int kmalloc_failed;
+
+/**
+ * inter_module_register - register a new set of inter module data.
+ * @im_name: an arbitrary string to identify the data, must be unique
+ * @owner: module that is registering the data, always use THIS_MODULE
+ * @userdata: pointer to arbitrary userdata to be registered
+ *
+ * Description: Check that the im_name has not already been registered,
+ * complain if it has.  For new data, add it to the inter_module_entry
+ * list.
+ */
+void inter_module_register(const char *im_name, struct module *owner, const void *userdata)
+{
+	struct list_head *tmp;
+	struct inter_module_entry *ime, *ime_new;
+
+	if (!(ime_new = kmalloc(sizeof(*ime), GFP_KERNEL))) {
+		/* Overloaded kernel, not fatal */
+		printk(KERN_ERR
+			"Aiee, inter_module_register: cannot kmalloc entry for '%s'\n",
+			im_name);
+		kmalloc_failed = 1;
+		return;
+	}
+	memset(ime_new, 0, sizeof(*ime_new));
+	ime_new->im_name = im_name;
+	ime_new->owner = owner;
+	ime_new->userdata = userdata;
+
+	spin_lock(&ime_lock);
+	list_for_each(tmp, &ime_list) {
+		ime = list_entry(tmp, struct inter_module_entry, list);
+		if (strcmp(ime->im_name, im_name) == 0) {
+			spin_unlock(&ime_lock);
+			kfree(ime_new);
+			/* Program logic error, fatal */
+			printk(KERN_ERR "inter_module_register: duplicate im_name '%s'", im_name);
+			BUG();
+		}
+	}
+	list_add(&(ime_new->list), &ime_list);
+	spin_unlock(&ime_lock);
+}
+
+/**
+ * inter_module_unregister - unregister a set of inter module data.
+ * @im_name: an arbitrary string to identify the data, must be unique
+ *
+ * Description: Check that the im_name has been registered, complain if
+ * it has not.  For existing data, remove it from the
+ * inter_module_entry list.
+ */
+void inter_module_unregister(const char *im_name)
+{
+	struct list_head *tmp;
+	struct inter_module_entry *ime;
+
+	spin_lock(&ime_lock);
+	list_for_each(tmp, &ime_list) {
+		ime = list_entry(tmp, struct inter_module_entry, list);
+		if (strcmp(ime->im_name, im_name) == 0) {
+			list_del(&(ime->list));
+			spin_unlock(&ime_lock);
+			kfree(ime);
+			return;
+		}
+	}
+	spin_unlock(&ime_lock);
+	if (kmalloc_failed) {
+		printk(KERN_ERR
+			"inter_module_unregister: no entry for '%s', "
+			"probably caused by previous kmalloc failure\n",
+			im_name);
+		return;
+	}
+	else {
+		/* Program logic error, fatal */
+		printk(KERN_ERR "inter_module_unregister: no entry for '%s'", im_name);
+		BUG();
+	}
+}
+
+/**
+ * inter_module_get - return arbitrary userdata from another module.
+ * @im_name: an arbitrary string to identify the data, must be unique
+ *
+ * Description: If the im_name has not been registered, return NULL.
+ * Try to increment the use count on the owning module, if that fails
+ * then return NULL.  Otherwise return the userdata.
+ */
+const void *inter_module_get(const char *im_name)
+{
+	struct list_head *tmp;
+	struct inter_module_entry *ime;
+	const void *result = NULL;
+
+	spin_lock(&ime_lock);
+	list_for_each(tmp, &ime_list) {
+		ime = list_entry(tmp, struct inter_module_entry, list);
+		if (strcmp(ime->im_name, im_name) == 0) {
+			if (try_inc_mod_count(ime->owner))
+				result = ime->userdata;
+			break;
+		}
+	}
+	spin_unlock(&ime_lock);
+	return(result);
+}
+
+/**
+ * inter_module_get_request - im get with automatic request_module.
+ * @im_name: an arbitrary string to identify the data, must be unique
+ * @modname: module that is expected to register im_name
+ *
+ * Description: If inter_module_get fails, do request_module then retry.
+ */
+const void *inter_module_get_request(const char *im_name, const char *modname)
+{
+	const void *result = inter_module_get(im_name);
+	if (!result) {
+		request_module(modname);
+		result = inter_module_get(im_name);
+	}
+	return(result);
+}
+
+/**
+ * inter_module_put - release use of data from another module.
+ * @im_name: an arbitrary string to identify the data, must be unique
+ *
+ * Description: If the im_name has not been registered, complain,
+ * otherwise decrement the use count on the owning module.
+ */
+void inter_module_put(const char *im_name)
+{
+	struct list_head *tmp;
+	struct inter_module_entry *ime;
+
+	spin_lock(&ime_lock);
+	list_for_each(tmp, &ime_list) {
+		ime = list_entry(tmp, struct inter_module_entry, list);
+		if (strcmp(ime->im_name, im_name) == 0) {
+			if (ime->owner)
+				__MOD_DEC_USE_COUNT(ime->owner);
+			spin_unlock(&ime_lock);
+			return;
+		}
+	}
+	spin_unlock(&ime_lock);
+	printk(KERN_ERR "inter_module_put: no entry for '%s'", im_name);
+	BUG();
+}
+
+
+#if defined(CONFIG_MODULES)	/* The rest of the source */
+
 static long get_mod_name(const char *user_name, char **buf);
 static void put_mod_name(char *buf);
@@ -368,4 +538,19 @@ err0:
 }
 
+static spinlock_t unload_lock = SPIN_LOCK_UNLOCKED;
+int try_inc_mod_count(struct module *mod)
+{
+	int res = 1;
+	if (mod) {
+		spin_lock(&unload_lock);
+		if (mod->flags & MOD_DELETED)
+			res = 0;
+		else
+			__MOD_INC_USE_COUNT(mod);
+		spin_unlock(&unload_lock);
+	}
+	return res;
+}
+
 asmlinkage int
 sys_delete_module(const char *name_user)
@@ -1039,4 +1224,9 @@ sys_get_kernel_syms(struct kernel_sym *t
 {
 	return -ENOSYS;
+}
+
+int try_inc_mod_count(struct module *mod)
+{
+	return 1;
 }
 

-- 
Chip Salzenberg            - a.k.a. -            <chip@valinux.com>
   "Give me immortality, or give me death!"  // Firesign Theatre
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
