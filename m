Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262549AbVF2Vuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262549AbVF2Vuo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 17:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262651AbVF2Vuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 17:50:44 -0400
Received: from aun.it.uu.se ([130.238.12.36]:16825 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262549AbVF2Vu0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 17:50:26 -0400
Date: Wed, 29 Jun 2005 23:50:17 +0200 (MEST)
Message-Id: <200506292150.j5TLoHiA020924@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH 2.6.12-mm2] perfctr: syscall numbering fixups
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The inclusion of the pselect6 and ppoll syscalls in 2.6.12-mm2
broke ia32 emulation on x86_64, and ppc32 emulation on ppc64,
for the perfctr syscalls. This patch fixes this, and also corrects
a few comments in the ppc32 syscall tables.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 arch/ppc/kernel/misc.S           |    4 ++--
 arch/ppc64/kernel/misc.S         |    8 +++++++-
 arch/x86_64/ia32/ia32entry.S     |    4 +++-
 include/asm-x86_64/ia32_unistd.h |    4 ++--
 4 files changed, 14 insertions(+), 6 deletions(-)

diff -rupN linux-2.6.12-mm2/arch/ppc/kernel/misc.S linux-2.6.12-mm2.perfctr-syscall-numbers-fixups/arch/ppc/kernel/misc.S
--- linux-2.6.12-mm2/arch/ppc/kernel/misc.S	2005-06-29 21:54:04.000000000 +0200
+++ linux-2.6.12-mm2.perfctr-syscall-numbers-fixups/arch/ppc/kernel/misc.S	2005-06-29 23:38:08.000000000 +0200
@@ -1453,7 +1453,7 @@ _GLOBAL(sys_call_table)
 	.long sys_ppoll
 	.long sys_ioprio_set
 	.long sys_ioprio_get
-	.long sys_vperfctr_open		/* 275 */
+	.long sys_vperfctr_open
 	.long sys_vperfctr_control
 	.long sys_vperfctr_write
-	.long sys_vperfctr_read
+	.long sys_vperfctr_read		/* 280 */
diff -rupN linux-2.6.12-mm2/arch/ppc64/kernel/misc.S linux-2.6.12-mm2.perfctr-syscall-numbers-fixups/arch/ppc64/kernel/misc.S
--- linux-2.6.12-mm2/arch/ppc64/kernel/misc.S	2005-06-29 21:54:04.000000000 +0200
+++ linux-2.6.12-mm2.perfctr-syscall-numbers-fixups/arch/ppc64/kernel/misc.S	2005-06-29 23:38:08.000000000 +0200
@@ -1129,6 +1129,12 @@ _GLOBAL(sys_call_table32)
 	.llong .compat_sys_waitid
 	.llong .compat_sys_pselect6
 	.llong .compat_sys_ppoll
+	.llong .sys_ni_syscall		/* 275 reserved for sys_ioprio_set */
+	.llong .sys_ni_syscall		/* 276 reserved for sys_ioprio_get */
+	.llong .sys_vperfctr_open
+	.llong .sys_vperfctr_control
+	.llong .sys_vperfctr_write
+	.llong .sys_vperfctr_read	/* 280 */
 
 	.balign 8
 _GLOBAL(sys_call_table)
@@ -1412,5 +1418,5 @@ _GLOBAL(sys_call_table)
 	.llong .sys_vperfctr_open
 	.llong .sys_vperfctr_control
 	.llong .sys_vperfctr_write
-	.llong .sys_vperfctr_read
+	.llong .sys_vperfctr_read	/* 280 */
 
diff -rupN linux-2.6.12-mm2/arch/x86_64/ia32/ia32entry.S linux-2.6.12-mm2.perfctr-syscall-numbers-fixups/arch/x86_64/ia32/ia32entry.S
--- linux-2.6.12-mm2/arch/x86_64/ia32/ia32entry.S	2005-06-29 21:54:04.000000000 +0200
+++ linux-2.6.12-mm2.perfctr-syscall-numbers-fixups/arch/x86_64/ia32/ia32entry.S	2005-06-29 23:38:08.000000000 +0200
@@ -595,8 +595,10 @@ ia32_sys_call_table:
 	.quad sys_add_key
 	.quad sys_request_key
 	.quad sys_keyctl
+	.quad quiet_ni_syscall		/* pselect6 */
+	.quad quiet_ni_syscall		/* ppoll */	/* 290 */
 	.quad quiet_ni_syscall		/* sys_ioprio_set */
-	.quad quiet_ni_syscall		/* sys_ioprio_get */	/* 290 */
+	.quad quiet_ni_syscall		/* sys_ioprio_get */
 	.quad sys_vperfctr_open
 	.quad sys_vperfctr_control
 	.quad sys_vperfctr_write
diff -rupN linux-2.6.12-mm2/include/asm-x86_64/ia32_unistd.h linux-2.6.12-mm2.perfctr-syscall-numbers-fixups/include/asm-x86_64/ia32_unistd.h
--- linux-2.6.12-mm2/include/asm-x86_64/ia32_unistd.h	2005-06-29 21:54:08.000000000 +0200
+++ linux-2.6.12-mm2.perfctr-syscall-numbers-fixups/include/asm-x86_64/ia32_unistd.h	2005-06-29 23:38:08.000000000 +0200
@@ -294,11 +294,11 @@
 #define __NR_ia32_add_key		286
 #define __NR_ia32_request_key	287
 #define __NR_ia32_keyctl		288
-#define __NR_ia32_vperfctr_open		291
+#define __NR_ia32_vperfctr_open		293
 #define __NR_ia32_vperfctr_control	(__NR_ia32_vperfctr_open+1)
 #define __NR_ia32_vperfctr_write	(__NR_ia32_vperfctr_open+2)
 #define __NR_ia32_vperfctr_read		(__NR_ia32_vperfctr_open+3)
 
-#define IA32_NR_syscalls 295	/* must be > than biggest syscall! */
+#define IA32_NR_syscalls 297	/* must be > than biggest syscall! */
 
 #endif /* _ASM_X86_64_IA32_UNISTD_H_ */
