Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264638AbUGSXYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264638AbUGSXYi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 19:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264701AbUGSXYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 19:24:37 -0400
Received: from palrel11.hp.com ([156.153.255.246]:40150 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S264638AbUGSXYd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 19:24:33 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16636.17877.90080.590149@napali.hpl.hp.com>
Date: Mon, 19 Jul 2004 15:06:13 -0700
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, davidm@hpl.hp.com
Subject: Re: [patch] NX: clean up legacy binary support, 2.6.8-rc2
In-Reply-To: <20040718084406.GA4766@elte.hu>
References: <20040718084406.GA4766@elte.hu>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sun, 18 Jul 2004 10:44:06 +0200, Ingo Molnar <mingo@elte.hu> said:

  Ingo> the attached patch cleans up legacy x86 binary support by
  Ingo> introducing a new personality bit: READ_IMPLIES_EXEC, and
  Ingo> implements Linus' suggestion to add the PROT_EXEC bit on the
  Ingo> two affected syscall entry places, sys_mprotect() and
  Ingo> sys_mmap(). If this bit is set then PROT_READ will also add
  Ingo> the PROT_EXEC bit - as expected by legacy x86 binaries. The
  Ingo> ELF loader will automatically set this bit when it encounters
  Ingo> a legacy binary.

This looks better, but is still insufficient.  Remember: on some
platforms, you'll want to support READ_IMPLIES_EXEC differently
depending on personality (e.g, native binary vs. x86 binary).

Isn't something along the lines of the patch below cleaner, easier to
understand, and more flexible?

Please apply, if there are no objections (I'll send the necessary ia64
bits separately).

Thanks,

	--david

===== fs/binfmt_elf.c 1.81 vs edited =====
--- 1.81/fs/binfmt_elf.c	2004-07-19 13:27:08 -07:00
+++ edited/fs/binfmt_elf.c	2004-07-19 14:55:49 -07:00
@@ -492,7 +492,7 @@
   	struct exec interp_ex;
 	char passed_fileno[6];
 	struct files_struct *files;
-	int executable_stack = EXSTACK_DEFAULT;
+	int have_pt_gnu_stack, executable_stack = EXSTACK_DEFAULT;
 	unsigned long def_flags = 0;
 	
 	/* Get the exec-header */
@@ -627,10 +627,7 @@
 				executable_stack = EXSTACK_DISABLE_X;
 			break;
 		}
-#ifdef LEGACY_BINARIES
-	if (i == elf_ex.e_phnum)
-		current->personality |= READ_IMPLIES_EXEC;
-#endif
+	have_pt_gnu_stack = (i < elf_ex.e_phnum);
 
 	/* Some simple consistency checks for the interpreter */
 	if (elf_interpreter) {
@@ -703,6 +700,8 @@
 	/* Do this immediately, since STACK_TOP as used in setup_arg_pages
 	   may depend on the personality.  */
 	SET_PERSONALITY(elf_ex, ibcs2_interpreter);
+	if (elf_read_implies_exec(elf_ex, have_pt_gnu_stack))
+		current->personality |= READ_IMPLIES_EXEC;
 
 	/* Do this so that we can load the interpreter, if need be.  We will
 	   change some of these later */
===== include/asm-i386/elf.h 1.12 vs edited =====
--- 1.12/include/asm-i386/elf.h	2004-07-17 17:00:00 -07:00
+++ edited/include/asm-i386/elf.h	2004-07-19 14:55:39 -07:00
@@ -120,10 +120,10 @@
 #define SET_PERSONALITY(ex, ibcs2) do { } while (0)
 
 /*
- * A legacy binary, when loaded by the ELF loader, will have the
- * READ_IMPLIES_EXEC personality flag set automatically:
+ * An executable for which elf_read_implies_exec() returns TRUE will
+ * have the READ_IMPLIES_EXEC personality flag set automatically.
  */
-#define LEGACY_BINARIES
+#define elf_read_implies_exec_binary(ex, have_pt_gnu_stack)	(!(have_pt_gnu_stack))
 
 extern int dump_task_regs (struct task_struct *, elf_gregset_t *);
 extern int dump_task_fpu (struct task_struct *, elf_fpregset_t *);
===== include/linux/elf.h 1.28 vs edited =====
--- 1.28/include/linux/elf.h	2004-05-20 10:55:24 -07:00
+++ edited/include/linux/elf.h	2004-07-19 14:56:03 -07:00
@@ -4,6 +4,13 @@
 #include <linux/types.h>
 #include <asm/elf.h>
 
+#ifndef elf_read_implies_exec
+  /* Executables for which elf_read_implies_exec() returns TRUE will
+     have the READ_IMPLIES_EXEC personality flag set automatically.
+     Override in asm/elf.h as needed.  */
+# define elf_read_implies_exec(ex, have_pt_gnu_stack)	0
+#endif
+
 /* 32-bit ELF base types. */
 typedef __u32	Elf32_Addr;
 typedef __u16	Elf32_Half;
