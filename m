Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267854AbTAMFF4>; Mon, 13 Jan 2003 00:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267855AbTAMFFz>; Mon, 13 Jan 2003 00:05:55 -0500
Received: from dp.samba.org ([66.70.73.150]:49864 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267854AbTAMFFo>;
	Mon, 13 Jan 2003 00:05:44 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, tridge@samba.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: [PATCH] Check compiler version, SMP and PREEMPT.
Date: Mon, 13 Jan 2003 16:13:19 +1100
Message-Id: <20030113051434.DC2092C09F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply if you agree.

Tridge reported getting burned by gcc 3.2 compiled (Debian) XFree
modules not working on his gcc 2.95-compiled kernel.  Interestingly,
(as Tridge points out) modversions probably would not have caught the
change in spinlock size, since the ioctl takes a void*, not a
structure pointer...

Simple bitmask, allows extension later, and prevents this kind of
thing (maybe a warning is more appropriate: this refuses to load it).

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Module Sanity Check
Author: Rusty Russell
Status: Tested on 2.5.56

D: Stores a simple bitmask in the module structure, for SMP, PREEMPT
D: and compiler version (spinlocks change size on UP with gcc major,
D: at least).  Also printks on modules with common section (becoming
D: an FAQ for third-party modules).

diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5-bk/include/linux/module.h working-2.5-bk-compilerversion/include/linux/module.h
--- linux-2.5-bk/include/linux/module.h	Mon Jan 13 11:17:32 2003
+++ working-2.5-bk-compilerversion/include/linux/module.h	Mon Jan 13 15:33:03 2003
@@ -32,6 +32,21 @@
 #define MODULE_SYMBOL_PREFIX ""
 #endif
 
+/* Simply sanity stamp to place in each module */
+#ifdef CONFIG_SMP
+#define MODULE_SANITY_SMP 1
+#else
+#define MODULE_SANITY_SMP 0
+#endif
+#ifdef CONFIG_PREEMPT
+#define MODULE_SANITY_PREEMPT 1
+#else
+#define MODULE_SANITY_PREEMPT 0
+#endif
+#define MODULE_SANITY						\
+	((MODULE_SANITY_SMP<<16) | (MODULE_SANITY_PREEMPT<<17) 	\
+	 | (__GNUC__<<8) | (__GNUC_MINOR__))
+
 #define MODULE_NAME_LEN (64 - sizeof(unsigned long))
 struct kernel_symbol
 {
@@ -168,6 +183,9 @@ struct module
 {
 	enum module_state state;
 
+	/* Simple compatibility bitmask (useful for non-modversions). */
+	int sanity;
+
 	/* Member of list of modules */
 	struct list_head list;
 
@@ -378,6 +396,7 @@ __attribute__((section(".gnu.linkonce.th
 #ifdef CONFIG_MODULE_UNLOAD
 	.exit = cleanup_module,
 #endif
+	.sanity = MODULE_SANITY,
 };
 #endif /* KBUILD_MODNAME */
 #endif /* MODULE */
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5-bk/kernel/module.c working-2.5-bk-compilerversion/kernel/module.c
--- linux-2.5-bk/kernel/module.c	Fri Jan 10 10:55:43 2003
+++ working-2.5-bk-compilerversion/kernel/module.c	Mon Jan 13 16:07:40 2003
@@ -846,6 +846,8 @@ static int simplify_symbols(Elf_Shdr *se
 			/* We compiled with -fno-common.  These are not
 			   supposed to happen.  */
 			DEBUGP("Common symbol: %s\n", strtab + sym[i].st_name);
+			printk("%s: probably not cimpiled with -fno-common\n",
+			       mod->name);
 			return -ENOEXEC;
 
 		case SHN_ABS:
@@ -1094,6 +1096,13 @@ static struct module *load_module(void *
 		goto free_hdr;
 	}
 	mod = (void *)sechdrs[modindex].sh_addr;
+
+	if (mod->sanity != MODULE_SANITY) {
+		printk(KERN_ERR "Module %s version %08x not %08x\n",
+		       mod->name, mod->sanity, MODULE_SANITY);
+		err = -ENOEXEC;
+		goto free_hdr;
+	}
 
 	/* Now copy in args */
 	err = strlen_user(uargs);
