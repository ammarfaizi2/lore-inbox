Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263868AbTDJDWX (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 23:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263883AbTDJDWX (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 23:22:23 -0400
Received: from dp.samba.org ([66.70.73.150]:48562 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263868AbTDJDWT (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 23:22:19 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: davidm@hpl.hp.com
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [patch] add module_arch_cleanup() and improve module debugging output 
In-reply-to: Your message of "Wed, 09 Apr 2003 14:54:48 MST."
             <200304092154.h39Lsmop011302@napali.hpl.hp.com> 
Date: Thu, 10 Apr 2003 12:16:52 +1000
Message-Id: <20030410033400.962822C09B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200304092154.h39Lsmop011302@napali.hpl.hp.com> you write:
> Rusty,
> 
> The patch below updates the other platforms with
> module_arch_cleanup().  Also, I added more debug output to
> kernel/module.c since I found it useful to be able to see the final
> section layout.

Yep, looks great.

Linus, please apply if you haven't already.

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: module_arch_cleanup hook
Author: David Mosberger
Status: Trivial

D: The patch below updates the other platforms with
D: module_arch_cleanup().  Also, I added more debug output to
D: kernel/module.c since I found it useful to be able to see the final
D: section layout.

diff -Nru a/kernel/module.c b/kernel/module.c
--- a/kernel/module.c	Wed Apr  9 14:49:49 2003
+++ b/kernel/module.c	Wed Apr  9 14:49:49 2003
@@ -909,6 +909,9 @@
 	list_del(&mod->list);
 	spin_unlock_irq(&modlist_lock);
 
+	/* Arch-specific cleanup. */
+	module_arch_cleanup(mod);
+
 	/* Module unload stuff */
 	module_unload_free(mod);
 
@@ -1241,6 +1244,7 @@
 	mod->module_init = ptr;
 
 	/* Transfer each section which specifies SHF_ALLOC */
+	DEBUGP("final section addresses:\n");
 	for (i = 0; i < hdr->e_shnum; i++) {
 		void *dest;
 
@@ -1258,6 +1262,7 @@
 			       sechdrs[i].sh_size);
 		/* Update sh_addr to point to copy in image. */
 		sechdrs[i].sh_addr = (unsigned long)dest;
+		DEBUGP("\t0x%lx %s\n", sechdrs[i].sh_addr, secstrings + sechdrs[i].sh_name);
 	}
 	/* Module has been moved. */
 	mod = (void *)sechdrs[modindex].sh_addr;
diff -Nru a/include/linux/moduleloader.h b/include/linux/moduleloader.h
--- a/include/linux/moduleloader.h	Wed Apr  9 14:49:49 2003
+++ b/include/linux/moduleloader.h	Wed Apr  9 14:49:49 2003
@@ -41,4 +41,7 @@
 		    const Elf_Shdr *sechdrs,
 		    struct module *mod);
 
+/* Any cleanup needed when module leaves. */
+void module_arch_cleanup(struct module *mod);
+
 #endif
diff -Nru a/arch/alpha/kernel/module.c b/arch/alpha/kernel/module.c
--- a/arch/alpha/kernel/module.c	Wed Apr  9 14:49:48 2003
+++ b/arch/alpha/kernel/module.c	Wed Apr  9 14:49:48 2003
@@ -300,3 +300,8 @@
 {
 	return 0;
 }
+
+void
+module_arch_cleanup(struct module *mod)
+{
+}
diff -Nru a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
--- a/arch/arm/kernel/module.c	Wed Apr  9 14:49:48 2003
+++ b/arch/arm/kernel/module.c	Wed Apr  9 14:49:48 2003
@@ -159,3 +159,8 @@
 {
 	return 0;
 }
+
+void
+module_arch_cleanup(struct module *mod)
+{
+}
diff -Nru a/arch/i386/kernel/module.c b/arch/i386/kernel/module.c
--- a/arch/i386/kernel/module.c	Wed Apr  9 14:49:49 2003
+++ b/arch/i386/kernel/module.c	Wed Apr  9 14:49:49 2003
@@ -110,3 +110,7 @@
 {
 	return 0;
 }
+
+void module_arch_cleanup(struct module *mod)
+{
+}
diff -Nru a/arch/parisc/kernel/module.c b/arch/parisc/kernel/module.c
--- a/arch/parisc/kernel/module.c	Wed Apr  9 14:49:50 2003
+++ b/arch/parisc/kernel/module.c	Wed Apr  9 14:49:50 2003
@@ -568,3 +568,7 @@
 #endif
 	return 0;
 }
+
+void module_arch_cleanup(struct module *mod)
+{
+}
diff -Nru a/arch/ppc/kernel/module.c b/arch/ppc/kernel/module.c
--- a/arch/ppc/kernel/module.c	Wed Apr  9 14:49:48 2003
+++ b/arch/ppc/kernel/module.c	Wed Apr  9 14:49:48 2003
@@ -269,3 +269,7 @@
 {
 	return 0;
 }
+
+void module_arch_cleanup(struct module *mod)
+{
+}
diff -Nru a/arch/ppc64/kernel/module.c b/arch/ppc64/kernel/module.c
--- a/arch/ppc64/kernel/module.c	Wed Apr  9 14:49:49 2003
+++ b/arch/ppc64/kernel/module.c	Wed Apr  9 14:49:49 2003
@@ -386,3 +386,7 @@
 		      me->extable.entry + me->extable.num_entries);
 	return 0;
 }
