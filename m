Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261320AbVCKURk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbVCKURk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 15:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbVCKUQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 15:16:41 -0500
Received: from outmx023.isp.belgacom.be ([195.238.2.204]:65244 "EHLO
	outmx023.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S261798AbVCKUI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 15:08:28 -0500
Message-ID: <4231FABA.2030809@246tNt.com>
Date: Fri, 11 Mar 2005 21:08:26 +0100
From: Sylvain Munaut <tnt@246tNt.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040816)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Tom Rini <trini@kernel.crashing.org>
Subject: Re: [PATCH 2/2] MPC52xx updates : PCI Support
References: <4231F9F9.5080506@246tNt.com>
In-Reply-To: <4231F9F9.5080506@246tNt.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And here's the second patch :


# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/03/11 19:58:21+01:00 tnt@246tNt.com
#   ppc32: Add PCI bus support for Freescale MPC52xx
#  
#   Note that this support has "known" problem but theses
#   are believed to be due to hardware issues.
#  
#   Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
#
# arch/ppc/syslib/mpc52xx_pci.h
#   2005/03/11 19:57:56+01:00 tnt@246tNt.com +139 -0
#   ppc32: Add PCI bus support for Freescale MPC52xx
#
# include/linux/pci_ids.h
#   2005/03/11 19:57:56+01:00 tnt@246tNt.com +1 -0
#   ppc32: Add PCI bus support for Freescale MPC52xx
#
# include/asm-ppc/mpc52xx.h
#   2005/03/11 19:57:56+01:00 tnt@246tNt.com +2 -0
#   ppc32: Add PCI bus support for Freescale MPC52xx
#
# arch/ppc/syslib/mpc52xx_pci.h
#   2005/03/11 19:57:56+01:00 tnt@246tNt.com +0 -0
#   BitKeeper file 
/home/tnt/musicbox/kernel/linux-2.5-mpc52xx-pending/arch/ppc/syslib/mpc52xx_pci.h
#
# arch/ppc/syslib/mpc52xx_pci.c
#   2005/03/11 19:57:56+01:00 tnt@246tNt.com +235 -0
#   ppc32: Add PCI bus support for Freescale MPC52xx
#
# arch/ppc/syslib/Makefile
#   2005/03/11 19:57:56+01:00 tnt@246tNt.com +3 -0
#   ppc32: Add PCI bus support for Freescale MPC52xx
#
# arch/ppc/platforms/lite5200.c
#   2005/03/11 19:57:56+01:00 tnt@246tNt.com +33 -3
#   ppc32: Add PCI bus support for Freescale MPC52xx
#
# arch/ppc/Kconfig
#   2005/03/11 19:57:56+01:00 tnt@246tNt.com +1 -1
#   ppc32: Add PCI bus support for Freescale MPC52xx
#
# arch/ppc/syslib/mpc52xx_pci.c
#   2005/03/11 19:57:56+01:00 tnt@246tNt.com +0 -0
#   BitKeeper file 
/home/tnt/musicbox/kernel/linux-2.5-mpc52xx-pending/arch/ppc/syslib/mpc52xx_pci.c
#
diff -Nru a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig  2005-03-11 20:41:56 +01:00
+++ b/arch/ppc/Kconfig  2005-03-11 20:41:56 +01:00
@@ -1097,7 +1097,7 @@
        bool

 config PCI
-       bool "PCI support" if 40x || CPM2 || 83xx || 85xx
+       bool "PCI support" if 40x || CPM2 || 83xx || 85xx || PPC_MPC52xx
        default y if !40x && !CPM2 && !8xx && !APUS && !83xx && !85xx
        default PCI_PERMEDIA if !4xx && !CPM2 && !8xx && APUS
        default PCI_QSPAN if !4xx && !CPM2 && 8xx
diff -Nru a/arch/ppc/platforms/lite5200.c b/arch/ppc/platforms/lite5200.c
--- a/arch/ppc/platforms/lite5200.c     2005-03-11 20:41:56 +01:00
+++ b/arch/ppc/platforms/lite5200.c     2005-03-11 20:41:56 +01:00
@@ -35,6 +35,8 @@
 #include <asm/ocp.h>
 #include <asm/mpc52xx.h>

+#include <syslib/mpc52xx_pci.h>
+

 extern int powersave_nap;

