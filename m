Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbVBFLxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbVBFLxA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 06:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbVBFLw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 06:52:59 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:17939 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261351AbVBFLsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 06:48:09 -0500
Date: Sun, 6 Feb 2005 11:47:59 +0000
From: Arjan van de Ven <arjan@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, torvalds@osdl.org, mingo@elte.hu,
       linux-kernel@vger.kernel.org, drepper@redhat.com
Subject: Re: [PROPOSAL/PATCH] Remove PT_GNU_STACK support before 2.6.11
Message-ID: <20050206114758.GA8437@infradead.org>
References: <20050206113635.GA30109@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050206113635.GA30109@wotan.suse.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2005 at 12:36:35PM +0100, Andi Kleen wrote:

> PT_GNU_STACK assumes that any program with a PT_GNU_STACK header
> always pass correct PROT_EXEC flags to mmap/mprotect etc. before
> allocating mappings. 

that is incorrect and was introduced later


> Worse is that even when the program has trampolines and has PT_GNU_STACK
> header with an E bit on the stack it still won't get an executable
> heap by default  (this is what broke grub) 

this I can fix easy, see the patch below

the problem is in the read_implies_exec() design, it passed in "does it have
a PT_GNU_STACK flag" not the value. Easy fix.


Your main objection is that *incorrect* programs that assume they can
execute malloc() code without PROT_EXEC protection. For legacy binaries
keeping this behavior makes sense, no objection from me.

For newly compiled programs this is just wrong and incorrect.

You mention grub (which has RWE and the patch below thus makes that work)
and mono. mono has patches for this on their mailinglist and bugzilla since
2003 according to google, I'm surprised the novell mono guys haven't fixed
this bug in their code.

FWIW all jvm's don't suffer from this. They are either legacy binaries or
mprotect properly (only i386 traditionally had this behavior, all others
already required PROT_EXEC anyway so any half portable app already did this,
as well as any app portable to BSD since they enforce this on x86 as well)

So I rather see the patch below merged instead; it fixes the worst problems
(RWE not marking the heap executable) while keeping this useful feature
enabled.


Signed-off-by: Arjan van de Ven <arjan@infradead.org>


diff -purN linux-2.6.11-rc2-bk4/fs/binfmt_elf.c linux-foo/fs/binfmt_elf.c
--- linux-2.6.11-rc2-bk4/fs/binfmt_elf.c	2005-01-26 18:24:50.000000000 +0100
+++ linux-foo/fs/binfmt_elf.c	2005-02-06 12:29:02.000000000 +0100
@@ -757,7 +757,7 @@ static int load_elf_binary(struct linux_
 	/* Do this immediately, since STACK_TOP as used in setup_arg_pages
 	   may depend on the personality.  */
 	SET_PERSONALITY(loc->elf_ex, ibcs2_interpreter);
-	if (elf_read_implies_exec(loc->elf_ex, have_pt_gnu_stack))
+	if (elf_read_implies_exec(loc->elf_ex, executable_stack))
 		current->personality |= READ_IMPLIES_EXEC;
 
 	arch_pick_mmap_layout(current->mm);
diff -purN linux-2.6.11-rc2-bk4/include/asm-i386/elf.h linux-foo/include/asm-i386/elf.h
--- linux-2.6.11-rc2-bk4/include/asm-i386/elf.h	2004-12-24 22:35:15.000000000 +0100
+++ linux-foo/include/asm-i386/elf.h	2005-02-06 12:29:55.000000000 +0100
@@ -123,7 +123,7 @@ typedef struct user_fxsr_struct elf_fpxr
  * An executable for which elf_read_implies_exec() returns TRUE will
  * have the READ_IMPLIES_EXEC personality flag set automatically.
  */
-#define elf_read_implies_exec(ex, have_pt_gnu_stack)	(!(have_pt_gnu_stack))
+#define elf_read_implies_exec(ex, executable_stack)	(executable_stack != EXSTACK_DISABLE_X)
 
 extern int dump_task_regs (struct task_struct *, elf_gregset_t *);
 extern int dump_task_fpu (struct task_struct *, elf_fpregset_t *);
diff -purN linux-2.6.11-rc2-bk4/include/asm-ia64/elf.h linux-foo/include/asm-ia64/elf.h
--- linux-2.6.11-rc2-bk4/include/asm-ia64/elf.h	2004-12-24 22:35:18.000000000 +0100
+++ linux-foo/include/asm-ia64/elf.h	2005-02-06 12:32:47.000000000 +0100
@@ -186,8 +186,8 @@ extern void ia64_elf_core_copy_regs (str
 
 #ifdef __KERNEL__
 #define SET_PERSONALITY(ex, ibcs2)	set_personality(PER_LINUX)
-#define elf_read_implies_exec(ex, have_pt_gnu_stack)					\
-	(!(have_pt_gnu_stack) && ((ex).e_flags & EF_IA_64_LINUX_EXECUTABLE_STACK) != 0)
+#define elf_read_implies_exec(ex, executable_stack)					\
+	((executable_stack!=EXSTACK_DISABLE_X) && ((ex).e_flags & EF_IA_64_LINUX_EXECUTABLE_STACK) != 0)
 
 struct task_struct;
 
diff -purN linux-2.6.11-rc2-bk4/include/asm-x86_64/elf.h linux-foo/include/asm-x86_64/elf.h
--- linux-2.6.11-rc2-bk4/include/asm-x86_64/elf.h	2004-12-24 22:35:24.000000000 +0100
+++ linux-foo/include/asm-x86_64/elf.h	2005-02-06 12:31:39.000000000 +0100
@@ -147,14 +147,7 @@ extern void set_personality_64bit(void);
  * An executable for which elf_read_implies_exec() returns TRUE will
  * have the READ_IMPLIES_EXEC personality flag set automatically.
  */
-#define elf_read_implies_exec(ex, have_pt_gnu_stack)	(!(have_pt_gnu_stack))
-	
-/*
- * An executable for which elf_read_implies_exec() returns TRUE will
- * have the READ_IMPLIES_EXEC personality flag set automatically.
- */
-#define elf_read_implies_exec_binary(ex, have_pt_gnu_stack)   \
-	 (!(have_pt_gnu_stack))
+#define elf_read_implies_exec(ex, executable_stack)	(executable_stack != EXSTACK_DISABLE_X)
 
 extern int dump_task_regs (struct task_struct *, elf_gregset_t *);
 extern int dump_task_fpu (struct task_struct *, elf_fpregset_t *);
