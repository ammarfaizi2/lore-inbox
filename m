Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292797AbSB0SYo>; Wed, 27 Feb 2002 13:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292871AbSB0SYW>; Wed, 27 Feb 2002 13:24:22 -0500
Received: from sproxy.gmx.net ([213.165.64.20]:60939 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S292874AbSB0SYE>;
	Wed, 27 Feb 2002 13:24:04 -0500
Message-ID: <3C7D2432.3A5DA1D7@gmx.net>
Date: Wed, 27 Feb 2002 19:23:46 +0100
From: Gunther Mayer <gunther.mayer@gmx.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Herbert Rosmanith <herp@wildsau.idv-edu.uni-linz.ac.at>
CC: linux-kernel@vger.kernel.org
Subject: Re: pcmcia problems with IDE & cardbus
In-Reply-To: <200202270026.g1R0QOa14113@wildsau.idv-edu.uni-linz.ac.at>
Content-Type: multipart/mixed;
 boundary="------------9EAD9A941EC2446EACB5EE51"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------9EAD9A941EC2446EACB5EE51
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Herbert Rosmanith wrote:

> hi,
>
> I've been trying to get a CompactFlash act as an IDE-drive, 2nd or 3rd
> ide-channel, that is, IDE1 or IDE2 resp. Didn't work. Seems to be driver
> related.
>
> I downloaded 2.4.18 and pcmcia-3.1.31, from the later I got "ide_cs.o"
>
> The hardware I am using a a two socket PCI to PCMCIA bridge:
>
> hale-bopp:~ # cat /proc/interrupts
> [...]
>  10:          1          XT-PIC  Texas Instruments PCI1221, Texas Instruments PCI1221 (#2)
> ...
>    : hde: SanDisk SDCFB-16, ATA DISK drive
>    : ide2: Disabled unable to get IRQ 10.
>   ...
>    : ide_cs: ide_register() at 0x100 & 0x10e, irq 10 failed
>    : Trying to free nonexistent resource <00000100-0000010f>
>
> "unable to get IRQ 10" is somewhat funny, since IRQ-10 is used by
> the cardbus device. what I don't understand is if the IDE-drive
> sould get its own interrupt or not.

With PCI-PCMCIA bridges you only have _one_ PCI irq, but linux
falsely fails to share irq in this case.

This patch exists since 6 months but due to communiation problems
between Linux and IDE maintainer nobody cared to include it.

Find my patch for 2.4.15 appended.
-
Gunther



--------------9EAD9A941EC2446EACB5EE51
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

--------------9EAD9A941EC2446EACB5EE51--

