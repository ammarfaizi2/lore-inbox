Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267180AbUJTAxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267180AbUJTAxo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 20:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266891AbUJTAxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 20:53:41 -0400
Received: from mail.kroah.org ([69.55.234.183]:6836 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267180AbUJTATa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 20:19:30 -0400
Subject: Re: [PATCH] I2C update for 2.6.9
In-Reply-To: <10982315043501@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 19 Oct 2004 17:18:25 -0700
Message-Id: <10982315052484@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1867.7.5, 2004/09/15 15:27:44-07:00, johnpol@2ka.mipt.ru

[PATCH] w1_therm: more precise temperature calculation

This patch will introduce new temperature calculation mechanism which
allows to use up to 9bit resolution(currently 3 digits after point).
Fixed timeout issues with multiple repeated reading.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/w1/w1_therm.c |   71 ++++++++++++++++++++++++++++++--------------------
 1 files changed, 43 insertions(+), 28 deletions(-)


diff -Nru a/drivers/w1/w1_therm.c b/drivers/w1/w1_therm.c
--- a/drivers/w1/w1_therm.c	2004-10-19 16:55:06 -07:00
+++ b/drivers/w1/w1_therm.c	2004-10-19 16:55:06 -07:00
@@ -59,19 +59,28 @@
 	return sprintf(buf, "%s\n", sl->name);
 }
 
+static inline int w1_convert_temp(u8 rom[9])
+{
+	int t, h;
+	
+	if (rom[1] == 0)
+		t = ((s32)rom[0] >> 1)*1000;
+	else
+		t = 1000*(-1*(s32)(0x100-rom[0]) >> 1);
+	
+	t -= 250;
+	h = 1000*((s32)rom[7] - (s32)rom[6]);
+	h /= (s32)rom[7];
+	t += h;
+
+	return t;
+}
+
 static ssize_t w1_therm_read_temp(struct device *dev, char *buf)
 {
 	struct w1_slave *sl = container_of(dev, struct w1_slave, dev);
-	s16 temp;
-
-	/* 
-	 * Must be more precise.
-	 */
-	temp = 0;
-	temp <<= sl->rom[1] / 2;
-	temp |= sl->rom[0] / 2;
 
-	return sprintf(buf, "%d\n", temp * 1000);
+	return sprintf(buf, "%d\n", w1_convert_temp(sl->rom));
 }
 
 static int w1_therm_check_rom(u8 rom[9])
@@ -92,7 +101,6 @@
 	struct w1_master *dev = sl->master;
 	u8 rom[9], crc, verdict;
 	int i, max_trying = 10;
-	u16 temp;
 
 	atomic_inc(&sl->refcnt);
 	if (down_interruptible(&sl->master->mutex)) {
@@ -120,6 +128,7 @@
 		if (!w1_reset_bus (dev)) {
 			int count = 0;
 			u8 match[9] = {W1_MATCH_ROM, };
+			unsigned long tm;
 
 			memcpy(&match[1], (u64 *) & sl->reg_num, 8);
 			
@@ -127,24 +136,29 @@
 
 			w1_write_8(dev, W1_CONVERT_TEMP);
 
-			if (count < 10) {
-				if (!w1_reset_bus(dev)) {
-					w1_write_block(dev, match, 9);
-
-					w1_write_8(dev, W1_READ_SCRATCHPAD);
-					if ((count = w1_read_block(dev, rom, 9)) != 9) {
-						dev_warn(&dev->dev, "w1_read_block() returned %d instead of 9.\n", count);
-					}
+			tm = jiffies + msecs_to_jiffies(750);
+			while(time_before(jiffies, tm)) {
+				set_current_state(TASK_INTERRUPTIBLE);
+				schedule_timeout(tm-jiffies);
 
-					crc = w1_calc_crc8(rom, 8);
+				if (signal_pending(current))
+					flush_signals(current);
+			}
 
-					if (rom[8] == crc && rom[0])
-						verdict = 1;
+			if (!w1_reset_bus (dev)) {
+				w1_write_block(dev, match, 9);
+				
+				w1_write_8(dev, W1_READ_SCRATCHPAD);
+				if ((count = w1_read_block(dev, rom, 9)) != 9) {
+					dev_warn(&dev->dev, "w1_read_block() returned %d instead of 9.\n", count);
 				}
+
+				crc = w1_calc_crc8(rom, 8);
+
+				if (rom[8] == crc && rom[0])
+					verdict = 1;
+
 			}
-			else
-				dev_warn(&dev->dev,
-					  "18S20 doesn't respond to CONVERT_TEMP.\n");
 		}
 
 		if (!w1_therm_check_rom(rom))
@@ -157,12 +171,13 @@
 			   crc, (verdict) ? "YES" : "NO");
 	if (verdict)
 		memcpy(sl->rom, rom, sizeof(sl->rom));
+	else
+		dev_warn(&dev->dev, "18S20 doesn't respond to CONVERT_TEMP.\n");
+
 	for (i = 0; i < 9; ++i)
 		count += sprintf(buf + count, "%02x ", sl->rom[i]);
-	temp = 0;
-	temp <<= sl->rom[1] / 2;
-	temp |= sl->rom[0] / 2;
-	count += sprintf(buf + count, "t=%u\n", temp);
+	
+	count += sprintf(buf + count, "t=%d\n", w1_convert_temp(rom));
 out:
 	up(&dev->mutex);
 out_dec:

