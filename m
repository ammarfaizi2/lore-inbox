Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264386AbUD2Muj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264386AbUD2Muj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 08:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264367AbUD2Muj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 08:50:39 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:38660 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264386AbUD2Msa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 08:48:30 -0400
Date: Thu, 29 Apr 2004 13:48:24 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [RFC] 1/4 MMC layer
Message-ID: <20040429134824.C16407@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch adds core support to the Linux kernel for driving MMC
interfaces found on embedded devices, such as found in the Intel
PXA and ARM MMCI primecell.  This patch does _not_ add support
for SD or SDIO cards.

It is vaguely based upon the handhelds.org MMC code, but the bulk
of the core has been rewritten from scratch.

The only area of concern is the MMC block device support, which,
since the block layer does not really support hotplug, may be
iffy.  I believe Al Viro has some patches to make the block layer
more "hotplug friendly."

Note that MMC is an hotpluggable medium, so we can't just ignore
the issue and hope it goes away.

diff -urpN orig/drivers/mmc/Kconfig linux/drivers/mmc/Kconfig
--- orig/drivers/mmc/Kconfig	Thu Jan  1 01:00:00 1970
+++ linux/drivers/mmc/Kconfig	Fri Oct 17 17:41:27 2003
@@ -0,0 +1,32 @@
+#
+# MMC subsystem configuration
+#
+
+menu "MMC/SD Card support"
+
+config MMC
+	tristate "MMC support"
+	help
+	  MMC is the "multi-media card" bus protocol.
+
+	  If you want MMC support, you should say Y here and also
+	  to the specific driver for your MMC interface.
+
+config MMC_DEBUG
+	bool "MMC debugging"
+	depends on MMC != n
+	help
+	  This is an option for use by developers; most people should
+	  say N here.  This enables MMC core and driver debugging.
+
+config MMC_BLOCK
+	tristate "MMC block device driver"
+	depends on MMC
+	default y
+	help
+	  Say Y here to enable the MMC block device driver support.
+	  This provides a block device driver, which you can use to
+	  mount the filesystem. Almost everyone wishing MMC support
+	  should say Y or M here.
+
+endmenu
diff -urpN orig/drivers/mmc/Makefile linux/drivers/mmc/Makefile
--- orig/drivers/mmc/Makefile	Thu Jan  1 01:00:00 1970
+++ linux/drivers/mmc/Makefile	Mon Jul  7 21:52:01 2003
@@ -0,0 +1,19 @@
+#
+# Makefile for the kernel mmc device drivers.
+#
+
+#
+# Core
+#
+obj-$(CONFIG_MMC)		+= mmc_core.o
+
+#
+# Media drivers
+#
+obj-$(CONFIG_MMC_BLOCK)		+= mmc_block.o
+
+#
+# Host drivers
+#
+
+mmc_core-y := mmc.o mmc_queue.o mmc_sysfs.o
diff -urpN orig/drivers/mmc/mmc.c linux/drivers/mmc/mmc.c
--- orig/drivers/mmc/mmc.c	Thu Jan  1 01:00:00 1970
+++ linux/drivers/mmc/mmc.c	Mon Jan 12 13:12:48 2004
@@ -0,0 +1,823 @@
+/*
+ *  linux/drivers/mmc/mmc.c
+ *
+ *  Copyright (C) 2003 Russell King, All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/completion.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+
+#include <linux/mmc/card.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/protocol.h>
+
+#include "mmc.h"
+
+#ifdef CONFIG_MMC_DEBUG
+#define DBG(x...)	printk(KERN_DEBUG x)
+#else
+#define DBG(x...)	do { } while (0)
+#endif
+
+#define CMD_RETRIES	3
+
+/*
+ * OCR Bit positions to 10s of Vdd mV.
+ */
+static const unsigned short mmc_ocr_bit_to_vdd[] = {
+	150,	155,	160,	165,	170,	180,	190,	200,
+	210,	220,	230,	240,	250,	260,	270,	280,
+	290,	300,	310,	320,	330,	340,	350,	360
+};
+
+static const unsigned int tran_exp[] = {
+	10000,		100000,		1000000,	10000000,
+	0,		0,		0,		0
+};
+
+static const unsigned char tran_mant[] = {
+	0,	10,	12,	13,	15,	20,	25,	30,
+	35,	40,	45,	50,	55,	60,	70,	80,
+};
+
+static const unsigned int tacc_exp[] = {
+	1,	10,	100,	1000,	10000,	100000,	1000000, 10000000,
+};
+
+static const unsigned int tacc_mant[] = {
+	0,	10,	12,	13,	15,	20,	25,	30,
+	35,	40,	45,	50,	55,	60,	70,	80,
+};
+
+
+/**
+ *	mmc_request_done - finish processing an MMC command
+ *	@host: MMC host which completed command
+ *	@cmd: MMC command which completed
+ *	@err: MMC error code
+ *
+ *	MMC drivers should call this function when they have completed
+ *	their processing of a command.  This should be called before the
+ *	data part of the command has completed.
+ */
+void mmc_request_done(struct mmc_host *host, struct mmc_request *req)
+{
+	struct mmc_command *cmd = req->cmd;
+	int err = req->cmd->error;
+	DBG("MMC: req done (%02x): %d: %08x %08x %08x %08x\n", cmd->opcode,
+	    err, cmd->resp[0], cmd->resp[1], cmd->resp[2], cmd->resp[3]);
+
+	if (err && cmd->retries) {
+		cmd->retries--;
+		cmd->error = 0;
+		host->ops->request(host, req);
+	} else if (req->done) {
+		req->done(req);
+	}
+}
+
+EXPORT_SYMBOL(mmc_request_done);
+
+/**
+ *	mmc_start_request - start a command on a host
+ *	@host: MMC host to start command on
+ *	@cmd: MMC command to start
+ *
+ *	Queue a command on the specified host.  We expect the
+ *	caller to be holding the host lock with interrupts disabled.
+ */
+void
+mmc_start_request(struct mmc_host *host, struct mmc_request *req)
+{
+	DBG("MMC: starting cmd %02x arg %08x flags %08x\n",
+	    req->cmd->opcode, req->cmd->arg, req->cmd->flags);
+
+	WARN_ON(host->card_busy == NULL);
+
+	req->cmd->error = 0;
+	req->cmd->req = req;
+	if (req->data) {
+		req->cmd->data = req->data;
+		req->data->error = 0;
+		req->data->req = req;
+		if (req->stop) {
+			req->data->stop = req->stop;
+			req->stop->error = 0;
+			req->stop->req = req;
+		}
+	}
+	host->ops->request(host, req);
+}
+
+EXPORT_SYMBOL(mmc_start_request);
+
+static void mmc_wait_done(struct mmc_request *req)
+{
+	complete(req->done_data);
+}
+
+int mmc_wait_for_req(struct mmc_host *host, struct mmc_request *req)
+{
+	DECLARE_COMPLETION(complete);
+
+	req->done_data = &complete;
+	req->done = mmc_wait_done;
+
+	mmc_start_request(host, req);
+
+	wait_for_completion(&complete);
+
+	return 0;
+}
+
+EXPORT_SYMBOL(mmc_wait_for_req);
+
+/**
+ *	mmc_wait_for_cmd - start a command and wait for completion
+ *	@host: MMC host to start command
+ *	@cmd: MMC command to start
+ *	@retries: maximum number of retries
+ *
+ *	Start a new MMC command for a host, and wait for the command
+ *	to complete.  Return any error that occurred while the command
+ *	was executing.  Do not attempt to parse the response.
+ */
+int mmc_wait_for_cmd(struct mmc_host *host, struct mmc_command *cmd, int retries)
+{
+	struct mmc_request req;
+
+	BUG_ON(host->card_busy == NULL);
+
+	memset(&req, 0, sizeof(struct mmc_request));
+
+	memset(cmd->resp, 0, sizeof(cmd->resp));
+	cmd->retries = retries;
+
+	req.cmd = cmd;
+	cmd->data = NULL;
+
+	mmc_wait_for_req(host, &req);
+
+	return cmd->error;
+}
+
+EXPORT_SYMBOL(mmc_wait_for_cmd);
+
+
+
+/**
+ *	__mmc_claim_host - exclusively claim a host
+ *	@host: mmc host to claim
+ *	@card: mmc card to claim host for
+ *
+ *	Claim a host for a set of operations.  If a valid card
+ *	is passed and this wasn't the last card selected, select
+ *	the card before returning.
+ *
+ *	Note: you should use mmc_card_claim_host or mmc_claim_host.
+ */
+int __mmc_claim_host(struct mmc_host *host, struct mmc_card *card)
+{
+	DECLARE_WAITQUEUE(wait, current);
+	unsigned long flags;
+	int err = 0;
+
+	add_wait_queue(&host->wq, &wait);
+	spin_lock_irqsave(&host->lock, flags);
+	while (1) {
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		if (host->card_busy == NULL)
+			break;
+		spin_unlock_irqrestore(&host->lock, flags);
+		schedule();
+		spin_lock_irqsave(&host->lock, flags);
+	}
+	set_current_state(TASK_RUNNING);
+	host->card_busy = card;
+	spin_unlock_irqrestore(&host->lock, flags);
+	remove_wait_queue(&host->wq, &wait);
+
+	if (card != (void *)-1 && host->card_selected != card) {
+		struct mmc_command cmd;
+
+		host->card_selected = card;
+
+		cmd.opcode = MMC_SELECT_CARD;
+		cmd.arg = card->rca << 16;
+		cmd.flags = MMC_RSP_SHORT | MMC_RSP_CRC;
+
+		err = mmc_wait_for_cmd(host, &cmd, CMD_RETRIES);
+	}
+
+	return err;
+}
+
+EXPORT_SYMBOL(__mmc_claim_host);
+
+/**
+ *	mmc_release_host - release a host
+ *	@host: mmc host to release
+ *
+ *	Release a MMC host, allowing others to claim the host
+ *	for their operations.
+ */
+void mmc_release_host(struct mmc_host *host)
+{
+	unsigned long flags;
+
+	BUG_ON(host->card_busy == NULL);
+
+	spin_lock_irqsave(&host->lock, flags);
+	host->card_busy = NULL;
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	wake_up(&host->wq);
+}
+
+EXPORT_SYMBOL(mmc_release_host);
+
+/*
+ * Ensure that no card is selected.
+ */
+static void mmc_deselect_cards(struct mmc_host *host)
+{
+	struct mmc_command cmd;
+
+	if (host->card_selected) {
+		host->card_selected = NULL;
+
+		cmd.opcode = MMC_SELECT_CARD;
+		cmd.arg = 0;
+		cmd.flags = MMC_RSP_NONE;
+
+		mmc_wait_for_cmd(host, &cmd, 0);
+	}
+}
+
+
+static inline void mmc_delay(unsigned int ms)
+{
+	if (ms < HZ / 1000) {
+		yield();
+		mdelay(ms);
+	} else {
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(ms * HZ / 1000);
+	}
+}
+
+/*
+ * Mask off any voltages we don't support and select
+ * the lowest voltage
+ */
+static u32 mmc_select_voltage(struct mmc_host *host, u32 ocr)
+{
+	int bit;
+
+	ocr &= host->ocr_avail;
+
+	bit = ffs(ocr);
+	if (bit) {
+		bit -= 1;
+
+		ocr = 3 << bit;
+
+		host->ios.vdd = bit;
+		host->ops->set_ios(host, &host->ios);
+	} else {
+		ocr = 0;
+	}
+
+	return ocr;
+}
+
+static void mmc_decode_cid(struct mmc_cid *cid, u32 *resp)
+{
+	memset(cid, 0, sizeof(struct mmc_cid));
+
+	cid->manfid	  = resp[0] >> 8;
+	cid->prod_name[0] = resp[0];
+	cid->prod_name[1] = resp[1] >> 24;
+	cid->prod_name[2] = resp[1] >> 16;
+	cid->prod_name[3] = resp[1] >> 8;
+	cid->prod_name[4] = resp[1];
+	cid->prod_name[5] = resp[2] >> 24;
+	cid->prod_name[6] = resp[2] >> 16;
+	cid->prod_name[7] = '\0';
+	cid->hwrev	  = (resp[2] >> 12) & 15;
+	cid->fwrev	  = (resp[2] >> 8) & 15;
+	cid->serial	  = (resp[2] & 255) << 16 | (resp[3] >> 16);
+	cid->month	  = (resp[3] >> 12) & 15;
+	cid->year	  = (resp[3] >> 8) & 15;
+}
+
+static void mmc_decode_csd(struct mmc_csd *csd, u32 *resp)
+{
+	unsigned int e, m;
+
+	csd->mmc_prot	 = (resp[0] >> 26) & 15;
+	m = (resp[0] >> 19) & 15;
+	e = (resp[0] >> 16) & 7;
+	csd->tacc_ns	 = (tacc_exp[e] * tacc_mant[m] + 9) / 10;
+	csd->tacc_clks	 = ((resp[0] >> 8) & 255) * 100;
+
+	m = (resp[0] >> 3) & 15;
+	e = resp[0] & 7;
+	csd->max_dtr	  = tran_exp[e] * tran_mant[m];
+	csd->cmdclass	  = (resp[1] >> 20) & 0xfff;
+
+	e = (resp[2] >> 15) & 7;
+	m = (resp[1] << 2 | resp[2] >> 30) & 0x3fff;
+	csd->capacity	  = (1 + m) << (e + 2);
+
+	csd->read_blkbits = (resp[1] >> 16) & 15;
+}
+
+/*
+ * Locate a MMC card on this MMC host given a CID.
+ */
+static struct mmc_card *
+mmc_find_card(struct mmc_host *host, struct mmc_cid *cid)
+{
+	struct mmc_card *card;
+
+	list_for_each_entry(card, &host->cards, node) {
+		if (memcmp(&card->cid, cid, sizeof(struct mmc_cid)) == 0)
+			return card;
+	}
+	return NULL;
+}
+
+/*
+ * Allocate a new MMC card, and assign a unique RCA.
+ */
+static struct mmc_card *
+mmc_alloc_card(struct mmc_host *host, struct mmc_cid *cid, unsigned int *frca)
+{
+	struct mmc_card *card, *c;
+	unsigned int rca = *frca;
+
+	card = kmalloc(sizeof(struct mmc_card), GFP_KERNEL);
+	if (!card)
+		return ERR_PTR(-ENOMEM);
+
+	mmc_init_card(card, host);
+	memcpy(&card->cid, cid, sizeof(struct mmc_cid));
+
+ again:
+	list_for_each_entry(c, &host->cards, node)
+		if (c->rca == rca) {
+			rca++;
+			goto again;
+		}
+
+	card->rca = rca;
+
+	*frca = rca;
+
+	return card;
+}
+
+/*
+ * Apply power to the MMC stack.
+ */
+static void mmc_power_up(struct mmc_host *host)
+{
+	struct mmc_command cmd;
+	int bit = fls(host->ocr_avail) - 1;
+
+	host->ios.vdd = bit;
+	host->ios.bus_mode = MMC_BUSMODE_OPENDRAIN;
+	host->ios.power_mode = MMC_POWER_UP;
+	host->ops->set_ios(host, &host->ios);
+
+	mmc_delay(1);
+
+	host->ios.clock = host->f_min;
+	host->ios.power_mode = MMC_POWER_ON;
+	host->ops->set_ios(host, &host->ios);
+
+	mmc_delay(2);
+
+	cmd.opcode = MMC_GO_IDLE_STATE;
+	cmd.arg = 0;
+	cmd.flags = MMC_RSP_NONE;
+
+	mmc_wait_for_cmd(host, &cmd, 0);
+}
+
+static void mmc_power_off(struct mmc_host *host)
+{
+	host->ios.clock = 0;
+	host->ios.vdd = 0;
+	host->ios.bus_mode = MMC_BUSMODE_OPENDRAIN;
+	host->ios.power_mode = MMC_POWER_OFF;
+	host->ops->set_ios(host, &host->ios);
+}
+
+static int mmc_send_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
+{
+	struct mmc_command cmd;
+	int i, err = 0;
+
+	cmd.opcode = MMC_SEND_OP_COND;
+	cmd.arg = ocr;
+	cmd.flags = MMC_RSP_SHORT;
+
+	for (i = 100; i; i--) {
+		err = mmc_wait_for_cmd(host, &cmd, 0);
+		if (err != MMC_ERR_NONE)
+			break;
+
+		if (cmd.resp[0] & MMC_CARD_BUSY || ocr == 0)
+			break;
+
+		err = MMC_ERR_TIMEOUT;
+	}
+
+	if (rocr)
+		*rocr = cmd.resp[0];
+
+	return err;
+}
+
+/*
+ * Discover cards by requesting their CID.  If this command
+ * times out, it is not an error; there are no further cards
+ * to be discovered.  Add new cards to the list.
+ *
+ * Create a mmc_card entry for each discovered card, assigning
+ * it an RCA, and save the CID.
+ */
+static void mmc_discover_cards(struct mmc_host *host)
+{
+	struct mmc_card *card;
+	unsigned int first_rca = 1, err;
+
+	while (1) {
+		struct mmc_command cmd;
+		struct mmc_cid cid;
+
+		cmd.opcode = MMC_ALL_SEND_CID;
+		cmd.arg = 0;
+		cmd.flags = MMC_RSP_LONG | MMC_RSP_CRC;
+
+		err = mmc_wait_for_cmd(host, &cmd, CMD_RETRIES);
+		if (err == MMC_ERR_TIMEOUT) {
+			err = MMC_ERR_NONE;
+			break;
+		}
+		if (err != MMC_ERR_NONE) {
+			printk(KERN_ERR "%s: error requesting CID: %d\n",
+				host->host_name, err);
+			break;
+		}
+
+		mmc_decode_cid(&cid, cmd.resp);
+
+		card = mmc_find_card(host, &cid);
+		if (!card) {
+			card = mmc_alloc_card(host, &cid, &first_rca);
+			if (IS_ERR(card)) {
+				err = PTR_ERR(card);
+				break;
+			}
+			list_add(&card->node, &host->cards);
+		}
+
+		card->state &= ~MMC_STATE_DEAD;
+
+		cmd.opcode = MMC_SET_RELATIVE_ADDR;
+		cmd.arg = card->rca << 16;
+		cmd.flags = MMC_RSP_SHORT | MMC_RSP_CRC;
+
+		err = mmc_wait_for_cmd(host, &cmd, CMD_RETRIES);
+		if (err != MMC_ERR_NONE)
+			card->state |= MMC_STATE_DEAD;
+	}
+}
+
+static void mmc_read_csds(struct mmc_host *host)
+{
+	struct mmc_card *card;
+
+	list_for_each_entry(card, &host->cards, node) {
+		struct mmc_command cmd;
+		int err;
+
+		if (card->state & (MMC_STATE_DEAD|MMC_STATE_PRESENT))
+			continue;
+
+		cmd.opcode = MMC_SEND_CSD;
+		cmd.arg = card->rca << 16;
+		cmd.flags = MMC_RSP_LONG | MMC_RSP_CRC;
+
+		err = mmc_wait_for_cmd(host, &cmd, CMD_RETRIES);
+		if (err != MMC_ERR_NONE) {
+			card->state |= MMC_STATE_DEAD;
+			continue;
+		}
+
+		mmc_decode_csd(&card->csd, cmd.resp);
+	}
+}
+
+static unsigned int mmc_calculate_clock(struct mmc_host *host)
+{
+	struct mmc_card *card;
+	unsigned int max_dtr = host->f_max;
+
+	list_for_each_entry(card, &host->cards, node)
+		if (!mmc_card_dead(card) && max_dtr > card->csd.max_dtr)
+			max_dtr = card->csd.max_dtr;
+
+	DBG("MMC: selected %d.%03dMHz transfer rate\n",
+	    max_dtr / 1000000, (max_dtr / 1000) % 1000);
+
+	return max_dtr;
+}
+
+/*
+ * Check whether cards we already know about are still present.
+ * We do this by requesting status, and checking whether a card
+ * responds.
+ *
+ * A request for status does not cause a state change in data
+ * transfer mode.
+ */
+static void mmc_check_cards(struct mmc_host *host)
+{
+	struct list_head *l, *n;
+
+	mmc_deselect_cards(host);
+
+	list_for_each_safe(l, n, &host->cards) {
+		struct mmc_card *card = mmc_list_to_card(l);
+		struct mmc_command cmd;
+		int err;
+
+		cmd.opcode = MMC_SEND_STATUS;
+		cmd.arg = card->rca << 16;
+		cmd.flags = MMC_RSP_SHORT | MMC_RSP_CRC;
+
+		err = mmc_wait_for_cmd(host, &cmd, CMD_RETRIES);
+		if (err == MMC_ERR_NONE)
+			continue;
+
+		card->state |= MMC_STATE_DEAD;
+	}
+}
+
+static void mmc_setup(struct mmc_host *host)
+{
+	if (host->ios.power_mode != MMC_POWER_ON) {
+		int err;
+		u32 ocr;
+
+		mmc_power_up(host);
+
+		err = mmc_send_op_cond(host, 0, &ocr);
+		if (err != MMC_ERR_NONE)
+			return;
+
+		host->ocr = mmc_select_voltage(host, ocr);
+	} else {
+		host->ios.bus_mode = MMC_BUSMODE_OPENDRAIN;
+		host->ios.clock = host->f_min;
+		host->ops->set_ios(host, &host->ios);
+
+		/*
+		 * We should remember the OCR mask from the existing
+		 * cards, and detect the new cards OCR mask, combine
+		 * the two and re-select the VDD.  However, if we do
+		 * change VDD, we should do an idle, and then do a
+		 * full re-initialisation.  We would need to notify
+		 * drivers so that they can re-setup the cards as
+		 * well, while keeping their queues at bay.
+		 *
+		 * For the moment, we take the easy way out - if the
+		 * new cards don't like our currently selected VDD,
+		 * they drop off the bus.
+		 */
+	}
+
+	if (host->ocr == 0)
+		return;
+
+	/*
+	 * Send the selected OCR multiple times... until the cards
+	 * all get the idea that they should be ready for CMD2.
+	 * (My SanDisk card seems to need this.)
+	 */
+	mmc_send_op_cond(host, host->ocr, NULL);
+
+	mmc_discover_cards(host);
+
+	/*
+	 * Ok, now switch to push-pull mode.
+	 */
+	host->ios.bus_mode = MMC_BUSMODE_PUSHPULL;
+	host->ops->set_ios(host, &host->ios);
+
+	mmc_read_csds(host);
+}
+
+
+/**
+ *	mmc_detect_change - process change of state on a MMC socket
+ *	@host: host which changed state.
+ *
+ *	All we know is that card(s) have been inserted or removed
+ *	from the socket(s).  We don't know which socket or cards.
+ */
+void mmc_detect_change(struct mmc_host *host)
+{
+	schedule_work(&host->detect);
+}
+
+EXPORT_SYMBOL(mmc_detect_change);
+
+
+static void mmc_rescan(void *data)
+{
+	struct mmc_host *host = data;
+	struct list_head *l, *n;
+
+	mmc_claim_host(host);
+
+	if (host->ios.power_mode == MMC_POWER_ON)
+		mmc_check_cards(host);
+
+	mmc_setup(host);
+
+	if (!list_empty(&host->cards)) {
+		/*
+		 * (Re-)calculate the fastest clock rate which the
+		 * attached cards and the host support.
+		 */
+		host->ios.clock = mmc_calculate_clock(host);
+		host->ops->set_ios(host, &host->ios);
+	}
+
+	mmc_release_host(host);
+
+	list_for_each_safe(l, n, &host->cards) {
+		struct mmc_card *card = mmc_list_to_card(l);
+
+		/*
+		 * If this is a new and good card, register it.
+		 */
+		if (!mmc_card_present(card) && !mmc_card_dead(card)) {
+			if (mmc_register_card(card))
+				card->state |= MMC_STATE_DEAD;
+			else
+				card->state |= MMC_STATE_PRESENT;
+		}
+
+		/*
+		 * If this card is dead, destroy it.
+		 */
+		if (mmc_card_dead(card)) {
+			list_del(&card->node);
+			mmc_remove_card(card);
+		}
+	}
+
+	/*
+	 * If we discover that there are no cards on the
+	 * bus, turn off the clock and power down.
+	 */
+	if (list_empty(&host->cards))
+		mmc_power_off(host);
+}
+
+
+/**
+ *	mmc_alloc_host - initialise the per-host structure.
+ *	@extra: sizeof private data structure
+ *	@dev: pointer to host device model structure
+ *
+ *	Initialise the per-host structure.
+ */
+struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
+{
+	struct mmc_host *host;
+
+	host = kmalloc(sizeof(struct mmc_host) + extra, GFP_KERNEL);
+	if (host) {
+		memset(host, 0, sizeof(struct mmc_host) + extra);
+
+		host->priv = host + 1;
+
+		spin_lock_init(&host->lock);
+		init_waitqueue_head(&host->wq);
+		INIT_LIST_HEAD(&host->cards);
+		INIT_WORK(&host->detect, mmc_rescan, host);
+
+		host->dev = dev;
+	}
+
+	return host;
+}
+
+EXPORT_SYMBOL(mmc_alloc_host);
+
+/**
+ *	mmc_add_host - initialise host hardware
+ *	@host: mmc host
+ */
+int mmc_add_host(struct mmc_host *host)
+{
+	static unsigned int host_num;
+
+	snprintf(host->host_name, sizeof(host->host_name),
+		 "mmc%d", host_num++);
+
+	mmc_power_off(host);
+	mmc_detect_change(host);
+
+	return 0;
+}
+
+EXPORT_SYMBOL(mmc_add_host);
+
+/**
+ *	mmc_remove_host - remove host hardware
+ *	@host: mmc host
+ *
+ *	Unregister and remove all cards associated with this host,
+ *	and power down the MMC bus.
+ */
+void mmc_remove_host(struct mmc_host *host)
+{
+	struct list_head *l, *n;
+
+	list_for_each_safe(l, n, &host->cards) {
+		struct mmc_card *card = mmc_list_to_card(l);
+
+		mmc_remove_card(card);
+	}
+
+	mmc_power_off(host);
+}
+
+EXPORT_SYMBOL(mmc_remove_host);
+
+/**
+ *	mmc_free_host - free the host structure
+ *	@host: mmc host
+ *
+ *	Free the host once all references to it have been dropped.
+ */
+void mmc_free_host(struct mmc_host *host)
+{
+	flush_scheduled_work();
+	kfree(host);
+}
+
+EXPORT_SYMBOL(mmc_free_host);
+
+#ifdef CONFIG_PM
+
+/**
+ *	mmc_suspend_host - suspend a host
+ *	@host: mmc host
+ *	@state: suspend mode (PM_SUSPEND_xxx)
+ */
+int mmc_suspend_host(struct mmc_host *host, u32 state)
+{
+	mmc_claim_host(host);
+	mmc_deselect_cards(host);
+	mmc_power_off(host);
+	mmc_release_host(host);
+
+	return 0;
+}
+
+EXPORT_SYMBOL(mmc_suspend_host);
+
+/**
+ *	mmc_resume_host - resume a previously suspended host
+ *	@host: mmc host
+ */
+int mmc_resume_host(struct mmc_host *host)
+{
+	mmc_detect_change(host);
+
+	return 0;
+}
+
+EXPORT_SYMBOL(mmc_resume_host);
+
+#endif
+
+MODULE_LICENSE("GPL");
diff -urpN orig/drivers/mmc/mmc.h linux/drivers/mmc/mmc.h
--- orig/drivers/mmc/mmc.h	Thu Jan  1 01:00:00 1970
+++ linux/drivers/mmc/mmc.h	Mon Jan 12 13:13:03 2004
@@ -0,0 +1,16 @@
+/*
+ *  linux/drivers/mmc/mmc.h
+ *
+ *  Copyright (C) 2003 Russell King, All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef _MMC_H
+#define _MMC_H
+/* core-internal functions */
+void mmc_init_card(struct mmc_card *card, struct mmc_host *host);
+int mmc_register_card(struct mmc_card *card);
+void mmc_remove_card(struct mmc_card *card);
+#endif
diff -urpN orig/drivers/mmc/mmc_block.c linux/drivers/mmc/mmc_block.c
--- orig/drivers/mmc/mmc_block.c	Thu Jan  1 01:00:00 1970
+++ linux/drivers/mmc/mmc_block.c	Mon Jan 12 13:13:43 2004
@@ -0,0 +1,498 @@
+/*
+ * Block driver for media (i.e., flash cards)
+ *
+ * Copyright 2002 Hewlett-Packard Company
+ *
+ * Use consistent with the GNU GPL is permitted,
+ * provided that this copyright notice is
+ * preserved in its entirety in all copies and derived works.
+ *
+ * HEWLETT-PACKARD COMPANY MAKES NO WARRANTIES, EXPRESSED OR IMPLIED,
+ * AS TO THE USEFULNESS OR CORRECTNESS OF THIS CODE OR ITS
+ * FITNESS FOR ANY PARTICULAR PURPOSE.
+ *
+ * Many thanks to Alessandro Rubini and Jonathan Corbet!
+ *
+ * Author:  Andrew Christian
+ *          28 May 2002
+ */
+#include <linux/moduleparam.h>
+#include <linux/module.h>
+#include <linux/init.h>
+
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/errno.h>
+#include <linux/hdreg.h>
+#include <linux/kdev_t.h>
+#include <linux/blkdev.h>
+#include <linux/devfs_fs_kernel.h>
+
+#include <linux/mmc/card.h>
+#include <linux/mmc/protocol.h>
+
+#include <asm/system.h>
+#include <asm/uaccess.h>
+
+#include "mmc_queue.h"
+
+/*
+ * max 8 partitions per card
+ */
+#define MMC_SHIFT	3
+
+static int mmc_major;
+static int maxsectors = 8;
+
+/*
+ * There is one mmc_blk_data per slot.
+ */
+struct mmc_blk_data {
+	spinlock_t	lock;
+	struct gendisk	*disk;
+	struct mmc_queue queue;
+
+	unsigned int	usage;
+	unsigned int	block_bits;
+	unsigned int	suspended;
+};
+
+static DECLARE_MUTEX(open_lock);
+
+static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
+{
+	struct mmc_blk_data *md;
+
+	down(&open_lock);
+	md = disk->private_data;
+	if (md && md->usage == 0)
+		md = NULL;
+	if (md)
+		md->usage++;
+	up(&open_lock);
+
+	return md;
+}
+
+static void mmc_blk_put(struct mmc_blk_data *md)
+{
+	down(&open_lock);
+	md->usage--;
+	if (md->usage == 0) {
+		put_disk(md->disk);
+		mmc_cleanup_queue(&md->queue);
+		kfree(md);
+	}
+	up(&open_lock);
+}
+
+static int mmc_blk_open(struct inode *inode, struct file *filp)
+{
+	struct mmc_blk_data *md;
+	int ret = -ENXIO;
+
+	md = mmc_blk_get(inode->i_bdev->bd_disk);
+	if (md) {
+		if (md->usage == 2)
+			check_disk_change(inode->i_bdev);
+		ret = 0;
+	}
+
+	return ret;
+}
+
+static int mmc_blk_release(struct inode *inode, struct file *filp)
+{
+	struct mmc_blk_data *md = inode->i_bdev->bd_disk->private_data;
+
+	mmc_blk_put(md);
+	return 0;
+}
+
+static int
+mmc_blk_ioctl(struct inode *inode, struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	struct block_device *bdev = inode->i_bdev;
+
+	if (cmd == HDIO_GETGEO) {
+		struct hd_geometry geo;
+
+		memset(&geo, 0, sizeof(struct hd_geometry));
+
+		geo.cylinders	= get_capacity(bdev->bd_disk) / (4 * 16);
+		geo.heads	= 4;
+		geo.sectors	= 16;
+		geo.start	= get_start_sect(bdev);
+
+		return copy_to_user((void *)arg, &geo, sizeof(geo))
+			? -EFAULT : 0;
+	}
+
+	return -ENOTTY;
+}
+
+static struct block_device_operations mmc_bdops = {
+	.open			= mmc_blk_open,
+	.release		= mmc_blk_release,
+	.ioctl			= mmc_blk_ioctl,
+	.owner			= THIS_MODULE,
+};
+
+struct mmc_blk_request {
+	struct mmc_request	req;
+	struct mmc_command	cmd;
+	struct mmc_command	stop;
+	struct mmc_data		data;
+};
+
+static int mmc_blk_prep_rq(struct mmc_queue *mq, struct request *req)
+{
+	struct mmc_blk_data *md = mq->data;
+
+	/*
+	 * If we have no device, we haven't finished initialising.
+	 */
+	if (!md || !mq->card) {
+		printk(KERN_ERR "%s: killing request - no device/host\n",
+		       req->rq_disk->disk_name);
+		goto kill;
+	}
+
+	if (md->suspended) {
+		blk_plug_device(md->queue.queue);
+		goto defer;
+	}
+
+	/*
+	 * Check for excessive requests.
+	 */
+	if (req->sector + req->nr_sectors > get_capacity(req->rq_disk)) {
+		printk(KERN_ERR "%s: bad request size\n",
+		       req->rq_disk->disk_name);
+		goto kill;
+	}
+
+	return BLKPREP_OK;
+
+ defer:
+	return BLKPREP_DEFER;
+ kill:
+	return BLKPREP_KILL;
+}
+
+static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
+{
+	struct mmc_blk_data *md = mq->data;
+	struct mmc_card *card = md->queue.card;
+	int err, sz = 0;
+
+	err = mmc_card_claim_host(card);
+	if (err)
+		goto cmd_err;
+
+	do {
+		struct mmc_blk_request rq;
+		struct mmc_command cmd;
+
+		memset(&rq, 0, sizeof(struct mmc_blk_request));
+		rq.req.cmd = &rq.cmd;
+		rq.req.data = &rq.data;
+
+		rq.cmd.arg = req->sector << 9;
+		rq.cmd.flags = MMC_RSP_SHORT | MMC_RSP_CRC;
+		rq.data.rq = req;
+		rq.data.timeout_ns = card->csd.tacc_ns * 10;
+		rq.data.timeout_clks = card->csd.tacc_clks * 10;
+		rq.data.blksz_bits = md->block_bits;
+		rq.data.blocks = req->current_nr_sectors >> (md->block_bits - 9);
+		rq.stop.opcode = MMC_STOP_TRANSMISSION;
+		rq.stop.arg = 0;
+		rq.stop.flags = MMC_RSP_SHORT | MMC_RSP_CRC | MMC_RSP_BUSY;
+
+		if (rq_data_dir(req) == READ) {
+			rq.cmd.opcode = rq.data.blocks > 1 ? MMC_READ_MULTIPLE_BLOCK : MMC_READ_SINGLE_BLOCK;
+			rq.data.flags |= MMC_DATA_READ;
+		} else {
+			rq.cmd.opcode = MMC_WRITE_BLOCK;
+			rq.cmd.flags |= MMC_RSP_BUSY;
+			rq.data.flags |= MMC_DATA_WRITE;
+			rq.data.blocks = 1;
+		}
+		rq.req.stop = rq.data.blocks > 1 ? &rq.stop : NULL;
+
+		mmc_wait_for_req(card->host, &rq.req);
+		if (rq.cmd.error) {
+			err = rq.cmd.error;
+			printk(KERN_ERR "%s: error %d sending read/write command\n",
+			       req->rq_disk->disk_name, err);
+			goto cmd_err;
+		}
+
+		if (rq_data_dir(req) == READ) {
+			sz = rq.data.bytes_xfered;
+		} else {
+			sz = 0;
+		}
+
+		if (rq.data.error) {
+			err = rq.data.error;
+			printk(KERN_ERR "%s: error %d transferring data\n",
+			       req->rq_disk->disk_name, err);
+			goto cmd_err;
+		}
+
+		if (rq.stop.error) {
+			err = rq.stop.error;
+			printk(KERN_ERR "%s: error %d sending stop command\n",
+			       req->rq_disk->disk_name, err);
+			goto cmd_err;
+		}
+
+		do {
+			cmd.opcode = MMC_SEND_STATUS;
+			cmd.arg = card->rca << 16;
+			cmd.flags = MMC_RSP_SHORT | MMC_RSP_CRC;
+			err = mmc_wait_for_cmd(card->host, &cmd, 5);
+			if (err) {
+				printk(KERN_ERR "%s: error %d requesting status\n",
+				       req->rq_disk->disk_name, err);
+				goto cmd_err;
+			}
+		} while (!(cmd.resp[0] & R1_READY_FOR_DATA));
+
+#if 0
+		if (cmd.resp[0] & ~0x00000900)
+			printk(KERN_ERR "%s: status = %08x\n",
+			       req->rq_disk->disk_name, cmd.resp[0]);
+		err = mmc_decode_status(cmd.resp);
+		if (err)
+			goto cmd_err;
+#endif
+
+		sz = rq.data.bytes_xfered;
+	} while (end_that_request_chunk(req, 1, sz));
+
+	mmc_card_release_host(card);
+
+	return 1;
+
+ cmd_err:
+	mmc_card_release_host(card);
+
+	end_that_request_chunk(req, 1, sz);
+	req->errors = err;
+
+	return 0;
+}
+
+#define MMC_NUM_MINORS	(256 >> MMC_SHIFT)
+
+static unsigned long dev_use[MMC_NUM_MINORS/(8*sizeof(unsigned long))];
+
+static struct mmc_blk_data *mmc_blk_alloc(struct mmc_card *card)
+{
+	struct mmc_blk_data *md;
+	int devidx, ret;
+
+	devidx = find_first_zero_bit(dev_use, MMC_NUM_MINORS);
+	if (devidx >= MMC_NUM_MINORS)
+		return ERR_PTR(-ENOSPC);
+	__set_bit(devidx, dev_use);
+
+	md = kmalloc(sizeof(struct mmc_blk_data), GFP_KERNEL);
+	if (md) {
+		memset(md, 0, sizeof(struct mmc_blk_data));
+
+		md->disk = alloc_disk(1 << MMC_SHIFT);
+		if (md->disk == NULL) {
+			kfree(md);
+			md = ERR_PTR(-ENOMEM);
+			goto out;
+		}
+
+		spin_lock_init(&md->lock);
+		md->usage = 1;
+
+		ret = mmc_init_queue(&md->queue, card, &md->lock);
+		if (ret) {
+			put_disk(md->disk);
+			kfree(md);
+			md = ERR_PTR(ret);
+			goto out;
+		}
+		md->queue.prep_fn = mmc_blk_prep_rq;
+		md->queue.issue_fn = mmc_blk_issue_rq;
+		md->queue.data = md;
+
+		md->disk->major	= mmc_major;
+		md->disk->first_minor = devidx << MMC_SHIFT;
+		md->disk->fops = &mmc_bdops;
+		md->disk->private_data = md;
+		md->disk->queue = md->queue.queue;
+		md->disk->driverfs_dev = &card->dev;
+
+		sprintf(md->disk->disk_name, "mmcblk%d", devidx);
+		sprintf(md->disk->devfs_name, "mmc/blk%d", devidx);
+
+		md->block_bits = md->queue.card->csd.read_blkbits;
+
+		blk_queue_max_sectors(md->queue.queue, maxsectors);
+		blk_queue_hardsect_size(md->queue.queue, 1 << md->block_bits);
+		set_capacity(md->disk, md->queue.card->csd.capacity);
+	}
+ out:
+	return md;
+}
+
+static int
+mmc_blk_set_blksize(struct mmc_blk_data *md, struct mmc_card *card)
+{
+	struct mmc_command cmd;
+	int err;
+
+	mmc_card_claim_host(card);
+	cmd.opcode = MMC_SET_BLOCKLEN;
+	cmd.arg = 1 << card->csd.read_blkbits;
+	cmd.flags = MMC_RSP_SHORT | MMC_RSP_CRC;
+	err = mmc_wait_for_cmd(card->host, &cmd, 5);
+	mmc_card_release_host(card);
+
+	if (err) {
+		printk(KERN_ERR "%s: unable to set block size to %d: %d\n",
+			md->disk->disk_name, cmd.arg, err);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int mmc_blk_probe(struct mmc_card *card)
+{
+	struct mmc_blk_data *md;
+	int err;
+
+	if (card->csd.cmdclass & ~0x1ff)
+		return -ENODEV;
+
+	if (card->csd.read_blkbits < 9) {
+		printk(KERN_WARNING "%s: read blocksize too small (%u)\n",
+			mmc_card_id(card), 1 << card->csd.read_blkbits);
+		return -ENODEV;
+	}
+
+	md = mmc_blk_alloc(card);
+	if (IS_ERR(md))
+		return PTR_ERR(md);
+
+	err = mmc_blk_set_blksize(md, card);
+	if (err)
+		goto out;
+
+	printk(KERN_INFO "%s: %s %s %dKiB\n",
+		md->disk->disk_name, mmc_card_id(card), mmc_card_name(card),
+		(card->csd.capacity << card->csd.read_blkbits) / 1024);
+
+	mmc_set_drvdata(card, md);
+	add_disk(md->disk);
+	return 0;
+
+ out:
+	mmc_blk_put(md);
+
+	return err;
+}
+
+static void mmc_blk_remove(struct mmc_card *card)
+{
+	struct mmc_blk_data *md = mmc_get_drvdata(card);
+
+	if (md) {
+		int devidx;
+
+		del_gendisk(md->disk);
+
+		/*
+		 * I think this is needed.
+		 */
+		md->disk->queue = NULL;
+
+		devidx = md->disk->first_minor >> MMC_SHIFT;
+		__clear_bit(devidx, dev_use);
+
+		mmc_blk_put(md);
+	}
+	mmc_set_drvdata(card, NULL);
+}
+
+#ifdef CONFIG_PM
+static int mmc_blk_suspend(struct mmc_card *card, u32 state)
+{
+	struct mmc_blk_data *md = mmc_get_drvdata(card);
+
+	if (md) {
+		blk_stop_queue(md->queue.queue);
+	}
+	return 0;
+}
+
+static int mmc_blk_resume(struct mmc_card *card)
+{
+	struct mmc_blk_data *md = mmc_get_drvdata(card);
+
+	if (md) {
+		mmc_blk_set_blksize(md, md->queue.card);
+		blk_start_queue(md->queue.queue);
+	}
+	return 0;
+}
+#else
+#define	mmc_blk_suspend	NULL
+#define mmc_blk_resume	NULL
+#endif
+
+static struct mmc_driver mmc_driver = {
+	.drv		= {
+		.name	= "mmcblk",
+	},
+	.probe		= mmc_blk_probe,
+	.remove		= mmc_blk_remove,
+	.suspend	= mmc_blk_suspend,
+	.resume		= mmc_blk_resume,
+};
+
+static int __init mmc_blk_init(void)
+{
+	int res = -ENOMEM;
+
+	res = register_blkdev(mmc_major, "mmc");
+	if (res < 0) {
+		printk(KERN_WARNING "Unable to get major %d for MMC media: %d\n",
+		       mmc_major, res);
+		goto out;
+	}
+	if (mmc_major == 0)
+		mmc_major = res;
+
+	devfs_mk_dir("mmc");
+	return mmc_register_driver(&mmc_driver);
+
+ out:
+	return res;
+}
+
+static void __exit mmc_blk_exit(void)
+{
+	mmc_unregister_driver(&mmc_driver);
+	devfs_remove("mmc");
+	unregister_blkdev(mmc_major, "mmc");
+}
+
+module_init(mmc_blk_init);
+module_exit(mmc_blk_exit);
+module_param(maxsectors, int, 0444);
+
+MODULE_PARM_DESC(maxsectors, "Maximum number of sectors for a single request");
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Multimedia Card (MMC) block device driver");
diff -urpN orig/drivers/mmc/mmc_queue.c linux/drivers/mmc/mmc_queue.c
--- orig/drivers/mmc/mmc_queue.c	Thu Jan  1 01:00:00 1970
+++ linux/drivers/mmc/mmc_queue.c	Thu Jan  1 15:09:33 2004
@@ -0,0 +1,175 @@
+/*
+ *  linux/drivers/mmc/mmc_queue.c
+ *
+ *  Copyright (C) 2003 Russell King, All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+#include <linux/module.h>
+#include <linux/blkdev.h>
+
+#include <linux/mmc/card.h>
+#include <linux/mmc/host.h>
+#include "mmc_queue.h"
+
+/*
+ * Prepare a MMC request.  Essentially, this means passing the
+ * preparation off to the media driver.  The media driver will
+ * create a mmc_io_request in req->special.
+ */
+static int mmc_prep_request(struct request_queue *q, struct request *req)
+{
+	struct mmc_queue *mq = q->queuedata;
+	int ret = BLKPREP_KILL;
+
+	if (req->flags & REQ_SPECIAL) {
+		/*
+		 * Special commands already have the command
+		 * blocks already setup in req->special.
+		 */
+		BUG_ON(!req->special);
+
+		ret = BLKPREP_OK;
+	} else if (req->flags & (REQ_CMD | REQ_BLOCK_PC)) {
+		/*
+		 * Block I/O requests need translating according
+		 * to the protocol.
+		 */
+		ret = mq->prep_fn(mq, req);
+	} else {
+		/*
+		 * Everything else is invalid.
+		 */
+		blk_dump_rq_flags(req, "MMC bad request");
+	}
+
+	if (ret == BLKPREP_OK)
+		req->flags |= REQ_DONTPREP;
+
+	return ret;
+}
+
+static int mmc_queue_thread(void *d)
+{
+	struct mmc_queue *mq = d;
+	struct request_queue *q = mq->queue;
+	DECLARE_WAITQUEUE(wait, current);
+	int ret;
+
+	/*
+	 * Set iothread to ensure that we aren't put to sleep by
+	 * the process freezing.  We handle suspension ourselves.
+	 */
+	current->flags |= PF_MEMALLOC|PF_NOFREEZE;
+
+	daemonize("mmcqd");
+
+	spin_lock_irq(&current->sighand->siglock);
+	sigfillset(&current->blocked);
+	recalc_sigpending();
+	spin_unlock_irq(&current->sighand->siglock);
+
+	mq->thread = current;
+	complete(&mq->thread_complete);
+
+	add_wait_queue(&mq->thread_wq, &wait);
+	spin_lock_irq(q->queue_lock);
+	do {
+		struct request *req = NULL;
+
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (!blk_queue_plugged(q))
+			mq->req = req = elv_next_request(q);
+		spin_unlock(q->queue_lock);
+
+		if (!req) {
+			if (!mq->thread)
+				break;
+			schedule();
+			continue;
+		}
+		set_current_state(TASK_RUNNING);
+
+		ret = mq->issue_fn(mq, req);
+
+		spin_lock_irq(q->queue_lock);
+		end_request(req, ret);
+	} while (1);
+	remove_wait_queue(&mq->thread_wq, &wait);
+
+	complete_and_exit(&mq->thread_complete, 0);
+	return 0;
+}
+
+/*
+ * Generic MMC request handler.  This is called for any queue on a
+ * particular host.  When the host is not busy, we look for a request
+ * on any queue on this host, and attempt to issue it.  This may
+ * not be the queue we were asked to process.
+ */
+static void mmc_request(request_queue_t *q)
+{
+	struct mmc_queue *mq = q->queuedata;
+
+	if (!mq->req && !blk_queue_plugged(q))
+		wake_up(&mq->thread_wq);
+}
+
+/**
+ * mmc_init_queue - initialise a queue structure.
+ * @mq: mmc queue
+ * @card: mmc card to attach this queue
+ * @lock: queue lock
+ *
+ * Initialise a MMC card request queue.
+ */
+int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card, spinlock_t *lock)
+{
+	u64 limit = BLK_BOUNCE_HIGH;
+	int ret;
+
+	if (card->host->dev->dma_mask)
+		limit = *card->host->dev->dma_mask;
+
+	mq->card = card;
+	mq->queue = blk_init_queue(mmc_request, lock);
+	if (!mq->queue)
+		return -ENOMEM;
+
+	blk_queue_prep_rq(mq->queue, mmc_prep_request);
+	blk_queue_bounce_limit(mq->queue, limit);
+
+	mq->queue->queuedata = mq;
+	mq->req = NULL;
+
+	init_completion(&mq->thread_complete);
+	init_waitqueue_head(&mq->thread_wq);
+
+	ret = kernel_thread(mmc_queue_thread, mq, CLONE_KERNEL);
+	if (ret < 0) {
+		blk_cleanup_queue(mq->queue);
+	} else {
+		wait_for_completion(&mq->thread_complete);
+		init_completion(&mq->thread_complete);
+		ret = 0;
+	}
+
+	return ret;
+}
+
+EXPORT_SYMBOL(mmc_init_queue);
+
+void mmc_cleanup_queue(struct mmc_queue *mq)
+{
+	mq->thread = NULL;
+	wake_up(&mq->thread_wq);
+	wait_for_completion(&mq->thread_complete);
+	blk_cleanup_queue(mq->queue);
+
+	mq->card = NULL;
+}
+
+EXPORT_SYMBOL(mmc_cleanup_queue);
diff -urpN orig/drivers/mmc/mmc_queue.h linux/drivers/mmc/mmc_queue.h
--- orig/drivers/mmc/mmc_queue.h	Thu Jan  1 01:00:00 1970
+++ linux/drivers/mmc/mmc_queue.h	Thu Aug 14 18:11:18 2003
@@ -0,0 +1,29 @@
+#ifndef MMC_QUEUE_H
+#define MMC_QUEUE_H
+
+struct request;
+struct task_struct;
+
+struct mmc_queue {
+	struct mmc_card		*card;
+	struct completion	thread_complete;
+	wait_queue_head_t	thread_wq;
+	struct task_struct	*thread;
+	struct request		*req;
+	int			(*prep_fn)(struct mmc_queue *, struct request *);
+	int			(*issue_fn)(struct mmc_queue *, struct request *);
+	void			*data;
+	struct request_queue	*queue;
+};
+
+struct mmc_io_request {
+	struct request		*rq;
+	int			num;
+	struct mmc_command	selcmd;		/* mmc_queue private */
+	struct mmc_command	cmd[4];		/* max 4 commands */
+};
+
+extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, spinlock_t *);
+extern void mmc_cleanup_queue(struct mmc_queue *);
+
+#endif
diff -urpN orig/drivers/mmc/mmc_sysfs.c linux/drivers/mmc/mmc_sysfs.c
--- orig/drivers/mmc/mmc_sysfs.c	Thu Jan  1 01:00:00 1970
+++ linux/drivers/mmc/mmc_sysfs.c	Thu Jan  1 19:50:26 2004
@@ -0,0 +1,231 @@
+/*
+ *  linux/drivers/mmc/mmc_sysfs.c
+ *
+ *  Copyright (C) 2003 Russell King, All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ *  MMC sysfs/driver model support.
+ */
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/device.h>
+
+#include <linux/mmc/card.h>
+#include <linux/mmc/host.h>
+
+#include "mmc.h"
+
+#define dev_to_mmc_card(d)	container_of(d, struct mmc_card, dev)
+#define to_mmc_driver(d)	container_of(d, struct mmc_driver, drv)
+
+static void mmc_release_card(struct device *dev)
+{
+	struct mmc_card *card = dev_to_mmc_card(dev);
+
+	kfree(card);
+}
+
+/*
+ * This currently matches any MMC driver to any MMC card - drivers
+ * themselves make the decision whether to drive this card in their
+ * probe method.
+ */
+static int mmc_bus_match(struct device *dev, struct device_driver *drv)
+{
+	return 1;
+}
+
+static int
+mmc_bus_hotplug(struct device *dev, char **envp, int num_envp, char *buf,
+		int buf_size)
+{
+	struct mmc_card *card = dev_to_mmc_card(dev);
+	char ccc[13];
+	int i = 0;
+
+#define add_env(fmt,val)						\
+	({								\
+		int len, ret = -ENOMEM;					\
+		if (i < num_envp) {					\
+			envp[i++] = buf;				\
+			len = snprintf(buf, buf_size, fmt, val) + 1;	\
+			buf_size -= len;				\
+			buf += len;					\
+			if (buf_size >= 0)				\
+				ret = 0;				\
+		}							\
+		ret;							\
+	})
+
+	for (i = 0; i < 12; i++)
+		ccc[i] = card->csd.cmdclass & (1 << i) ? '1' : '0';
+	ccc[12] = '\0';
+
+	i = 0;
+	add_env("MMC_CCC=%s", ccc);
+	add_env("MMC_MANFID=%03x", card->cid.manfid);
+	add_env("MMC_SLOT_NAME=%s", card->dev.bus_id);
+
+	return 0;
+}
+
+static int mmc_bus_suspend(struct device *dev, u32 state)
+{
+	struct mmc_driver *drv = to_mmc_driver(dev->driver);
+	struct mmc_card *card = dev_to_mmc_card(dev);
+	int ret = 0;
+
+	if (dev->driver && drv->suspend)
+		ret = drv->suspend(card, state);
+	return ret;
+}
+
+static int mmc_bus_resume(struct device *dev)
+{
+	struct mmc_driver *drv = to_mmc_driver(dev->driver);
+	struct mmc_card *card = dev_to_mmc_card(dev);
+	int ret = 0;
+
+	if (dev->driver && drv->resume)
+		ret = drv->resume(card);
+	return ret;
+}
+
+static struct bus_type mmc_bus_type = {
+	.name		= "mmc",
+	.match		= mmc_bus_match,
+	.hotplug	= mmc_bus_hotplug,
+	.suspend	= mmc_bus_suspend,
+	.resume		= mmc_bus_resume,
+};
+
+
+static int mmc_drv_probe(struct device *dev)
+{
+	struct mmc_driver *drv = to_mmc_driver(dev->driver);
+	struct mmc_card *card = dev_to_mmc_card(dev);
+
+	return drv->probe(card);
+}
+
+static int mmc_drv_remove(struct device *dev)
+{
+	struct mmc_driver *drv = to_mmc_driver(dev->driver);
+	struct mmc_card *card = dev_to_mmc_card(dev);
+
+	drv->remove(card);
+
+	return 0;
+}
+
+
+/**
+ *	mmc_register_driver - register a media driver
+ *	@drv: MMC media driver
+ */
+int mmc_register_driver(struct mmc_driver *drv)
+{
+	drv->drv.bus = &mmc_bus_type;
+	drv->drv.probe = mmc_drv_probe;
+	drv->drv.remove = mmc_drv_remove;
+	return driver_register(&drv->drv);
+}
+
+EXPORT_SYMBOL(mmc_register_driver);
+
+/**
+ *	mmc_unregister_driver - unregister a media driver
+ *	@drv: MMC media driver
+ */
+void mmc_unregister_driver(struct mmc_driver *drv)
+{
+	drv->drv.bus = &mmc_bus_type;
+	driver_unregister(&drv->drv);
+}
+
+EXPORT_SYMBOL(mmc_unregister_driver);
+
+
+#define MMC_ATTR(name, fmt, args...)					\
+static ssize_t mmc_dev_show_##name (struct device *dev, char *buf)	\
+{									\
+	struct mmc_card *card = dev_to_mmc_card(dev);			\
+	return sprintf(buf, fmt, args);					\
+}									\
+static DEVICE_ATTR(name, S_IRUGO, mmc_dev_show_##name, NULL)
+
+MMC_ATTR(date, "%02d/%04d\n", card->cid.month, 1997 + card->cid.year);
+MMC_ATTR(fwrev, "0x%x\n", card->cid.fwrev);
+MMC_ATTR(hwrev, "0x%x\n", card->cid.hwrev);
+MMC_ATTR(manfid, "0x%03x\n", card->cid.manfid);
+MMC_ATTR(serial, "0x%06x\n", card->cid.serial);
+MMC_ATTR(name, "%s\n", card->cid.prod_name);
+
+static struct device_attribute *mmc_dev_attributes[] = {
+	&dev_attr_date,
+	&dev_attr_fwrev,
+	&dev_attr_hwrev,
+	&dev_attr_manfid,
+	&dev_attr_serial,
+	&dev_attr_name,
+};
+
+/*
+ * Internal function.  Initialise a MMC card structure.
+ */
+void mmc_init_card(struct mmc_card *card, struct mmc_host *host)
+{
+	memset(card, 0, sizeof(struct mmc_card));
+	card->host = host;
+	device_initialize(&card->dev);
+	card->dev.parent = card->host->dev;
+	card->dev.bus = &mmc_bus_type;
+	card->dev.release = mmc_release_card;
+}
+
+/*
+ * Internal function.  Register a new MMC card with the driver model.
+ */
+int mmc_register_card(struct mmc_card *card)
+{
+	int ret, i;
+
+	snprintf(card->dev.bus_id, sizeof(card->dev.bus_id),
+		 "%s:%04x", card->host->host_name, card->rca);
+
+	ret = device_add(&card->dev);
+	if (ret == 0)
+		for (i = 0; i < ARRAY_SIZE(mmc_dev_attributes); i++)
+			device_create_file(&card->dev, mmc_dev_attributes[i]);
+
+	return ret;
+}
+
+/*
+ * Internal function.  Unregister a new MMC card with the
+ * driver model, and (eventually) free it.
+ */
+void mmc_remove_card(struct mmc_card *card)
+{
+	if (mmc_card_present(card))
+		device_del(&card->dev);
+
+	put_device(&card->dev);
+}
+
+
+static int __init mmc_init(void)
+{
+	return bus_register(&mmc_bus_type);
+}
+
+static void __exit mmc_exit(void)
+{
+	bus_unregister(&mmc_bus_type);
+}
+
+module_init(mmc_init);
+module_exit(mmc_exit);
diff -urpN orig/include/linux/mmc/card.h linux/include/linux/mmc/card.h
--- orig/include/linux/mmc/card.h	Thu Jan  1 01:00:00 1970
+++ linux/include/linux/mmc/card.h	Fri Aug 29 20:11:30 2003
@@ -0,0 +1,83 @@
+/*
+ *  linux/include/linux/mmc/card.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ *  Card driver specific definitions.
+ */
+#ifndef LINUX_MMC_CARD_H
+#define LINUX_MMC_CARD_H
+
+#include <linux/mmc/mmc.h>
+
+struct mmc_cid {
+	unsigned int		manfid;
+	unsigned int		serial;
+	char			prod_name[8];
+	unsigned char		hwrev;
+	unsigned char		fwrev;
+	unsigned char		month;
+	unsigned char		year;
+};
+
+struct mmc_csd {
+	unsigned char		mmc_prot;
+	unsigned short		cmdclass;
+	unsigned short		tacc_clks;
+	unsigned int		tacc_ns;
+	unsigned int		max_dtr;
+	unsigned int		read_blkbits;
+	unsigned int		capacity;
+};
+
+struct mmc_host;
+
+/*
+ * MMC device
+ */
+struct mmc_card {
+	struct list_head	node;		/* node in hosts devices list */
+	struct mmc_host		*host;		/* the host this device belongs to */
+	struct device		dev;		/* the device */
+	unsigned int		rca;		/* relative card address of device */
+	unsigned int		state;		/* (our) card state */
+#define MMC_STATE_PRESENT	(1<<0)
+#define MMC_STATE_DEAD		(1<<1)
+	struct mmc_cid		cid;		/* card identification */
+	struct mmc_csd		csd;		/* card specific */
+};
+
+#define mmc_card_dead(c)	((c)->state & MMC_STATE_DEAD)
+#define mmc_card_present(c)	((c)->state & MMC_STATE_PRESENT)
+
+#define mmc_card_name(c)	((c)->cid.prod_name)
+#define mmc_card_id(c)		((c)->dev.bus_id)
+
+#define mmc_list_to_card(l)	container_of(l, struct mmc_card, node)
+#define mmc_get_drvdata(c)	dev_get_drvdata(&(c)->dev)
+#define mmc_set_drvdata(c,d)	dev_set_drvdata(&(c)->dev, d)
+
+/*
+ * MMC device driver (e.g., Flash card, I/O card...)
+ */
+struct mmc_driver {
+	struct device_driver drv;
+	int (*probe)(struct mmc_card *);
+	void (*remove)(struct mmc_card *);
+	int (*suspend)(struct mmc_card *, u32);
+	int (*resume)(struct mmc_card *);
+};
+
+extern int mmc_register_driver(struct mmc_driver *);
+extern void mmc_unregister_driver(struct mmc_driver *);
+
+static inline int mmc_card_claim_host(struct mmc_card *card)
+{
+	return __mmc_claim_host(card->host, card);
+}
+
+#define mmc_card_release_host(c)	mmc_release_host((c)->host)
+
+#endif
diff -urpN orig/include/linux/mmc/host.h linux/include/linux/mmc/host.h
--- orig/include/linux/mmc/host.h	Thu Jan  1 01:00:00 1970
+++ linux/include/linux/mmc/host.h	Thu Jan  1 19:49:23 2004
@@ -0,0 +1,102 @@
+/*
+ *  linux/include/linux/mmc/host.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ *  Host driver specific definitions.
+ */
+#ifndef LINUX_MMC_HOST_H
+#define LINUX_MMC_HOST_H
+
+#include <linux/mmc/mmc.h>
+
+struct mmc_ios {
+	unsigned int	clock;			/* clock rate */
+	unsigned short	vdd;
+
+#define	MMC_VDD_150	0
+#define	MMC_VDD_155	1
+#define	MMC_VDD_160	2
+#define	MMC_VDD_165	3
+#define	MMC_VDD_170	4
+#define	MMC_VDD_180	5
+#define	MMC_VDD_190	6
+#define	MMC_VDD_200	7
+#define	MMC_VDD_210	8
+#define	MMC_VDD_220	9
+#define	MMC_VDD_230	10
+#define	MMC_VDD_240	11
+#define	MMC_VDD_250	12
+#define	MMC_VDD_260	13
+#define	MMC_VDD_270	14
+#define	MMC_VDD_280	15
+#define	MMC_VDD_290	16
+#define	MMC_VDD_300	17
+#define	MMC_VDD_310	18
+#define	MMC_VDD_320	19
+#define	MMC_VDD_330	20
+#define	MMC_VDD_340	21
+#define	MMC_VDD_350	22
+#define	MMC_VDD_360	23
+
+	unsigned char	bus_mode;		/* command output mode */
+
+#define MMC_BUSMODE_OPENDRAIN	1
+#define MMC_BUSMODE_PUSHPULL	2
+
+	unsigned char	power_mode;		/* power supply mode */
+
+#define MMC_POWER_OFF		0
+#define MMC_POWER_UP		1
+#define MMC_POWER_ON		2
+};
+
+struct mmc_host_ops {
+	void	(*request)(struct mmc_host *host, struct mmc_request *req);
+	void	(*set_ios)(struct mmc_host *host, struct mmc_ios *ios);
+};
+
+struct mmc_card;
+struct device;
+
+struct mmc_host {
+	struct device		*dev;
+	struct mmc_host_ops	*ops;
+	void			*priv;
+	unsigned int		f_min;
+	unsigned int		f_max;
+	u32			ocr_avail;
+	char			host_name[8];
+
+	/* private data */
+	struct mmc_ios		ios;		/* current io bus settings */
+	u32			ocr;		/* the current OCR setting */
+
+	struct list_head	cards;		/* devices attached to this host */
+
+	wait_queue_head_t	wq;
+	spinlock_t		lock;		/* card_busy lock */
+	struct mmc_card		*card_busy;	/* the MMC card claiming host */
+	struct mmc_card		*card_selected;	/* the selected MMC card */
+
+	struct work_struct	detect;
+};
+
+extern struct mmc_host *mmc_alloc_host(int extra, struct device *);
+extern int mmc_add_host(struct mmc_host *);
+extern void mmc_remove_host(struct mmc_host *);
+extern void mmc_free_host(struct mmc_host *);
+
+#define mmc_priv(x)	((void *)((x) + 1))
+#define mmc_dev(x)	((x)->dev)
+
+extern int mmc_suspend_host(struct mmc_host *, u32);
+extern int mmc_resume_host(struct mmc_host *);
+
+extern void mmc_detect_change(struct mmc_host *);
+extern void mmc_request_done(struct mmc_host *, struct mmc_request *);
+
+#endif
+
diff -urpN orig/include/linux/mmc/mmc.h linux/include/linux/mmc/mmc.h
--- orig/include/linux/mmc/mmc.h	Thu Jan  1 01:00:00 1970
+++ linux/include/linux/mmc/mmc.h	Fri Jul 11 15:19:05 2003
@@ -0,0 +1,88 @@
+/*
+ *  linux/include/linux/mmc/mmc.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef MMC_H
+#define MMC_H
+
+#include <linux/list.h>
+#include <linux/interrupt.h>
+#include <linux/device.h>
+
+struct request;
+struct mmc_data;
+struct mmc_request;
+
+struct mmc_command {
+	u32			opcode;
+	u32			arg;
+	u32			resp[4];
+	unsigned int		flags;		/* expected response type */
+#define MMC_RSP_NONE	(0 << 0)
+#define MMC_RSP_SHORT	(1 << 0)
+#define MMC_RSP_LONG	(2 << 0)
+#define MMC_RSP_MASK	(3 << 0)
+#define MMC_RSP_CRC	(1 << 3)		/* expect valid crc */
+#define MMC_RSP_BUSY	(1 << 4)		/* card may send busy */
+
+	unsigned int		retries;	/* max number of retries */
+	unsigned int		error;		/* command error */
+
+#define MMC_ERR_NONE	0
+#define MMC_ERR_TIMEOUT	1
+#define MMC_ERR_BADCRC	2
+#define MMC_ERR_FIFO	3
+#define MMC_ERR_FAILED	4
+#define MMC_ERR_INVALID	5
+
+	struct mmc_data		*data;		/* data segment associated with cmd */
+	struct mmc_request	*req;		/* assoicated request */
+};
+
+struct mmc_data {
+	unsigned int		timeout_ns;	/* data timeout (in ns, max 80ms) */
+	unsigned int		timeout_clks;	/* data timeout (in clocks) */
+	unsigned int		blksz_bits;	/* data block size */
+	unsigned int		blocks;		/* number of blocks */
+	struct request		*rq;		/* request structure */
+	unsigned int		error;		/* data error */
+	unsigned int		flags;
+
+#define MMC_DATA_WRITE	(1 << 8)
+#define MMC_DATA_READ	(1 << 9)
+#define MMC_DATA_STREAM	(1 << 10)
+
+	unsigned int		bytes_xfered;
+
+	struct mmc_command	*stop;		/* stop command */
+	struct mmc_request	*req;		/* assoicated request */
+};
+
+struct mmc_request {
+	struct mmc_command	*cmd;
+	struct mmc_data		*data;
+	struct mmc_command	*stop;
+
+	void			*done_data;	/* completion data */
+	void			(*done)(struct mmc_request *);/* completion function */
+};
+
+struct mmc_host;
+struct mmc_card;
+
+extern int mmc_wait_for_req(struct mmc_host *, struct mmc_request *);
+extern int mmc_wait_for_cmd(struct mmc_host *, struct mmc_command *, int);
+
+extern int __mmc_claim_host(struct mmc_host *host, struct mmc_card *card);
+
+static inline void mmc_claim_host(struct mmc_host *host)
+{
+	__mmc_claim_host(host, (struct mmc_card *)-1);
+}
+
+extern void mmc_release_host(struct mmc_host *host);
+
+#endif
diff -urpN orig/include/linux/mmc/protocol.h linux/include/linux/mmc/protocol.h
--- orig/include/linux/mmc/protocol.h	Thu Jan  1 01:00:00 1970
+++ linux/include/linux/mmc/protocol.h	Mon Jul  7 21:21:21 2003
@@ -0,0 +1,203 @@
+/*
+ * Header for MultiMediaCard (MMC)
+ *
+ * Copyright 2002 Hewlett-Packard Company
+ *
+ * Use consistent with the GNU GPL is permitted,
+ * provided that this copyright notice is
+ * preserved in its entirety in all copies and derived works.
+ *
+ * HEWLETT-PACKARD COMPANY MAKES NO WARRANTIES, EXPRESSED OR IMPLIED,
+ * AS TO THE USEFULNESS OR CORRECTNESS OF THIS CODE OR ITS
+ * FITNESS FOR ANY PARTICULAR PURPOSE.
+ *
+ * Many thanks to Alessandro Rubini and Jonathan Corbet!
+ *
+ * Based strongly on code by:
+ *
+ * Author: Yong-iL Joh <tolkien@mizi.com>
+ * Date  : $Date: 2002/06/18 12:37:30 $
+ *
+ * Author:  Andrew Christian
+ *          15 May 2002
+ */
+
+#ifndef MMC_MMC_PROTOCOL_H
+#define MMC_MMC_PROTOCOL_H
+
+/* Standard MMC commands (3.1)           type  argument     response */
+   /* class 1 */
+#define	MMC_GO_IDLE_STATE         0   /* bc                          */
+#define MMC_SEND_OP_COND          1   /* bcr  [31:0] OCR         R3  */
+#define MMC_ALL_SEND_CID          2   /* bcr                     R2  */
+#define MMC_SET_RELATIVE_ADDR     3   /* ac   [31:16] RCA        R1  */
+#define MMC_SET_DSR               4   /* bc   [31:16] RCA            */
+#define MMC_SELECT_CARD           7   /* ac   [31:16] RCA        R1  */
+#define MMC_SEND_CSD              9   /* ac   [31:16] RCA        R2  */
+#define MMC_SEND_CID             10   /* ac   [31:16] RCA        R2  */
+#define MMC_READ_DAT_UNTIL_STOP  11   /* adtc [31:0] dadr        R1  */
+#define MMC_STOP_TRANSMISSION    12   /* ac                      R1b */
+#define MMC_SEND_STATUS	         13   /* ac   [31:16] RCA        R1  */
+#define MMC_GO_INACTIVE_STATE    15   /* ac   [31:16] RCA            */
+
+  /* class 2 */
+#define MMC_SET_BLOCKLEN         16   /* ac   [31:0] block len   R1  */
+#define MMC_READ_SINGLE_BLOCK    17   /* adtc [31:0] data addr   R1  */
+#define MMC_READ_MULTIPLE_BLOCK  18   /* adtc [31:0] data addr   R1  */
+
+  /* class 3 */
+#define MMC_WRITE_DAT_UNTIL_STOP 20   /* adtc [31:0] data addr   R1  */
+
+  /* class 4 */
+#define MMC_SET_BLOCK_COUNT      23   /* adtc [31:0] data addr   R1  */
+#define MMC_WRITE_BLOCK          24   /* adtc [31:0] data addr   R1  */
+#define MMC_WRITE_MULTIPLE_BLOCK 25   /* adtc                    R1  */
+#define MMC_PROGRAM_CID          26   /* adtc                    R1  */
+#define MMC_PROGRAM_CSD          27   /* adtc                    R1  */
+
+  /* class 6 */
+#define MMC_SET_WRITE_PROT       28   /* ac   [31:0] data addr   R1b */
+#define MMC_CLR_WRITE_PROT       29   /* ac   [31:0] data addr   R1b */
+#define MMC_SEND_WRITE_PROT      30   /* adtc [31:0] wpdata addr R1  */
+
+  /* class 5 */
+#define MMC_ERASE_GROUP_START    35   /* ac   [31:0] data addr   R1  */
+#define MMC_ERASE_GROUP_END      36   /* ac   [31:0] data addr   R1  */
+#define MMC_ERASE                37   /* ac                      R1b */
+
+  /* class 9 */
+#define MMC_FAST_IO              39   /* ac   <Complex>          R4  */
+#define MMC_GO_IRQ_STATE         40   /* bcr                     R5  */
+
+  /* class 7 */
+#define MMC_LOCK_UNLOCK          42   /* adtc                    R1b */
+
+  /* class 8 */
+#define MMC_APP_CMD              55   /* ac   [31:16] RCA        R1  */
+#define MMC_GEN_CMD              56   /* adtc [0] RD/WR          R1b */
+
+/*
+  MMC status in R1
+  Type
+  	e : error bit
+	s : status bit
+	r : detected and set for the actual command response
+	x : detected and set during command execution. the host must poll
+            the card by sending status command in order to read these bits.
+  Clear condition
+  	a : according to the card state
+	b : always related to the previous command. Reception of
+            a valid command will clear it (with a delay of one command)
+	c : clear by read
+ */
+
+#define R1_OUT_OF_RANGE		(1 << 31)	/* er, c */
+#define R1_ADDRESS_ERROR	(1 << 30)	/* erx, c */
+#define R1_BLOCK_LEN_ERROR	(1 << 29)	/* er, c */
+#define R1_ERASE_SEQ_ERROR      (1 << 28)	/* er, c */
+#define R1_ERASE_PARAM		(1 << 27)	/* ex, c */
+#define R1_WP_VIOLATION		(1 << 26)	/* erx, c */
+#define R1_CARD_IS_LOCKED	(1 << 25)	/* sx, a */
+#define R1_LOCK_UNLOCK_FAILED	(1 << 24)	/* erx, c */
+#define R1_COM_CRC_ERROR	(1 << 23)	/* er, b */
+#define R1_ILLEGAL_COMMAND	(1 << 22)	/* er, b */
+#define R1_CARD_ECC_FAILED	(1 << 21)	/* ex, c */
+#define R1_CC_ERROR		(1 << 20)	/* erx, c */
+#define R1_ERROR		(1 << 19)	/* erx, c */
+#define R1_UNDERRUN		(1 << 18)	/* ex, c */
+#define R1_OVERRUN		(1 << 17)	/* ex, c */
+#define R1_CID_CSD_OVERWRITE	(1 << 16)	/* erx, c, CID/CSD overwrite */
+#define R1_WP_ERASE_SKIP	(1 << 15)	/* sx, c */
+#define R1_CARD_ECC_DISABLED	(1 << 14)	/* sx, a */
+#define R1_ERASE_RESET		(1 << 13)	/* sr, c */
+#define R1_STATUS(x)            (x & 0xFFFFE000)
+#define R1_CURRENT_STATE(x)    	((x & 0x00001E00) >> 9)	/* sx, b (4 bits) */
+#define R1_READY_FOR_DATA	(1 << 8)	/* sx, a */
+#define R1_APP_CMD		(1 << 7)	/* sr, c */
+
+/* These are unpacked versions of the actual responses */
+
+struct _mmc_csd {
+	u8  csd_structure;
+	u8  spec_vers;
+	u8  taac;
+	u8  nsac;
+	u8  tran_speed;
+	u16 ccc;
+	u8  read_bl_len;
+	u8  read_bl_partial;
+	u8  write_blk_misalign;
+	u8  read_blk_misalign;
+	u8  dsr_imp;
+	u16 c_size;
+	u8  vdd_r_curr_min;
+	u8  vdd_r_curr_max;
+	u8  vdd_w_curr_min;
+	u8  vdd_w_curr_max;
+	u8  c_size_mult;
+	union {
+		struct { /* MMC system specification version 3.1 */
+			u8  erase_grp_size;
+			u8  erase_grp_mult;
+		} v31;
+		struct { /* MMC system specification version 2.2 */
+			u8  sector_size;
+			u8  erase_grp_size;
+		} v22;
+	} erase;
+	u8  wp_grp_size;
+	u8  wp_grp_enable;
+	u8  default_ecc;
+	u8  r2w_factor;
+	u8  write_bl_len;
+	u8  write_bl_partial;
+	u8  file_format_grp;
+	u8  copy;
+	u8  perm_write_protect;
+	u8  tmp_write_protect;
+	u8  file_format;
+	u8  ecc;
+};
+
+#define MMC_VDD_145_150	0x00000001	/* VDD voltage 1.45 - 1.50 */
+#define MMC_VDD_150_155	0x00000002	/* VDD voltage 1.50 - 1.55 */
+#define MMC_VDD_155_160	0x00000004	/* VDD voltage 1.55 - 1.60 */
+#define MMC_VDD_160_165	0x00000008	/* VDD voltage 1.60 - 1.65 */
+#define MMC_VDD_165_170	0x00000010	/* VDD voltage 1.65 - 1.70 */
+#define MMC_VDD_17_18	0x00000020	/* VDD voltage 1.7 - 1.8 */
+#define MMC_VDD_18_19	0x00000040	/* VDD voltage 1.8 - 1.9 */
+#define MMC_VDD_19_20	0x00000080	/* VDD voltage 1.9 - 2.0 */
+#define MMC_VDD_20_21	0x00000100	/* VDD voltage 2.0 ~ 2.1 */
+#define MMC_VDD_21_22	0x00000200	/* VDD voltage 2.1 ~ 2.2 */
+#define MMC_VDD_22_23	0x00000400	/* VDD voltage 2.2 ~ 2.3 */
+#define MMC_VDD_23_24	0x00000800	/* VDD voltage 2.3 ~ 2.4 */
+#define MMC_VDD_24_25	0x00001000	/* VDD voltage 2.4 ~ 2.5 */
+#define MMC_VDD_25_26	0x00002000	/* VDD voltage 2.5 ~ 2.6 */
+#define MMC_VDD_26_27	0x00004000	/* VDD voltage 2.6 ~ 2.7 */
+#define MMC_VDD_27_28	0x00008000	/* VDD voltage 2.7 ~ 2.8 */
+#define MMC_VDD_28_29	0x00010000	/* VDD voltage 2.8 ~ 2.9 */
+#define MMC_VDD_29_30	0x00020000	/* VDD voltage 2.9 ~ 3.0 */
+#define MMC_VDD_30_31	0x00040000	/* VDD voltage 3.0 ~ 3.1 */
+#define MMC_VDD_31_32	0x00080000	/* VDD voltage 3.1 ~ 3.2 */
+#define MMC_VDD_32_33	0x00100000	/* VDD voltage 3.2 ~ 3.3 */
+#define MMC_VDD_33_34	0x00200000	/* VDD voltage 3.3 ~ 3.4 */
+#define MMC_VDD_34_35	0x00400000	/* VDD voltage 3.4 ~ 3.5 */
+#define MMC_VDD_35_36	0x00800000	/* VDD voltage 3.5 ~ 3.6 */
+#define MMC_CARD_BUSY	0x80000000	/* Card Power up status bit */
+
+
+/*
+ * CSD field definitions
+ */
+
+#define CSD_STRUCT_VER_1_0  0           /* Valid for system specification 1.0 - 1.2 */
+#define CSD_STRUCT_VER_1_1  1           /* Valid for system specification 1.4 - 2.2 */
+#define CSD_STRUCT_VER_1_2  2           /* Valid for system specification 3.1       */
+
+#define CSD_SPEC_VER_0      0           /* Implements system specification 1.0 - 1.2 */
+#define CSD_SPEC_VER_1      1           /* Implements system specification 1.4 */
+#define CSD_SPEC_VER_2      2           /* Implements system specification 2.0 - 2.2 */
+#define CSD_SPEC_VER_3      3           /* Implements system specification 3.1 */
+
+#endif  /* MMC_MMC_PROTOCOL_H */
+

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
