Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262536AbUBXXaT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 18:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262541AbUBXXaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 18:30:19 -0500
Received: from mail.kroah.org ([65.200.24.183]:21470 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262536AbUBXX3m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 18:29:42 -0500
Date: Tue, 24 Feb 2004 15:29:40 -0800
From: Greg KH <greg@kroah.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] add kobject to struct module
Message-ID: <20040224232940.GA3140@kroah.com>
References: <Pine.LNX.4.33.0309100807430.1012-100000@localhost.localdomain> <20030911011644.DA21C2C335@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030911011644.DA21C2C335@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I'm digging up some old code here...

On Thu, Sep 11, 2003 at 11:13:25AM +1000, Rusty Russell wrote:
> > > > But in looking at your patch, I don't see why you want to separate the
> > > > module from the kobject?  What benefit does it have?
> > > 
> > > The lifetimes are separate, each controlled by their own reference
> > > count.  I *know* this will work even if someone holds a reference to
> > > the kobject (for some reason in the future) even as the module is
> > > removed.
> > 
> > Correct me if I'm wrong, but this sounds similar to the networking 
> > refcount problem. The reference on the containing object is the 
> > interesting one, as far as visibility goes. As long as its positive, the 
> > module is active. 
> 
> There are basically two choices: ensure that the reference count is
> taken using try_module_get() (kobject doesn't have an owner field, so
> it does not match this one), or ensure that an object isn't ever
> referenced after the module cleanup function is called.
> 
> In this context, that means that the module cleanup must pause until
> the reference count of the kobject hits zero, so it can be freed.
> 
> Implementation below.

Problem is, this implementation dies a horrible death if you grab the
reference to the sysfs file and then try to unload the module at the
same time :(

So, here's a patch on top of your patch (full patch against 2.6.3 is
below), that simply makes the module reference file be owned by the
module that it is assigned to.  Yes, this means that when you actually
read the file value, the reference is 1 greater than when it is closed,
but that's the breaks.  It does solve the "grab the file and then try to
unload the module" problem, as it simply prevents this from happening.

Comments?

I think this whole patch can be simpler now, as we don't have to do the
kobject_wait type logic, but if you think we should go back to doing
that, I'll try to go debug what's wrong with your original patch...

thanks,

greg k-h

-------
Incremental patch:

diff -Nru a/include/linux/module.h b/include/linux/module.h
--- a/include/linux/module.h	Tue Feb 24 15:23:16 2004
+++ b/include/linux/module.h	Tue Feb 24 15:23:16 2004
@@ -192,6 +192,7 @@
 struct module
 {
 	struct kobject	kobj;
+	struct module_attribute *mod_refcount;
 
 	enum module_state state;
 
diff -Nru a/kernel/module.c b/kernel/module.c
--- a/kernel/module.c	Tue Feb 24 15:23:16 2004
+++ b/kernel/module.c	Tue Feb 24 15:23:16 2004
@@ -1130,7 +1130,7 @@
 	return sprintf(buf, "%d\n", module_refcount(mod));
 }
 
