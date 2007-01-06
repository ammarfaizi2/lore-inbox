Return-Path: <linux-kernel-owner+w=401wt.eu-S932141AbXAFUKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbXAFUKt (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 15:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbXAFUKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 15:10:49 -0500
Received: from extu-mxob-1.symantec.com ([216.10.194.28]:7616 "EHLO
	extu-mxob-1.symantec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932141AbXAFUKs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 15:10:48 -0500
X-AuditID: d80ac21c-9df38bb00000021a-93-45a002472609 
Date: Sat, 6 Jan 2007 20:11:00 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Linus Torvalds <torvalds@osdl.org>, Marcus Meissner <meissner@suse.de>,
       Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>,
       Dave Jones <davej@codemonkey.org.uk>,
       Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: revert PIE randomization?
Message-ID: <Pine.LNX.4.64.0701062005001.22171@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 06 Jan 2007 20:10:47.0474 (UTC) FILETIME=[C1059120:01C731CE]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's a lot of gaps in my understanding, but I think 2.6.20-rc's
59287c0913cc9a6c75712a775f6c1c1ef418ef3b (randomize PIE binaries)
needs to be reverted for now.

Running any 2.6.20-rc kernel on i386 openSUSE 10.2, my kernel builds
occasionally fail with an ld.so error when building some .o or .ko
(then succeed when restarted in the same tree immediately after): e.g. 

  LD [M]  fs/vfat/vfat.o
Inconsistency detected by ld.so: rtld.c: 1217: dl_main:
 Assertion `_rtld_local._dl_rtld_map.l_libname' failed!
make[2]: *** [fs/vfat/vfat.o] Error 127

I guessed a TLB problem, but no, bisection points to the random PIE
patch.  I've no idea how it arrives at the particular failure seen,
but the code does look wrong to me:

		vaddr = elf_ppnt->p_vaddr;
		if (loc->elf_ex.e_type == ET_EXEC || load_addr_set) {
			elf_flags |= MAP_FIXED;
		} else if (loc->elf_ex.e_type == ET_DYN) {
			/* Try and get dynamic programs out of the way of the
			 * default mmap base, as well as whatever program they
			 * might try to exec.  This is because the brk will
			 * follow the loader, and is not movable.  */
			if (current->flags & PF_RANDOMIZE)
				load_bias = randomize_range(0x10000,
							    ELF_ET_DYN_BASE,
							    0);
			else
				load_bias = ELF_ET_DYN_BASE;
			load_bias = ELF_PAGESTART(load_bias - vaddr);
		}
		error = elf_map(bprm->file, load_bias + vaddr, elf_ppnt,
				elf_prot, elf_flags);

Isn't that randomization, anywhere from 0x10000 to ELF_ET_DYN_BASE,
sure to place the ET_DYN from time to time just where the comment says
it's trying to avoid?  I assume that somehow results in the error reported.

No problem yet seen on x86_64 or ppc64, I suppose because the address
space is so much larger.  No problem seen before openSUSE 10.2, while
running 2.6.19-rc-mm which contained the patch: hmm, the oS /bin/bash
is a "shared object" rather than the familiar "executable", maybe that
has something to do with it.  No problem seen if I revert that patch;
nor if I add on the patch below, which does a much more limited
randomization - but my guess is others will improve upon it.

(I probably have my priorities wrong, going up from ELF_ET_DYN_BASE
because I don't like calling the top of a range _BASE: with stack
coming randomly down on most arches, maybe it'd better go below.

And I notice that Andi added a personality & ADDR_NO_RANDOMIZE check
into randomize_stack_top: I cannot see why that's necessary there,
but if it is, then should the ET_DYN case add it too?)

Hugh

--- 2.6.20-rc3/fs/binfmt_elf.c	2007-01-01 10:30:40.000000000 +0000
+++ linux/fs/binfmt_elf.c	2007-01-05 17:01:31.000000000 +0000
@@ -509,6 +509,12 @@ out:
 #define STACK_RND_MASK 0x7ff		/* with 4K pages 8MB of VA */
 #endif
 
+/*
+ * Though STACK_RND_MASK was introduced to govern randomizing the stack,
+ * it should also be appropriate to govern randomizing the ET_DYN base.
+ */
+#define ELF_ET_DYN_HIBASE (ELF_ET_DYN_BASE + ((STACK_RND_MASK+1)<<PAGE_SHIFT))
+
 static unsigned long randomize_stack_top(unsigned long stack_top)
 {
 	unsigned int random_variable = 0;
@@ -855,9 +861,8 @@ static int load_elf_binary(struct linux_
 			 * might try to exec.  This is because the brk will
 			 * follow the loader, and is not movable.  */
 			if (current->flags & PF_RANDOMIZE)
-				load_bias = randomize_range(0x10000,
-							    ELF_ET_DYN_BASE,
-							    0);
+				load_bias = randomize_range(ELF_ET_DYN_BASE,
+							ELF_ET_DYN_HIBASE, 0);
 			else
 				load_bias = ELF_ET_DYN_BASE;
 			load_bias = ELF_PAGESTART(load_bias - vaddr);
