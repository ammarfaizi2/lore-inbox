Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265043AbTIIWYc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 18:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265046AbTIIWYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 18:24:31 -0400
Received: from mail.kroah.org ([65.200.24.183]:35288 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265043AbTIIWYD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 18:24:03 -0400
Date: Tue, 9 Sep 2003 15:24:21 -0700
From: Greg KH <greg@kroah.com>
To: rusty@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [RFC] add kobject to struct module
Message-ID: <20030909222421.GA7703@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A while ago we had talked about adding a kobject to struct module.  By
doing this we add support for module paramaters and other module info to
be exported in sysfs.  So here's a patch that does this that is against
2.6.0-test4 (it applies with some fuzz, sorry.)

This patch adds basic kobject support to struct module, and it creates a
/sys/module directory which contains all of the individual modules.
Each module currently exports only one file, the module refcount:
	$ tree /sys/module/
	/sys/module/
	|-- ehci_hcd
	|   `-- refcount
	|-- hid
	|   `-- refcount
	|-- parport
	|   `-- refcount
	|-- parport_pc
	|   `-- refcount
	|-- uhci_hcd
	|   `-- refcount
	`-- usbcore
	    `-- refcount

I used the kobject reference count to add to the module reference count
to handle races if a user has a module owned sysfs file open, but this
reference is not exported to userspace, as that just confuses the
userspace tools a bunch (and I don't want to force people to upgrade
module-init-tools this late in the development cycle...)

Rusty, any comments?  If this looks sane, I'll work on adding the
module_paramater support to the individual module directories.

thanks,

greg k-h


# Module: Add a kobject to struct module
#
# This gets us /sys/module to show all modules.
# Module attributes will happen next.

diff -Nru a/include/linux/module.h b/include/linux/module.h
--- a/include/linux/module.h	Tue Sep  9 14:58:58 2003
+++ b/include/linux/module.h	Tue Sep  9 14:58:58 2003
@@ -16,6 +16,7 @@
 #include <linux/kmod.h>
 #include <linux/elf.h>
 #include <linux/stringify.h>
+#include <linux/kobject.h>
 #include <asm/local.h>
 
 #include <asm/module.h>
@@ -184,6 +185,8 @@
 
 struct module
 {
+	struct kobject	kobj;
+
 	enum module_state state;
 
 	/* Member of list of modules */
diff -Nru a/kernel/module.c b/kernel/module.c
--- a/kernel/module.c	Tue Sep  9 14:58:58 2003
+++ b/kernel/module.c	Tue Sep  9 14:58:58 2003
@@ -613,6 +613,7 @@
 
 	for (i = 0; i < NR_CPUS; i++)
 		total += local_read(&mod->ref[i].count);
+	total += atomic_read(&mod->kobj.refcount);
 	return total;
 }
 EXPORT_SYMBOL(module_refcount);
@@ -656,6 +657,8 @@
 	down(&module_mutex);
 }
 
+static void mod_kobject_remove(struct module *mod);
+
 asmlinkage long
 sys_delete_module(const char __user *name_user, unsigned int flags)
 {
@@ -704,6 +707,10 @@
 			goto out;
 		}
 	}
+
+	/* unregister the kobject in this module */
+	mod_kobject_remove(mod);
+
 	/* Stop the machine so refcounts can't move: irqs disabled. */
 	DEBUGP("Stopping refcounts...\n");
 	ret = stop_refcounts();
@@ -743,7 +750,7 @@
 	struct module_use *use;
 	int printed_something = 0;
 
-	seq_printf(m, " %u ", module_refcount(mod));
+	seq_printf(m, " %u ", module_refcount(mod) - atomic_read(&mod->kobj.refcount));
 
 	/* Always include a trailing , so userspace can differentiate
            between this and the old multi-field proc format. */
@@ -1753,6 +1760,85 @@
 	else return ptr;
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
+/* Huh?  A release() function that doesn't do anything?
+ * This is here only because a module has another reference count that
+ * it uses to determine if it should be cleaned up or not.  If the
+ * module wants to switch over to use the kobject reference instead of
+ * its own, then this release function needs to do some work.
+ */
+static void module_release(struct kobject *kobj)
+{
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
+	return sprintf(buf, "%d\n", module_refcount(mod) - atomic_read(&mod->kobj.refcount));
+}
+
+static struct module_attribute mod_refcount = {
+	.attr = {.name = "refcount", .mode = S_IRUGO},
+	.show = show_mod_refcount,
+};
+
+static int mod_kobject_init(struct module *mod)
+{
+	int retval;
+
+	memset(&mod->kobj, 0x00, sizeof(struct kobject));
+	kobject_set_name(&mod->kobj, mod->name);
+	kobj_set_kset_s(mod, module_subsys);
+	retval = kobject_register(&mod->kobj);
+	if (!retval)
+		retval = sysfs_create_file(&mod->kobj, &mod_refcount.attr);
+	return retval;
+}
+
+static void mod_kobject_remove(struct module *mod)
+{
+	sysfs_remove_file(&mod->kobj, &mod_refcount.attr);
+	kobject_unregister(&mod->kobj);
+}
+
 /* This is where the real work happens */
 asmlinkage long
 sys_init_module(void __user *umod,
@@ -1816,6 +1902,8 @@
 		}
 		return ret;
 	}
+
+	mod_kobject_init(mod);
 
 	/* Now it's a first class citizen! */
 	down(&module_mutex);
