Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbVCKDoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVCKDoQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 22:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261152AbVCKDoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 22:44:16 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:29322 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261566AbVCKDik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 22:38:40 -0500
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: linux-kernel@vger.kernel.org
Date: Fri, 11 Mar 2005 14:38:37 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16945.4797.594678.975856@berry.gelato.unsw.EDU.AU>
Subject: User mode drivers: part 2: PCI device handling (patch 2/2 for 2.6.11)
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


User-level drivers:  Add system calls for I386 and IA64.
Signed-Off-By: Peter Chubb <peterc@gelato.unsw.edu.au>

# 
# arch/i386/kernel/entry.S  |    4 ++++
# arch/ia64/kernel/entry.S  |    8 ++++----
# include/asm-i386/unistd.h |    6 +++++-
# include/asm-ia64/unistd.h |    4 ++++
# 4 files changed, 17 insertions(+), 5 deletions(-)
#
Index: linux-2.6.11-usrdrivers/arch/ia64/kernel/entry.S
===================================================================
--- linux-2.6.11-usrdrivers.orig/arch/ia64/kernel/entry.S	2005-03-11 13:59:28.940744950 +1100
+++ linux-2.6.11-usrdrivers/arch/ia64/kernel/entry.S	2005-03-11 13:59:41.236542676 +1100
@@ -1577,10 +1577,10 @@
 	data8 sys_add_key
 	data8 sys_request_key
 	data8 sys_keyctl
-	data8 sys_ni_syscall
-	data8 sys_ni_syscall			// 1275
-	data8 sys_ni_syscall
-	data8 sys_ni_syscall
+	data8 sys_usr_pci_open
+	data8 sys_usr_pci_mmap			// 1275
+	data8 sys_usr_pci_munmap
+	data8 sys_usr_pci_get_consistent
 	data8 sys_ni_syscall
 	data8 sys_ni_syscall
 
Index: linux-2.6.11-usrdrivers/include/asm-i386/unistd.h
===================================================================
--- linux-2.6.11-usrdrivers.orig/include/asm-i386/unistd.h	2005-03-11 13:59:28.942698059 +1100
+++ linux-2.6.11-usrdrivers/include/asm-i386/unistd.h	2005-03-11 13:59:41.245331667 +1100
@@ -294,8 +294,12 @@
 #define __NR_add_key		286
 #define __NR_request_key	287
 #define __NR_keyctl		288
+#define __NR_usr_pci_open	289
+#define __NR_usr_pci_mmap	(__NR_usr_pci_open+1)
+#define __NR_usr_pci_munmap	(__NR_usr_pci_open+2)
+#define __NR_usr_pci_get_consistent	(__NR_usr_pci_open+3)
 
-#define NR_syscalls 289
+#define NR_syscalls 293
 
 /*
  * user-visible error numbers are in the range -1 - -128: see
Index: linux-2.6.11-usrdrivers/include/asm-ia64/unistd.h
===================================================================
--- linux-2.6.11-usrdrivers.orig/include/asm-ia64/unistd.h	2005-03-11 13:59:28.942698059 +1100
+++ linux-2.6.11-usrdrivers/include/asm-ia64/unistd.h	2005-03-11 13:59:41.247284776 +1100
@@ -263,6 +263,10 @@
 #define __NR_add_key			1271
 #define __NR_request_key		1272
 #define __NR_keyctl			1273
+#define __NR_usr_pci_open               1274
+#define __NR_usr_pci_mmap               1275
+#define __NR_usr_pci_unmap              1276
+#define __NR_usr_pci_get_consistent     1277
 
 #ifdef __KERNEL__
 
Index: linux-2.6.11-usrdrivers/arch/i386/kernel/entry.S
===================================================================
--- linux-2.6.11-usrdrivers.orig/arch/i386/kernel/entry.S	2005-03-11 13:59:28.941721505 +1100
+++ linux-2.6.11-usrdrivers/arch/i386/kernel/entry.S	2005-03-11 13:59:41.248261330 +1100
@@ -864,5 +864,9 @@
 	.long sys_add_key
 	.long sys_request_key
 	.long sys_keyctl
+	.long sys_usr_pci_open
+	.long sys_usr_pci_mmap		/* 290 */
+	.long sys_usr_pci_munmap
+	.long sys_usr_pci_get_consistent
 
 syscall_table_size=(.-sys_call_table)
