Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265226AbUF1VP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265226AbUF1VP7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 17:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265224AbUF1VP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 17:15:58 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:7348 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S265214AbUF1VPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 17:15:04 -0400
Subject: [PATCH/Example] using dma_get_required_mask() in sym2
From: James Bottomley <James.Bottomley@steeleye.com>
To: willy@debian.org
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 28 Jun 2004 16:14:58 -0500
Message-Id: <1088457301.1749.44.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch shows how to use dma_get_required_mask() to make the sym2
driver select the correct descriptor format on the fly (instead of
having to have it compiled in to the driver).

I've compiled and booted it on my 64 bit system with a 53c875

James

===== drivers/scsi/Kconfig 1.73 vs edited =====
--- 1.73/drivers/scsi/Kconfig	2004-06-26 18:02:22 -05:00
+++ edited/drivers/scsi/Kconfig	2004-06-28 10:20:47 -05:00
@@ -947,29 +947,6 @@
 	  Please read <file:Documentation/scsi/sym53c8xx_2.txt> for more
 	  information.
 
-config SCSI_SYM53C8XX_DMA_ADDRESSING_MODE
-	int "DMA addressing mode"
-	depends on SCSI_SYM53C8XX_2
-	default "1"
-	---help---
-	  This option only applies to PCI-SCSI chips that are PCI DAC
-	  capable (875A, 895A, 896, 1010-33, 1010-66, 1000).
-
-	  When set to 0, the driver will program the chip to only perform
-	  32-bit DMA.  When set to 1, the chip will be able to perform DMA
-	  to addresses up to 1TB.  When set to 2, the driver supports the
-	  full 64-bit DMA address range, but can only address 16 segments
-	  of 4 GB each.  This limits the total addressable range to 64 GB.
-
-	  Most machines with less than 4GB of memory should use a setting
-	  of 0 for best performance.  If your machine has 4GB of memory
-	  or more, you should set this option to 1 (the default).
-
-	  The still experimental value 2 (64 bit DMA addressing with 16
-	  x 4GB segments limitation) can be used on systems that require
-	  PCI address bits past bit 39 to be set for the addressing of
-	  memory using PCI DAC cycles.
-
 config SCSI_SYM53C8XX_DEFAULT_TAGS
 	int "default tagged command queue depth"
 	depends on SCSI_SYM53C8XX_2
===== drivers/scsi/sym53c8xx_2/sym_fw.c 1.5 vs edited =====
--- 1.5/drivers/scsi/sym53c8xx_2/sym_fw.c	2004-03-11 03:06:01 -06:00
+++ edited/drivers/scsi/sym53c8xx_2/sym_fw.c	2004-06-28 10:54:34 -05:00
@@ -193,18 +193,16 @@
 		scripta0->start[0]	= cpu_to_scr(SCR_NO_OP);
 	}
 
-#if   SYM_CONF_DMA_ADDRESSING_MODE == 2
 	/*
 	 *  Remove useless 64 bit DMA specific SCRIPTS, 
 	 *  when this feature is not available.
 	 */
