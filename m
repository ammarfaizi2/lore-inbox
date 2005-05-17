Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbVEQBQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVEQBQm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 21:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVEQBQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 21:16:42 -0400
Received: from b2492.static.pacific.net.au ([210.23.143.146]:60867 "EHLO
	b2492.static.pacific.net.au") by vger.kernel.org with ESMTP
	id S261631AbVEQBPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 21:15:54 -0400
Message-ID: <428945C3.2050109@peterskipworth.com>
Date: Tue, 17 May 2005 11:15:47 +1000
From: Peter Skipworth <pete@peterskipworth.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] BTTV support for Adlink RTV24
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is my first post, so please let me know if I'm going about this the 
wrong way.

The bttv module currently lacks support for the Adlink RTV24 capture 
card. The following patch adds support for the Adlink RTV24 video 
capture card to the bttv module.
This patch is against sources for 2.6.11.9.


diff -uprN -X dontdiff linux-2.6.11.9/drivers/media/video/bttv-cards.c 
linux-2.6.11.9-with-bttv-changes/drivers/media/video/bttv-cards.c
--- linux-2.6.11.9/drivers/media/video/bttv-cards.c    2005-05-12 
08:41:58.000000000 +1000
+++ linux-2.6.11.9-with-bttv-changes/drivers/media/video/bttv-cards.c    
2005-05-16 17:37:07.000000000 +1000
@@ -51,6 +51,7 @@ static void avermedia_eeprom(struct bttv
 static void osprey_eeprom(struct bttv *btv);
 static void modtec_eeprom(struct bttv *btv);
 static void init_PXC200(struct bttv *btv);
+static void init_RTV24(struct bttv *btv);
 
 static void winview_audio(struct bttv *btv, struct video_audio *v, int 
set);
 static void lt9415_audio(struct bttv *btv, struct video_audio *v, int set);
@@ -2188,7 +2189,20 @@ struct tvcard bttv_tvcards[] = {
         .no_tda7432    = 1,
         .tuner_type     = -1,
         .muxsel_hook    = tibetCS16_muxsel,
-}};
+},{
+       /* ---- card 0x84---------------------------------- */
+       /* Michael Henson <mhenson@clarityvi.com> */
+       /* Adlink RTV24 with special unlock codes */
+       .name           = "Adlink RTV24",
+       .video_inputs   = 4,
+       .audio_inputs   = 1,
+       .tuner          = 0,
+       .svhs           = 2,
+       .muxsel         = { 2, 3, 1, 0},
+       .tuner_type     = -1,
+       .pll            = PLL_28,
+
+};
 
 static const unsigned int bttv_num_tvcards = ARRAY_SIZE(bttv_tvcards);
 
@@ -2682,6 +2696,10 @@ void __devinit bttv_init_card2(struct bt
     case BTTV_TIBET_CS16:
         tibetCS16_init(btv);
         break;
+        case BTTV_ADLINK_RTV24:
+                init_RTV24( btv );
+                break;
+
     }
 
     /* pll configuration */
@@ -3238,6 +3256,99 @@ static void __devinit init_PXC200(struct
 }
 
 
+
+/* 
----------------------------------------------------------------------- */
+/*
+ *  The Adlink RTV-24 (aka Angelo) has some special initialisation to 
unlock
+ *  it. This apparently involves the following procedure for each 878 chip:
+ *
+ *  1) write 0x00C3FEFF to the GPIO_OUT_EN register
+ *
+ *  2)  write to GPIO_DATA
+ *      - 0x0E
+ *      - sleep 1ms
+ *      - 0x10 + 0x0E
+ *      - sleep 10ms
+ *      - 0x0E
+ *     read from GPIO_DATA into buf (uint_32)
+ *      - if ( data>>18 & 0x01 != 0) || ( buf>>19 & 0x01 != 1 )
+ *                 error. ERROR_CPLD_Check_Failed stop.
+ *
+ *  3) write to GPIO_DATA
+ *      - write 0x4400 + 0x0E
+ *      - sleep 10ms
+ *      - write 0x4410 + 0x0E
+ *      - sleep 1ms
+ *      - write 0x0E
+ *     read from GPIO_DATA into buf (uint_32)
+ *      - if ( buf>>18 & 0x01 ) || ( buf>>19 && 0x01 != 0 )
+ *                error. ERROR_CPLD_Check_Failed.
+ */
+/* 
----------------------------------------------------------------------- */
+void init_RTV24(struct bttv *btv)
+{
+        uint32_t dataRead = 0;
+        long watchdog_value = 0x0E;
+
+        printk(
+                KERN_INFO
+                "bttv%d: Adlink RTV-24 initialisation in progress ...\n",
+                btv->c.nr
+        );
+
+        btwrite( 0x00c3feff, BT848_GPIO_OUT_EN );
+
+        btwrite( 0 + watchdog_value, BT848_GPIO_DATA );
+        msleep( 1 );
+        btwrite( 0x10 + watchdog_value, BT848_GPIO_DATA );
+        msleep( 10 );
+        btwrite( 0 + watchdog_value, BT848_GPIO_DATA );
+
+        dataRead = btread( BT848_GPIO_DATA );
+
+        if ( ( ( ( dataRead >> 18 ) & 0x01 ) != 0 ) ||
+             ( ( ( dataRead >> 19 ) & 0x01 ) != 1 )
+        )
+         {
+                printk(
+                        KERN_INFO
+                        "bttv%d: Adlink RTV-24 initialisation(1) 
ERROR_CPLD_Check_Failed (read %d)\n",
+                        btv->c.nr, dataRead
+                );
+
+                /*      return; */
+        }
+
+        btwrite( 0x4400 + watchdog_value, BT848_GPIO_DATA );
+        msleep( 10 );
+        btwrite( 0x4410 + watchdog_value, BT848_GPIO_DATA );
+        msleep( 1 );
+        btwrite( watchdog_value, BT848_GPIO_DATA );
+        msleep( 1 );
+        dataRead = btread( BT848_GPIO_DATA );
+
+        if ( ( ( ( dataRead >> 18 ) & 0x01 ) != 0 ) ||
+             ( ( ( dataRead >> 19 ) & 0x01 ) != 0 )
+        )
+         {
+                printk(
+                        KERN_INFO
+                        "bttv%d: Adlink RTV-24 initialisation(2) 
ERROR_CPLD_Check_Failed (read %d)\n",
+                        btv->c.nr, dataRead
+                );
+
+                return;
+        }
+
+        printk(
+                KERN_INFO
+                "bttv%d: Adlink RTV-24 initialisation complete.\n",
+                btv->c.nr
+        );
+}
+
+
+
 /* 
----------------------------------------------------------------------- */
 /* Miro Pro radio stuff -- the tea5757 is connected to some GPIO 
ports     */
 /*
diff -uprN -X dontdiff linux-2.6.11.9/drivers/media/video/bttv.h 
linux-2.6.11.9-with-bttv-changes/drivers/media/video/bttv.h
--- linux-2.6.11.9/drivers/media/video/bttv.h    2005-05-12 
08:41:12.000000000 +1000
+++ linux-2.6.11.9-with-bttv-changes/drivers/media/video/bttv.h    
2005-05-16 17:29:50.000000000 +1000
@@ -134,6 +134,7 @@
 #define BTTV_APAC_VIEWCOMP  0x7f
 #define BTTV_DVICO_DVBT_LITE  0x80
 #define BTTV_TIBET_CS16  0x83
+#define BTTV_ADLINK_RTV24   0x84
 
 /* i2c address list */
 #define I2C_TSA5522        0xc2



