Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265907AbTIKBQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 21:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265916AbTIKBQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 21:16:57 -0400
Received: from dp.samba.org ([66.70.73.150]:22402 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265907AbTIKBQq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 21:16:46 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Patrick Mochel <mochel@osdl.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] add kobject to struct module 
In-reply-to: Your message of "Wed, 10 Sep 2003 08:26:41 MST."
             <Pine.LNX.4.33.0309100807430.1012-100000@localhost.localdomain> 
Date: Thu, 11 Sep 2003 11:13:25 +1000
Message-Id: <20030911011644.DA21C2C335@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.33.0309100807430.1012-100000@localhost.localdomain> you write:
> kernel/module.c owns the attribute code. (The same code and attribute 
> structure is reused for each object its exported for, so the owner field 
> must be set to the owner of the code itself.) 

Right, then the current code is correct.

> > > But in looking at your patch, I don't see why you want to separate the
> > > module from the kobject?  What benefit does it have?
> > 
> > The lifetimes are separate, each controlled by their own reference
> > count.  I *know* this will work even if someone holds a reference to
> > the kobject (for some reason in the future) even as the module is
> > removed.
> 
> Correct me if I'm wrong, but this sounds similar to the networking 
> refcount problem. The reference on the containing object is the 
> interesting one, as far as visibility goes. As long as its positive, the 
> module is active. 

There are basically two choices: ensure that the reference count is
taken using try_module_get() (kobject doesn't have an owner field, so
it does not match this one), or ensure that an object isn't ever
referenced after the module cleanup function is called.

In this context, that means that the module cleanup must pause until
the reference count of the kobject hits zero, so it can be freed.

Implementation below.

BTW, The *real* answer IMHO is (this is 2.7 stuff:)

1) Adopt a faster, smaller implementation of alloc_percpu (this patch
   exists, needs some arch-dependent love for ia64).
2) Use it to generalize the current module reference count scheme to
   a "bigref_t" (I have a couple of these)
3) Use that in kobjects.
4) Decide that module removal is not as important as it was, and not
   all modules need be removable (at least in finite time).
5) Use the kobject reference count everywhere, including modules.

This would make everything faster, except for the case where someone
is actually waiting for a refcount to hit zero: for long-lived objects
like kobjects, this seems the right tradeoff.

Cheers!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Modules in sysfs
Author: Greg KH <greg@kroah.com>
Status: Tested on 2.6.0-test5-bk1

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
D: 
D: Rusty: We ensure that the kobject embedded in the module has a shorter
D: lifetime than the module itself by waiting for its reference count
D: to reach zero before freeing the module structure.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .28943-linux-2.6.0-test5/include/linux/module.h .28943-linux-2.6.0-test5.updated/include/linux/module.h
--- .28943-linux-2.6.0-test5/include/linux/module.h	2003-07-31 01:50:19.000000000 +1000
+++ .28943-linux-2.6.0-test5.updated/include/linux/module.h	2003-09-11 09:19:42.000000000 +1000
@@ -16,6 +16,7 @@
 #include <linux/kmod.h>
 #include <linux/elf.h>
 #include <linux/stringify.h>
+#include <linux/kobject.h>
 #include <asm/local.h>
 
 #include <asm/module.h>
@@ -184,6 +185,8 @@ enum module_state
 
 struct module
 {
+	struct kobject	kobj;
+
 	enum module_state state;
 
 	/* Member of list of modules */
@@ -230,6 +233,9 @@ struct module
 	/* Am I GPL-compatible */
 	int license_gplok;
 
+	/* Who is waiting for us to be unloaded, or kobject to be unused. */
+	struct task_struct *waiter;
+
 #ifdef CONFIG_MODULE_UNLOAD
 	/* Reference counts */
 	struct module_ref ref[NR_CPUS];
@@ -237,9 +243,6 @@ struct module
 	/* What modules depend on me? */
 	struct list_head modules_which_use_me;
 
-	/* Who is waiting for us to be unloaded */
-	struct task_struct *waiter;
-
 	/* Destruction function. */
 	void (*exit)(void);
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .28943-linux-2.6.0-test5/kernel/module.c .28943-linux-2.6.0-test5.updated/kernel/module.c
--- .28943-linux-2.6.0-test5/kernel/module.c	2003-09-09 10:35:05.000000000 +1000
+++ .28943-linux-2.6.0-test5.updated/kernel/module.c	2003-09-11 09:35:51.000000000 +1000
@@ -702,6 +702,7 @@ sys_delete_module(const char __user *nam
 			goto out;
 		}
 	}
