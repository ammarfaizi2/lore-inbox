Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129746AbRBYVDQ>; Sun, 25 Feb 2001 16:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129754AbRBYVDG>; Sun, 25 Feb 2001 16:03:06 -0500
Received: from smtp102.urscorp.com ([38.202.96.105]:24078 "EHLO
	smtp102.urscorp.com") by vger.kernel.org with ESMTP
	id <S129746AbRBYVCy>; Sun, 25 Feb 2001 16:02:54 -0500
To: alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Cc: linux-tr@linuxtr.net
Subject: [PATCH] Cardbus support - Olympic Driver
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
From: mike_phillips@urscorp.com
Message-ID: <OF0C9A3B47.78131F19-ON852569FE.006D0E01@urscorp.com>
Date: Sun, 25 Feb 2001 15:52:32 -0500
X-MIMETrack: Serialize by Router on SMTP102/URSCorp(Release 5.0.5 |September 22, 2000) at
 02/25/2001 04:00:22 PM,
	Serialize complete at 02/25/2001 04:00:22 PM
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the small patch required to enable the olympic driver to work with 
the olympic chipset based cardbus tokenring adapters.
The patch is against stock 2.4.2.

(Bigger fixes to enable proper hot-swap and pci api updates are in the 
works)

Thanks
Mike Phillips
Linux Token Ring Project
http://www.linuxtr.net

diff -urN linux.orig/drivers/net/tokenring/olympic.c 
linux.cb/drivers/net/tokenring/olympic.c
--- linux.orig/drivers/net/tokenring/olympic.c  Sun Feb 25 14:19:14 2001
+++ linux.cb/drivers/net/tokenring/olympic.c    Sun Feb 25 14:19:43 2001
@@ -1,6 +1,6 @@
 /*
  *   olympic.c (c) 1999 Peter De Schrijver All Rights Reserved
- *                1999 Mike Phillips (phillim@amtrak.com)
+ *                1999 Mike Phillips (mikep@linuxtr.net)
  *
  *  Linux driver for IBM PCI tokenring cards based on the 
Pit/Pit-Phy/Olympic
  *  chipset. 
@@ -38,10 +38,11 @@
  *            Fixing the hardware descriptors was another matter,
  *            because they weren't going through read[wl](), there all
  *            the results had to be in memory in le32 values. kdaaker
- *
+ * 12/23/00 - Added minimal Cardbus support (Thanks Donald).
  *
  *  To Do:
- *
+ *           Complete full Cardbus / hot-swap support.
+ * 
  *  If Problems do Occur
  *  Most problems can be rectified by either closing and opening the 
interface
  *  (ifconfig down and up) or rmmod and insmod'ing the driver (a bit 
difficult
@@ -99,7 +100,7 @@
  */
 
 static char *version = 
-"Olympic.c v0.5.0 3/10/00 - Peter De Schrijver & Mike Phillips" ; 
+"Olympic.c v0.5.C 12/23/00 - Peter De Schrijver & Mike Phillips" ; 
 
 static struct pci_device_id olympic_pci_tbl[] __initdata = {
        { PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_TR_WAKE, PCI_ANY_ID, 
PCI_ANY_ID, },
@@ -191,10 +192,8 @@
                        if (pci_enable_device(pci_device))
                                continue;
 
-                       /* These lines are needed by the PowerPC, it 
appears
-that these flags
-                        * are not being set properly for the PPC, this 
may
-well be fixed with
+                       /* These lines are needed by the PowerPC, it 
appears that these flags
+                        * are not being set properly for the PPC, this 
may well be fixed with
                         * the new PCI code */ 
                        pci_read_config_word(pci_device, PCI_COMMAND, 
&pci_command);
                        pci_command |= PCI_COMMAND_IO | 
PCI_COMMAND_MEMORY;
@@ -287,6 +286,10 @@
        }
 
        spin_lock_init(&olympic_priv->olympic_lock) ; 
+
+/* Needed for cardbus */
+       if(!(readl(olympic_mmio+BCTL) & BCTL_MODE_INDICATOR))
+ writel(readl(olympic_priv->olympic_mmio+FERMASK)|FERMASK_INT_BIT, 
olympic_mmio+FERMASK);
 
 #if OLYMPIC_DEBUG
        printk("BCTL: %x\n",readl(olympic_mmio+BCTL));
diff -urN linux.orig/drivers/net/tokenring/olympic.h 
linux.cb/drivers/net/tokenring/olympic.h
--- linux.orig/drivers/net/tokenring/olympic.h  Sun Feb 25 14:19:14 2001
+++ linux.cb/drivers/net/tokenring/olympic.h    Sun Feb 25 14:19:43 2001
@@ -1,6 +1,6 @@
 /*
  *  olympic.h (c) 1999 Peter De Schrijver All Rights Reserved
- *                1999 Mike Phillips (phillim@amtrak.com)
+ *                1999 Mike Phillips (mikep@linuxtr.net)
  *
  *  Linux driver for IBM PCI tokenring cards based on the olympic and the 
PIT/PHY chipset.
  *
@@ -19,6 +19,7 @@
 #define BCTL 0x70
 #define BCTL_SOFTRESET (1<<15)
 #define BCTL_MIMREB (1<<6)
+#define BCTL_MODE_INDICATOR (1<<5)
 
 #define GPR 0x4a
 #define GPR_OPTI_BF (1<<6)
@@ -124,6 +125,9 @@
 #define TXSTATQCNT_2 0xe4
 #define TXCSA_1 0xc8
 #define TXCSA_2 0xe8
+/* Cardbus */
+#define FERMASK 0xf4
+#define FERMASK_INT_BIT (1<<15)
 
 #define OLYMPIC_IO_SPACE 256
 
