Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129764AbRAXQfQ>; Wed, 24 Jan 2001 11:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129847AbRAXQfH>; Wed, 24 Jan 2001 11:35:07 -0500
Received: from chaos.analogic.com ([204.178.40.224]:1920 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129764AbRAXQe4>; Wed, 24 Jan 2001 11:34:56 -0500
Date: Wed, 24 Jan 2001 11:34:40 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: AMD Ethernet/Am79C973/Am79C975 (pcnet32/FAST), SEEPROM R/W patch
Message-ID: <Pine.LNX.3.95.1010124112831.2516A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Some are using the AMD Elan-SC520 development board for embedded systems.
This board, and probably the production model, contains an AMD Network
controller, Am79C973/Am79C975. The Linux 2.4.0 kernel contains a driver,
(AMD PCnet32 PCI supprt), pcnet32.c,  that will work with this chip.

However, when you make your own stuff, you need a way to write the
IEEE station address, and a bunch of configuration parameters into
the SEEPROM.

This patch provides both read and write routines for the serial eeprom.
They are addressed from user-space with a private ioctl(). The actual
data to be written, and the checksumming of that data, is done from
a user space application, information about which can be obtained from
the AMD web site. 

So that normal AND controller code is not bloated with stuff that will
never be used, the actual SEEPROM object code is in a separate file.

The original pcnet32.c file contains only code necessary to recover from a
defective (or empty) serial EEPROM.

If this gets into the main-line kernel I'll maintain it. Otherwise,
here is a chance for embedded systems programmers to snatch a copy.


--- linux-2.4.0/drivers/net/Config.in.orig	Fri Jan 12 08:41:33 2001
+++ linux-2.4.0/drivers/net/Config.in	Fri Jan 12 08:45:12 2001
@@ -128,6 +128,7 @@
    bool '  EISA, VLB, PCI and on board controllers' CONFIG_NET_PCI
    if [ "$CONFIG_NET_PCI" = "y" ]; then
       dep_tristate '    AMD PCnet32 PCI support' CONFIG_PCNET32 $CONFIG_PCI
+      dep_tristate '    AMD PCnet32 with SEEPROM support' CONFIG_PCNET32_SEEPROM $CONFIG_PCI
       dep_tristate '    Adaptec Starfire support (EXPERIMENTAL)' CONFIG_ADAPTEC_STARFIRE $CONFIG_PCI $CONFIG_EXPERIMENTAL
       if [ "$CONFIG_ISA" = "y" -o "$CONFIG_EISA" = "y" ]; then
 	 dep_tristate '    Ansel Communications EISA 3200 support (EXPERIMENTAL)' CONFIG_AC3200 $CONFIG_EXPERIMENTAL
--- linux-2.4.0/drivers/net/Makefile.orig	Fri Jan 12 08:25:24 2001
+++ linux-2.4.0/drivers/net/Makefile	Fri Jan 12 13:40:47 2001
@@ -62,6 +62,7 @@
 obj-$(CONFIG_VORTEX) += 3c59x.o
 obj-$(CONFIG_NE2K_PCI) += ne2k-pci.o 8390.o
 obj-$(CONFIG_PCNET32) += pcnet32.o
+obj-$(CONFIG_PCNET32_SEEPROM) += pcnet32se.o
 obj-$(CONFIG_EEPRO100) += eepro100.o
 obj-$(CONFIG_TLAN) += tlan.o
 obj-$(CONFIG_EPIC100) += epic100.o
@@ -215,4 +216,11 @@
 
 rcpci.o: rcpci45.o rclanmtl.o
 	$(LD) -r -o rcpci.o rcpci45.o rclanmtl.o
+
+pcnet32sep.o:	pcnet32.c
+	$(CC) $(CFLAGS) -DSEEPROM -c -o pcnet32sep.o pcnet32.c
+
+pcnet32se.o:	pcnet32sep.o pcnet32_seeprom.o
+	$(LD) -r -o pcnet32se.o pcnet32sep.o pcnet32_seeprom.o
+
 
--- linux-2.4.0/drivers/net/pcnet32.c.orig	Wed Jan 10 15:11:39 2001
+++ linux-2.4.0/drivers/net/pcnet32.c	Wed Jan 24 10:16:13 2001
@@ -1,5 +1,6 @@
-/* pcnet32.c: An AMD PCnet32 ethernet driver for linux. */
 /*
+ *      pcnet32.c: An AMD PCnet32 ethernet driver for linux.
+ *
  *	Copyright 1996-1999 Thomas Bogendoerfer
  * 
  *	Derived from the lance driver written 1993,1994,1995 by Donald Becker.
@@ -12,8 +13,11 @@
  *
  *	This driver is for PCnet32 and PCnetPCI based ethercards
  */
-
+#ifdef SEEPROM
+static const char version[]="pcnet32.c:V2.0 18.1.2001 rjohnson@analogic.com\n";
+#else
 static const char *version = "pcnet32.c:v1.25kf 26.9.1999 tsbogend@alpha.franken.de\n";
+#endif
 
 #include <linux/module.h>
 
@@ -36,6 +40,7 @@
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
 #include <linux/spinlock.h>
+#include "pcnet32.h"
 
 static unsigned int pcnet32_portlist[] __initdata = {0x300, 0x320, 0x340, 0x360, 0};
 
@@ -57,6 +62,9 @@
 #define PORT_100      0x40
 #define PORT_FD	      0x80
 
+#define NOSEEPROM     (PORT_100|PORT_ASEL|PORT_FD|PORT_MII)
+static const char force[]={0x00, 0xde, 0xad, 0xfa, 0xce, 0x00}; 
+
 #define PCNET32_DMA_MASK 0xffffffff
 
 /*
@@ -162,8 +170,14 @@
  * v1.25kf Added No Interrupt on successful Tx for some Tx's <kaf@fc.hp.com>
  * v1.26   Converted to pci_alloc_consistent, Jamey Hicks / George France
  *                                           <jamey@crl.dec.com>
+ * v2.00   Conditional compilation adds SEEPROM read and write routines.
+ *         Recovery from a missing or bad SEEPROM.
+ *         Richard B. Johnson rjohnson@analogic.com
  */
 
+#ifdef SEEPROM
+#define HAVE_PRIVATE_IOCTL
+#endif
 
 /*
  * Set the number of Tx and Rx buffers, using Log_2(# buffers).
@@ -239,17 +253,6 @@
     u32 tx_ring;
 };
 
-/* PCnet32 access functions */
-struct pcnet32_access {
-    u16 (*read_csr)(unsigned long, int);
-    void (*write_csr)(unsigned long, int, u16);
-    u16 (*read_bcr)(unsigned long, int);
-    void (*write_bcr)(unsigned long, int, u16);
-    u16 (*read_rap)(unsigned long);
-    void (*write_rap)(unsigned long, u16);
-    void (*reset)(unsigned long);
-};
-
 /*
  * The first three fields of pcnet32_private are read by the ethernet device 
  * so we allocate the structure should be allocated by pci_alloc_consistent().
@@ -268,7 +271,6 @@
     dma_addr_t tx_dma_addr[TX_RING_SIZE];
     dma_addr_t rx_dma_addr[RX_RING_SIZE];
     struct pcnet32_access a;
-    spinlock_t lock;					/* Guard lock */
     unsigned int cur_rx, cur_tx;		/* The next free ring entry */
     unsigned int dirty_rx, dirty_tx;	/* The ring entries to be free()ed. */
     struct net_device_stats stats;
@@ -284,6 +286,7 @@
     struct net_device *next;
 };
 
