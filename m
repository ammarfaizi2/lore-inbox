Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310359AbSCAKcB>; Fri, 1 Mar 2002 05:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310155AbSCAK3h>; Fri, 1 Mar 2002 05:29:37 -0500
Received: from mail5.speakeasy.net ([216.254.0.205]:38620 "EHLO
	mail5.speakeasy.net") by vger.kernel.org with ESMTP
	id <S310426AbSCAKYr>; Fri, 1 Mar 2002 05:24:47 -0500
Message-Id: <4.3.2.7.2.20020228230436.00b6a100@mail.speakeasy.net>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Fri, 01 Mar 2002 02:24:43 -0800
To: linux-kernel@vger.kernel.org
From: David Ruggiero <jdr@farfalle.com>
Subject: [PATCH] 3c509.c driver patch to allow full-duplex (kernel
  2.4.x, 2.5.x)
Cc: jgarzik@mandrakesoft.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to 3c509.c for kernel versions 2.4.x/2.5.x to allow selection of the 
card's full-duplex communications mode. A patched driver will report v1.20.

Feedback on the patch and any suggestions for improvements to it, or to the 
documentation, are welcomed.


Full description -

This patch allows selection of full-duplex communications mode on the 3Com 
3C509B NIC when using the 10baseT interface (prior to this, only 
half-duplex mode was available). It has been tested reasonably well over 
several months of real-world conditions, and also via ttcp benchmarks. It 
appears considerably improve the card's overall throughput under heavy i/o 
conditions.

Only boot-time initialization code is affected by the patch; no runtime 
routines or data structures are changed.

- For safety reasons, full-duplex mode will never be automatically enabled 
by the driver, no matter which version is used or what the card's 
user-configurable EEPROM settings are. Full-duplex mode must always be 
_explicitly_ selected when the driver is loaded, using a transceiver type 
code of "8" or "12".

- There are important hardware limitations on the 3C509B's handling of 
full-duplex mode. If you are going to use the patched driver, it would be 
advisable to read the new documentation file first and understand these. 
This document is available at: http://www.sambadance.com/3c509/3c509_v120.html

- The new 3c509.c driver, the diff output, documentation, and a readme will 
be available for a time in:
http://www.sambadance.com/3c509/

- A version of the patched driver, dubbed v1.19, that is usable with 2.2.x 
series kernels is available as 
well:  http://www.sambadance.com/3c509/kernel-2.2.x/  This version was 
based on the latest 2.2.x driver, v1.16.

- The patched version of the driver should also work (but has not been 
tested) on the 3C589B, which is the PCMCIA form of the 3c509B.

- Thanks to Andrew Morton for good initial configuration advice, and of 
course to Donald Becker for authoring the original driver and base 
documentation.

-David Ruggiero
<jdr@farfalle.com>

-----------------------------------------------------------------------------------
diff -u /src/linux/drivers/net/3c509.orig  3c509.c
--- /src/linux/drivers/net/3c509.orig   Mon Jan  1 00:23:00 2002
+++ 3c509.c     Fri Mar  1 00:46:26 2002
@@ -45,12 +45,16 @@
                         - Reviewed against 1.18 from scyld.com
                 v1.18a 17Nov2001 Jeff Garzik <jgarzik@mandrakesoft.com>
                         - ethtool support
+               v1.20 15Sep2001 David Ruggiero <jdr@farfalle.com>
+                       - Implemented the card's (semi-undocumented, 
mostly-functional)
+                         full-duplex capabilities
  */

  #define DRV_NAME       "3c509"
  #define DRV_VERSION    "1.18a"
  #define DRV_RELDATE    "17Nov2001"

+
  /* A few values that may be tweaked. */

  /* Time in jiffies before concluding the transmitter is hung. */
@@ -137,6 +141,8 @@
  #define WN0_IRQ                0x08            /* Window 0: Set IRQ line 
in bits 12-15. */
  #define WN4_MEDIA      0x0A            /* Window 4: Various 
transcvr/media bits. */
  #define  MEDIA_TP      0x00C0          /* Enable link beat and jabber for 
10baseT. */
+#define WN4_NETDIAG    0x06            /* Window 4: Net diagnostic */
+#define  FD_ENABLE     0x8000          /* Enable full-duplex ("external 
loopback") */

  /*
   * Must be a power of two (we use a binary and in the
@@ -214,7 +220,6 @@
  MODULE_DEVICE_TABLE(isapnp, el3_isapnp_adapters);
  MODULE_LICENSE("GPL");

-
  static u16 el3_isapnp_phys_addr[8][3];
  #endif /* CONFIG_ISAPNP || CONFIG_ISAPNP_MODULE */
  static int nopnp;
@@ -486,12 +491,18 @@
         memcpy(dev->dev_addr, phys_addr, sizeof(phys_addr));
         dev->base_addr = ioaddr;
         dev->irq = irq;
