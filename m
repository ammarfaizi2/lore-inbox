Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263655AbUCPR0g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 12:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264155AbUCPRSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 12:18:42 -0500
Received: from fed1mtao01.cox.net ([68.6.19.244]:13495 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP id S261541AbUCPRQj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 12:16:39 -0500
Date: Tue, 16 Mar 2004 10:16:35 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Colin Leroy <colin@colino.net>
Cc: linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6.5-rc1: compilation error on ppc32
Message-ID: <20040316171635.GJ14221@smtp.west.cox.net>
References: <05bf01c40b4d$553bdb70$3cc8a8c0@epro.dom>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05bf01c40b4d$553bdb70$3cc8a8c0@epro.dom>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2004 at 12:53:44PM +0100, Colin Leroy wrote:

> Hi,
> 
> 2.6.5-rc1 compilation fails at arch/ppc/syslib/indirect_pci.c lines 47 and
> 86: variable dev isn't defined.
> The change breaking it is a change from out_be32() to PCI_CFG_OUT (line
> 17513 of the patch at
> http://www.kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.5-rc1.bz2 ,

The following is an uncleaned up (and slightly incomplete, there's
changes to <asm-ppc/dma-mapping.h> needed) patch that gets things
compiling for me.  I'm compiling now for a Motorola LoPEC and I'll
actually test the changes shortly.  If it works, I'll split it up
and send to akpm.

===== arch/ppc/defconfig 1.26 vs edited =====
--- 1.26/arch/ppc/defconfig	Fri Feb  6 08:30:36 2004
+++ edited/arch/ppc/defconfig	Tue Mar 16 10:06:13 2004
@@ -722,7 +722,7 @@
 CONFIG_PMAC_APM_EMU=y
 CONFIG_PMAC_BACKLIGHT=y
 # CONFIG_MAC_FLOPPY is not set
-CONFIG_MAC_SERIAL=m
+CONFIG_MAC_SERIAL=n
 CONFIG_ADB=y
 CONFIG_ADB_MACIO=y
 CONFIG_INPUT_ADBHID=y
===== arch/ppc/configs/common_defconfig 1.26 vs edited =====
--- 1.26/arch/ppc/configs/common_defconfig	Fri Feb  6 08:30:36 2004
+++ edited/arch/ppc/configs/common_defconfig	Tue Mar 16 10:06:15 2004
@@ -721,7 +721,7 @@
 CONFIG_PMAC_APM_EMU=y
 CONFIG_PMAC_BACKLIGHT=y
 # CONFIG_MAC_FLOPPY is not set
-CONFIG_MAC_SERIAL=m
+CONFIG_MAC_SERIAL=n
 CONFIG_ADB=y
 CONFIG_ADB_MACIO=y
 CONFIG_INPUT_ADBHID=y
===== arch/ppc/syslib/indirect_pci.c 1.13 vs edited =====
--- 1.13/arch/ppc/syslib/indirect_pci.c	Tue Mar 16 08:49:56 2004
+++ edited/arch/ppc/syslib/indirect_pci.c	Tue Mar 16 10:01:42 2004
@@ -44,8 +44,8 @@
 			cfg_type = 1;
 
 	PCI_CFG_OUT(hose->cfg_addr, 					 
-		 (0x80000000 | ((dev->bus->number - hose->bus_offset) << 16) 
-		  | (dev->devfn << 8) | ((offset & 0xfc) | cfg_type)));	
+		 (0x80000000 | ((bus->number - hose->bus_offset) << 16) 
+		  | (devfn << 8) | ((offset & 0xfc) | cfg_type)));	
 
 	/*
 	 * Note: the caller has already checked that offset is
@@ -83,8 +83,8 @@
 			cfg_type = 1;
 
 	PCI_CFG_OUT(hose->cfg_addr, 					 
-		 (0x80000000 | ((dev->bus->number - hose->bus_offset) << 16) 
-		  | (dev->devfn << 8) | ((offset & 0xfc) | cfg_type)));	
+		 (0x80000000 | ((bus->number - hose->bus_offset) << 16) 
+		  | (devfn << 8) | ((offset & 0xfc) | cfg_type)));	
 
 	/*
 	 * Note: the caller has already checked that offset is
===== include/asm-ppc/pci.h 1.29 vs edited =====
--- 1.29/include/asm-ppc/pci.h	Tue Mar 16 08:50:02 2004
+++ edited/include/asm-ppc/pci.h	Tue Mar 16 09:56:13 2004
@@ -200,7 +200,7 @@
 {
 	BUG_ON(direction == PCI_DMA_NONE);
 
-	consistent_sync_for_cpu(bus_to_virt(dma_handle), size, direction);
+	consistent_sync(bus_to_virt(dma_handle), size, direction);
 }
 
 static inline void pci_dma_sync_single_for_device(struct pci_dev *hwdev,
@@ -209,7 +209,7 @@
 {
 	BUG_ON(direction == PCI_DMA_NONE);
 
-	consistent_sync_for_device(bus_to_virt(dma_handle), size, direction);
+	consistent_sync(bus_to_virt(dma_handle), size, direction);
 }
 
 /* Make physical memory consistent for a set of streaming
@@ -227,8 +227,8 @@
 	BUG_ON(direction == PCI_DMA_NONE);
 
 	for (i = 0; i < nelems; i++, sg++)
-		consistent_sync_page_for_cpu(sg->page, sg->offset,
-					     sg->length, direction);
+		consistent_sync_page(sg->page, sg->offset,
+				     sg->length, direction);
 }
 
 static inline void pci_dma_sync_sg_for_device(struct pci_dev *hwdev,
@@ -240,8 +240,8 @@
 	BUG_ON(direction == PCI_DMA_NONE);
 
 	for (i = 0; i < nelems; i++, sg++)
-		consistent_sync_page_for_device(sg->page, sg->offset,
-						sg->length, direction);
+		consistent_sync_page(sg->page, sg->offset,
+				     sg->length, direction);
 }
 
 /* Return whether the given PCI device DMA address mask can
===== include/asm-ppc/unistd.h 1.32 vs edited =====
--- 1.32/include/asm-ppc/unistd.h	Tue Mar 16 08:50:02 2004
+++ edited/include/asm-ppc/unistd.h	Tue Mar 16 09:42:07 2004
@@ -415,10 +415,10 @@
 int sys_pipe(int __user *fildes);
 int sys_ptrace(long request, long pid, long addr, long data);
 struct sigaction;
-asmlinkage long sys_rt_sigaction(int sig,
-				const struct sigaction __user *act,
-				struct sigaction __user *oact,
-				size_t sigsetsize);
+long sys_rt_sigaction(int sig,
+		      const struct sigaction __user *act,
+		      struct sigaction __user *oact,
+		      size_t sigsetsize);
 
 #endif /* __KERNEL_SYSCALLS__ */
 

> which strangely enough doesn't show in bkweb interface).

It does, you just have to go back quite a ways.  We all hate bk patches
now :)

-- 
Tom Rini
http://gate.crashing.org/~trini/
