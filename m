Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbVAHRIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbVAHRIq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 12:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbVAHRHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 12:07:34 -0500
Received: from out008pub.verizon.net ([206.46.170.108]:52927 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S261229AbVAHREm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 12:04:42 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: paulus@samba.org, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050108170459.32690.18426.28345@localhost.localdomain>
In-Reply-To: <20050108170406.32690.36989.11853@localhost.localdomain>
References: <20050108170406.32690.36989.11853@localhost.localdomain>
Subject: [RESEND] [PATCH 7/7] ppc: remove cli()/sti() in arch/ppc/syslib/qspan_pci.c
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [209.158.220.243] at Sat, 8 Jan 2005 11:04:39 -0600
Date: Sat, 8 Jan 2005 11:04:42 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace save_flags()/resore_flags() with spin_lock_irqsave()/spin_unlock_irqrestore()
and document reasons for locking.

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-mm1-original/arch/ppc/syslib/qspan_pci.c linux-2.6.10-mm1/arch/ppc/syslib/qspan_pci.c
--- linux-2.6.10-mm1-original/arch/ppc/syslib/qspan_pci.c	2004-12-24 16:34:26.000000000 -0500
+++ linux-2.6.10-mm1/arch/ppc/syslib/qspan_pci.c	2005-01-07 19:47:51.355219639 -0500
@@ -94,6 +94,8 @@
 #define mk_config_type1(bus, dev, offset) \
 	mk_config_addr(bus, dev, offset) | 1;
 
+static spinlock_t pcibios_lock = SPIN_LOCK_UNLOCKED;
+
 int qspan_pcibios_read_config_byte(unsigned char bus, unsigned char dev_fn,
 				  unsigned char offset, unsigned char *val)
 {
@@ -109,8 +111,8 @@
 	}
 
 #ifdef CONFIG_RPXCLASSIC
-	save_flags(flags);
-	cli();
+	/* disable interrupts */
+	spin_lock_irqsave(&pcibios_lock, flags);
 	*((uint *)RPX_CSR_ADDR) &= ~BCSR2_QSPACESEL;
 	eieio();
 #endif
@@ -124,7 +126,7 @@
 #ifdef CONFIG_RPXCLASSIC
 	*((uint *)RPX_CSR_ADDR) |= BCSR2_QSPACESEL;
 	eieio();
-	restore_flags(flags);
+	spin_unlock_irqrestore(&pcibios_lock, flags);
 #endif
 
 	offset ^= 0x03;
@@ -148,8 +150,8 @@
 	}
 
 #ifdef CONFIG_RPXCLASSIC
-	save_flags(flags);
-	cli();
+	/* disable interrupts */
+	spin_lock_irqsave(&pcibios_lock, flags);
 	*((uint *)RPX_CSR_ADDR) &= ~BCSR2_QSPACESEL;
 	eieio();
 #endif
@@ -164,7 +166,7 @@
 #ifdef CONFIG_RPXCLASSIC
 	*((uint *)RPX_CSR_ADDR) |= BCSR2_QSPACESEL;
 	eieio();
-	restore_flags(flags);
+	spin_unlock_irqrestore(&pcibios_lock, flags);
 #endif
 
 	sp = ((ushort *)&temp) + ((offset >> 1) & 1);
@@ -185,8 +187,8 @@
 	}
 
 #ifdef CONFIG_RPXCLASSIC
-	save_flags(flags);
-	cli();
+	/* disable interrupts */
+	spin_lock_irqsave(&pcibios_lock, flags);
 	*((uint *)RPX_CSR_ADDR) &= ~BCSR2_QSPACESEL;
 	eieio();
 #endif
@@ -200,7 +202,7 @@
 #ifdef CONFIG_RPXCLASSIC
 	*((uint *)RPX_CSR_ADDR) |= BCSR2_QSPACESEL;
 	eieio();
-	restore_flags(flags);
+	spin_unlock_irqrestore(&pcibios_lock, flags);
 #endif
 
 	return PCIBIOS_SUCCESSFUL;
@@ -225,8 +227,8 @@
 	*cp = val;
 
 #ifdef CONFIG_RPXCLASSIC
-	save_flags(flags);
-	cli();
+	/* disable interrupts */
+	spin_lock_irqsave(&pcibios_lock, flags);
 	*((uint *)RPX_CSR_ADDR) &= ~BCSR2_QSPACESEL;
 	eieio();
 #endif
@@ -240,7 +242,7 @@
 #ifdef CONFIG_RPXCLASSIC
 	*((uint *)RPX_CSR_ADDR) |= BCSR2_QSPACESEL;
 	eieio();
-	restore_flags(flags);
+	spin_unlock_irqrestore(&pcibios_lock, flags);
 #endif
 
 	return PCIBIOS_SUCCESSFUL;
@@ -265,8 +267,8 @@
 	*sp = val;
 
 #ifdef CONFIG_RPXCLASSIC
-	save_flags(flags);
-	cli();
+	/* disable interrupts */
+	spin_lock_irqsave(&pcibios_lock, flags);
 	*((uint *)RPX_CSR_ADDR) &= ~BCSR2_QSPACESEL;
 	eieio();
 #endif
@@ -280,7 +282,7 @@
 #ifdef CONFIG_RPXCLASSIC
 	*((uint *)RPX_CSR_ADDR) |= BCSR2_QSPACESEL;
 	eieio();
-	restore_flags(flags);
+	spin_unlock_irqrestore(&pcibios_lock, flags);
 #endif
 
 	return PCIBIOS_SUCCESSFUL;
@@ -297,8 +299,8 @@
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 #ifdef CONFIG_RPXCLASSIC
-	save_flags(flags);
-	cli();
+	/* disable interrupts */
+	spin_lock_irqsave(&pcibios_lock, flags);
 	*((uint *)RPX_CSR_ADDR) &= ~BCSR2_QSPACESEL;
 	eieio();
 #endif
@@ -312,7 +314,7 @@
 #ifdef CONFIG_RPXCLASSIC
 	*((uint *)RPX_CSR_ADDR) |= BCSR2_QSPACESEL;
 	eieio();
-	restore_flags(flags);
+	spin_unlock_irqrestore(&pcibios_lock, flags);
 #endif
 
 	return PCIBIOS_SUCCESSFUL;
