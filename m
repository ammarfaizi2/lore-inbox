Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266417AbTAFKKE>; Mon, 6 Jan 2003 05:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266433AbTAFKKE>; Mon, 6 Jan 2003 05:10:04 -0500
Received: from dp.samba.org ([66.70.73.150]:63460 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266417AbTAFKJ7>;
	Mon, 6 Jan 2003 05:09:59 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Miles Bader <miles@gnu.org>
Cc: torvalds@transmeta.com, rth@twiddle.net, linux-kernel@vger.kernel.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>, ak@suse.de,
       davem@redhat.com, paulus@samba.org, rmk@arm.linux.org.uk
Subject: Re: [PATCH] Modules 3/3: Sort sections 
In-reply-to: Your message of "06 Jan 2003 18:25:26 +0900."
             <buo3co6bpfd.fsf@mcspd15.ucom.lsi.nec.co.jp> 
Date: Mon, 06 Jan 2003 21:17:25 +1100
Message-Id: <20030106101836.F036D2C057@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <buo3co6bpfd.fsf@mcspd15.ucom.lsi.nec.co.jp> you write:
> The declaration of `module_frob_arch_sections' in moduleloader.h (and
> the definitions in most of the module.c files) are inconsistent with the
> definition in the PPC's module.c -- in the latter the first two
> arguments are not declared `const', whereas everyplace else they are.0

"constfrobbing considered harmful"

Linus, please apply.
Rusty.
PS.  secstrings can be modded to: if an arch can't handle discarding
     init, it simply renames the .init sections.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/arch/arm/kernel/module.c working-2.5-bk-frob/arch/arm/kernel/module.c
--- linux-2.5-bk/arch/arm/kernel/module.c	2003-01-02 14:47:57.000000000 +1100
+++ working-2.5-bk-frob/arch/arm/kernel/module.c	2003-01-06 21:13:23.000000000 +1100
@@ -67,9 +67,9 @@ void module_free(struct module *module, 
 	vfree(region);
 }
 
-int module_frob_arch_sections(const Elf_Ehdr *hdr,
-			      const Elf_Shdr *sechdrs,
-			      const char *secstrings,
+int module_frob_arch_sections(Elf_Ehdr *hdr,
+			      Elf_Shdr *sechdrs,
+			      char *secstrings,
 			      struct module *mod)
 {
 	return 0;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/arch/i386/kernel/module.c working-2.5-bk-frob/arch/i386/kernel/module.c
--- linux-2.5-bk/arch/i386/kernel/module.c	2003-01-02 14:47:57.000000000 +1100
+++ working-2.5-bk-frob/arch/i386/kernel/module.c	2003-01-06 21:12:42.000000000 +1100
@@ -45,9 +45,9 @@ void module_free(struct module *mod, voi
 }
 
 /* We don't need anything special. */
-int module_frob_arch_sections(const Elf_Ehdr *hdr,
-			      const Elf_Shdr *sechdrs,
-			      const char *secstrings,
+int module_frob_arch_sections(Elf_Ehdr *hdr,
+			      Elf_Shdr *sechdrs,
+			      char *secstrings,
 			      struct module *mod)
 {
 	return 0;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/arch/ppc/kernel/module.c working-2.5-bk-frob/arch/ppc/kernel/module.c
--- linux-2.5-bk/arch/ppc/kernel/module.c	2003-01-06 16:39:21.000000000 +1100
+++ working-2.5-bk-frob/arch/ppc/kernel/module.c	2003-01-06 21:13:15.000000000 +1100
@@ -103,7 +103,7 @@ static unsigned long get_plt_size(const 
 
 int module_frob_arch_sections(Elf32_Ehdr *hdr,
 			      Elf32_Shdr *sechdrs,
-			      const char *secstrings,
+			      char *secstrings,
 			      struct module *me)
 {
 	unsigned int i;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/arch/s390/kernel/module.c working-2.5-bk-frob/arch/s390/kernel/module.c
--- linux-2.5-bk/arch/s390/kernel/module.c	2003-01-02 14:47:58.000000000 +1100
+++ working-2.5-bk-frob/arch/s390/kernel/module.c	2003-01-06 21:13:26.000000000 +1100
@@ -51,9 +51,9 @@ void module_free(struct module *mod, voi
            table entries. */
 }
 
-int module_frob_arch_sections(const Elf_Ehdr *hdr,
-			      const Elf_Shdr *sechdrs,
-			      const char *secstrings,
+int module_frob_arch_sections(Elf_Ehdr *hdr,
+			      Elf_Shdr *sechdrs,
+			      char *secstrings,
 			      struct module *mod)
 {
 	// FIXME: add space needed for GOT/PLT
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/arch/s390x/kernel/module.c working-2.5-bk-frob/arch/s390x/kernel/module.c
--- linux-2.5-bk/arch/s390x/kernel/module.c	2003-01-02 14:47:58.000000000 +1100
+++ working-2.5-bk-frob/arch/s390x/kernel/module.c	2003-01-06 21:13:32.000000000 +1100
@@ -52,9 +52,9 @@ void module_free(struct module *mod, voi
 }
 
 /* s390/s390x needs additional memory for GOT/PLT sections. */
-int module_frob_arch_sections(const Elf_Ehdr *hdr,
-			      const Elf_Shdr *sechdrs,
-			      const char *secstrings,
+int module_frob_arch_sections(Elf_Ehdr *hdr,
+			      Elf_Shdr *sechdrs,
+			      char *secstrings,
 			      struct module *mod)
 {
 	// FIXME: add space needed for GOT/PLT
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/arch/sparc/kernel/module.c working-2.5-bk-frob/arch/sparc/kernel/module.c
--- linux-2.5-bk/arch/sparc/kernel/module.c	2003-01-02 14:47:58.000000000 +1100
+++ working-2.5-bk-frob/arch/sparc/kernel/module.c	2003-01-06 21:13:07.000000000 +1100
@@ -37,9 +37,9 @@ void module_free(struct module *mod, voi
 }
 
 /* We don't need anything special. */
-int module_frob_arch_sections(const Elf_Ehdr *hdr,
-			      const Elf_Shdr *sechdrs,
-			      const char *secstrings,
+int module_frob_arch_sections(Elf_Ehdr *hdr,
+			      Elf_Shdr *sechdrs,
+			      char *secstrings,
 			      struct module *mod)
 {
 	return 0;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/arch/sparc64/kernel/module.c working-2.5-bk-frob/arch/sparc64/kernel/module.c
--- linux-2.5-bk/arch/sparc64/kernel/module.c	2003-01-02 14:47:58.000000000 +1100
+++ working-2.5-bk-frob/arch/sparc64/kernel/module.c	2003-01-06 21:13:19.000000000 +1100
@@ -144,9 +144,9 @@ void module_free(struct module *mod, voi
 }
 
 /* We don't need anything special. */
-int module_frob_arch_sections(const Elf_Ehdr *hdr,
-			      const Elf_Shdr *sechdrs,
-			      const char *secstrings,
+int module_frob_arch_sections(Elf_Ehdr *hdr,
+			      Elf_Shdr *sechdrs,
+			      char *secstrings,
 			      struct module *mod)
 {
 	return 0;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/arch/x86_64/kernel/module.c working-2.5-bk-frob/arch/x86_64/kernel/module.c
--- linux-2.5-bk/arch/x86_64/kernel/module.c	2003-01-02 14:47:58.000000000 +1100
+++ working-2.5-bk-frob/arch/x86_64/kernel/module.c	2003-01-06 21:13:36.000000000 +1100
@@ -26,9 +26,9 @@
 #define DEBUGP(fmt...) 
  
 /* We don't need anything special. */
-int module_frob_arch_sections(const Elf_Ehdr *hdr,
-			      const Elf_Shdr *sechdrs,
-			      const char *secstrings,
+int module_frob_arch_sections(Elf_Ehdr *hdr,
+			      Elf_Shdr *sechdrs,
+			      char *secstrings,
 			      struct module *mod)
 {
 	return 0;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/include/linux/moduleloader.h working-2.5-bk-frob/include/linux/moduleloader.h
--- linux-2.5-bk/include/linux/moduleloader.h	2003-01-02 14:48:00.000000000 +1100
+++ working-2.5-bk-frob/include/linux/moduleloader.h	2003-01-06 21:12:58.000000000 +1100
@@ -16,9 +16,9 @@ unsigned long find_symbol_internal(Elf_S
 /* These must be implemented by the specific architecture */
 
 /* Adjust arch-specific sections.  Return 0 on success.  */
-int module_frob_arch_sections(const Elf_Ehdr *hdr,
-			      const Elf_Shdr *sechdrs,
-			      const char *secstrings,
+int module_frob_arch_sections(Elf_Ehdr *hdr,
+			      Elf_Shdr *sechdrs,
+			      char *secstrings,
 			      struct module *mod);
 
 /* Allocator used for allocating struct module, core sections and init
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
