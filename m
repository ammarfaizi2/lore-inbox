Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265096AbSLWNaa>; Mon, 23 Dec 2002 08:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265098AbSLWNaa>; Mon, 23 Dec 2002 08:30:30 -0500
Received: from h-64-105-34-78.SNVACAID.covad.net ([64.105.34.78]:40124 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S265096AbSLWNaY>; Mon, 23 Dec 2002 08:30:24 -0500
Date: Mon, 23 Dec 2002 05:36:14 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: rusty@rustcomp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: RFC/Preliminary patch - simpler raceless module unloading
Message-ID: <20021223053614.A31939@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	Here is a completely untested patch to illustrate a simpler
way to raceless module unloading.  Code that uses this scheme does
not have to deal with the possibilty of try_module_get failing, and,
if all users of the old mechanism are converted, we will be able
to delete the new most fundamental type of locking primitive code
in kernel/module.c.

	I've kept this code mostly separated in <linux/module_rwsem.h>
and kernel/module_rwsem.c so that it will not necessitate pulling
<linux/module.h> into more include files and it should be more
portable across different module loading schems.

	The basic theory of operation is that the data structure for
looking up a given type of driver by name or number should be
protected by an rw_semaphore (e.g., registering a file system type,
finding a file system type by name).  When a driver is registered, it
call register_module_rwsem to associate to tell the module system that
it needs to acquire a write lock on the given rwsem before attempting
to remove the module (or checking its reference count for that
purpose).  The get_foo_driver_by_name(name) and put_foo_driver(driver)
routines take a read lock on the rw_semaphore (or assume that they are
called with the read lock held) while they look up the driver and
manipulate its module reference count.  register_foo_driver a takes a
write lock on the rw_semaphore (or requires the caller to be holding a
write lock on it).  unregister_foo_driver assumes that the caller
already holds a write lock on the semaphore because sys_delete_module
already acquirs all of the rwsem's that were registered for a given
module by register_module_rwsem.  As a result, no attempt to look
up a driver by name or modify its reference count can overlap
with the part of sys_delete_module that checks the module reference
count through completion of the module's unload routine.

	I plan to port net_device, filesystem, file_operations,
block_device_operations, and device_driver to use it.  So if what
I've described above is too verbose, it should become clearer once
I post some ports of code to it.

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mod_rwsems.diff"

--- linux-2.5.52/include/linux/module.h	2002-12-15 18:08:14.000000000 -0800
+++ linux/include/linux/module.h	2002-12-23 04:43:47.000000000 -0800
@@ -157,6 +157,11 @@
 	/* Reference counts */
 	struct module_ref ref[NR_CPUS];
 
+	/* Which rwsems to grab before trying to unload the module.
+	   This list of struct module_rwsem is in order sorted by
+	   module_rwsem.rwsem address. */
+	struct list_head rwsems;
+
 	/* What modules depend on me? */
 	struct list_head modules_which_use_me;
 
--- linux-2.5.52/include/linux/module_rwsem.h	1969-12-31 16:00:00.000000000 -0800
+++ linux/include/linux/module_rwsem.h	2002-12-23 04:44:02.000000000 -0800
@@ -0,0 +1,23 @@
+#ifndef _LINUX_MODULE_RWSEM_H
+#define _LINUX_MODULE_RWSEM_H
+
+/* This is separate from module.h so that most headers will not need
+   to include <linux/module.h>. */
+
+#include <linux/list.h>
+
+struct module;
+struct rw_semaphore;
+
+struct rw_semaphore;
+struct module_rwsem {
+	struct rw_semaphore	*rwsem;
+	struct module		*module;
+	struct list_head	same_module;
+};
+
+extern void register_module_rwsem(struct module_rwsem *);
+extern int module_rwsems_down(struct module *);
+extern void module_rwsems_up(struct module *);
+
+#endif
--- linux-2.5.52/kernel/module.c	2002-12-15 18:08:13.000000000 -0800
+++ linux/kernel/module.c	2002-12-23 04:43:27.000000000 -0800
@@ -17,6 +17,7 @@
 */
 #include <linux/config.h>
 #include <linux/module.h>
+#include <linux/module_rwsem.h>
 #include <linux/moduleloader.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -116,6 +117,7 @@
 {
 	unsigned int i;
 
+	INIT_LIST_HEAD(&mod->rwsems);
 	INIT_LIST_HEAD(&mod->modules_which_use_me);
 	for (i = 0; i < NR_CPUS; i++)
 		atomic_set(&mod->ref[i].count, 0);
@@ -377,9 +379,13 @@
 	mod = find_module(name);
 	if (!mod) {
 		ret = -ENOENT;
-		goto out;
+		goto out_no_rwsems;
 	}
 
+	ret = module_rwsems_down(mod);
+	if (ret)
+		goto out_no_rwsems;
+
 	if (!list_empty(&mod->modules_which_use_me)) {
 		/* Other modules depend on us: get rid of them first. */
 		ret = -EWOULDBLOCK;
@@ -457,6 +463,9 @@
 	free_module(mod);
 
  out:
+	module_rwsems_up(mod);
+
+ out_no_rwsems:
 	up(&module_mutex);
 	return ret;
 }
--- linux-2.5.52/kernel/module_rwsem.c	1969-12-31 16:00:00.000000000 -0800
+++ linux/kernel/module_rwsem.c	2002-12-23 04:43:21.000000000 -0800
@@ -0,0 +1,163 @@
+#include <linux/config.h>
+#include <linux/module_rwsem.h>
+#include <linux/module.h>
+#include <linux/rwsem.h>
+
+#ifdef CONFIG_MODULE_UNLOAD
+
+#define list_add_before(list, new)	list_add_tail(list, new)
+
+/**
+ * register_module_rwsem - Require that sys_delete module take an
+ *			   grab an exclusive lock on an rwsem when trying
+ *			   to unload this module.
+ * @module_rwsem:   Contains module, rw_sempahore and pointers.  This
+ *		    structure should be statically allocated in the module
+ *		    itself, as it is referenced after the module_exit routine
+ *		    ends.
+ *	.module		The module to associate with the rw_semaphore.
+ *	.rwsem		The rw_semaphore to associate with the module.
+ *	.same_module	(Filled in by register_module_rwsem)
+ *
+ * Description:
+ *  Make sys_delete_module take an exclusive lock on the rwsem when trying
+ *  to unload the given module.  The module's remove function is then
+ *  responsible for releasing each rwsem, usually via
+ *  unregister_module_rwsem.
+ *
+ *  You can safely associate an rwsem with the same module multiple times.
+ *  sys_delete_module will grab the rwsem only once, and
+ *  unregister_module_rwsem will only release the rwsem if it is the
+ *  last remaining reference to it in the module's rwsem list.
+ **/
+void register_module_rwsem(struct module_rwsem *mod_rwsem)
+{
+	struct list_head *list_ptr;
+
+	if (mod_rwsem->module == NULL)
+		return;
+
+	BUG_ON(mod_rwsem->rwsem == NULL);
+
+	list_for_each(list_ptr, &mod_rwsem->module->rwsems) {
+		struct module_rwsem *tmp_mod_rwsem =
+			list_entry(list_ptr, struct module_rwsem, same_module);
+		if (tmp_mod_rwsem->rwsem > mod_rwsem->rwsem) {
+			list_add_before(&mod_rwsem->same_module, list_ptr);
+			return;
+		}
+	}
+
+	list_add_tail(&mod_rwsem->same_module, &mod_rwsem->module->rwsems);
+}
+EXPORT_SYMBOL(register_module_rwsem);
+
+/* Kludge until somebody implements down_write_interruptible. */
+static inline int down_write_interruptible(struct rw_semaphore *rwsem)
+{
+	down_write(rwsem);
+	return 0;
+}
+
+static void
+module_rwsems_up_partial(struct module *module, struct rw_semaphore *end)
+{
+	struct rw_semaphore *prev_rwsem = NULL;
+	struct module_rwsem *mod_rwsem;
+
+	list_for_each_entry(mod_rwsem, &module->rwsems, same_module) {
+		struct rw_semaphore *rwsem = mod_rwsem->rwsem;
+		if (rwsem == end)
+			return;
+		if (rwsem != prev_rwsem) {
+			up_write(rwsem);
+			prev_rwsem = rwsem;
+		}
+	}
+}
+
+void module_rwsems_up(struct module *module)
+{
+	module_rwsems_up_partial(module, NULL);
+}
+
+int module_rwsems_down(struct module *module)
+{
+	struct rw_semaphore *prev_rwsem = NULL;
+	struct module_rwsem *mod_rwsem;
+
+	list_for_each_entry(mod_rwsem, &module->rwsems, same_module) {
+		struct rw_semaphore *rwsem = mod_rwsem->rwsem;
+		if (rwsem != prev_rwsem) {
+			int err = down_write_interruptible(rwsem);
+			if (err) {
+				module_rwsems_up_partial(module, rwsem);
+				return err;
+			}
+			prev_rwsem = mod_rwsem->rwsem;
+		}
+	}
+	return 0;
+}
+
+# if 0
+
+static int
+same_rwsem(struct list_head *list_ptr, struct module_rwsem *mod_rwsem)
+{
+	struct module_rwsem *other_mod_rwsem;
+
+	if (list_ptr == &mod_rwsem->module->rwsems)
+		return 0;
+
+	other_mod_rwsem = list_entry(list_ptr,
+				     struct module_rwsem, same_module);
+	return (other_mod_rwsem->rwsem == mod_rwsem->rwsem);
+}
+
+/**
+ * unregister_module_rwsem - Dissociate an rwsem from a module.
+ * @module_rwsem:   The rwsem/module association.
+ *
+ * Description:
+ *  Do not use.  Instead, up_write is called on all module rwsem's
+ *  automatically after the module's module_exit routine returns.
+ *
+ *  This routine exists only in case somebody really needs to remove
+ *  a module/rwsem association before the module's module_exit routine
+ *  completes (for example, because the storage of the struct
+ *  module_rwsem will be deallocated before then or because the
+ *  rwsem must be released before then).  This does not appear to
+ *  even be necessary, but here is an untested implementation in
+ *  case it is needed in the future.
+ **/
+void unregister_module_rwsem(struct module_rwsem *mod_rwsem)
+{
+	int used_again = 
+		same_rwsem(use->same_module.next, use) ||
+		same_rwsem(use->same_module.prev, use);
+
+	list_del(&use->same_module);
+	if (!used_again)
+		up_write(use->rwsem);
+}
+EXPORT_SYMBOL(unregister_module_rwsem);
+
+# endif /* 0 */
+
+#else /* !CONFIG_MODULE_UNLOAD */
+
+void register_module_rwsem(struct module_rwsem *)
+{
+}
+
+int module_rwsems_down(struct module *)
+{
+	return 0;
+}
+
+static inline void module_rwsems_up(struct module *)
+{
+}
+
+#endif /* CONFIG_MODULE_UNLOAD */

--h31gzZEtNLTqOjlF--
