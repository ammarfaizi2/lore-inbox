Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131029AbQJ1HAA>; Sat, 28 Oct 2000 03:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131061AbQJ1G7v>; Sat, 28 Oct 2000 02:59:51 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:185 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131029AbQJ1G7h>; Sat, 28 Oct 2000 02:59:37 -0400
Message-ID: <39FA7919.55BF1FF2@uow.edu.au>
Date: Sat, 28 Oct 2000 17:58:33 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make agpsupport work with modversions
In-Reply-To: Your message of "Fri, 27 Oct 2000 14:25:48 BST."
	             <20075.972653148@redhat.com> <5122.972699496@ocs3.ocs-net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> I will be adding generic inter-object registration code and removing
> all vestiges of get_module_symbol this weekend.

While you're there, why not eradicate sys_get_kernel_syms()?


Also, I've been sitting on (and using) this sys_init_init_module()
bugfix for two months.  The explanation is at http://www.uwsg.iu.edu/hypermail/linux/kernel/0008.3/0379.html

Perhaps now is a good time to merge it?



--- linux-2.4.0-test10-pre5/kernel/module.c	Tue Oct 24 21:34:13 2000
+++ linux-akpm/kernel/module.c	Wed Oct 25 22:11:46 2000
@@ -6,6 +6,7 @@
 #include <linux/smp_lock.h>
 #include <asm/pgalloc.h>
 #include <linux/init.h>
+#include <linux/slab.h>
 
 /*
  * Originally by Anonymous (as far as I know...)
@@ -151,7 +152,7 @@
 sys_init_module(const char *name_user, struct module *mod_user)
 {
 	struct module mod_tmp, *mod;
-	char *name, *n_name;
+	char *name, *n_name, *name_tmp = 0;
 	long namelen, n_namelen, i, error;
 	unsigned long mod_user_size;
 	struct module_ref *dep;
@@ -185,6 +186,12 @@
 	/* Hold the current contents while we play with the user's idea
 	   of righteousness.  */
 	mod_tmp = *mod;
+	name_tmp = kmalloc(strlen(mod->name) + 1, GFP_KERNEL);	/* Where's kstrdup()? */
+	if (name_tmp == NULL) {
+		error = -ENOMEM;
+		goto err1;
+	}
+	strcpy(name_tmp, mod->name);
 
 	error = copy_from_user(mod, mod_user, sizeof(struct module));
 	if (error) {
@@ -281,9 +288,10 @@
 	   to make the I and D caches consistent.  */
 	flush_icache_range((unsigned long)mod, (unsigned long)mod + mod->size);
 
-	/* Update module references.  */
 	mod->next = mod_tmp.next;
 	mod->refs = NULL;
+
+	/* Sanity check the module's dependents */
 	for (i = 0, dep = mod->deps; i < mod->ndeps; ++i, ++dep) {
 		struct module *o, *d = dep->dep;
 
@@ -294,14 +302,21 @@
 			goto err3;
 		}
 
-		for (o = module_list; o != &kernel_module; o = o->next)
-			if (o == d) goto found_dep;
+		/* Scan the current modules for this dependency */
+		for (o = module_list; o != &kernel_module && o != d; o = o->next)
+			;
 
-		printk(KERN_ERR "init_module: found dependency that is "
+		if (o != d) {
+			printk(KERN_ERR "init_module: found dependency that is "
 				"(no longer?) a module.\n");
-		goto err3;
-		
-	found_dep:
+			goto err3;
+		}
+	}
+
+	/* Update module references.  */
+	for (i = 0, dep = mod->deps; i < mod->ndeps; ++i, ++dep) {
+		struct module *d = dep->dep;
+
 		dep->ref = mod;
 		dep->next_ref = d->refs;
 		d->refs = dep;
@@ -335,10 +350,12 @@
 	put_mod_name(n_name);
 err2:
 	*mod = mod_tmp;
+	strcpy((char *)mod->name, name_tmp);	/* We know there is room for this */
 err1:
 	put_mod_name(name);
 err0:
 	unlock_kernel();
+	kfree(name_tmp);
 	return error;
 }
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
