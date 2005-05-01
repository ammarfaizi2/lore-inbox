Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbVEAKVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbVEAKVW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 06:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261583AbVEAKVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 06:21:22 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:64211 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S261580AbVEAKVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 06:21:01 -0400
Subject: [patch 1/1] Uml: obvious compile fixes for x86-64 Subarch and x86 regression fixes [for 2.6.12]
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Sun, 01 May 2005 20:40:41 +0200
Message-Id: <20050501184043.8347F400F1@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

This patch does some totally trivial compilation fixes. It also restores the
debugregs manipulation, which was commented out simply because it doesn't
compile on x86_64 (we haven't yet implemented there debugregs handling).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.12-paolo/arch/um/kernel/ptrace.c         |    4 +++-
 linux-2.6.12-paolo/arch/um/sys-x86_64/syscalls.c   |    2 ++
 linux-2.6.12-paolo/include/asm-um/ipc.h            |    7 +------
 linux-2.6.12-paolo/include/asm-um/page.h           |    3 +++
 linux-2.6.12-paolo/include/asm-um/pgtable-3level.h |    2 +-
 5 files changed, 10 insertions(+), 8 deletions(-)

diff -puN arch/um/kernel/ptrace.c~uml-simple-x86-64-compilation arch/um/kernel/ptrace.c
--- linux-2.6.12/arch/um/kernel/ptrace.c~uml-simple-x86-64-compilation	2005-05-01 20:37:38.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/kernel/ptrace.c	2005-05-01 20:37:38.000000000 +0200
@@ -98,12 +98,14 @@ long sys_ptrace(long request, long pid, 
 		if(addr < MAX_REG_OFFSET){
 			tmp = getreg(child, addr);
 		}
+#if defined(CONFIG_UML_X86) && !defined(CONFIG_64BIT)
 		else if((addr >= offsetof(struct user, u_debugreg[0])) &&
 			(addr <= offsetof(struct user, u_debugreg[7]))){
 			addr -= offsetof(struct user, u_debugreg[0]);
 			addr = addr >> 2;
 			tmp = child->thread.arch.debugregs[addr];
 		}
+#endif
 		ret = put_user(tmp, (unsigned long __user *) data);
 		break;
 	}
@@ -127,7 +129,7 @@ long sys_ptrace(long request, long pid, 
 			ret = putreg(child, addr, data);
 			break;
 		}
-#if 0 /* XXX x86_64 */
+#if defined(CONFIG_UML_X86) && !defined(CONFIG_64BIT)
 		else if((addr >= offsetof(struct user, u_debugreg[0])) &&
 			(addr <= offsetof(struct user, u_debugreg[7]))){
 			  addr -= offsetof(struct user, u_debugreg[0]);
diff -puN arch/um/sys-x86_64/syscalls.c~uml-simple-x86-64-compilation arch/um/sys-x86_64/syscalls.c
--- linux-2.6.12/arch/um/sys-x86_64/syscalls.c~uml-simple-x86-64-compilation	2005-05-01 20:37:38.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/sys-x86_64/syscalls.c	2005-05-01 20:37:38.000000000 +0200
@@ -7,6 +7,8 @@
 #include "linux/linkage.h"
 #include "linux/slab.h"
 #include "linux/shm.h"
+#include "linux/utsname.h"
+#include "linux/personality.h"
 #include "asm/uaccess.h"
 #define __FRAME_OFFSETS
 #include "asm/ptrace.h"
diff -puN include/asm-um/ipc.h~uml-simple-x86-64-compilation include/asm-um/ipc.h
--- linux-2.6.12/include/asm-um/ipc.h~uml-simple-x86-64-compilation	2005-05-01 20:37:38.000000000 +0200
+++ linux-2.6.12-paolo/include/asm-um/ipc.h	2005-05-01 20:37:38.000000000 +0200
@@ -1,6 +1 @@
-#ifndef __UM_IPC_H
-#define __UM_IPC_H
-
-#include "asm/arch/ipc.h"
-
-#endif
+#include <asm-generic/ipc.h>
diff -puN include/asm-um/page.h~uml-simple-x86-64-compilation include/asm-um/page.h
--- linux-2.6.12/include/asm-um/page.h~uml-simple-x86-64-compilation	2005-05-01 20:37:38.000000000 +0200
+++ linux-2.6.12-paolo/include/asm-um/page.h	2005-05-01 20:37:38.000000000 +0200
@@ -45,6 +45,9 @@ typedef struct { unsigned long pgd; } pg
 	({ (pte).pte_high = (phys) >> 32; \
 	   (pte).pte_low = (phys) | pgprot_val(prot); })
 
+#define pmd_val(x)	((x).pmd)
+#define __pmd(x) ((pmd_t) { (x) } )
+
 typedef unsigned long long pfn_t;
 typedef unsigned long long phys_t;
 
diff -puN include/asm-um/pgtable-3level.h~uml-simple-x86-64-compilation include/asm-um/pgtable-3level.h
--- linux-2.6.12/include/asm-um/pgtable-3level.h~uml-simple-x86-64-compilation	2005-05-01 20:37:38.000000000 +0200
+++ linux-2.6.12-paolo/include/asm-um/pgtable-3level.h	2005-05-01 20:37:38.000000000 +0200
@@ -149,7 +149,7 @@ static inline pmd_t pfn_pmd(pfn_t page_n
 
 #define pte_to_pgoff(p) ((p).pte >> 32)
 
-#define pgoff_to_pte(off) ((pte_t) { ((off) < 32) | _PAGE_FILE })
+#define pgoff_to_pte(off) ((pte_t) { ((off) << 32) | _PAGE_FILE })
 
 #else
 
_
