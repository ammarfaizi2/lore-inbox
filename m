Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265845AbUFDRTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265845AbUFDRTc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 13:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265834AbUFDRTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 13:19:32 -0400
Received: from mx1.elte.hu ([157.181.1.137]:64961 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S265886AbUFDRTJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 13:19:09 -0400
Date: Fri, 4 Jun 2004 19:20:08 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andy Lutomirski <luto@myrealbox.com>, Andi Kleen <ak@suse.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, arjanv@redhat.com,
       suresh.b.siddha@intel.com, jun.nakajima@intel.com
Subject: Re: [announce] [patch] NX (No eXecute) support for x86,   2.6.7-rc2-bk2
Message-ID: <20040604172008.GA4993@elte.hu>
References: <20040602205025.GA21555@elte.hu> <20040603230834.GF868@wotan.suse.de> <20040604092552.GA11034@elte.hu> <200406040826.15427.luto@myrealbox.com> <Pine.LNX.4.58.0406040830200.7010@ppc970.osdl.org> <20040604160628.GA32375@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040604160628.GA32375@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


correction to the table:

>  PT_GNU_STACK not present: legacy app, stack and heap executable
>  PT_GNU_STACK present but X: heap non-executable, stack executable
>  PT_GNU_STACK present and !X: both heap and stack are non-executable.
> 
> this method is what is used in Fedora and it works pretty well.

the patch below implements this simple and pretty robust logic ontop of
the -AF NX patch.

in fact it's more conservative than what we have in Fedora because it
will turn on executability even for data mmap()s. (in theory there could
be third party apps that expect a data mmap to be executable on x86 even
if it's not PROT_EXEC.)

I've test-booted it on an athlon64 box running FC2 and have tested an
old PT_GNU_STACK-less binary and it indeed has all data mappings
executable, explicitly. (I've also test-booted it on an x86 box with an
older distribution installed - works as expected.)

newly-compiled applications that have the PT_GNU_STACK flag (either as X
or NX) will have the heap non-executable, and the stack executable
depending on the value of the flag.

hm?

	Ingo

--- linux/fs/binfmt_elf.c	
+++ linux/fs/binfmt_elf.c	
@@ -491,6 +491,7 @@ static int load_elf_binary(struct linux_
 	char passed_fileno[6];
 	struct files_struct *files;
 	int executable_stack = EXSTACK_DEFAULT;
+	unsigned long def_flags = 0;
 	
 	/* Get the exec-header */
 	elf_ex = *((struct elfhdr *) bprm->buf);
@@ -622,7 +623,10 @@ static int load_elf_binary(struct linux_
 				executable_stack = EXSTACK_ENABLE_X;
 			else
 				executable_stack = EXSTACK_DISABLE_X;
+			break;
 		}
+	if (i == elf_ex.e_phnum)
+		def_flags |= VM_EXEC | VM_MAYEXEC;
 
 	/* Some simple consistency checks for the interpreter */
 	if (elf_interpreter) {
@@ -690,6 +694,7 @@ static int load_elf_binary(struct linux_
 	current->mm->end_code = 0;
 	current->mm->mmap = NULL;
 	current->flags &= ~PF_FORKNOEXEC;
+	current->mm->def_flags = def_flags;
 
 	/* Do this immediately, since STACK_TOP as used in setup_arg_pages
 	   may depend on the personality.  */
--- linux/fs/exec.c	
+++ linux/fs/exec.c	
@@ -431,6 +431,7 @@ int setup_arg_pages(struct linux_binprm 
 			mpnt->vm_flags = VM_STACK_FLAGS & ~VM_EXEC;
 		else
 			mpnt->vm_flags = VM_STACK_FLAGS;
+		mpnt->vm_flags |= mm->def_flags;
 		mpnt->vm_page_prot = protection_map[mpnt->vm_flags & 0x7];
 		insert_vm_struct(mm, mpnt);
 		mm->total_vm = (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT;
--- linux/include/asm-i386/page.h	
+++ linux/include/asm-i386/page.h	
@@ -138,7 +138,7 @@ static __inline__ int get_order(unsigned
 
 #define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
 
-#define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
+#define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
 #endif /* __KERNEL__ */
