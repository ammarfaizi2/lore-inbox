Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289331AbSAVSEV>; Tue, 22 Jan 2002 13:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289328AbSAVSDT>; Tue, 22 Jan 2002 13:03:19 -0500
Received: from pop.gmx.net ([213.165.64.20]:30159 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S289290AbSAVSCN>;
	Tue, 22 Jan 2002 13:02:13 -0500
Message-ID: <3C4DA90C.2D251A64@gmx.net>
Date: Tue, 22 Jan 2002 19:01:48 +0100
From: root <gunther.mayer@gmx.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux@mswinxp.net
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] VAIO irq assignment fix ->CompactFlash-pcmcia freeze
In-Reply-To: <000c01c1a2ad$efc5bcc0$8119fea9@lee>
Content-Type: multipart/mixed;
 boundary="------------194EDC8AAA4E65FF99E9D2D8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------194EDC8AAA4E65FF99E9D2D8
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Lee Packham wrote:

> One is a wireless card, one is a compact flash converter thing (for the
> camera).
>
> Both cards work individually. The laptop locks up if I insert both
> cards. There is no OOPS or anything... It just locks up. Removing the
> cards does not spring it back to life.
>
> It is probably down to the fact that the Vaio laptops assign everything
> IRQ9. Please find attached my /proc/interrupts and lspci -vvv.

This is _probably_ caused by an IRQ storm, as the IDE code (which is
used for your Compact Flash) raises an IRQ in it's probe routine
but hasn't installed a handler.

The proper patch for this is ignored by Linus and Marcelo since August 2000.

Though Andre has acknowledged the bug and my patch is included in
his latest ide patches.

Try this and report:

diff -ur linux-2.4.15.orig/drivers/ide/ide-cs.c linux/drivers/ide/ide-cs.c
--- linux-2.4.15.orig/drivers/ide/ide-cs.c      Sun Sep 30 21:26:05 2001
+++ linux/drivers/ide/ide-cs.c  Sun Nov 25 13:11:36 2001
@@ -42,6 +42,7 @@
 #include <linux/ioport.h>
 #include <linux/hdreg.h>
 #include <linux/major.h>
+#include <linux/ide.h>

 #include <asm/io.h>
 #include <asm/system.h>
@@ -226,6 +227,16 @@
 #define CFG_CHECK(fn, args...) \
 if (CardServices(fn, args) != 0) goto next_entry

