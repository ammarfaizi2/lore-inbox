Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268405AbUHLB1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268405AbUHLB1X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 21:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268399AbUHKXmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 19:42:44 -0400
Received: from omx1-ext.SGI.COM ([192.48.179.11]:12775 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S268343AbUHKXbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 19:31:33 -0400
From: Pat Gefre <pfg@sgi.com>
Message-Id: <200408112330.i7BNUK54163392@fsgi900.americas.sgi.com>
Subject: Re: Altix I/O code reorganization - 8 of 21
To: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       hch@infradead.org
Date: Wed, 11 Aug 2004 18:30:20 -0500 (CDT)
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 004-pci-bridge_drivers:
>    You still have code dealing with all kinds of PCIIO_ and PCIBR_ flags
>    that will never be set through the Linux interfaces.  Again see the DMA
>    mapping code I sent you.
> 

The PCIIO_ flags are designed for usage at the Device Driver layer, 
while the PCIBR_ flags are designed to be the actual hardware bits that needed 
setting.  However, with the latest code, we have deleted the PCIIO_ and 
PCIBR_ flags that are not used.


# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/11 16:13:14-05:00 pfg@sgi.com 
#   This set of new files supports 2 of our 3 PCI Bridges, PIC and TIOCP.
#   pcibr_dma.c is new and provides the PCI DMA Mapping routines.
#   pcibr_sal_interfaces.c is new and provides the SAL Interfaces.
#   pcibr_provider.c is new and defines the Chipset specific Provider Tables.
#   
#   
# 
# arch/ia64/sn/ioif/pci/pcibr_sal_interfaces.c
#   2004/08/11 16:09:28-05:00 pfg@sgi.com +134 -0
# 
# arch/ia64/sn/ioif/pci/pcibr_sal_interfaces.c
#   2004/08/11 16:09:27-05:00 pfg@sgi.com +0 -0
#   BitKeeper file /work.attica2/pfg/Linux/2.5-BK/to-base-2.6/arch/ia64/sn/ioif/pci/pcibr_sal_interfaces.c
# 
# arch/ia64/sn/ioif/pci/pcibr_provider.c
#   2004/08/11 16:09:26-05:00 pfg@sgi.com +182 -0
# 
# arch/ia64/sn/ioif/pci/pcibr_provider.c
#   2004/08/11 16:09:26-05:00 pfg@sgi.com +0 -0
#   BitKeeper file /work.attica2/pfg/Linux/2.5-BK/to-base-2.6/arch/ia64/sn/ioif/pci/pcibr_provider.c
# 
# arch/ia64/sn/ioif/pci/pcibr_dma.c
#   2004/08/11 16:09:24-05:00 pfg@sgi.com +729 -0
# 
# arch/ia64/sn/ioif/pci/pcibr_dma.c
#   2004/08/11 16:09:24-05:00 pfg@sgi.com +0 -0
#   BitKeeper file /work.attica2/pfg/Linux/2.5-BK/to-base-2.6/arch/ia64/sn/ioif/pci/pcibr_dma.c
# 
# arch/ia64/sn/ioif/pci/Makefile
#   2004/08/11 16:09:23-05:00 pfg@sgi.com +14 -0
# 
# arch/ia64/sn/ioif/pci/Makefile
#   2004/08/11 16:09:23-05:00 pfg@sgi.com +0 -0
#   BitKeeper file /work.attica2/pfg/Linux/2.5-BK/to-base-2.6/arch/ia64/sn/ioif/pci/Makefile
# 
diff -Nru a/arch/ia64/sn/ioif/pci/Makefile b/arch/ia64/sn/ioif/pci/Makefile
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ia64/sn/ioif/pci/Makefile	2004-08-11 16:14:09 -05:00
@@ -0,0 +1,14 @@
+#
+# This file is subject to the terms and conditions of the GNU General Public
+# License.  See the file "COPYING" in the main directory of this archive
+# for more details.
+#
+# Copyright (C) 2002-2004 Silicon Graphics, Inc.  All Rights Reserved.
+#
+# Makefile for the sn2 io routines.
+
+obj-y				+=  pcibr_sal_interfaces.o \
+				    pcibr_dma.o pcibr_reg.o \
+				    pcibr_ate.o pcibr_err.o \
+				    pcibr_intr.o pcibr_provider.o \
+				    wrappers/
diff -Nru a/arch/ia64/sn/ioif/pci/pcibr_dma.c b/arch/ia64/sn/ioif/pci/pcibr_dma.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ia64/sn/ioif/pci/pcibr_dma.c	2004-08-11 16:14:09 -05:00
@@ -0,0 +1,729 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2001-2004 Silicon Graphics, Inc. All rights reserved.
+ */
+
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <asm/sn/sn_sal.h>
+#include <asm/sn/sn2/geo.h>
+#include <asm/sn/xtalk/xtalk_provider.h>
+#include <asm/sn/xtalk/xwidgetdev.h>
+#include <asm/sn/xtalk/hubdev.h>
+#include <asm/sn/pci/pcibus_provider_defs.h>
+#include <asm/sn/pci/pcidev.h>
+#include <asm/sn/pci/pcibus.h>
+#include <asm/sn/pci/pcibr_asic.h>
+#include <asm/sn/pci/pcibr_provider.h>
+#include <asm/sn/pci/tiocp.h>
+#include <asm/sn/sn2/tio.h>
+#include <asm/sn/addrs.h>
+
+
+/* =====================================================================
+ *    Device(x) register management
+ */
+
+/* pcibr_try_set_device: attempt to modify Device(x) 
+ * for the specified slot on the specified bridge
+ * as requested in flags, limited to the specified
+ * bits. Returns which BRIDGE bits were in conflict,
+ * or ZERO if everything went OK.
+ *
+ * Caller MUST hold pcibr_lock when calling this function.
+ */
+static int
+pcibr_try_set_device(struct pcibus_info *pcibus_info,
+		     uint8_t internal_device, uint32_t flags, uint64_t mask)
+{
+	struct pcibus_slot *slotp;
+	uint64_t old;
+	uint64_t new;
+	uint64_t chg;
+	uint64_t bad;
+	uint64_t badpmu;
+	uint64_t badd32;
+	uint64_t badd64;
+	uint64_t fix;
+	uint64_t s;
+
+	slotp = &pcibus_info->pbi_slot[internal_device];
+
+	s = pcibr_lock(pcibus_info);
+
+	old = slotp->device;
+
+	/* figure out what the desired
+	 * Device(x) bits are based on
+	 * the flags specified.
+	 */
+
+	new = old;
+
+	/* Currently, we inherit anything that
+	 * the new caller has not specified in
+	 * one way or another, unless we take
+	 * action here to not inherit.
+	 *
+	 * This is needed for the "swap" stuff,
+	 * since it could have been set via
+	 * pcibr_endian_set -- altho note that
+	 * any explicit PCIBR_BYTE_STREAM or
+	 * PCIBR_WORD_VALUES will freely override
+	 * the effect of that call (and vice
+	 * versa, no protection either way).
+	 *
+	 * I want to get rid of pcibr_endian_set
+	 * in favor of tracking DMA endianness
+	 * using the flags specified when DMA
+	 * channels are created.
+	 */
+
+	/* Do not use Barrier, Write Gather,
+	 * or Prefetch unless asked.
+	 * Leave everything else as it
+	 * was from the last time.
+	 */
+	new = new
+	    & ~PCIBR_DEV_BARRIER & ~PCIBR_DEV_DIR_WRGA_EN & ~PCIBR_DEV_PREF;
+
+	/* Generic macro flags
+	 */
+	if (flags & PCIIO_DMA_DATA) {
+		new = (new & ~PCIBR_DEV_BARRIER)	/* barrier off */
+		    |PCIBR_DEV_PREF;	/* prefetch on */
+	}
+	if (flags & PCIIO_DMA_CMD) {
+		new = ((new & ~PCIBR_DEV_PREF)	/* prefetch off */
+		       &~PCIBR_DEV_DIR_WRGA_EN)	/* write gather off */
+		    |PCIBR_DEV_BARRIER;	/* barrier on */
+	}
+	/* Generic detail flags
+	 */
+	if (flags & PCIIO_WRITE_GATHER)
+		new |= PCIBR_DEV_DIR_WRGA_EN;
+	if (flags & PCIIO_NOWRITE_GATHER)
+		new &= ~PCIBR_DEV_DIR_WRGA_EN;
+
+	if (flags & PCIIO_PREFETCH)
+		new |= PCIBR_DEV_PREF;
+	if (flags & PCIIO_NOPREFETCH)
+		new &= ~PCIBR_DEV_PREF;
+
+	if (flags & PCIBR_WRITE_GATHER)
+		new |= PCIBR_DEV_DIR_WRGA_EN;
+	if (flags & PCIBR_NOWRITE_GATHER)
+		new &= ~PCIBR_DEV_DIR_WRGA_EN;
+
+	if (flags & PCIIO_BYTE_STREAM)
+		new |= PCIBR_DEV_SWAP_DIR;
+	if (flags & PCIIO_WORD_VALUES)
+		new &= ~PCIBR_DEV_SWAP_DIR;
+
+	/* Provider-specific flags
+	 */
+	if (flags & PCIBR_PREFETCH)
+		new |= PCIBR_DEV_PREF;
+	if (flags & PCIBR_NOPREFETCH)
+		new &= ~PCIBR_DEV_PREF;
+
+	if (flags & PCIBR_PRECISE)
+		new |= PCIBR_DEV_PRECISE;
+	if (flags & PCIBR_NOPRECISE)
+		new &= ~PCIBR_DEV_PRECISE;
+
+	if (flags & PCIBR_BARRIER)
+		new |= PCIBR_DEV_BARRIER;
+	if (flags & PCIBR_NOBARRIER)
+		new &= ~PCIBR_DEV_BARRIER;
+
+	if (flags & PCIBR_64BIT)
+		new |= PCIBR_DEV_DEV_SIZE;
+	if (flags & PCIBR_NO64BIT)
+		new &= ~PCIBR_DEV_DEV_SIZE;
+
+	if (IS_TIOCP_SOFT(pcibus_info) && (flags & PCIBR_PEER_PIO))
+		new |= TIOCP_DEV_PIO_OP;
+
+	/*
+	 * PIC BRINGUP WAR (PV# 855271):
+	 * Allow setting PCIBR_DEV_VIRTUAL_EN on PIC iff we're a 64-bit
+	 * device.  The bit is only intended for 64-bit devices and, on
+	 * PIC, can cause problems for 32-bit devices.
+	 */
+	if (IS_PIC_SOFT(pcibus_info) && mask == PCIBR_DEV_D64_BITS &&
+	    PCIBR_WAR_ENABLED(PV855271, pcibus_info)) {
+		if (flags & PCIBR_VCHAN1) {
+			new |= PCIBR_DEV_VIRTUAL_EN;
+			mask |= PCIBR_DEV_VIRTUAL_EN;
+		}
+	}
+
+	/* PIC BRINGUP WAR (PV# 878674):   Don't allow 64bit PIO accesses */
+	if (IS_PIC_SOFT(pcibus_info) && (flags & PCIBR_64BIT) &&
+	    PCIBR_WAR_ENABLED(PV878674, pcibus_info)) {
+		new &= ~PCIBR_DEV_DEV_SIZE;
+	}
+
+	chg = old ^ new;	/* what are we changing, */
+	chg &= mask;		/* of the interesting bits */
+
+	if (chg) {
+
+		badd32 = slotp->d32_uctr ? (PCIBR_DEV_D32_BITS & chg) : 0;
+		badpmu = slotp->pmu_uctr ? (PCIBR_DEV_PMU_BITS & chg) : 0;
+		badd64 = slotp->d64_uctr ? (PCIBR_DEV_D64_BITS & chg) : 0;
+		bad = badpmu | badd32 | badd64;
+
+		if (bad) {
+
+			/* some conflicts can be resolved by
+			 * forcing the bit on. this may cause
+			 * some performance degredation in
+			 * the stream(s) that want the bit off,
+			 * but the alternative is not allowing
+			 * the new stream at all.
+			 */
+			if ((fix = bad & (PCIBR_DEV_PRECISE |
+					  PCIBR_DEV_BARRIER))) {
+				bad &= ~fix;
+				/* don't change these bits if
+				 * they are already set in "old"
+				 */
+				chg &= ~(fix & old);
+			}
+			/* some conflicts can be resolved by
+			 * forcing the bit off. this may cause
+			 * some performance degredation in
+			 * the stream(s) that want the bit on,
+			 * but the alternative is not allowing
+			 * the new stream at all.
+			 */
+			if ((fix = bad & (PCIBR_DEV_DIR_WRGA_EN |
+					  PCIBR_DEV_PREF))) {
+				bad &= ~fix;
+				/* don't change these bits if
+				 * we wanted to turn them on.
+				 */
+				chg &= ~(fix & new);
+			}
+			/* conflicts in other bits mean
+			 * we can not establish this DMA
+			 * channel while the other(s) are
+			 * still present.
+			 */
+			if (bad) {
+				pcibr_unlock(pcibus_info, s);
+				PCIBR_DEBUG((PCIBR_DEBUG_DEVREG, pcibus_info,
+					     "pcibr_try_set_device: mod blocked by 0x%x\n",
+					     bad));
+				return bad;
+			}
+		}
+	}
+	if (mask == PCIBR_DEV_PMU_BITS)
+		slotp->pmu_uctr++;
+	if (mask == PCIBR_DEV_D32_BITS)
+		slotp->d32_uctr++;
+	if (mask == PCIBR_DEV_D64_BITS)
+		slotp->d64_uctr++;
+
+	/* the value we want to write is the
+	 * original value, with the bits for
+	 * our selected changes flipped, and
+	 * with any disabled features turned off.
+	 */
+	new = old ^ chg;	/* only change what we want to change */
+
+	if (slotp->device == new) {
+		pcibr_unlock(pcibus_info, s);
+		return 0;
+	}
+
+	pcireg_device_set(pcibus_info, internal_device, new);
+	slotp->device = new;
+	pcireg_tflush_get(pcibus_info);	/* wait until Bridge PIO complete */
+	pcibr_unlock(pcibus_info, s);
+
+	PCIBR_DEBUG((PCIBR_DEBUG_DEVREG, pcibus_info,
+		     "pcibr_try_set_device: Device(%d): 0x%x\n", slot, new));
+	return 0;
+}
+
+void
+pcibr_release_device(struct pcibus_info *pcibus_info, uint8_t slot,
+		     uint64_t mask)
+{
+	struct pcibus_slot *slotp;
+	uint64_t s;
+
+	slotp = &pcibus_info->pbi_slot[slot];
+
+	s = pcibr_lock(pcibus_info);
+
+	if (mask == PCIBR_DEV_PMU_BITS)
+		slotp->pmu_uctr--;
+	if (mask == PCIBR_DEV_D32_BITS)
+		slotp->d32_uctr--;
+	if (mask == PCIBR_DEV_D64_BITS)
+		slotp->d64_uctr--;
+
+	pcibr_unlock(pcibus_info, s);
+}
+
+/* =====================================================================
+ *    DMA MANAGEMENT
+ *
+ *      The Bridge ASIC provides three methods of doing DMA: via a "direct map"
+ *      register available in 32-bit PCI space (which selects a contiguous 2G
+ *	address space on some other widget), via "direct" addressing via 64-bit
+ *      PCI space (all destination information comes from the PCI address,
+ *      including transfer attributes), and via a "mapped" region that allows 
+ *      a bunch of different small mappings to be established with the PMU.
+ *
+ *      For efficiency, we most prefer to use the 32bit direct mapping facility,
+ *      since it requires no resource allocations. The advantage of using the
+ *      PMU over the 64-bit direct is that single-cycle PCI addressing can be
+ *      used; the advantage of using 64-bit direct over PMU addressing is that
+ *      we do not have to allocate entries in the PMU.
+ */
+
+/*
+ * Convert PCI-generic software flags and Bridge-specific software flags
+ * into Bridge-specific Direct Map attribute bits.
+ */
+static uint64_t pcibr_flags_to_d64(uint32_t flags,
+				   struct pcibus_info *pcibus_info)
+{
+	uint64_t attributes = 0;
+
+	/* Sanity check: Bridge only allows use of VCHAN1 via 64-bit addrs */
+	ASSERT_ALWAYS(!(flags & PCIBR_VCHAN1) || (flags & PCIIO_DMA_A64));
+
+	/* Generic macro flags
+	 */
+	if (flags & PCIIO_DMA_DATA) {	/* standard data channel */
+		attributes &= ~PCI64_ATTR_BAR;	/* no barrier bit */
+		attributes |= PCI64_ATTR_PREF;	/* prefetch on */
+	}
+	if (flags & PCIIO_DMA_CMD) {	/* standard command channel */
+		attributes |= PCI64_ATTR_BAR;	/* barrier bit on */
+		attributes &= ~PCI64_ATTR_PREF;	/* disable prefetch */
+	}
+	/* Generic detail flags
+	 */
+	if (flags & PCIIO_PREFETCH)
+		attributes |= PCI64_ATTR_PREF;
+	if (flags & PCIIO_NOPREFETCH)
+		attributes &= ~PCI64_ATTR_PREF;
+
+	/* the swap bit is in the address attributes */
+	if (flags & PCIIO_BYTE_STREAM)
+		attributes |= PCI64_ATTR_SWAP;
+	if (flags & PCIIO_WORD_VALUES)
+		attributes &= ~PCI64_ATTR_SWAP;
+
+	/* Provider-specific flags
+	 */
+	if (flags & PCIBR_BARRIER)
+		attributes |= PCI64_ATTR_BAR;
+	if (flags & PCIBR_NOBARRIER)
+		attributes &= ~PCI64_ATTR_BAR;
+
+	if (flags & PCIBR_PREFETCH)
+		attributes |= PCI64_ATTR_PREF;
+	if (flags & PCIBR_NOPREFETCH)
+		attributes &= ~PCI64_ATTR_PREF;
+
+	if (flags & PCIBR_PRECISE)
+		attributes |= PCI64_ATTR_PREC;
+	if (flags & PCIBR_NOPRECISE)
+		attributes &= ~PCI64_ATTR_PREC;
+
+	if (flags & PCIBR_VCHAN1)
+		attributes |= PCI64_ATTR_VIRTUAL;
+	if (flags & PCIBR_VCHAN0)
+		attributes &= ~PCI64_ATTR_VIRTUAL;
+
+	/* Bus in PCI-X mode only supports barrier & swap */
+	if (IS_PCIX(pcibus_info)) {
+		attributes &= (PCI64_ATTR_BAR | PCI64_ATTR_SWAP);
+	}
+
+	return attributes;
+}
+
+uint64_t
+pcibr_dmamap_ate32(struct pcidev_info * info,
+		   uint64_t paddr, size_t req_size, uint32_t flags)
+{
+
+	struct pcidev_info *pcidev_info = info->pdi_host_pcidev_info;
+	struct pcibus_info * pcibus_info = (struct pcibus_info *) pcidev_info->
+						pdi_pcibus_info;
+	uint8_t internal_device;
+	int ate_count;
+	int ate_index;
+	uint64_t ate_proto;
+	uint64_t ate;
+	uint64_t pci_addr;
+	uint64_t xio_addr;
+	uint64_t offset;
+
+	/* PIC in PCI-X mode does not supports 32bit PageMap mode */
+	if (IS_PIC_SOFT(pcibus_info) && IS_PCIX(pcibus_info)) {
+		return 0;
+	}
+
+	flags |= pcibus_info->pbi_dma_flags;	/* Forced flags. */
+	internal_device = pcidev_info->pdi_internal_dev;
+	if (pcibr_try_set_device(pcibus_info, internal_device, flags, 
+		PCIBR_DEV_PMU_BITS)) {
+		PCIBR_DEBUG_ALWAYS((PCIBR_DEBUG_DMAMAP, pcidev_info,
+				    "pcibr_dmamap_alloc: PMU use failed\n"));
+		return 0;
+	}
+
+	/*
+	 * Allocate Address Translation Entries from the mapping RAM.
+	 * Unless the PCIBR_NO_ATE_ROUNDUP flag is specified,
+	 * the maximum number of ATEs is based on the worst-case
+	 * scenario, where the requested target is in the
+	 * last byte of an ATE; thus, mapping IOPGSIZE+2
+	 * does end up requiring three ATEs.
+	 */
+	if (!(flags & PCIBR_NO_ATE_ROUNDUP)) {
+		ate_count = IOPG((IOPGSIZE - 1)	/* worst case start offset */
+				 +req_size	/* max mapping bytes */
+				 - 1) + 1;	/* round UP */
+	} else {		/* assume requested target is page aligned */
+		ate_count = IOPG(req_size	/* max mapping bytes */
+				 - 1) + 1;	/* round UP */
+	}
+	ate_index = pcibr_ate_alloc(pcibus_info, ate_count);
+	if (ate_index < 0)
+		return 0;
+
+	PCIBR_DEBUG((PCIBR_DEBUG_DMAMAP, info,
+		     "pcibr_dmamap_alloc: using PMU, ate_index=%d\n",
+		     ate_index));
+
+	ate_proto = pcibr_flags_to_ate(pcibus_info, flags);
+	xio_addr =
+	    IS_PIC_SOFT(pcibus_info) ? PHYS_TO_DMA(paddr) :
+	    PHYS_TO_TIODMA(paddr);
+	offset = IOPGOFF(xio_addr);
+	ate = ate_proto | (xio_addr - offset);
+
+	/* If PIC, put the targetid in the ATE */
+	if (IS_PIC_SOFT(pcibus_info)) {
+		ate |= (pcibus_info->pbi_hub_xid << PIC_ATE_TARGETID_SHFT);
+	}
+	ate_write(pcibus_info, ate_index, ate_count, ate);
+
+	/*
+	 * Set up the DMA mapped Address.
+	 */
+	pci_addr = PCI32_MAPPED_BASE + offset + IOPGSIZE * ate_index;
+	if (flags & PCIIO_BYTE_STREAM)
+		ATE_SWAP_ON(pci_addr);
+	/*
+	 * If swap was set in device in pcibr_endian_set()
+	 * we need to change the address bit.
+	 */
+	if (pcibus_info->pbi_slot[internal_device].device & PCIBR_DEV_SWAP_DIR)
+		ATE_SWAP_ON(pci_addr);
+	if (flags & PCIIO_WORD_VALUES)
+		ATE_SWAP_OFF(pci_addr);
+
+	PCIBR_DEBUG((PCIBR_DEBUG_DMAMAP, info,
+		     "pcibr_dmamap_addr (PMU) : wanted paddr "
+		     "[0x%lx..0x%lx] returning PCI 0x%lx\n",
+		     paddr, paddr + req_size - 1, pci_addr));
+
+	return pci_addr;
+}
+
+void
+pcibr_unmap_ate32(struct pcibus_info *pcibus_info, uint8_t slot,
+		  dma_addr_t dma_handle)
+{
+	int ate_index;
+
+	ate_index = IOPG((ATE_SWAP_OFF(dma_handle) - PCI32_MAPPED_BASE));
+	pcibr_ate_free(pcibus_info, ate_index);
+	pcibr_release_device(pcibus_info, slot, PCIBR_DEV_PMU_BITS);
+}
+
+uint64_t
+pcibr_dmatrans_direct64(struct pcidev_info *info, uint64_t paddr,
+			uint32_t flags)
+{
+	struct pcibus_info * pcibus_info = (struct pcibus_info *)
+	    ((info->pdi_host_pcidev_info)->pdi_pcibus_info);
+	uint64_t pci_addr;
+
+	/*
+	 * hub_dmatrans_addr: Translate the paddr into an xtalk system address.
+	 * tio_dmatrans_addr: Translate the paddr into an coretalk system address.
+	 */
+	pci_addr = IS_PIC_SOFT(pcibus_info) ? PHYS_TO_DMA(paddr) :
+	    PHYS_TO_TIODMA(paddr);
+
+	/*
+	 * Set the appropriate DMA attributes.
+	 */
+	if (!(flags & PCIBR_VCHAN1))
+		flags |= PCIBR_VCHAN0;
+	flags |= pcibus_info->pbi_dma_flags;
+	pci_addr |= pcibr_flags_to_d64(flags, pcibus_info);
+
+	if (IS_PIC_SOFT(pcibus_info)) {
+		pci_addr |=
+		    ((uint64_t) pcibus_info->pbi_hub_xid << PIC_PCI64_ATTR_TARG_SHFT);
+	} else {		/* IS_TIOCP_SOFT */
+		if (flags & PCIBR_PEER_PIO) {
+			pci_addr |= TIOCP_PCI64_CMDTYPE_PIO;
+		} else {
+			pci_addr |= TIOCP_PCI64_CMDTYPE_MEM;
+		}
+	}
+
+	PCIBR_DEBUG((PCIBR_DEBUG_DMADIR, info,
+		     "pcibr_dmatrans_addr:  wanted paddr 0x%lx, "
+		     "direct64: pci_addr=0x%lx, "
+		     "new flags: 0x%x\n", paddr, pci_addr, (uint64_t) flags));
+
+	return pci_addr;
+
+}
+
+uint64_t
+pcibr_dmatrans_direct32(struct pcidev_info * info,
+			uint64_t paddr, size_t req_size, uint32_t flags)
+{
+
+	struct pcidev_info *pcidev_info = info->pdi_host_pcidev_info;
+	struct pcibus_info * pcibus_info = (struct pcibus_info *) pcidev_info->
+						pdi_pcibus_info;
+	uint8_t internal_device = pcidev_info->pdi_internal_dev;
+	struct pcibus_slot * slotp = &pcibus_info->pbi_slot[internal_device];
+
+	char xio_port;
+	uint64_t xio_addr;
+	uint64_t pci_addr;
+
+	size_t map_size;
+	uint64_t xio_base;
+	uint64_t offset;
+	uint64_t endoff;
+
+	/* PCI BRIDGE in PCI-X mode does not support 32bit Direct */
+	if (IS_PCIX(pcibus_info)) {
+		return 0;
+	}
+
+	/* merge in forced flags */
+	flags |= pcibus_info->pbi_dma_flags;
+
+	/*
+	 * hub_dmatrans_addr: Translate the paddr into an xtalk system address.
+	 * tio_dmatrans_addr: Translate the paddr into an coretalk system address.
+	 */
+	xio_addr =
+	    IS_PIC_SOFT(pcibus_info) ? PHYS_TO_DMA(paddr) :
+	    PHYS_TO_TIODMA(paddr);
+	xio_port = pcibus_info->pbi_hub_xid;
+
+	map_size = 1ULL << 31;
+	xio_base = pcibus_info->pbi_dir_xbase;
+	offset = xio_addr - xio_base;
+	endoff = req_size + offset;
+	if ((req_size > map_size) ||	/* Too Big */
+	    (xio_addr < xio_base) ||	/* Out of range for mappings */
+	    (xio_port != pcibus_info->pbi_dir_xport) ||	/* Wrong XIO Port */
+	    (endoff > map_size)) {	/* Too Big */
+		PCIBR_DEBUG((PCIBR_DEBUG_DMADIR, info,
+			     "pcibr_dmatrans_addr:  wanted paddr [0x%lx..0x%lx], "
+			     "xio_port=0x%x, xio region outside direct32 target\n",
+			     paddr, paddr + req_size - 1, xio_addr));
+		return 0;
+	}
+
+	/*
+	 * Check for the normal case where all the conditions are the same 
+	 * as the previous mappings.
+	 */
+	pci_addr = slotp->d32_base;
+	if ((pci_addr != 0xFFFFFFFF) && (flags == slotp->d32_flags)) {
+		pci_addr |= offset;
+
+		PCIBR_DEBUG((PCIBR_DEBUG_DMADIR, info,
+			     "pcibr_dmatrans_addr:  wanted paddr [0x%lx..0x%lx],"
+			     " xio_port=0x%x, direct32: pci_addr=0x%lx\n",
+			     paddr, paddr + req_size - 1, xio_addr, pci_addr));
+
+		return pci_addr;
+	}
+
+	if (!pcibr_try_set_device
+	    (pcibus_info, internal_device, flags, PCIBR_DEV_D32_BITS)) {
+
+		pci_addr = PCI32_DIRECT_BASE;
+		slotp->d32_flags = flags;
+		slotp->d32_base = pci_addr;
+		pci_addr |= offset;
+
+		PCIBR_DEBUG((PCIBR_DEBUG_DMADIR, info,
+			     "pcibr_dmatrans_addr:  wanted paddr [0x%lx..0x%lx],"
+			     " xio_port=0x%x, direct32: pci_addr=0x%lx, "
+			     "new flags: 0x%x\n", paddr, paddr + req_size - 1,
+			     xio_addr, pci_addr, (uint64_t) flags));
+
+		return pci_addr;
+	}
+
+	return 0;		/* Not reached .. */
+
+}
+
+/*
+ * Wrapper routine for free'ing DMA maps
+ * DMA mappings for Direct 64 and 32 do not have any DMA maps.
+ */
+void
+pcibr_dma_unmap(struct pcidev_info *pcidev_info, dma_addr_t dma_handle,
+		int direction)
+{
+	struct pcibus_info * pcibus_info = (struct pcibus_info *) pcidev_info->
+						pdi_pcibus_info;
+	uint8_t internal_device = pcidev_info->pdi_internal_dev;
+
+	if (IS_PCI32_MAPPED(dma_handle)) {
+		pcibr_unmap_ate32(pcibus_info, internal_device, dma_handle);
+		return;
+	} else if (dma_handle <= 0xffffffff) {	/* Direct 32 */
+		pcibr_release_device(pcibus_info, internal_device, 
+			PCIBR_DEV_D32_BITS);
+	} else {		/* Direct 64 */
+		pcibr_release_device(pcibus_info, internal_device, 
+			PCIBR_DEV_D64_BITS);
+		;
+	}
+}
+
+/*
+ * On SN systems there is a race condition between a PIO read response and 
+ * DMA's.  In rare cases, the read response may beat the DMA, causing the
+ * driver to think that data in memory is complete and meaningful.  This code
+ * eliminates that race.  This routine is called by the PIO read routines
+ * after doing the read.  For PIC this routine then forces a fake interrupt
+ * on another line, which is logically associated with the slot that the PIO
+ * is addressed to.  It then spins while watching the memory location that
+ * the interrupt is targetted to.  When the interrupt response arrives, we 
+ * are sure that the DMA has landed in memory and it is safe for the driver
+ * to proceed.	For TIOCP use the Device(x) Write Request Buffer Flush 
+ * Bridge register since it ensures the data has entered the coherence domain,
+ * unlike the PIC Device(x) Write Request Buffer Flush register.
+ */
+void sn_dma_flush(uint64_t addr)
+{
+	nasid_t nasid;
+	int is_tio;
+	int wid_num;
+	int i, j;
+	int bwin;
+	uint64_t flags;
+	struct hubdev_info *hubinfo;
+	volatile struct sn_flush_device_list *p;
+	struct sn_flush_nasid_entry *flush_nasid_list;
+
+	nasid = NASID_GET(addr);
+	hubinfo = (NODEPDA(NASID_TO_COMPACT_NODEID(nasid)))->pdinfo;
+	if (!hubinfo)
+		BUG();
+	is_tio = (nasid & 1);
+
+	if (is_tio) {
+		wid_num = TIO_SWIN_WIDGETNUM(addr);
+		bwin = TIO_BWIN_WINDOWNUM(addr);
+	} else {
+		wid_num = SWIN_WIDGETNUM(addr);
+		bwin = BWIN_WINDOWNUM(addr);
+	}
+
+	flush_nasid_list = &hubinfo->hdi_flush_nasid_list;
+	if (flush_nasid_list->widget_p == NULL)
+		return;
+	if (bwin > 0) {
+		uint64_t itte = flush_nasid_list->iio_itte[bwin];
+
+		if (is_tio) {
+			wid_num = (itte >> TIO_ITTE_WIDGET_SHIFT) &
+			    TIO_ITTE_WIDGET_MASK;
+		} else {
+			wid_num = (itte >> IIO_ITTE_WIDGET_SHIFT) &
+			    IIO_ITTE_WIDGET_MASK;
+		}
+	}
+	if (flush_nasid_list->widget_p == NULL)
+		return;
+	if (flush_nasid_list->widget_p[wid_num] == NULL)
+		return;
+	p = &flush_nasid_list->widget_p[wid_num][0];
+
+	/* find a matching BAR */
+	for (i = 0; i < DEV_PER_WIDGET; i++) {
+		for (j = 0; j < PCI_ROM_RESOURCE; j++) {
+			if (p->sfdl_bar_list[j].start == 0)
+				break;
+			if (addr >= p->sfdl_bar_list[j].start
+			    && addr <= p->sfdl_bar_list[j].end)
+				break;
+		}
+		if (j < PCI_ROM_RESOURCE && p->sfdl_bar_list[j].start != 0)
+			break;
+		p++;
+	}
+
+	/* if no matching BAR, return without doing anything. */
+	if (i == DEV_PER_WIDGET)
+		return;
+
+	/*
+	 * For TIOCP use the Device(x) Write Request Buffer Flush Bridge
+	 * register since it ensures the data has entered the coherence
+	 * domain, unlike PIC
+	 */
+	if (is_tio) {
+		uint32_t tio_id = REMOTE_HUB_L(nasid, TIO_NODE_ID);
+		uint32_t revnum = XWIDGET_PART_REV_NUM(tio_id);
+
+		/* TIOCP BRINGUP WAR (PV907516): Don't write buffer flush reg */
+		if ((1 << XWIDGET_PART_REV_NUM_REV(revnum)) & PV907516) {
+			return;
+		} else {
+			pcireg_wrb_flush_get(p->sfdl_pcibus_info, (p->sfdl_slot - 1));
+		}
+	} else {
+		spin_lock_irqsave(&((struct sn_flush_device_list *)p)->
+				  sfdl_flush_lock, flags);
+
+		p->sfdl_flush_value = 0;
+
+		/* force an interrupt. */
+		*(volatile uint32_t *)(p->sfdl_force_int_addr) = 1;
+
+		/* wait for the interrupt to come back. */
+		while (*(p->sfdl_flush_addr) != 0x10f) ;
+
+		/* okay, everything is synched up. */
+		spin_unlock_irqrestore(&p->sfdl_flush_lock, flags);
+	}
+	return;
+}
+
+EXPORT_SYMBOL(sn_dma_flush);
diff -Nru a/arch/ia64/sn/ioif/pci/pcibr_provider.c b/arch/ia64/sn/ioif/pci/pcibr_provider.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ia64/sn/ioif/pci/pcibr_provider.c	2004-08-11 16:14:09 -05:00
@@ -0,0 +1,182 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2001-2004 Silicon Graphics, Inc. All rights reserved.
+ */
+
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+#include <asm/sn/sn_sal.h>
+#include <asm/sn/sn2/geo.h>
+#include <asm/sn/xtalk/xtalk_provider.h>
+#include <asm/sn/xtalk/xwidgetdev.h>
+#include <asm/sn/xtalk/hubdev.h>
+#include <asm/sn/module.h>
+#include <asm/sn/pci/pcibus_provider_defs.h>
+#include <asm/sn/pci/pcidev.h>
+#include <asm/sn/pci/pcibus.h>
+#include <asm/sn/pci/pcibr_asic.h>
+#include <asm/sn/pci/pcibr_sal.h>
+#include <asm/sn/pci/pcibr_provider.h>
+
+
+/*
+ * global variables to toggle the different levels of pcibr debugging.
+ *   -pcibr_debug_mask is the mask of the different types of debugging
+ *    you want to enable.  See include/asm-ia64/sn/pci/pcibr_provider.h
+ *   -pcibr_debug_module is the module you want to trace.  By default
+ *    all modules are trace.  The format is something like "001c10".
+ *   -pcibr_debug_bus is the bus in a given 'module' you want to trace.
+ *   -pcibr_debug_slot is the pci slot you want to trace.
+ *   -pcibr_debug_func is the pci function you want to trace.
+ */
+uint32_t pcibr_debug_mask = 0x00000000;	/* 0x00000000 to disable */
+static char *pcibr_debug_module = "all";/* 'all' for all modules */
+static int pcibr_debug_bus = -1;	/* '-1' for all bus      */
+static int pcibr_debug_slot = -1;	/* '-1' for all slots    */
+static int pcibr_debug_func = -1;	/* '-1' for all funcs    */
+
+pcibus_provider_t tiocp_pci_interfaces = {
+	PCIIO_ASIC_TYPE_PIC,
+
+	(pcibus_dmatrans_direct64_f *) pcibr_dmatrans_direct64,
+	(pcibus_dmatrans_direct32_f *) pcibr_dmatrans_direct32,
+	(pcibus_dma_unmap_f *) pcibr_dma_unmap,
+	(pcibus_dmamap_ate32_f *) pcibr_dmamap_ate32,
+
+	(pcibus_rrb_alloc_f *) sal_pcibr_rrb_alloc,
+
+	(pcibus_endian_set_f *) sal_pcibr_endian_set,
+	(pcibus_error_interrupt_f *) sal_pcibr_error_interrupt,
+
+	(pcibus_safe_read_addr_f *) sal_pcibr_safe_read_addr,
+	(pcibus_safe_write_addr_f *) sal_pcibr_safe_write_addr,
+
+	(pcibus_slot_enable_f *) sal_pcibr_slot_enable,
+	(pcibus_slot_disable_f *) sal_pcibr_slot_disable,
+};
+
+pcibus_provider_t pic_pci_interfaces = {
+	PCIIO_ASIC_TYPE_PIC,
+
+	(pcibus_dmatrans_direct64_f *) pcibr_dmatrans_direct64,
+	(pcibus_dmatrans_direct32_f *) pcibr_dmatrans_direct32,
+	(pcibus_dma_unmap_f *) pcibr_dma_unmap,
+	(pcibus_dmamap_ate32_f *) pcibr_dmamap_ate32,
+
+	(pcibus_rrb_alloc_f *) sal_pcibr_rrb_alloc,
+
+	(pcibus_endian_set_f *) sal_pcibr_endian_set,
+	(pcibus_error_interrupt_f *) sal_pcibr_error_interrupt,
+
+	(pcibus_safe_read_addr_f *) sal_pcibr_safe_read_addr,
+	(pcibus_safe_write_addr_f *) sal_pcibr_safe_write_addr,
+
+	(pcibus_slot_enable_f *) sal_pcibr_slot_enable,
+	(pcibus_slot_disable_f *) sal_pcibr_slot_disable,
+};
+
+/*
+ * pcibr_debug() is used to print pcibr debug messages to the console.	A
+ * user enables tracing by setting the following global variables:
+ *
+ *    pcibr_debug_mask	   -Bitmask of what to trace. see pcibr_provider.h
+ *    pcibr_debug_module   -Module to trace.  'all' means trace all modules
+ *    pcibr_debug_bus	   -bus in module to trace. '-1' means trace all busses
+ *    pcibr_debug_slot	   -Slot to trace.  '-1' means trace all slots
+ *    pcibr_debug_func	   -Function to trace.	'-1' means trace all slots
+ *
+ * 'type' is the type of debugging that the current PCIBR_DEBUG macro is
+ * tracing.  'ptr' (which can be NULL) is the pcidev_info struct associated
+ * with the debug statement or is the pcibus_info struct if the pcidev_info
+ * struct isn't available.  If there is a 'ptr' associated with this debug
+ * statement, module, bus, slot and func are obtained from it.	If the
+ * globals above match the PCIBR_DEBUG params, then the debug info in the
+ * parameter 'format' is sent to the console.
+ */
+void pcibr_debug(uint32_t type, void *ptr, char *format, ...)
+{
+	char module[8] = "all";
+	char buffer[256];
+	int bus = -1;
+	int slot = -1;
+	int func = -1;
+	va_list ap;
+
+	if (pcibr_debug_mask & type) {
+		if (ptr) {
+			struct pcibus_info *pcibus_info =
+			    (struct pcibus_info *)ptr;
+			struct pcidev_info *pcidev_info =
+			    (struct pcidev_info *)ptr;
+
+			if (pcibus_info->pbi_magic == PCIBR_SOFT_MAGIC) {
+				pcidev_info = NULL;	/* not a struct pcidev_info * */
+			} else {
+				pcibus_info =
+				    (struct pcibus_info *) pcidev_info->
+						pdi_pcibus_info;
+			}
+
+			format_module_id(module, pcibus_info->pbi_moduleid,
+					 MODULE_FORMAT_LCD);
+			bus = pcibus_info->pbi_brick_busnum;
+			if (pcidev_info) {
+				slot = (int)PCI_SLOT(((struct pci_dev *)
+					(pcidev_info->pdi_linux_pcidev))->devfn);
+				func = (int)PCI_FUNC(((struct pci_dev *)
+					(pcidev_info->pdi_linux_pcidev))->devfn);
+			}
+		}
+
+		if ((ptr == NULL) ||
+		    ((pcibr_debug_bus == -1 || pcibr_debug_bus == bus) &&
+		     (pcibr_debug_slot == -1 || pcibr_debug_slot == slot) &&
+		     (pcibr_debug_func == -1 || pcibr_debug_func == func) &&
+		     (!strcmp("all", pcibr_debug_module) ||
+		      (!strcmp(module, pcibr_debug_module))))) {
+
+			/* We are tracing this module/bus/slot/func, print it out */
+			if (strlen(module) != 6)
+				strcpy(module, "unknwn");
+			printk("PCIBR_DEBUG: <%s>:%02d:%02d:%02d:\t", module,
+			       bus, slot, func);
+			va_start(ap, format);
+			vsprintf(buffer, format, ap);
+			printk(buffer);
+			va_end(ap);
+		}
+	}
+}
+
+void pcibr_fixup(struct pcibus_info *soft)
+{
+
+	/*
+	 * register the bridge's error interrupt handler
+	 */
+	request_irq(SGI_PCIBR_ERROR, (void *)pcibr_error_intr_handler,
+		    SA_SHIRQ, "PCIBR error", (void *)(soft));
+
+	/*
+	 * initalize the xwidget_info's provider table
+	 */
+	if (IS_PIC_SOFT(soft)) {
+		soft->pbi_xwidget_info->xwi_khub_provider = &hub_provider;
+	} else {
+		soft->pbi_xwidget_info->xwi_khub_provider = &tio_provider;
+	}
+
+	/* 
+	 * Update the Bridge with the "kernel" pagesize 
+	 */
+	if (PAGE_SIZE < 16384) {
+		pcireg_control_bit_clr(soft, PCIBR_CTRL_PAGE_SIZE);
+	} else {
+		pcireg_control_bit_set(soft, PCIBR_CTRL_PAGE_SIZE);
+	}
+
+}
diff -Nru a/arch/ia64/sn/ioif/pci/pcibr_sal_interfaces.c b/arch/ia64/sn/ioif/pci/pcibr_sal_interfaces.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ia64/sn/ioif/pci/pcibr_sal_interfaces.c	2004-08-11 16:14:09 -05:00
@@ -0,0 +1,134 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2001-2004 Silicon Graphics, Inc. All rights reserved.
+ */
+
+#include <asm/sn/sn_sal.h>
+#include <asm/sn/pci/pcibus_provider_defs.h>
+#include <asm/sn/pci/pcidev.h>
+#include <asm/sn/pci/pcibus.h>
+#include <asm/sn/pci/pcibr_sal.h>
+#include <asm/sn/pci/pcibr_provider.h>
+#include <linux/pci.h>
+
+int sal_pcibr_rrb_alloc(struct pcidev_info *info, int *count_vchan0,
+			int *count_vchan1)
+{
+
+	struct ia64_sal_retval ret_stuff;
+	uint64_t busnum, devfn;
+	ret_stuff.status = 0;
+	ret_stuff.v0 = 0;
+
+	busnum = info->pdi_linux_pcidev->bus->number;
+	devfn = info->pdi_linux_pcidev->devfn;
+	SAL_CALL_NOLOCK(ret_stuff, (u64) SN_SAL_PCIIO,
+			(u64) PCIIO_CALL_RRB_ALLOC,
+			(u64) busnum, (u64)devfn, (u64) count_vchan0,
+			(u64) count_vchan1, (u64) 0, 0);
+	return (int)ret_stuff.v1;
+}
+
+enum pcidev_endian sal_pcibr_endian_set(struct pcidev_info *info,
+					enum pcidev_endian device_end,
+					enum pcidev_endian desired_end)
+{
+
+	struct ia64_sal_retval ret_stuff;
+	uint64_t busnum, devfn;
+	ret_stuff.status = 0;
+	ret_stuff.v0 = 0;
+
+	busnum = info->pdi_linux_pcidev->bus->number;
+	devfn = info->pdi_linux_pcidev->devfn;
+	SAL_CALL_NOLOCK(ret_stuff, (u64) SN_SAL_PCIIO,
+			(u64) PCIIO_CALL_ENDIAN_SET,
+			(u64) busnum, (u64)devfn,
+			(u64) device_end, (u64) desired_end, 0, 0);
+
+	return (enum pcidev_endian)ret_stuff.v1;
+}
+
+int sal_pcibr_slot_enable(struct pcibus_info *soft, void *slot_info)
+{
+	struct ia64_sal_retval ret_stuff;
+	uint64_t busnum;
+	ret_stuff.status = 0;
+	ret_stuff.v0 = 0;
+
+	busnum = ((struct pcibus_info *)soft)->pbi_buscommon.bs_persist_busnum;
+	SAL_CALL_NOLOCK(ret_stuff, (u64) SN_SAL_PCIIO,
+			(u64) PCIIO_CALL_SLOT_ENABLE,
+			(u64) busnum, (u64) slot_info, 0, 0, 0, 0);
+
+	return (int)ret_stuff.v1;
+}
+
+int sal_pcibr_slot_disable(struct pcibus_info *soft, void *slot_info)
+{
+	struct ia64_sal_retval ret_stuff;
+	uint64_t busnum;
+	ret_stuff.status = 0;
+	ret_stuff.v0 = 0;
+
+	busnum = ((struct pcibus_info *)soft)->pbi_buscommon.bs_persist_busnum;
+	SAL_CALL_NOLOCK(ret_stuff, (u64) SN_SAL_PCIIO,
+			(u64) PCIIO_CALL_SLOT_DISABLE,
+			(u64) busnum, (u64) slot_info, 0, 0, 0, 0);
+
+	return (int)ret_stuff.v1;
+}
+
+int sal_pcibr_error_interrupt(struct pcibus_info *soft)
+{
+	struct ia64_sal_retval ret_stuff;
+	uint64_t busnum;
+	ret_stuff.status = 0;
+	ret_stuff.v0 = 0;
+
+	busnum = soft->pbi_buscommon.bs_persist_busnum;
+	SAL_CALL_NOLOCK(ret_stuff, (u64) SN_SAL_PCIIO,
+			(u64) PCIIO_CALL_ERROR_INTERRUPT,
+			(u64) busnum, 0, 0, 0, 0, 0);
+
+	return (int)ret_stuff.v0;
+}
+
+int sal_pcibr_safe_read_addr(struct pcidev_info *pcidev_info,
+			     void *from, int length, void *to)
+{
+
+	struct ia64_sal_retval ret_stuff;
+	uint64_t busnum, devfn;
+	ret_stuff.status = 0;
+	ret_stuff.v0 = 0;
+
+	busnum = pcidev_info->pdi_linux_pcidev->bus->number;
+	devfn = pcidev_info->pdi_linux_pcidev->devfn;
+	SAL_CALL_NOLOCK(ret_stuff, SN_SAL_PCIIO, PCIIO_CALL_SAFE_READ_ADDR,
+			(u64) busnum, (u64) devfn,
+			(u64) from, (u64) length, (u64) to, 0);
+
+	return (int)ret_stuff.v0;
+}
+
+int sal_pcibr_safe_write_addr(struct pcidev_info *pcidev_info,
+			      void *to, int length, void *data)
+{
+
+	struct ia64_sal_retval ret_stuff;
+	uint64_t busnum, devfn;
+	ret_stuff.status = 0;
+	ret_stuff.v0 = 0;
+
+	busnum = pcidev_info->pdi_linux_pcidev->bus->number;
+	devfn = pcidev_info->pdi_linux_pcidev->devfn;
+	SAL_CALL_NOLOCK(ret_stuff, SN_SAL_PCIIO, PCIIO_CALL_SAFE_WRITE_ADDR,
+			(u64) busnum, (u64) devfn,
+			(u64) to, (u64) length, (u64) data, 0);
+
+	return (int)ret_stuff.v0;
+}
