Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261825AbULJVqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbULJVqg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 16:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbULJVqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 16:46:35 -0500
Received: from users.ccur.com ([208.248.32.211]:2582 "EHLO flmx.iccur.com")
	by vger.kernel.org with ESMTP id S261825AbULJVpp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 16:45:45 -0500
Message-ID: <41BA1904.4090904@ccur.com>
Date: Fri, 10 Dec 2004 16:45:40 -0500
From: John Blackwood <john.blackwood@ccur.com>
Reply-To: john.blackwood@ccur.com
Organization: Concurrent Computer Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040301
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andi Kleen <ak@muc.de>
Subject: [PATCH] include/asm-x86_64/pgtable.h pgd_offset_gate()
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Dec 2004 21:45:41.0503 (UTC) FILETIME=[9838B0F0:01C4DF01]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andi,

We noticed a problem on x86_64 platforms where a /proc read of the
vsyscall area (address 0xffffffffff600000) would cause the kernel to
oops in get_user_pages().

I believe that the fix is to pull in the include/asm-ia64/pgtable.h
changes for pgd_offset_gate() into the x86_64 pgtable.h header file.

This seems to fix the problem nicely for us.

The original ia64 patch was:

# ChangeSet
#   2004/07/28 23:01:30-07:00 davidm@napali.hpl.hp.com
#   [PATCH] Make get_user_pages() work again for ia64 gate area
#
#   Changeset
#
#     roland@redhat.com[torvalds]|ChangeSet|20040624165002|30880
#
#   inadvertently broke ia64 because the patch assumed that 
pgd_offset_k() is
#   just an optimization of pgd_offset(), which it is not.  This patch fixes
#   the problem by introducing pgd_offset_gate().  On architectures on which
#   the gate area lives in the user's address-space, this should be 
aliased to
#   pgd_offset() and on architectures on which the gate area lives in the
#   kernel-mapped segment, this should be aliased to pgd_offset_k().
#
#   This bug was found and tracked down by Peter Chubb.
#
#   Signed-off-by: <davidm@hpl.hp.com>
#   Signed-off-by: Andrew Morton <akpm@osdl.org>
#   Signed-off-by: Linus Torvalds <torvalds@osdl.org>


The changes to pgtable.h for x86_64 are below.

Thank you for your time and considerations.



diff -ru linux-2.6.9/include/asm-x86_64/pgtable.h 
linux/include/asm-x86_64/pgtable.h
--- linux-2.6.9/include/asm-x86_64/pgtable.h    2004-10-18 
17:54:40.000000000 -0400
+++ linux/include/asm-x86_64/pgtable.h  2004-12-10 16:00:30.434277001 -0500
@@ -340,6 +340,11 @@
         return __pgd_offset_k((pgd_t *)__va(addr), address);
  }

+/* Look up a pgd entry in the gate area.  On x86_64, the gate-area
+   resides in the kernel-mapped segment, hence we use pgd_offset_k()
+   here.  */
+#define pgd_offset_gate(mm, addr)      pgd_offset_k(addr)
+
  #define pgd_offset(mm, address) ((mm)->pgd+pgd_index(address))

  /* PMD  - Level 2 access */
@@ -442,6 +447,7 @@
  #define __HAVE_ARCH_PTEP_SET_WRPROTECT
  #define __HAVE_ARCH_PTEP_MKDIRTY
  #define __HAVE_ARCH_PTE_SAME
+#define __HAVE_ARCH_PGD_OFFSET_GATE
  #include <asm-generic/pgtable.h>

  #endif /* _X86_64_PGTABLE_H */

