Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267409AbUIPJUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267409AbUIPJUi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 05:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267880AbUIPJUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 05:20:38 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:18142 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S267409AbUIPJUZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 05:20:25 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 16 Sep 2004 11:10:04 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: tuner update
Message-ID: <20040916091004.GA11496@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This is a update for the analof tv tuner module, it adds support for
two new tuner chips.

please apply,

  Gerd

diff -up linux-2.6.9-rc2/drivers/media/video/tuner.c linux/drivers/media/video/tuner.c
--- linux-2.6.9-rc2/drivers/media/video/tuner.c	2004-09-14 10:37:22.000000000 +0200
+++ linux/drivers/media/video/tuner.c	2004-09-16 10:06:33.000000000 +0200
@@ -129,7 +129,8 @@ struct tunertype 
 	unsigned char config; 
 	unsigned short IFPCoff; /* 622.4=16*38.90 MHz PAL, 
 				   732  =16*45.75 NTSCi, 
-				   940  =58.75 NTSC-Japan */
+				   940  =16*58.75 NTSC-Japan
+				   704  =16*44    ATSC */
 };
 
 /*
@@ -244,10 +245,14 @@ static struct tunertype tuners[] = {
 	{ "Panasonic VP27s/ENGE4324D", Panasonic, NTSC,
 	  16*160.00,16*454.00,0x01,0x02,0x08,0xce,940},
         { "LG NTSC (TAPE series)", LGINNOTEK, NTSC,
-          16*170.00, 16*450.00, 0x01,0x02,0x04,0x8e,732 },
+          16*160.00,16*442.00,0x01,0x02,0x04,0xc8,732 },
 
         { "Tenna TNF 8831 BGFF)", Philips, PAL,
           16*161.25,16*463.25,0xa0,0x90,0x30,0x8e,623},
+	{ "Microtune 4042 FI5 ATSC/NTSC dual in", Microtune, NTSC,
+	  16*162.00,16*457.00,0xa2,0x94,0x31,0x8e,732},
+        { "TCL 2002N", TCL, NTSC,
+          16*172.00,16*448.00,0x01,0x02,0x08,0x88,732},
 
 };
 #define TUNERS ARRAY_SIZE(tuners)
@@ -550,7 +555,7 @@ static void mt2032_set_tv_freq(struct i2
 		// NTSC
 		from = 40750*1000;
 		to   = 46750*1000;
-		if2  = 45750*1000;
+		if2  = 45750*1000; 
 	} else {
 		// PAL
 		from = 32900*1000;
@@ -854,7 +859,7 @@ static void default_set_tv_freq(struct i
 
 		} else if (t->std & V4L2_STD_PAL_DK) {
 			config |= TEMIC_SET_PAL_DK;
-
+			
 		} else if (t->std & V4L2_STD_SECAM_L) {
 			config |= TEMIC_SET_PAL_L;
 
@@ -886,8 +891,12 @@ static void default_set_tv_freq(struct i
 			config |= 2;
 		/* FIXME: input */
 		break;
-	}
 
+	case TUNER_MICROTUNE_4042FI5:
+		/* Set the charge pump for fast tuning */
+		tun->config |= 0x40;
+		break;
+	}
 	
 	/*
 	 * Philips FI1216MK2 remark from specification :
@@ -921,6 +930,37 @@ static void default_set_tv_freq(struct i
         if (4 != (rc = i2c_master_send(c,buffer,4)))
                 printk("tuner: i2c i/o error: rc == %d (should be 4)\n",rc);
 
+	if (t->type == TUNER_MICROTUNE_4042FI5) {
+		// FIXME - this may also work for other tuners
+		unsigned long timeout = jiffies + msecs_to_jiffies(1);
+		u8 status_byte = 0;
+
+		/* Wait until the PLL locks */
+		for (;;) {
+			if (time_after(jiffies,timeout))
+				return;
+			if (1 != (rc = i2c_master_recv(c,&status_byte,1))) {
+				dprintk("tuner: i2c i/o read error: rc == %d (should be 1)\n",rc);
+				break;
+			}
+			/* bit 6 is PLL locked indicator */
+			if (status_byte & 0x40)
+				break;
+			udelay(10);
+		}
+		
+		/* Set the charge pump for optimized phase noise figure */
+		tun->config &= ~0x40;
+		buffer[0] = (div>>8) & 0x7f;
+		buffer[1] = div      & 0xff;
+		buffer[2] = tun->config;
+		buffer[3] = config;
+		dprintk("tuner: tv 0x%02x 0x%02x 0x%02x 0x%02x\n",
+			buffer[0],buffer[1],buffer[2],buffer[3]);
+
+		if (4 != (rc = i2c_master_send(c,buffer,4)))
+			dprintk("tuner: i2c i/o error: rc == %d (should be 4)\n",rc);
+	}
 }
 
 static void default_set_radio_freq(struct i2c_client *c, unsigned int freq)
diff -up linux-2.6.9-rc2/include/media/tuner.h linux/include/media/tuner.h
--- linux-2.6.9-rc2/include/media/tuner.h	2004-09-14 10:36:54.000000000 +0200
+++ linux/include/media/tuner.h	2004-09-16 10:06:33.000000000 +0200
@@ -1,3 +1,4 @@
+
 /* 
     tuner.h - definition for different tuners
 
@@ -69,9 +70,12 @@
 #define TUNER_PHILIPS_ATSC       42
 #define TUNER_PHILIPS_FM1236_MK3 43
 #define TUNER_PHILIPS_4IN1       44	/* ATI TV Wonder Pro - Conexant */
+/* Microtune mergeged with Temic 12/31/1999 partially financed by Alps - these may be similar to Temic */ 
 #define TUNER_MICROTUNE_4049FM5  45
 #define TUNER_LG_NTSC_TAPE       47
 #define TUNER_TNF_8831BGFF       48
+#define TUNER_MICROTUNE_4042FI5  49	/* FusionHDTV 3 Gold - 4042 FI5 (3X 8147) */
+#define TUNER_TCL_2002N          50
 
 #define NOTUNER 0
 #define PAL     1	/* PAL_BG */
@@ -91,6 +95,7 @@
 #define Microtune 8
 #define HITACHI 9
 #define Panasonic 10
+#define TCL     11
 
 #define TUNER_SET_TYPE               _IOW('t',1,int)    /* set tuner type */
 #define TUNER_SET_TVFREQ             _IOW('t',2,int)    /* set tv freq */

-- 
return -ENOSIG;
