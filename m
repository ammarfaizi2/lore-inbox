Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266662AbUGQAfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266662AbUGQAfT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 20:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266664AbUGQAfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 20:35:18 -0400
Received: from palrel13.hp.com ([156.153.255.238]:12491 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S266662AbUGQAfE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 20:35:04 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16632.29749.550202.245115@napali.hpl.hp.com>
Date: Fri, 16 Jul 2004 17:35:01 -0700
To: Ingo Molnar <mingo@redhat.com>
Cc: davidm@hpl.hp.com, suresh.b.siddha@intel.com, jun.nakajima@intel.com,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: serious performance regression due to NX patch
In-Reply-To: <Pine.LNX.4.58.0407110536130.2248@devserv.devel.redhat.com>
References: <200407100528.i6A5SF8h020094@napali.hpl.hp.com>
	<Pine.LNX.4.58.0407110437310.26065@devserv.devel.redhat.com>
	<Pine.LNX.4.58.0407110536130.2248@devserv.devel.redhat.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sun, 11 Jul 2004 05:39:23 -0400 (EDT), Ingo Molnar <mingo@redhat.com> said:

  Ingo> On Sun, 11 Jul 2004, Ingo Molnar wrote:

  >> ok, agreed. I'll check that it still does the right thing on x86.

  Ingo> it doesnt seem to do the right thing for !PT_GNU_STACK applications on 
  Ingo> x86:

How about the patch below (on top of Linus' current bk tree)?  Only
platforms which had VM_DATA_DEFAULT_FLAGS changed (as a result of the
NX patch) will need to define LEGACY_VM_DATA_DEFAULT_FLAGS to the old
value.  AFAIK, that's x86 only, so the impact is very minimal and
should retain the existing behavior on all other platforms.

	--david

===== fs/binfmt_elf.c 1.80 vs edited =====
--- 1.80/fs/binfmt_elf.c	2004-07-16 16:46:22 -07:00
+++ edited/fs/binfmt_elf.c	2004-07-16 17:25:26 -07:00
@@ -662,9 +662,9 @@
 		SET_PERSONALITY(elf_ex, ibcs2_interpreter);
 	}
 
-	/* Now that personality is set, we can use VM_DATA_DEFAULT_FLAGS.  */
+	/* Now that personality is set, we can use LEGACY_VM_DATA_DEFAULT_FLAGS.  */
 	if (no_gnu_stack)
-		def_flags |= VM_DATA_DEFAULT_FLAGS & (VM_EXEC | VM_MAYEXEC);
+		def_flags |= LEGACY_VM_DATA_DEFAULT_FLAGS & (VM_EXEC | VM_MAYEXEC);
 
 	/* OK, we are done with that, now set up the arg stuff,
 	   and then start this sucker up */
===== include/asm-i386/page.h 1.26 vs edited =====
--- 1.26/include/asm-i386/page.h	2004-07-01 17:00:00 -07:00
+++ edited/include/asm-i386/page.h	2004-07-16 17:24:26 -07:00
@@ -142,6 +142,7 @@
 
 #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
+#define LEGACY_VM_DATA_DEFAULT_FLAGS	(VM_DATA_DEFAULT_FLAGS | VM_EXEC)
 
 #endif /* __KERNEL__ */
 
===== include/linux/mm.h 1.138 vs edited =====
--- 1.138/include/linux/mm.h	2004-07-06 22:19:25 -07:00
+++ edited/include/linux/mm.h	2004-07-16 17:23:41 -07:00
@@ -136,6 +136,10 @@
 #define VM_HUGETLB	0x00400000	/* Huge TLB Page VM */
 #define VM_NONLINEAR	0x00800000	/* Is non-linear (remap_file_pages) */
 
+#ifndef LEGACY_VM_DATA_DEFAULT_FLAGS
+#define LEGACY_VM_DATA_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS
+#endif
+
 #ifndef VM_STACK_DEFAULT_FLAGS		/* arch can override this */
 #define VM_STACK_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS
 #endif
