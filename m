Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266142AbUGJF2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266142AbUGJF2Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 01:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266143AbUGJF2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 01:28:23 -0400
Received: from palrel10.hp.com ([156.153.255.245]:16593 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S266142AbUGJF2T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 01:28:19 -0400
Date: Fri, 9 Jul 2004 22:28:15 -0700
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200407100528.i6A5SF8h020094@napali.hpl.hp.com>
To: mingo@redhat.com, suresh.b.siddha@intel.com, jun.nakajima@intel.com,
       akpm@osdl.org, torvalds@osdl.org
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: serious performance regression due to NX patch
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-To: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The "No eXecute patch for x86" causes a serious exec() performance
degradation on ia64 since it ends up incorrectly turning on the
execute protection on all segments (since most ia64 binaries don't
have a gnu_stack program-header).

The patch below fixes the problem by turning on VM_EXEC and VM_MAYEXEC
only if VM_DATA_DEFAULT_FLAGS mentions them.  Note that on ia64, the
value of VM_DATA_DEFAULT_FLAGS depends on the personality (to support
x86 binaries) and hence I had to move the setting of "def_flags" down
a bit to a point after SET_PERSONALITY() has been done.

Please apply.

	--david

===== fs/binfmt_elf.c 1.78 vs edited =====
--- 1.78/fs/binfmt_elf.c	2004-06-29 07:43:10 -07:00
+++ edited/fs/binfmt_elf.c	2004-07-09 21:53:05 -07:00
@@ -493,8 +493,8 @@
 	char passed_fileno[6];
 	struct files_struct *files;
 	int executable_stack = EXSTACK_DEFAULT;
-	unsigned long def_flags = 0;
-	
+	unsigned long no_gnu_stack, def_flags = 0;
+
 	/* Get the exec-header */
 	elf_ex = *((struct elfhdr *) bprm->buf);
 
@@ -627,8 +627,7 @@
 				executable_stack = EXSTACK_DISABLE_X;
 			break;
 		}
-	if (i == elf_ex.e_phnum)
-		def_flags |= VM_EXEC | VM_MAYEXEC;
+	no_gnu_stack = (i == elf_ex.e_phnum);
 
 	/* Some simple consistency checks for the interpreter */
 	if (elf_interpreter) {
@@ -662,6 +661,10 @@
 		/* Executables without an interpreter also need a personality  */
 		SET_PERSONALITY(elf_ex, ibcs2_interpreter);
 	}
+
+	/* Now that personality is set, we can use VM_DATA_DEFAULT_FLAGS.  */
+	if (no_gnu_stack)
+		def_flags |= VM_DATA_DEFAULT_FLAGS & (VM_EXEC | VM_MAYEXEC);
 
 	/* OK, we are done with that, now set up the arg stuff,
 	   and then start this sucker up */
