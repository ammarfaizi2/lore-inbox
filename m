Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbULMWR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbULMWR6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 17:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbULMWRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 17:17:40 -0500
Received: from h142-az.mvista.com ([65.200.49.142]:35992 "HELO
	xyzzy.farnsworth.org") by vger.kernel.org with SMTP id S261200AbULMWOd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 17:14:33 -0500
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Mon, 13 Dec 2004 15:14:31 -0700
To: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, Russell King <rmk@arm.linux.org.uk>,
       Manish Lachwani <mlachwani@mvista.com>,
       Brian Waite <brian@waitefamily.us>,
       "Steven J. Hill" <sjhill@realitydiluted.com>
Subject: [PATCH 2/6] mv643xx_eth: replace fixed-count spin delays
Message-ID: <20041213221431.GB19951@xyzzy>
References: <20041213220949.GA19609@xyzzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041213220949.GA19609@xyzzy>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes spin delays (count to 1000000, ugh) and instead waits
with udelay or msleep for hardware flags to change.

It also adds a spinlock to protect access to the MV64340_ETH_SMI_REG,
which is shared across ports.

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>

Index: linux-2.5-marvell-submit/drivers/net/mv643xx_eth.c
===================================================================
--- linux-2.5-marvell-submit.orig/drivers/net/mv643xx_eth.c	2004-12-13 14:29:54.292321344 -0700
+++ linux-2.5-marvell-submit/drivers/net/mv643xx_eth.c	2004-12-13 14:29:55.829024727 -0700
@@ -10,6 +10,9 @@
  *
  * Copyright (C) 2003 Ralf Baechle <ralf@linux-mips.org>
  *
+ * Copyright (C) 2004 MontaVista Software, Inc.
+ *                    Dale Farnsworth <dale@farnsworth.org>
+ *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
  * as published by the Free Software Foundation; either version 2
@@ -28,10 +31,12 @@
 #include <linux/tcp.h>
 #include <linux/etherdevice.h>
 #include <linux/bitops.h>
+#include <linux/delay.h>
 #include <asm/io.h>
 #include <asm/types.h>
 #include <asm/pgtable.h>
 #include <asm/system.h>
+#include <asm/delay.h>
 #include "mv643xx_eth.h"
 
 /*
@@ -66,6 +71,8 @@
 unsigned char prom_mac_addr_base[6];
 unsigned long mv64340_sram_base;
 
+static spinlock_t mv64340_eth_phy_lock = SPIN_LOCK_UNLOCKED;
+
 /*
  * Changes MTU (maximum transfer unit) of the gigabit ethenret port
  *
@@ -770,6 +777,7 @@
 	unsigned int port_num = mp->port_num;
 	u32 phy_reg_data;
 	unsigned int size;
+	int i;
 
 	/* Stop RX Queues */
 	MV_WRITE(MV64340_ETH_RECEIVE_QUEUE_COMMAND_REG(port_num),
@@ -864,12 +872,16 @@
 			(MV_READ(MV64340_ETH_PORT_SERIAL_CONTROL_REG(port_num))
 					& 0xfff1ffff));
 
-	/* Check Link status on phy */
-	eth_port_read_smi_reg(port_num, 1, &phy_reg_data);
-	if (!(phy_reg_data & 0x20))
-		netif_stop_queue(dev);
-	else
-		netif_start_queue(dev);
+	/* wait up to 1 second for link to come up */
+	for (i=0; i<10; i++) {
+		eth_port_read_smi_reg(port_num, 1, &phy_reg_data);
+		if (phy_reg_data & 0x20) {
+			netif_start_queue(dev);
+			return 0;
+		}
+		msleep(100);			/* sleep 1/10 second */
+	}
+	netif_stop_queue(dev);
 
 	return 0;
 }
@@ -1549,9 +1561,6 @@
 #define ETH_ENABLE_TX_QUEUE(eth_port) \
 	MV_WRITE(MV64340_ETH_TRANSMIT_QUEUE_COMMAND_REG(eth_port), 1)
 
-#define LINK_UP_TIMEOUT		100000
-#define PHY_BUSY_TIMEOUT	10000000
-
 /* locals */
 
 /* PHY routines */
@@ -1888,38 +1897,26 @@
  * ethernet_phy_reset - Reset Ethernet port PHY.
  *
  * DESCRIPTION:
- *       This routine utilize the SMI interface to reset the ethernet port PHY.
- *       The routine waits until the link is up again or link up is timeout.
+ *       This routine utilizes the SMI interface to reset the ethernet port PHY.
  *
  * INPUT:
  *	unsigned int   eth_port_num   Ethernet Port number.
  *
  * OUTPUT:
- *       The ethernet port PHY renew its link.
+ *       The PHY is reset.
  *
  * RETURN:
  *       None.
  *
  */
