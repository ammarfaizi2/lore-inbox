Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265377AbRF0TBQ>; Wed, 27 Jun 2001 15:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265371AbRF0TBH>; Wed, 27 Jun 2001 15:01:07 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:29707 "EHLO
	mailout03.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S265372AbRF0TA5>; Wed, 27 Jun 2001 15:00:57 -0400
Message-ID: <3B3A2D9B.919630EC@t-online.de>
Date: Wed, 27 Jun 2001 21:01:47 +0200
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: dhinds@zen.stanford.edu, andre@aslab.com
Subject: patch(2.4.5): 2nd ed. Fix PCMCIA ATA/IDE + PCI IRQ sharing 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
this includes the last fix + now it is willing to share PCI irqs.
Of course you still need CONFIG_IDEPCI_SHARE_IRQ set.

Now CF is working very fine, hdparm-4.1 shows 1.27 MB/sec.
(Only after treaking the source for small (i.e. <64MB) devices).

Regards, Gunther




--- linux245.orig/drivers/ide/ide-cs.c  Fri Feb  9 20:40:02 2001
+++ linux/drivers/ide/ide-cs.c  Wed Jun 27 20:19:45 2001
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
@@ -324,12 +334,15 @@
     if (link->io.NumPorts2)
        release_region(link->io.BasePort2, link->io.NumPorts2);
 
+    outb(0x02, ctl_base); // Set nIEN = disable device interrupts
+                         // else it hangs on PCI-Cardbus Add-in cards wedging irq
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
--- linux245.orig/drivers/ide/ide-probe.c       Sun Mar 18 18:25:02 2001
+++ linux/drivers/ide/ide-probe.c       Wed Jun 27 17:31:45 2001
@@ -685,6 +685,8 @@
 #else /* !CONFIG_IDEPCI_SHARE_IRQ */
                int sa = (hwif->chipset == ide_pci) ? SA_INTERRUPT|SA_SHIRQ : SA_INTERRUPT;
 #endif /* CONFIG_IDEPCI_SHARE_IRQ */
+
+               outb(0x00, hwif->io_ports[IDE_CONTROL_OFFSET]); // clear nIEN == enable irqs
                if (ide_request_irq(hwif->irq, &ide_intr, sa, hwif->name, hwgroup)) {
                        if (!match)
                                kfree(hwgroup);
--- linux245.orig/drivers/ide/ide.c     Wed May  2 01:05:00 2001
+++ linux/drivers/ide/ide.c     Wed Jun 27 20:18:23 2001
@@ -2181,6 +2181,7 @@
        memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->hw.io_ports));
        hwif->irq = hw->irq;
        hwif->noprobe = 0;
+       hwif->chipset = hw->chipset;
 
        if (!initializing) {
                ide_probe_module();
--- linux245.orig/include/linux/ide.h   Sat May 26 03:02:42 2001
+++ linux/include/linux/ide.h   Wed Jun 27 19:01:35 2001
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



P.S.
====

However, my "lsata"'s heuristics shows this as ATA1
(i.e. no ATA2 features used):

lsata /dev/hde

ihack for pcmcia compact flash
ATA Level = 1
ATAPI (Packet Interface): no
ATA Device Information for Command 0xEC

Conforming to 'AT Attachment for Disk Drives'
ANSI X3.221-1994
X3T10 791D Revision 4c Working Draft
All reserved Bits shall be zero (Chap. 8.8, p.25)

Word 0 General Configuration
1 Shall be 0. Reserved for non-magnetic drives
0 Format speed tolerance gap required ? 'no' : 'yes'
0 Track Offset optin available ? 'no' : 'yes'
0 Data strobe offset option available ? 'no' : 'yes'
0 Rotational speed tolerance >0.5 percent ? 'no' : 'yes'
1 Disk transfer rate  > 10 Mbs ? 'no' : 'yes'
0 Disk transfer rate > 5Mbs but <= 10Mbs ? 'no' : 'yes'
0 Disk transfer rate < 5Mbs  ? 'no' : 'yes'
1 removable cartridge drive ? 'no' : 'yes'
0 Fixed Drive ? 'no' : 'yes'
0 Spindle motor control option implemented ? 'no' : 'yes'
0 Head switch time >15 usec ? 'no' : 'yes'
1 MFM encoded ? 'yes' : 'no'
0 Soft sectored ? 'no' : 'yes'
1 Hard sectored ? 'no' : 'yes'
0 reserved

Word 1 Number of Cylinders 02e2  0002 00e2 
738 

Word 2 Reserved
0000000000000000

Word 3 Number of Heads
4

Word 4 Number of unformatted bytes per track
0

Word 5 Number of unformatted bytes per sector
512

Word 6 Number of sectors per track
32

Word 7-9 Vendor Unique
0000000000000001
0111000100000000
0000000000000000

Word 10-19 Serial number
           Right justified padded with Spaces 20h
2020202020202020202020202020202020202020

                    

Word 20 Buffer Type
00 ? 'unspecified':'single port':'dual port':'dual port w/ read cache'
00000000000010 reserved

Word 21 Buffer size in 512 byte increment
2

Word 22 Number of ECC Bytes available on read/write long commands
4 often 4

Word 23-26 Firmware revision
52657620312e3031
Rev 1.01

Word 27-46 Model Number
4869746163686920435620372e312e31202020202020202020202020202020202020202020202020
Hitachi CV 7.1.1                        

Word 47 
00000000 Vendor unique
1 Maximum number of sect. transfered per IRQ on R/W Multiple

Word 48 Backward compatible Vendor unique use
000000000000000 unspecified 0
0 ? 'cannot':'can' perform doubleword I/O

Word 49 Capabilites
000000 reserved, Shall be 0
1 LBA Supported ?'no':'yes'
0 DMA supported ?'no':'yes'
00000000 Vendor unique

Word 50 
0000000000000000 Reserved

Word 51 see figure 6 for Mode 0,1 and 2 (1.5, 2,3 and 3,7 M B/sec)
1 PIO data transfer cycle timing mode
00000000 Vendor unique

Word 52 single Word 0,1,2 (1.0, 2.0, 4,0 MB/sec) nmultiword
multiword only mode ( 5.8 MB/sec?)
0 DMA data transfer cycle timing mode
    Shall be ignored, if Words 62 or 63 are supported.
00000000 Vendor unique

Word 53
000000000000000 Reserved
1 Words 54-58 (Current log cyl, head, sect and Capacity) ? 'may be valid' : 'valid'

Word 54 Number of current cylinders
738

Word 55 Number of current heads
4

Word 56 Number of current sectors per track
32

Word 57-58 Current Capacity in sectors
1895825409

Word 59 
0000000 Reserved
1 Multiple Sector setting is ? 'not valid' : 'valid'
0 Current Setting for number of sectors transf. per IRQ on R/W Multiple

Word 60-61 Total number of user addressable sectors in LBA mode
1895825409

Word 62 Valid Modes in ATA1:0,1,2
00000000 Single word DMA transfer active mode (LSB is mode0), One Bit shall be set
00000000 Single word DMA transfer modes supported (LSB is mode0)

Word 63 Valid Mode in ATA-1: Only 0
00000000 Multiword DMA transfer active mode (LSB is mode0), One Bit shall be set
00000000 Mulitword DMA transfer modes supported (LSB is mode0)

Word 64-127 Reserved
0000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000

Word 128-159 Vendor unique
0000484954414348492000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000

Word 160-255 Reserved
0000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000

Total Bits=4096, Bytes =512
