Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752538AbWAFUXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752538AbWAFUXa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 15:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752539AbWAFUXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 15:23:30 -0500
Received: from mailhub4.stratus.com ([134.111.1.17]:42207 "EHLO
	mailhub4.stratus.com") by vger.kernel.org with ESMTP
	id S1752538AbWAFUX3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 15:23:29 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: (2nd try) [PATCH] corruption during e100 MDI register access
Date: Fri, 6 Jan 2006 15:22:32 -0500
Message-ID: <92952AEF1F064042B6EF2522E0EEF43703225312@EXNA.corp.stratus.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: (2nd try) [PATCH] corruption during e100 MDI register access
Thread-Index: AcYS/ux5gb+NR6LtQKSq2jjIRQLWWw==
From: "ODonnell, Michael" <Michael.ODonnell@stratus.com>
To: <adapter_support@intel.com>
Cc: <bonding-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
       <linux-netdev@lists.sourceforge.net>
X-OriginalArrivalTime: 06 Jan 2006 20:22:33.0244 (UTC) FILETIME=[ECEAC5C0:01C612FE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 [ 2nd transmission.  Microsoft mailer "helpfully"
   reformatted the patch in the last one... :-(    ]

Greetings,

We have identified two related bugs in the e100 driver and we request
that they be repaired in the official Intel version of the driver.

Both bugs are related to manipulation of the MDI control register.

The first problem is that the Ready bit is being ignored when
writing to the Control register; we noticed this because the Linux
bonding driver would occasionally come to the spurious conclusion
that the link was down when querying Link State.  It turned out
that by failing to wait for a previous command to complete it was
selecting what was essentially a random register in the MDI register
set.  When we added code that waits for the Ready bit (as shown in
the patch file below) all such problems ceased.

The second problem is that, although access to the MDI registers
involves multiple steps which must not be intermixed, nothing was
defending against two or more threads attempting simultaneous access.
The most obvious situation where such interference could occur
involves the watchdog versus ioctl paths, but there are probably
others, so we recommend the locking shown in our patch file.

Thanks,
  --Michael O'Donnell, Stratus Technologies, Maynard, MA  USA

Signed-off-by: Michael O'Donnell <Michael.ODonnell at stratus dot com>

--- drivers/net/e100.c.orig	2006-01-06 10:28:13.000000000 -0500
+++ drivers/net/e100.c	2006-01-06 10:51:57.000000000 -0500
@@ -125,20 +125,24 @@
  * 	not supported (hardware limitation).
  *
  * 	MagicPacket(tm) WoL support is enabled/disabled via ethtool.
  *
  * 	Thanks to JC (jchapman@katalix.com) for helping with
  * 	testing/troubleshooting the development driver.
  *
  * 	TODO:
  * 	o several entry points race with dev->close
  * 	o check for tx-no-resources/stop Q races with tx clean/wake Q
+ *
+ *	FIXES:
+ * 2005/12/02 - Michael O'Donnell <Michael.ODonnell at stratus dot com>
+ *	- Stratus87247: protect MDI control register manipulations
  */
 
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/init.h>
@@ -572,20 +577,21 @@ struct nic {
 	u32 rx_fc_pause;
 	u32 rx_fc_unsupported;
 	u32 rx_tco_frames;
 	u32 rx_over_length_errors;
 
 	u8 rev_id;
 	u16 leds;
 	u16 eeprom_wc;
 	u16 eeprom[256];
 	u32 pm_state[16];
+	spinlock_t mdio_lock;
 };
 
 static inline void e100_write_flush(struct nic *nic)
 {
 	/* Flush previous PCI writes through intermediate bridges
 	 * by doing a benign read */
 	(void)readb(&nic->csr->scb.status);
 }
 
 static inline void e100_enable_irq(struct nic *nic)
@@ -869,29 +894,49 @@ static inline int e100_exec_cb(struct ni
 err_unlock:
 	spin_unlock_irqrestore(&nic->cb_lock, flags);
 
 	return err;
 }
 
 static u16 mdio_ctrl(struct nic *nic, u32 addr, u32 dir, u32 reg, u16
data)
 {
 	u32 data_out = 0;
 	unsigned int i;
+	unsigned long flags;
+
 
+	/*
+	 * Stratus87247: we shouldn't be writing the MDI control
+	 * register until the Ready bit shows True.  Also, since
+	 * manipulation of the MDI control registers is a multi-step
+	 * procedure it should be done under lock.
+	 */
+	spin_lock_irqsave( &(nic->mdio_lock), flags );
+	for( i = 100;  i;  --i )  {
+		if( readl( &(nic->csr->mdi_ctrl) ) & mdi_ready )  {
+			break;
+		}
+		udelay( 20 );
+	}
+	if( unlikely( !i ) )  {
+		printk( "e100.mdio_ctrl(%s)won't go Ready\n",
nic->netdev->name );
+		spin_unlock_irqrestore( &(nic->mdio_lock), flags );
+		return( 0 );		/* No way to indicate timeout
error */
+	}
 	writel((reg << 16) | (addr << 21) | dir | data,
&nic->csr->mdi_ctrl);
 
 	for(i = 0; i < 100; i++) {
 		udelay(20);
 		if((data_out = readl(&nic->csr->mdi_ctrl)) & mdi_ready)
 			break;
 	}
-
+	spin_unlock_irqrestore( &(nic->mdio_lock), flags );
 	DPRINTK(HW, DEBUG,
 		"%s:addr=%d, reg=%d, data_in=0x%04X, data_out=0x%04X\n",
 		dir == mdi_read ? "READ" : "WRITE", addr, reg, data,
data_out);
 	return (u16)data_out;
 }
 
 static int mdio_read(struct net_device *netdev, int addr, int reg)
 {
 	return mdio_ctrl(netdev_priv(netdev), addr, mdi_read, reg, 0);
 }
@@ -2306,20 +2435,21 @@ static int __devinit e100_probe(struct p
 	if(ent->driver_data)
 		nic->flags |= ich;
 	else
 		nic->flags &= ~ich;
 
 	e100_get_defaults(nic);
 
 	/* locks must be initialized before calling hw_reset */
 	spin_lock_init(&nic->cb_lock);
 	spin_lock_init(&nic->cmd_lock);
+	spin_lock_init(&nic->mdio_lock);
 
 	/* Reset the device before pci_set_master() in case device is in
some
 	 * funky state and has an interrupt pending - hint: we don't
have the
 	 * interrupt handler registered yet. */
 	e100_hw_reset(nic);
 
 	pci_set_master(pdev);
 
 	init_timer(&nic->watchdog);
 	nic->watchdog.function = e100_watchdog;
