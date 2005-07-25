Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261717AbVGYGTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbVGYGTj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 02:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbVGYGRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 02:17:34 -0400
Received: from ozlabs.org ([203.10.76.45]:64964 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261851AbVGYGQ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 02:16:56 -0400
Date: Mon, 25 Jul 2005 16:16:35 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: [PPC64] Remove another fixed address constraint
Message-ID: <20050725061635.GD19817@localhost.localdomain>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc64-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Presently the LparMap, one of the structures the kernel shares with
the legacy iSeries hypervisor has a fixed offset address in head.S.
This patch changes this so the LparMap is a normally initialized
structure, without fixed address.  This allows us to use macros to
compute some of the values in the structure, which wasn't previously
possible because the assembler always uses signed-% which gets the
wrong answers for the computations in question.

Unfortunately, a gcc bug means that doing this requires another
structure (hvReleaseData) to be initialized in asm instead of C, but
on the whole the result is cleaner than before.

Signed-off-by: David Gibson <dwg@au1.ibm.com>

Index: working-2.6/include/asm-ppc64/iSeries/LparMap.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/iSeries/LparMap.h	2005-07-06 10:30:53.000000000 +1000
+++ working-2.6/include/asm-ppc64/iSeries/LparMap.h	2005-07-25 15:28:42.000000000 +1000
@@ -49,19 +49,26 @@
  * entry to map the Esid to the Vsid.
 */
 
+#define HvEsidsToMap	2
+#define HvRangesToMap	1
+
 /* Hypervisor initially maps 32MB of the load area */
 #define HvPagesToMap	8192
 
 struct LparMap {
-	u64	xNumberEsids;	// Number of ESID/VSID pairs (1)
-	u64	xNumberRanges;	// Number of VA ranges to map (1)
-	u64	xSegmentTableOffs; // Page number within load area of seg table (0)
+	u64	xNumberEsids;	// Number of ESID/VSID pairs
+	u64	xNumberRanges;	// Number of VA ranges to map
+	u64	xSegmentTableOffs; // Page number within load area of seg table
 	u64	xRsvd[5];
-	u64	xKernelEsid;	// Esid used to map kernel load (0x0C00000000)
-	u64	xKernelVsid;	// Vsid used to map kernel load (0x0C00000000)
-	u64	xPages;		// Number of pages to be mapped	(8192)
-	u64	xOffset;	// Offset from start of load area (0)
-	u64	xVPN;		// Virtual Page Number (0x000C000000000000)
+	struct {
+		u64	xKernelEsid;	// Esid used to map kernel load
+		u64	xKernelVsid;	// Vsid used to map kernel load
+	} xEsids[HvEsidsToMap];
+	struct {
+		u64	xPages;		// Number of pages to be mapped
+		u64	xOffset;	// Offset from start of load area
+		u64	xVPN;		// Virtual Page Number
+	} xRanges[HvRangesToMap];
 };
 
 extern struct LparMap		xLparMap;
Index: working-2.6/include/asm-ppc64/iSeries/HvReleaseData.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/iSeries/HvReleaseData.h	2005-07-06 10:30:53.000000000 +1000
+++ working-2.6/include/asm-ppc64/iSeries/HvReleaseData.h	2005-07-25 15:28:42.000000000 +1000
@@ -39,6 +39,11 @@
  * know that this PLIC does not support running an OS "that old".
  */
 
+#define	HVREL_TAGSINACTIVE	0x8000
+#define HVREL_32BIT		0x4000
+#define HVREL_NOSHAREDPROCS	0x2000
+#define HVREL_NOHMT		0x1000
+
 struct HvReleaseData {
 	u32	xDesc;		/* Descriptor "HvRD" ebcdic	x00-x03 */
 	u16	xSize;		/* Size of this control block	x04-x05 */
@@ -46,11 +51,7 @@
 	struct  naca_struct	*xSlicNacaAddr; /* Virt addr of SLIC NACA x08-x0F */
 	u32	xMsNucDataOffset; /* Offset of Linux Mapping Data x10-x13 */
 	u32	xRsvd1;		/* Reserved			x14-x17 */
-	u16	xTagsMode:1;	/* 0 == tags active, 1 == tags inactive */
-	u16	xAddressSize:1;	/* 0 == 64-bit, 1 == 32-bit */
-	u16	xNoSharedProcs:1; /* 0 == shared procs, 1 == no shared */
-	u16	xNoHMT:1;	/* 0 == allow HMT, 1 == no HMT */
-	u16	xRsvd2:12;	/* Reserved			x18-x19 */
+	u16	xFlags;
 	u16	xVrmIndex;	/* VRM Index of OS image	x1A-x1B */
 	u16	xMinSupportedPlicVrmIndex; /* Min PLIC level  (soft) x1C-x1D */
 	u16	xMinCompatablePlicVrmIndex; /* Min PLIC levelP (hard) x1E-x1F */
Index: working-2.6/arch/ppc64/kernel/LparData.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/LparData.c	2005-07-14 10:57:49.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/LparData.c	2005-07-25 15:09:55.000000000 +1000
@@ -33,17 +33,36 @@
  * the hypervisor and Linux.  
  */
 
+/*
+ * WARNING - magic here
+ *
+ * Ok, this is a horrid hack below, but marginally better than the
+ * alternatives.  What we really want is just to initialize
+ * hvReleaseData in C as in the #if 0 section here.  However, gcc
+ * refuses to believe that (u32)&x is a constant expression, so will
+ * not allow the xMsNucDataOffset field to be properly initialized.
+ * So, we declare hvReleaseData in inline asm instead.  We use inline
+ * asm, rather than a .S file, because the assembler won't generate
+ * the necessary relocation for the LparMap either, unless that symbol
+ * is declared in the same source file.  Finally, we put the asm in a
+ * dummy, attribute-used function, instead of at file scope, because
+ * file scope asms don't allow contraints.  We want to use the "i"
+ * constraints to put sizeof() and offsetof() expressions in there,
+ * because including asm/offsets.h in C code then stringifying causes
+ * all manner of warnings.
+ */
+#if 0
 struct HvReleaseData hvReleaseData = {
 	.xDesc = 0xc8a5d9c4,	/* "HvRD" ebcdic */
 	.xSize = sizeof(struct HvReleaseData),
 	.xVpdAreasPtrOffset = offsetof(struct naca_struct, xItVpdAreas),
 	.xSlicNacaAddr = &naca,		/* 64-bit Naca address */
-	.xMsNucDataOffset = 0x4800,	/* offset of LparMap within loadarea (see head.S) */
-	.xTagsMode = 1,			/* tags inactive       */
-	.xAddressSize = 0,		/* 64 bit              */
-	.xNoSharedProcs = 0,		/* shared processors   */
-	.xNoHMT = 0,			/* HMT allowed         */
-	.xRsvd2 = 6,			/* TEMP: This allows non-GA driver */
+	.xMsNucDataOffset = (u32)((unsigned long)&xLparMap - KERNELBASE),
+	.xFlags = HVREL_TAGSINACTIVE	/* tags inactive       */
+					/* 64 bit              */
+					/* shared processors   */
+					/* HMT allowed         */
+		  | 6,			/* TEMP: This allows non-GA driver */
 	.xVrmIndex = 4,			/* We are v5r2m0               */
 	.xMinSupportedPlicVrmIndex = 3,		/* v5r1m0 */
 	.xMinCompatablePlicVrmIndex = 3,	/* v5r1m0 */
@@ -51,6 +70,63 @@
 		0xa7, 0x40, 0xf2, 0x4b,
 		0xf4, 0x4b, 0xf6, 0xf4 },
 };
+#endif
+
+
+extern struct HvReleaseData hvReleaseData;
+
+static void __attribute_used__ hvReleaseData_wrapper(void)
+{
+	/* This doesn't appear to need any alignment (even 4 byte) */
+	asm volatile (
+		"	lparMapPhys = xLparMap - %3\n"
+		"	.data\n"
+		"	.globl	hvReleaseData\n"
+		"hvReleaseData:\n"
+		"	.long	0xc8a5d9c4\n"	/* xDesc */
+						/* "HvRD" in ebcdic */
+		"	.short	%0\n"		/* xSize */
+		"	.short	%1\n"		/* xVpdAreasPtrOffset */
+		"	.llong	naca\n"		/* xSlicNacaAddr */
+		"	.long	lparMapPhys\n"	/* xMsNucDataOffset */
+		"	.long	0\n"		/* xRsvd1 */
+		"	.short	%2\n"		/* xFlags */
+		"	.short	4\n"	/* xVrmIndex  - v5r2m0 */
+		"	.short	3\n"	/* xMinSupportedPlicVrmIndex - v5r1m0 */
+		"	.short	3\n"	/* xMinCompatablePlicVrmIndex - v5r1m0 */
+		"	.long	0xd38995a4\n"	/* xVrmName */
+		"	.long	0xa740f24b\n"	/*   "Linux 2.4.64" ebcdic */
+		"	.long	0xf44bf6f4\n"
+		"	. = hvReleaseData + %0\n"
+		"	.previous\n"
+		: : "i"(sizeof(hvReleaseData)),
+		"i"(offsetof(struct naca_struct, xItVpdAreas)),
+		"i"(HVREL_TAGSINACTIVE /* tags inactive, 64 bit, */
+				       /* shared processors, HMT allowed */
+		    | 6), /* TEMP: This allows non-GA drivers */
+		"i"(KERNELBASE)
+		);
+}
+
+struct LparMap __attribute__((aligned (16))) xLparMap = {
+	.xNumberEsids = HvEsidsToMap,
+	.xNumberRanges = HvRangesToMap,
+	.xSegmentTableOffs = STAB0_PAGE,
+
+	.xEsids = {
+		{ .xKernelEsid = GET_ESID(KERNELBASE),
+		  .xKernelVsid = KERNEL_VSID(KERNELBASE), },
+		{ .xKernelEsid = GET_ESID(VMALLOCBASE),
+		  .xKernelVsid = KERNEL_VSID(VMALLOCBASE), },
+	},
+
+	.xRanges = {
+		{ .xPages = HvPagesToMap,
+		  .xOffset = 0,
+		  .xVPN = KERNEL_VSID(KERNELBASE) << (SID_SHIFT - PAGE_SHIFT),
+		},
+	},
+};
 
 extern void system_reset_iSeries(void);
 extern void machine_check_iSeries(void);
Index: working-2.6/include/asm-ppc64/mmu.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/mmu.h	2005-07-25 15:28:15.000000000 +1000
+++ working-2.6/include/asm-ppc64/mmu.h	2005-07-25 15:29:40.000000000 +1000
@@ -338,6 +338,9 @@
 			     | (ea >> SID_SHIFT));
 }
 
