Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263799AbUEGV3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263799AbUEGV3Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 17:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263802AbUEGV3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 17:29:24 -0400
Received: from mail.kroah.org ([65.200.24.183]:30634 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263799AbUEGV3C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 17:29:02 -0400
Date: Fri, 7 May 2004 14:28:10 -0700
From: Greg KH <greg@kroah.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] add kobject to struct module
Message-ID: <20040507212810.GA13268@kroah.com>
References: <Pine.LNX.4.33.0309100807430.1012-100000@localhost.localdomain> <20030911011644.DA21C2C335@lists.samba.org> <20040224232940.GA3140@kroah.com> <1078497241.2492.908.camel@bach>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1078497241.2492.908.camel@bach>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 06, 2004 at 01:34:02AM +1100, Rusty Russell wrote:
> On Wed, 2004-02-25 at 10:29, Greg KH wrote:
> > So, here's a patch on top of your patch (full patch against 2.6.3 is
> > below), that simply makes the module reference file be owned by the
> > module that it is assigned to.  Yes, this means that when you actually
> > read the file value, the reference is 1 greater than when it is closed,
> > but that's the breaks.  It does solve the "grab the file and then try to
> > unload the module" problem, as it simply prevents this from happening.
> > 
> > Comments?
> 
> I've rewritten your rewrite again 8)

Heh, ok, time to stop this rewriting...

> This patch actually implements module_param in sysfs for modules.  You
> can see my tests in crypto_null().

This looks good.  I made some _very_ minor tweaks, and have checked it
into my driver tree, it will show up in the next -mm release.  I've
included the patch below if you want to verify it.

> What's missing is inbuilt modules.  I think /sys/modules/ne2k/debug
> should exist whether ne2k is built-in or modular, for example.  Since
> the only thing we have is a kparam with "ne2k.debug" as its name, there
> will have to be some kludgery here, but we can end up with something OK.

I agree, I'll work on that next.  I have support for exporting the
version, author, and license through the directory working, but I think
I'll hold off on it for a while (if at all, exporting the license all of
the time is pretty dumb...)  But people have expressed interest in
having the version exported to make it easier for bug-info-generating
scripts to pick up (distros specifically.)

thanks for putting up with the slow pace of this patch :)

greg k-h


# Add modules to sysfs
#
# This patch adds basic kobject support to struct module, and it creates a 
# /sys/module directory which contains all of the individual modules.  Each
# module currently exports the refcount (if they are unloadable) and any
# module paramaters that are marked exportable in sysfs.
# 
# Was written by me and Rusty over and over many times during the past 6 months.

diff -Nru a/include/linux/module.h b/include/linux/module.h
--- a/include/linux/module.h	Fri May  7 14:24:10 2004
+++ b/include/linux/module.h	Fri May  7 14:24:10 2004
@@ -16,6 +16,8 @@
 #include <linux/kmod.h>
 #include <linux/elf.h>
 #include <linux/stringify.h>
+#include <linux/kobject.h>
+#include <linux/moduleparam.h>
 #include <asm/local.h>
 
 #include <asm/module.h>
@@ -207,6 +209,23 @@
 	MODULE_STATE_GOING,
 };
 
