Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262629AbVA0OJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262629AbVA0OJU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 09:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262628AbVA0OJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 09:09:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:14523 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262629AbVA0OIZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 09:08:25 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <31453.1105979239@redhat.com> 
References: <31453.1105979239@redhat.com> 
To: rusty@rustcorp.com.au, akpm@osdl.org, torvalds@osdl.org,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix kallsyms/insmod/rmmod race [try #2]
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Thu, 27 Jan 2005 14:08:07 +0000
Message-ID: <3880.1106834887@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch fixes a race between kallsyms and insmod/rmmod.

The problem is this:

 (1) The various kallsyms functions poke around in the module list without any
     locking so that they can be called from the oops handler.

 (2) Although insmod and rmmod use locks to exclude each other, these have no
     effect on the kallsyms function.

 (3) Although rmmod modifies the module state with the machine "stopped", it
     hasn't removed the metadata from the module metadata list, meaning that
     as soon as the machine is "restarted", the metadata can be observed by
     kallsyms.

     It's not possible to say that an item in that list should be ignored if
     it's state is marked as inactive - you can't get at the state information
     because you can't trust the metadata in which it is embedded.

     Furthermore, list linkage information is embedded in the metadata too, so
     you can't trust that either...

 (4) kallsyms may be walking the module list without a lock whilst either
     insmod or rmmod are busy changing it. insmod probably isn't a problem
     since nothing is going a way, but rmmod is as it's deleting an entry.

 (5) Therefore nothing that uses these functions can in any way trust any
     pointers to "static" data (such as module symbol names or module names)
     that are returned.

 (6) On ppc64 the problems are exacerbated since the hypervisor may reschedule
     bits of the kernel, making operations that appear adjacent occur a long
     time apart.

This patch fixes the race by only linking/unlinking modules into/from the
master module list with the machine in the "stopped" state. This means that
any "static" information can be trusted as far as the next kernel reschedule
on any given CPU without the need to hold any locks.

However, I'm not sure how this is affected by preemption. I suspect more work
may need to be done in that case, but I'm not entirely sure.

This also means that rmmod has to bump the machine into the stopped state
twice... but since that shouldn't be a common operation, I don't think that's
a problem.

I've amended this patch to not get spinlocks whilst in the machine locked
state - there's no point as nothing else can be holding spinlocks.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat kallsyms-race-2611rc1.diff
 kallsyms.c |   16 ++++++++++++++--
 module.c   |   31 ++++++++++++++++++++++++-------
 2 files changed, 38 insertions(+), 9 deletions(-)

diff -uNrp linux-2.6.11-rc1/kernel/kallsyms.c linux-2.6.11-rc1-kallsyms/kernel/kallsyms.c
--- linux-2.6.11-rc1/kernel/kallsyms.c	2005-01-12 19:09:18.000000000 +0000
+++ linux-2.6.11-rc1-kallsyms/kernel/kallsyms.c	2005-01-17 15:33:55.000000000 +0000
@@ -139,13 +139,20 @@ unsigned long kallsyms_lookup_name(const
 	return module_kallsyms_lookup_name(name);
 }
 
-/* Lookup an address.  modname is set to NULL if it's in the kernel. */
+/*
+ * Lookup an address
+ * - modname is set to NULL if it's in the kernel
+ * - we guarantee that the returned name is valid until we reschedule even if
+ *   it resides in a module
+ * - we also guarantee that modname will be valid until rescheduled
+ */
 const char *kallsyms_lookup(unsigned long addr,
 			    unsigned long *symbolsize,
 			    unsigned long *offset,
 			    char **modname, char *namebuf)
 {
 	unsigned long i, low, high, mid;
+	const char *msym;
 
 	/* This kernel should never had been booted. */
 	BUG_ON(!kallsyms_addresses);
@@ -196,7 +203,12 @@ const char *kallsyms_lookup(unsigned lon
 		return namebuf;
 	}
 
-	return module_address_lookup(addr, symbolsize, offset, modname);
+	/* see if it's in a module */
+	msym = module_address_lookup(addr, symbolsize, offset, modname);
+	if (msym)
+		return strncpy(namebuf, msym, KSYM_NAME_LEN);
+
+	return NULL;
 }
 
 /* Replace "%s" in format with address, or returns -errno. */
diff -uNrp linux-2.6.11-rc1/kernel/module.c linux-2.6.11-rc1-kallsyms/kernel/module.c
--- linux-2.6.11-rc1/kernel/module.c	2005-01-12 19:09:18.000000000 +0000
+++ linux-2.6.11-rc1-kallsyms/kernel/module.c	2005-01-27 14:06:22.857054758 +0000
@@ -1072,14 +1072,22 @@ static void mod_kobject_remove(struct mo
 	kobject_unregister(&mod->mkobj.kobj);
 }
 
+/*
+ * unlink the module with the whole machine is stopped with interrupts off
+ * - this defends against kallsyms not taking locks
+ */
+static inline int __unlink_module(void *_mod)
+{
+	struct module *mod = _mod;
+	list_del(&mod->list);
+	return 0;
+}
+
 /* Free a module, remove from lists, etc (must hold module mutex). */
 static void free_module(struct module *mod)
 {
 	/* Delete from various lists */
-	spin_lock_irq(&modlist_lock);
-	list_del(&mod->list);
-	spin_unlock_irq(&modlist_lock);
-
+	stop_machine_run(__unlink_module, mod, NR_CPUS);
 	remove_sect_attrs(mod);
 	mod_kobject_remove(mod);
 
@@ -1732,6 +1740,17 @@ static struct module *load_module(void _
 	goto free_hdr;
 }
 
+/*
+ * link the module with the whole machine is stopped with interrupts off
+ * - this defends against kallsyms not taking locks
+ */
+static inline int __link_module(void *_mod)
+{
+	struct module *mod = _mod;
+	list_add(&mod->list, &modules);
+	return 0;
+}
+
 /* This is where the real work happens */
 asmlinkage long
 sys_init_module(void __user *umod,
@@ -1766,9 +1785,7 @@ sys_init_module(void __user *umod,
 
 	/* Now sew it into the lists.  They won't access us, since
            strong_try_module_get() will fail. */
-	spin_lock_irq(&modlist_lock);
-	list_add(&mod->list, &modules);
-	spin_unlock_irq(&modlist_lock);
+	stop_machine_run(__link_module, mod, NR_CPUS);
 
 	/* Drop lock so they can recurse */
 	up(&module_mutex);