+int idecs_register (int io_base, int ctl_base, int irq)
+{
+        hw_regs_t hw;
+        ide_init_hwif_ports(&hw, (ide_ioreg_t) io_base, (ide_ioreg_t)
ctl_base, NULL);
+        hw.irq = irq;
+        hw.chipset = ide_pci; // this enables IRQ sharing w/ PCI irqs
+        return ide_register_hw(&hw, NULL);
+}
+
+
 void ide_config(dev_link_t *link)
 {
     client_handle_t handle = link->handle;
@@ -327,12 +338,16 @@
     if (link->io.NumPorts2)
        release_region(link->io.BasePort2, link->io.NumPorts2);

+    /* disable drive interrupts during IDE probe */
+    if(ctl_base)
+       outb(0x02, ctl_base);
+
     /* retry registration in case device is still spinning up */
     for (i = 0; i < 10; i++) {
-       hd = ide_register(io_base, ctl_base, link->irq.AssignedIRQ);
+       hd = idecs_register(io_base, ctl_base, link->irq.AssignedIRQ);
        if (hd >= 0) break;
        if (link->io.NumPorts1 == 0x20) {
-           hd = ide_register(io_base+0x10, ctl_base+0x10,
+           hd = idecs_register(io_base+0x10, ctl_base+0x10,
                              link->irq.AssignedIRQ);
            if (hd >= 0) {
                io_base += 0x10; ctl_base += 0x10;
Only in linux/drivers/ide: ide-cs.c-2415
diff -ur linux-2.4.15.orig/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.4.15.orig/drivers/ide/ide.c Thu Oct 25 22:58:35 2001
+++ linux/drivers/ide/ide.c     Sun Nov 25 13:02:34 2001
@@ -2293,6 +2293,7 @@
        memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->hw.io_ports));

        hwif->irq = hw->irq;
        hwif->noprobe = 0;
+       hwif->chipset = hw->chipset;

        if (!initializing) {
                ide_probe_module();
diff -ur linux-2.4.15.orig/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.4.15.orig/include/linux/ide.h       Thu Nov 22 20:48:07 2001
+++ linux/include/linux/ide.h   Sun Nov 25 13:05:57 2001
@@ -223,6 +223,23 @@
 #endif

 /*
+ * hwif_chipset_t is used to keep track of the specific hardware
+ * chipset used by each IDE interface, if known.
+ */
+typedef enum {  ide_unknown,    ide_generic,    ide_pci,
+                ide_cmd640,     ide_dtc2278,    ide_ali14xx,
+                ide_qd65xx,     ide_umc8672,    ide_ht6560b,
+                ide_pdc4030,    ide_rz1000,     ide_trm290,
+                ide_cmd646,     ide_cy82c693,   ide_4drives,
+                ide_pmac,       ide_etrax100
+} hwif_chipset_t;
+
+#define IDE_CHIPSET_PCI_MASK    \
+    ((1<<ide_pci)|(1<<ide_cmd646)|(1<<ide_ali14xx))
+#define IDE_CHIPSET_IS_PCI(c)   ((IDE_CHIPSET_PCI_MASK >> (c)) & 1)
+
+
+/*
  * Structure to hold all information about the location of this port
  */
 typedef struct hw_regs_s {
@@ -231,6 +248,7 @@
        int             dma;                    /* our dma entry */
        ide_ack_intr_t  *ack_intr;              /* acknowledge interrupt */
        void            *priv;                  /* interface specific data */

+       hwif_chipset_t  chipset;
 } hw_regs_t;

 /*
@@ -439,22 +457,6 @@
  * ide soft-power support
  */
 typedef int (ide_busproc_t) (struct hwif_s *, int);
-
-/*
- * hwif_chipset_t is used to keep track of the specific hardware
- * chipset used by each IDE interface, if known.
- */
-typedef enum { ide_unknown,    ide_generic,    ide_pci,
-               ide_cmd640,     ide_dtc2278,    ide_ali14xx,
-               ide_qd65xx,     ide_umc8672,    ide_ht6560b,
-               ide_pdc4030,    ide_rz1000,     ide_trm290,
-               ide_cmd646,     ide_cy82c693,   ide_4drives,
-               ide_pmac,       ide_etrax100
-} hwif_chipset_t;
-
-#define IDE_CHIPSET_PCI_MASK   \
-    ((1<<ide_pci)|(1<<ide_cmd646)|(1<<ide_ali14xx))
-#define IDE_CHIPSET_IS_PCI(c)  ((IDE_CHIPSET_PCI_MASK >> (c)) & 1)

 #ifdef CONFIG_BLK_DEV_IDEPCI
 typedef struct ide_pci_devid_s {




--------------194EDC8AAA4E65FF99E9D2D8
Content-Type: text/plain; charset=us-ascii;
 name="gmdiff-lx2415-compactflash+pcmcia+PCI"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gmdiff-lx2415-compactflash+pcmcia+PCI"

diff -ur linux-2.4.15.orig/drivers/ide/ide-cs.c linux/drivers/ide/ide-cs.c
--- linux-2.4.15.orig/drivers/ide/ide-cs.c	Sun Sep 30 21:26:05 2001
+++ linux/drivers/ide/ide-cs.c	Sun Nov 25 13:11:36 2001
@@ -42,6 +42,7 @@
 #include <linux/ioport.h>
 #include <linux/hdreg.h>
 #include <linux/major.h>
+#include <linux/ide.h>
 
 #include <asm/io.h>
 #include <asm/system.h>
@@ -226,6 +227,16 @@
 #define CFG_CHECK(fn, args...) \
 if (CardServices(fn, args) != 0) goto next_entry
 
+int idecs_register (int io_base, int ctl_base, int irq)
+{
+        hw_regs_t hw;
+        ide_init_hwif_ports(&hw, (ide_ioreg_t) io_base, (ide_ioreg_t) ctl_base, NULL);
+        hw.irq = irq;
+        hw.chipset = ide_pci; // this enables IRQ sharing w/ PCI irqs
+        return ide_register_hw(&hw, NULL);
+}
+
+
 void ide_config(dev_link_t *link)
 {
     client_handle_t handle = link->handle;
@@ -327,12 +338,16 @@
     if (link->io.NumPorts2)
 	release_region(link->io.BasePort2, link->io.NumPorts2);
 
+    /* disable drive interrupts during IDE probe */
+    if(ctl_base)
+    	outb(0x02, ctl_base);
+
     /* retry registration in case device is still spinning up */
     for (i = 0; i < 10; i++) {
-	hd = ide_register(io_base, ctl_base, link->irq.AssignedIRQ);
+	hd = idecs_register(io_base, ctl_base, link->irq.AssignedIRQ);
 	if (hd >= 0) break;
 	if (link->io.NumPorts1 == 0x20) {
-	    hd = ide_register(io_base+0x10, ctl_base+0x10,
+	    hd = idecs_register(io_base+0x10, ctl_base+0x10,
 			      link->irq.AssignedIRQ);
 	    if (hd >= 0) {
 		io_base += 0x10; ctl_base += 0x10;
Only in linux/drivers/ide: ide-cs.c-2415
diff -ur linux-2.4.15.orig/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.4.15.orig/drivers/ide/ide.c	Thu Oct 25 22:58:35 2001
+++ linux/drivers/ide/ide.c	Sun Nov 25 13:02:34 2001
@@ -2293,6 +2293,7 @@
 	memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->hw.io_ports));
 	hwif->irq = hw->irq;
 	hwif->noprobe = 0;
+	hwif->chipset = hw->chipset;
 
 	if (!initializing) {
 		ide_probe_module();
diff -ur linux-2.4.15.orig/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.4.15.orig/include/linux/ide.h	Thu Nov 22 20:48:07 2001
+++ linux/include/linux/ide.h	Sun Nov 25 13:05:57 2001
@@ -223,6 +223,23 @@
 #endif
 
 /*
+ * hwif_chipset_t is used to keep track of the specific hardware
+ * chipset used by each IDE interface, if known.
+ */
+typedef enum {  ide_unknown,    ide_generic,    ide_pci,
+                ide_cmd640,     ide_dtc2278,    ide_ali14xx,
+                ide_qd65xx,     ide_umc8672,    ide_ht6560b,
+                ide_pdc4030,    ide_rz1000,     ide_trm290,
+                ide_cmd646,     ide_cy82c693,   ide_4drives,
+                ide_pmac,       ide_etrax100
+} hwif_chipset_t;
+
+#define IDE_CHIPSET_PCI_MASK    \
+    ((1<<ide_pci)|(1<<ide_cmd646)|(1<<ide_ali14xx))
+#define IDE_CHIPSET_IS_PCI(c)   ((IDE_CHIPSET_PCI_MASK >> (c)) & 1)
+
+
+/*
  * Structure to hold all information about the location of this port
  */
 typedef struct hw_regs_s {
@@ -231,6 +248,7 @@
 	int		dma;			/* our dma entry */
 	ide_ack_intr_t	*ack_intr;		/* acknowledge interrupt */
 	void		*priv;			/* interface specific data */
+	hwif_chipset_t  chipset;
 } hw_regs_t;
 
 /*
@@ -439,22 +457,6 @@
  * ide soft-power support
  */
 typedef int (ide_busproc_t) (struct hwif_s *, int);
-
-/*
- * hwif_chipset_t is used to keep track of the specific hardware
- * chipset used by each IDE interface, if known.
- */
-typedef enum {	ide_unknown,	ide_generic,	ide_pci,
-		ide_cmd640,	ide_dtc2278,	ide_ali14xx,
-		ide_qd65xx,	ide_umc8672,	ide_ht6560b,
-		ide_pdc4030,	ide_rz1000,	ide_trm290,
-		ide_cmd646,	ide_cy82c693,	ide_4drives,
-		ide_pmac,       ide_etrax100
-} hwif_chipset_t;
-
-#define IDE_CHIPSET_PCI_MASK	\
-    ((1<<ide_pci)|(1<<ide_cmd646)|(1<<ide_ali14xx))
-#define IDE_CHIPSET_IS_PCI(c)	((IDE_CHIPSET_PCI_MASK >> (c)) & 1)
 
 #ifdef CONFIG_BLK_DEV_IDEPCI
 typedef struct ide_pci_devid_s {

--------------194EDC8AAA4E65FF99E9D2D8--

