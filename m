Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160993AbWF0OQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160993AbWF0OQY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 10:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWF0OQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 10:16:24 -0400
Received: from mba.ocn.ne.jp ([210.190.142.172]:1778 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S932428AbWF0OQX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 10:16:23 -0400
Date: Tue, 27 Jun 2006 23:17:31 +0900 (JST)
Message-Id: <20060627.231731.89066761.anemo@mba.ocn.ne.jp>
To: david-b@pacbell.net
Cc: akpm@osdl.org, a.zummo@towertech.it, linux-kernel@vger.kernel.org
Subject: Re: + rtc-add-rtc-rs5c348-driver.patch added to -mm tree
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060624.234231.63742358.anemo@mba.ocn.ne.jp>
References: <20060623.190141.34763616.nemoto@toshiba-tops.co.jp>
	<200606230809.24077.david-b@pacbell.net>
	<20060624.234231.63742358.anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Jun 2006 23:42:31 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> Anyway I'll modify it to use spi_write_then_read().
> 
> > Grr, you're right.  There was supposed to be spi_board_info.mode,
> > but instead there's just a comment that it _should_ be there.
> > 
> > You seem to have the first driver that needs non-default chipselect
> > polarity.  I'll put together a patch adding that, and then you should
> > adjust your code appropriately.  (Chipselect polarity is potentially
> > troublesome, since Linux has to initialize it to "deselected" very
> > early in order for the hardware act correctly.  Boot firmware has
> > probably initialized it correctly ... Linux just has to avoid goofing
> > it up, and without the board_info telling it the right polarity, it
> > can't avoid goofing it up.)
> 
> OK, I'll adjust my driver according to the SPI subsystem change.

Here is an update patch for 2.6.17-mm3.


Subject: rtc-add-rtc-rs5c348-driver-update

Use spi_write_then_read() instead of spi_sync().  Leave setup of
transfer mode and chipselect polarity to the board specific init code.
Suggested by David Brownell.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

--- linux-2.6.17-mm3/drivers/rtc/rtc-rs5c348.c.org	2006-06-27 22:34:07.826706168 +0900
+++ linux-2.6.17-mm3/drivers/rtc/rtc-rs5c348.c	2006-06-27 22:53:22.516166688 +0900
@@ -6,6 +6,10 @@
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
+ *
+ * The board specific init code should provide characteristics of this
+ * device:
+ *     Mode 1 (High-Active, Shift-Then-Sample), High Avtive CS
  */
 
 #include <linux/bcd.h>
@@ -52,65 +56,42 @@
 struct rs5c348_plat_data {
 	struct rtc_device *rtc;
 	int rtc_24h;
-	void *xferbuf;
 };
 
 static int
-rs5c348_io(struct spi_device *spi,
-	   const unsigned char *inbuf, unsigned char *outbuf,
-	   unsigned int count)
-{
-	struct spi_message m;
-	struct spi_transfer t;
-	struct rs5c348_plat_data *pdata = spi->dev.platform_data;
-	int ret;
-
-	spi_message_init(&m);
-	memset(&t, 0, sizeof(t));
-	spi_message_add_tail(&t, &m);
-
-	memcpy(pdata->xferbuf, inbuf, count);
-	t.tx_buf = pdata->xferbuf;
-	t.rx_buf = pdata->xferbuf + count;
-	t.len = count;
-
-	ret = spi_sync(spi, &m);
-
-	udelay(62);	/* Tcsr 62us */
-	memcpy(outbuf, t.rx_buf, count);
-	return ret < 0 ? ret : m.status;
-}
-
-static int
 rs5c348_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct spi_device *spi = to_spi_device(dev);
 	struct rs5c348_plat_data *pdata = spi->dev.platform_data;
-	unsigned char inbuf[11], *inp;
-
-	inp = inbuf;
-	/* Transfer 4 bytes before writing SEC.  This gives 31us for carry. */
-	*inp++ = RS5C348_CMD_R(RS5C348_REG_CTL2); /* cmd, ctl2 */
-	inp++;
-	*inp++ = RS5C348_CMD_MW(RS5C348_REG_CTL2); /* cmd, ctl2, sec, ... */
-	*inp++ = 0x57;	/* mask W0C bits */
-	*inp++ = BIN2BCD(tm->tm_sec);
-	*inp++ = BIN2BCD(tm->tm_min);
+	u8 txbuf[5+7], *txp;
+	int ret;
 
+	/* Transfer 5 bytes before writing SEC.  This gives 31us for carry. */
+	txp = txbuf;
+	txbuf[0] = RS5C348_CMD_R(RS5C348_REG_CTL2); /* cmd, ctl2 */
+	txbuf[1] = 0;	/* dummy */
+	txbuf[2] = RS5C348_CMD_R(RS5C348_REG_CTL2); /* cmd, ctl2 */
+	txbuf[3] = 0;	/* dummy */
+	txbuf[4] = RS5C348_CMD_MW(RS5C348_REG_SECS); /* cmd, sec, ... */
+	txp = &txbuf[5];
+	txp[RS5C348_REG_SECS] = BIN2BCD(tm->tm_sec);
+	txp[RS5C348_REG_MINS] = BIN2BCD(tm->tm_min);
 	if (pdata->rtc_24h) {
-		*inp++ = BIN2BCD(tm->tm_hour);
+		txp[RS5C348_REG_HOURS] = BIN2BCD(tm->tm_hour);
 	} else {
 		/* hour 0 is AM12, noon is PM12 */
-		*inp++ = BIN2BCD((tm->tm_hour + 11) % 12 + 1) |
+		txp[RS5C348_REG_HOURS] = BIN2BCD((tm->tm_hour + 11) % 12 + 1) |
 			(tm->tm_hour >= 12 ? RS5C348_BIT_PM : 0);
 	}
-	*inp++ = BIN2BCD(tm->tm_wday);
-	*inp++ = BIN2BCD(tm->tm_mday);
-	*inp++ = BIN2BCD(tm->tm_mon + 1) |
+	txp[RS5C348_REG_WDAY] = BIN2BCD(tm->tm_wday);
+	txp[RS5C348_REG_DAY] = BIN2BCD(tm->tm_mday);
+	txp[RS5C348_REG_MONTH] = BIN2BCD(tm->tm_mon + 1) |
 		(tm->tm_year >= 100 ? RS5C348_BIT_Y2K : 0);
-	*inp++ = BIN2BCD(tm->tm_year % 100);
+	txp[RS5C348_REG_YEAR] = BIN2BCD(tm->tm_year % 100);
 	/* write in one transfer to avoid data inconsistency */
-	return rs5c348_io(spi, inbuf, NULL, sizeof(inbuf));
+	ret = spi_write_then_read(spi, txbuf, sizeof(txbuf), NULL, 0);
+	udelay(62);	/* Tcsr 62us */
+	return ret;
 }
 
 static int
@@ -118,39 +99,38 @@
 {
 	struct spi_device *spi = to_spi_device(dev);
 	struct rs5c348_plat_data *pdata = spi->dev.platform_data;
-	unsigned char inbuf[11], outbuf[11], *outp;
-	unsigned int y2k;
+	u8 txbuf[5], rxbuf[7];
 	int ret;
 
-	memset(inbuf, 0, sizeof(inbuf));
-	/* Transfer 4 byte befores reading SEC.  This gives 31us for carry. */
-	inbuf[0] = RS5C348_CMD_R(RS5C348_REG_CTL2); /* cmd, ctl2 */
-	inbuf[2] = RS5C348_CMD_MR(RS5C348_REG_CTL2); /* cmd, ctl2, sec, ... */
+	/* Transfer 5 byte befores reading SEC.  This gives 31us for carry. */
+	txbuf[0] = RS5C348_CMD_R(RS5C348_REG_CTL2); /* cmd, ctl2 */
+	txbuf[1] = 0;	/* dummy */
+	txbuf[2] = RS5C348_CMD_R(RS5C348_REG_CTL2); /* cmd, ctl2 */
+	txbuf[3] = 0;	/* dummy */
+	txbuf[4] = RS5C348_CMD_MR(RS5C348_REG_SECS); /* cmd, sec, ... */
+
 	/* read in one transfer to avoid data inconsistency */
-	ret = rs5c348_io(spi, inbuf, outbuf, sizeof(inbuf));
+	ret = spi_write_then_read(spi, txbuf, sizeof(txbuf),
+				  rxbuf, sizeof(rxbuf));
+	udelay(62);	/* Tcsr 62us */
 	if (ret < 0)
 		return ret;
-	outp = outbuf + 4;	/* cmd, ctl2, cmd, ctl2 */
-	tm->tm_sec = BCD2BIN(*outp & RS5C348_SECS_MASK);
-	outp++;
-	tm->tm_min = BCD2BIN(*outp & RS5C348_MINS_MASK);
-	outp++;
-	tm->tm_hour = BCD2BIN(*outp & RS5C348_HOURS_MASK);
+
+	tm->tm_sec = BCD2BIN(rxbuf[RS5C348_REG_SECS] & RS5C348_SECS_MASK);
+	tm->tm_min = BCD2BIN(rxbuf[RS5C348_REG_MINS] & RS5C348_MINS_MASK);
+	tm->tm_hour = BCD2BIN(rxbuf[RS5C348_REG_HOURS] & RS5C348_HOURS_MASK);
 	if (!pdata->rtc_24h) {
 		tm->tm_hour %= 12;
-		if (*outp & RS5C348_BIT_PM)
+		if (rxbuf[RS5C348_REG_HOURS] & RS5C348_BIT_PM)
 			tm->tm_hour += 12;
 	}
-	outp++;
-	tm->tm_wday = BCD2BIN(*outp & RS5C348_WDAY_MASK);
-	outp++;
-	tm->tm_mday = BCD2BIN(*outp & RS5C348_DAY_MASK);
-	outp++;
-	y2k = *outp & RS5C348_BIT_Y2K;
-	tm->tm_mon = BCD2BIN(*outp & RS5C348_MONTH_MASK) - 1;
-	outp++;
+	tm->tm_wday = BCD2BIN(rxbuf[RS5C348_REG_WDAY] & RS5C348_WDAY_MASK);
+	tm->tm_mday = BCD2BIN(rxbuf[RS5C348_REG_DAY] & RS5C348_DAY_MASK);
+	tm->tm_mon =
+		BCD2BIN(rxbuf[RS5C348_REG_MONTH] & RS5C348_MONTH_MASK) - 1;
 	/* year is 1900 + tm->tm_year */
-	tm->tm_year = BCD2BIN(*outp) + (y2k ? 100 : 0);
+	tm->tm_year = BCD2BIN(rxbuf[RS5C348_REG_YEAR]) +
+		((rxbuf[RS5C348_REG_MONTH] & RS5C348_BIT_Y2K) ? 100 : 0);
 
 	if (rtc_valid_tm(tm) < 0) {
 		dev_err(&spi->dev, "retrieved date/time is not valid.\n");
@@ -173,21 +153,9 @@
 	struct rtc_device *rtc;
 	struct rs5c348_plat_data *pdata;
 
-	/* Mode 1 (High-Active, Shift-Then-Sample), High Avtive CS  */
-	spi->mode = SPI_MODE_1 | SPI_CS_HIGH;
-	ret = spi_setup(spi);
-	if (ret)
-		return ret;
-
 	pdata = kzalloc(sizeof(struct rs5c348_plat_data), GFP_KERNEL);
 	if (!pdata)
 		return -ENOMEM;
-	/* allocate a DMA-safe buffer */
-	pdata->xferbuf = kmalloc(32, GFP_KERNEL);
-	if (!pdata->xferbuf) {
-		ret = -ENOMEM;
-		goto kfree_exit;
-	}
 	spi->dev.platform_data = pdata;
 
 	/* Check D7 of SECOND register */
@@ -234,7 +202,6 @@
 
 	return 0;
  kfree_exit:
-	kfree(pdata->xferbuf);
 	kfree(pdata);
 	return ret;
 }
@@ -246,7 +213,6 @@
 
 	if (rtc)
 		rtc_device_unregister(rtc);
-	kfree(pdata->xferbuf);
 	kfree(pdata);
 	return 0;
 }