-static int ethernet_phy_reset(unsigned int eth_port_num)
+static void ethernet_phy_reset(unsigned int eth_port_num)
 {
-	unsigned int time_out = 50;
 	unsigned int phy_reg_data;
 
 	/* Reset the PHY */
 	eth_port_read_smi_reg(eth_port_num, 0, &phy_reg_data);
 	phy_reg_data |= 0x8000;	/* Set bit 15 to reset the PHY */
 	eth_port_write_smi_reg(eth_port_num, 0, phy_reg_data);
-
-	/* Poll on the PHY LINK */
-	do {
-		eth_port_read_smi_reg(eth_port_num, 1, &phy_reg_data);
-
-		if (time_out-- == 0)
-			return 0;
-	} while (!(phy_reg_data & 0x20));
-
-	return 1;
 }
 
 /*
@@ -1940,62 +1937,48 @@
  *       None.
  *
  */
-static void eth_port_reset(unsigned int eth_port_num)
+static void eth_port_reset(unsigned int port_num)
 {
 	unsigned int reg_data;
 
 	/* Stop Tx port activity. Check port Tx activity. */
-	reg_data =
-	    MV_READ(MV64340_ETH_TRANSMIT_QUEUE_COMMAND_REG(eth_port_num));
+	reg_data = MV_READ(MV64340_ETH_TRANSMIT_QUEUE_COMMAND_REG(port_num));
 
 	if (reg_data & 0xFF) {
 		/* Issue stop command for active channels only */
-		MV_WRITE(MV64340_ETH_TRANSMIT_QUEUE_COMMAND_REG
-			 (eth_port_num), (reg_data << 8));
+		MV_WRITE(MV64340_ETH_TRANSMIT_QUEUE_COMMAND_REG(port_num),
+							(reg_data << 8));
 
 		/* Wait for all Tx activity to terminate. */
-		do {
-			/* Check port cause register that all Tx queues are stopped */
-			reg_data =
-			    MV_READ
-			    (MV64340_ETH_TRANSMIT_QUEUE_COMMAND_REG
-			     (eth_port_num));
-		}
-		while (reg_data & 0xFF);
+		/* Check port cause register that all Tx queues are stopped */
+		while (MV_READ(MV64340_ETH_TRANSMIT_QUEUE_COMMAND_REG(port_num))
+									& 0xFF)
+			udelay(10);
 	}
 
 	/* Stop Rx port activity. Check port Rx activity. */
-	reg_data =
-	    MV_READ(MV64340_ETH_RECEIVE_QUEUE_COMMAND_REG
-			 (eth_port_num));
+	reg_data = MV_READ(MV64340_ETH_RECEIVE_QUEUE_COMMAND_REG(port_num));
 
 	if (reg_data & 0xFF) {
 		/* Issue stop command for active channels only */
-		MV_WRITE(MV64340_ETH_RECEIVE_QUEUE_COMMAND_REG
-			 (eth_port_num), (reg_data << 8));
+		MV_WRITE(MV64340_ETH_RECEIVE_QUEUE_COMMAND_REG(port_num),
+							(reg_data << 8));
 
 		/* Wait for all Rx activity to terminate. */
-		do {
-			/* Check port cause register that all Rx queues are stopped */
-			reg_data =
-			    MV_READ
-			    (MV64340_ETH_RECEIVE_QUEUE_COMMAND_REG
-			     (eth_port_num));
-		}
-		while (reg_data & 0xFF);
+		/* Check port cause register that all Rx queues are stopped */
+		while (MV_READ(MV64340_ETH_RECEIVE_QUEUE_COMMAND_REG(port_num))
+									& 0xFF)
+			udelay(10);
 	}
 
 
 	/* Clear all MIB counters */
-	eth_clear_mib_counters(eth_port_num);
+	eth_clear_mib_counters(port_num);
 
 	/* Reset the Enable bit in the Configuration Register */
-	reg_data =
-	    MV_READ(MV64340_ETH_PORT_SERIAL_CONTROL_REG (eth_port_num));
+	reg_data = MV_READ(MV64340_ETH_PORT_SERIAL_CONTROL_REG(port_num));
 	reg_data &= ~ETH_SERIAL_PORT_ENABLE;
-	MV_WRITE(MV64340_ETH_PORT_SERIAL_CONTROL_REG(eth_port_num), reg_data);
-
-	return;
+	MV_WRITE(MV64340_ETH_PORT_SERIAL_CONTROL_REG(port_num), reg_data);
 }
 
 /*
@@ -2054,6 +2037,8 @@
 	return eth_config_reg;
 }
 
+#define PHY_WAIT_ITERATIONS	1000	/* 1000 iterations * 10uS = 10mS max */
+
 
 /*
  * eth_port_read_smi_reg - Read PHY registers
@@ -2063,7 +2048,7 @@
  *       order to perform PHY register read.
  *
  * INPUT:
- *	unsigned int   eth_port_num   Ethernet Port number.
+ *       unsigned int   port_num  Ethernet Port number.
  *       unsigned int   phy_reg   PHY register address offset.
  *       unsigned int   *value   Register value buffer.
  *
@@ -2075,41 +2060,41 @@
  *       true otherwise.
  *
  */
