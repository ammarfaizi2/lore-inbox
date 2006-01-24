Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964915AbWAXMIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964915AbWAXMIv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 07:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbWAXMIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 07:08:51 -0500
Received: from webapps.arcom.com ([194.200.159.168]:5129 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S964915AbWAXMIu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 07:08:50 -0500
Message-ID: <43D618D0.1090107@arcom.com>
Date: Tue, 24 Jan 2006 12:08:48 +0000
From: David Vrabel <dvrabel@arcom.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: MC251x CAN controller driver example
References: <43D61374.8010208@arcom.com>
In-Reply-To: <43D61374.8010208@arcom.com>
Content-Type: multipart/mixed;
 boundary="------------000905030805050903000004"
X-OriginalArrivalTime: 24 Jan 2006 12:13:10.0953 (UTC) FILETIME=[8B103990:01C620DF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000905030805050903000004
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

And here's an example of a CAN controller driver.  It for the Microchip
MCP251x (tested with an MCP2515) which uses an SPI interface to the
processor.

David Vrabel
-- 
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/

--------------000905030805050903000004
Content-Type: text/plain;
 name="drivers-can-mcp251x-wip"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="drivers-can-mcp251x-wip"

Index: linux-2.6-working/drivers/can/mcp251x.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-working/drivers/can/mcp251x.c	2006-01-24 11:18:40.000000000 +0000
@@ -0,0 +1,694 @@
+/*
+ * Microchip MCP251x CAN controller driver.
+ *
+ * Copyright (C) 2006 Arcom Control Systems Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/netdevice.h>
+#include <linux/interrupt.h>
+#include <linux/spi/spi.h>
+#include <linux/can/can.h>
+#include <linux/can/mcp251x.h>
+
+#include <asm/semaphore.h>
+
+/* SPI interface instruction set */
+#define INSTRUCTION_WRITE       0x02
+#define INSTRUCTION_READ        0x03
+#define INSTRUCTION_BIT_MODIFY  0x05
+#define INSTRUCTION_LOAD_TXB(n) (0x40 + 2 * (n))
+#define INSTRUCTION_READ_RXB(n) (0x90 + 2 * (n))
+#define INSTRUCTION_RESET       0xc0
+
+/* MPC251x registers */
+#define CANCTRL       0x0f
+#  define CANCTRL_REQOP_MASK        0xe0
+#  define CANCTRL_REQOP_CONF        0x80
+#  define CANCTRL_REQOP_LISTEN_ONLY 0x60
+#  define CANCTRL_REQOP_LOOPBACK    0x40
+#  define CANCTRL_REQOP_SLEEP       0x20
+#  define CANCTRL_REQOP_NORMAL      0x00
+#  define CANCTRL_OSM               0x08
+#define TEC           0x1c
+#define REC           0x1d
+#define CNF1          0x2a
+#define CNF2          0x29
+#  define CNF2_BTLMODE  0x80
+#define CNF3          0x28
+#  define CNF3_SOF      0x08
+#  define CNF3_WAKFIL   0x04
+#  define CNF3_PHSEG2_MASK 0x07
+#define CANINTE       0x2b
+#  define CANINTE_MERRE 0x80
+#  define CANINTE_WAKIE 0x40
+#  define CANINTE_ERRIE 0x20
+#  define CANINTE_TX2IE 0x10
+#  define CANINTE_TX1IE 0x08
+#  define CANINTE_TX0IE 0x04
+#  define CANINTE_RX1IE 0x02
+#  define CANINTE_RX0IE 0x01
+#define CANINTF       0x2c
+#  define CANINTF_MERRF 0x80
+#  define CANINTF_WAKIF 0x40
+#  define CANINTF_ERRIF 0x20
+#  define CANINTF_TX2IF 0x10
+#  define CANINTF_TX1IF 0x08
+#  define CANINTF_TX0IF 0x04
+#  define CANINTF_RX1IF 0x02
+#  define CANINTF_RX0IF 0x01
+#define EFLG          0x2d
+#  define EFLG_RX1OVR   0x80
+#  define EFLG_RX0OVR   0x40
+#define TXBCTRL(n)  ((n * 0x10) + 0x30)
+#  define TXBCTRL_TXREQ  0x08
+
+/* Buffer size required for the largest SPI transfer (i.e., reading a
+ * frame). */
+#define SPI_TRANSFER_BUF_LEN (2*(6 + CAN_FRAME_MAX_DATA_LEN))
+
+struct mcp251x {
+	struct can_device *can;
+	struct semaphore lock;
+	uint8_t *spi_transfer_buf;
+
+	int bit_rate;
+	int reg;
+
+	struct sk_buff *tx_skb;
+
+	struct work_struct tx_work;
+	struct work_struct irq_work;
+};
+
+static uint8_t mcp251x_read_reg(struct spi_device *spi, uint8_t reg)
+{
+	struct mcp251x *chip = dev_get_drvdata(&spi->dev);
+	uint8_t *tx_buf, *rx_buf;
+	uint8_t val;
+	struct spi_transfer t;
+	struct spi_message m;
+	int ret;
+
+	tx_buf = chip->spi_transfer_buf;
+	rx_buf = chip->spi_transfer_buf + 8;
+
+	down(&chip->lock);
+
+	tx_buf[0] = INSTRUCTION_READ;
+	tx_buf[1] = reg;
+
+	t.tx_buf = tx_buf;
+	t.rx_buf = rx_buf;
+	t.len = 3;
+	t.cs_change = 0;
+
+	spi_message_init(&m);
+	spi_message_add_tail(&t, &m);
+
+	ret = spi_sync(spi, &m);
+	if (ret < 0) {
+		dev_dbg(&spi->dev, "%s: failed: ret = %d\n", __FUNCTION__, ret);
+		val = 0;
+	} else
+		val = rx_buf[2];
+
+	up(&chip->lock);
+
+	return val;
+}
+
+static void mcp251x_write_reg(struct spi_device *spi, uint8_t reg, uint8_t val)
+{
+	struct mcp251x *chip = dev_get_drvdata(&spi->dev);
+	int ret;
+
+	down(&chip->lock);
+
+	chip->spi_transfer_buf[0] = INSTRUCTION_WRITE;
+	chip->spi_transfer_buf[1] = reg;
+	chip->spi_transfer_buf[2] = val;
+
+	ret = spi_write(spi, chip->spi_transfer_buf, 3);
+	if (ret < 0)
+		dev_dbg(&spi->dev, "%s: failed: ret = %d\n", __FUNCTION__, ret);
+
+	up(&chip->lock);
+}
+
+static void mcp251x_write_bits(struct spi_device *spi, uint8_t reg, uint8_t mask, uint8_t val)
+{
+	struct mcp251x *chip = dev_get_drvdata(&spi->dev);
+	int ret;
+
+	down(&chip->lock);
+
+	chip->spi_transfer_buf[0] = INSTRUCTION_BIT_MODIFY;
+	chip->spi_transfer_buf[1] = reg;
+	chip->spi_transfer_buf[2] = mask;
+	chip->spi_transfer_buf[3] = val;
+
+	ret = spi_write(spi, chip->spi_transfer_buf, 4);
+	if (ret < 0)
+		dev_dbg(&spi->dev, "%s: failed: ret = %d\n", __FUNCTION__, ret);
+
+	up(&chip->lock);
+}
+
+static void hw_reset(struct spi_device *spi)
+{
+	struct mcp251x *chip = dev_get_drvdata(&spi->dev);
+	int ret;
+
+	down(&chip->lock);
+
+	chip->spi_transfer_buf[0] = INSTRUCTION_RESET;
+
+	ret = spi_write(spi, chip->spi_transfer_buf, 1);
+	if (ret < 0)
+		dev_dbg(&spi->dev, "%s: failed: ret = %d\n", __FUNCTION__, ret);
+
+	up(&chip->lock);
+}
+
+
+#ifdef DEBUG
+
+static ssize_t mcp251x_reg_addr_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	struct mcp251x *chip = dev_get_drvdata(&spi->dev);
+
+	return sprintf(buf, "0x%02x\n", chip->reg);
+}
+
+static ssize_t mcp251x_reg_addr_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	struct mcp251x *chip = dev_get_drvdata(&spi->dev);
+
+	chip->reg = simple_strtoul(buf, NULL, 0);
+
+	return count;
+}
+
+static DEVICE_ATTR(reg_addr, 0600, mcp251x_reg_addr_show, mcp251x_reg_addr_store);
+
+static ssize_t mcp251x_reg_data_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	struct mcp251x *chip = dev_get_drvdata(&spi->dev);
+
+	return sprintf(buf, "0x%02x\n", mcp251x_read_reg(spi, chip->reg));
+}
+
+static ssize_t mcp251x_reg_data_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	struct mcp251x *chip = dev_get_drvdata(&spi->dev);
+
+	mcp251x_write_reg(spi, chip->reg, simple_strtoul(buf, NULL, 0));
+
+	return count;
+}
+
+static DEVICE_ATTR(reg_data, 0600, mcp251x_reg_data_show, mcp251x_reg_data_store);
+
+#endif /* DEBUG */
+
+
+static void __devinit mcp251x_hw_init(struct spi_device *spi)
+{
+	hw_reset(spi);
+}
+
+static void mcp251x_hw_sleep(struct spi_device *spi)
+{
+	mcp251x_write_reg(spi, CANCTRL, CANCTRL_REQOP_SLEEP);
+}
+
+static void mcp251x_hw_wakeup(struct spi_device *spi)
+{
+	/* Can only wake up by generating a wake-up interrupt. */
+	mcp251x_write_bits(spi, CANINTE, CANINTE_WAKIE, CANINTE_WAKIE);
+	mcp251x_write_bits(spi, CANINTF, CANINTF_WAKIF, CANINTF_WAKIF);
+}
+
+
+static int mcp251x_set_bit_rate(struct can_device *can, int bit_rate)
+{
+	struct spi_device *spi = to_spi_device(can->cdev.dev);
+	struct mcp251x *chip = dev_get_drvdata(&spi->dev);
+	struct mcp251x_platform_data *pdata = spi->dev.platform_data;
+	int tqs; /* tbit/TQ */
+	int brp;
+	int ps1, ps2, propseg, sjw;
+
+	/* Determine the BRP value that gives the requested bit rate. */
+	for(brp = 0; brp < 8; brp++) {
+		tqs = pdata->f_osc / (2 * (brp + 1)) / bit_rate;
+		if (tqs >= 5 && tqs <= 25
+		    && (pdata->f_osc / (2 * (brp + 1)) / tqs) == bit_rate)
+			break;
+	}
+	if (brp >= 8)
+		return -EINVAL;
+
+	/* The CAN bus bit time (tbit) is determined by:
+	 *   tbit = (SyncSeg + PropSeg + PS1 + PS2) * TQ
+	 * with:
+	 *     SyncSeg = 1
+	 *     sample point (between PS1 and PS2) must be at 60%-70% of the bit time
+	 *     PropSeg + PS1 >= PS2
+	 *     PropSeg + PS1 >= Tdelay
+	 *     PS2 > SJW
+	 *     1 <= PropSeg <= 8, 1 <= PS1 <=8, 2 <= PS2 <= 8
+	 * SJW = 1 is sufficient in most cases.
+	 * Tdelay is usually 1 or 2 TQ.
+	 */
+
+	propseg = ps1 = ps2 = (tqs - 1) / 3;
+	if (tqs - (1 + propseg + ps1 + ps2) == 2)
+		ps1++;
+	if (tqs - (1 + propseg + ps1 + ps2) == 1)
+		ps2++;
+	sjw = 1;
+
+	dev_dbg(&spi->dev, "bit rate: BRP = %d, Tbit = %d TQ, PropSeg = %d, PS1 = %d, PS2 = %d, SJW = %d\n",
+		brp, tqs, propseg, ps1, ps2, sjw);
+
+	/* Since we can only change the bit rate when the network device is
+	 * down the chip must be in sleep mode. Wake it up and put it into
+	 * config mode. */
+	mcp251x_hw_wakeup(spi);
+	mcp251x_write_bits(spi, CANCTRL, CANCTRL_REQOP_MASK, CANCTRL_REQOP_CONF);
+
+	mcp251x_write_reg(spi, CNF1, ((sjw-1) << 6) | brp);
+	mcp251x_write_reg(spi, CNF2, CNF2_BTLMODE | ((ps1-1) << 3) | (propseg-1));
+	mcp251x_write_bits(spi, CNF3, CNF3_PHSEG2_MASK, (ps2-1));
+
+	mcp251x_hw_sleep(spi);
+
+	/* Calculate actual bit rate. */
+	chip->bit_rate = pdata->f_osc / (2 * (brp + 1)) / tqs;
+
+	return 0;
+}
+
+static int mcp251x_get_bit_rate(struct can_device *can)
+{
+	struct spi_device *spi = to_spi_device(can->cdev.dev);
+	struct mcp251x *chip = dev_get_drvdata(&spi->dev);
+
+	return chip->bit_rate;
+}
+
+
+static void mcp251x_hw_tx(struct spi_device *spi, struct can_frame *frame, int tx_buf_idx)
+{
+	struct mcp251x *chip = dev_get_drvdata(&spi->dev);
+	uint8_t *buf = chip->spi_transfer_buf;
+	int ret;
+
+	dev_dbg(&spi->dev, "%s()\n", __FUNCTION__);
+
+	down(&chip->lock);
+
+	buf[0] = INSTRUCTION_LOAD_TXB(tx_buf_idx);
+	buf[1] = frame->header.id >> 3;
+	buf[2] = (frame->header.id << 5) | (frame->header.ide << 3)
+		| frame->header.eid >> 16;
+	buf[3]  = frame->header.eid >> 8;
+	buf[4]  = frame->header.eid;
+	buf[5] = (frame->header.rtr << 6) | frame->header.dlc;
+	memcpy(buf + 6, frame->data, frame->header.dlc);
+
+	ret = spi_write(spi, buf, 6 + CAN_FRAME_MAX_DATA_LEN);
+	if (ret < 0)
+		dev_dbg(&spi->dev, "%s: failed: ret = %d\n", __FUNCTION__, ret);
+
+	up(&chip->lock);
+
+	mcp251x_write_reg(spi, TXBCTRL(tx_buf_idx), TXBCTRL_TXREQ);
+}
+
+static void mcp251x_hw_rx(struct spi_device *spi, int buf_idx)
+{
+	struct mcp251x *chip = dev_get_drvdata(&spi->dev);
+	uint8_t *buf = chip->spi_transfer_buf;
+	uint8_t *rx_buf;
+	struct spi_transfer t;
+	struct spi_message m;
+	int ret;
+	struct sk_buff *skb;
+	struct can_frame *frame;
+
+	skb = dev_alloc_skb(sizeof(struct can_frame));
+	if (!skb) {
+		dev_dbg(&spi->dev, "%s: out of memory for Rx'd frame\n", __FUNCTION__);
+		chip->can->stats.rx_dropped++;
+		return;
+	}
+	skb->dev = &chip->can->ndev;
+	frame = (struct can_frame *)skb_put(skb, sizeof(struct can_frame));
+
+	down(&chip->lock);
+
+	buf[0] = INSTRUCTION_READ_RXB(buf_idx);
+
+	t.tx_buf = buf;
+	t.rx_buf = rx_buf = buf + (6 + CAN_FRAME_MAX_DATA_LEN);
+	t.len = 14;
+	t.cs_change = 0;
+
+	spi_message_init(&m);
+	spi_message_add_tail(&t, &m);
+
+	ret = spi_sync(spi, &m);
+	if (ret < 0)
+		dev_dbg(&spi->dev, "%s: failed: ret = %d\n", __FUNCTION__, ret);
+
+	frame->header.id = (rx_buf[1] << 3) | (rx_buf[2] >> 5);
+	frame->header.ide = (rx_buf[2] >> 3) & 0x1;
+	frame->header.eid = (rx_buf[2] << 16) | (rx_buf[3] << 8) | rx_buf[4];
+	frame->header.rtr = (rx_buf[5] >> 6) & 0x1;
+	frame->header.dlc = rx_buf[5] & 0x0f;
+	memcpy(frame->data, rx_buf + 6, CAN_FRAME_MAX_DATA_LEN);
+
+	up(&chip->lock);
+
+	chip->can->stats.rx_packets++;
+	chip->can->stats.rx_bytes += frame->header.dlc;
+
+	netif_rx(skb);
+}
+
+
+static void mcp251x_tx_work_handler(void *data)
+{
+	struct spi_device *spi = data;
+	struct mcp251x *chip = dev_get_drvdata(&spi->dev);
+	struct can_frame *frame = (struct can_frame *)chip->tx_skb->data;
+
+	dev_dbg(&spi->dev, "%s()\n", __FUNCTION__);
+
+	/* FIXME: move this somewhere more appropriate? */
+	if (frame->header.dlc > CAN_FRAME_MAX_DATA_LEN)
+		frame->header.dlc = CAN_FRAME_MAX_DATA_LEN;
+
+	/* FIXME: use all 3 Tx buffers */
+	mcp251x_hw_tx(spi, frame, 0);
+
+	dev_kfree_skb(chip->tx_skb);
+}
+
+
+static void mcp251x_irq_work_handler(void *data)
+{
+	struct spi_device *spi = data;
+	struct mcp251x *chip = dev_get_drvdata(&spi->dev);
+	uint8_t intf;
+
+	for (;;) {
+		intf = mcp251x_read_reg(spi, CANINTF);
+		if (intf == 0x00)
+			break;
+
+		dev_dbg(&spi->dev, "interrupt:%s%s%s%s%s%s%s%s\n",
+			(intf & CANINTF_MERRF) ? " MERR":"",
+			(intf & CANINTF_WAKIF) ? " WAK":"",
+			(intf & CANINTF_ERRIF) ? " ERR":"",
+			(intf & CANINTF_TX2IF) ? " TX2":"",
+			(intf & CANINTF_TX1IF) ? " TX1":"",
+			(intf & CANINTF_TX0IF) ? " TX0":"",
+			(intf & CANINTF_RX1IF) ? " RX1":"",
+			(intf & CANINTF_RX0IF) ? " RX0":"");
+
+		if (intf & CANINTF_MERRF) {
+			uint8_t txbnctrl;
+			/* if there are no pending Tx buffers, restart queue */
+			txbnctrl = mcp251x_read_reg(spi, TXBCTRL(0));
+			if (!(txbnctrl & TXBCTRL_TXREQ))
+				netif_wake_queue(&chip->can->ndev);
+		}
+		if (intf & CANINTF_ERRIF) {
+			uint8_t eflg = mcp251x_read_reg(spi, EFLG);
+
+			dev_dbg(&spi->dev, "EFLG = 0x%02x\n", eflg);
+
+			if (eflg & (EFLG_RX0OVR | EFLG_RX1OVR)) {
+				if (eflg & EFLG_RX0OVR)
+					chip->can->stats.rx_over_errors++;
+				if (eflg & EFLG_RX1OVR)
+					chip->can->stats.rx_over_errors++;
+				mcp251x_write_reg(spi, EFLG, 0x00);
+			}
+		}
+		if (intf & (CANINTF_TX2IF | CANINTF_TX1IF | CANINTF_TX0IF)) {
+			chip->can->stats.tx_packets++;
+			chip->can->stats.tx_bytes += ((struct can_frame *)(chip->tx_skb->data))->header.dlc;
+			netif_wake_queue(&chip->can->ndev);
+		}
+		if (intf & CANINTF_RX0IF)
+			mcp251x_hw_rx(spi, 0);
+		if (intf & CANINTF_RX1IF)
+			mcp251x_hw_rx(spi, 1);
+
+		mcp251x_write_bits(spi, CANINTF, intf, 0x00);
+	}
+}
+
+
+static irqreturn_t mcp251x_irq(int irq, void *dev_id, struct pt_regs *regs)
+{
+	struct spi_device *spi = dev_id;
+	struct mcp251x *chip = dev_get_drvdata(&spi->dev);
+
+	/* Can't do anything in interrupt context so fire of the interrupt
+	 * handling workqueue. */
+	schedule_work(&chip->irq_work);
+
+	return IRQ_HANDLED;
+}
+
+static int mcp251x_open(struct net_device *netdev)
+{
+	struct can_device *can = netdev->priv;
+	struct spi_device *spi = to_spi_device(can->cdev.dev);
+	struct mcp251x_platform_data *pdata = spi->dev.platform_data;
+
+	if (pdata->transceiver_enable)
+		pdata->transceiver_enable(1);
+
+	mcp251x_hw_wakeup(spi);
+
+	/* Enable interrupts */
+	mcp251x_write_reg(spi, CANINTE,
+		  CANINTE_ERRIE
+		  | CANINTE_TX2IE | CANINTE_TX1IE | CANINTE_TX0IE
+		  | CANINTE_RX1IE | CANINTE_RX0IE);
+
+	/* put device into normal mode */
+	mcp251x_write_reg(spi, CANCTRL, CANCTRL_REQOP_NORMAL);
+
+	return 0;
+}
+
+static int mcp251x_stop(struct net_device *netdev)
+{
+	struct can_device *can = netdev->priv;
+	struct spi_device *spi = to_spi_device(can->cdev.dev);
+	struct mcp251x_platform_data *pdata = spi->dev.platform_data;
+
+	/* disable and clear pending interrupts */
+	mcp251x_write_reg(spi, CANINTE, 0x00);
+	mcp251x_write_reg(spi, CANINTF, 0x00);
+
+	mcp251x_hw_sleep(spi);
+
+	if (pdata->transceiver_enable)
+		pdata->transceiver_enable(0);
+
+	return 0;
+}
+
+static int mcp251x_tx(struct sk_buff *skb, struct net_device *netdev)
+{
+	struct can_device *can = netdev->priv;
+	struct spi_device *spi = to_spi_device(can->cdev.dev);
+	struct mcp251x *chip = dev_get_drvdata(&spi->dev);
+	struct can_frame *frame;
+
+	if (skb->len != sizeof(struct can_frame)) {
+		dev_dbg(&spi->dev, "dropping packet - bad length\n");
+		dev_kfree_skb(skb);
+		chip->can->stats.tx_dropped++;
+		return 0;
+	}
+
+	netif_stop_queue(netdev);
+
+	frame = (struct can_frame *)skb->data;
+
+	chip->tx_skb = skb;
+	schedule_work(&chip->tx_work);
+
+	return 0;
+}
+
+static int mcp251x_remove(struct spi_device *spi)
+{
+	struct mcp251x *chip = dev_get_drvdata(&spi->dev);
+
+	dev_dbg(&spi->dev, "%s: stop\n",  __FUNCTION__);
+
+#ifdef DEBUG
+	device_remove_file(&spi->dev, &dev_attr_reg_addr);
+	device_remove_file(&spi->dev, &dev_attr_reg_data);
+#endif
+
+	can_device_unregister(chip->can);
+	free_irq(spi->irq, spi);
+	kfree(chip->spi_transfer_buf);
+
+	return 0;
+}
+
+static int __devinit mcp251x_probe(struct spi_device *spi)
+{
+	struct can_device *can;
+	struct mcp251x *chip;
+	int ret = 0;
+
+	dev_dbg(&spi->dev, "%s: start\n",  __FUNCTION__);
+
+	can = can_device_alloc(&spi->dev, sizeof(struct mcp251x));
+	if (!can) {
+		ret = -ENOMEM;
+		goto error_alloc;
+	}
+	chip = can_device_get_devdata(can);
+	dev_set_drvdata(&spi->dev, chip);
+	chip->can = can;
+
+	chip->spi_transfer_buf = kmalloc(SPI_TRANSFER_BUF_LEN, GFP_KERNEL);
+	if (!chip->spi_transfer_buf) {
+		ret = -ENOMEM;
+		goto error_buf;
+	}
+	init_MUTEX(&chip->lock);
+
+	ret = request_irq(spi->irq, mcp251x_irq, SA_SAMPLE_RANDOM, "mcp251x", spi);
+	if (ret < 0) {
+		dev_err(&spi->dev, "request irq %d failed (ret = %d)\n", spi->irq, ret);
+		goto error_irq;
+	}
+
+	can->set_bit_rate = mcp251x_set_bit_rate;
+	can->get_bit_rate = mcp251x_get_bit_rate;
+
+	can->ndev.open            = mcp251x_open;
+	can->ndev.stop            = mcp251x_stop;
+	can->ndev.hard_start_xmit = mcp251x_tx;
+
+	ret = can_device_register(can);
+	if (ret < 0) {
+		dev_err(&spi->dev, "register can device failed (ret = %d)\n", ret);
+		goto error_register;
+	}
+
+	INIT_WORK(&chip->tx_work, mcp251x_tx_work_handler, spi);
+	INIT_WORK(&chip->irq_work, mcp251x_irq_work_handler, spi);
+
+#ifdef DEBUG
+	device_create_file(&spi->dev, &dev_attr_reg_addr);
+	device_create_file(&spi->dev, &dev_attr_reg_data);
+#endif
+
+	mcp251x_hw_init(spi);
+	mcp251x_set_bit_rate(can, 125000); /* A reasonable default */
+	mcp251x_hw_sleep(spi);
+
+	return 0;
+
+  error_register:
+	free_irq(spi->irq, spi);
+  error_irq:
+	kfree(chip->spi_transfer_buf);
+  error_buf:
+	class_device_put(&can->cdev);
+  error_alloc:
+	return ret;
+}
+
+static int mcp251x_suspend(struct spi_device *spi, pm_message_t mesg)
+{
+	struct mcp251x *chip = dev_get_drvdata(&spi->dev);
+	struct mcp251x_platform_data *pdata = spi->dev.platform_data;
+
+        if (!netif_running(&chip->can->ndev))
+                return 0;
+
+	netif_device_detach(&chip->can->ndev);
+
+	mcp251x_hw_sleep(spi);
+	if (pdata->transceiver_enable)
+		pdata->transceiver_enable(0);
+
+	return 0;
+}
+
+static int mcp251x_resume(struct spi_device *spi)
+{
+	struct mcp251x *chip = dev_get_drvdata(&spi->dev);
+	struct mcp251x_platform_data *pdata = spi->dev.platform_data;
+
+        if (!netif_running(&chip->can->ndev))
+                return 0;
+
+	if (pdata->transceiver_enable)
+		pdata->transceiver_enable(1);
+	mcp251x_hw_wakeup(spi);
+
+	netif_device_attach(&chip->can->ndev);
+
+	return 0;
+}
+
+
+static struct spi_driver mcp251x_driver = {
+	.driver = {
+		.name	= "mcp251x",
+		.bus	= &spi_bus_type,
+		.owner	= THIS_MODULE,
+	},
+	.probe		= mcp251x_probe,
+	.remove		= __devexit_p(mcp251x_remove),
+#ifdef CONFIG_PM
+	.suspend	= mcp251x_suspend,
+	.resume		= mcp251x_resume,
+#endif
+};
+
+static int __init mcp251x_init(void)
+{
+	return spi_register_driver(&mcp251x_driver);
+}
+module_init(mcp251x_init);
+
+static void __exit mcp251x_exit(void)
+{
+	spi_unregister_driver(&mcp251x_driver);
+}
+module_exit(mcp251x_exit);
+
+
+MODULE_DESCRIPTION("MCP251x CAN controller driver");
+MODULE_LICENSE("GPL");
Index: linux-2.6-working/include/linux/can/mcp251x.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-working/include/linux/can/mcp251x.h	2006-01-24 11:18:40.000000000 +0000
@@ -0,0 +1,26 @@
+/*
+ * MCP251x CAN controller driver
+ *
+ * Copyright (C) 2006 Arcom Control Systems Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#ifndef __LINUX_CAN_MCP251X_H
+#define __LINUX_CAN_MCP251X_H
+
+/**
+ * struct mpc251x - MCP251x CAN controller platform data
+ *
+ * f_osc: input clock frequency in Hz
+ * transceiver_enable: enable/disable CAN bus transceivers.  May be NULL if
+ *     the transceivers are always enabled.
+ */
+struct mcp251x_platform_data {
+	int f_osc;
+	void (*transceiver_enable)(int enable);
+};
+
+#endif /* !__LINUX_CAN_MCP251X_H */
Index: linux-2.6-working/drivers/can/Kconfig
===================================================================
--- linux-2.6-working.orig/drivers/can/Kconfig	2006-01-24 11:17:13.000000000 +0000
+++ linux-2.6-working/drivers/can/Kconfig	2006-01-24 11:18:35.000000000 +0000
@@ -14,4 +14,14 @@
           Say "yes" to enable debug messaging (like dev_dbg and pr_debug),
           sysfs, and debugfs support in CAN controller drivers.
 
+config CAN_MCP251X
+	tristate "MCP251x CAN controller"
+	depends on CAN
+	depends on SPI
+	help
+	  Support for Microchip MCP2510 and MCP2515 CAN controllers.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called mcp251x.
+
 endmenu
Index: linux-2.6-working/drivers/can/Makefile
===================================================================
--- linux-2.6-working.orig/drivers/can/Makefile	2006-01-24 11:17:13.000000000 +0000
+++ linux-2.6-working/drivers/can/Makefile	2006-01-24 11:18:35.000000000 +0000
@@ -3,3 +3,4 @@
 endif
 
 obj-$(CONFIG_CAN)		+= can.o
+obj-$(CONFIG_CAN_MCP251X)	+= mcp251x.o

--------------000905030805050903000004--
