Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbVCEQNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbVCEQNF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 11:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261911AbVCEQNC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 11:13:02 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:62105 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S262008AbVCEQFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 11:05:17 -0500
Subject: [patch 1/1] x86_64: remove old decl (trivial)
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, blaisorblade@yahoo.it, ak@suse.de
From: blaisorblade@yahoo.it
Date: Fri, 04 Mar 2005 20:10:15 +0100
Message-Id: <20050304191016.94ED26535@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


CC: Andi Kleen <ak@suse.de>

vm_force_exec32 and friends were still alive on 2.6.9 release, but now (and in
2.6.10) they seem deleted.
I've not compile-tested this, but it seems correct. Below some history of why
I guess they were deleted (I'm including it so that you can find the changeset
which deleted the definitions but forgot the declarations in).

They were used in 2.6.9
arch/x86_64/kernel/setup64.c and arch/x86_64/ia32/sys_ia32.c to implement the
NX option:

arch/x86_64/ia32/sys_ia32.c-{
arch/x86_64/ia32/sys_ia32.c-    if (prot & PROT_READ)
arch/x86_64/ia32/sys_ia32.c:            prot |= vm_force_exec32;
arch/x86_64/ia32/sys_ia32.c-    return sys_mprotect(start,len,prot);
arch/x86_64/ia32/sys_ia32.c-}

The above sample code from 2.6.9 or'ed the mask with vm_force_exec32, which
was PROT_EXEC (NX disabled) or 0 (NX enabled) depending on the user's choice
at boot.

This was deleted because probably replaced by a check on current->personality
in do_mmap_pgoff().

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/include/asm-x86_64/page.h |    4 ----
 1 files changed, 4 deletions(-)

diff -puN include/asm-x86_64/page.h~x86-64-remove-old-decl include/asm-x86_64/page.h
--- linux-2.6.11/include/asm-x86_64/page.h~x86-64-remove-old-decl	2005-03-04 20:01:30.054785960 +0100
+++ linux-2.6.11-paolo/include/asm-x86_64/page.h	2005-03-04 20:02:27.189100224 +0100
@@ -63,10 +63,6 @@ typedef struct { unsigned long pgprot; }
 #define __pgd(x) ((pgd_t) { (x) } )
 #define __pgprot(x)	((pgprot_t) { (x) } )
 
-extern unsigned long vm_stack_flags, vm_stack_flags32;
-extern unsigned long vm_data_default_flags, vm_data_default_flags32;
-extern unsigned long vm_force_exec32;
-
 #define __START_KERNEL		0xffffffff80100000UL
 #define __START_KERNEL_map	0xffffffff80000000UL
 #define __PAGE_OFFSET           0xffff810000000000UL
_