fdef CONFIG_PCI
+static int
+lite5200_map_irq(struct pci_dev *dev, unsigned char idsel,
+                 unsigned char pin) {
+       return (pin == 1) && (idsel==24) ? MPC52xx_IRQ0 : -1;
+}
+#endif
+
 static void __init
 lite5200_setup_cpu(void)
 {
+       struct mpc52xx_xlb  __iomem *xlb;
        struct mpc52xx_intr __iomem *intr;

        u32 intr_ctrl;

        /* Map zones */
+       xlb  = ioremap(MPC52xx_XLB,sizeof(struct mpc52xx_xlb));
        intr = ioremap(MPC52xx_INTR,sizeof(struct mpc52xx_intr));

-       if (!intr) {
-               printk("lite5200.c: Error while mapping INTR during 
lite5200_setup_cpu\n");
+       if (!xlb || !intr) {
+               printk("lite5200.c: Error while mapping XLB/INTR during 
lite5200_setup_cpu\n");
                goto unmap_regs;
        }

+       /* Configure the XLB Arbiter */
+       out_be32(&xlb->master_pri_enable, 0xff);
+       out_be32(&xlb->master_priority, 0x11111111);
+
+       /* Enable ram snooping for 1GB window */
+       out_be32(&xlb->config, in_be32(&xlb->config) | 
MPC52xx_XLB_CFG_SNOOP);
+       out_be32(&xlb->snoop_window, MPC52xx_PCI_TARGET_MEM | 0x1d);
+
        /* IRQ[0-3] setup : IRQ0     - Level Active Low  */
        /*                  IRQ[1-3] - Level Active High */
        intr_ctrl = in_be32(&intr->ctrl);
@@ -103,6 +123,7 @@
       
        /* Unmap reg zone */
 unmap_regs:
+       if (xlb)  iounmap(xlb);
        if (intr) iounmap(intr);
 }
 
@@ -114,6 +135,11 @@
       
        /* CPU & Port mux setup */
        lite5200_setup_cpu();
+
+#ifdef CONFIG_PCI
+       /* PCI Bridge setup */
+       mpc52xx_find_bridges();
+#endif
 }
 
 void __init
@@ -152,7 +178,7 @@
        /* BAT setup */
        mpc52xx_set_bat();
 
-       /* No ISA bus AFAIK */
+       /* No ISA bus by default */
        isa_io_base             = 0;
        isa_mem_base            = 0;
 
@@ -165,6 +191,10 @@
        ppc_md.show_percpuinfo  = NULL;
        ppc_md.init_IRQ         = mpc52xx_init_irq;
        ppc_md.get_irq          = mpc52xx_get_irq;
+
+#ifdef CONFIG_PCI
+       ppc_md.pci_map_irq      = lite5200_map_irq;
+#endif
       
        ppc_md.find_end_of_memory = mpc52xx_find_end_of_memory;
        ppc_md.setup_io_mappings  = mpc52xx_map_io;
diff -Nru a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
--- a/arch/ppc/syslib/Makefile  2005-03-11 20:41:56 +01:00
+++ b/arch/ppc/syslib/Makefile  2005-03-11 20:41:56 +01:00
@@ -106,3 +106,6 @@
 endif
 obj-$(CONFIG_MPC8555_CDS)      += todc_time.o
 obj-$(CONFIG_PPC_MPC52xx)      += mpc52xx_setup.o mpc52xx_pic.o
+ifeq ($(CONFIG_PPC_MPC52xx),y)
+obj-$(CONFIG_PCI)              += mpc52xx_pci.o
+endif
diff -Nru a/arch/ppc/syslib/mpc52xx_pci.c b/arch/ppc/syslib/mpc52xx_pci.c
--- /dev/null   Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/syslib/mpc52xx_pci.c     2005-03-11 20:41:56 +01:00
@@ -0,0 +1,235 @@
+/*
+ * arch/ppc/syslib/mpc52xx_pci.c
+ *
+ * PCI code for the Freescale MPC52xx embedded CPU.
+ *
+ *
+ * Maintainer : Sylvain Munaut <tnt@246tNt.com>
+ *
+ * Copyright (C) 2004 Sylvain Munaut <tnt@246tNt.com>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <linux/config.h>
+
+#include <asm/pci.h>
+
+#include <asm/mpc52xx.h>
+#include "mpc52xx_pci.h"
+
+#include <asm/delay.h>
+
+
+static int
+mpc52xx_pci_read_config(struct pci_bus *bus, unsigned int devfn,
+                        int offset, int len, u32 *val)
+{
+       struct pci_controller *hose = bus->sysdata;
+       u32 value;
+
+       if (ppc_md.pci_exclude_device)
+               if (ppc_md.pci_exclude_device(bus->number, devfn))
+                       return PCIBIOS_DEVICE_NOT_FOUND;
+
+       out_be32(hose->cfg_addr,
+               (1 << 31) |
+               ((bus->number - hose->bus_offset) << 16) |
+               (devfn << 8) |
+               (offset & 0xfc));
+
+       value = in_le32(hose->cfg_data);
+
+       if (len != 4) {
+               value >>= ((offset & 0x3) << 3);
+               value &= 0xffffffff >> (32 - (len << 3));
+       }
+
+       *val = value;
+
+       out_be32(hose->cfg_addr, 0);
+
+       return PCIBIOS_SUCCESSFUL;
+}
+
+static int
+mpc52xx_pci_write_config(struct pci_bus *bus, unsigned int devfn,
+                         int offset, int len, u32 val)
+{
+       struct pci_controller *hose = bus->sysdata;
+       u32 value, mask;
+
+       if (ppc_md.pci_exclude_device)
+               if (ppc_md.pci_exclude_device(bus->number, devfn))
+                       return PCIBIOS_DEVICE_NOT_FOUND;
+
+       out_be32(hose->cfg_addr,
+               (1 << 31) |
+               ((bus->number - hose->bus_offset) << 16) |
+               (devfn << 8) |
+               (offset & 0xfc));
+
+       if (len != 4) {
+               value = in_le32(hose->cfg_data);
+
+               offset = (offset & 0x3) << 3;
+               mask = (0xffffffff >> (32 - (len << 3)));
+               mask <<= offset;
+
+               value &= ~mask;
+               val = value | ((val << offset) & mask);
+       }
+
+       out_le32(hose->cfg_data, val);
+
+       out_be32(hose->cfg_addr, 0);
+
+       return PCIBIOS_SUCCESSFUL;
+}
+
+static struct pci_ops mpc52xx_pci_ops = {
+       .read  = mpc52xx_pci_read_config,
+       .write = mpc52xx_pci_write_config
+};
+
+
+static void __init
+mpc52xx_pci_setup(struct mpc52xx_pci __iomem *pci_regs)
+{
+
+       /* Setup control regs */
+               /* Nothing to do afaik */
+
+       /* Setup windows */
+       out_be32(&pci_regs->iw0btar, MPC52xx_PCI_IWBTAR_TRANSLATION(
+               MPC52xx_PCI_MEM_START + MPC52xx_PCI_MEM_OFFSET,
+               MPC52xx_PCI_MEM_START,
+               MPC52xx_PCI_MEM_SIZE ));
+
+       out_be32(&pci_regs->iw1btar, MPC52xx_PCI_IWBTAR_TRANSLATION(
+               MPC52xx_PCI_MMIO_START + MPC52xx_PCI_MEM_OFFSET,
+               MPC52xx_PCI_MMIO_START,
+               MPC52xx_PCI_MMIO_SIZE ));
+
+       out_be32(&pci_regs->iw2btar, MPC52xx_PCI_IWBTAR_TRANSLATION(
+               MPC52xx_PCI_IO_BASE,
+               MPC52xx_PCI_IO_START,
+               MPC52xx_PCI_IO_SIZE ));
+
+       out_be32(&pci_regs->iwcr, MPC52xx_PCI_IWCR_PACK(
+               ( MPC52xx_PCI_IWCR_ENABLE |             /* iw0btar */
+                 MPC52xx_PCI_IWCR_READ_MULTI |
+                 MPC52xx_PCI_IWCR_MEM ),
+               ( MPC52xx_PCI_IWCR_ENABLE |             /* iw1btar */
+                 MPC52xx_PCI_IWCR_READ |
+                 MPC52xx_PCI_IWCR_MEM ),
+               ( MPC52xx_PCI_IWCR_ENABLE |             /* iw2btar */
+                 MPC52xx_PCI_IWCR_IO )
+       ));
+
+
+       out_be32(&pci_regs->tbatr0,
+               MPC52xx_PCI_TBATR_ENABLE | MPC52xx_PCI_TARGET_IO );
+       out_be32(&pci_regs->tbatr1,
+               MPC52xx_PCI_TBATR_ENABLE | MPC52xx_PCI_TARGET_MEM );
+
+       out_be32(&pci_regs->tcr, MPC52xx_PCI_TCR_LD);
+
+       /* Reset the exteral bus ( internal PCI controller is NOT 
resetted ) */
+       /* Not necessary and can be a bad thing if for example the 
bootloader
+          is displaying a splash screen or ... Just left here for
+          documentation purpose if anyone need it */
+#if 0
+       u32 tmp;
+       tmp = in_be32(&pci_regs->gscr);
+       out_be32(&pci_regs->gscr, tmp | MPC52xx_PCI_GSCR_PR);
+       udelay(50);
+       out_be32(&pci_regs->gscr, tmp);
+#endif
+}
+
+static void __init
+mpc52xx_pci_fixup_resources(struct pci_dev *dev)
+{
+       int i;
+
+       /* We don't rely on boot loader for PCI and resets all
+          devices */
+       for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
+               struct resource *res = &dev->resource[i];
+               if (res->end > res->start) {    /* Only valid resources */
+                       res->end -= res->start;
+                       res->start = 0;
+                       res->flags |= IORESOURCE_UNSET;
+               }
+       }
+
+       /* The PCI Host bridge of MPC52xx has a prefetch memory resource
+          fixed to 1Gb. Doesn't fit in the resource system so we remove 
it */
+       if ( (dev->vendor == PCI_VENDOR_ID_MOTOROLA) &&
+            (dev->device == PCI_DEVICE_ID_MOTOROLA_MPC5200) ) {
+               struct resource *res = &dev->resource[1];
+               res->start = res->end = res->flags = 0;
+       }
+}
+
+void __init
+mpc52xx_find_bridges(void)
+{
+       struct mpc52xx_pci __iomem *pci_regs;
+       struct pci_controller *hose;
+
+       pci_assign_all_busses = 1;
+
+       pci_regs = ioremap(MPC52xx_PCI, sizeof(struct mpc52xx_pci));
+       if (!pci_regs)
+               return;
+
+       hose = pcibios_alloc_controller();
+       if (!hose) {
+               iounmap(pci_regs);
+               return;
+       }
+
+       ppc_md.pci_swizzle = common_swizzle;
+       ppc_md.pcibios_fixup_resources = mpc52xx_pci_fixup_resources;
+
+       hose->first_busno = 0;
+       hose->last_busno = 0xff;
+       hose->bus_offset = 0;
+       hose->ops = &mpc52xx_pci_ops;
+
+       mpc52xx_pci_setup(pci_regs);
+
+       hose->pci_mem_offset = MPC52xx_PCI_MEM_OFFSET;
+
+       isa_io_base =
+               (unsigned long) ioremap(MPC52xx_PCI_IO_BASE,
+                                       MPC52xx_PCI_IO_SIZE);
+       hose->io_base_virt = (void *) isa_io_base;
+
+       hose->cfg_addr = &pci_regs->car;
+       hose->cfg_data = (void __iomem *) isa_io_base;
+
+       /* Setup resources */
+       pci_init_resource(&hose->mem_resources[0],
+                       MPC52xx_PCI_MEM_START,
+                       MPC52xx_PCI_MEM_STOP,
+                       IORESOURCE_MEM|IORESOURCE_PREFETCH,
+                       "PCI prefetchable memory");
+
+       pci_init_resource(&hose->mem_resources[1],
+                       MPC52xx_PCI_MMIO_START,
+                       MPC52xx_PCI_MMIO_STOP,
+                       IORESOURCE_MEM,
+                       "PCI memory");
+
+       pci_init_resource(&hose->io_resource,
+                       MPC52xx_PCI_IO_START,
+                       MPC52xx_PCI_IO_STOP,
+                       IORESOURCE_IO,
+                       "PCI I/O");
+
+}
diff -Nru a/arch/ppc/syslib/mpc52xx_pci.h b/arch/ppc/syslib/mpc52xx_pci.h
--- /dev/null   Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/syslib/mpc52xx_pci.h     2005-03-11 20:41:56 +01:00
@@ -0,0 +1,139 @@
+/*
+ * arch/ppc/syslib/mpc52xx_pci.h
+ *
+ * PCI Include file the Freescale MPC52xx embedded cpu chips
+ *
+ *
+ * Maintainer : Sylvain Munaut <tnt@246tNt.com>
+ *
+ * Inspired from code written by Dale Farnsworth <dfarnsworth@mvista.com>
+ * for the 2.4 kernel.
+ *
+ * Copyright (C) 2004 Sylvain Munaut <tnt@246tNt.com>
+ * Copyright (C) 2003 MontaVista, Software, Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#ifndef __SYSLIB_MPC52xx_PCI_H__
+#define __SYSLIB_MPC52xx_PCI_H__
+
+/* 
======================================================================== */
+/* PCI windows 
config                                                       */
+/* 
======================================================================== */
+
+/*
+ * Master windows : MPC52xx -> PCI
+ *
+ *  0x80000000 -> 0x9FFFFFFF       PCI Mem prefetchable          IW0BTAR
+ *  0xA0000000 -> 0xAFFFFFFF       PCI Mem                       IW1BTAR
+ *  0xB0000000 -> 0xB0FFFFFF       PCI IO                        IW2BTAR
+ *
+ * Slave windows  : PCI -> MPC52xx
+ *
+ *  0xF0000000 -> 0xF003FFFF       MPC52xx MBAR                  TBATR0
+ *  0x00000000 -> 0x3FFFFFFF       MPC52xx local memory          TBATR1
+ */
+
+#define MPC52xx_PCI_MEM_OFFSET         0x00000000      /* Offset for 
MEM MMIO */
+
+#define MPC52xx_PCI_MEM_START  0x80000000
+#define MPC52xx_PCI_MEM_SIZE   0x20000000
+#define MPC52xx_PCI_MEM_STOP   
(MPC52xx_PCI_MEM_START+MPC52xx_PCI_MEM_SIZE-1)
+
+#define MPC52xx_PCI_MMIO_START 0xa0000000
+#define MPC52xx_PCI_MMIO_SIZE  0x10000000
+#define MPC52xx_PCI_MMIO_STOP  
(MPC52xx_PCI_MMIO_START+MPC52xx_PCI_MMIO_SIZE-1)
+
+#define MPC52xx_PCI_IO_BASE    0xb0000000
+
+#define MPC52xx_PCI_IO_START   0x00000000
+#define MPC52xx_PCI_IO_SIZE    0x01000000
+#define MPC52xx_PCI_IO_STOP    (MPC52xx_PCI_IO_START+MPC52xx_PCI_IO_SIZE-1)
+
+
+#define MPC52xx_PCI_TARGET_IO  MPC52xx_MBAR
+#define MPC52xx_PCI_TARGET_MEM 0x00000000
+
+
+/* 
======================================================================== */
+/* Structures mapping & Defines for PCI 
Unit                                */
+/* 
======================================================================== */
+
+#define MPC52xx_PCI_GSCR_BM            0x40000000
+#define MPC52xx_PCI_GSCR_PE            0x20000000
+#define MPC52xx_PCI_GSCR_SE            0x10000000
+#define MPC52xx_PCI_GSCR_XLB2PCI_MASK  0x07000000
+#define MPC52xx_PCI_GSCR_XLB2PCI_SHIFT 24
+#define MPC52xx_PCI_GSCR_IPG2PCI_MASK  0x00070000
+#define MPC52xx_PCI_GSCR_IPG2PCI_SHIFT 16
+#define MPC52xx_PCI_GSCR_BME           0x00004000
+#define MPC52xx_PCI_GSCR_PEE           0x00002000
+#define MPC52xx_PCI_GSCR_SEE           0x00001000
+#define MPC52xx_PCI_GSCR_PR            0x00000001
+
+
+#define MPC52xx_PCI_IWBTAR_TRANSLATION(proc_ad,pci_ad,size)      \
+               ( ( (proc_ad) & 0xff000000 )                    | \
+                 ( (((size) - 1) >> 8) & 0x00ff0000 )          | \
+                 ( ((pci_ad) >> 16) & 0x0000ff00 ) )
+                
+#define MPC52xx_PCI_IWCR_PACK(win0,win1,win2)  (((win0) << 24) | \
+                                                ((win1) << 16) | \
+                                                ((win2) <<  8))
+
+#define MPC52xx_PCI_IWCR_DISABLE       0x0
+#define MPC52xx_PCI_IWCR_ENABLE                0x1
+#define MPC52xx_PCI_IWCR_READ          0x0
+#define MPC52xx_PCI_IWCR_READ_LINE     0x2
+#define MPC52xx_PCI_IWCR_READ_MULTI    0x4
+#define MPC52xx_PCI_IWCR_MEM           0x0
+#define MPC52xx_PCI_IWCR_IO            0x8
+
+#define MPC52xx_PCI_TCR_P              0x01000000
+#define MPC52xx_PCI_TCR_LD             0x00010000
+
+#define MPC52xx_PCI_TBATR_DISABLE      0x0
+#define MPC52xx_PCI_TBATR_ENABLE       0x1
+
+
+#ifndef __ASSEMBLY__
+
+struct mpc52xx_pci {
+       u32     idr;            /* PCI + 0x00 */
+       u32     scr;            /* PCI + 0x04 */
+       u32     ccrir;          /* PCI + 0x08 */
+       u32     cr1;            /* PCI + 0x0C */
+       u32     bar0;           /* PCI + 0x10 */
+       u32     bar1;           /* PCI + 0x14 */
+       u8      reserved1[16];  /* PCI + 0x18 */
+       u32     ccpr;           /* PCI + 0x28 */
+       u32     sid;            /* PCI + 0x2C */
+       u32     erbar;          /* PCI + 0x30 */
+       u32     cpr;            /* PCI + 0x34 */
+       u8      reserved2[4];   /* PCI + 0x38 */
+       u32     cr2;            /* PCI + 0x3C */
+       u8      reserved3[32];  /* PCI + 0x40 */
+       u32     gscr;           /* PCI + 0x60 */
+       u32     tbatr0;         /* PCI + 0x64 */
+       u32     tbatr1;         /* PCI + 0x68 */
+       u32     tcr;            /* PCI + 0x6C */
+       u32     iw0btar;        /* PCI + 0x70 */
+       u32     iw1btar;        /* PCI + 0x74 */
+       u32     iw2btar;        /* PCI + 0x78 */
+       u8      reserved4[4];   /* PCI + 0x7C */
+       u32     iwcr;           /* PCI + 0x80 */
+       u32     icr;            /* PCI + 0x84 */
+       u32     isr;            /* PCI + 0x88 */
+       u32     arb;            /* PCI + 0x8C */
+       u8      reserved5[104]; /* PCI + 0x90 */
+       u32     car;            /* PCI + 0xF8 */
+       u8      reserved6[4];   /* PCI + 0xFC */
+};
+
+#endif  /* __ASSEMBLY__ */
+
+
+#endif  /* __SYSLIB_MPC52xx_PCI_H__ */
diff -Nru a/include/asm-ppc/mpc52xx.h b/include/asm-ppc/mpc52xx.h
--- a/include/asm-ppc/mpc52xx.h 2005-03-11 20:41:56 +01:00
+++ b/include/asm-ppc/mpc52xx.h 2005-03-11 20:41:56 +01:00
@@ -393,6 +393,8 @@
 extern void mpc52xx_calibrate_decr(void);
 extern void mpc52xx_add_board_devices(struct ocp_def board_ocp[]);

+extern void mpc52xx_find_bridges(void);
+
 #endif /* __ASSEMBLY__ */


diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h   2005-03-11 20:41:56 +01:00
+++ b/include/linux/pci_ids.h   2005-03-11 20:41:56 +01:00
@@ -807,6 +807,7 @@
 #define PCI_DEVICE_ID_MOTOROLA_HAWK    0x4803
 #define PCI_DEVICE_ID_MOTOROLA_CPX8216 0x4806
 #define PCI_DEVICE_ID_MOTOROLA_HARRIER 0x480b
+#define PCI_DEVICE_ID_MOTOROLA_MPC5200 0x5803

 #define PCI_VENDOR_ID_PROMISE          0x105a
 #define PCI_DEVICE_ID_PROMISE_20265    0x0d30