+#define VSID_SCRAMBLE(pvsid)	(((pvsid) * VSID_MULTIPLIER) % VSID_MODULUS)
+#define KERNEL_VSID(ea)		VSID_SCRAMBLE(GET_ESID(ea))
+
 #endif /* __ASSEMBLY */
 
 #endif /* _PPC64_MMU_H_ */
Index: working-2.6/arch/ppc64/kernel/head.S
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/head.S	2005-07-25 15:28:15.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/head.S	2005-07-25 15:31:00.000000000 +1000
@@ -522,36 +522,9 @@
 #ifdef CONFIG_PPC_ISERIES
 	.globl naca
 naca:
-	.llong itVpdAreas
-
-	/*
-	 * The iSeries LPAR map is at this fixed address
-	 * so that the HvReleaseData structure can address
-	 * it with a 32-bit offset.
-	 *
-	 * The VSID values below are dependent on the
-	 * VSID generation algorithm.  See include/asm/mmu_context.h.
-	 */
-
-	. = 0x4800
-
-	.llong	2		/* # ESIDs to be mapped by hypervisor	 */
-	.llong	1		/* # memory ranges to be mapped by hypervisor */
-	.llong	STAB0_PAGE	/* Page # of segment table within load area	*/
-	.llong	0		/* Reserved */
-	.llong	0		/* Reserved */
-	.llong	0		/* Reserved */
-	.llong	0		/* Reserved */
-	.llong	0		/* Reserved */
-	.llong	(KERNELBASE>>SID_SHIFT)
-	.llong	0x408f92c94	/* KERNELBASE VSID */
-	/* We have to list the bolted VMALLOC segment here, too, so that it
-	 * will be restored on shared processor switch */
-	.llong	(VMALLOCBASE>>SID_SHIFT)
-	.llong	0xf09b89af5	/* VMALLOCBASE VSID */
-	.llong	8192		/* # pages to map (32 MB) */
-	.llong	0		/* Offset from start of loadarea to start of map */
-	.llong	0x408f92c940000	/* VPN of first page to map */
+	.llong	itVpdAreas
+	.llong	0		/* xRamDisk */
+	.llong	0		/* xRamDiskSize */
 
 	. = 0x6100
 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/people/dgibson