-static struct module_attribute mod_refcount = {
+static struct module_attribute mod_refcount_template = {
 	.attr = {.name = "refcount", .mode = S_IRUGO},
 	.show = show_mod_refcount,
 };
@@ -1148,22 +1148,33 @@
 {
 	int retval;
 
+	mod->mod_refcount = kmalloc(sizeof(struct module_attribute), GFP_KERNEL);
+	if (!mod->mod_refcount)
+		return -ENOMEM;
+	memcpy(mod->mod_refcount, &mod_refcount_template, sizeof(struct module_attribute));
+	mod->mod_refcount->attr.owner = mod;
+	
 	retval = kobject_set_name(&mod->kobj, mod->name);
 	if (retval < 0)
-		return retval;
+		goto error;
 	kobj_set_kset_s(mod, module_subsys);
 	retval = kobject_register(&mod->kobj);
 	if (retval)
-		return retval;
-	retval = sysfs_create_file(&mod->kobj, &mod_refcount.attr);
+		goto error;
+	retval = sysfs_create_file(&mod->kobj, &mod->mod_refcount->attr);
 	if (retval < 0)
 		remove_kobject_wait(mod);
 	return retval;
+
+error:
+	kfree(mod->mod_refcount);
+	return retval;
 }
 
 static void mod_kobject_remove(struct module *mod)
 {
-	sysfs_remove_file(&mod->kobj, &mod_refcount.attr);
+	sysfs_remove_file(&mod->kobj, &mod->mod_refcount->attr);
+	kfree(mod->mod_refcount);
 	remove_kobject_wait(mod);
 }
 

------------------

Full patch against a clean 2.6.3:


--- a/include/linux/module.h	Tue Feb 24 15:23:56 2004
+++ b/include/linux/module.h	Tue Feb 24 15:23:56 2004
@@ -16,6 +16,7 @@
 #include <linux/kmod.h>
 #include <linux/elf.h>
 #include <linux/stringify.h>
+#include <linux/kobject.h>
 #include <asm/local.h>
 
 #include <asm/module.h>
@@ -190,6 +191,9 @@
 
 struct module
 {
+	struct kobject	kobj;
+	struct module_attribute *mod_refcount;
+
 	enum module_state state;
 
 	/* Member of list of modules */
@@ -236,15 +240,15 @@
 	/* Am I GPL-compatible */
 	int license_gplok;
 
+	/* Who is waiting for us to be unloaded, or kobject to be unused. */
+	struct task_struct *waiter;
+
 #ifdef CONFIG_MODULE_UNLOAD
 	/* Reference counts */
 	struct module_ref ref[NR_CPUS];
 
 	/* What modules depend on me? */
 	struct list_head modules_which_use_me;
-
-	/* Who is waiting for us to be unloaded */
-	struct task_struct *waiter;
 
 	/* Destruction function. */
 	void (*exit)(void);
--- a/kernel/module.c	Tue Feb 24 15:23:56 2004
+++ b/kernel/module.c	Tue Feb 24 15:23:56 2004
@@ -706,6 +706,7 @@
 			goto out;
 		}
 	}
+
 	/* Stop the machine so refcounts can't move: irqs disabled. */
 	DEBUGP("Stopping refcounts...\n");
 	ret = stop_refcounts();
@@ -1076,6 +1077,107 @@
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
+static struct module_attribute mod_refcount_template = {
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
+	mod->mod_refcount = kmalloc(sizeof(struct module_attribute), GFP_KERNEL);
+	if (!mod->mod_refcount)
+		return -ENOMEM;
+	memcpy(mod->mod_refcount, &mod_refcount_template, sizeof(struct module_attribute));
+	mod->mod_refcount->attr.owner = mod;
+	
+	retval = kobject_set_name(&mod->kobj, mod->name);
+	if (retval < 0)
+		goto error;
+	kobj_set_kset_s(mod, module_subsys);
+	retval = kobject_register(&mod->kobj);
+	if (retval)
+		goto error;
+	retval = sysfs_create_file(&mod->kobj, &mod->mod_refcount->attr);
+	if (retval < 0)
+		remove_kobject_wait(mod);
+	return retval;
+
+error:
+	kfree(mod->mod_refcount);
+	return retval;
+}
+
+static void mod_kobject_remove(struct module *mod)
+{
+	sysfs_remove_file(&mod->kobj, &mod->mod_refcount->attr);
+	kfree(mod->mod_refcount);
+	remove_kobject_wait(mod);
+}
+
 /* Free a module, remove from lists, etc (must hold module mutex). */
 static void free_module(struct module *mod)
 {
@@ -1084,6 +1186,8 @@
 	list_del(&mod->list);
 	spin_unlock_irq(&modlist_lock);
 
+	mod_kobject_remove(mod);
+
 	/* Arch-specific cleanup. */
 	module_arch_cleanup(mod);
 
@@ -1678,6 +1782,10 @@
 	}
 	if (err < 0)
 		goto arch_cleanup;
+
+	err = mod_kobject_init(mod);
+	if (err < 0)
+		goto cleanup;
 
 	/* Get rid of temporary copy */
 	vfree(hdr);
