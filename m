Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261993AbVCLSLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbVCLSLK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 13:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbVCLSLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 13:11:10 -0500
Received: from mailfe07.swip.net ([212.247.154.193]:11428 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261993AbVCLSIL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 13:08:11 -0500
X-T2-Posting-ID: icQHdNe7aEavrnKIz+aKnQ==
Subject: Re: Strange memory leak in 2.6.x
From: Alexander Nyberg <alexn@dsv.su.se>
To: Tobias Hennerich <Tobias@Hennerich.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1110640085.2376.22.camel@boxen>
References: <20050308133735.A13586@bart.hennerich.de>
	 <20050308173811.0cd767c3.akpm@osdl.org>
	 <20050309102740.D3382@bart.hennerich.de>
	 <20050311183207.A22397@bart.hennerich.de> <1110565420.2501.12.camel@boxen>
	 <20050312133241.A11469@bart.hennerich.de>  <1110640085.2376.22.camel@boxen>
Content-Type: text/plain
Date: Sat, 12 Mar 2005 19:08:00 +0100
Message-Id: <1110650881.3360.5.camel@boxen>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is for example good complete trace:
> [0xc0148b9a] do_anonymous_page+170
> [0xc0148cdb] do_no_page+75
> [0xc0149128] handle_mm_fault+264
> [0xc0113625] do_page_fault+501
> [0xc0104a7b] error_code+43
> 
> The next one here is how it looks when it is not so good:
> [0xc013962b] find_or_create_page+91
> [0xc01596ac] grow_dev_page+44
> [0xc015986a] __getblk_slow+170
> [0xc0159c26] __getblk+54
> [0xf8ac0a57] +1207
> [0xf8abfccd] +61
> [0xf8ac03c1] +241
> [0xf8ac040a] +42
> 
> 
> Stupid me, the 0xf8ac040a addresses are vmalloc space (modules). I need
> to look into why it doesn't work with vmalloc

Just for completeness I see what's happening, it is fixed in mainline
(went in after 2.6.11 however).

The more cumbersome way I suggested with saving /proc/kallsyms still works.


# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/03/08 09:48:29-08:00 dhowells@redhat.com 
#   [PATCH] Fix kallsyms/insmod/rmmod race
#   
#   The attached patch fixes a race between kallsyms and insmod/rmmod.
#   
#   The problem is this:
#   
#    (1) The various kallsyms functions poke around in the module list without any
#        locking so that they can be called from the oops handler.
#   
#    (2) Although insmod and rmmod use locks to exclude each other, these have no
#        effect on the kallsyms function.
#   
#    (3) Although rmmod modifies the module state with the machine "stopped", it
#        hasn't removed the metadata from the module metadata list, meaning that
#        as soon as the machine is "restarted", the metadata can be observed by
#        kallsyms.
#   
#        It's not possible to say that an item in that list should be ignored if
#        it's state is marked as inactive - you can't get at the state information
#        because you can't trust the metadata in which it is embedded.
#   
#        Furthermore, list linkage information is embedded in the metadata too, so
#        you can't trust that either...
#   
#    (4) kallsyms may be walking the module list without a lock whilst either
#        insmod or rmmod are busy changing it. insmod probably isn't a problem
#        since nothing is going a way, but rmmod is as it's deleting an entry.
#   
#    (5) Therefore nothing that uses these functions can in any way trust any
#        pointers to "static" data (such as module symbol names or module names)
#        that are returned.
#   
#    (6) On ppc64 the problems are exacerbated since the hypervisor may reschedule
#        bits of the kernel, making operations that appear adjacent occur a long
#        time apart.
#   
#   This patch fixes the race by only linking/unlinking modules into/from the
#   master module list with the machine in the "stopped" state. This means that
#   any "static" information can be trusted as far as the next kernel reschedule
#   on any given CPU without the need to hold any locks.
#   
#   However, I'm not sure how this is affected by preemption. I suspect more work
#   may need to be done in that case, but I'm not entirely sure.
#   
#   This also means that rmmod has to bump the machine into the stopped state
#   twice... but since that shouldn't be a common operation, I don't think that's
#   a problem.
#   
#   I've amended this patch to not get spinlocks whilst in the machine locked
#   state - there's no point as nothing else can be holding spinlocks.
#   
#   Signed-Off-By: David Howells <dhowells@redhat.com>
#   Signed-off-by: Andrew Morton <akpm@osdl.org>
#   Signed-off-by: Linus Torvalds <torvalds@osdl.org>
# 
# kernel/module.c
#   2005/03/07 20:41:36-08:00 dhowells@redhat.com +25 -8
#   Fix kallsyms/insmod/rmmod race
# 
# kernel/kallsyms.c
#   2005/03/07 21:14:30-08:00 dhowells@redhat.com +14 -2
#   Fix kallsyms/insmod/rmmod race
# 
# include/linux/stop_machine.h
#   2005/03/07 20:41:36-08:00 dhowells@redhat.com +1 -1
#   Fix kallsyms/insmod/rmmod race
# 
diff -Nru a/include/linux/stop_machine.h b/include/linux/stop_machine.h
--- a/include/linux/stop_machine.h	2005-03-12 18:56:52 +01:00
+++ b/include/linux/stop_machine.h	2005-03-12 18:56:52 +01:00
@@ -8,7 +8,7 @@
 #include <linux/cpu.h>
 #include <asm/system.h>
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_STOP_MACHINE) && defined(CONFIG_SMP)
 /**
  * stop_machine_run: freeze the machine on all CPUs and run this function
  * @fn: the function to run
diff -Nru a/kernel/kallsyms.c b/kernel/kallsyms.c
--- a/kernel/kallsyms.c	2005-03-12 18:56:52 +01:00
+++ b/kernel/kallsyms.c	2005-03-12 18:56:52 +01:00
@@ -146,13 +146,20 @@
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
@@ -204,7 +211,12 @@
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
diff -Nru a/kernel/module.c b/kernel/module.c
--- a/kernel/module.c	2005-03-12 18:56:52 +01:00
+++ b/kernel/module.c	2005-03-12 18:56:52 +01:00
@@ -472,7 +472,7 @@
 };
 
 /* Whole machine is stopped with interrupts off when this runs. */
-static inline int __try_stop_module(void *_sref)
+static int __try_stop_module(void *_sref)
 {
 	struct stopref *sref = _sref;
 
@@ -1072,14 +1072,22 @@
 	kobject_unregister(&mod->mkobj.kobj);
 }
 
+/*
+ * unlink the module with the whole machine is stopped with interrupts off
+ * - this defends against kallsyms not taking locks
+ */
+static int __unlink_module(void *_mod)
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
 
@@ -1732,6 +1740,17 @@
 	goto free_hdr;
 }
 
+/*
+ * link the module with the whole machine is stopped with interrupts off
+ * - this defends against kallsyms not taking locks
+ */
+static int __link_module(void *_mod)
+{
+	struct module *mod = _mod;
+	list_add(&mod->list, &modules);
+	return 0;
+}
+
 /* This is where the real work happens */
 asmlinkage long
 sys_init_module(void __user *umod,
@@ -1766,9 +1785,7 @@
 
 	/* Now sew it into the lists.  They won't access us, since
            strong_try_module_get() will fail. */
-	spin_lock_irq(&modlist_lock);
-	list_add(&mod->list, &modules);
-	spin_unlock_irq(&modlist_lock);
+	stop_machine_run(__link_module, mod, NR_CPUS);
 
 	/* Drop lock so they can recurse */
 	up(&module_mutex);


