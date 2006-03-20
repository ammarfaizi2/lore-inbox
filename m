Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964959AbWCTPZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbWCTPZx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965282AbWCTPZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:25:20 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:17592 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964875AbWCTPY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:24:28 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 008/141] V4L/DVB (3405): Fixes tvp5150a/am1 detection.
Date: Mon, 20 Mar 2006 12:08:38 -0300
Message-id: <20060320150838.PS404835000008@infradead.org>
In-Reply-To: <20060320150819.PS760228000000@infradead.org>
References: <20060320150819.PS760228000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab@infradead.org>
Date: 1138016914 -0200

- Tvp5150 type were determined by a secondary register instead of
  using ROM code.
- tvp5150am1 have ROM=4.0, while tvp5150a have ROM=3.33 (decimal).
  All other ROM versions are reported as unknown tvp5150.
- Except for reporting, current code doesn't enable any special feature
  for tvp5150am1 or tvp5150a. Code should work for both models (but were
  tested only for tvp5150am1).

Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/tvp5150.c b/drivers/media/video/tvp5150.c
diff --git a/drivers/media/video/tvp5150.c b/drivers/media/video/tvp5150.c
index fad9ea0..a6330a3 100644
--- a/drivers/media/video/tvp5150.c
+++ b/drivers/media/video/tvp5150.c
@@ -746,24 +746,27 @@ static int tvp5150_set_std(struct i2c_cl
 
 static inline void tvp5150_reset(struct i2c_client *c)
 {
-	u8 type, ver_656, msb_id, lsb_id, msb_rom, lsb_rom;
+	u8 msb_id, lsb_id, msb_rom, lsb_rom;
 	struct tvp5150 *decoder = i2c_get_clientdata(c);
 
-	type=tvp5150_read(c,TVP5150_AUTOSW_MSK);
 	msb_id=tvp5150_read(c,TVP5150_MSB_DEV_ID);
 	lsb_id=tvp5150_read(c,TVP5150_LSB_DEV_ID);
 	msb_rom=tvp5150_read(c,TVP5150_ROM_MAJOR_VER);
 	lsb_rom=tvp5150_read(c,TVP5150_ROM_MINOR_VER);
 
-	if (type==0xdc) {
-		ver_656=tvp5150_read(c,TVP5150_REV_SELECT);
-		tvp5150_info("tvp%02x%02xam1 detected 656 version is %d.\n",msb_id, lsb_id,ver_656);
-	} else if (type==0xfc) {
-		tvp5150_info("tvp%02x%02xa detected.\n",msb_id, lsb_id);
+	if ((msb_rom==4)&&(lsb_rom==0)) { /* Is TVP5150AM1 */
+		tvp5150_info("tvp%02x%02xam1 detected.\n",msb_id, lsb_id);
+
+		/* ITU-T BT.656.4 timing */
+		tvp5150_write(c,TVP5150_REV_SELECT,0);
 	} else {
-		tvp5150_info("unknown tvp%02x%02x chip detected(%d).\n",msb_id,lsb_id,type);
+		if ((msb_rom==3)||(lsb_rom==0x21)) { /* Is TVP5150A */
+			tvp5150_info("tvp%02x%02xa detected.\n",msb_id, lsb_id);
+		} else {
+			tvp5150_info("*** unknown tvp%02x%02x chip detected.\n",msb_id,lsb_id);
+			tvp5150_info("*** Rom ver is %d.%d\n",msb_rom,lsb_rom);
+		}
 	}
-	tvp5150_info("Rom ver is %d.%d\n",msb_rom,lsb_rom);
 
 	/* Initializes TVP5150 to its default values */
 	tvp5150_write_inittab(c, tvp5150_init_default);

