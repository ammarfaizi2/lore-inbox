Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262423AbUKKWzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbUKKWzu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 17:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262413AbUKKWzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 17:55:13 -0500
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:10683 "EHLO
	timesys.com") by vger.kernel.org with ESMTP id S262409AbUKKWsr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 17:48:47 -0500
Date: Thu, 11 Nov 2004 17:48:45 -0500
From: Jason McMullan <jason.mcmullan@timesys.com>
To: linux-kernel@vger.kernel.org
Cc: jgarzik@pobox.com, romieu@fr.zoreil.com
Subject: Re: [PATCH] MII bus API for PHY devices
Message-ID: <20041111224845.GA12646@jmcmullan.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Second attempt, more polish.

(Though I'm leaving my macro abuse in for now!)

Description: MII Bus interface
Date:        Thu, 11 Nov 2004 17:44:57 -0500
Signed-off-by:  Jason McMullan <jmcmullan@timesys.com>
Depends:
	linux-2.6.9

###############################

Index of changes:

 drivers/net/Makefile          |    2 
 linux/drivers/net/mii_bus.c   |  857 ++++++++++++++++++++++++++++++++++++++++++
 linux/include/linux/mii_bus.h |  132 ++++++
 3 files changed, 990 insertions(+), 1 deletion(-)


--- linux-orig/drivers/net/Makefile
+++ linux/drivers/net/Makefile
@@ -62,7 +62,7 @@
 # end link order section
 #
 
-obj-$(CONFIG_MII) += mii.o
+obj-$(CONFIG_MII) += mii.o mii_bus.o
 
 obj-$(CONFIG_SUNDANCE) += sundance.o
 obj-$(CONFIG_HAMACHI) += hamachi.o
--- /dev/null
+++ linux/drivers/net/mii_bus.c
@@ -0,0 +1,857 @@
+/* 
+ * drivers/net/mii_bus.c
+ *
+ * Adapeted from drivers/net/gianfar_mii.c, by Andy Fleming
+ *
+ * Author: Jason McMullan (jason.mcmullan@timesys.com) to 
+ * 	   be a generic mii interface
+ *
+ * Copyright (c) 2004 Timesys Inc
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/skbuff.h>
+#include <linux/spinlock.h>
+#include <linux/mm.h>
+#include <linux/mii_bus.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/uaccess.h>
+#include <linux/module.h>
+
+/*
+ * struct phy_cmd:  A command for reading or writing a PHY register
+ *
+ * mii_reg:  The register to read or write
+ *
+ * mii_data:  For writes, the value to put in the register.
+ * 	A value of -1 indicates this is a read.
+ *
+ * funct: A function pointer which is invoked for each command.
+ * 	For reads, this function will be passed the value read
+ *	from the PHY, and process it.
+ *	For writes, the result of this function will be written
+ *	to the PHY register
+ */
+struct phy_cmd {
+    u32 mii_reg;
+    u32 mii_data;
+    u16 (*funct) (u16 mii_reg, int bus, int id);
+};
+
+/* struct phy_info: a structure which defines attributes for a PHY
+ *
+ * id will contain a number which represents the PHY.  During
+ * startup, the driver will poll the PHY to find out what its
+ * UID--as defined by registers 2 and 3--is.  The 32-bit result
+ * gotten from the PHY will be shifted right by "shift" bits to
+ * discard any bits which may change based on revision numbers
+ * unimportant to functionality
+ *
+ * The struct phy_cmd entries represent pointers to an arrays of
+ * commands which tell the driver what to do to the PHY.
+ */
+struct phy_info {
+    u32 id;
+    const char *name;
+    unsigned int shift;
+    /* Called to configure the PHY, and modify the controller
+     * based on the results */
+    const struct phy_cmd *config;
+
+    /* Called when starting up the controller.  Usually sets
+     * up the interrupt for state changes */
+    const struct phy_cmd *startup;
+
+    /* Called inside the interrupt handler to acknowledge
+     * the interrupt */
+    const struct phy_cmd *ack_int;
+
+    /* Called in the bottom half to get the state */
+    const struct phy_cmd *poll;
+
+    /* Called to re-enable interrupts */
+    const struct phy_cmd *end_int;
+
+    /* Called when bringing down the controller.  Usually stops
+     * the interrupts from being generated */
+    const struct phy_cmd *shutdown;
+
+    /* Local state information */
+    struct {
+	int irq;
+	unsigned long msecs;
+	void (*func)(void *data);
+	void *data;
+    	struct work_struct tq;
+	struct timer_list timer;
+    } delta;
+
+    struct phy_state state;
+};
+
+static struct mii_bus *mii_bus[4];
+
+#define MII_BUS_MAX	(sizeof(mii_bus)/sizeof(struct mii_bus *))
+
+#define VALID_BUS(bus) (mii_bus[bus]!=NULL)
+#define VALID(bus,x) (mii_bus[bus]!=NULL && (mii_bus[bus]->phy[id] != NULL))
+#define PHY_ID(phy_id) (phy_id & 0x1f)
+#define PHY_BUS(phy_id) ((phy_id & 0x20) ? 1 : 0)
+#define MII_ID(mii) PHY_ID(mii->phy_id)
+#define MII_BUS(mii) PHY_BUS(mii->phy_id)
+#define BUS_ID(phy_id) int bus = PHY_BUS(phy_id); int id = PHY_ID(phy_id);
+
+static inline struct phy_info *mii_phy_of(struct mii_if_info *mii)
+{
+	if (mii != NULL) {
+		BUS_ID(mii->phy_id);
+		return mii_bus[bus]->phy[id];
+	}
+
+	return NULL;
+}
+
+/* Write value to the PHY for this device to the register at regnum, */
+/* waiting until the write is done before it returns.  All PHY */
+/* configuration has to be done through the TSEC1 MIIM regs */
+EXPORT_SYMBOL(mii_bus_write);
+int mii_bus_write(int bus, int id, int regnum, uint16_t value)
+{
+	if (!VALID_BUS(bus))
+		return -EINVAL;
+
+       	mii_bus[bus]->write(mii_bus[bus]->priv,id,regnum,value);
+	return 0;
+}
+
+/* Reads from register regnum in the PHY for device dev, */
+/* returning the value.  Clears miimcom first.  All PHY */
+/* configuration has to be done through the TSEC1 MIIM regs */
+EXPORT_SYMBOL(mii_bus_read);
+int mii_bus_read(int bus, int id, int regnum)
+{
+	if (!VALID_BUS(bus))
+		return -EINVAL;
+
+       	return mii_bus[bus]->read(mii_bus[bus]->priv,id,regnum);
+}
+
+/* returns which value to write to the control register. */
+/* For 10/100 the value is slightly different. */
+static u16 mii_cr_init(u16 mii_reg, int bus, int id)
+{
+		return BMCR_ANRESTART;
+}
+
+#define BRIEF_MII_ERRORS
+/* Wait for auto-negotiation to complete */
+u16 mii_parse_sr(u16 mii_reg, int bus, int id)
+{
+	unsigned int timeout = MII_TIMEOUT;
+	struct phy_state *pstate;
+
+	if (!VALID(bus, id)) return 0xffff;
+	pstate = &mii_bus[bus]->phy[id]->state;
+
+	if (mii_reg & BMSR_LSTATUS) {
+		pstate->link = 1;
+	} else {
+		pstate->link = 0;
+		pstate->auto_neg = 1;
+	}
+
+	/* Only auto-negotiate if the link has just gone up */
+	if (pstate->link && pstate->auto_neg) {
+		while ((!(mii_reg & BMSR_ANEGCOMPLETE)) && timeout--)
+			mii_reg = mii_bus_read(bus, id, MII_BMSR);
+
+#if defined(BRIEF_MII_ERRORS)
+		if (mii_reg & BMSR_ANEGCOMPLETE)
+			printk(KERN_INFO "phy %d.%d: Auto-negotiation done\n",
+			       bus,id);
+		else
+			printk(KERN_INFO "phy %d.%d: Auto-negotiation timed out\n",
+			       bus,id);
+#endif
+		pstate->auto_neg = 0;
+
+		if (mii_reg & BMSR_ANEGCOMPLETE) {
+			mii_reg = mii_bus_read(bus, id, MII_LPA);
+			mii_reg &= mii_bus_read(bus, id, MII_ADVERTISE);
+			/* Get the speed */
+			if (mii_reg & (LPA_100FULL | LPA_100HALF))
+				pstate->speed = 100;
+			else if (mii_reg & (LPA_10FULL | LPA_10HALF))
+				pstate->speed = 10;
+
+			/* Get the duplex */
+			if (mii_reg & (LPA_100FULL | LPA_10FULL))
+				pstate->duplex = 1;
+			else if (mii_reg & (LPA_100HALF | LPA_10HALF))
+				pstate->duplex = 0;
+		}
+	}
+
+	return 0;
+}
+
+/* Determine the speed and duplex which was negotiated */
+u16 mii_parse_88E1011_psr(u16 mii_reg, int bus, int id)
+{
+	unsigned int speed;
+	struct phy_state *pstate;
+
+	if (!VALID(bus, id)) return 0xffff;
+	pstate = &mii_bus[bus]->phy[id]->state;
+
+	if (pstate->link) {
+		if (mii_reg & MIIM_88E1011_PHYSTAT_DUPLEX)
+			pstate->duplex = 1;
+		else
+			pstate->duplex = 0;
+
+		speed = (mii_reg & MIIM_88E1011_PHYSTAT_SPEED);
+
+		switch (speed) {
+		case MIIM_88E1011_PHYSTAT_GBIT:
+			pstate->speed = 1000;
+			break;
+		case MIIM_88E1011_PHYSTAT_100:
+			pstate->speed = 100;
+			break;
+		default:
+			pstate->speed = 10;
+			break;
+		}
+	} else {
+		pstate->speed = 0;
+		pstate->duplex = 0;
+	}
+
+	return 0;
+}
+
+u16 mii_parse_cis8201(u16 mii_reg, int bus, int id)
+{
+	unsigned int speed;
+	struct phy_state *pstate;
+
+	if (!VALID(bus, id)) return 0xffff;
+	pstate = &mii_bus[bus]->phy[id]->state;
+
+	if (pstate->link) {
+		if (mii_reg & MIIM_CIS8201_AUXCONSTAT_DUPLEX)
+			pstate->duplex = 1;
+		else
+			pstate->duplex = 0;
+
+		speed = mii_reg & MIIM_CIS8201_AUXCONSTAT_SPEED;
+
+		switch (speed) {
+		case MIIM_CIS8201_AUXCONSTAT_GBIT:
+			pstate->speed = 1000;
+			break;
+		case MIIM_CIS8201_AUXCONSTAT_100:
+			pstate->speed = 100;
+			break;
+		default:
+			pstate->speed = 10;
+			break;
+		}
+	} else {
+		pstate->speed = 0;
+		pstate->duplex = 0;
+	}
+
+	return 0;
+}
+
+u16 mii_parse_dm9161_scsr(u16 mii_reg, int bus, int id)
+{
+	struct phy_state *pstate;
+
+	if (!VALID(bus, id)) return 0xffff;
+	pstate = &mii_bus[bus]->phy[id]->state;
+
+	if (mii_reg & (MIIM_DM9161_SCSR_100F | MIIM_DM9161_SCSR_100H))
+		pstate->speed = 100;
+	else
+		pstate->speed = 10;
+
+	if (mii_reg & (MIIM_DM9161_SCSR_100F | MIIM_DM9161_SCSR_10F))
+		pstate->duplex = 1;
+	else
+		pstate->duplex = 0;
+
+	return 0;
+}
+
+u16 dm9161_wait(u16 mii_reg, int bus, int id)
+{
+	int timeout = 3*HZ;
+
+	if (!VALID(bus,id)) return 0xffff;
+
+	/* Davicom takes a bit to come up after a reset,
+	 * so wait here for a bit */
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	schedule_timeout(timeout);
+
+	return 0;
+}
+
+static struct phy_info phy_info_M88E1011S = {
+	.id = 0x01410c6,
+	.name = "Marvell 88E1011S",
+	.shift = 4,
+	.config = (const struct phy_cmd[]) {	/* config */
+		/* Reset and configure the PHY */
+		{MII_BMCR, BMCR_ANRESTART, mii_cr_init},
+		{miim_end,}
+	},
+	.startup = (const struct phy_cmd[]) {	/* startup */
+		/* Clear the IEVENT register */
+		{MIIM_88E1011_IEVENT, miim_read, NULL},
+		/* Set up the mask */
+		{MIIM_88E1011_IMASK, MIIM_88E1011_IMASK_INIT, NULL},
+		{miim_end,}
+	},
+	.ack_int = (const struct phy_cmd[]) {	/* ack_int */
+		/* Clear the interrupt */
+		{MIIM_88E1011_IEVENT, miim_read, NULL},
+		/* Disable interrupts */
+		{MIIM_88E1011_IMASK, MIIM_88E1011_IMASK_CLEAR, NULL},
+		{miim_end,}
+	},
+	.poll = (const struct phy_cmd[]) {	/* poll */
+		/* Read the Status (2x to make sure link is right) */
+		{MII_BMSR, miim_read, NULL},
+		/* Check the status */
+		{MII_BMSR, miim_read, mii_parse_sr},
+		{MIIM_88E1011_PHY_STATUS, miim_read, mii_parse_88E1011_psr},
+		{miim_end,}
+	},
+	.end_int = (const struct phy_cmd[]) {	/* end_int */
+			/* Enable Interrupts */
+		{MIIM_88E1011_IMASK, MIIM_88E1011_IMASK_INIT, NULL},
+		{miim_end,}
+	},
+	.shutdown = (const struct phy_cmd[]) {	/* shutdown */
+		{MIIM_88E1011_IEVENT, miim_read, NULL},
+		{MIIM_88E1011_IMASK, MIIM_88E1011_IMASK_CLEAR, NULL},
+		{miim_end,}
+	},
+};
+
+/* Cicada 8201 */
+static struct phy_info phy_info_cis8201 = {
+	.id = 0xfc41,
+	.name = "CIS8201",
+	.shift = 4,
+	.config = (const struct phy_cmd[]) {	/* config */
+		/* Override PHY config settings */
+		{MIIM_CIS8201_AUX_CONSTAT, MIIM_CIS8201_AUXCONSTAT_INIT, NULL},
+		/* Set up the interface mode */
+		{MIIM_CIS8201_EXT_CON1, MIIM_CIS8201_EXTCON1_INIT, NULL},
+		/* Configure some basic stuff */
+		{MII_BMCR, BMCR_ANRESTART, mii_cr_init},
+		{miim_end,}
+	},
+	.poll = (const struct phy_cmd[]) {	/* poll */
+		/* Read the Status (2x to make sure link is right) */
+		{MII_BMSR, miim_read, NULL},
+		/* Auto-negotiate */
+		{MII_BMSR, miim_read, mii_parse_sr},
+		/* Read the status */
+		{MIIM_CIS8201_AUX_CONSTAT, miim_read, mii_parse_cis8201},
+		{miim_end,}
+	},
+};
+
+static struct phy_info phy_info_dm9161 = {
+	.id = 0x0181b88,
+	.name = "Davicom DM9161E",
+	.shift = 4,
+	.config = (const struct phy_cmd[]) {	/* config */
+		{MII_BMCR, MIIM_DM9161_CR_STOP, NULL},
+		/* Do not bypass the scrambler/descrambler */
+		{MIIM_DM9161_SCR, MIIM_DM9161_SCR_INIT, NULL},
+		/* Clear 10BTCSR to default */
+		{MIIM_DM9161_10BTCSR, MIIM_DM9161_10BTCSR_INIT, NULL},
+		/* Configure some basic stuff */
+		{MII_BMCR, BMCR_ANRESTART, NULL},
+		/* Restart Auto Negotiation */
+		{MII_BMCR, MIIM_DM9161_CR_RSTAN, NULL},
+		{miim_end,}
+	},
+	.startup = (const struct phy_cmd[]) {	/* startup */
+		/* Status is read once to clear old link state */
+		{MII_BMSR, miim_read, dm9161_wait},
+		/* Clear any pending interrupts */
+		{MIIM_DM9161_INTR, miim_read, NULL},
+		{miim_end,}
+	},
+	.ack_int = (const struct phy_cmd[]) {	/* ack_int */
+		{MIIM_DM9161_INTR, miim_read, NULL},
+		{miim_end,}
+	},
+	.poll = (const struct phy_cmd[]) {	/* poll */
+		{MII_BMSR, miim_read, NULL},
+		{MII_BMSR, miim_read, mii_parse_sr},
+		{MIIM_DM9161_SCSR, miim_read, mii_parse_dm9161_scsr},
+		{miim_end,}
+	},
+	.shutdown = (const struct phy_cmd[]) {	/* shutdown */
+		{MIIM_DM9161_INTR, miim_read, NULL},
+		{miim_end,}
+	},
+};
+
+static struct phy_info phy_info_bcm5222 = {
+	.id = 0x0040632,
+	.name = "Broadcom BCM5222",
+	.shift = 4,
+	.config = (const struct phy_cmd[]) {	/* config */
+		/* Configure some basic stuff */
+		{MII_BMCR, BMCR_ANRESTART, NULL},
+		/* Status is read once to clear old link state */
+		{MII_BMSR, miim_read, NULL},
+		{miim_end,}
+	},
+	.poll = (const struct phy_cmd[]) {	/* poll */
+		{MII_BMSR, miim_read, NULL},
+		{MII_BMSR, miim_read, mii_parse_sr},
+		{miim_end,}
+	},
+};
+
+static struct phy_info phy_info_generic = {
+	.id = 0x0,
+	.name = "Generic PHY",
+	.shift = 32,
+	.config = (const struct phy_cmd[]) {	/* config */
+		/* Configure some basic stuff */
+		{MII_BMCR, BMCR_ANRESTART, NULL},
+		/* Ignore old link state */
+		{MII_BMSR, miim_read, NULL},
+		{miim_end,}
+	},
+	.poll = (const struct phy_cmd[]) {	/* handle_int */
+		{MII_BMSR, miim_read, NULL},
+		{MII_BMSR, miim_read, mii_parse_sr},
+		{miim_end,}
+	},
+};
+
+static struct phy_info *phy_info[] = {
+	&phy_info_generic,
+	&phy_info_cis8201,
+	&phy_info_M88E1011S,
+	&phy_info_dm9161,
+	&phy_info_bcm5222,
+	NULL
+};
+
+/* Use the PHY ID registers to determine what type of PHY is attached
+ * to device dev.  return a struct phy_info structure describing that PHY
+ */
+struct phy_info *mii_phy_get_info(int bus, int id)
+{
+	u16 phy_reg;
+	u32 phy_ID;
+	int i;
+	struct phy_info *theInfo = NULL;
+
+	if (mii_bus[bus] == NULL)
+		return NULL;
+
+	/* Grab the bits from PHYIR1, and put them in the upper half */
+	phy_reg = mii_bus_read(bus, id, MII_PHYSID1);
+	phy_ID = (phy_reg & 0xffff) << 16;
+
+	/* Grab the bits from PHYIR2, and put them in the lower half */
+	phy_reg = mii_bus_read(bus, id, MII_PHYSID2);
+	phy_ID |= (phy_reg & 0xffff);
+
+	/* loop through all the known PHY types, and find one that */
+	/* matches the ID we read from the PHY. */
+	for (i = 0; phy_info[i]; i++)
+		if (phy_info[i]->id == (phy_ID >> phy_info[i]->shift))
+			theInfo = phy_info[i];
+
+	if (theInfo == NULL) {
+		printk("phy %d.%d: PHY id 0x%x is not supported!\n", bus, id, phy_ID);
+		return NULL;
+	} else {
+		printk("phy %d.%d: PHY is %s (%x)\n", bus, id, theInfo->name,
+		       phy_ID);
+	}
+
+	return theInfo;
+}
+
+/* Take a list of struct phy_cmd, and, depending on the values, either */
+/* read or write, using a helper function if provided */
+/* It is assumed that all lists of struct phy_cmd will be terminated by */
+/* mii_end. */
+static void phy_run_commands(int bus, int id, const struct phy_cmd *cmd)
+{
+	int i;
+	u16 result;
+
+	if (!VALID(bus, id)) return;
+
+	if (cmd == NULL)
+		return;
+
+	for (i = 0; cmd->mii_reg != miim_end; i++) {
+		/* The command is a read if mii_data is miim_read */
+		if (cmd->mii_data == miim_read) {
+			/* Read the value of the PHY reg */
+			result = mii_bus_read(bus, id, cmd->mii_reg);
+
+			/* If a function was supplied, we need to let it process */
+			/* the result. */
+			if (cmd->funct != NULL)
+				(*(cmd->funct)) (result, bus, id);
+		} else {	/* Otherwise, it's a write */
+			/* If a function was supplied, it will provide 
+			 * the value to write */
+			/* Otherwise, the value was supplied in cmd->mii_data */
+			if (cmd->funct != NULL)
+				result = (*(cmd->funct)) (0, bus, id);
+			else
+				result = cmd->mii_data;
+
+			/* Write the appropriate value to the PHY reg */
+			mii_bus_write(bus, id, cmd->mii_reg, result);
+		}
+		cmd++;
+	}
+}
+
+static int mdio_read(struct net_device *dev, int phy, int reg)
+{
+	BUS_ID(phy);
+
+	return mii_bus_read(bus, id, reg);
+}
+
+static void mdio_write(struct net_device *dev, int phy, int reg, int val)
+{
+	BUS_ID(phy);
+
+	mii_bus_write(bus, id, reg, val & 0xffff);
+}
+
+static inline void mii_phy_irq_ack(struct mii_if_info *mii)
+{
+	BUS_ID(mii->phy_id);
+
+	if (!VALID(bus, id))
+		return;
+
+	phy_run_commands(bus, id, mii_bus[bus]->phy[id]->ack_int);
+}
+
+static inline void mii_phy_irq_handle(struct mii_if_info *mii)
+{
+	BUS_ID(mii->phy_id);
+
+       	if (!VALID(bus, id))
+		return;
+
+	phy_run_commands(bus, id, mii_bus[bus]->phy[id]->poll);
+	phy_run_commands(bus, id, mii_bus[bus]->phy[id]->end_int);
+}
+
+static irqreturn_t mii_phy_irq(int irq, void *data, struct pt_regs *regs)
+{
+	struct mii_if_info *mii = (void *)data;
+	struct phy_info *phy = mii_phy_of(mii);
+
+	mii_phy_irq_ack(mii);
+
+	/* Schedule the bottom half */
+	schedule_work(&phy->delta.tq);
+
+	return IRQ_HANDLED;
+}
+
+EXPORT_SYMBOL(mii_phy_irq_enable);
+int mii_phy_irq_enable(struct mii_if_info *mii,int irq,void (*func)(void *),void *data)
+{
+	struct phy_info *phy = mii_phy_of(mii);
+	int err;
+	BUS_ID(mii->phy_id);
+
+	if (!VALID(bus, id))
+		return -EINVAL;
+
+	if (phy->delta.data != NULL)
+		return -EBUSY;
+
+	phy->delta.irq = irq;
+	phy->delta.func = func;
+	phy->delta.data = data;
+
+	err = request_irq(irq, mii_phy_irq, SA_SHIRQ, phy->name, mii);
+	if (err < 0) {
+		phy->delta.irq = -1;
+		phy->delta.func = NULL;
+		phy->delta.data = NULL;
+		return err;
+	}
+
+	phy_run_commands(bus, id, mii_bus[bus]->phy[id]->startup);
+	return 0;
+}
+
+EXPORT_SYMBOL(mii_phy_irq_disable);
+void mii_phy_irq_disable(struct mii_if_info *mii,void *data)
+{
+	struct phy_info *phy = mii_phy_of(mii);
+	BUS_ID(mii->phy_id);
+
+	if (!VALID(bus, id))
+		return;
+
+	if (phy->delta.data != data)
+		return;
+
+	phy_run_commands(bus, id, mii_bus[bus]->phy[id]->shutdown);
+
+	free_irq(phy->delta.irq, mii);
+	phy->delta.irq = -1;
+}
+
+/* Scheduled by the task queue */
+static void mii_phy_delta(void *data)
+{
+	struct mii_if_info *mii = (void *)data;
+	struct phy_info *phy = mii_phy_of(mii);
+	int timeout = HZ / 1000 + 1;
+
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	schedule_timeout(timeout);
+
+	if (phy->delta.irq >= 0)
+		mii_phy_irq_handle(mii);
+	else {
+		BUS_ID(mii->phy_id);
+		phy_run_commands(bus, id, mii_bus[bus]->phy[id]->poll);
+	}
+
+	if (phy->delta.func)
+		phy->delta.func(phy->delta.data);
+}
+
+static void mii_phy_poll(unsigned long data)
+{
+	struct mii_if_info *mii = (void *)data;
+	struct phy_info *phy = mii_phy_of(mii);
+
+	BUG_ON(phy == NULL);
+	schedule_work(&phy->delta.tq);
+
+	mod_timer(&phy->delta.timer, jiffies + HZ*phy->delta.msecs/1000);
+}
+
+
+EXPORT_SYMBOL(mii_phy_poll_enable);
+int mii_phy_poll_enable(struct mii_if_info *mii,unsigned long msecs,void (*func)(void *),void *data)
+{
+	struct phy_info *phy = mii_phy_of(mii);
+
+	if (phy == NULL)
+		return -EINVAL;
+
+	if (HZ*msecs/1000 <= 0 || func == NULL)
+		return -EINVAL;
+
+	if (phy->delta.data != NULL)
+		return -EINVAL;
+
+	init_timer(&phy->delta.timer);
+	phy->delta.timer.function = mii_phy_poll;
+	phy->delta.timer.data = (unsigned long)mii;
+	phy->delta.data = data;
+	phy->delta.func = func;
+	phy->delta.msecs = msecs;
+	mod_timer(&phy->delta.timer, jiffies + HZ*msecs/1000);
+	schedule_work(&phy->delta.tq);
+
+	return 0;
+}
+
+EXPORT_SYMBOL(mii_phy_poll_disable);
+void mii_phy_poll_disable(struct mii_if_info *mii,void *data)
+{
+	struct phy_info *phy = mii_phy_of(mii);
+
+	if (phy == NULL || phy->delta.data == NULL)
+		return;
+
+	del_timer_sync(&phy->delta.timer);
+	phy->delta.func = NULL;
+	phy->delta.data = NULL;
+}
+
+EXPORT_SYMBOL(mii_phy_attach);
+int mii_phy_attach(struct mii_if_info *mii, struct net_device *dev, int bus, int id)
+{
+	struct phy_info *phy,*info;
+
+	if (mii_bus[bus] == NULL) {
+		printk(KERN_ERR "mii_phy_attach: Can't attach %s, no MII bus %d present\n",dev->name,bus);
+		return -ENODEV;
+	}
+
+	if (VALID(bus,id)) {
+		printk(KERN_ERR "mii_phy_attach: PHY %d.%d is already attached to %s\n",bus,id,dev->name);
+		return -EBUSY;
+	}
+
+	info = mii_phy_get_info(bus, id);
+	if (info == NULL)
+		return -ENODEV;
+
+	phy = kmalloc(sizeof(*phy), GFP_KERNEL);
+	memcpy(phy,info,sizeof(*phy));
+
+	INIT_WORK(&phy->delta.tq, mii_phy_delta, mii);
+	phy->delta.data = NULL;
+	phy->delta.irq = -1;
+	phy->state.link=0;
+	phy->state.duplex=0;
+	phy->state.auto_neg=1;
+	phy->state.speed=0;
+
+	memset(mii,0,sizeof(*mii));
+	mii->phy_id = (bus << 5) | id;
+	mii->phy_id_mask = 0xff;
+	mii->reg_num_mask = 0x1f;
+	mii->dev = dev;
+	mii->mdio_read = mdio_read;
+	mii->mdio_write = mdio_write;
+
+	mii_bus[bus]->phy[id] = phy;
+
+	phy_run_commands(bus, id, phy->startup);
+
+	return 0;
+}
+
+EXPORT_SYMBOL(mii_phy_detach);
+void mii_phy_detach(struct mii_if_info *mii)
+{
+	struct phy_info *phy;
+	struct mii_bus *pbus;
+	BUS_ID(mii->phy_id);
+
+	if (!VALID(bus, id))
+		return;
+
+	pbus = mii_bus[bus];
+	phy = pbus->phy[id];
+
+	if (phy->delta.data != NULL) {
+		if (phy->delta.irq < 0)
+			mii_phy_poll_disable(mii, phy->delta.data);
+		else
+			mii_phy_irq_disable(mii, phy->delta.data);
+	}
+
+	phy_run_commands(bus, id, phy->shutdown);
+	pbus->phy[id]=NULL;
+	kfree(phy);
+}
+
+EXPORT_SYMBOL(mii_phy_state);
+int mii_phy_state(struct mii_if_info *mii, struct phy_state *state)
+{
+	struct phy_info *phy = mii_phy_of(mii);
+	BUS_ID(mii->phy_id);
+
+	if (!VALID(bus, id))
+		return -ENODEV;
+
+	if (phy->delta.data == NULL)
+		phy_run_commands(bus, id, phy->poll);
+
+	memcpy(state,&phy->state,sizeof(*state));
+
+	return 0;
+}
+
+
+static DECLARE_MUTEX(mii_bus_lock);
+
+EXPORT_SYMBOL(mii_bus_register);
+int mii_bus_register(struct mii_bus *bus)
+{
+	int bus_id;
+
+	if (bus == NULL || bus->name == NULL || bus->read == NULL ||
+	    bus->write == NULL)
+		return -EINVAL;
+
+	down(&mii_bus_lock);
+
+	for (bus_id = 0; bus_id < MII_BUS_MAX; bus_id++) {
+		if (mii_bus[bus_id] == NULL)
+			break;
+	}
+
+	if (bus_id >= MII_BUS_MAX) {
+		up(&mii_bus_lock);
+		return -ENOMEM;
+	}
+
+	mii_bus[bus_id] = bus;
+
+	if (mii_bus[bus_id] == NULL) {
+		up(&mii_bus_lock);
+		return -EINVAL;
+	}
+
+	if (mii_bus[bus_id]->reset)
+		mii_bus[bus_id]->reset(mii_bus[bus_id]->priv);
+
+	up(&mii_bus_lock);
+
+	printk(KERN_INFO "%s: registered as PHY bus %d\n",bus->name,bus_id);
+	
+	return bus_id;
+}
+
+EXPORT_SYMBOL(mii_bus_unregister);
+void mii_bus_unregister(struct mii_bus *bus)
+{
+	int i;
+
+	down(&mii_bus_lock);
+
+	for (i=0; i < MII_BUS_MAX; i++)
+		if (mii_bus[i] == bus)
+			mii_bus[i] = NULL;
+
+	up(&mii_bus_lock);
+}	

--- /dev/null
+++ linux/include/linux/mii_bus.h
@@ -0,0 +1,132 @@
+/* 
+ * include/linux/mii_bus.h
+ *
+ * Author: Jason McMullan
+ *
+ * Copyright (c) 2004 Timesys Corp.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+#ifndef __MII_BUS_H
+#define __MII_BUS_H
+
+#include <linux/mii.h>
+
+#define MII_TIMEOUT 	(1*HZ)
+
+#define miim_end ((u32)-2)
+#define miim_read ((u32)-1)
+
+/* Cicada Auxiliary Control/Status Register */
+#define MIIM_CIS8201_AUX_CONSTAT        0x1c
+#define MIIM_CIS8201_AUXCONSTAT_INIT    0x0004
+#define MIIM_CIS8201_AUXCONSTAT_DUPLEX  0x0020
+#define MIIM_CIS8201_AUXCONSTAT_SPEED   0x0018
+#define MIIM_CIS8201_AUXCONSTAT_GBIT    0x0010
+#define MIIM_CIS8201_AUXCONSTAT_100     0x0008
+                                                                                
+/* Cicada Extended Control Register 1 */
+#define MIIM_CIS8201_EXT_CON1           0x17
+#define MIIM_CIS8201_EXTCON1_INIT       0x0000
+
+/* 88E1011 PHY Status Register */
+#define MIIM_88E1011_PHY_STATUS         0x11
+#define MIIM_88E1011_PHYSTAT_SPEED      0xc000
+#define MIIM_88E1011_PHYSTAT_GBIT       0x8000
+#define MIIM_88E1011_PHYSTAT_100        0x4000
+#define MIIM_88E1011_PHYSTAT_DUPLEX     0x2000
+#define MIIM_88E1011_PHYSTAT_LINK	0x0400
+
+#define MIIM_88E1011_IEVENT		0x13
+#define MIIM_88E1011_IEVENT_CLEAR	0x0000
+
+#define MIIM_88E1011_IMASK		0x12
+#define MIIM_88E1011_IMASK_INIT		0x6400
+#define MIIM_88E1011_IMASK_CLEAR	0x0000
+
+/* DM9161 Control register values */
+#define MIIM_DM9161_CR_STOP	0x0400
+#define MIIM_DM9161_CR_RSTAN	0x1200
+
+#define MIIM_DM9161_SCR		0x10
+#define MIIM_DM9161_SCR_INIT	0x0610
+
+/* DM9161 Specified Configuration and Status Register */
+#define MIIM_DM9161_SCSR	0x11
+#define MIIM_DM9161_SCSR_100F	0x8000
+#define MIIM_DM9161_SCSR_100H	0x4000
+#define MIIM_DM9161_SCSR_10F	0x2000
+#define MIIM_DM9161_SCSR_10H	0x1000
+
+/* DM9161 Interrupt Register */
+#define MIIM_DM9161_INTR	0x15
+#define MIIM_DM9161_INTR_PEND		0x8000
+#define MIIM_DM9161_INTR_DPLX_MASK	0x0800
+#define MIIM_DM9161_INTR_SPD_MASK	0x0400
+#define MIIM_DM9161_INTR_LINK_MASK	0x0200
+#define MIIM_DM9161_INTR_MASK		0x0100
+#define MIIM_DM9161_INTR_DPLX_CHANGE	0x0010
+#define MIIM_DM9161_INTR_SPD_CHANGE	0x0008
+#define MIIM_DM9161_INTR_LINK_CHANGE	0x0004
+#define MIIM_DM9161_INTR_INIT 		0x0000
+#define MIIM_DM9161_INTR_STOP	\
+(MIIM_DM9161_INTR_DPLX_MASK | MIIM_DM9161_INTR_SPD_MASK \
+ | MIIM_DM9161_INTR_LINK_MASK | MIIM_DM9161_INTR_MASK)
+
+/* DM9161 10BT Configuration/Status */
+#define MIIM_DM9161_10BTCSR	0x12
+#define MIIM_DM9161_10BTCSR_INIT	0x7800
+
+struct phy_state {
+	unsigned int link:1;
+	unsigned int duplex:1;
+	unsigned int auto_neg:1;
+	unsigned int speed:29;
+};
+
+struct mii_bus {
+	const char *name;
+	void *priv;
+	int (*read)(void *priv, int phy_id, int location);
+	int (*write)(void *priv, int phy_id, int location, uint16_t val);
+	void (*reset)(void *priv);
+
+	/* Auto-filled in values */
+	struct phy_info *phy[32];
+};
+
+/* MII bus registration
+ */
+extern int mii_bus_register(struct mii_bus *bus);
+extern void mii_bus_unregister(struct mii_bus *bus);
+
+/* Raw read/write routines
+ * Returns a 16-bit register value, or < 0 error code
+ */
+extern int mii_bus_read(int bus_id, int phy_id, int reg);
+extern int mii_bus_write(int bus_id, int phy_id, int reg, uint16_t val);
+
+/* Routines used by network devices that use the MII bus
+ */
+extern int mii_phy_attach(struct mii_if_info *mii, struct net_device *dev, int phy_bus, int phy_id);
+extern void mii_phy_detach(struct mii_if_info *mii);
+
+/* Read current phy state
+ */
+extern int mii_phy_state(struct mii_if_info *mii, struct phy_state *state);
+
+/* Use an IRQ to determine when the PHY changes
+ */
+extern int mii_phy_irq_enable(struct mii_if_info *mii,int irq,void (*func)(void *),void *data);
+extern void mii_phy_irq_disable(struct mii_if_info *mii,void *data);
+
+/* Poll the PHY
+ */
+extern int mii_phy_poll_enable(struct mii_if_info *mii, unsigned long msecs, void (*func)(void *),void *data);
+extern void mii_phy_poll_disable(struct mii_if_info *mii,void *data);
+
+#endif /* __MII_BUS_H */


-- 
Jason McMullan <jason.mcmullan@timesys.com>
TimeSys Corporation
