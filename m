Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264497AbTIJDup (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 23:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264504AbTIJDup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 23:50:45 -0400
Received: from dp.samba.org ([66.70.73.150]:59853 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264497AbTIJDui (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 23:50:38 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] add kobject to struct module 
In-reply-to: Your message of "Tue, 09 Sep 2003 15:24:21 MST."
             <20030909222421.GA7703@kroah.com> 
Date: Wed, 10 Sep 2003 13:31:02 +1000
Message-Id: <20030910035038.3BE5E2C013@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030909222421.GA7703@kroah.com> you write:
> Hi,
> 
> A while ago we had talked about adding a kobject to struct module.  By
> doing this we add support for module paramaters and other module info to
> be exported in sysfs.  So here's a patch that does this that is against
> 2.6.0-test4 (it applies with some fuzz, sorry.)

I'd just started on the same thing, but I'll use yours as a bae.

> I used the kobject reference count to add to the module reference count
> to handle races if a user has a module owned sysfs file open, but this
> reference is not exported to userspace, as that just confuses the
> userspace tools a bunch (and I don't want to force people to upgrade
> module-init-tools this late in the development cycle...)

I'm not sure if embedding the kobject in the module is the correct
approach in this case, because we can't use the kobject refcount for
modules because it's too slow.  This cannot be fixed before 2.7 8(

Because kobject does not have a "struct module *owner", we can't
simply add in the refcount.  The module reference count is defined to
never go from zero to one when the module is dying, which means
callers must use try_module_get().  I grab the reference on
read/write, which means opening the file won't hold the module,
either.

Were you intending to put all the info currently in /proc/modules
under sysfs?  Makes sense I think.  For the options you'll need a
subdir to avoid name clashes.

Cheers!
Rusty.

Name: Modules in sysfs
Author: Greg KH <greg@kroah.com>
Status: Tested on 2.6.0-test5

D: Modified by Rusty to allocate kobject and module separately.
D: 
D: This patch adds basic kobject support to struct module, and it creates a
D: /sys/module directory which contains all of the individual modules.
D: Each module currently exports only one file, the module refcount:
D: 	$ tree /sys/module/
D: 	/sys/module/
D: 	|-- ehci_hcd
D: 	|   `-- refcount
D: 	|-- hid
D: 	|   `-- refcount
D: 	|-- parport
D: 	|   `-- refcount
D: 	|-- parport_pc
D: 	|   `-- refcount
D: 	|-- uhci_hcd
D: 	|   `-- refcount
D: 	`-- usbcore
D: 	    `-- refcount

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26542-linux-2.6.0-test5/include/linux/module.h .26542-linux-2.6.0-test5.updated/include/linux/module.h
--- .26542-linux-2.6.0-test5/include/linux/module.h	2003-07-31 01:50:19.000000000 +1000
+++ .26542-linux-2.6.0-test5.updated/include/linux/module.h	2003-09-10 11:50:04.000000000 +1000
@@ -16,6 +16,7 @@
 #include <linux/kmod.h>
 #include <linux/elf.h>
 #include <linux/stringify.h>
+#include <linux/kobject.h>
 #include <asm/local.h>
 
 #include <asm/module.h>
@@ -182,6 +183,12 @@ enum module_state
 	MODULE_STATE_GOING,
 };
 
+struct module_kobj
+{
+	struct kobject kobj;
+	struct module *mod;
+};
+
 struct module
 {
 	enum module_state state;
@@ -192,6 +199,9 @@ struct module
 	/* Unique handle for this module */
 	char name[MODULE_NAME_LEN];
 
+	/* Our presence in sysfs. */
+	struct module_kobj *mkobj;
+
 	/* Exported symbols */
 	const struct kernel_symbol *syms;
 	unsigned int num_syms;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26542-linux-2.6.0-test5/kernel/module.c .26542-linux-2.6.0-test5.updated/kernel/module.c
--- .26542-linux-2.6.0-test5/kernel/module.c	2003-09-09 10:35:05.000000000 +1000
+++ .26542-linux-2.6.0-test5.updated/kernel/module.c	2003-09-10 12:19:51.000000000 +1000
@@ -1071,6 +1071,29 @@ static unsigned long resolve_symbol(Elf_
 	return ret;
 }
 
+static ssize_t show_mod_refcount(struct module *mod, char *buf)
+{
+	/* We hold one temporarily to access this, so sub 1. */
+	return sprintf(buf, "%d\n", module_refcount(mod)-1);
+}
+
+struct module_attribute {
+	struct attribute attr;
+	ssize_t (*show)(struct module *mod, char *);
+	ssize_t (*store)(struct module *mod, const char *, size_t);
+};
+
+static struct module_attribute mod_refcount = {
+	.attr = {.name = "refcount", .mode = S_IRUGO},
+	.show = show_mod_refcount,
+};
+
+static void mod_kobject_remove(struct module_kobj *mkobj)
+{
+	sysfs_remove_file(&mkobj->kobj, &mod_refcount.attr);
+	kobject_unregister(&mkobj->kobj);
+}
+
 /* Free a module, remove from lists, etc (must hold module mutex). */
 static void free_module(struct module *mod)
 {
@@ -1079,6 +1103,10 @@ static void free_module(struct module *m
 	list_del(&mod->list);
 	spin_unlock_irq(&modlist_lock);
 
+	/* unregister the kobject in this module */
+	if (mod->mkobj)
+		mod_kobject_remove(mod->mkobj);
+
 	/* Arch-specific cleanup. */
 	module_arch_cleanup(mod);
 
@@ -1677,6 +1705,99 @@ static struct module *load_module(void _
 	else return ptr;
 }
 
+/* sysfs stuff */
+#define to_module_attr(n) container_of(n, struct module_attribute, attr);
+#define to_module_kobj(n) container_of(n, struct module_kobj, kobj);
+
+static ssize_t module_attr_show(struct kobject *kobj,
+				struct attribute *attr,
+				char *buf)
+{
+	struct module_attribute *attribute = to_module_attr(attr);
+	struct module_kobj *mkobj = to_module_kobj(kobj);
+	ssize_t ret;
+
+	/* Don't let them in a module unloading *or loading*. */
+	if (!strong_try_module_get(mkobj->mod))
+		return -EIO;
+
+	ret = attribute->show ? attribute->show(mkobj->mod, buf) : 0;
+	module_put(mkobj->mod);
+	return ret;
+}
+
+static ssize_t module_attr_store(struct kobject *kobj,
+				 struct attribute *attr,
+				 const char *buf, size_t len)
+{
+	struct module_attribute *attribute = to_module_attr(attr);
+	struct module_kobj *mkobj = to_module_kobj(kobj);
+	ssize_t ret;
+
+	/* Don't let them in a module unloading *or loading*. */
+	if (!strong_try_module_get(mkobj->mod))
+		return -EIO;
+
+	ret = attribute->store ? attribute->store(mkobj->mod, buf, len) : 0;
+	module_put(mkobj->mod);
+	return ret;
+}
+
+static struct sysfs_ops module_sysfs_ops = {
+	.show = module_attr_show,
+	.store = module_attr_store,
+};
+
+static void module_release(struct kobject *kobj)
+{
+	struct module_kobj *mkobj = to_module_kobj(kobj);
+	kfree(mkobj);
+}
+
+static struct kobj_type module_ktype = {
+	.sysfs_ops =	&module_sysfs_ops,
+	.release =	&module_release,
+};
+static decl_subsys(module, &module_ktype, NULL);
+
+static int __init module_subsys_init(void)
+{
+	return subsystem_register(&module_subsys);
+}
+core_initcall(module_subsys_init);
+
+static int mod_kobject_init(struct module *mod)
+{
+	int retval;
+
+	mod->mkobj = kmalloc(sizeof(*mod->mkobj), GFP_KERNEL);
+	if (!mod->mkobj)
+		return -ENOMEM;
+
+	memset(&mod->mkobj->kobj, 0x00, sizeof(struct kobject));
+	mod->mkobj->mod = mod;
+	retval = kobject_set_name(&mod->mkobj->kobj, "%s", mod->name);
+	if (retval < 0)
+		goto free_kobj;
+	kobj_set_kset_s(mod->mkobj, module_subsys);
+	retval = kobject_register(&mod->mkobj->kobj);
+	if (retval < 0)
+		goto free_kobj;
+	retval = sysfs_create_file(&mod->mkobj->kobj, &mod_refcount.attr);
+	if (retval < 0) {
+		kobject_unregister(&mod->mkobj->kobj); /* Frees for us */
+		goto fail;
+	}
+	return retval;
+
+free_kobj:
+	kfree(mod->mkobj);
+fail:
+	/* Make us idempotent for free_module() */
+	mod->mkobj = NULL;
+	return retval;
+}
+
 /* This is where the real work happens */
 asmlinkage long
 sys_init_module(void __user *umod,
@@ -1715,6 +1836,13 @@ sys_init_module(void __user *umod,
 	list_add(&mod->list, &modules);
 	spin_unlock_irq(&modlist_lock);
 
+	ret = mod_kobject_init(mod);
+	if (ret < 0) {
+		free_module(mod);
+		up(&module_mutex);
+		return ret;
+	}
+
 	/* Drop lock so they can recurse */
 	up(&module_mutex);
 
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