+
 	/* Stop the machine so refcounts can't move: irqs disabled. */
 	DEBUGP("Stopping refcounts...\n");
 	ret = stop_refcounts();
@@ -1071,6 +1072,96 @@ static unsigned long resolve_symbol(Elf_
 	return ret;
 }
 
+/* sysfs stuff */
+struct module_attribute {
+	struct attribute attr;
+	ssize_t (*show)(struct module *mod, char *);
+	ssize_t (*store)(struct module *mod, const char *, size_t);
+};
+#define to_module_attr(n) container_of(n, struct module_attribute, attr);
+#define to_module(n) container_of(n, struct module, kobj)
+
+static ssize_t module_attr_show(struct kobject *kobj, struct attribute *attr, char *buf)
+{
+	struct module *slot = to_module(kobj);
+	struct module_attribute *attribute = to_module_attr(attr);
+	return attribute->show ? attribute->show(slot, buf) : 0;
+}
+
+static ssize_t module_attr_store(struct kobject *kobj, struct attribute *attr, const char *buf, size_t len)
+{
+	struct module *slot = to_module(kobj);
+	struct module_attribute *attribute = to_module_attr(attr);
+	return attribute->store ? attribute->store(slot, buf, len) : 0;
+}
+
+static struct sysfs_ops module_sysfs_ops = {
+	.show = module_attr_show,
+	.store = module_attr_store,
+};
+
+/* remove_kobject_wait is waiting for this (called when kobj->refcount
+ * hits zero) */
+static void module_release(struct kobject *kobj)
+{
+	struct module *mod = to_module(kobj);
+	wake_up_process(mod->waiter);
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
+static ssize_t show_mod_refcount(struct module *mod, char *buf)
+{
+	return sprintf(buf, "%d\n", module_refcount(mod));
+}
+
+static struct module_attribute mod_refcount = {
+	.attr = {.name = "refcount", .mode = S_IRUGO},
+	.show = show_mod_refcount,
+};
+
+/* Remove kobject and block until refcount hits zero. */
+static void remove_kobject_wait(struct module *mod)
+{
+	mod->waiter = current;
+	set_task_state(current, TASK_UNINTERRUPTIBLE);
+	kobject_unregister(&mod->kobj);
+	schedule();
+}
+
+static int mod_kobject_init(struct module *mod)
+{
+	int retval;
+
+	retval = kobject_set_name(&mod->kobj, mod->name);
+	if (retval < 0)
+		return retval;
+	kobj_set_kset_s(mod, module_subsys);
+	retval = kobject_register(&mod->kobj);
+	if (retval)
+		return retval;
+	retval = sysfs_create_file(&mod->kobj, &mod_refcount.attr);
+	if (retval < 0)
+		remove_kobject_wait(mod);
+	return retval;
+}
+
+static void mod_kobject_remove(struct module *mod)
+{
+	sysfs_remove_file(&mod->kobj, &mod_refcount.attr);
+	remove_kobject_wait(mod);
+}
+
 /* Free a module, remove from lists, etc (must hold module mutex). */
 static void free_module(struct module *mod)
 {
@@ -1079,6 +1170,8 @@ static void free_module(struct module *m
 	list_del(&mod->list);
 	spin_unlock_irq(&modlist_lock);
 
+	mod_kobject_remove(mod);
+
 	/* Arch-specific cleanup. */
 	module_arch_cleanup(mod);
 
@@ -1655,6 +1748,10 @@ static struct module *load_module(void _
 	if (err < 0)
 		goto cleanup;
 
+	err = mod_kobject_init(mod);
+	if (err < 0)
+		goto cleanup;
+
 	/* Get rid of temporary copy */
 	vfree(hdr);
 
