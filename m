Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbVBFLmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbVBFLmo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 06:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbVBFLmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 06:42:38 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:40639 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261305AbVBFLgg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 06:36:36 -0500
Date: Sun, 6 Feb 2005 12:36:35 +0100
From: Andi Kleen <ak@suse.de>
To: akpm@osdl.org, torvalds@osdl.org
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: [PROPOSAL/PATCH] Remove PT_GNU_STACK support before 2.6.11
Message-ID: <20050206113635.GA30109@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hallo,

I'm getting more and more reports that the PT_GNU_STACK change breaks
a lot of programs. In particular it breaks grub which implies that nobody
could have really tested it. Mono seems to break too, there are undoubtedly
others. There are some reports of Wine breaking too, I suspect
they are related to this too. The testing for this was obviously not very 
effective.

PT_GNU_STACK assumes that any program with a PT_GNU_STACK header
always pass correct PROT_EXEC flags to mmap/mprotect etc. before
allocating mappings. 

The problem is that people are recompiling these programs with
new compilers, the new compilers set PT_GNU_STACK and then they
break. Sometimes obviously (like grub), I bet in some other cases
they break only in obscure cases that are hard to catch.

Worse is that even when the program has trampolines and has PT_GNU_STACK
header with an E bit on the stack it still won't get an executable
heap by default  (this is what broke grub) 

This is a major source of source level and binary incompatibility. 

People reporting this to me all the time for x86-64 because few people
run PAE/NX enabled kernels on i386, and without PAE this breakage
is not visible. Also you need a NX capable CPU of course,
and basically all NX capable CPUs are able to run x86-64, so a 
lot of them run 64bit kernels. That is why the full impact of these
changes was not felt on i386.

I'm not really willing to handle all these problems on the x86-64 side, 
for what was ultimatively a half baked change comming from i386. 

My proposal is to turn this all off at least for 2.6.11. 

If it should be reenabled later probably needs a lot of discussion.
IMHO it's not a very good idea in 2.6 because it's an extremly invasive change
in the ABI and the security advantages of using NX are not that great anyways. 

I understand that some people want to have it as part of a marketing
campaign as "answer to Microsoft SP2", but IMHO source & binary compatibility
is too important to be sacrified for such things. If they really
want it they can continue to maintain it as private patches.

I also don't remember a thread on linux-kernel discussion these
trade offs and what significant impact it has on user space.
Before reenabling it I think we would need a lot of discussion
if it's really worth it, and a lot more education of user land
people on what they need to do to cope with this.

One way would be to have special command line flags or sysctls like
x86-64 used to have for this (but they were removed as "too confusing"),
and then only people who know what they are doing or can tolerate
some of their programs breaking can enable it.

But forcing it on all users doesn't seem to work very well.

Here's a patch to disable PT_GNU_STACK parsing for now. I would 
prefer it to be merged before 2.6.11.

Thanks,
-Andi

Remove PT_GNU_STACK support because user land is not ready for it yet.

Signed-off-by: Andi Kleen <ak@suse.de>

diff -u linux-2.6.11rc3/fs/binfmt_elf.c-o linux-2.6.11rc3/fs/binfmt_elf.c
--- linux-2.6.11rc3/fs/binfmt_elf.c-o	2005-02-04 09:13:18.000000000 +0100
+++ linux-2.6.11rc3/fs/binfmt_elf.c	2005-02-06 12:30:59.000000000 +0100
@@ -675,6 +675,13 @@
 		elf_ppnt++;
 	}
 
+#if 1
+	/* 
+	 * The user land is not ready for PT_GNU_STACK yet. Disable
+	 * it for now.
+	 */
+	have_pt_gnu_stack = 0;
+#else
 	elf_ppnt = elf_phdata;
 	for (i = 0; i < loc->elf_ex.e_phnum; i++, elf_ppnt++)
 		if (elf_ppnt->p_type == PT_GNU_STACK) {
@@ -685,6 +692,7 @@
 			break;
 		}
 	have_pt_gnu_stack = (i < loc->elf_ex.e_phnum);
+#endif
 
 	/* Some simple consistency checks for the interpreter */
 	if (elf_interpreter) {