+spinlock_t  pcnet32_lock;				/* Guard lock */
 static int  pcnet32_probe_vlbus(int cards_found);
 static int  pcnet32_probe_pci(struct pci_dev *, const struct pci_device_id *);
 static int  pcnet32_probe1(unsigned long, unsigned char, int, int, struct pci_dev *);
@@ -299,6 +302,7 @@
 #ifdef HAVE_PRIVATE_IOCTL
 static int  pcnet32_mii_ioctl(struct net_device *, struct ifreq *, int);
 #endif
+ 
 
 enum pci_flags_bit {
     PCI_USES_IO=1, PCI_USES_MEM=2, PCI_USES_MASTER=4,
@@ -629,6 +633,60 @@
        The first six bytes are the station address. */
     for (i = 0; i < 6; i++)
 	printk(" %2.2x", dev->dev_addr[i] = inb(ioaddr + i));
+/*
+ *  If there is no serial EEPROM, we have a problem. A lot of registers
+ *  needed to have been loaded before the PCI PnP occurred. Also, the
+ *  card doesn't have an IEEE station address.
+ *  So, we wing it. We use "00:DE:AD:FA:CE:00" as the station address
+ *  and set some essential registers. This should get an embedded machine
+ *  up enough so you can talk to it over a LAN.
+ */
+    if( ((dev->dev_addr[1] == 0x00) && (dev->dev_addr[2] == 0x00)) ||
+        ((dev->dev_addr[0] == 0xff) && (dev->dev_addr[1] == 0xff)) )
+    {
+        media = NOSEEPROM;
+	(*a->write_bcr)(ioaddr, 2, 0x2002);
+	(*a->write_bcr)(ioaddr, 4, 0x00c0);
+	(*a->write_bcr)(ioaddr, 5, 0x0084);
+	(*a->write_bcr)(ioaddr, 6, 0x1080);
+	(*a->write_bcr)(ioaddr, 7, 0x0090);
+	(*a->write_bcr)(ioaddr, 9, media);
+	(*a->write_bcr)(ioaddr, 18,0x9261);
+	(*a->write_bcr)(ioaddr, 22,0x1818);
+	(*a->write_bcr)(ioaddr, 23,0x1022);
+	(*a->write_bcr)(ioaddr, 24,0x2000);
+	(*a->write_bcr)(ioaddr, 25,0x0017);
+	(*a->write_bcr)(ioaddr, 26,0x0008);
+	(*a->write_bcr)(ioaddr, 27,0x0000);
+	(*a->write_bcr)(ioaddr, 32,0x0020);
+	(*a->write_bcr)(ioaddr, 33,0x03c0);
+	(*a->write_bcr)(ioaddr, 35,0x1022);
+	(*a->write_bcr)(ioaddr, 36,0xfe01);
+	(*a->write_bcr)(ioaddr, 37,0x0114);
+	(*a->write_bcr)(ioaddr, 38,0x010f);
+	(*a->write_bcr)(ioaddr, 39,0x010f);
+	(*a->write_bcr)(ioaddr, 40,0x010f);
+	(*a->write_bcr)(ioaddr, 41,0x0114);
+	(*a->write_bcr)(ioaddr, 42,0x010f);
+	(*a->write_bcr)(ioaddr, 43,0x010f);
+	(*a->write_bcr)(ioaddr, 44,0x010f);
+	(*a->write_bcr)(ioaddr, 49,media);
+        memcpy(dev->dev_addr, force, sizeof(force));
+	(*a->write_bcr)(ioaddr, 18, ((*a->read_bcr)(ioaddr, 18) & ~0x0800));
+	(*a->write_csr)(ioaddr, 80, ((*a->read_csr)(ioaddr, 80) & ~0x0C00));
+        printk("\nNo SEEPROM detected, using :\n");
+        printk("\tStation address : %02x:%02x:%02x:%02x:%02x:%02x\n",
+               dev->dev_addr[0], dev->dev_addr[1], dev->dev_addr[2],
+               dev->dev_addr[3], dev->dev_addr[4], dev->dev_addr[5]);
+        printk("\tMedia type : %03x\n", media);
+	i = (*a->read_bcr)(ioaddr, 18);  /* Check Burst/Bus control */
+	printk(" BCR18(%x):",i&0xffff);
+	if (i & (1<<5)) printk("BurstWrEn ");
+	if (i & (1<<6)) printk("BurstRdEn ");
+	if (i & (1<<7)) printk("DWordIO ");
+	if (i & (1<<11)) printk("NoUFlow ");
+        printk("\n");
+    }
 
     if (((chip_version + 1) & 0xfffe) == 0x2624) { /* Version 0x2623 or 0x2624 */
 	i = a->read_csr(ioaddr, 80) & 0x0C00;  /* Check tx_start_pt */
@@ -665,7 +723,7 @@
     lp->pci_dev = pdev;
     printk("\n" KERN_INFO "pcnet32: pcnet32_private lp=%p lp_dma_addr=%#08x", lp, lp_dma_addr);
 
-    spin_lock_init(&lp->lock);
+    spin_lock_init(&pcnet32_lock);
     
     dev->priv = lp;
     lp->name = chipname;
@@ -1010,7 +1068,7 @@
 	       dev->name, lp->a.read_csr (ioaddr, 0));
     }
 