+
+void module_arch_cleanup(struct module *mod)
+{
+}
diff -Nru a/arch/s390/kernel/module.c b/arch/s390/kernel/module.c
--- a/arch/s390/kernel/module.c	Wed Apr  9 14:49:49 2003
+++ b/arch/s390/kernel/module.c	Wed Apr  9 14:49:49 2003
@@ -348,3 +348,7 @@
 		kfree(me->arch.syminfo);
 	return 0;
 }
+
+void module_arch_cleanup(struct module *mod)
+{
+}
diff -Nru a/arch/s390x/kernel/module.c b/arch/s390x/kernel/module.c
--- a/arch/s390x/kernel/module.c	Wed Apr  9 14:49:50 2003
+++ b/arch/s390x/kernel/module.c	Wed Apr  9 14:49:50 2003
@@ -374,3 +374,7 @@
 		kfree(me->arch.syminfo);
 	return 0;
 }
+
+void module_arch_cleanup(struct module *mod)
+{
+}
diff -Nru a/arch/sparc/kernel/module.c b/arch/sparc/kernel/module.c
--- a/arch/sparc/kernel/module.c	Wed Apr  9 14:49:48 2003
+++ b/arch/sparc/kernel/module.c	Wed Apr  9 14:49:48 2003
@@ -145,3 +145,7 @@
 {
 	return 0;
 }
+
+void module_arch_cleanup(struct module *mod)
+{
+}
diff -Nru a/arch/sparc64/kernel/module.c b/arch/sparc64/kernel/module.c
--- a/arch/sparc64/kernel/module.c	Wed Apr  9 14:49:49 2003
+++ b/arch/sparc64/kernel/module.c	Wed Apr  9 14:49:49 2003
@@ -273,3 +273,7 @@
 {
 	return 0;
 }
+
+void module_arch_cleanup(struct module *mod)
+{
+}
diff -Nru a/arch/v850/kernel/module.c b/arch/v850/kernel/module.c
--- a/arch/v850/kernel/module.c	Wed Apr  9 14:49:49 2003
+++ b/arch/v850/kernel/module.c	Wed Apr  9 14:49:49 2003
@@ -230,3 +230,8 @@
 
 	return 0;
 }
+
+void
+module_arch_cleanup(struct module *mod)
+{
+}
diff -Nru a/arch/x86_64/kernel/module.c b/arch/x86_64/kernel/module.c
--- a/arch/x86_64/kernel/module.c	Wed Apr  9 14:49:49 2003
+++ b/arch/x86_64/kernel/module.c	Wed Apr  9 14:49:49 2003
@@ -231,3 +231,7 @@
 {
 	return 0;
 }
+
+void module_arch_cleanup(struct module *mod)
+{
+}
