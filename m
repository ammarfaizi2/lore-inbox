Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310979AbSDUHIq>; Sun, 21 Apr 2002 03:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311211AbSDUHIp>; Sun, 21 Apr 2002 03:08:45 -0400
Received: from ucsu.Colorado.EDU ([128.138.129.83]:36088 "EHLO
	ucsu.colorado.edu") by vger.kernel.org with ESMTP
	id <S310979AbSDUHIo>; Sun, 21 Apr 2002 03:08:44 -0400
Content-Type: text/plain; charset=US-ASCII
From: "Ivan G." <ivangurdiev@yahoo.com>
Reply-To: ivangurdiev@yahoo.com
Organization: ( )
To: Urban Widmark <urban@teststation.com>,
        Shing Chuang <ShingChuang@via.com.tw>
Subject: [PATCH] Via-rhine minor issues
Date: Sun, 21 Apr 2002 01:02:20 -0600
X-Mailer: KMail [version 1.2]
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <02042101022001.00833@cobra.linux>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please comment on this before I send to Marcello.
I am a newbie and would like some help.
Patch fixes minor issues in the driver.

Note: Shing Chuang, this includes your own patch for Rhine-III support 
since it's not yet in the kernel and I diff-ed against the original source, 
while I added your patch to my driver version.

BTW your own patch wouldn't patch cleanly for some reason.

DIFF-ED AGAINST:
2.4.19-pre3 ( I don't think there were changes to via-rhine 
b-ween pre3 and pre7)

CONTENTS:
- Shing Chuang's Rhine III support and 6100 cleanup patch.
- edited comments on supported cards
- removed unused W_MAX_TIMEOUT
- added flag HasDavicomPhy for VT86C100A card
- changed chip_id in wait_for_reset as parameter since np is not initialized
the first time this function is called (should this be fixed differently?)
- enable all interrupts (add 4 additional ones)
- fix debug message - frame is off by one
- change "Something Wicked" message to "PCI Error" (I still don't see the 
purpose of the trap)

NOTE:
Urban, this should clear up the annoying minor issues so I can do more tests
on my own delay problem (Via-Rhine stalls on transmit thread)

PATCH:  (watch out for kmail newlines on several places)

--- via-rhine.c.origkernel      Sat Mar 30 01:10:02 2002
+++ via-rhine.c Sun Apr 21 00:30:34 2002
@@ -9,8 +9,8 @@
        a complete program and may only be used when the entire operating
        system is licensed under the GPL.

-       This driver is designed for the VIA VT86c100A Rhine-II PCI Fast 
Ethernet
-       controller.  It also works with the older 3043 Rhine-I chip.
+       This driver is designed for the VIA VT86C100A Rhine-I.
+       It also works with the 6102 Rhine-II, and 6105/6105M Rhine-III.

        The author may be reached as becker@scyld.com, or C/O
        Scyld Computing Corporation
@@ -136,9 +136,6 @@

 #define PKT_BUF_SZ             1536                    /* Size of each 
temporary Rx buffer.*/

-/* max time out delay time */
-#define W_MAX_TIMEOUT  0x0FFFU
-
 #if !defined(__OPTIMIZE__)  ||  !defined(__KERNEL__)
 #warning  You must compile this file with the correct options!
 #warning  See the last lines of the source file.
@@ -317,7 +314,8 @@
 enum via_rhine_chips {
        VT86C100A = 0,
        VT6102,
-       VT3043,
+       VT6105,
+       VT6105M
 };

 struct via_rhine_chip_info {
@@ -342,18 +340,21 @@
 static struct via_rhine_chip_info via_rhine_chip_info[] __devinitdata =
 {
        { "VIA VT86C100A Rhine", RHINE_IOTYPE, 128,
-         CanHaveMII | ReqTxAlign },
+         CanHaveMII | ReqTxAlign | HasDavicomPhy },
        { "VIA VT6102 Rhine-II", RHINE_IOTYPE, 256,
          CanHaveMII | HasWOL },
-       { "VIA VT3043 Rhine",    RHINE_IOTYPE, 128,
-         CanHaveMII | ReqTxAlign }
+       { "VIA VT6105 Rhine-III", RHINE_IOTYPE, 256,
+         CanHaveMII | HasWOL },
+       { "VIA VT6105M Rhine-III", RHINE_IOTYPE, 256,
+         CanHaveMII | HasWOL },
 };

 static struct pci_device_id via_rhine_pci_tbl[] __devinitdata =
 {
-       {0x1106, 0x6100, PCI_ANY_ID, PCI_ANY_ID, 0, 0, VT86C100A},
+       {0x1106, 0x3043, PCI_ANY_ID, PCI_ANY_ID, 0, 0, VT86C100A},
        {0x1106, 0x3065, PCI_ANY_ID, PCI_ANY_ID, 0, 0, VT6102},
-       {0x1106, 0x3043, PCI_ANY_ID, PCI_ANY_ID, 0, 0, VT3043},
+       {0x1106, 0x3106, PCI_ANY_ID, PCI_ANY_ID, 0, 0, VT6105},
+       {0x1106, 0x3053, PCI_ANY_ID, PCI_ANY_ID, 0, 0, VT6105M},
        {0,}                    /* terminate list */
 };
 MODULE_DEVICE_TABLE(pci, via_rhine_pci_tbl);
@@ -502,15 +503,13 @@
 static int  via_rhine_close(struct net_device *dev);
 static inline void clear_tally_counters(long ioaddr);

-static void wait_for_reset(struct net_device *dev, char *name)
+static void wait_for_reset(struct net_device *dev, int chip_id, char *name)
 {
-       struct netdev_private *np = dev->priv;
        long ioaddr = dev->base_addr;
-       int chip_id = np->chip_id;
        int i;

-       /* 3043 may need long delay after reset (dlink) */
-       if (chip_id == VT3043 || chip_id == VT86C100A)
+       /* VT86C100A may need long delay after reset (dlink) */
+       if (chip_id == VT86C100A)
                udelay(100);

        i = 0;
@@ -531,7 +530,7 @@
 static void __devinit enable_mmio(long ioaddr, int chip_id)
 {
        int n;
-       if (chip_id == VT3043 || chip_id == VT86C100A) {
+       if (chip_id == VT86C100A) {
                /* More recent docs say that this bit is reserved ... */
                n = inb(ioaddr + ConfigA) | 0x20;
                outb(n, ioaddr + ConfigA);
@@ -659,7 +658,7 @@
        writew(CmdReset, ioaddr + ChipCmd);

        dev->base_addr = ioaddr;
-       wait_for_reset(dev, shortname);
+       wait_for_reset(dev, chip_id, shortname);

        /* Reload the station address from the EEPROM. */
 #ifdef USE_IO
@@ -980,7 +979,8 @@

        /* Enable interrupts by setting the interrupt mask. */
        writew(IntrRxDone | IntrRxErr | IntrRxEmpty| IntrRxOverflow| 
IntrRxDropped|
-                  IntrTxDone | IntrTxAbort | IntrTxUnderrun |
+                  IntrRxEarly | IntrRxNoBuf | IntrRxWakeUp | IntrTxAborted|
+                  IntrTxDone | IntrTxAbort | IntrTxUnderrun |
                   IntrPCIErr | IntrStatsMax | IntrLinkChange | IntrMIIChange,
                   ioaddr + IntrEnable);

@@ -1070,7 +1070,7 @@
                return i;
        alloc_rbufs(dev);
        alloc_tbufs(dev);
-       wait_for_reset(dev, dev->name);
+       wait_for_reset(dev, np->chip_id, dev->name);
        init_registers(dev);
        if (debug > 2)
                printk(KERN_DEBUG "%s: Done via_rhine_open(), status %4.4x "
@@ -1177,7 +1177,7 @@
        alloc_rbufs(dev);

        /* Reinitialize the hardware. */
-       wait_for_reset(dev, dev->name);
+       wait_for_reset(dev, np->chip_id, dev->name);
        init_registers(dev);

        spin_unlock(&np->lock);
@@ -1247,7 +1247,7 @@

        if (debug > 4) {
                printk(KERN_DEBUG "%s: Transmit frame #%d queued in slot 
%d.\n",
-                          dev->name, np->cur_tx, entry);
+                          dev->name, np->cur_tx-1, entry);
        }
        return 0;
 }
@@ -1498,12 +1498,11 @@
                        printk(KERN_INFO "%s: Transmitter underrun, 
increasing Tx "
                                   "threshold setting to %2.2x.\n", 
dev->name, np->tx_thresh);
        }
-       if ((intr_status & ~( IntrLinkChange | IntrStatsMax |
-                                                 IntrTxAbort | 
IntrTxAborted))) {
+       if (intr_status & IntrPCIErr) {
                if (debug > 1)
-                       printk(KERN_ERR "%s: Something Wicked happened! 
%4.4x.\n",
+                       printk(KERN_ERR "%s: PCI Error! %4.4x.\n",
                           dev->name, intr_status);
-               /* Recovery for other fault sources not known. */
+               /* Recovery for PCI Error. */
                writew(CmdTxDemand | np->chip_cmd, dev->base_addr + ChipCmd);
        }


 