-    spin_lock_irqsave(&lp->lock, flags);
+    spin_lock_irqsave(&pcnet32_lock, flags);
 
     /* Default status -- will not enable Successful-TxDone
      * interrupt when that option is available to us.
@@ -1059,7 +1117,7 @@
 	lp->tx_full = 1;
 	netif_stop_queue(dev);
     }
-    spin_unlock_irqrestore(&lp->lock, flags);
+    spin_unlock_irqrestore(&pcnet32_lock, flags);
     return 0;
 }
 
@@ -1082,7 +1140,7 @@
     ioaddr = dev->base_addr;
     lp = (struct pcnet32_private *)dev->priv;
     
-    spin_lock(&lp->lock);
+    spin_lock(&pcnet32_lock);
     
     rap = lp->a.read_rap(ioaddr);
     while ((csr0 = lp->a.read_csr (ioaddr, 0)) & 0x8600 && --boguscnt >= 0) {
@@ -1207,7 +1265,7 @@
 	printk(KERN_DEBUG "%s: exiting interrupt, csr0=%#4.4x.\n",
 	       dev->name, lp->a.read_csr (ioaddr, 0));
 
-    spin_unlock(&lp->lock);
+    spin_unlock(&pcnet32_lock);
 }
 
 static int
@@ -1362,11 +1420,11 @@
     u16 saved_addr;
     unsigned long flags;
 
-    spin_lock_irqsave(&lp->lock, flags);
+    spin_lock_irqsave(&pcnet32_lock, flags);
     saved_addr = lp->a.read_rap(ioaddr);
     lp->stats.rx_missed_errors = lp->a.read_csr (ioaddr, 112);
     lp->a.write_rap(ioaddr, saved_addr);
-    spin_unlock_irqrestore(&lp->lock, flags);
+    spin_unlock_irqrestore(&pcnet32_lock, flags);
 
     return &lp->stats;
 }
@@ -1468,6 +1526,14 @@
 	    lp->a.write_bcr (ioaddr, 34, data[2]);
 	    lp->a.write_bcr (ioaddr, 33, phyaddr);
 	    return 0;
+#ifdef SEEPROM
+        case CHEK_SEEPROM:
+            return(check_seeprom(&lp->a, ioaddr, (char *) rq->ifr_data));
+        case READ_SEEPROM:
+            return(read_seeprom(&lp->a,  ioaddr, (char *) rq->ifr_data));
+        case WRITE_SEEPROM:
+            return(write_seeprom(&lp->a, ioaddr, (const char *) rq->ifr_data));
+#endif
 	default:
 	    return -EOPNOTSUPP;
 	}
--- linux-2.4.0/drivers/net/pcnet32.h.orig	Tue Jan 23 13:37:24 2001
+++ linux-2.4.0/drivers/net/pcnet32.h	Mon Jan 22 11:05:16 2001
@@ -0,0 +1,33 @@
+/*
+ *  File: pcnet32.h         Created 12-12-2000   Richard. B. Johnson
+ *
+ *  Contains elements that need to be shared between two or
+ *  more files.
+ */
+#ifndef _PCNET32_H_
+#define _PCNET32_H_
+#ifdef __KERNEL__
+struct pcnet32_access {
+    u16 (*read_csr)(unsigned long, int);
+    void (*write_csr)(unsigned long, int, u16);
+    u16 (*read_bcr)(unsigned long, int);
+    void (*write_bcr)(unsigned long, int, u16);
+    u16 (*read_rap)(unsigned long);
+    void (*write_rap)(unsigned long, u16);
+    void (*reset)(unsigned long);
+    };
+
+extern int check_seeprom(struct pcnet32_access *, unsigned long, char *);
+extern int write_seeprom(struct pcnet32_access *, unsigned long, const char *);
+extern int read_seeprom(struct pcnet32_access *, unsigned long, char *);
+#endif   /* __KERNEL__ */
+#define SLEN 0x80                      /* Max length of SEEPROM buffer */
+/*
+ *   Interface to the private device functions. User API sees this only.
+ */
+#define CHEK_SEEPROM   SIOCDEVPRIVATE + 0x07
+#define READ_SEEPROM   SIOCDEVPRIVATE + 0x08
+#define WRITE_SEEPROM  SIOCDEVPRIVATE + 0x09
+
+#endif
+
--- linux-2.4.0/drivers/net/pcnet32_seeprom.c.orig	Tue Jan 23 13:29:41 2001
+++ linux-2.4.0/drivers/net/pcnet32_seeprom.c	Wed Jan 24 11:00:05 2001
@@ -0,0 +1,315 @@
+/*
+ *   File:  pcnet32_seeprom.c    Created 18-JAN-2001  Richard B. Johnson
+ *                               rjohnson@analogic.com
+ *
+ *   This reads and writes the SEEPROM contents in the AMD 79c973
+ *   controller. It is accessed through a private ioctl() and the
+ *   input/output buffers are 'raw'. They have to be accessed with
+ *   copy_to/from_user.
+ *
+ *   File pcnet32sep.o is generated from pcnet32.c when SEEPROM is defined.
+ *   This is linked with pcnet32sep.o so that symbols need not be exported. 
+ *
+ *   Note that if you write new SEEPROM contents, they must be checksummed
+ *   in the two places specified in the AMD data manual (Page B-21, Am79C973/
+ *   Am79C795) or else the SEEPROM contents won't be loaded upon reset or
+ *   power up. The result is a very dumb chip that won't work.
+ * 
+ *   This software may be used and distributed according to the terms
+ *   of the GNU Public License, incorporated herein by reference.
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <asm/uaccess.h>
+#include <asm/io.h>
+#include <linux/netdevice.h>
+#include <linux/spinlock.h>
+#include "pcnet32.h"
+#define UL unsigned long
+#define US unsigned short
+#define UC unsigned char
+#define SPCNET struct pcnet32_access
+
+extern spinlock_t pcnet32_lock;
+static const char exists[]="SEEPROM driver exists";
+static unsigned short eeprom_read(SPCNET *p32, UL ioaddr, int location);
+static int eeprom_write(SPCNET *p32, UL ioaddr, int location, US word);
+static int eeprom_lock(SPCNET *p32, UL ioaddr);
+static int eeprom_unlock(SPCNET *p32, UL ioaddr);
+
+/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
+/*
+ *  Test for existence of the SEEPROM driver.
+ */
+int check_seeprom(SPCNET *pc32, UL ioaddr, char *data)
+{
+    int i;
+    UL flags;
+    US *buf;
+    if((buf = (US *)vmalloc(SLEN * sizeof(char))) == NULL)
+        return -ENOMEM;
+    spin_lock_irqsave(&pcnet32_lock, flags);
+    i = (*pc32->read_bcr)(ioaddr, 0x13);
+    spin_unlock_irqrestore(&pcnet32_lock, flags);
+    i = sprintf((char *)buf, "%s %08x\n", exists, i);
+    copy_to_user(data, buf, ++i);
+    vfree(buf);
+    return 0;
+}
+/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
+/*
+ *  Write the entire buffer of characters to the SEEPROM. Since
+ *  This must be checksummed, the entire thing is written rather
+ *  than just pieces.
+ */
+int write_seeprom(SPCNET *pc32, UL ioaddr, const char *data)
+{
+    size_t i;
+    US *buf;
+    US *sp;
+    if((buf = (US *)vmalloc(SLEN * sizeof(char))) == NULL)
+        return -ENOMEM;
+    copy_from_user(buf, data, SLEN);
+    (void) eeprom_unlock(pc32, ioaddr);
+    sp = buf;
+    for(i=0; i< (SLEN / sizeof(US)); i++)
+        (void) eeprom_write(pc32, ioaddr, i , *sp++);
+    (void) eeprom_lock(pc32, ioaddr);
+    vfree(buf);
+    return 0;
+}
+/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
+/*
+ *  Read the entire contents of the SEEPROM. Since the whole thing
+ *  must be checksummed, we don't bother to read partial contents.
+ */
+int read_seeprom(SPCNET *pc32, UL ioaddr, char *data)
+{
+    size_t i;
+    US *sp;
+    US *buf;
+
+    if((buf = (US *) vmalloc(SLEN * sizeof(char))) == NULL)
+        return -ENOMEM;
+    sp = buf;
+    for(i=0; i< (SLEN/sizeof(US)); i++)
+        *sp++ = eeprom_read(pc32, ioaddr, i);
+    copy_to_user(data, buf, SLEN);
+    vfree(buf);
+    return 0;
+}
+/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
+/*
+ *  This is the code necessary to bit-fiddle with the AMD's SEEPROM.
+ *  The SEEPROM is a 3-wire serial device, variously known as the
+ *  Atmel AT93C46, AT93C56, AT93C57, and AT93C66.
+ *
+ *  To access SEEPROM, we need to disable the AMD Controller Chip.
+ *  Even though it's subsequently enabled, any Ethernet traffic will
+ *  suffer because the chip ends up timing out and is restarted with
+ *  the software watchdog.
+ */ 
+#define AMD_BCR19	0x0013       /* Base control offset for EEPROM */
+#define AMD_EEN         0x0010       /* EEPROM enable                  */
+#define AMD_RES         0x0008       /* Reserved, written zero         */
+#define AMD_ECS         0x0004       /* EEPROM Chip select             */
+#define AMD_ESK         0x0002       /* EEPROM serial clock            */
+#define AMD_DAT         0x0001       /* Data bit for RX or TX          */
+#define AMD_STOP        0x0004       /* Stop bit is CSR0               */
+#define AMD_STRT        0x0002       /* Start bit in CSR0              */
+#define AMD_CSR0        0x0000       /* Command/status register 0      */
+#define EE_READC        0x0180       /* Note! Contains the start bit.  */
+#define EE_WRITEC       0x0140       /* Note! Contains the start bit.  */
+#define EE_WRITENAB     0x0130       /* Note! Contains the start bit.  */ 
+#define EE_WRITEDIS     0x0100       /* Note! Contains the start bit.  */ 
+#define WRITE_TIMELIM   0x1000       /* 0x450 is nominal completion    */
+
+#define DELAY udelay(5) 
+#define WRITE_EEPROM(what) (*p32->write_bcr)(ioaddr, AMD_BCR19, (what))
+#define READ_EEPROM        (*p32->read_bcr)(ioaddr,  AMD_BCR19)
+#define READ_CSR           (*p32->read_csr)(ioaddr,  AMD_CSR0)
+#define WRITE_CSR(what)    (*p32->write_csr)(ioaddr, AMD_CSR0, (what))
+/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
+/*
+ *  This first saves the current chip status. Then it turns OFF the
+ *  Ethernet chip. It then reads the SEEPROM, one 16-bit word at
+ *  a time. Then it turns the Ethernet chip back on from the preserved
+ *  status.
+ */
+
+static US eeprom_read(SPCNET *p32, UL ioaddr, int loc)
+{
+    int i; 
+    UL flags;
+    US dataval;
+    US status;
+    US read_cmd = (US) loc | EE_READC;
+    spin_lock_irqsave(&pcnet32_lock, flags);
+
+    status = READ_CSR;                              /* Save current modes */
+    WRITE_CSR(AMD_STOP);                            /* Stop the chip      */
+/*
+ *   Send the read command bits out, one bit at a time.
+ */
+    i = 10;
+    do {
+        dataval  = (read_cmd & (1 << i)) ? 1 : 0;
+        dataval |= (AMD_EEN|AMD_ECS);
+        WRITE_EEPROM(dataval);
+        DELAY;
+        WRITE_EEPROM(dataval|AMD_ESK);
+	DELAY;
+    } while (i--);
+/*
+ *  Read the 16-bit result, 1 bit at a time. Note: the leading zero-
+ *  bit, the extra one specified as a feature, is quietly ignored
+ *  by this code. In other words, we didn't read it, we just toggled
+ *  the clock to get the next one. Remember that chip BUG if you
+ *  modify this routine.
+ */
+    dataval = 0;
+    for (i = 0; i < 0x10; i++)
+    {
+        WRITE_EEPROM(AMD_EEN|AMD_ECS);          /* Chip select, clock low  */
+        DELAY;
+        WRITE_EEPROM(AMD_EEN|AMD_ESK|AMD_ECS);  /* Chip select, clock high */
+        DELAY;
+        dataval <<= 1;
+        dataval |= (READ_EEPROM & AMD_DAT);      /* AMD_DAT is bit zero     */
+    }
+    WRITE_EEPROM(0);                             /* Turn OFF EPROM          */
+    WRITE_CSR(status|AMD_STRT);                  /* Restart the chip        */
+    spin_unlock_irqrestore(&pcnet32_lock, flags);
+    return dataval;
+}
+/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
+/*
+ *   This enables the EEPROM for writes. This first gets and saves the
+ *   controller status. Then it stops the chip. After the unlock sequence,
+ *   it restores the controller status and starts the chip.
+ */
+static int eeprom_unlock(SPCNET *p32, UL ioaddr)
+{
+    int i;
+    UL flags;
+    US dataval;
+    US status;
+    US unlock_cmd = EE_WRITENAB;
+    spin_lock_irqsave(&pcnet32_lock, flags);
+    status = READ_CSR;                              /* Save current modes */
+    WRITE_CSR(AMD_STOP);                            /* Stop the chip      */
+    i = 10;
+    do {
+        dataval  = (unlock_cmd & (1 << i)) ? 1 : 0;
+        dataval |= (AMD_EEN|AMD_ECS);
+        WRITE_EEPROM(dataval);
+        DELAY;
+        WRITE_EEPROM(dataval|AMD_ESK);
+	DELAY;
+    } while (i--);
+    WRITE_EEPROM(0);                                /* Turn OFF EEPROM     */
+    WRITE_CSR(status|AMD_STRT);                     /* Restart the chip    */
+    spin_unlock_irqrestore(&pcnet32_lock, flags);
+    return 0;
+}
+/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
+/*
+ *   This disables the EEPROM for writes. This first gets and saves the
+ *   controller status. Then it stops the chip. After the unlock sequence,
+ *   it restores the controller status and starts the chip.
+ */
+static int eeprom_lock(SPCNET *p32, UL ioaddr)
+{
+    int i;
+    UL flags;
+    US dataval;
+    US status;
+    US lock_cmd = EE_WRITEDIS;
+    spin_lock_irqsave(&pcnet32_lock, flags);
+    status = READ_CSR;                              /* Save current modes */
+    WRITE_CSR(AMD_STOP);                            /* Stop the chip      */
+    i = 10;
+    do {
+        dataval  = (lock_cmd & (1 << i)) ? 1 : 0;
+        dataval |= (AMD_EEN|AMD_ECS);
+        WRITE_EEPROM(dataval);
+        DELAY;
+        WRITE_EEPROM(dataval|AMD_ESK);
+	DELAY;
+    } while (i--);
+    WRITE_EEPROM(0);                                /* Turn OFF EEPROM     */
+    WRITE_CSR(status|AMD_STRT);                     /* Restart the chip    */
+    spin_unlock_irqrestore(&pcnet32_lock, flags);
+    return 0;
+}
+/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
+/*
+ *  Just like the read routine, we get the current Ethernet chip
+ *  status, turn off the chip, then write the SEEPROM, then turn
+ *  the chip back on.  
+ */
+
+static int eeprom_write(SPCNET *p32, UL ioaddr, int loc, US data)
+{
+    int i; 
+    UL flags;
+    US dataval;
+    US status;
+    US read_cmd = (US) loc | EE_WRITEC;
+    spin_lock_irqsave(&pcnet32_lock, flags);
+    status = READ_CSR;                              /* Save current modes */
+    WRITE_CSR(AMD_STOP);                            /* Stop the chip      */
+/*
+ *   Send the write command bits out, one bit at a time.
+ */
+    i = 10;
+    do {
+        dataval  = (read_cmd & (1 << i)) ? 1 : 0;
+        dataval |= (AMD_EEN|AMD_ECS);
+        WRITE_EEPROM(dataval);
+        DELAY;
+        WRITE_EEPROM(dataval|AMD_ESK);
+	DELAY;
+    } while (i--);
+/*
+ *   Continue with the data-bits, backwards, just like above.
+ */
+    i = 0x0f;
+    do {
+        dataval  = (data & (1 << i)) ? 1 : 0;
+        dataval |= (AMD_EEN|AMD_ECS);
+        WRITE_EEPROM(dataval);          
+        DELAY;
+        WRITE_EEPROM(dataval|AMD_ESK);
+        DELAY;
+    } while (i--);
+/*
+ *  Wait for the programming to complete. If it doesn't seem to
+ *  complete, just give up after logging the problem.
+ */
+    WRITE_EEPROM(AMD_EEN);              /* Lower chip-select */
+    DELAY;
+    WRITE_EEPROM(AMD_EEN|AMD_ECS);      /* Raise chip-select */
+    if(!(READ_EEPROM & AMD_DAT))
+    {
+        for(i=0; i< WRITE_TIMELIM; i++)
+        {
+            DELAY;
+            if(READ_EEPROM & AMD_DAT)
+                break;
+        }
+        if(i == WRITE_TIMELIM)
+            printk("SEEPROM failed to signal write completion\n");
+    }
+    WRITE_EEPROM(0);                      /* Turn OFF EPROM    */
+    WRITE_CSR(status|AMD_STRT);           /* Restart the chip  */
+    spin_unlock_irqrestore(&pcnet32_lock, flags);
+    return 0;
+}
+/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
+/*-=-=-=-=-=-=-=-=-=-=-=-=  END  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
+/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
+


Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