-static int eth_port_read_smi_reg(unsigned int eth_port_num,
+static void eth_port_read_smi_reg(unsigned int port_num,
 	unsigned int phy_reg, unsigned int *value)
 {
-	int phy_addr = ethernet_phy_get(eth_port_num);
-	unsigned int time_out = PHY_BUSY_TIMEOUT;
-	unsigned int reg_value;
-
-	/* first check that it is not busy */
-	do {
-		reg_value = MV_READ(MV64340_ETH_SMI_REG);
-		if (time_out-- == 0)
-			return 0;
-	} while (reg_value & ETH_SMI_BUSY);
+	int phy_addr = ethernet_phy_get(port_num);
+	unsigned long flags;
+	int i;
+
+	/* the SMI register is a shared resource */
+	spin_lock_irqsave(&mv64340_eth_phy_lock, flags);
 
-	/* not busy */
+	/* wait for the SMI register to become available */
+	for (i=0; MV_READ(MV64340_ETH_SMI_REG) & ETH_SMI_BUSY; i++) {
+		if (i == PHY_WAIT_ITERATIONS) {
+			printk("mv64340 PHY busy timeout, port %d\n", port_num);
+			goto out;
+		}
+		udelay(10);
+	}
 
 	MV_WRITE(MV64340_ETH_SMI_REG,
 		 (phy_addr << 16) | (phy_reg << 21) | ETH_SMI_OPCODE_READ);
 
-	time_out = PHY_BUSY_TIMEOUT;	/* initialize the time out var again */
-
-	do {
-		reg_value = MV_READ(MV64340_ETH_SMI_REG);
-		if (time_out-- == 0)
-			return 0;
-	} while (reg_value & ETH_SMI_READ_VALID);
-
-	/* Wait for the data to update in the SMI register */
-	for (time_out = 0; time_out < PHY_BUSY_TIMEOUT; time_out++);
-
-	reg_value = MV_READ(MV64340_ETH_SMI_REG);
-
-	*value = reg_value & 0xffff;
+	/* now wait for the data to be valid */
+	for (i=0; !(MV_READ(MV64340_ETH_SMI_REG) & ETH_SMI_READ_VALID); i++) {
+		if (i == PHY_WAIT_ITERATIONS) {
+			printk("mv64340 PHY read timeout, port %d\n", port_num);
+			goto out;
+		}
+		udelay(10);
+	}
+	 
+	*value = MV_READ(MV64340_ETH_SMI_REG) & 0xffff;
 
-	return 1;
+out:
+	spin_unlock_irqrestore(&mv64340_eth_phy_lock, flags);
 }
 
 /*
@@ -2132,27 +2117,32 @@
  *      true otherwise.
  *
  */
-static int eth_port_write_smi_reg(unsigned int eth_port_num,
+static void eth_port_write_smi_reg(unsigned int eth_port_num,
 	unsigned int phy_reg, unsigned int value)
 {
-	unsigned int time_out = PHY_BUSY_TIMEOUT;
-	unsigned int reg_value;
 	int phy_addr;
+	int i;
+	unsigned long flags;
 
 	phy_addr = ethernet_phy_get(eth_port_num);
 
-	/* first check that it is not busy */
-	do {
-		reg_value = MV_READ(MV64340_ETH_SMI_REG);
-		if (time_out-- == 0)
-			return 0;
-	} while (reg_value & ETH_SMI_BUSY);
+	/* the SMI register is a shared resource */
+	spin_lock_irqsave(&mv64340_eth_phy_lock, flags);
+
+	/* wait for the SMI register to become available */
+	for (i=0; MV_READ(MV64340_ETH_SMI_REG) & ETH_SMI_BUSY; i++) {
+		if (i == PHY_WAIT_ITERATIONS) {
+			printk("mv64340 PHY busy timeout, port %d\n",
+								eth_port_num);
+			goto out;
+		}
+		udelay(10);
+	}
 
-	/* not busy */
 	MV_WRITE(MV64340_ETH_SMI_REG, (phy_addr << 16) | (phy_reg << 21) |
 		 ETH_SMI_OPCODE_WRITE | (value & 0xffff));
-
-	return 1;
+out:
+	spin_unlock_irqrestore(&mv64340_eth_phy_lock, flags);
 }
 
 /*
Index: linux-2.5-marvell-submit/drivers/net/mv643xx_eth.h
===================================================================
--- linux-2.5-marvell-submit.orig/drivers/net/mv643xx_eth.h	2004-12-13 14:29:50.487055840 -0700
+++ linux-2.5-marvell-submit/drivers/net/mv643xx_eth.h	2004-12-13 14:29:55.829024727 -0700
@@ -576,13 +576,13 @@
 				 unsigned char *p_addr);
 
 /* PHY and MIB routines */
-static int ethernet_phy_reset(unsigned int eth_port_num);
+static void ethernet_phy_reset(unsigned int eth_port_num);
 
-static int eth_port_write_smi_reg(unsigned int eth_port_num,
+static void eth_port_write_smi_reg(unsigned int eth_port_num,
 				   unsigned int phy_reg,
 				   unsigned int value);
 
-static int eth_port_read_smi_reg(unsigned int eth_port_num,
+static void eth_port_read_smi_reg(unsigned int eth_port_num,
 				  unsigned int phy_reg,
 				  unsigned int *value);
 
