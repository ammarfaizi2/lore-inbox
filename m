Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268894AbUI3GWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268894AbUI3GWX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 02:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268886AbUI3GWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 02:22:23 -0400
Received: from ozlabs.org ([203.10.76.45]:4298 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268894AbUI3GWO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 02:22:14 -0400
Date: Thu, 30 Sep 2004 16:20:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PPC64] EEH checks mistakenly became no-ops
Message-ID: <20040930062048.GA21889@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
	Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply:

Recent changes which removed the use of IO tokens for EEH enabled
devices had a bug, which mean we now never do EEH checks at all.  This
patch corrects the problem.  Unfortunately, it does mean we do EEH
checks on pSeries whenever any IO returns all 1s.

Signed-off-by: David Gibson <dwg@au1.ibm.com>

Index: working-2.6/include/asm-ppc64/eeh.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/eeh.h	2004-09-24 10:14:10.000000000 +1000
+++ working-2.6/include/asm-ppc64/eeh.h	2004-09-30 16:03:17.822907592 +1000
@@ -71,16 +71,10 @@
 /*
  * EEH_POSSIBLE_ERROR() -- test for possible MMIO failure.
  *
- * Order this macro for performance.
- * If EEH is off for a device and it is a memory BAR, ioremap will
- * map it to the IOREGION.  In this case addr == vaddr and since these
- * should be in registers we compare them first.  Next we check for
- * ff's which indicates a (very) possible failure.
- *
  * If this macro yields TRUE, the caller relays to eeh_check_failure()
  * which does further tests out of line.
  */
-#define EEH_POSSIBLE_IO_ERROR(val, type)	((val) == (type)~0)
+#define EEH_POSSIBLE_ERROR(val, type)	((val) == (type)~0)
 
 /*
  * Reads from a device which has been isolated by EEH will return
@@ -89,21 +83,13 @@
  */
 #define EEH_IO_ERROR_VALUE(size)	(~0U >> ((4 - (size)) * 8))
 
-/*
- * The vaddr will equal the addr if EEH checking is disabled for
- * this device.  This is because eeh_ioremap() will not have
- * remapped to 0xA0, and thus both vaddr and addr will be 0xE0...
- */
-#define EEH_POSSIBLE_ERROR(addr, vaddr, val, type) \
-		((vaddr) != (addr) && EEH_POSSIBLE_IO_ERROR(val, type))
-
 /* 
  * MMIO read/write operations with EEH support.
  */
 static inline u8 eeh_readb(const volatile void __iomem *addr) {
 	volatile u8 *vaddr = (volatile u8 __force *) addr;
 	u8 val = in_8(vaddr);
-	if (EEH_POSSIBLE_ERROR(addr, vaddr, val, u8))
+	if (EEH_POSSIBLE_ERROR(val, u8))
 		return eeh_check_failure(addr, val);
 	return val;
 }
@@ -115,7 +101,7 @@
 static inline u16 eeh_readw(const volatile void __iomem *addr) {
 	volatile u16 *vaddr = (volatile u16 __force *) addr;
 	u16 val = in_le16(vaddr);
-	if (EEH_POSSIBLE_ERROR(addr, vaddr, val, u16))
+	if (EEH_POSSIBLE_ERROR(val, u16))
 		return eeh_check_failure(addr, val);
 	return val;
 }
@@ -126,7 +112,7 @@
 static inline u16 eeh_raw_readw(const volatile void __iomem *addr) {
 	volatile u16 *vaddr = (volatile u16 __force *) addr;
 	u16 val = in_be16(vaddr);
-	if (EEH_POSSIBLE_ERROR(addr, vaddr, val, u16))
+	if (EEH_POSSIBLE_ERROR(val, u16))
 		return eeh_check_failure(addr, val);
 	return val;
 }
@@ -138,7 +124,7 @@
 static inline u32 eeh_readl(const volatile void __iomem *addr) {
 	volatile u32 *vaddr = (volatile u32 __force *) addr;
 	u32 val = in_le32(vaddr);
-	if (EEH_POSSIBLE_ERROR(addr, vaddr, val, u32))
+	if (EEH_POSSIBLE_ERROR(val, u32))
 		return eeh_check_failure(addr, val);
 	return val;
 }
@@ -149,7 +135,7 @@
 static inline u32 eeh_raw_readl(const volatile void __iomem *addr) {
 	volatile u32 *vaddr = (volatile u32 __force *) addr;
 	u32 val = in_be32(vaddr);
-	if (EEH_POSSIBLE_ERROR(addr, vaddr, val, u32))
+	if (EEH_POSSIBLE_ERROR(val, u32))
 		return eeh_check_failure(addr, val);
 	return val;
 }
