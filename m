Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267986AbUIAXV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267986AbUIAXV5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 19:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268119AbUIAXTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 19:19:34 -0400
Received: from baikonur.stro.at ([213.239.196.228]:51850 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267998AbUIAXQM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 19:16:12 -0400
Subject: [patch 06/14]  radio/radio-maestro: replace 	schedule_timeout() with msleep()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Thu, 02 Sep 2004 01:16:11 +0200
Message-ID: <E1C2eKp-0002nh-VY@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org







I would appreciate any comments from the janitor@sternweltens list.

Thanks,
Nish



Description: Replaced sleep_125ms() with msleep(125), udelay2()
with udelay(2), udelay4() with udelay(4) and udelay16() with
udelay(16) and removed the replaced functions' definitions.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.9-rc1-bk7-max/drivers/media/radio/radio-maestro.c |   50 +++---------
 1 files changed, 15 insertions(+), 35 deletions(-)

diff -puN drivers/media/radio/radio-maestro.c~msleep-drivers_media_radio-maestro drivers/media/radio/radio-maestro.c
--- linux-2.6.9-rc1-bk7/drivers/media/radio/radio-maestro.c~msleep-drivers_media_radio-maestro	2004-09-01 19:35:11.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/drivers/media/radio/radio-maestro.c	2004-09-01 19:35:11.000000000 +0200
@@ -93,27 +93,6 @@ static struct radio_device
 	struct  semaphore lock;
 } radio_unit = {0, 0, 0, 0, };
 
-static void sleep_125ms(void)
-{
-	current->state = TASK_INTERRUPTIBLE;
-	schedule_timeout(HZ >> 3);
-}
-
-static void udelay2(void)
-{
-	udelay(2);
-}
-
-static void udelay4(void)
-{
-	udelay(4);
-}
-
-static void udelay16(void)
-{
-	udelay(16);
-}
-
 static __u32 radio_bits_get(struct radio_device *dev)
 {
 	register __u16 io=dev->io, l, rdata;
@@ -122,14 +101,15 @@ static __u32 radio_bits_get(struct radio
 	omask = inw(io + IO_MASK);
 	outw(~(STR_CLK | STR_WREN), io + IO_MASK);
 	outw(0, io);
-	udelay16();
+	udelay(16);
+
 	for (l=24;l--;) {
 		outw(STR_CLK, io);		/* HI state */
-		udelay2();
+		udelay(2);
 		if(!l) 
 			dev->tuned = inw(io) & STR_MOST ? 0 : 0xffff;
 		outw(0, io);			/* LO state */
-		udelay2();
+		udelay(2);
 		data <<= 1;			/* shift data */
 		rdata = inw(io);
 		if(!l)
@@ -138,11 +118,11 @@ static __u32 radio_bits_get(struct radio
 		else
 			if(rdata & STR_DATA)
 				data++;
-		udelay2();
+		udelay(2);
 	}
 	if(dev->muted)
 		outw(STR_WREN, io);
-	udelay4();
+	udelay(4);
 	outw(omask, io + IO_MASK);
 	return data & 0x3ffe;
 }
@@ -155,23 +135,23 @@ static void radio_bits_set(struct radio_
 	odir  = (inw(io + IO_DIR) & ~STR_DATA) | (STR_CLK | STR_WREN);
 	outw(odir | STR_DATA, io + IO_DIR);
 	outw(~(STR_DATA | STR_CLK | STR_WREN), io + IO_MASK);
-	udelay16();
+	udelay(16);
 	for (l=25;l;l--) {
 		bits = ((data >> 18) & STR_DATA) | STR_WREN ;
 		data <<= 1;			/* shift data */
 		outw(bits, io);			/* start strobe */
-		udelay2();
+		udelay(2);
 		outw(bits | STR_CLK, io);	/* HI level */
-		udelay2();   
+		udelay(2);
 		outw(bits, io);			/* LO level */
-		udelay4();
+		udelay(4);
 	}
 	if(!dev->muted)
 		outw(0, io);
-	udelay4();
+	udelay(4);
 	outw(omask, io + IO_MASK);
 	outw(odir, io + IO_DIR);
-	sleep_125ms();
+	msleep(125);
 }
 
 inline static int radio_function(struct inode *inode, struct file *file,
@@ -238,9 +218,9 @@ inline static int radio_function(struct 
 				outw(~STR_WREN, io + IO_MASK);
 				outw((card->muted = v->flags & VIDEO_AUDIO_MUTE)
 				     ? STR_WREN : 0, io);
-				udelay4();
+				udelay(4);
 				outw(omask, io + IO_MASK);
-				sleep_125ms();
+				msleep(125);
 				return 0;
 			}
 		}
@@ -315,7 +295,7 @@ inline static __u16 radio_power_on(struc
 	outw(odir, io + IO_DIR);
 	outw(~(STR_WREN | STR_CLK), io + IO_MASK);
 	outw(dev->muted ? 0 : STR_WREN, io);
-	udelay16();
+	udelay(16);
 	outw(omask, io + IO_MASK);
 	ofreq = radio_bits_get(dev);
 	if((ofreq<FREQ2BITS(FREQ_LO)) || (ofreq>FREQ2BITS(FREQ_HI)))

_
