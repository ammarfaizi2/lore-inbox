Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266619AbUIANjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266619AbUIANjj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 09:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266613AbUIANjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 09:39:39 -0400
Received: from mail.renesas.com ([202.234.163.13]:640 "EHLO
	mail03.idc.renesas.com") by vger.kernel.org with ESMTP
	id S266730AbUIANZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 09:25:19 -0400
Date: Wed, 01 Sep 2004 22:25:00 +0900 (JST)
Message-Id: <20040901.222500.596521289.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] [m32r] Upgrade to 2.6.8.1 kernel
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

Here is a patch for 2.6.8.1 kernel of Renesas M32R processor.
Please apply.

       * Upgrade from 2.6.7 to 2.6.8.1 kernel.

---
 arch/m32r/Makefile                        |    2 
 arch/m32r/defconfig                       |   27 +++-
 arch/m32r/drivers/smc91111.c              |  166 ++++++++++++++----------------
 arch/m32r/kernel/init_task.c              |    1 
 arch/m32r/kernel/irq.c                    |    5 
 arch/m32r/kernel/module.c                 |    2 
 arch/m32r/kernel/setup.c                  |   26 +++-
 arch/m32r/kernel/smp.c                    |   93 +++++++++-------
 arch/m32r/kernel/smpboot.c                |   25 ++--
 arch/m32r/kernel/sys_m32r.c               |    2 
 arch/m32r/kernel/time.c                   |   30 ++---
 arch/m32r/kernel/traps.c                  |    4 
 arch/m32r/lib/delay.c                     |   10 +
 arch/m32r/m32700ut/defconfig.m32700ut.smp |   25 +++-
 arch/m32r/m32700ut/defconfig.m32700ut.up  |   28 +++--
 arch/m32r/mappi/defconfig.nommu           |   23 ++--
 arch/m32r/mappi/defconfig.smp             |   38 +++++-
 arch/m32r/mappi/defconfig.up              |   38 +++++-
 arch/m32r/mm/fault.c                      |   63 +++++++----
 arch/m32r/mm/init.c                       |   12 +-
 arch/m32r/oaks32r/defconfig.nommu         |   21 ++-
 arch/m32r/opsput/defconfig.opsput         |   22 ++-
 include/asm-m32r/bitops.h                 |   26 ++--
 include/asm-m32r/checksum.h               |    4 
 include/asm-m32r/cpumask.h                |    7 -
 include/asm-m32r/delay.h                  |    8 +
 include/asm-m32r/fcntl.h                  |    1 
 include/asm-m32r/init.h                   |    1 
 include/asm-m32r/resource.h               |    8 +
 include/asm-m32r/setup.h                  |    2 
 include/asm-m32r/signal.h                 |   16 +-
 include/asm-m32r/smp.h                    |   47 +++++++-
 include/asm-m32r/uaccess.h                |    4 
 include/asm-m32r/unistd.h                 |   20 +--
 34 files changed, 508 insertions(+), 299 deletions(-)
---


diff -ruN linux-2.6.7_20040830/arch/m32r/Makefile linux-2.6.8.1/arch/m32r/Makefile
--- linux-2.6.7_20040830/arch/m32r/Makefile	2004-08-23 20:53:31.000000000 +0900
+++ linux-2.6.8.1/arch/m32r/Makefile	2004-08-30 10:23:53.000000000 +0900
@@ -25,6 +25,8 @@
 CFLAGS += $(cflags-y)
 AFLAGS += $(aflags-y)
 
+CHECK	:= $(CHECK) -D__m32r__=1
+
 head-y	:= arch/m32r/kernel/head.o arch/m32r/kernel/init_task.o
 
 LIBGCC	:= $(shell $(CC) $(CFLAGS) -print-libgcc-file-name)
diff -ruN linux-2.6.7_20040830/arch/m32r/defconfig linux-2.6.8.1/arch/m32r/defconfig
--- linux-2.6.7_20040830/arch/m32r/defconfig	2004-07-15 13:43:14.000000000 +0900
+++ linux-2.6.8.1/arch/m32r/defconfig	2004-08-30 10:23:53.000000000 +0900
@@ -10,7 +10,6 @@
 #
 CONFIG_EXPERIMENTAL=y
 CONFIG_CLEAN_COMPILE=y
-CONFIG_STANDALONE=y
 CONFIG_BROKEN_ON_SMP=y
 
 #
@@ -20,6 +19,7 @@
 CONFIG_SYSVIPC=y
 # CONFIG_POSIX_MQUEUE is not set
 CONFIG_BSD_PROCESS_ACCT=y
+# CONFIG_BSD_PROCESS_ACCT_V3 is not set
 CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
 CONFIG_LOG_BUF_SHIFT=14
@@ -52,6 +52,7 @@
 # CONFIG_PLAT_MAPPI is not set
 # CONFIG_PLAT_USRV is not set
 CONFIG_PLAT_M32700UT=y
+# CONFIG_PLAT_OPSPUT is not set
 # CONFIG_PLAT_OAKS32R is not set
 # CONFIG_PLAT_MAPPI2 is not set
 CONFIG_CHIP_M32700=y
@@ -83,6 +84,7 @@
 CONFIG_M32R_CFC=y
 CONFIG_M32700UT_CFC=y
 CONFIG_CFC_NUM=1
+# CONFIG_MTD_M32R is not set
 CONFIG_M32R_SMC91111=y
 CONFIG_M32700UT_DS1302=y
 
@@ -121,6 +123,8 @@
 #
 # Generic Driver Options
 #
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_FW_LOADER is not set
 
 #
@@ -157,6 +161,7 @@
 #
 # Please see Documentation/ide.txt for help/info on IDE drives
 #
+# CONFIG_BLK_DEV_IDE_SATA is not set
 CONFIG_BLK_DEV_IDEDISK=y
 # CONFIG_IDEDISK_MULTI_MODE is not set
 CONFIG_BLK_DEV_IDECS=y
@@ -234,7 +239,6 @@
 #
 # IEEE 1394 (FireWire) support
 #
-# CONFIG_IEEE1394 is not set
 
 #
 # I2O device support
@@ -286,13 +290,13 @@
 # CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-# CONFIG_NET_FASTROUTE is not set
 # CONFIG_NET_HW_FLOWCONTROL is not set
 
 #
 # QoS and/or fair queueing
 #
 # CONFIG_NET_SCHED is not set
+# CONFIG_NET_CLS_ROUTE is not set
 
 #
 # Network testing
@@ -335,7 +339,7 @@
 # CONFIG_GAMEPORT is not set
 CONFIG_SOUND_GAMEPORT=y
 CONFIG_SERIO=y
-CONFIG_SERIO_I8042=y
+# CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_CT82C710 is not set
 
@@ -385,12 +389,10 @@
 # CONFIG_GEN_RTC is not set
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
-# CONFIG_APPLICOM is not set
 
 #
 # Ftape, the floppy tape device driver
 #
-# CONFIG_FTAPE is not set
 # CONFIG_AGP is not set
 # CONFIG_DRM is not set
 
@@ -406,6 +408,11 @@
 # CONFIG_I2C is not set
 
 #
+# Dallas's 1-wire bus
+#
+# CONFIG_W1 is not set
+
+#
 # Misc devices
 #
 
@@ -422,11 +429,12 @@
 # Video Adapters
 #
 # CONFIG_VIDEO_CPIA is not set
+CONFIG_M32R_AR=y
+CONFIG_M32R_AR_VGA=y
 
 #
 # Radio Adapters
 #
-# CONFIG_RADIO_MAXIRADIO is not set
 # CONFIG_RADIO_MAESTRO is not set
 
 #
@@ -484,6 +492,7 @@
 CONFIG_JOLIET=y
 # CONFIG_ZISOFS is not set
 CONFIG_UDF_FS=m
+CONFIG_UDF_NLS=y
 
 #
 # DOS/FAT/NT Filesystems
@@ -491,6 +500,8 @@
 CONFIG_FAT_FS=m
 CONFIG_MSDOS_FS=m
 CONFIG_VFAT_FS=m
+CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
 # CONFIG_NTFS_FS is not set
 
 #
@@ -578,6 +589,7 @@
 # CONFIG_NLS_ISO8859_8 is not set
 # CONFIG_NLS_CODEPAGE_1250 is not set
 # CONFIG_NLS_CODEPAGE_1251 is not set
+# CONFIG_NLS_ASCII is not set
 # CONFIG_NLS_ISO8859_1 is not set
 # CONFIG_NLS_ISO8859_2 is not set
 # CONFIG_NLS_ISO8859_3 is not set
@@ -618,5 +630,6 @@
 #
 # Library routines
 #
+# CONFIG_CRC_CCITT is not set
 CONFIG_CRC32=y
 # CONFIG_LIBCRC32C is not set
diff -ruN linux-2.6.7_20040830/arch/m32r/drivers/smc91111.c linux-2.6.8.1/arch/m32r/drivers/smc91111.c
--- linux-2.6.7_20040830/arch/m32r/drivers/smc91111.c	2004-07-27 15:54:20.000000000 +0900
+++ linux-2.6.8.1/arch/m32r/drivers/smc91111.c	2004-08-30 10:23:53.000000000 +0900
@@ -72,7 +72,7 @@
 
 
 static const char version[] =
-	"SMSC LAN91C111 Driver (v2.0), (Linux Kernel 2.4 + Support for Odd Byte) 09/24/01 -      by Pramod Bhardwaj (pramod.bhardwaj@smsc.com)\n\n";
+	"SMSC LAN91C111 Driver (v2.0), (Linux Kernel 2.4 + Support for Odd Byte) 09/24/01 -      by Pramod Bhardwaj (pramod.bhardwaj@smsc.com)\n";
 
 #ifdef MODULE
 #include <linux/module.h>
@@ -241,7 +241,7 @@
 	unsigned short ChipRev;
 	/* <= Pramod, Odd Byte issue */
 
-        spinlock_t lock;
+	spinlock_t lock;
 
 #ifdef CONFIG_SYSCTL
 
@@ -398,12 +398,12 @@
  . This is a separate procedure to handle the receipt of a packet, to
  . leave the interrupt code looking slightly cleaner
 */
-inline static void smc_rcv( struct net_device *dev );
+static inline void smc_rcv( struct net_device *dev );
 /*
  . This handles a TX interrupt, which is only called when an error
  . relating to a packet is sent.
 */
-inline static void smc_tx( struct net_device * dev );
+static inline void smc_tx( struct net_device * dev );
 
 /*
  . This handles interrupts generated from PHY register 18
@@ -748,7 +748,7 @@
 	lp->saved_skb = skb;
 
 	length = ETH_ZLEN < skb->len ? skb->len : ETH_ZLEN;
-		
+
 	/*
 	** The MMU wants the number of pages to be the number of 256 bytes
 	** 'pages', minus 1 ( since a packet can't ever have 0 pages :) )
@@ -815,11 +815,11 @@
 		/* and when we set the interrupt bit */
 		status = inb( ioaddr + INT_REG );
 		if ( !(status & IM_ALLOC_INT) ) {
-      			PRINTK2("%s: memory allocation deferred. \n",
+			PRINTK2("%s: memory allocation deferred. \n",
 				dev->name);
 			/* it's deferred, but I'll handle it later */
 			spin_unlock_irqrestore(&lp->lock, flags);
-      			return 0;
+			return 0;
 		}
 
 		/* Looks like it did sneak in, so disable */
@@ -828,7 +828,7 @@
 	}
 	/* or YES! I can send the packet now.. */
 #if THROTTLE_TX_PKTS
-                netif_stop_queue(dev);
+	netif_stop_queue(dev);
 #endif
 	smc_hardware_send_packet(dev);
 //	netif_wake_queue(dev);
@@ -1110,7 +1110,7 @@
 	/* clear hardware interrupts again, because that's how it
 	   was when I was called... */
 	cli();
-	
+
 	/* and return what I found */
 	return probe_irq_off(cookie);
 }
@@ -1150,7 +1150,7 @@
 	static unsigned version_printed = 0;
 	unsigned int	bank;
 
-        const char *version_string;
+	const char *version_string;
 
 	/*registers */
 	word	revision_register;
@@ -1329,12 +1329,12 @@
 	memset(dev->priv, 0, sizeof(struct smc_local));
 
 	/* Grab the IRQ */
-    retval = request_irq(dev->irq, &smc_interrupt, 0, dev->name, dev);
-    if (retval) {
-       	  printk("%s: unable to get IRQ %d (irqval=%d).\n",
-		dev->name, dev->irq, retval);
-		  goto err_out;
-      	}
+	retval = request_irq(dev->irq, &smc_interrupt, 0, dev->name, dev);
+	if (retval) {
+		printk("%s: unable to get IRQ %d (irqval=%d).\n",
+		       dev->name, dev->irq, retval);
+		goto err_out;
+	}
 
 	dev->open		        = smc_open;
 	dev->stop		        = smc_close;
@@ -1352,7 +1352,7 @@
 	lp->ChipID = (revision_register >> 4) & 0xF;
 	lp->ChipRev = revision_register & 0xF;
 
-        spin_lock_init(&lp->lock);
+	spin_lock_init(&lp->lock);
 
 	return 0;
 
