Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266045AbRF1RUz>; Thu, 28 Jun 2001 13:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266042AbRF1RUk>; Thu, 28 Jun 2001 13:20:40 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:29965 "EHLO
	mailout02.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S266039AbRF1RUX>; Thu, 28 Jun 2001 13:20:23 -0400
Message-ID: <3B3B677C.458188BB@t-online.de>
Date: Thu, 28 Jun 2001 19:21:00 +0200
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@aslab.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Patch(2.4.5): Fix PCMCIA ATA/IDE freeze (w/ PCI add-in cards) V3
In-Reply-To: <Pine.LNX.4.04.10106271442210.21460-100000@mail.aslab.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:
> 
> It fixes a BUG in CFA, but what will it do to the other stuff?
> Parse it exclusive to CFA and there is not an issue.
...
> Not all ./arch have a control register doing this randomly without know the
> rest of the driver will kill more than it fixes.
> 

Thanks for pointing out this implementation bug. Although I fixed another problem
in ide-cs, where ctl_base could eventually be 0.

I would rather not add a special hwif->is_pcmcia flag, as
the control register (if it exists) is well defined
(bit2=softreset bit1=nIEN, others reserved; however there is
 a hardcoded value of 0x08 somewhere in the ide code?).

-
Gunther



--- linux245.orig/drivers/ide/ide-cs.c  Fri Feb  9 20:40:02 2001
+++ linux/drivers/ide/ide-cs.c  Thu Jun 28 18:04:27 2001
@@ -42,6 +42,7 @@
 #include <linux/ioport.h>
 #include <linux/hdreg.h>
 #include <linux/major.h>
+#include <linux/ide.h>
 
 #include <asm/io.h>
 #include <asm/system.h>
@@ -223,6 +224,15 @@
 #define CFG_CHECK(fn, args...) \
 if (CardServices(fn, args) != 0) goto next_entry
 
+int idecs_register (int arg1, int arg2, int irq)
+{
+        hw_regs_t hw;
+        ide_init_hwif_ports(&hw, (ide_ioreg_t) arg1, (ide_ioreg_t) arg2, NULL);
+        hw.irq = irq;
+        hw.chipset = ide_pci; // this enables IRQ sharing w/ PCI irqs
+        return ide_register_hw(&hw, NULL);
+}
+
 void ide_config(dev_link_t *link)
 {
     client_handle_t handle = link->handle;
@@ -326,10 +336,12 @@
 
     /* retry registration in case device is still spinning up */
     for (i = 0; i < 10; i++) {
-       hd = ide_register(io_base, ctl_base, link->irq.AssignedIRQ);
+       if(ctl_base) outb(0x02, ctl_base); // Set nIEN = disable device interrupts
+       hd = idecs_register(io_base, ctl_base, link->irq.AssignedIRQ);
        if (hd >= 0) break;
        if (link->io.NumPorts1 == 0x20) {
-           hd = ide_register(io_base+0x10, ctl_base+0x10,
+           if(ctl_base) outb(0x02, ctl_base+0x10);
+           hd = idecs_register(io_base+0x10, ctl_base+0x10,
                              link->irq.AssignedIRQ);
            if (hd >= 0) {
                io_base += 0x10; ctl_base += 0x10;
--- linux245.orig/drivers/ide/ide-probe.c       Sun Mar 18 18:25:02 2001
+++ linux/drivers/ide/ide-probe.c       Thu Jun 28 18:43:43 2001
@@ -685,6 +685,9 @@
 #else /* !CONFIG_IDEPCI_SHARE_IRQ */
                int sa = (hwif->chipset == ide_pci) ? SA_INTERRUPT|SA_SHIRQ : SA_INTERRUPT;
 #endif /* CONFIG_IDEPCI_SHARE_IRQ */
+
+               if(hwif->io_ports[IDE_CONTROL_OFFSET])
+                       OUT_BYTE(0x00, hwif->io_ports[IDE_CONTROL_OFFSET]); // clear nIEN == enable irqs
                if (ide_request_irq(hwif->irq, &ide_intr, sa, hwif->name, hwgroup)) {
                        if (!match)
                                kfree(hwgroup);
--- linux245.orig/drivers/ide/ide.c     Wed May  2 01:05:00 2001
+++ linux/drivers/ide/ide.c     Thu Jun 28 18:04:42 2001
@@ -2181,6 +2181,7 @@
        memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->hw.io_ports));
        hwif->irq = hw->irq;
        hwif->noprobe = 0;
+       hwif->chipset = hw->chipset;
 
        if (!initializing) {
                ide_probe_module();
--- linux245.orig/include/linux/ide.h   Sat May 26 03:02:42 2001
+++ linux/include/linux/ide.h   Thu Jun 28 18:18:05 2001
@@ -226,6 +226,19 @@
 #endif
 
 /*
+ * hwif_chipset_t is used to keep track of the specific hardware
+ * chipset used by each IDE interface, if known.
+ */
+typedef enum {  ide_unknown,    ide_generic,    ide_pci,
+                ide_cmd640,     ide_dtc2278,    ide_ali14xx,
+                ide_qd6580,     ide_umc8672,    ide_ht6560b,
+                ide_pdc4030,    ide_rz1000,     ide_trm290,
+                ide_cmd646,     ide_cy82c693,   ide_4drives,
+                ide_pmac
+} hwif_chipset_t;
+
+
+/*
  * Structure to hold all information about the location of this port
  */
 typedef struct hw_regs_s {
@@ -234,6 +247,7 @@
        int             dma;                    /* our dma entry */
        ide_ack_intr_t  *ack_intr;              /* acknowledge interrupt */
        void            *priv;                  /* interface specific data */
+       hwif_chipset_t  chipset;
 } hw_regs_t;
 
 /*
@@ -396,17 +410,6 @@
 typedef void (ide_maskproc_t) (ide_drive_t *, int);
 typedef void (ide_rw_proc_t) (ide_drive_t *, ide_dma_action_t);
 
-/*
- * hwif_chipset_t is used to keep track of the specific hardware
- * chipset used by each IDE interface, if known.
- */
-typedef enum { ide_unknown,    ide_generic,    ide_pci,
-               ide_cmd640,     ide_dtc2278,    ide_ali14xx,
-               ide_qd6580,     ide_umc8672,    ide_ht6560b,
-               ide_pdc4030,    ide_rz1000,     ide_trm290,
-               ide_cmd646,     ide_cy82c693,   ide_4drives,
-               ide_pmac
-} hwif_chipset_t;
 
 #ifdef CONFIG_BLK_DEV_IDEPCI
 typedef struct ide_pci_devid_s {