-       dev->if_port = (dev->mem_start & 0x1f) ? dev->mem_start & 3 : if_port;
+
+       if (dev->mem_start & 0x05) { /* xcvr codes 1/3/4/12 */
+               dev->if_port = (dev->mem_start & 0x0f);
+       } else { /* xcvr codes 0/8 */
+               /* use eeprom value, but save user's full-duplex selection */
+               dev->if_port = (if_port | (dev->mem_start & 0x08) );
+       }

         {
                 const char *if_names[] = {"10baseT", "AUI", "undefined", 
"BNC"};
                 printk("%s: 3c5x9 at %#3.3lx, %s port, address ",
-                          dev->name, dev->base_addr, if_names[dev->if_port]);
+                dev->name, dev->base_addr, if_names[(dev->if_port & 0x03)]);
         }

         /* Read in the station address. */
@@ -567,7 +578,7 @@
  el3_open(struct net_device *dev)
  {
         int ioaddr = dev->base_addr;
-       int i;
+       int i, sw_info, net_diag;

         outw(TxReset, ioaddr + EL3_CMD);
         outw(RxReset, ioaddr + EL3_CMD);
@@ -578,7 +589,7 @@

         EL3WINDOW(0);
         if (el3_debug > 3)
-               printk("%s: Opening, IRQ %d      status@%x %4.4x.\n", 
dev->name,
+               printk("%s: Opening: IRQ %d; status@%x is %4.4x.\n", dev->name,
                            dev->irq, ioaddr + EL3_STATUS, inw(ioaddr + 
EL3_STATUS));

         /* Activate board: this is probably unnecessary. */
@@ -593,12 +604,44 @@
         for (i = 0; i < 6; i++)
                 outb(dev->dev_addr[i], ioaddr + i);

-       if (dev->if_port == 3)
+       if ((dev->if_port & 0x03) == 3) /* BNC interface */
                 /* Start the thinnet transceiver. We should really wait 
50ms...*/
                 outw(StartCoax, ioaddr + EL3_CMD);
-       else if (dev->if_port == 0) {
-               /* 10baseT interface, enabled link beat and jabber check. */
+
+       else if ((dev->if_port & 0x03) == 0) { /* 10baseT interface */
+               /* Combine secondary sw_info word (the adapter level) and 
primary
+                       sw_info word (duplex setting plus other useless 
bits) */
+               EL3WINDOW(0);
+               sw_info = (read_eeprom(ioaddr, 0x14) & 0x400f) |
+                                                (read_eeprom(ioaddr, 0x0d) 
& 0xBff0);
                 EL3WINDOW(4);
+               net_diag = inw(ioaddr + WN4_NETDIAG);
+               net_diag = (net_diag | FD_ENABLE); /* temporarily assume 
full-duplex will be se
t */
+
+               switch (dev->if_port & 0x0c) {
+                       case 12:
+                                /* force full-duplex mode if 3c5x9b */
+                               if (sw_info & 0x000f) {
+                                       printk("Forcing 3c5x9b full-duplex 
mode");
+                                       break;
+                               }
+                       case 8:
+                               /* set full-duplex mode based on eeprom 
config setting */
+                               if ((sw_info & 0x000f) && (sw_info & 0x8000)) {
+                                       printk("Setting 3c5x9b full-duplex 
mode (from EEPROM co
nfiguration bit)");
+                                       break;
+                               }
+                       default:
+                               /* xcvr=(0 || 4) OR user has an old 3c5x9 
non "B" model */
+                               printk("Setting 3c5x9/3c5x9B half-duplex 
mode");
+                               net_diag = (net_diag & ~FD_ENABLE); /* 
disable full duplex */
+               }
+
+               outw(net_diag, ioaddr + WN4_NETDIAG);
+               printk(" on %s. if_port: %d, sw_info: %4.4x\n", dev->name, 
dev->if_port, sw_inf
o);
+               if (el3_debug > 3) printk("3c5x9 net diag word is now: 
%4.4x.\n", net_diag);
+
+               /* Enable link beat and jabber check. */
                 outw(inw(ioaddr + WN4_MEDIA) | MEDIA_TP, ioaddr + WN4_MEDIA);
         }

@@ -1097,11 +1140,11 @@
  /* Parameters that may be passed into the module. */
  static int debug = -1;
  static int irq[] = {-1, -1, -1, -1, -1, -1, -1, -1};
-static int xcvr[] = {-1, -1, -1, -1, -1, -1, -1, -1};
+static int xcvr[] = {-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1};

  MODULE_PARM(debug,"i");
  MODULE_PARM(irq,"1-8i");
-MODULE_PARM(xcvr,"1-8i");
+MODULE_PARM(xcvr,"1-12i");
  MODULE_PARM(max_interrupt_work, "i");
  MODULE_PARM_DESC(debug, "EtherLink III debug level (0-6)");
  MODULE_PARM_DESC(irq, "EtherLink III IRQ number(s) (assigned)"); 

