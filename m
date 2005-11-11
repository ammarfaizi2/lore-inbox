Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbVKKIjX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbVKKIjX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 03:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbVKKIjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 03:39:22 -0500
Received: from i121.durables.org ([64.81.244.121]:10958 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932252AbVKKIgJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 03:36:09 -0500
Date: Fri, 11 Nov 2005 02:35:55 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
X-PatchBomber: http://selenic.com/scripts/mailpatches
In-Reply-To: <13.282480653@selenic.com>
Message-Id: <14.282480653@selenic.com>
Subject: [PATCH 13/15] misc: Configure ELF core dump support
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

configurable support for ELF core dumps

   text    data     bss     dec     hex filename
3330172  529036  190556 4049764  3dcb64 vmlinux-baseline
3325552  528912  190556 4045020  3db8dc vmlinux-no-elf

add/remove: 0/8 grow/shrink: 0/0 up/down: 0/-4424 (-4424)
function                                     old     new   delta
fill_note                                     32       -     -32
maydump                                       58       -     -58
dump_seek                                     67       -     -67
writenote                                    180       -    -180
elf_dump_thread_status                       274       -    -274
fill_psinfo                                  308       -    -308
fill_prstatus                                466       -    -466
elf_core_dump                               3039       -   -3039

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6.14-misc/fs/binfmt_elf.c
===================================================================
--- 2.6.14-misc.orig/fs/binfmt_elf.c	2005-11-09 11:27:14.000000000 -0800
+++ 2.6.14-misc/fs/binfmt_elf.c	2005-11-09 11:27:20.000000000 -0800
@@ -58,7 +58,7 @@ extern int dump_fpu (struct pt_regs *, e
  * If we don't support core dumping, then supply a NULL so we
  * don't even try.
  */
-#ifdef USE_ELF_CORE_DUMP
+#if defined(USE_ELF_CORE_DUMP) && defined(CONFIG_ELF_CORE)
 static int elf_core_dump(long signr, struct pt_regs * regs, struct file * file);
 #else
 #define elf_core_dump	NULL
@@ -1108,7 +1108,7 @@ out:
  * Note that some platforms still use traditional core dumps and not
  * the ELF core dump.  Each platform can select it as appropriate.
  */
-#ifdef USE_ELF_CORE_DUMP
+#if defined(USE_ELF_CORE_DUMP) && defined(CONFIG_ELF_CORE)
 
 /*
  * ELF core dumper
Index: 2.6.14-misc/init/Kconfig
===================================================================
--- 2.6.14-misc.orig/init/Kconfig	2005-11-09 11:27:18.000000000 -0800
+++ 2.6.14-misc/init/Kconfig	2005-11-09 11:27:20.000000000 -0800
@@ -341,6 +341,12 @@ config FULL_PANIC
           Disabling compiles out the explanations for panics, saving
 	  string space. Use with caution.
 
+config ELF_CORE
+	default y
+	bool "Enable ELF core dumps" if EMBEDDED
+	help
+	  Enable support for generating core dumps. Disabling saves about 4k.
+
 config BASE_FULL
 	default y
 	bool "Enable full-sized data structures for core" if EMBEDDED