@@ -161,7 +147,7 @@
 static inline u64 eeh_readq(const volatile void __iomem *addr) {
 	volatile u64 *vaddr = (volatile u64 __force *) addr;
 	u64 val = in_le64(vaddr);
-	if (EEH_POSSIBLE_ERROR(addr, vaddr, val, u64))
+	if (EEH_POSSIBLE_ERROR(val, u64))
 		return eeh_check_failure(addr, val);
 	return val;
 }
@@ -172,7 +158,7 @@
 static inline u64 eeh_raw_readq(const volatile void __iomem *addr) {
 	volatile u64 *vaddr = (volatile u64 __force *) addr;
 	u64 val = in_be64(vaddr);
-	if (EEH_POSSIBLE_ERROR(addr, vaddr, val, u64))
+	if (EEH_POSSIBLE_ERROR(val, u64))
 		return eeh_check_failure(addr, val);
 	return val;
 }
@@ -209,7 +195,7 @@
 }
 static inline void eeh_memcpy_fromio(void *dest, const volatile void __iomem *src, unsigned long n) {
 	void *vsrc = (void __force *) src;
-	void *vsrcsave = vsrc, *destsave = dest;
+	void *destsave = dest;
 	const volatile void __iomem *srcsave = src;
 	unsigned long nsave = n;
 
@@ -240,8 +226,7 @@
 	 * were copied. Check all four bytes.
 	 */
 	if ((nsave >= 4) &&
-		(EEH_POSSIBLE_ERROR(srcsave, vsrcsave, (*((u32 *) destsave+nsave-4)),
-				    u32))) {
+		(EEH_POSSIBLE_ERROR((*((u32 *) destsave+nsave-4)), u32))) {
 		eeh_check_failure(srcsave, (*((u32 *) destsave+nsave-4)));
 	}
 }
@@ -281,7 +266,7 @@
 	if (!_IO_IS_VALID(port))
 		return ~0;
 	val = in_8((u8 *)(port+pci_io_base));
-	if (EEH_POSSIBLE_IO_ERROR(val, u8))
+	if (EEH_POSSIBLE_ERROR(val, u8))
 		return eeh_check_failure((void __iomem *)(port), val);
 	return val;
 }
@@ -296,7 +281,7 @@
 	if (!_IO_IS_VALID(port))
 		return ~0;
 	val = in_le16((u16 *)(port+pci_io_base));
-	if (EEH_POSSIBLE_IO_ERROR(val, u16))
+	if (EEH_POSSIBLE_ERROR(val, u16))
 		return eeh_check_failure((void __iomem *)(port), val);
 	return val;
 }
@@ -311,7 +296,7 @@
 	if (!_IO_IS_VALID(port))
 		return ~0;
 	val = in_le32((u32 *)(port+pci_io_base));
-	if (EEH_POSSIBLE_IO_ERROR(val, u32))
+	if (EEH_POSSIBLE_ERROR(val, u32))
 		return eeh_check_failure((void __iomem *)(port), val);
 	return val;
 }
@@ -324,19 +309,19 @@
 /* in-string eeh macros */
 static inline void eeh_insb(unsigned long port, void * buf, int ns) {
 	_insb((u8 *)(port+pci_io_base), buf, ns);
-	if (EEH_POSSIBLE_IO_ERROR((*(((u8*)buf)+ns-1)), u8))
+	if (EEH_POSSIBLE_ERROR((*(((u8*)buf)+ns-1)), u8))
 		eeh_check_failure((void __iomem *)(port), *(u8*)buf);
 }
 
 static inline void eeh_insw_ns(unsigned long port, void * buf, int ns) {
 	_insw_ns((u16 *)(port+pci_io_base), buf, ns);
-	if (EEH_POSSIBLE_IO_ERROR((*(((u16*)buf)+ns-1)), u16))
+	if (EEH_POSSIBLE_ERROR((*(((u16*)buf)+ns-1)), u16))
 		eeh_check_failure((void __iomem *)(port), *(u16*)buf);
 }
 
 static inline void eeh_insl_ns(unsigned long port, void * buf, int nl) {
 	_insl_ns((u32 *)(port+pci_io_base), buf, nl);
-	if (EEH_POSSIBLE_IO_ERROR((*(((u32*)buf)+nl-1)), u32))
+	if (EEH_POSSIBLE_ERROR((*(((u32*)buf)+nl-1)), u32))
 		eeh_check_failure((void __iomem *)(port), *(u32*)buf);
 }
 


-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
