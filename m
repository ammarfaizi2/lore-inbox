Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265815AbUFDSC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265815AbUFDSC2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 14:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265889AbUFDSC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 14:02:28 -0400
Received: from fmr05.intel.com ([134.134.136.6]:918 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S265815AbUFDSCO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 14:02:14 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [announce] [patch] NX (No eXecute) support for x86,   2.6.7-rc2-bk2
Date: Fri, 4 Jun 2004 11:01:44 -0700
Message-ID: <7F740D512C7C1046AB53446D37200173018E5149@scsmsx402.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [announce] [patch] NX (No eXecute) support for x86,   2.6.7-rc2-bk2
thread-index: AcRKWBTPFcygV3E2R9WzQMH7I8gVgwAASR/Q
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Ingo Molnar" <mingo@elte.hu>, "Linus Torvalds" <torvalds@osdl.org>
Cc: "Andy Lutomirski" <luto@myrealbox.com>, "Andi Kleen" <ak@suse.de>,
       "Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, <arjanv@redhat.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
X-OriginalArrivalTime: 04 Jun 2004 18:01:46.0129 (UTC) FILETIME=[000A9010:01C44A5E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Ingo Molnar [mailto:mingo@elte.hu]
>Sent: Friday, June 04, 2004 10:20 AM
>To: Linus Torvalds
>Cc: Andy Lutomirski; Andi Kleen; Kernel Mailing List; Andrew Morton;
>arjanv@redhat.com; Siddha, Suresh B; Nakajima, Jun
>Subject: Re: [announce] [patch] NX (No eXecute) support for x86,
2.6.7-rc2-
>bk2
>
>
>correction to the table:
>
>>  PT_GNU_STACK not present: legacy app, stack and heap executable
>>  PT_GNU_STACK present but X: heap non-executable, stack executable
>>  PT_GNU_STACK present and !X: both heap and stack are non-executable.
>>
>> this method is what is used in Fedora and it works pretty well.
>
Thanks for the correction. This sounds good to me. To me this simply
means the heap is non-executable by default in Linux if compiled by the
new gcc:
- the compiler controls if the stack is executable or not. 
- legacy apps would be more secure if recompiled by the new gcc
- if an app is broken when recompiled by the new gcc, the app has a bug,
or security issue. We should fix it, but in the meantime we could make
it run by removing PT_GNU_STACK, or by using the old binary, for
example. 

Jun

>the patch below implements this simple and pretty robust logic ontop of
>the -AF NX patch.
>
>in fact it's more conservative than what we have in Fedora because it
>will turn on executability even for data mmap()s. (in theory there
could
>be third party apps that expect a data mmap to be executable on x86
even
>if it's not PROT_EXEC.)
>
>I've test-booted it on an athlon64 box running FC2 and have tested an
>old PT_GNU_STACK-less binary and it indeed has all data mappings
>executable, explicitly. (I've also test-booted it on an x86 box with an
>older distribution installed - works as expected.)
>
>newly-compiled applications that have the PT_GNU_STACK flag (either as
X
>or NX) will have the heap non-executable, and the stack executable
>depending on the value of the flag.
>
>hm?
>
>	Ingo
>
>--- linux/fs/binfmt_elf.c
>+++ linux/fs/binfmt_elf.c
>@@ -491,6 +491,7 @@ static int load_elf_binary(struct linux_
> 	char passed_fileno[6];
> 	struct files_struct *files;
> 	int executable_stack = EXSTACK_DEFAULT;
>+	unsigned long def_flags = 0;
>
> 	/* Get the exec-header */
> 	elf_ex = *((struct elfhdr *) bprm->buf);
>@@ -622,7 +623,10 @@ static int load_elf_binary(struct linux_
> 				executable_stack = EXSTACK_ENABLE_X;
> 			else
> 				executable_stack = EXSTACK_DISABLE_X;
>+			break;
> 		}
>+	if (i == elf_ex.e_phnum)
>+		def_flags |= VM_EXEC | VM_MAYEXEC;
>
> 	/* Some simple consistency checks for the interpreter */
> 	if (elf_interpreter) {
>@@ -690,6 +694,7 @@ static int load_elf_binary(struct linux_
> 	current->mm->end_code = 0;
> 	current->mm->mmap = NULL;
> 	current->flags &= ~PF_FORKNOEXEC;
>+	current->mm->def_flags = def_flags;
>
> 	/* Do this immediately, since STACK_TOP as used in
setup_arg_pages
> 	   may depend on the personality.  */
>--- linux/fs/exec.c
>+++ linux/fs/exec.c
>@@ -431,6 +431,7 @@ int setup_arg_pages(struct linux_binprm
> 			mpnt->vm_flags = VM_STACK_FLAGS & ~VM_EXEC;
> 		else
> 			mpnt->vm_flags = VM_STACK_FLAGS;
>+		mpnt->vm_flags |= mm->def_flags;
> 		mpnt->vm_page_prot = protection_map[mpnt->vm_flags &
0x7];
> 		insert_vm_struct(mm, mpnt);
> 		mm->total_vm = (mpnt->vm_end - mpnt->vm_start) >>
PAGE_SHIFT;
>--- linux/include/asm-i386/page.h
>+++ linux/include/asm-i386/page.h
>@@ -138,7 +138,7 @@ static __inline__ int get_order(unsigned
>
> #define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >>
PAGE_SHIFT)
>
>-#define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
>+#define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | \
> 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
>
> #endif /* __KERNEL__ */