@@ -1482,15 +1482,15 @@
 static void smc_timeout (struct net_device *dev)
 {
 
-        struct smc_local *lp = (struct smc_local *)dev->priv;
-        unsigned long flags;
+	struct smc_local *lp = (struct smc_local *)dev->priv;
+	unsigned long flags;
 
-        /*
-         *      Best would be to use synchronize_irq(); spin_lock() here
-         *      lets make it work first..
-         */
-         
-        spin_lock_irqsave(&lp->lock, flags);
+	/*
+	 *      Best would be to use synchronize_irq(); spin_lock() here
+	 *      lets make it work first..
+	 */
+
+	spin_lock_irqsave(&lp->lock, flags);
 
 	PRINTK3("%s:smc_send_packet\n", dev->name);
 
@@ -1598,7 +1598,7 @@
 			// Acknowledge the interrupt
 			outb(IM_TX_INT, ioaddr + INT_REG );
 #if THROTTLE_TX_PKTS
-                        netif_wake_queue(dev);
+			netif_wake_queue(dev);
 #endif
 		} else if (status & IM_TX_EMPTY_INT ) {
 			/* update stats */
@@ -1697,7 +1697,7 @@
  . o otherwise, read in the packet
  --------------------------------------------------------------
 */
-static void smc_rcv(struct net_device *dev)
+static inline void smc_rcv(struct net_device *dev)
 {
 	struct smc_local *lp = (struct smc_local *)dev->priv;
 	int 	ioaddr = dev->base_addr;
@@ -1763,21 +1763,20 @@
 		skb->dev = dev;
 
 		/* =>
-    ODD-BYTE ISSUE : The odd byte problem has been fixed in the LAN91C111 Rev B.
-		So we check if the Chip Revision, stored in smsc_local->ChipRev, is = 1.
-		If so then we increment the packet length only if RS_ODDFRAME is set.
-		If the Chip's revision is equal to 0, then we blindly increment the packet length
-		by 1, thus always assuming that the packet is odd length, leaving the higher layer
-		to decide the actual length.
-			-- Pramod
-		<= */
+		   ODD-BYTE ISSUE : The odd byte problem has been fixed in the LAN91C111 Rev B.
+		   So we check if the Chip Revision, stored in smsc_local->ChipRev, is = 1.
+		   If so then we increment the packet length only if RS_ODDFRAME is set.
+		   If the Chip's revision is equal to 0, then we blindly increment the packet length
+		   by 1, thus always assuming that the packet is odd length, leaving the higher layer
+		   to decide the actual length.
+		   -- Pramod
+		   <= */
 		if ((9 == lp->ChipID) && (1 == lp->ChipRev))
 		{
 			if (status & RS_ODDFRAME)
-				data = skb_put( skb, packet_length + 1 );	
+				data = skb_put( skb, packet_length + 1 );
 			else
-				data = skb_put( skb, packet_length);			
-			
+				data = skb_put( skb, packet_length);
 		}
 		else
 		{
@@ -1850,7 +1849,7 @@
  .	( resend?  Not really, since we don't want old packets around )
  .	Restore saved values
  ************************************************************************/
-static void smc_tx( struct net_device * dev )
+static inline void smc_tx( struct net_device * dev )
 {
 	int	ioaddr = dev->base_addr;
 	struct smc_local *lp = (struct smc_local *)dev->priv;
@@ -2156,7 +2155,7 @@
  . Sysctl handler for all integer parameters
  .-------------------------------------------------------------*/
 static int smc_sysctl_handler(ctl_table *ctl, int write, struct file * filp,
-				void *buffer, size_t *lenp)
+				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net_device *dev = (struct net_device*)ctl->extra1;
 	struct smc_local *lp = (struct smc_local *)ctl->extra2;
@@ -2384,8 +2383,8 @@
 	// Save old state
 	val = *valp;
 
-	// Perform the generic integer operation	
-	if ((ret = proc_dointvec(ctl, write, filp, buffer, lenp)) != 0)
+	// Perform the generic integer operation
+	if ((ret = proc_dointvec(ctl, write, filp, buffer, lenp, ppos)) != 0)
 		return(ret);
 
 	// Write changes out to the registers
@@ -2673,7 +2672,7 @@
 
 	} // end if
 
-        return ret;
+	return ret;
 }
 
 /*------------------------------------------------------------
@@ -3355,7 +3354,7 @@
 	smc_dump_mii_stream(bits, sizeof bits);
 #endif
 
-	return(phydata);	
+	return(phydata);
 }
 
 
@@ -3496,7 +3495,7 @@
 		PRINTK3("%s: phy_id1=%x, phy_id2=%x\n",
 			dev->name, phy_id1, phy_id2);
 
-		// Make sure it is a valid identifier	
+		// Make sure it is a valid identifier
 		if ((phy_id2 > 0x0000) && (phy_id2 < 0xffff) &&
 		    (phy_id1 > 0x0000) && (phy_id1 < 0xffff))
 			{
@@ -3817,78 +3816,77 @@
 
 	PRINTK2("%s: smc_phy_interrupt\n", dev->name);
 
-  while (1)
-	{ 
-	// Read PHY Register 18, Status Output
-	phy18 = smc_read_phy_register(ioaddr, phyaddr, PHY_INT_REG);
+	while (1) { 
+		// Read PHY Register 18, Status Output
+		phy18 = smc_read_phy_register(ioaddr, phyaddr, PHY_INT_REG);
 
-	// Exit if not more changes
-	if (phy18 == lp->lastPhy18)
-		break;
+		// Exit if not more changes
+		if (phy18 == lp->lastPhy18)
+			break;
 
 #if (SMC_DEBUG > 1 )
 
-	PRINTK2("%s:     phy18=0x%x\n", dev->name, phy18);
-	PRINTK2("%s: lastPhy18=0x%x\n", dev->name, lp->lastPhy18);
+		PRINTK2("%s:     phy18=0x%x\n", dev->name, phy18);
+		PRINTK2("%s: lastPhy18=0x%x\n", dev->name, lp->lastPhy18);
 
-	// Handle events
-	if ((phy18 & PHY_INT_LNKFAIL) != (lp->lastPhy18 & PHY_INT_LNKFAIL))
+		// Handle events
+		if ((phy18 & PHY_INT_LNKFAIL) != (lp->lastPhy18 & PHY_INT_LNKFAIL))
 		{
-		PRINTK2("%s: PHY Link Fail=%x\n", dev->name,
-			phy18 & PHY_INT_LNKFAIL);
+			PRINTK2("%s: PHY Link Fail=%x\n", dev->name,
+				phy18 & PHY_INT_LNKFAIL);
 		}
 
-	if ((phy18 & PHY_INT_LOSSSYNC) != (lp->lastPhy18 & PHY_INT_LOSSSYNC))
+		if ((phy18 & PHY_INT_LOSSSYNC) != (lp->lastPhy18 & PHY_INT_LOSSSYNC))
 		{
-		PRINTK2("%s: PHY LOSS SYNC=%x\n", dev->name,
-			phy18 & PHY_INT_LOSSSYNC);
+			PRINTK2("%s: PHY LOSS SYNC=%x\n", dev->name,
+				phy18 & PHY_INT_LOSSSYNC);
 		}
 
-	if ((phy18 & PHY_INT_CWRD) != (lp->lastPhy18 & PHY_INT_CWRD))
+		if ((phy18 & PHY_INT_CWRD) != (lp->lastPhy18 & PHY_INT_CWRD))
 		{
-		PRINTK2("%s: PHY INVALID 4B5B code=%x\n", dev->name,
-			phy18 & PHY_INT_CWRD);
+			PRINTK2("%s: PHY INVALID 4B5B code=%x\n", dev->name,
+				phy18 & PHY_INT_CWRD);
 		}
 
-	if ((phy18 & PHY_INT_SSD) != (lp->lastPhy18 & PHY_INT_SSD))
+		if ((phy18 & PHY_INT_SSD) != (lp->lastPhy18 & PHY_INT_SSD))
 		{
-		PRINTK2("%s: PHY No Start Of Stream=%x\n", dev->name,
-			phy18 & PHY_INT_SSD);
+			PRINTK2("%s: PHY No Start Of Stream=%x\n", dev->name,
+				phy18 & PHY_INT_SSD);
 		}
 
-	if ((phy18 & PHY_INT_ESD) != (lp->lastPhy18 & PHY_INT_ESD))
+		if ((phy18 & PHY_INT_ESD) != (lp->lastPhy18 & PHY_INT_ESD))
 		{
-		PRINTK2("%s: PHY No End Of Stream=%x\n", dev->name,
-			phy18 & PHY_INT_ESD);
+			PRINTK2("%s: PHY No End Of Stream=%x\n", dev->name,
+				phy18 & PHY_INT_ESD);
 		}
 
-	if ((phy18 & PHY_INT_RPOL) != (lp->lastPhy18 & PHY_INT_RPOL))
+		if ((phy18 & PHY_INT_RPOL) != (lp->lastPhy18 & PHY_INT_RPOL))
 		{
-		PRINTK2("%s: PHY Reverse Polarity Detected=%x\n", dev->name,
-			phy18 & PHY_INT_RPOL);
+			PRINTK2("%s: PHY Reverse Polarity Detected=%x\n", dev->name,
+				phy18 & PHY_INT_RPOL);
 		}
 
-	if ((phy18 & PHY_INT_JAB) != (lp->lastPhy18 & PHY_INT_JAB))
+		if ((phy18 & PHY_INT_JAB) != (lp->lastPhy18 & PHY_INT_JAB))
 		{
-		PRINTK2("%s: PHY Jabber Detected=%x\n", dev->name,
-			phy18 & PHY_INT_JAB);
+			PRINTK2("%s: PHY Jabber Detected=%x\n", dev->name,
+				phy18 & PHY_INT_JAB);
 		}
 
-	if ((phy18 & PHY_INT_SPDDET) != (lp->lastPhy18 & PHY_INT_SPDDET))
+		if ((phy18 & PHY_INT_SPDDET) != (lp->lastPhy18 & PHY_INT_SPDDET))
 		{
-		PRINTK2("%s: PHY Speed Detect=%x\n", dev->name,
-			phy18 & PHY_INT_SPDDET);
+			PRINTK2("%s: PHY Speed Detect=%x\n", dev->name,
+				phy18 & PHY_INT_SPDDET);
 		}
 
-	if ((phy18 & PHY_INT_DPLXDET) != (lp->lastPhy18 & PHY_INT_DPLXDET))
+		if ((phy18 & PHY_INT_DPLXDET) != (lp->lastPhy18 & PHY_INT_DPLXDET))
 		{
-		PRINTK2("%s: PHY Duplex Detect=%x\n", dev->name,
-			phy18 & PHY_INT_DPLXDET);
+			PRINTK2("%s: PHY Duplex Detect=%x\n", dev->name,
+				phy18 & PHY_INT_DPLXDET);
 		}
 #endif
 
-	// Update the last phy 18 variable
-	lp->lastPhy18 = phy18;
+		// Update the last phy 18 variable
+		lp->lastPhy18 = phy18;
 
 	} // end while
 }
diff -ruN linux-2.6.7_20040830/arch/m32r/kernel/init_task.c linux-2.6.8.1/arch/m32r/kernel/init_task.c
--- linux-2.6.7_20040830/arch/m32r/kernel/init_task.c	2003-10-09 13:58:37.000000000 +0900
+++ linux-2.6.8.1/arch/m32r/kernel/init_task.c	2004-08-30 10:23:53.000000000 +0900
@@ -6,6 +6,7 @@
 #include <linux/init.h>
 #include <linux/init_task.h>
 #include <linux/fs.h>
+#include <linux/mqueue.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
diff -ruN linux-2.6.7_20040830/arch/m32r/kernel/irq.c linux-2.6.8.1/arch/m32r/kernel/irq.c
--- linux-2.6.7_20040830/arch/m32r/kernel/irq.c	2004-03-25 13:27:25.000000000 +0900
+++ linux-2.6.8.1/arch/m32r/kernel/irq.c	2004-08-30 10:23:53.000000000 +0900
@@ -49,7 +49,6 @@
 #include <asm/system.h>
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
-#include <asm/pgalloc.h>
 #include <asm/delay.h>
 #include <asm/irq.h>
 
@@ -555,7 +554,7 @@
 
 	action->handler = handler;
 	action->flags = irqflags;
-	action->mask = 0;
+	cpus_clear(action->mask);
 	action->name = devname;
 	action->next = NULL;
 	action->dev_id = dev_id;
@@ -997,7 +996,7 @@
 	int i;
 
 	/* create /proc/irq */
-	root_irq_dir = proc_mkdir("irq", 0);
+	root_irq_dir = proc_mkdir("irq", NULL);
 
 	/* create /proc/irq/prof_cpu_mask */
 	entry = create_proc_entry("prof_cpu_mask", 0600, root_irq_dir);
diff -ruN linux-2.6.7_20040830/arch/m32r/kernel/module.c linux-2.6.8.1/arch/m32r/kernel/module.c
--- linux-2.6.7_20040830/arch/m32r/kernel/module.c	2004-05-11 13:54:57.000000000 +0900
+++ linux-2.6.8.1/arch/m32r/kernel/module.c	2004-08-30 10:23:53.000000000 +0900
@@ -31,7 +31,7 @@
 {
 	if (size == 0)
 		return NULL;
-	return vmalloc(size);
+	return vmalloc_exec(size);
 }
 
 
diff -ruN linux-2.6.7_20040830/arch/m32r/kernel/setup.c linux-2.6.8.1/arch/m32r/kernel/setup.c
--- linux-2.6.7_20040830/arch/m32r/kernel/setup.c	2004-08-24 15:16:14.000000000 +0900
+++ linux-2.6.8.1/arch/m32r/kernel/setup.c	2004-08-30 10:23:53.000000000 +0900
@@ -68,11 +68,21 @@
 
 extern int root_mountflags;
 
-static char command_line[COMMAND_LINE_SIZE] = { 0 };
-char saved_command_line[COMMAND_LINE_SIZE];
+static char command_line[COMMAND_LINE_SIZE];
 
-static struct resource code_resource = { "Kernel code", 0x100000, 0 };
-static struct resource data_resource = { "Kernel data", 0, 0 };
+static struct resource data_resource = {
+	.name   = "Kernel data",
+	.start  = 0,
+	.end    = 0,
+	.flags  = IORESOURCE_BUSY | IORESOURCE_MEM
+};
+
+static struct resource code_resource = {
+	.name   = "Kernel code",
+	.start  = 0,
+	.end    = 0,
+	.flags  = IORESOURCE_BUSY | IORESOURCE_MEM
+};
 
 unsigned long memory_start;
 unsigned long memory_end;
@@ -234,9 +244,9 @@
 
 #ifdef CONFIG_VT
 #if defined(CONFIG_VGA_CONSOLE)
-        conswitchp = &vga_con;
+	conswitchp = &vga_con;
 #elif defined(CONFIG_DUMMY_CONSOLE)
-        conswitchp = &dummy_con;
+	conswitchp = &dummy_con;
 #endif
 #endif
 
@@ -271,7 +281,7 @@
 	unsigned long cpu = c - cpu_data;
 	
 #ifdef CONFIG_SMP
-	if (!(cpu_online_map & (1 << cpu)))
+	if (!cpu_online(cpu))
 		return 0;
 #endif  /* CONFIG_SMP */
 
@@ -359,7 +369,7 @@
  */
 #if defined(CONFIG_CHIP_VDEC2) || defined(CONFIG_CHIP_XNUX2)	\
 	|| defined(CONFIG_CHIP_M32700) || defined(CONFIG_CHIP_M32102) \
-        || defined(CONFIG_CHIP_OPSP)
+	|| defined(CONFIG_CHIP_OPSP)
 void __init cpu_init (void)
 {
 	int cpu_id = smp_processor_id();
diff -ruN linux-2.6.7_20040830/arch/m32r/kernel/smp.c linux-2.6.8.1/arch/m32r/kernel/smp.c
--- linux-2.6.7_20040830/arch/m32r/kernel/smp.c	2004-08-27 17:18:48.000000000 +0900
+++ linux-2.6.8.1/arch/m32r/kernel/smp.c	2004-08-30 10:23:53.000000000 +0900
@@ -55,7 +55,7 @@
  * For flush_cache_all()
  */
 static spinlock_t flushcache_lock = SPIN_LOCK_UNLOCKED;
-static volatile unsigned long flushcache_cpumask;
+static volatile unsigned long flushcache_cpumask = 0;
 
 /* 
  * For flush_tlb_others()
@@ -90,7 +90,7 @@
 void smp_flush_tlb_range(struct vm_area_struct *, unsigned long, \
 	unsigned long);
 void smp_flush_tlb_page(struct vm_area_struct *, unsigned long);
-static void flush_tlb_others(unsigned long, struct mm_struct *,
+static void flush_tlb_others(cpumask_t, struct mm_struct *,
 	struct vm_area_struct *, unsigned long);
 void smp_invalidate_interrupt(void);
 
@@ -132,7 +132,7 @@
  *==========================================================================*/
 void smp_send_reschedule(int cpu_id)
 {
-	send_IPI_mask(1 << cpu_id, RESCHEDULE_IPI, 1);
+	send_IPI_mask(cpumask_of_cpu(cpu_id), RESCHEDULE_IPI, 1);
 }
 
 /*==========================================================================*
@@ -179,15 +179,18 @@
 void smp_flush_cache_all(void)
 {
 	cpumask_t cpumask;
+	unsigned long *mask;
 
 	preempt_disable();
-	cpumask = 1UL << smp_processor_id();
-	cpumask = cpu_online_map & ~cpumask;
+	cpumask = cpu_online_map;
+	cpu_clear(smp_processor_id(), cpumask);
 	spin_lock(&flushcache_lock);
-	atomic_set_mask(cpumask, (atomic_t *)&flushcache_cpumask);
+	mask=cpus_addr(cpumask);
+	atomic_set_mask(*mask, (atomic_t *)&flushcache_cpumask);
 	send_IPI_mask(cpumask, INVALIDATE_CACHE_IPI, 0);
 	_flush_cache_copyback_all();
-	while (flushcache_cpumask);
+	while (flushcache_cpumask)
+		mb();
 	spin_unlock(&flushcache_lock);
 	preempt_enable();
 }
@@ -273,11 +276,14 @@
 void smp_flush_tlb_mm(struct mm_struct *mm)
 {
 	int cpu_id = smp_processor_id();
-	cpumask_t cpu_mask = mm->cpu_vm_mask & ~(1 << cpu_id);
+	cpumask_t cpu_mask;
 	unsigned long *mmc = &mm->context[cpu_id];
 	unsigned long flags;
 
 	preempt_disable();
+	cpu_mask = mm->cpu_vm_mask;
+	cpu_clear(cpu_id, cpu_mask);
+
 	if (*mmc != NO_CONTEXT) {
 		local_irq_save(flags);
 		*mmc = NO_CONTEXT;
@@ -287,7 +293,7 @@
 			cpu_clear(cpu_id, mm->cpu_vm_mask);
 		local_irq_restore(flags);
 	}
-	if (cpu_mask)
+	if (!cpus_empty(cpu_mask))
 		flush_tlb_others(cpu_mask, mm, NULL, FLUSH_ALL);
 
 	preempt_enable();
@@ -338,11 +344,14 @@
 {
 	struct mm_struct *mm = vma->vm_mm;
 	int cpu_id = smp_processor_id();
-	cpumask_t cpu_mask = mm->cpu_vm_mask & ~(1 << cpu_id);
+	cpumask_t cpu_mask;
 	unsigned long *mmc = &mm->context[cpu_id];
 	unsigned long flags;
 
 	preempt_disable();
+	cpu_mask = mm->cpu_vm_mask;
+	cpu_clear(cpu_id, cpu_mask);
+
 #ifdef DEBUG_SMP
 	if (!mm)
 		BUG();
@@ -355,7 +364,7 @@
 		__flush_tlb_page(va);
 		local_irq_restore(flags);
 	}
-	if (cpu_mask)
+	if (!cpus_empty(cpu_mask))
 		flush_tlb_others(cpu_mask, mm, vma, va);
 
 	preempt_enable();
@@ -387,6 +396,8 @@
 static void flush_tlb_others(cpumask_t cpumask, struct mm_struct *mm, 
 	struct vm_area_struct *vma, unsigned long va)
 {
+	cpumask_t tmp;
+	unsigned long *mask;
 #ifdef DEBUG_SMP
 	unsigned long flags;
 	__save_flags(flags);
@@ -401,14 +412,12 @@
 	 * - current CPU must not be in mask
 	 * - mask must exist :)
 	 */
-	if (!cpumask)
-		BUG();
-	if ((cpumask & cpu_online_map) != cpumask)
-		BUG();
-	if (cpumask & (1 << smp_processor_id()))
-		BUG();
-	if (!mm)
-		BUG();
+	BUG_ON(cpus_empty(cpumask));
+
+	cpus_and(tmp, cpumask, cpu_online_map);
+	BUG_ON(!cpus_equal(cpumask, tmp));
+	BUG_ON(cpu_isset(smp_processor_id(), cpumask));
+	BUG_ON(!mm);
 
 	/*
 	 * i'm not happy about this global shared spinlock in the
@@ -421,8 +430,8 @@
 	flush_mm = mm;
 	flush_vma = vma;
 	flush_va = va;
-
-	atomic_set_mask(cpumask, (atomic_t *)&flush_cpumask);
+	mask=cpus_addr(cpumask);
+	atomic_set_mask(*mask, (atomic_t *)&flush_cpumask);
 
 	/*
 	 * We have to send the IPI only to
@@ -430,8 +439,9 @@
 	 */
 	send_IPI_mask(cpumask, INVALIDATE_TLB_IPI, 0);
 
-	while (flush_cpumask)
-		/* nothing. lockup detection does not belong here */;
+	while (!cpus_empty(flush_cpumask))
+		/* nothing. lockup detection does not belong here */
+		mb();
 
 	flush_mm = NULL;
 	flush_vma = NULL;
@@ -485,7 +495,7 @@
 }
 
 /*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*/
-/* Stop CPU reequest Routins                                                 */
+/* Stop CPU request Routins                                                 */
 /*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*/
 
 /*==========================================================================*
@@ -608,7 +618,8 @@
 
 	spin_lock(&call_lock);
 	call_data = &data;
-	wmb();
+	mb();
+
 	/* Send a message to all other CPUs and wait for them to respond */
 	send_IPI_allbutself(CALL_FUNCTION_IPI, 0);
 
@@ -659,6 +670,7 @@
 	irq_enter();
 	(*func)(info);
 	irq_exit();
+
 	if (wait) {
 		mb();
 		atomic_inc(&call_data->finished);
@@ -799,7 +811,10 @@
  *==========================================================================*/
 void send_IPI_allbutself(int ipi_num, int try)
 {
-	cpumask_t cpumask = (cpu_online_map & ~(1 << smp_processor_id()));
+	cpumask_t cpumask;
+	
+	cpumask = cpu_online_map;
+	cpu_clear(smp_processor_id(), cpumask);
 
 	send_IPI_mask(cpumask, ipi_num, try);
 }
@@ -826,21 +841,21 @@
  *==========================================================================*/
 static void send_IPI_mask(cpumask_t cpumask, int ipi_num, int try)
 {
-	cpumask_t physid_mask;
+	cpumask_t physid_mask, tmp;
 	int cpu_id, phys_id;
 	int num_cpus = num_online_cpus();
 
 	if (num_cpus <= 1)	/* NO MP */
 		return;
 
-	if ((cpumask & cpu_online_map) != cpumask) /* include not online CPU */
-		BUG();
+	cpus_and(tmp, cpumask, cpu_online_map);
+	BUG_ON(!cpus_equal(cpumask, tmp));
 
-	physid_mask = 0;
-	for (cpu_id = 0 ; cpu_id < num_cpus ; cpu_id++)
-		if (cpumask & (1 << cpu_id))
-			if ((phys_id = cpu_to_physid(cpu_id)) != -1)
-				cpu_set(phys_id, physid_mask);
+	physid_mask = CPU_MASK_NONE;
+	for_each_cpu_mask(cpu_id, cpumask){
+		if ((phys_id = cpu_to_physid(cpu_id)) != -1)
+			cpu_set(phys_id, physid_mask);
+	}
 
 	send_IPI_mask_phys(physid_mask, ipi_num, try);
 }
@@ -872,14 +887,16 @@
 	unsigned long flags = 0;
 	volatile unsigned long *ipicr_addr;
 	unsigned long ipicr_val;
-	cpumask_t my_physid_mask;
+	unsigned long my_physid_mask;
+	unsigned long mask = cpus_addr(physid_mask)[0];
 
-	if (physid_mask & ~phys_cpu_present_map)
+	
+	if (mask & ~physids_coerce(phys_cpu_present_map))
 		BUG();
 	if (ipi_num >= NR_IPIS)
 		BUG();
 
-	physid_mask <<= IPI_SHIFT;
+	mask <<= IPI_SHIFT;
 	ipilock = &ipi_lock[ipi_num];
 	ipicr_addr = (volatile unsigned long *)(M32R_ICU_IPICR_ADDR 
 		+ (ipi_num << 2));
@@ -929,7 +946,7 @@
 		"st	r4, @%2			\n\t"
 		: "=&r"(ipicr_val)
 		: "r"(flags), "r"(&ipilock->lock), "r"(ipicr_addr),
-		  "r"(physid_mask), "r"(try), "r"(my_physid_mask)
+		  "r"(mask), "r"(try), "r"(my_physid_mask)
 		: "memory", "r4"
 #ifdef CONFIG_CHIP_M32700_TS1
 		, "r5"
diff -ruN linux-2.6.7_20040830/arch/m32r/kernel/smpboot.c linux-2.6.8.1/arch/m32r/kernel/smpboot.c
--- linux-2.6.7_20040830/arch/m32r/kernel/smpboot.c	2003-10-09 13:58:37.000000000 +0900
+++ linux-2.6.8.1/arch/m32r/kernel/smpboot.c	2004-08-30 10:23:53.000000000 +0900
@@ -61,7 +61,7 @@
 #endif
 
 extern int cpu_idle(void);
-extern unsigned long cpu_initialized;
+extern cpumask_t cpu_initialized;
 
 /*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*/
 /* Data structures and variables                                             */
@@ -71,7 +71,7 @@
 static unsigned int bsp_phys_id = -1;
 
 /* Bitmask of physically existing CPUs */
-cpumask_t phys_cpu_present_map;
+physid_mask_t phys_cpu_present_map;
 
 /* Bitmask of currently online CPUs */
 cpumask_t cpu_online_map;
@@ -142,7 +142,7 @@
 void __devinit smp_prepare_boot_cpu(void)
 {
 	bsp_phys_id = hard_smp_processor_id();
-	cpu_set(bsp_phys_id, phys_cpu_present_map);
+	physid_set(bsp_phys_id, phys_cpu_present_map);
 	cpu_set(0, cpu_online_map);	/* BSP's cpu_id == 0 */
 	cpu_set(0, cpu_callout_map);
 	cpu_set(0, cpu_callin_map);
@@ -184,7 +184,7 @@
 		goto smp_done;
 	}
 	for (phys_id = 0 ; phys_id < nr_cpu ; phys_id++)
-		cpu_set(phys_id, phys_cpu_present_map);
+		physid_set(phys_id, phys_cpu_present_map);
 
 	show_mp_info(nr_cpu);
 
@@ -207,7 +207,7 @@
 	/*
 	 * Now scan the CPU present map and fire up the other CPUs.
 	 */
-	Dprintk("CPU present map : %lx\n", phys_cpu_present_map);
+	Dprintk("CPU present map : %lx\n", physids_coerce(phys_cpu_present_map));
 
 	for (phys_id = 0 ; phys_id < NR_CPUS ; phys_id++) {
 		/*
@@ -216,7 +216,7 @@
 		if (phys_id == bsp_phys_id)
 			continue;
 
-		if (!cpu_isset(phys_id, phys_cpu_present_map))
+		if (!physid_isset(phys_id, phys_cpu_present_map))
 			continue;
 
 		if ((max_cpus >= 0) && (max_cpus <= cpucount + 1))
@@ -228,7 +228,7 @@
 		 * Make sure we unmap all failed CPUs
 		 */
 		if (physid_to_cpu(phys_id) == -1) {
-			cpu_clear(phys_id, phys_cpu_present_map);
+			physid_clear(phys_id, phys_cpu_present_map);
 			printk("phys CPU#%d not responding - " \
 				"cannot use it.\n", phys_id);
 		}
@@ -329,7 +329,7 @@
 	cpu_set(phys_id, cpu_bootout_map);
 
 	/* Send Startup IPI */
-	send_IPI_mask_phys((1 << phys_id), CPU_BOOT_IPI, 0);
+	send_IPI_mask_phys(cpumask_of_cpu(phys_id), CPU_BOOT_IPI, 0);
 
 	Dprintk("Waiting for send to finish...\n");
 	timeout = 0;
@@ -405,11 +405,11 @@
 	unsigned long bogosum = 0;
 
 	for (timeout = 0; timeout < 5000; timeout++) {
-		if (cpu_callin_map == cpu_online_map)
+		if (cpus_equal(cpu_callin_map, cpu_online_map))
 			break;
 		udelay(1000);
 	}
-	if (cpu_callin_map != cpu_online_map)
+	if (!cpus_equal(cpu_callin_map, cpu_online_map))
 		BUG();
 
 	for (cpu_id = 0 ; cpu_id < num_online_cpus() ; cpu_id++)
@@ -420,9 +420,8 @@
 	 */
 	Dprintk("Before bogomips.\n");
 	if (cpucount) {
-		for (cpu_id = 0 ; cpu_id < NR_CPUS ; cpu_id++)
-			if (cpu_online_map & (1 << cpu_id))
-				bogosum += cpu_data[cpu_id].loops_per_jiffy;
+		for_each_cpu_mask(cpu_id, cpu_online_map)
+			bogosum += cpu_data[cpu_id].loops_per_jiffy;
 
 		printk(KERN_INFO "Total of %d processors activated " \
 			"(%lu.%02lu BogoMIPS).\n", cpucount + 1, 
diff -ruN linux-2.6.7_20040830/arch/m32r/kernel/sys_m32r.c linux-2.6.8.1/arch/m32r/kernel/sys_m32r.c
--- linux-2.6.7_20040830/arch/m32r/kernel/sys_m32r.c	2004-05-07 15:32:01.000000000 +0900
+++ linux-2.6.8.1/arch/m32r/kernel/sys_m32r.c	2004-08-30 10:23:53.000000000 +0900
@@ -195,7 +195,7 @@
 		union semun fourth;
 		if (!ptr)
 			return -EINVAL;
-		if (get_user(fourth.__pad, (void * __user *) ptr))
+		if (get_user(fourth.__pad, (void __user * __user *) ptr))
 			return -EFAULT;
 		return sys_semctl (first, second, third, fourth);
 		}
diff -ruN linux-2.6.7_20040830/arch/m32r/kernel/time.c linux-2.6.8.1/arch/m32r/kernel/time.c
--- linux-2.6.7_20040830/arch/m32r/kernel/time.c	2004-05-27 17:45:04.000000000 +0900
+++ linux-2.6.8.1/arch/m32r/kernel/time.c	2004-08-30 10:23:53.000000000 +0900
@@ -62,7 +62,7 @@
 
 #if defined(CONFIG_CHIP_M32102) || defined(CONFIG_CHIP_XNUX2) \
 	|| defined(CONFIG_CHIP_VDEC2) || defined(CONFIG_CHIP_M32700) \
-        || defined(CONFIG_CHIP_OPSP)
+	|| defined(CONFIG_CHIP_OPSP)
 #ifndef CONFIG_SMP
 
 	unsigned long count;
@@ -157,12 +157,12 @@
 		return -EINVAL;
 
 	write_seqlock_irq(&xtime_lock);
-        /*
-         * This is revolting. We need to set "xtime" correctly. However, the
-         * value in this location is the value at the most recent update of
-         * wall time.  Discover what correction gettimeofday() would have
-         * made, and then undo it!
-         */
+	/*
+	 * This is revolting. We need to set "xtime" correctly. However, the
+	 * value in this location is the value at the most recent update of
+	 * wall time.  Discover what correction gettimeofday() would have
+	 * made, and then undo it!
+	 */
 	nsec -= do_gettimeoffset() * NSEC_PER_USEC;
 	nsec -= (jiffies - wall_jiffies) * TICK_NSEC;
 
@@ -172,11 +172,11 @@
 	set_normalized_timespec(&xtime, sec, nsec);
 	set_normalized_timespec(&wall_to_monotonic, wtm_sec, wtm_nsec);
 
-        time_adjust = 0;		/* stop active adjtime() */
-        time_status |= STA_UNSYNC;
-        time_maxerror = NTP_PHASE_LIMIT;
-        time_esterror = NTP_PHASE_LIMIT;
-        write_sequnlock_irq(&xtime_lock);
+	time_adjust = 0;		/* stop active adjtime() */
+	time_status |= STA_UNSYNC;
+	time_maxerror = NTP_PHASE_LIMIT;
+	time_esterror = NTP_PHASE_LIMIT;
+	write_sequnlock_irq(&xtime_lock);
 	clock_was_set();
 
 	return 0;
@@ -249,8 +249,8 @@
 	return IRQ_HANDLED;
 }
 
-struct irqaction irq0 = { timer_interrupt, SA_INTERRUPT, 0, "MFT2", NULL, 
-	NULL };
+struct irqaction irq0 = { timer_interrupt, SA_INTERRUPT, CPU_MASK_NONE,
+			  "MFT2", NULL, NULL };
 
 void __init time_init(void)
 {
@@ -279,7 +279,7 @@
 
 #if defined(CONFIG_CHIP_M32102) || defined(CONFIG_CHIP_XNUX2) \
 	|| defined(CONFIG_CHIP_VDEC2) || defined(CONFIG_CHIP_M32700) \
-        || defined(CONFIG_CHIP_OPSP)
+	|| defined(CONFIG_CHIP_OPSP)
 
 	/* M32102 MFT setup */
 	setup_irq(M32R_IRQ_MFT2, &irq0);
diff -ruN linux-2.6.7_20040830/arch/m32r/kernel/traps.c linux-2.6.8.1/arch/m32r/kernel/traps.c
--- linux-2.6.7_20040830/arch/m32r/kernel/traps.c	2004-08-23 20:53:31.000000000 +0900
+++ linux-2.6.8.1/arch/m32r/kernel/traps.c	2004-08-30 10:23:53.000000000 +0900
@@ -132,7 +132,7 @@
 	printk("Call Trace: ");
 	while (!kstack_end(stack)) {
 		addr = *stack++;
-		if (kernel_text_address(addr)) {
+		if (__kernel_text_address(addr)) {
 			printk("[<%08lx>] ", addr);
 			print_symbol("%s\n", addr);
 		}
@@ -278,7 +278,7 @@
 	info.si_signo = signr; \
 	info.si_errno = 0; \
 	info.si_code = sicode; \
-	info.si_addr = (void *)siaddr; \
+	info.si_addr = (void __user *)siaddr; \
 	do_trap(trapnr, signr, str, regs, error_code, &info); \
 }
 
diff -ruN linux-2.6.7_20040830/arch/m32r/lib/delay.c linux-2.6.8.1/arch/m32r/lib/delay.c
--- linux-2.6.7_20040830/arch/m32r/lib/delay.c	2004-07-06 16:08:16.000000000 +0900
+++ linux-2.6.8.1/arch/m32r/lib/delay.c	2004-08-30 10:23:53.000000000 +0900
@@ -115,10 +115,12 @@
 	__delay(xloops * HZ);
 }
 
-/* 
- * 4294 = 2^32 / 10^6
- */
 void __udelay(unsigned long usecs)
 {
-	__const_udelay(usecs * 4294UL);
+	__const_udelay(usecs * 0x000010c7);  /* 2**32 / 1000000 (rounded up) */
+}
+
+void __ndelay(unsigned long nsecs)
+{
+	__const_udelay(nsecs * 0x00005);  /* 2**32 / 1000000000 (rounded up) */
 }
diff -ruN linux-2.6.7_20040830/arch/m32r/m32700ut/defconfig.m32700ut.smp linux-2.6.8.1/arch/m32r/m32700ut/defconfig.m32700ut.smp
--- linux-2.6.7_20040830/arch/m32r/m32700ut/defconfig.m32700ut.smp	2004-07-15 13:43:14.000000000 +0900
+++ linux-2.6.8.1/arch/m32r/m32700ut/defconfig.m32700ut.smp	2004-08-30 10:23:54.000000000 +0900
@@ -10,7 +10,6 @@
 #
 CONFIG_EXPERIMENTAL=y
 CONFIG_CLEAN_COMPILE=y
-CONFIG_STANDALONE=y
 
 #
 # General setup
@@ -19,6 +18,7 @@
 CONFIG_SYSVIPC=y
 # CONFIG_POSIX_MQUEUE is not set
 CONFIG_BSD_PROCESS_ACCT=y
+# CONFIG_BSD_PROCESS_ACCT_V3 is not set
 CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
 CONFIG_LOG_BUF_SHIFT=15
@@ -52,6 +52,7 @@
 # CONFIG_PLAT_MAPPI is not set
 # CONFIG_PLAT_USRV is not set
 CONFIG_PLAT_M32700UT=y
+# CONFIG_PLAT_OPSPUT is not set
 # CONFIG_PLAT_OAKS32R is not set
 # CONFIG_PLAT_MAPPI2 is not set
 CONFIG_CHIP_M32700=y
@@ -86,6 +87,7 @@
 CONFIG_M32R_CFC=y
 CONFIG_M32700UT_CFC=y
 CONFIG_CFC_NUM=1
+# CONFIG_MTD_M32R is not set
 CONFIG_M32R_SMC91111=y
 CONFIG_M32700UT_DS1302=y
 
@@ -124,6 +126,8 @@
 #
 # Generic Driver Options
 #
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_FW_LOADER is not set
 
 #
@@ -160,6 +164,7 @@
 #
 # Please see Documentation/ide.txt for help/info on IDE drives
 #
+# CONFIG_BLK_DEV_IDE_SATA is not set
 CONFIG_BLK_DEV_IDEDISK=y
 # CONFIG_IDEDISK_MULTI_MODE is not set
 CONFIG_BLK_DEV_IDECS=y
@@ -237,7 +242,6 @@
 #
 # IEEE 1394 (FireWire) support
 #
-# CONFIG_IEEE1394 is not set
 
 #
 # I2O device support
@@ -289,13 +293,13 @@
 # CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-# CONFIG_NET_FASTROUTE is not set
 # CONFIG_NET_HW_FLOWCONTROL is not set
 
 #
 # QoS and/or fair queueing
 #
 # CONFIG_NET_SCHED is not set
+# CONFIG_NET_CLS_ROUTE is not set
 
 #
 # Network testing
@@ -390,7 +394,6 @@
 # CONFIG_GEN_RTC is not set
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
-# CONFIG_APPLICOM is not set
 
 #
 # Ftape, the floppy tape device driver
@@ -410,6 +413,11 @@
 # CONFIG_I2C is not set
 
 #
+# Dallas's 1-wire bus
+#
+# CONFIG_W1 is not set
+
+#
 # Misc devices
 #
 
@@ -426,11 +434,12 @@
 # Video Adapters
 #
 # CONFIG_VIDEO_CPIA is not set
+CONFIG_M32R_AR=y
+CONFIG_M32R_AR_VGA=y
 
 #
 # Radio Adapters
 #
-# CONFIG_RADIO_MAXIRADIO is not set
 # CONFIG_RADIO_MAESTRO is not set
 
 #
@@ -452,7 +461,6 @@
 # CONFIG_MDA_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
-CONFIG_PCI_CONSOLE=y
 # CONFIG_FONTS is not set
 CONFIG_FONT_8x8=y
 CONFIG_FONT_8x16=y
@@ -511,6 +519,7 @@
 CONFIG_JOLIET=y
 # CONFIG_ZISOFS is not set
 CONFIG_UDF_FS=m
+CONFIG_UDF_NLS=y
 
 #
 # DOS/FAT/NT Filesystems
@@ -518,6 +527,8 @@
 CONFIG_FAT_FS=m
 CONFIG_MSDOS_FS=m
 CONFIG_VFAT_FS=m
+CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
 # CONFIG_NTFS_FS is not set
 
 #
@@ -605,6 +616,7 @@
 # CONFIG_NLS_ISO8859_8 is not set
 # CONFIG_NLS_CODEPAGE_1250 is not set
 # CONFIG_NLS_CODEPAGE_1251 is not set
+# CONFIG_NLS_ASCII is not set
 # CONFIG_NLS_ISO8859_1 is not set
 # CONFIG_NLS_ISO8859_2 is not set
 # CONFIG_NLS_ISO8859_3 is not set
@@ -645,5 +657,6 @@
 #
 # Library routines
 #
+# CONFIG_CRC_CCITT is not set
 CONFIG_CRC32=y
 # CONFIG_LIBCRC32C is not set
diff -ruN linux-2.6.7_20040830/arch/m32r/m32700ut/defconfig.m32700ut.up linux-2.6.8.1/arch/m32r/m32700ut/defconfig.m32700ut.up
--- linux-2.6.7_20040830/arch/m32r/m32700ut/defconfig.m32700ut.up	2004-07-15 13:43:14.000000000 +0900
+++ linux-2.6.8.1/arch/m32r/m32700ut/defconfig.m32700ut.up	2004-08-30 10:23:54.000000000 +0900
@@ -10,7 +10,6 @@
 #
 CONFIG_EXPERIMENTAL=y
 CONFIG_CLEAN_COMPILE=y
-CONFIG_STANDALONE=y
 CONFIG_BROKEN_ON_SMP=y
 
 #
@@ -20,6 +19,7 @@
 CONFIG_SYSVIPC=y
 # CONFIG_POSIX_MQUEUE is not set
 CONFIG_BSD_PROCESS_ACCT=y
+# CONFIG_BSD_PROCESS_ACCT_V3 is not set
 CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
 CONFIG_LOG_BUF_SHIFT=14
@@ -52,6 +52,7 @@
 # CONFIG_PLAT_MAPPI is not set
 # CONFIG_PLAT_USRV is not set
 CONFIG_PLAT_M32700UT=y
+# CONFIG_PLAT_OPSPUT is not set
 # CONFIG_PLAT_OAKS32R is not set
 # CONFIG_PLAT_MAPPI2 is not set
 CONFIG_CHIP_M32700=y
@@ -83,6 +84,7 @@
 CONFIG_M32R_CFC=y
 CONFIG_M32700UT_CFC=y
 CONFIG_CFC_NUM=1
+# CONFIG_MTD_M32R is not set
 CONFIG_M32R_SMC91111=y
 CONFIG_M32700UT_DS1302=y
 
@@ -121,6 +123,8 @@
 #
 # Generic Driver Options
 #
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_FW_LOADER is not set
 
 #
@@ -157,6 +161,7 @@
 #
 # Please see Documentation/ide.txt for help/info on IDE drives
 #
+# CONFIG_BLK_DEV_IDE_SATA is not set
 CONFIG_BLK_DEV_IDEDISK=y
 # CONFIG_IDEDISK_MULTI_MODE is not set
 CONFIG_BLK_DEV_IDECS=y
@@ -234,7 +239,6 @@
 #
 # IEEE 1394 (FireWire) support
 #
-# CONFIG_IEEE1394 is not set
 
 #
 # I2O device support
@@ -286,13 +290,13 @@
 # CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-# CONFIG_NET_FASTROUTE is not set
 # CONFIG_NET_HW_FLOWCONTROL is not set
 
 #
 # QoS and/or fair queueing
 #
 # CONFIG_NET_SCHED is not set
+# CONFIG_NET_CLS_ROUTE is not set
 
 #
 # Network testing
@@ -335,7 +339,7 @@
 # CONFIG_GAMEPORT is not set
 CONFIG_SOUND_GAMEPORT=y
 CONFIG_SERIO=y
-CONFIG_SERIO_I8042=y
+# CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_CT82C710 is not set
 
@@ -387,12 +391,10 @@
 # CONFIG_GEN_RTC is not set
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
-# CONFIG_APPLICOM is not set
 
 #
 # Ftape, the floppy tape device driver
 #
-# CONFIG_FTAPE is not set
 # CONFIG_AGP is not set
 # CONFIG_DRM is not set
 
@@ -408,6 +410,11 @@
 # CONFIG_I2C is not set
 
 #
+# Dallas's 1-wire bus
+#
+# CONFIG_W1 is not set
+
+#
 # Misc devices
 #
 
@@ -424,11 +431,12 @@
 # Video Adapters
 #
 # CONFIG_VIDEO_CPIA is not set
+CONFIG_M32R_AR=y
+CONFIG_M32R_AR_VGA=y
 
 #
 # Radio Adapters
 #
-# CONFIG_RADIO_MAXIRADIO is not set
 # CONFIG_RADIO_MAESTRO is not set
 
 #
@@ -450,7 +458,6 @@
 # CONFIG_MDA_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
-CONFIG_PCI_CONSOLE=y
 # CONFIG_FONTS is not set
 CONFIG_FONT_8x8=y
 CONFIG_FONT_8x16=y
@@ -509,6 +516,7 @@
 CONFIG_JOLIET=y
 # CONFIG_ZISOFS is not set
 CONFIG_UDF_FS=m
+CONFIG_UDF_NLS=y
 
 #
 # DOS/FAT/NT Filesystems
@@ -516,6 +524,8 @@
 CONFIG_FAT_FS=m
 CONFIG_MSDOS_FS=m
 CONFIG_VFAT_FS=m
+CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
 # CONFIG_NTFS_FS is not set
 
 #
@@ -603,6 +613,7 @@
 # CONFIG_NLS_ISO8859_8 is not set
 # CONFIG_NLS_CODEPAGE_1250 is not set
 # CONFIG_NLS_CODEPAGE_1251 is not set
+# CONFIG_NLS_ASCII is not set
 # CONFIG_NLS_ISO8859_1 is not set
 # CONFIG_NLS_ISO8859_2 is not set
 # CONFIG_NLS_ISO8859_3 is not set
@@ -643,5 +654,6 @@
 #
 # Library routines
 #
+# CONFIG_CRC_CCITT is not set
 CONFIG_CRC32=y
 # CONFIG_LIBCRC32C is not set
diff -ruN linux-2.6.7_20040830/arch/m32r/mappi/defconfig.nommu linux-2.6.8.1/arch/m32r/mappi/defconfig.nommu
--- linux-2.6.7_20040830/arch/m32r/mappi/defconfig.nommu	2004-07-15 13:43:14.000000000 +0900
+++ linux-2.6.8.1/arch/m32r/mappi/defconfig.nommu	2004-08-30 10:23:54.000000000 +0900
@@ -10,15 +10,14 @@
 #
 CONFIG_EXPERIMENTAL=y
 CONFIG_CLEAN_COMPILE=y
-CONFIG_STANDALONE=y
 CONFIG_BROKEN_ON_SMP=y
 
 #
 # General setup
 #
-# CONFIG_SYSVIPC is not set
 # CONFIG_POSIX_MQUEUE is not set
 CONFIG_BSD_PROCESS_ACCT=y
+# CONFIG_BSD_PROCESS_ACCT_V3 is not set
 CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
 CONFIG_LOG_BUF_SHIFT=14
@@ -51,6 +50,7 @@
 CONFIG_PLAT_MAPPI=y
 # CONFIG_PLAT_USRV is not set
 # CONFIG_PLAT_M32700UT is not set
+# CONFIG_PLAT_OPSPUT is not set
 # CONFIG_PLAT_OAKS32R is not set
 # CONFIG_PLAT_MAPPI2 is not set
 CONFIG_CHIP_M32700=y
@@ -116,6 +116,8 @@
 #
 # Generic Driver Options
 #
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_FW_LOADER is not set
 
 #
@@ -165,7 +167,6 @@
 #
 # IEEE 1394 (FireWire) support
 #
-# CONFIG_IEEE1394 is not set
 
 #
 # I2O device support
@@ -217,13 +218,13 @@
 # CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-# CONFIG_NET_FASTROUTE is not set
 # CONFIG_NET_HW_FLOWCONTROL is not set
 
 #
 # QoS and/or fair queueing
 #
 # CONFIG_NET_SCHED is not set
+# CONFIG_NET_CLS_ROUTE is not set
 
 #
 # Network testing
@@ -266,7 +267,7 @@
 # CONFIG_GAMEPORT is not set
 CONFIG_SOUND_GAMEPORT=y
 CONFIG_SERIO=y
-CONFIG_SERIO_I8042=y
+# CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_CT82C710 is not set
 
@@ -316,12 +317,10 @@
 # CONFIG_GEN_RTC is not set
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
-# CONFIG_APPLICOM is not set
 
 #
 # Ftape, the floppy tape device driver
 #
-# CONFIG_FTAPE is not set
 # CONFIG_AGP is not set
 # CONFIG_DRM is not set
 # CONFIG_RAW_DRIVER is not set
@@ -332,6 +331,11 @@
 # CONFIG_I2C is not set
 
 #
+# Dallas's 1-wire bus
+#
+# CONFIG_W1 is not set
+
+#
 # Misc devices
 #
 
@@ -389,7 +393,8 @@
 #
 # DOS/FAT/NT Filesystems
 #
-# CONFIG_FAT_FS is not set
+# CONFIG_MSDOS_FS is not set
+# CONFIG_VFAT_FS is not set
 # CONFIG_NTFS_FS is not set
 
 #
@@ -478,6 +483,7 @@
 # CONFIG_NLS_ISO8859_8 is not set
 # CONFIG_NLS_CODEPAGE_1250 is not set
 # CONFIG_NLS_CODEPAGE_1251 is not set
+# CONFIG_NLS_ASCII is not set
 # CONFIG_NLS_ISO8859_1 is not set
 # CONFIG_NLS_ISO8859_2 is not set
 # CONFIG_NLS_ISO8859_3 is not set
@@ -518,5 +524,6 @@
 #
 # Library routines
 #
+# CONFIG_CRC_CCITT is not set
 CONFIG_CRC32=y
 # CONFIG_LIBCRC32C is not set
diff -ruN linux-2.6.7_20040830/arch/m32r/mappi/defconfig.smp linux-2.6.8.1/arch/m32r/mappi/defconfig.smp
--- linux-2.6.7_20040830/arch/m32r/mappi/defconfig.smp	2004-07-15 13:43:14.000000000 +0900
+++ linux-2.6.8.1/arch/m32r/mappi/defconfig.smp	2004-08-30 10:23:54.000000000 +0900
@@ -10,7 +10,6 @@
 #
 CONFIG_EXPERIMENTAL=y
 # CONFIG_CLEAN_COMPILE is not set
-# CONFIG_STANDALONE is not set
 CONFIG_BROKEN=y
 CONFIG_BROKEN_ON_SMP=y
 
@@ -54,6 +53,7 @@
 CONFIG_PLAT_MAPPI=y
 # CONFIG_PLAT_USRV is not set
 # CONFIG_PLAT_M32700UT is not set
+# CONFIG_PLAT_OPSPUT is not set
 # CONFIG_PLAT_OAKS32R is not set
 # CONFIG_PLAT_MAPPI2 is not set
 CONFIG_CHIP_M32700=y
@@ -124,6 +124,8 @@
 #
 # Generic Driver Options
 #
+# CONFIG_STANDALONE is not set
+CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_FW_LOADER is not set
 
 #
@@ -134,6 +136,8 @@
 CONFIG_MTD_PARTITIONS=y
 # CONFIG_MTD_CONCAT is not set
 CONFIG_MTD_REDBOOT_PARTS=y
+# CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
+# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
 # CONFIG_MTD_CMDLINE_PARTS is not set
 
 #
@@ -150,6 +154,16 @@
 #
 # CONFIG_MTD_CFI is not set
 # CONFIG_MTD_JEDECPROBE is not set
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+# CONFIG_MTD_CFI_I4 is not set
+# CONFIG_MTD_CFI_I8 is not set
 # CONFIG_MTD_RAM is not set
 # CONFIG_MTD_ROM is not set
 # CONFIG_MTD_ABSENT is not set
@@ -164,6 +178,7 @@
 # Self-contained MTD device drivers
 #
 # CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PHRAM is not set
 # CONFIG_MTD_MTDRAM is not set
 # CONFIG_MTD_BLKMTD is not set
 
@@ -208,6 +223,7 @@
 #
 # Please see Documentation/ide.txt for help/info on IDE drives
 #
+# CONFIG_BLK_DEV_IDE_SATA is not set
 CONFIG_BLK_DEV_IDEDISK=m
 # CONFIG_IDEDISK_MULTI_MODE is not set
 CONFIG_BLK_DEV_IDECS=m
@@ -294,13 +310,13 @@
 # CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-# CONFIG_NET_FASTROUTE is not set
 # CONFIG_NET_HW_FLOWCONTROL is not set
 
 #
 # QoS and/or fair queueing
 #
 # CONFIG_NET_SCHED is not set
+# CONFIG_NET_CLS_ROUTE is not set
 
 #
 # Network testing
@@ -396,12 +412,10 @@
 # CONFIG_GEN_RTC is not set
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
-# CONFIG_APPLICOM is not set
 
 #
 # Ftape, the floppy tape device driver
 #
-# CONFIG_FTAPE is not set
 # CONFIG_AGP is not set
 # CONFIG_DRM is not set
 
@@ -417,6 +431,11 @@
 # CONFIG_I2C is not set
 
 #
+# Dallas's 1-wire bus
+#
+# CONFIG_W1 is not set
+
+#
 # Misc devices
 #
 
@@ -476,9 +495,11 @@
 #
 # DOS/FAT/NT Filesystems
 #
-CONFIG_FAT_FS=y
+CONFIG_FAT_FS=m
 CONFIG_MSDOS_FS=m
 CONFIG_VFAT_FS=m
+CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
 # CONFIG_NTFS_FS is not set
 
 #
@@ -508,9 +529,14 @@
 # CONFIG_EFS_FS is not set
 CONFIG_JFFS_FS=y
 CONFIG_JFFS_FS_VERBOSE=0
+CONFIG_JFFS_PROC_FS=y
 CONFIG_JFFS2_FS=y
 CONFIG_JFFS2_FS_DEBUG=0
 # CONFIG_JFFS2_FS_NAND is not set
+# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
+CONFIG_JFFS2_ZLIB=y
+CONFIG_JFFS2_RTIME=y
+# CONFIG_JFFS2_RUBIN is not set
 # CONFIG_CRAMFS is not set
 # CONFIG_VXFS_FS is not set
 # CONFIG_HPFS_FS is not set
@@ -572,6 +598,7 @@
 # CONFIG_NLS_ISO8859_8 is not set
 # CONFIG_NLS_CODEPAGE_1250 is not set
 # CONFIG_NLS_CODEPAGE_1251 is not set
+# CONFIG_NLS_ASCII is not set
 # CONFIG_NLS_ISO8859_1 is not set
 # CONFIG_NLS_ISO8859_2 is not set
 # CONFIG_NLS_ISO8859_3 is not set
@@ -612,6 +639,7 @@
 #
 # Library routines
 #
+# CONFIG_CRC_CCITT is not set
 CONFIG_CRC32=y
 # CONFIG_LIBCRC32C is not set
 CONFIG_ZLIB_INFLATE=y
diff -ruN linux-2.6.7_20040830/arch/m32r/mappi/defconfig.up linux-2.6.8.1/arch/m32r/mappi/defconfig.up
--- linux-2.6.7_20040830/arch/m32r/mappi/defconfig.up	2004-07-15 13:43:14.000000000 +0900
+++ linux-2.6.8.1/arch/m32r/mappi/defconfig.up	2004-08-30 10:23:54.000000000 +0900
@@ -10,7 +10,6 @@
 #
 CONFIG_EXPERIMENTAL=y
 # CONFIG_CLEAN_COMPILE is not set
-# CONFIG_STANDALONE is not set
 CONFIG_BROKEN=y
 CONFIG_BROKEN_ON_SMP=y
 
@@ -53,6 +52,7 @@
 CONFIG_PLAT_MAPPI=y
 # CONFIG_PLAT_USRV is not set
 # CONFIG_PLAT_M32700UT is not set
+# CONFIG_PLAT_OPSPUT is not set
 # CONFIG_PLAT_OAKS32R is not set
 # CONFIG_PLAT_MAPPI2 is not set
 CONFIG_CHIP_M32700=y
@@ -120,6 +120,8 @@
 #
 # Generic Driver Options
 #
+# CONFIG_STANDALONE is not set
+CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_FW_LOADER is not set
 
 #
@@ -130,6 +132,8 @@
 CONFIG_MTD_PARTITIONS=y
 # CONFIG_MTD_CONCAT is not set
 CONFIG_MTD_REDBOOT_PARTS=y
+# CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
+# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
 # CONFIG_MTD_CMDLINE_PARTS is not set
 
 #
@@ -146,6 +150,16 @@
 #
 # CONFIG_MTD_CFI is not set
 # CONFIG_MTD_JEDECPROBE is not set
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+# CONFIG_MTD_CFI_I4 is not set
+# CONFIG_MTD_CFI_I8 is not set
 # CONFIG_MTD_RAM is not set
 # CONFIG_MTD_ROM is not set
 # CONFIG_MTD_ABSENT is not set
@@ -160,6 +174,7 @@
 # Self-contained MTD device drivers
 #
 # CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PHRAM is not set
 # CONFIG_MTD_MTDRAM is not set
 # CONFIG_MTD_BLKMTD is not set
 
@@ -204,6 +219,7 @@
 #
 # Please see Documentation/ide.txt for help/info on IDE drives
 #
+# CONFIG_BLK_DEV_IDE_SATA is not set
 CONFIG_BLK_DEV_IDEDISK=m
 # CONFIG_IDEDISK_MULTI_MODE is not set
 CONFIG_BLK_DEV_IDECS=m
@@ -290,13 +306,13 @@
 # CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-# CONFIG_NET_FASTROUTE is not set
 # CONFIG_NET_HW_FLOWCONTROL is not set
 
 #
 # QoS and/or fair queueing
 #
 # CONFIG_NET_SCHED is not set
+# CONFIG_NET_CLS_ROUTE is not set
 
 #
 # Network testing
@@ -392,12 +408,10 @@
 # CONFIG_GEN_RTC is not set
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
-# CONFIG_APPLICOM is not set
 
 #
 # Ftape, the floppy tape device driver
 #
-# CONFIG_FTAPE is not set
 # CONFIG_AGP is not set
 # CONFIG_DRM is not set
 
@@ -413,6 +427,11 @@
 # CONFIG_I2C is not set
 
 #
+# Dallas's 1-wire bus
+#
+# CONFIG_W1 is not set
+
+#
 # Misc devices
 #
 
@@ -472,9 +491,11 @@
 #
 # DOS/FAT/NT Filesystems
 #
-CONFIG_FAT_FS=y
+CONFIG_FAT_FS=m
 CONFIG_MSDOS_FS=m
 CONFIG_VFAT_FS=m
+CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
 # CONFIG_NTFS_FS is not set
 
 #
@@ -504,9 +525,14 @@
 # CONFIG_EFS_FS is not set
 CONFIG_JFFS_FS=y
 CONFIG_JFFS_FS_VERBOSE=0
+CONFIG_JFFS_PROC_FS=y
 CONFIG_JFFS2_FS=y
 CONFIG_JFFS2_FS_DEBUG=0
 # CONFIG_JFFS2_FS_NAND is not set
+# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
+CONFIG_JFFS2_ZLIB=y
+CONFIG_JFFS2_RTIME=y
+# CONFIG_JFFS2_RUBIN is not set
 # CONFIG_CRAMFS is not set
 # CONFIG_VXFS_FS is not set
 # CONFIG_HPFS_FS is not set
@@ -568,6 +594,7 @@
 # CONFIG_NLS_ISO8859_8 is not set
 # CONFIG_NLS_CODEPAGE_1250 is not set
 # CONFIG_NLS_CODEPAGE_1251 is not set
+# CONFIG_NLS_ASCII is not set
 # CONFIG_NLS_ISO8859_1 is not set
 # CONFIG_NLS_ISO8859_2 is not set
 # CONFIG_NLS_ISO8859_3 is not set
@@ -608,6 +635,7 @@
 #
 # Library routines
 #
+# CONFIG_CRC_CCITT is not set
 CONFIG_CRC32=y
 # CONFIG_LIBCRC32C is not set
 CONFIG_ZLIB_INFLATE=y
diff -ruN linux-2.6.7_20040830/arch/m32r/mm/fault.c linux-2.6.8.1/arch/m32r/mm/fault.c
--- linux-2.6.7_20040830/arch/m32r/mm/fault.c	2004-07-27 15:54:20.000000000 +0900
+++ linux-2.6.8.1/arch/m32r/mm/fault.c	2004-08-30 10:23:54.000000000 +0900
@@ -31,7 +31,6 @@
 #include <asm/m32r.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
-#include <asm/pgalloc.h>
 #include <asm/hardirq.h>
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
@@ -142,7 +141,27 @@
 	if (in_atomic() || !mm)
 		goto bad_area_nosemaphore;
 
-	down_read(&mm->mmap_sem);
+	/* When running in the kernel we expect faults to occur only to
+	 * addresses in user space.  All other faults represent errors in the
+	 * kernel and should generate an OOPS.  Unfortunatly, in the case of an
+	 * erroneous fault occuring in a code path which already holds mmap_sem
+	 * we will deadlock attempting to validate the fault against the
+	 * address space.  Luckily the kernel only validly references user
+	 * space from well defined areas of code, which are listed in the
+	 * exceptions table.
+	 *
+	 * As the vast majority of faults will be valid we will only perform
+	 * the source reference check when there is a possibilty of a deadlock.
+	 * Attempt to lock the address space, if we cannot we then validate the
+	 * source.  If this is invalid we can skip the address space check,
+	 * thus avoiding the deadlock.
+	 */
+	if (!down_read_trylock(&mm->mmap_sem)) {
+		if ((error_code & 4) == 0 &&
+		    !search_exception_tables(regs->psw))
+			goto bad_area_nosemaphore;
+		down_read(&mm->mmap_sem);
+	}
 
 	vma = find_vma(mm, address);
 	if (!vma)
@@ -227,7 +246,7 @@
 		info.si_signo = SIGSEGV;
 		info.si_errno = 0;
 		/* info.si_code has been set above */
-		info.si_addr = (void *)address;
+		info.si_addr = (void __user *)address;
 		force_sig_info(SIGSEGV, &info, tsk);
 		return;
 	}
@@ -293,7 +312,7 @@
 	info.si_signo = SIGBUS;
 	info.si_errno = 0;
 	info.si_code = BUS_ADRERR;
-	info.si_addr = (void *)address;
+	info.si_addr = (void __user *)address;
 	force_sig_info(SIGBUS, &info, tsk);
 	return;
 
@@ -364,24 +383,24 @@
 
 #ifdef CONFIG_CHIP_OPSP
 	entry1 = (unsigned long *)ITLB_BASE;
-        for(i = 0 ; i < NR_TLB_ENTRIES; i++) {
-                if(*entry1++ == vaddr) {
-                        pte_data = pte_val(pte);
-                        set_tlb_data(entry1, pte_data);
-                        break;
-                }
-                entry1++;
-        }
-        entry2 = (unsigned long *)DTLB_BASE;
-        for(i = 0 ; i < NR_TLB_ENTRIES ; i++) {
-                if(*entry2++ == vaddr) {
-                        pte_data = pte_val(pte);
-                        set_tlb_data(entry2, pte_data);
-                        break;
-                }
-                entry2++;
-        }
-        local_irq_restore(flags);
+	for(i = 0 ; i < NR_TLB_ENTRIES; i++) {
+	        if(*entry1++ == vaddr) {
+	                pte_data = pte_val(pte);
+	                set_tlb_data(entry1, pte_data);
+	                break;
+	        }
+	        entry1++;
+	}
+	entry2 = (unsigned long *)DTLB_BASE;
+	for(i = 0 ; i < NR_TLB_ENTRIES ; i++) {
+	        if(*entry2++ == vaddr) {
+	                pte_data = pte_val(pte);
+	                set_tlb_data(entry2, pte_data);
+	                break;
+	        }
+	        entry2++;
+	}
+	local_irq_restore(flags);
 	return;
 #else
 	pte_data = pte_val(pte);
diff -ruN linux-2.6.7_20040830/arch/m32r/mm/init.c linux-2.6.8.1/arch/m32r/mm/init.c
--- linux-2.6.7_20040830/arch/m32r/mm/init.c	2004-07-08 17:44:48.000000000 +0900
+++ linux-2.6.8.1/arch/m32r/mm/init.c	2004-08-30 10:23:54.000000000 +0900
@@ -47,7 +47,7 @@
 
 	printk("Mem-info:\n");
 	show_free_areas();
-	printk("Free swap:       %6dkB\n",nr_swap_pages<<(PAGE_SHIFT-10));
+	printk("Free swap:       %6ldkB\n",nr_swap_pages<<(PAGE_SHIFT-10));
 	for_each_pgdat(pgdat) {
 		for (i = 0; i < pgdat->node_spanned_pages; ++i) {
 			page = pgdat->node_mem_map + i;
@@ -115,9 +115,9 @@
 		zones_size[ZONE_NORMAL] = low - max_dma;
 	}
 #else
-        zones_size[ZONE_DMA] = 0 >> PAGE_SHIFT;
-        zones_size[ZONE_NORMAL] = __MEMORY_SIZE >> PAGE_SHIFT;
-        start_pfn = __MEMORY_START >> PAGE_SHIFT;
+	zones_size[ZONE_DMA] = 0 >> PAGE_SHIFT;
+	zones_size[ZONE_NORMAL] = __MEMORY_SIZE >> PAGE_SHIFT;
+	start_pfn = __MEMORY_START >> PAGE_SHIFT;
 #endif /* CONFIG_MMU */
 
 	free_area_init_node(0, NODE_DATA(0), 0, zones_size, 
@@ -171,7 +171,7 @@
 	int codesize, reservedpages, datasize, initsize;
 	int nid;
 #ifndef CONFIG_MMU
-        extern unsigned long memory_end;
+	extern unsigned long memory_end;
 #endif
 
 	num_physpages = 0;
@@ -187,7 +187,7 @@
 #ifdef CONFIG_MMU
 	high_memory = (void *)__va(PFN_PHYS(MAX_LOW_PFN(0)));
 #else
-        high_memory = (void *)(memory_end & PAGE_MASK);
+	high_memory = (void *)(memory_end & PAGE_MASK);
 #endif /* CONFIG_MMU */
 
 	/* clear the zero-page */
diff -ruN linux-2.6.7_20040830/arch/m32r/oaks32r/defconfig.nommu linux-2.6.8.1/arch/m32r/oaks32r/defconfig.nommu
--- linux-2.6.7_20040830/arch/m32r/oaks32r/defconfig.nommu	2004-07-15 13:43:14.000000000 +0900
+++ linux-2.6.8.1/arch/m32r/oaks32r/defconfig.nommu	2004-08-30 10:23:54.000000000 +0900
@@ -10,15 +10,14 @@
 #
 CONFIG_EXPERIMENTAL=y
 CONFIG_CLEAN_COMPILE=y
-CONFIG_STANDALONE=y
 CONFIG_BROKEN_ON_SMP=y
 
 #
 # General setup
 #
-# CONFIG_SYSVIPC is not set
 # CONFIG_POSIX_MQUEUE is not set
 CONFIG_BSD_PROCESS_ACCT=y
+# CONFIG_BSD_PROCESS_ACCT_V3 is not set
 CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
 CONFIG_LOG_BUF_SHIFT=14
@@ -50,6 +49,7 @@
 # CONFIG_PLAT_MAPPI is not set
 # CONFIG_PLAT_USRV is not set
 # CONFIG_PLAT_M32700UT is not set
+# CONFIG_PLAT_OPSPUT is not set
 CONFIG_PLAT_OAKS32R=y
 # CONFIG_PLAT_MAPPI2 is not set
 # CONFIG_CHIP_M32700 is not set
@@ -110,6 +110,8 @@
 #
 # Generic Driver Options
 #
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_FW_LOADER is not set
 
 #
@@ -159,7 +161,6 @@
 #
 # IEEE 1394 (FireWire) support
 #
-# CONFIG_IEEE1394 is not set
 
 #
 # I2O device support
@@ -211,13 +212,13 @@
 # CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-# CONFIG_NET_FASTROUTE is not set
 # CONFIG_NET_HW_FLOWCONTROL is not set
 
 #
 # QoS and/or fair queueing
 #
 # CONFIG_NET_SCHED is not set
+# CONFIG_NET_CLS_ROUTE is not set
 
 #
 # Network testing
@@ -310,12 +311,10 @@
 # CONFIG_GEN_RTC is not set
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
-# CONFIG_APPLICOM is not set
 
 #
 # Ftape, the floppy tape device driver
 #
-# CONFIG_FTAPE is not set
 # CONFIG_AGP is not set
 # CONFIG_DRM is not set
 # CONFIG_RAW_DRIVER is not set
@@ -326,6 +325,11 @@
 # CONFIG_I2C is not set
 
 #
+# Dallas's 1-wire bus
+#
+# CONFIG_W1 is not set
+
+#
 # Misc devices
 #
 
@@ -383,7 +387,8 @@
 #
 # DOS/FAT/NT Filesystems
 #
-# CONFIG_FAT_FS is not set
+# CONFIG_MSDOS_FS is not set
+# CONFIG_VFAT_FS is not set
 # CONFIG_NTFS_FS is not set
 
 #
@@ -470,6 +475,7 @@
 # CONFIG_NLS_ISO8859_8 is not set
 # CONFIG_NLS_CODEPAGE_1250 is not set
 # CONFIG_NLS_CODEPAGE_1251 is not set
+# CONFIG_NLS_ASCII is not set
 # CONFIG_NLS_ISO8859_1 is not set
 # CONFIG_NLS_ISO8859_2 is not set
 # CONFIG_NLS_ISO8859_3 is not set
@@ -510,5 +516,6 @@
 #
 # Library routines
 #
+# CONFIG_CRC_CCITT is not set
 CONFIG_CRC32=y
 # CONFIG_LIBCRC32C is not set
diff -ruN linux-2.6.7_20040830/arch/m32r/opsput/defconfig.opsput linux-2.6.8.1/arch/m32r/opsput/defconfig.opsput
--- linux-2.6.7_20040830/arch/m32r/opsput/defconfig.opsput	2004-07-27 15:54:20.000000000 +0900
+++ linux-2.6.8.1/arch/m32r/opsput/defconfig.opsput	2004-08-30 10:23:55.000000000 +0900
@@ -10,7 +10,6 @@
 #
 CONFIG_EXPERIMENTAL=y
 CONFIG_CLEAN_COMPILE=y
-CONFIG_STANDALONE=y
 CONFIG_BROKEN_ON_SMP=y
 
 #
@@ -20,6 +19,7 @@
 CONFIG_SYSVIPC=y
 # CONFIG_POSIX_MQUEUE is not set
 CONFIG_BSD_PROCESS_ACCT=y
+# CONFIG_BSD_PROCESS_ACCT_V3 is not set
 CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
 CONFIG_LOG_BUF_SHIFT=14
@@ -81,6 +81,7 @@
 #
 # CONFIG_M32R_CFC is not set
 CONFIG_M32R_SMC91111=y
+CONFIG_M32700UT_DS1302=y
 
 #
 # Power management options (ACPI, APM)
@@ -117,6 +118,8 @@
 #
 # Generic Driver Options
 #
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_FW_LOADER is not set
 # CONFIG_DEBUG_DRIVER is not set
 
@@ -208,7 +211,6 @@
 #
 # IEEE 1394 (FireWire) support
 #
-# CONFIG_IEEE1394 is not set
 
 #
 # I2O device support
@@ -260,13 +262,13 @@
 # CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-# CONFIG_NET_FASTROUTE is not set
 # CONFIG_NET_HW_FLOWCONTROL is not set
 
 #
 # QoS and/or fair queueing
 #
 # CONFIG_NET_SCHED is not set
+# CONFIG_NET_CLS_ROUTE is not set
 
 #
 # Network testing
@@ -309,7 +311,7 @@
 # CONFIG_GAMEPORT is not set
 CONFIG_SOUND_GAMEPORT=y
 CONFIG_SERIO=y
-CONFIG_SERIO_I8042=y
+# CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_CT82C710 is not set
 
@@ -359,12 +361,10 @@
 # CONFIG_GEN_RTC is not set
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
-# CONFIG_APPLICOM is not set
 
 #
 # Ftape, the floppy tape device driver
 #
-# CONFIG_FTAPE is not set
 # CONFIG_AGP is not set
 # CONFIG_DRM is not set
 
@@ -380,6 +380,11 @@
 # CONFIG_I2C is not set
 
 #
+# Dallas's 1-wire bus
+#
+# CONFIG_W1 is not set
+
+#
 # Misc devices
 #
 
@@ -443,6 +448,7 @@
 CONFIG_JOLIET=y
 # CONFIG_ZISOFS is not set
 CONFIG_UDF_FS=m
+CONFIG_UDF_NLS=y
 
 #
 # DOS/FAT/NT Filesystems
@@ -450,6 +456,8 @@
 CONFIG_FAT_FS=m
 CONFIG_MSDOS_FS=m
 CONFIG_VFAT_FS=m
+CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
 # CONFIG_NTFS_FS is not set
 
 #
@@ -537,6 +545,7 @@
 # CONFIG_NLS_ISO8859_8 is not set
 # CONFIG_NLS_CODEPAGE_1250 is not set
 # CONFIG_NLS_CODEPAGE_1251 is not set
+# CONFIG_NLS_ASCII is not set
 # CONFIG_NLS_ISO8859_1 is not set
 # CONFIG_NLS_ISO8859_2 is not set
 # CONFIG_NLS_ISO8859_3 is not set
@@ -584,5 +593,6 @@
 #
 # Library routines
 #
+# CONFIG_CRC_CCITT is not set
 CONFIG_CRC32=y
 # CONFIG_LIBCRC32C is not set
diff -ruN linux-2.6.7_20040830/include/asm-m32r/bitops.h linux-2.6.8.1/include/asm-m32r/bitops.h
--- linux-2.6.7_20040830/include/asm-m32r/bitops.h	2004-05-19 18:53:48.000000000 +0900
+++ linux-2.6.8.1/include/asm-m32r/bitops.h	2004-08-30 10:24:11.000000000 +0900
@@ -54,7 +54,7 @@
 {
 	__u32 mask;
 	volatile __u32 *a = addr;
-        unsigned long  flags;
+	unsigned long  flags;
 
 	a += (nr >> 5);
 	mask = (1 << (nr & 0x1F));
@@ -108,7 +108,7 @@
 {
 	__u32 mask;
 	volatile __u32 *a = addr;
-        unsigned long  flags;
+	unsigned long  flags;
 
 	a += (nr >> 5);
 	mask = (1 << (nr & 0x1F));
@@ -175,8 +175,8 @@
 {
 	__u32  mask;
 	volatile __u32  *a = addr;
-        unsigned long  flags;
-	
+	unsigned long  flags;
+
 	a += (nr >> 5);
 	mask = (1 << (nr & 0x1F));
 
@@ -208,7 +208,7 @@
 {
 	__u32 mask, oldbit;
 	volatile __u32 *a = addr;
-        unsigned long  flags;
+	unsigned long  flags;
 
 	a += (nr >> 5);
 	mask = (1 << (nr & 0x1F));
@@ -263,7 +263,7 @@
 {
 	__u32 mask, oldbit;
 	volatile __u32 *a = addr;
-        unsigned long  flags;
+	unsigned long  flags;
 
 	a += (nr >> 5);
 	mask = (1 << (nr & 0x1F));
@@ -273,10 +273,10 @@
 	__asm__ __volatile__ (
 		DCACHE_CLEAR("%0", "r4", "%2")
 		LOAD"	%0, @%2;		\n\t"
-                "mv      r4, %0; \n\t"
-                "and     %0, %1; \n\t"
-                "not     %1, %1; \n\t"
-                "and     r4, %1; \n\t"
+		"mv      r4, %0; \n\t"
+		"and     %0, %1; \n\t"
+		"not     %1, %1; \n\t"
+		"and     r4, %1; \n\t"
 		STORE"	r4, @%2;		\n\t"
 		: "=&r" (oldbit), "+r" (mask)
 		: "r" (a)
@@ -335,7 +335,7 @@
 {
 	__u32 mask, oldbit;
 	volatile __u32 *a = addr;
-        unsigned long  flags;
+	unsigned long  flags;
 
 	a += (nr >> 5);
 	mask = (1 << (nr & 0x1F));
@@ -407,7 +407,7 @@
  */
 
 #define find_first_zero_bit(addr, size) \
-        find_next_zero_bit((addr), (size), 0)
+	find_next_zero_bit((addr), (size), 0)
 
 /**
  * find_next_zero_bit - find the first zero bit in a memory region
@@ -502,7 +502,7 @@
  * @offset: The bitnumber to start searching at
  * @size: The maximum size to search
  */
-static __inline__ unsigned long find_next_bit(unsigned long *addr,
+static __inline__ unsigned long find_next_bit(const unsigned long *addr,
 	unsigned long size, unsigned long offset)
 {
 	unsigned int *p = ((unsigned int *) addr) + (offset >> 5);
diff -ruN linux-2.6.7_20040830/include/asm-m32r/checksum.h linux-2.6.8.1/include/asm-m32r/checksum.h
--- linux-2.6.7_20040830/include/asm-m32r/checksum.h	2004-07-15 13:43:17.000000000 +0900
+++ linux-2.6.8.1/include/asm-m32r/checksum.h	2004-08-30 10:24:11.000000000 +0900
@@ -11,6 +11,8 @@
  *    Copyright (C) 2001, 2002  Hiroyuki Kondo, Hirokazu Takata
  */
 
+#include <linux/in6.h>
+
 /*
  * computes the checksum of a memory block at buff, length len,
  * and adds in "sum" (32-bit)
@@ -232,7 +234,7 @@
 		: "r" (saddr), "r" (daddr), 
 		  "r" (htonl((__u32) (len))), "r" (htonl(proto)), "0" (sum)
 		: "cbit"
-        );
+	);
 
 	return csum_fold(sum);
 }
diff -ruN linux-2.6.7_20040830/include/asm-m32r/cpumask.h linux-2.6.8.1/include/asm-m32r/cpumask.h
--- linux-2.6.7_20040830/include/asm-m32r/cpumask.h	2004-03-25 13:29:22.000000000 +0900
+++ linux-2.6.8.1/include/asm-m32r/cpumask.h	1970-01-01 09:00:00.000000000 +0900
@@ -1,7 +0,0 @@
-#ifndef _ASM_M32R_CPUMASK_H
-#define _ASM_M32R_CPUMASK_H
-
-#include <asm-generic/cpumask.h>
-
-#endif /* _ASM_M32R_CPUMASK_H */
-
diff -ruN linux-2.6.7_20040830/include/asm-m32r/delay.h linux-2.6.8.1/include/asm-m32r/delay.h
--- linux-2.6.7_20040830/include/asm-m32r/delay.h	2004-08-19 16:07:18.000000000 +0900
+++ linux-2.6.8.1/include/asm-m32r/delay.h	2004-08-30 10:24:11.000000000 +0900
@@ -10,13 +10,19 @@
  */
 
 extern void __bad_udelay(void);
+extern void __bad_ndelay(void);
 
 extern void __udelay(unsigned long usecs);
+extern void __ndelay(unsigned long nsecs);
 extern void __const_udelay(unsigned long usecs);
 extern void __delay(unsigned long loops);
 
 #define udelay(n) (__builtin_constant_p(n) ? \
-	((n) > 20000 ? __bad_udelay() : __const_udelay((n) * 4294UL)) : \
+	((n) > 20000 ? __bad_udelay() : __const_udelay((n) * 0x10c7ul)) : \
 	__udelay(n))
 
+#define ndelay(n) (__builtin_constant_p(n) ? \
+	((n) > 20000 ? __bad_ndelay() : __const_udelay((n) * 5ul)) : \
+	__ndelay(n))
+
 #endif /* _ASM_M32R_DELAY_H */
diff -ruN linux-2.6.7_20040830/include/asm-m32r/fcntl.h linux-2.6.8.1/include/asm-m32r/fcntl.h
--- linux-2.6.7_20040830/include/asm-m32r/fcntl.h	2003-09-09 10:16:45.000000000 +0900
+++ linux-2.6.8.1/include/asm-m32r/fcntl.h	2004-08-30 10:24:11.000000000 +0900
@@ -24,6 +24,7 @@
 #define O_LARGEFILE	0100000
 #define O_DIRECTORY	0200000	/* must be a directory */
 #define O_NOFOLLOW	0400000 /* don't follow links */
+#define O_NOATIME	01000000
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
diff -ruN linux-2.6.7_20040830/include/asm-m32r/init.h linux-2.6.8.1/include/asm-m32r/init.h
--- linux-2.6.7_20040830/include/asm-m32r/init.h	2003-09-09 10:16:45.000000000 +0900
+++ linux-2.6.8.1/include/asm-m32r/init.h	1970-01-01 09:00:00.000000000 +0900
@@ -1 +0,0 @@
-#error "<asm/init.h> should never be used - use <linux/init.h> instead"
diff -ruN linux-2.6.7_20040830/include/asm-m32r/resource.h linux-2.6.8.1/include/asm-m32r/resource.h
--- linux-2.6.7_20040830/include/asm-m32r/resource.h	2003-09-09 10:16:45.000000000 +0900
+++ linux-2.6.8.1/include/asm-m32r/resource.h	2004-08-30 10:24:11.000000000 +0900
@@ -20,8 +20,10 @@
 #define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_SIGPENDING 11		/* max number of pending signals */
+#define RLIMIT_MSGQUEUE	12		/* maximum bytes in POSIX mqueues */
 
-#define RLIM_NLIMITS	11
+#define RLIM_NLIMITS	13
 
 /*
  * SuS says limits have to be unsigned.
@@ -43,7 +45,9 @@
 	{      INR_OPEN,     INR_OPEN  },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
-        { RLIM_INFINITY, RLIM_INFINITY },		\
+	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
+	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
 }
 
 #endif /* __KERNEL__ */
diff -ruN linux-2.6.7_20040830/include/asm-m32r/setup.h linux-2.6.8.1/include/asm-m32r/setup.h
--- linux-2.6.7_20040830/include/asm-m32r/setup.h	2003-09-09 10:28:57.000000000 +0900
+++ linux-2.6.8.1/include/asm-m32r/setup.h	2004-08-30 10:24:11.000000000 +0900
@@ -18,7 +18,7 @@
 
 #define SCREEN_INFO		(*(struct screen_info *) (PARAM+0x200))
 
-#define COMMAND_LINE_SIZE	(256)
+#define COMMAND_LINE_SIZE	(512)
 
 #define RAMDISK_IMAGE_START_MASK	(0x07FF)
 #define RAMDISK_PROMPT_FLAG		(0x8000)
diff -ruN linux-2.6.7_20040830/include/asm-m32r/signal.h linux-2.6.8.1/include/asm-m32r/signal.h
--- linux-2.6.7_20040830/include/asm-m32r/signal.h	2003-10-01 11:48:18.000000000 +0900
+++ linux-2.6.8.1/include/asm-m32r/signal.h	2004-08-30 10:24:11.000000000 +0900
@@ -5,8 +5,10 @@
 
 /* orig : i386 2.4.18 */
 
-#include <linux/linkage.h>
 #include <linux/types.h>
+#include <linux/linkage.h>
+#include <linux/time.h>
+#include <linux/compiler.h>
 
 /* Avoid too many header ordering problems.  */
 struct siginfo;
@@ -131,7 +133,11 @@
 #define SIG_SETMASK        2	/* for setting the signal mask */
 
 /* Type of a signal handler.  */
-typedef void (*__sighandler_t)(int);
+typedef void __signalfn_t(int);
+typedef __signalfn_t __user *__sighandler_t;
+
+typedef void __restorefn_t(void);
+typedef __restorefn_t __user *__sigrestore_t;
 
 #define SIG_DFL	((__sighandler_t)0)	/* default signal handling */
 #define SIG_IGN	((__sighandler_t)1)	/* ignore signal */
@@ -142,13 +148,13 @@
 	__sighandler_t sa_handler;
 	old_sigset_t sa_mask;
 	unsigned long sa_flags;
-	void (*sa_restorer)(void);
+	__sigrestore_t sa_restorer;
 };
 
 struct sigaction {
 	__sighandler_t sa_handler;
 	unsigned long sa_flags;
-	void (*sa_restorer)(void);
+	__sigrestore_t sa_restorer;
 	sigset_t sa_mask;		/* mask last for extensibility */
 };
 
@@ -174,7 +180,7 @@
 #endif /* __KERNEL__ */
 
 typedef struct sigaltstack {
-	void *ss_sp;
+	void __user *ss_sp;
 	int ss_flags;
 	size_t ss_size;
 } stack_t;
diff -ruN linux-2.6.7_20040830/include/asm-m32r/smp.h linux-2.6.8.1/include/asm-m32r/smp.h
--- linux-2.6.7_20040830/include/asm-m32r/smp.h	2004-04-05 11:34:33.000000000 +0900
+++ linux-2.6.8.1/include/asm-m32r/smp.h	2004-08-30 10:24:11.000000000 +0900
@@ -13,7 +13,49 @@
 #include <linux/threads.h>
 #include <asm/m32r.h>
 
-extern cpumask_t phys_cpu_present_map;
+#define PHYSID_ARRAY_SIZE       1
+
+struct physid_mask
+{
+	unsigned long mask[PHYSID_ARRAY_SIZE];
+};
+
+typedef struct physid_mask physid_mask_t;
+
+#define physid_set(physid, map)                 set_bit(physid, (map).mask)
+#define physid_clear(physid, map)               clear_bit(physid, (map).mask)
+#define physid_isset(physid, map)               test_bit(physid, (map).mask)
+#define physid_test_and_set(physid, map)        test_and_set_bit(physid, (map).mask)
+
+#define physids_and(dst, src1, src2)            bitmap_and((dst).mask, (src1).mask, (src2).mask, MAX_APICS)
+#define physids_or(dst, src1, src2)             bitmap_or((dst).mask, (src1).mask, (src2).mask, MAX_APICS)
+#define physids_clear(map)                      bitmap_zero((map).mask, MAX_APICS)
+#define physids_complement(dst, src)            bitmap_complement((dst).mask,(src).mask, MAX_APICS)
+#define physids_empty(map)                      bitmap_empty((map).mask, MAX_APICS)
+#define physids_equal(map1, map2)               bitmap_equal((map1).mask, (map2).mask, MAX_APICS)
+#define physids_weight(map)                     bitmap_weight((map).mask, MAX_APICS)
+#define physids_shift_right(d, s, n)            bitmap_shift_right((d).mask, (s).mask, n, MAX_APICS)
+#define physids_shift_left(d, s, n)             bitmap_shift_left((d).mask, (s).mask, n, MAX_APICS)
+#define physids_coerce(map)                     ((map).mask[0])
+
+#define physids_promote(physids)					\
+	({								\
+		physid_mask_t __physid_mask = PHYSID_MASK_NONE;		\
+		__physid_mask.mask[0] = physids;			\
+		__physid_mask;						\
+	})
+
+#define physid_mask_of_physid(physid)					\
+	({								\
+		physid_mask_t __physid_mask = PHYSID_MASK_NONE;		\
+		physid_set(physid, __physid_mask);			\
+		__physid_mask;						\
+	})
+
+#define PHYSID_MASK_ALL         { {[0 ... PHYSID_ARRAY_SIZE-1] = ~0UL} }
+#define PHYSID_MASK_NONE        { {[0 ... PHYSID_ARRAY_SIZE-1] = 0UL} }
+
+extern physid_mask_t phys_cpu_present_map;
 
 /*
  * Some lowlevel functions might want to know about
@@ -51,7 +93,7 @@
 
 extern void smp_send_timer(void);
 extern void calibrate_delay(void);
-extern unsigned long send_IPI_mask_phys(unsigned long, int, int);
+extern unsigned long send_IPI_mask_phys(cpumask_t, int, int);
 
 #endif	/* not __ASSEMBLY__ */
 
@@ -75,4 +117,3 @@
 #endif	/* CONFIG_SMP */
 
 #endif	/* _ASM_M32R_SMP_H */
-
diff -ruN linux-2.6.7_20040830/include/asm-m32r/uaccess.h linux-2.6.8.1/include/asm-m32r/uaccess.h
--- linux-2.6.7_20040830/include/asm-m32r/uaccess.h	2004-08-24 12:22:53.000000000 +0900
+++ linux-2.6.8.1/include/asm-m32r/uaccess.h	2004-08-30 10:24:11.000000000 +0900
@@ -201,12 +201,12 @@
 #define __put_user_check(x,ptr,size)					\
 ({									\
 	long __pu_err = -EFAULT;					\
-	__typeof__(*(ptr)) *__pu_addr = (ptr);				\
+	__typeof__(*(ptr)) __user *__pu_addr = (ptr);			\
 	might_sleep();							\
 	if (access_ok(VERIFY_WRITE,__pu_addr,size))			\
 		__put_user_size((x),__pu_addr,(size),__pu_err);		\
 	__pu_err;							\
-})							
+})
 
 #define __put_user_size(x,ptr,size,retval)				\
 do {									\
diff -ruN linux-2.6.7_20040830/include/asm-m32r/unistd.h linux-2.6.8.1/include/asm-m32r/unistd.h
--- linux-2.6.7_20040830/include/asm-m32r/unistd.h	2004-07-15 13:43:17.000000000 +0900
+++ linux-2.6.8.1/include/asm-m32r/unistd.h	2004-08-30 10:24:11.000000000 +0900
@@ -293,7 +293,7 @@
 #define __NR_mq_notify          (__NR_mq_open+4)
 #define __NR_mq_getsetattr      (__NR_mq_open+5)
 #define __NR_kexec_load		283
- 
+
 #define NR_syscalls     284
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-m32r/errno.h> */
@@ -302,10 +302,10 @@
 do { \
 	if ((unsigned long)(res) >= (unsigned long)(-125)) { \
 	/* Avoid using "res" which is declared to be in register r0; \
-           errno might expand to a function call and clobber it.  */ \
-                int __err = -(res); \
-                errno = __err; \
-                res = -1; \
+	   errno might expand to a function call and clobber it.  */ \
+		int __err = -(res); \
+		errno = __err; \
+		res = -1; \
 	} \
 	return (type) (res); \
 } while (0)
@@ -384,7 +384,7 @@
 }
 
 #define _syscall5(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4, \
-          type5,arg5) \
+	type5,arg5) \
 type name(type1 arg1,type2 arg2,type3 arg3,type4 arg4,type5 arg5) \
 { \
 register long __scno __asm__ ("r7") = __NR_##name; \
@@ -446,15 +446,7 @@
  * won't be any messing with the stack from main(), but we define
  * some others too.
  */
-static __inline__ _syscall0(pid_t,setsid)
-static __inline__ _syscall3(int,write,int,fd,const char *,buf,off_t,count)
-static __inline__ _syscall3(int,read,int,fd,char *,buf,off_t,count)
-static __inline__ _syscall3(off_t,lseek,int,fd,off_t,offset,int,count)
-static __inline__ _syscall1(int,dup,int,fd)
 static __inline__ _syscall3(int,execve,const char *,file,char **,argv,char **,envp)
-static __inline__ _syscall3(int,open,const char *,file,int,flag,int,mode)
-static __inline__ _syscall1(int,close,int,fd)
-static __inline__ _syscall3(pid_t,waitpid,pid_t,pid,int *,wait_stat,int,options)
 
 asmlinkage int sys_modify_ldt(int func, void __user *ptr, unsigned long bytecount);
 asmlinkage long sys_mmap2(unsigned long addr, unsigned long len,


--
Hirokazu Takata
Linux/M32R Project: http://www.linux-m32r.org/