+/* sysfs stuff */
+struct module_attribute
+{
+	struct attribute attr;
+	struct kernel_param *param;
+};
+
+struct module_kobject
+{
+	/* Everyone should have one of these. */
+	struct kobject kobj;
+
+	/* We always have refcnt, we may have others from module_param(). */
+	unsigned int num_attributes;
+	struct module_attribute attr[0];
+};
+
 struct module
 {
 	enum module_state state;
@@ -217,6 +236,9 @@
 	/* Unique handle for this module */
 	char name[MODULE_NAME_LEN];
 
+	/* Sysfs stuff. */
+	struct module_kobject *mkobj;
+
 	/* Exported symbols */
 	const struct kernel_symbol *syms;
 	unsigned int num_syms;
@@ -267,6 +289,9 @@
 
 	/* Destruction function. */
 	void (*exit)(void);
+
+	/* Fake kernel param for refcnt. */
+	struct kernel_param refcnt_param;
 #endif
 
 #ifdef CONFIG_KALLSYMS
diff -Nru a/include/linux/moduleparam.h b/include/linux/moduleparam.h
--- a/include/linux/moduleparam.h	Fri May  7 14:24:10 2004
+++ b/include/linux/moduleparam.h	Fri May  7 14:24:10 2004
@@ -50,7 +50,7 @@
    not there, read bits mean it's readable, write bits mean it's
    writable. */
 #define __module_param_call(prefix, name, set, get, arg, perm)		\
-	static char __param_str_##name[] __initdata = prefix #name;	\
+	static char __param_str_##name[] = prefix #name;		\
 	static struct kernel_param const __param_##name			\
 	__attribute_used__						\
     __attribute__ ((unused,__section__ ("__param"),aligned(sizeof(void *)))) \
@@ -71,7 +71,7 @@
 
 /* Actually copy string: maxlen param is usually sizeof(string). */
 #define module_param_string(name, string, len, perm)			\
-	static struct kparam_string __param_string_##name __initdata	\
+	static struct kparam_string __param_string_##name		\
 		= { len, string };					\
 	module_param_call(name, param_set_copystring, param_get_charp,	\
 		   &__param_string_##name, perm)
diff -Nru a/kernel/module.c b/kernel/module.c
--- a/kernel/module.c	Fri May  7 14:24:10 2004
+++ b/kernel/module.c	Fri May  7 14:24:10 2004
@@ -504,6 +504,22 @@
 	return stop_machine_run(__try_stop_module, &sref, NR_CPUS);
 }
 
+static int add_attribute(struct module *mod, struct kernel_param *kp)
+{
+	struct module_attribute *a;
+	int retval;
+
+	a = &mod->mkobj->attr[mod->mkobj->num_attributes];
+	a->attr.name = (char *)kp->name;
+	a->attr.owner = mod;
+	a->attr.mode = kp->perm;
+	a->param = kp;
+	retval = sysfs_create_file(&mod->mkobj->kobj, &a->attr);
+	if (!retval)
+		mod->mkobj->num_attributes++;
+	return retval;
+}
+
 unsigned int module_refcount(struct module *mod)
 {
 	unsigned int i, total = 0;
@@ -663,6 +679,23 @@
 }
 EXPORT_SYMBOL_GPL(symbol_put_addr);
 
+static int refcnt_get_fn(char *buffer, struct kernel_param *kp)
+{
+	struct module *mod = container_of(kp, struct module, refcnt_param);
+
+	/* sysfs holds one reference. */
+	return sprintf(buffer, "%u", module_refcount(mod)-1);
+}
+
+static inline int sysfs_unload_setup(struct module *mod)
+{
+	mod->refcnt_param.name = "refcnt";
+	mod->refcnt_param.perm = 0444;
+	mod->refcnt_param.get = refcnt_get_fn;
+
+	return add_attribute(mod, &mod->refcnt_param);
+}
+
 #else /* !CONFIG_MODULE_UNLOAD */
 static void print_unload_info(struct seq_file *m, struct module *mod)
 {
@@ -689,6 +722,10 @@
 	return -ENOSYS;
 }
 
+static inline int sysfs_unload_setup(struct module *mod)
+{
+	return 0;
+}
 #endif /* CONFIG_MODULE_UNLOAD */
 
 #ifdef CONFIG_OBSOLETE_MODPARM
@@ -944,6 +981,116 @@
 	return ret;
 }
 