-	if (!np->use_dac) {
+	if (np->dma_addressing_mode != SYM_DMA_64_BIT) {
 		scripta0->is_dmap_dirty[0] = cpu_to_scr(SCR_NO_OP);
 		scripta0->is_dmap_dirty[1] = 0;
 		scripta0->is_dmap_dirty[2] = cpu_to_scr(SCR_NO_OP);
 		scripta0->is_dmap_dirty[3] = 0;
 	}
-#endif
 
 #ifdef SYM_CONF_IARB_SUPPORT
 	/*
===== drivers/scsi/sym53c8xx_2/sym_fw2.h 1.5 vs edited =====
--- 1.5/drivers/scsi/sym53c8xx_2/sym_fw2.h	2003-12-17 14:33:53 -06:00
+++ edited/drivers/scsi/sym53c8xx_2/sym_fw2.h	2004-06-28 10:22:55 -05:00
@@ -74,9 +74,7 @@
 #else
 	u32 select		[  4];
 #endif
-#if	SYM_CONF_DMA_ADDRESSING_MODE == 2
 	u32 is_dmap_dirty	[  4];
-#endif
 	u32 wf_sel_done		[  2];
 	u32 sel_done		[  2];
 	u32 send_ident		[  2];
@@ -342,13 +340,11 @@
 	 *  Patched with NOOP for chips that donnot 
 	 *  support DAC addressing.
 	 */
-#if	SYM_CONF_DMA_ADDRESSING_MODE == 2
 }/*-------------------------< IS_DMAP_DIRTY >--------------------*/,{
 	SCR_FROM_REG (HX_REG),
 		0,
 	SCR_INT ^ IFTRUE (MASK (HX_DMAP_DIRTY, HX_DMAP_DIRTY)),
 		SIR_DMAP_DIRTY,
-#endif
 }/*-------------------------< WF_SEL_DONE >----------------------*/,{
 	SCR_INT ^ IFFALSE (WHEN (SCR_MSG_OUT)),
 		SIR_SEL_ATN_NO_MSG_OUT,
===== drivers/scsi/sym53c8xx_2/sym_glue.c 1.44 vs edited =====
--- 1.44/drivers/scsi/sym53c8xx_2/sym_glue.c	2004-04-25 09:18:04 -05:00
+++ edited/drivers/scsi/sym53c8xx_2/sym_glue.c	2004-06-28 11:04:34 -05:00
@@ -1625,27 +1625,34 @@
  */
 static int sym_setup_bus_dma_mask(struct sym_hcb *np)
 {
-#if   SYM_CONF_DMA_ADDRESSING_MODE == 0
-	if (pci_set_dma_mask(np->s.device, 0xffffffffUL))
-		goto out_err32;
-#else
-#if   SYM_CONF_DMA_ADDRESSING_MODE == 1
-#define	PciDmaMask	0xffffffffffULL
-#elif SYM_CONF_DMA_ADDRESSING_MODE == 2
-#define	PciDmaMask	0xffffffffffffffffULL
-#endif
 	if (np->features & FE_DAC) {
-		if (!pci_set_dma_mask(np->s.device, PciDmaMask)) {
+		if (dma_set_mask(&np->s.device->dev, DMA_64BIT_MASK))
+			goto set_32bit_mask;
+		else {
+			u64 required_mask = dma_get_required_mask(&np->s.device->dev);
+			if (required_mask <= DMA_32BIT_MASK)
+				goto set_32bit_mask;
+
 			np->use_dac = 1;
-			printf_info("%s: using 64 bit DMA addressing\n",
-					sym_name(np));
-		} else {
-			if (pci_set_dma_mask(np->s.device, 0xffffffffUL))
-				goto out_err32;
+			
+			if (required_mask <= SYM_DMA_40_BIT_MASK) {
+				if (dma_set_mask(&np->s.device->dev, SYM_DMA_40_BIT_MASK))
+					goto set_32bit_mask;
+				np->dma_addressing_mode = SYM_DMA_40_BIT;
+			} else {
+				np->dma_addressing_mode = SYM_DMA_64_BIT;
+			}
 		}
+	} else {
+	set_32bit_mask:
+		if (dma_set_mask(&np->s.device->dev, DMA_32BIT_MASK))
+			goto out_err32;
+
+		np->dma_addressing_mode = SYM_DMA_32_BIT;
 	}
-#undef	PciDmaMask
-#endif
+			     
+	printf_info("%s: using %s bit DMA addressing\n",
+		    sym_name(np), sym_dma_bits(np));
 	return 0;
 
 out_err32:
===== drivers/scsi/sym53c8xx_2/sym_hipd.c 1.18 vs edited =====
--- 1.18/drivers/scsi/sym53c8xx_2/sym_hipd.c	2004-04-25 09:11:04 -05:00
+++ edited/drivers/scsi/sym53c8xx_2/sym_hipd.c	2004-06-28 11:06:32 -05:00
@@ -871,19 +871,23 @@
 	 *  64 bit addressing  (895A/896/1010) ?
 	 */
 	if (np->features & FE_DAC) {
-#if   SYM_CONF_DMA_ADDRESSING_MODE == 0
-		np->rv_ccntl1	|= (DDAC);
-#elif SYM_CONF_DMA_ADDRESSING_MODE == 1
-		if (!np->use_dac)
+		switch (np->dma_addressing_mode) {
+		case SYM_DMA_32_BIT:
 			np->rv_ccntl1	|= (DDAC);
-		else
-			np->rv_ccntl1	|= (XTIMOD | EXTIBMV);
-#elif SYM_CONF_DMA_ADDRESSING_MODE == 2
-		if (!np->use_dac)
-			np->rv_ccntl1	|= (DDAC);
-		else
-			np->rv_ccntl1	|= (0 | EXTIBMV);
-#endif
+			break;
+		case SYM_DMA_40_BIT:
+			if (!np->use_dac)
+				np->rv_ccntl1	|= (DDAC);
+			else
+				np->rv_ccntl1	|= (XTIMOD | EXTIBMV);
+			break;
+		case SYM_DMA_64_BIT:
+			if (!np->use_dac)
+				np->rv_ccntl1	|= (DDAC);
+			else
+				np->rv_ccntl1	|= (0 | EXTIBMV);
+			break;
+		}
 	}
 
 	/*
@@ -1443,7 +1447,6 @@
 	return 0;
 }
 
-#if SYM_CONF_DMA_ADDRESSING_MODE == 2
 /*
  *  Lookup the 64 bit DMA segments map.
  *  This is only used if the direct mapping 
@@ -1495,7 +1498,6 @@
 	}
 	np->dmap_dirty = 0;
 }
-#endif
 
 /*
  *  Prepare the next negotiation message if needed.
@@ -1598,14 +1600,12 @@
 	np->last_cp = cp;
 #endif
 
-#if   SYM_CONF_DMA_ADDRESSING_MODE == 2
 	/*
 	 *  Make SCRIPTS aware of the 64 bit DMA 
 	 *  segment registers not being up-to-date.
 	 */
 	if (np->dmap_dirty)
 		cp->host_xflags |= HX_DMAP_DIRTY;
-#endif
 
 	/*
 	 *  Optionnaly, set the IO timeout condition.
@@ -1877,17 +1877,15 @@
 		OUTB (nc_ccntl1, np->rv_ccntl1);
 	}
 
-#if	SYM_CONF_DMA_ADDRESSING_MODE == 2
 	/*
 	 *  Set up scratch C and DRS IO registers to map the 32 bit 
 	 *  DMA address range our data structures are located in.
 	 */
-	if (np->use_dac) {
+	if (np->use_dac && np->dma_addressing_mode == SYM_DMA_64_BIT) {
 		np->dmap_bah[0] = 0;	/* ??? */
 		OUTL (nc_scrx[0], np->dmap_bah[0]);
 		OUTL (nc_drs, np->dmap_bah[0]);
 	}
-#endif
 
 	/*
 	 *  If phase mismatch handled by scripts (895A/896/1010),
@@ -4474,7 +4472,6 @@
 	if (DEBUG_FLAGS & DEBUG_TINY) printf ("I#%d", num);
 
 	switch (num) {
-#if   SYM_CONF_DMA_ADDRESSING_MODE == 2
 	/*
 	 *  SCRIPTS tell us that we may have to update 
 	 *  64 bit DMA segment registers.
@@ -4482,7 +4479,6 @@
 	case SIR_DMAP_DIRTY:
 		sym_update_dmap_regs(np);
 		goto out;
-#endif
 	/*
 	 *  Command has been completed with error condition 
 	 *  or has been auto-sensed.
===== drivers/scsi/sym53c8xx_2/sym_hipd.h 1.6 vs edited =====
--- 1.6/drivers/scsi/sym53c8xx_2/sym_hipd.h	2004-04-13 19:20:15 -05:00
+++ edited/drivers/scsi/sym53c8xx_2/sym_hipd.h	2004-06-28 11:07:09 -05:00
@@ -279,12 +279,8 @@
 #define	SIR_COMPLETE_ERROR	(20)
 #define	SIR_DATA_OVERRUN	(21)
 #define	SIR_BAD_PHASE		(22)
-#if	SYM_CONF_DMA_ADDRESSING_MODE == 2
 #define	SIR_DMAP_DIRTY		(23)
 #define	SIR_MAX			(23)
-#else
-#define	SIR_MAX			(22)
-#endif
 
 /*
  *  Extended error bit codes.
@@ -318,7 +314,6 @@
 #define CCB_HASH_CODE(dsa)	(((dsa) >> 9) & CCB_HASH_MASK)
 #endif
 
-#if	SYM_CONF_DMA_ADDRESSING_MODE == 2
 /*
  *  We may want to use segment registers for 64 bit DMA.
  *  16 segments registers -> up to 64 GB addressable.
@@ -326,7 +321,6 @@
 #define SYM_DMAP_SHIFT	(4)
 #define SYM_DMAP_SIZE	(1u<<SYM_DMAP_SHIFT)
 #define SYM_DMAP_MASK	(SYM_DMAP_SIZE-1)
-#endif
 
 /*
  *  Device flags.
@@ -665,9 +659,7 @@
 /*
  *  More host flags
  */
-#if	SYM_CONF_DMA_ADDRESSING_MODE == 2
 #define	HX_DMAP_DIRTY	(1u<<7)
-#endif
 
 /*
  *  Global CCB HEADER.
@@ -704,6 +696,14 @@
 	u8	status[4];
 };
 
+enum sym_dma_mode {
+	SYM_DMA_32_BIT,
+	SYM_DMA_40_BIT,
+	SYM_DMA_64_BIT,
+};
+
+#define SYM_DMA_40_BIT_MASK (0xffffffffffULL)
+
 /*
  *  GET/SET the value of the data pointer used by SCRIPTS.
  *
@@ -1097,17 +1097,26 @@
 	/*
 	 *  64 bit DMA handling.
 	 */
-#if	SYM_CONF_DMA_ADDRESSING_MODE != 0
 	u_char	use_dac;		/* Use PCI DAC cycles		*/
-#if	SYM_CONF_DMA_ADDRESSING_MODE == 2
 	u_char	dmap_dirty;		/* Dma segments registers dirty	*/
 	u32	dmap_bah[SYM_DMAP_SIZE];/* Segment registers map	*/
-#endif
-#endif
+	enum sym_dma_mode dma_addressing_mode;
 };
 
 #define HCB_BA(np, lbl)	(np->hcb_ba + offsetof(struct sym_hcb, lbl))
 
+/* Simple printing macro for chosen dma width */
+static inline const char *sym_dma_bits(struct sym_hcb *np)
+{
+	switch (np->dma_addressing_mode) {
+	case SYM_DMA_32_BIT:
+		return "32";
+	case SYM_DMA_40_BIT:
+		return "40";
+	case SYM_DMA_64_BIT:
+		return "64";
+	}
+}
 
 /*
  *  FIRMWARES (sym_fw.c)
@@ -1191,39 +1200,37 @@
  *  This allows the 895A, 896, 1010 to address up to 1 TB of memory.
  */
 
-#if   SYM_CONF_DMA_ADDRESSING_MODE == 0
-#define sym_build_sge(np, data, badd, len)	\
-do {						\
-	(data)->addr = cpu_to_scr(badd);	\
-	(data)->size = cpu_to_scr(len);		\
-} while (0)
-#elif SYM_CONF_DMA_ADDRESSING_MODE == 1
-#define sym_build_sge(np, data, badd, len)				\
-do {									\
-	(data)->addr = cpu_to_scr(badd);				\
-	(data)->size = cpu_to_scr((((badd) >> 8) & 0xff000000) + len);	\
-} while (0)
-#elif SYM_CONF_DMA_ADDRESSING_MODE == 2
+
 int sym_lookup_dmap(hcb_p np, u32 h, int s);
+
 static __inline void 
 sym_build_sge(hcb_p np, struct sym_tblmove *data, u64 badd, int len)
 {
-	u32 h = (badd>>32);
-	int s = (h&SYM_DMAP_MASK);
-
-	if (h != np->dmap_bah[s])
-		goto bad;
-good:
-	(data)->addr = cpu_to_scr(badd);
-	(data)->size = cpu_to_scr((s<<24) + len);
-	return;
-bad:
-	s = sym_lookup_dmap(np, h, s);
-	goto good;
+	switch (np->dma_addressing_mode) {
+	case SYM_DMA_32_BIT:
+		(data)->addr = cpu_to_scr(badd);
+		(data)->size = cpu_to_scr(len);
+		return;
+	case SYM_DMA_40_BIT:
+		(data)->addr = cpu_to_scr(badd);
+		(data)->size = cpu_to_scr((((badd) >> 8) & 0xff000000) + len);
+		return;
+	case SYM_DMA_64_BIT: {
+		u32 h = (badd>>32);
+		int s = (h&SYM_DMAP_MASK);
+
+		if (h != np->dmap_bah[s])
+			goto bad;
+	good:
+		(data)->addr = cpu_to_scr(badd);
+		(data)->size = cpu_to_scr((s<<24) + len);
+		return;
+	bad:
+		s = sym_lookup_dmap(np, h, s);
+		goto good;
+	}
+	}
 }
-#else
-#error "Unsupported DMA addressing mode"
-#endif
 
 /*
  *  Set up data pointers used by SCRIPTS.