+#define to_module_attr(n) container_of(n, struct module_attribute, attr);
+
+static ssize_t module_attr_show(struct kobject *kobj,
+				struct attribute *attr,
+				char *buf)
+{
+	int count;
+	struct module_attribute *attribute = to_module_attr(attr);
+
+	if (!attribute->param->get)
+		return -EPERM;
+
+	count = attribute->param->get(buf, attribute->param);
+	if (count > 0) {
+		strcat(buf, "\n");
+		++count;
+	}
+	return count;
+}
+
+/* sysfs always hands a nul-terminated string in buf.  We rely on that. */
+static ssize_t module_attr_store(struct kobject *kobj,
+				 struct attribute *attr,
+				 const char *buf, size_t len)
+{
+	int err;
+	struct module_attribute *attribute = to_module_attr(attr);
+
+	if (!attribute->param->set)
+		return -EPERM;
+
+	err = attribute->param->set(buf, attribute->param);
+	if (!err)
+		return len;
+	return err;
+}
+
+static struct sysfs_ops module_sysfs_ops = {
+	.show = module_attr_show,
+	.store = module_attr_store,
+};
+
+static void module_kobj_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct module_kobject, kobj));
+}
+
+static struct kobj_type module_ktype = {
+	.sysfs_ops =	&module_sysfs_ops,
+	.release =	&module_kobj_release,
+};
+static decl_subsys(module, &module_ktype, NULL);
+
+static int mod_sysfs_setup(struct module *mod,
+			   struct kernel_param *kparam,
+			   unsigned int num_params)
+{
+	unsigned int i;
+	int err;
+
+	/* We overallocate: not every param is in sysfs, and maybe no refcnt */
+	mod->mkobj = kmalloc(sizeof(*mod->mkobj)
+			     + sizeof(mod->mkobj->attr[0]) * (num_params+1),
+			     GFP_KERNEL);
+	if (!mod->mkobj)
+		return -ENOMEM;
+
+	memset(&mod->mkobj->kobj, 0, sizeof(mod->mkobj->kobj));
+	err = kobject_set_name(&mod->mkobj->kobj, mod->name);
+	if (err)
+		goto out;
+	kobj_set_kset_s(mod->mkobj, module_subsys);
+	err = kobject_register(&mod->mkobj->kobj);
+	if (err)
+		goto out;
+
+	mod->mkobj->num_attributes = 0;
+
+	for (i = 0; i < num_params; i++) {
+		if (kparam[i].perm) {
+			err = add_attribute(mod, &kparam[i]);
+			if (err)
+				goto out_unreg;
+		}
+	}
+	err = sysfs_unload_setup(mod);
+	if (err)
+		goto out_unreg;
+	return 0;
+
+out_unreg:
+	for (i = 0; i < mod->mkobj->num_attributes; i++)
+		sysfs_remove_file(&mod->mkobj->kobj,&mod->mkobj->attr[i].attr);
+	/* Calls module_kobj_release */
+	kobject_unregister(&mod->mkobj->kobj);
+	return err;
+out:
+	kfree(mod->mkobj);
+	return err;
+}
+
+static void mod_kobject_remove(struct module *mod)
+{
+	unsigned int i;
+	for (i = 0; i < mod->mkobj->num_attributes; i++)
+		sysfs_remove_file(&mod->mkobj->kobj,&mod->mkobj->attr[i].attr);
+	/* Calls module_kobj_release */
+	kobject_unregister(&mod->mkobj->kobj);
+}
+
 /* Free a module, remove from lists, etc (must hold module mutex). */
 static void free_module(struct module *mod)
 {
@@ -952,6 +1099,8 @@
 	list_del(&mod->list);
 	spin_unlock_irq(&modlist_lock);
 
+	mod_kobject_remove(mod);
+
 	/* Arch-specific cleanup. */
 	module_arch_cleanup(mod);
 
@@ -1556,6 +1705,11 @@
 				 / sizeof(struct kernel_param),
 				 NULL);
 	}
+	err = mod_sysfs_setup(mod, 
+			      (struct kernel_param *)
+			      sechdrs[setupindex].sh_addr,
+			      sechdrs[setupindex].sh_size
+			      / sizeof(struct kernel_param));
 	if (err < 0)
 		goto arch_cleanup;
 
@@ -1891,3 +2045,9 @@
 void struct_module(struct module *mod) { return; }
 EXPORT_SYMBOL(struct_module);
 #endif
+
+static int __init modules_init(void)
+{
+	return subsystem_register(&module_subsys);
+}
+__initcall(modules_init);
diff -Nru a/kernel/params.c b/kernel/params.c
--- a/kernel/params.c	Fri May  7 14:24:10 2004
+++ b/kernel/params.c	Fri May  7 14:24:10 2004
@@ -161,7 +161,7 @@
 									\
 		if (!val) return -EINVAL;				\
 		l = strtolfn(val, &endp, 0);				\
-		if (endp == val || *endp || ((type)l != l))		\
+		if (endp == val || ((type)l != l))			\
 			return -EINVAL;					\
 		*((type *)kp->arg) = l;					\
 		return 0;						\
