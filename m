Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267923AbUIURqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267923AbUIURqP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 13:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267903AbUIURqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 13:46:15 -0400
Received: from mail.convergence.de ([212.227.36.84]:10905 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S267934AbUIURmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 13:42:55 -0400
Message-ID: <415067CB.1020101@linuxtv.org>
Date: Tue, 21 Sep 2004 19:41:31 +0200
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
CC: sensors@Stimpy.netroedge.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Adding .class field to struct i2c_client (was Re: [PATCH][2.6] Add
 command function to struct i2c_adapter
References: <41500BED.8090607@linuxtv.org> <20040921115442.M18286@linux-fr.org>
In-Reply-To: <20040921115442.M18286@linux-fr.org>
Content-Type: multipart/mixed;
 boundary="------------020504000006060008090307"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020504000006060008090307
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 21.09.2004 15:28, Jean Delvare wrote:
> On a completely different matter, what about the i2c subsystem class flags and
> checking mechanism? You had come with a first step some months ago (adding a
> class member to i2c clients), and your proposal (generalized check of i2c
> client class against adapter class) looked very good to me, but then we did
> not finish the job. What about it? 

I was unsure about the .class entries for some of the clients, then 
didn't find the time to investigate further and from then on the patches 
are bit-rotting on my harddisc. ;-(

> I am willing to help on the sensors front
> if you are going into this again someday. If I remember correctly, step 2 was
> about clearing manual class checks and filling all class members, and step 3
> was about implementing the generalized check in i2c-core. Am I right?

Yes, right. I've cleaned up the patches and attached them to this mail. 
Unfortunately, they only apply to 2.6.8(.1), but not 2.6.9-rc2-mm1. This 
is because SMBUS has been renamed to HWMON IIRC.

Please have a look and tell me what you think. The big problem will be, 
that we cannot test all configurations, so it's possible that some 
devices won't be recognized anymore, because the .class entries don't match.

Patches 1-3 are straight forward. For patches 4-7 I once created the 
following list:

==>4
#drivers/ieee1394/pcilynx.c => I2C_CLASS_NONE
#drivers/macintosh/therm_adt746x.c => I2C_CLASS_HWMON
#drivers/macintosh/therm_pm72.c => I2C_CLASS_HWMON
#drivers/macintosh/therm_windtunnel.c => I2C_CLASS_HWMON
#drivers/acorn/char/pcf8583.c => I2C_CLASS_ALL
#drivers/acorn/char/i2c.c => I2C_CLASS_ALL
#drivers/i2c/busses/i2c-keywest.c: => I2C_CLASS_HWMON | I2C_CLASS_SOUND;
#sound/ppc/keywest.c => I2C_CLASS_SOUND
#sound/oss/dmasound/dac3550a.c => I2C_CLASS_SOUND
#sound/oss/dmasound/tas_common.c => I2C_CLASS_SOUND

==>5
#drivers/i2c/algos/i2c-algo-pcf.c => I2C_CLASS_ALL
#drivers/i2c/busses/i2c-elektor.c => I2C_CLASS_ALL
#drivers/video/aty/radeon_i2c.c => I2C_CLASS_NONE
#drivers/video/matrox/i2c-matroxfb.c => I2C_CLASS_DDC and 
I2C_CLASS_TV_ANALOG
#drivers/video/matrox/matroxfb_maven.c => I2C_CLASS_TV_ANALOG
#drivers/media/video/zoran_card.c => I2C_CLASS_TV_ANALOG
#drivers/media/video/ir-kbd-i2c.c => I2C_CLASS_TV_ANALOG | 
I2C_CLASS_TV_DIGITAL
#drivers/media/dvb/bt8xx/dvb-bt8xx.c => I2C_CLASS_ALL

==>6
#drivers/i2c/busses/i2c-ibm_iic.c: => I2C_CLASS_ALL
#drivers/i2c/busses/i2c-iop3xx.c:=> I2C_CLASS_ALL
#drivers/i2c/busses/scx200_i2c.c => I2C_CLASS_ALL
#drivers/i2c/busses/i2c-ite.c => I2C_CLASS_ALL
(drivers/i2c/algos/i2c-algo-ite.c:)

==>7
#drivers/i2c/busses/i2c-frodo.c => I2C_CLASS_ALL
#drivers/i2c/busses/i2c-i810.c => I2C_CLASS_ALL + I2C_CLASS_DDC
#drivers/i2c/busses/i2c-prosavage.c => I2C_CLASS_ALL + I2C_CLASS_DDC
#drivers/i2c/busses/i2c-savage4.c => I2C_CLASS_ALL
#drivers/i2c/busses/i2c-ixp4xx.c => I2C_CLASS_ALL, doesn't compile!?
#drivers/i2c/busses/i2c-hydra.c => I2C_CLASS_HWMON

> Thanks.

CU
Michael.


--------------020504000006060008090307
Content-Type: text/plain;
 name="01-drivers-media-video.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="01-drivers-media-video.diff"

diff -ura xx-linux-2.6-6-rc3-mm2/drivers/media/video/adv7170.c linux-2.6-6-rc3-mm2/drivers/media/video/adv7170.c
--- xx-linux-2.6-6-rc3-mm2/drivers/media/video/adv7170.c	2004-05-09 11:03:04.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/media/video/adv7170.c	2004-05-09 11:28:12.000000000 +0200
@@ -516,6 +516,7 @@
 
 	.id = I2C_DRIVERID_ADV7170,
 	.flags = I2C_DF_NOTIFY,
+ 	.class = I2C_CLASS_TV_ANALOG,
 
 	.attach_adapter = adv7170_attach_adapter,
 	.detach_client = adv7170_detach_client,
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/media/video/adv7175.c linux-2.6-6-rc3-mm2/drivers/media/video/adv7175.c
--- xx-linux-2.6-6-rc3-mm2/drivers/media/video/adv7175.c	2004-05-09 11:03:04.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/media/video/adv7175.c	2004-05-09 11:27:55.000000000 +0200
@@ -538,6 +538,7 @@
 
 	.id = I2C_DRIVERID_ADV7175,
 	.flags = I2C_DF_NOTIFY,
+ 	.class = I2C_CLASS_TV_ANALOG,
 
 	.attach_adapter = adv7175_attach_adapter,
 	.detach_client = adv7175_detach_client,
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/media/video/bt819.c linux-2.6-6-rc3-mm2/drivers/media/video/bt819.c
--- xx-linux-2.6-6-rc3-mm2/drivers/media/video/bt819.c	2004-05-09 11:03:03.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/media/video/bt819.c	2004-05-09 11:24:22.000000000 +0200
@@ -642,6 +642,7 @@
 
 	.id = I2C_DRIVERID_BT819,
 	.flags = I2C_DF_NOTIFY,
+	.class = I2C_CLASS_TV_ANALOG,
 
 	.attach_adapter = bt819_attach_adapter,
 	.detach_client = bt819_detach_client,
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/media/video/bt856.c linux-2.6-6-rc3-mm2/drivers/media/video/bt856.c
--- xx-linux-2.6-6-rc3-mm2/drivers/media/video/bt856.c	2004-05-09 11:03:03.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/media/video/bt856.c	2004-05-09 11:23:22.000000000 +0200
@@ -423,6 +423,7 @@
 
 	.id = I2C_DRIVERID_BT856,
 	.flags = I2C_DF_NOTIFY,
+	.class = I2C_CLASS_TV_ANALOG,
 
 	.attach_adapter = bt856_attach_adapter,
 	.detach_client = bt856_detach_client,
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/media/video/saa7110.c linux-2.6-6-rc3-mm2/drivers/media/video/saa7110.c
--- xx-linux-2.6-6-rc3-mm2/drivers/media/video/saa7110.c	2004-05-09 11:03:03.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/media/video/saa7110.c	2004-05-09 11:22:57.000000000 +0200
@@ -599,6 +599,7 @@
 
 	.id = I2C_DRIVERID_SAA7110,
 	.flags = I2C_DF_NOTIFY,
+	.class = I2C_CLASS_TV_ANALOG,
 
 	.attach_adapter = saa7110_attach_adapter,
 	.detach_client = saa7110_detach_client,
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/media/video/saa7111.c linux-2.6-6-rc3-mm2/drivers/media/video/saa7111.c
--- xx-linux-2.6-6-rc3-mm2/drivers/media/video/saa7111.c	2004-05-09 11:06:43.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/media/video/saa7111.c	2004-05-09 11:24:54.000000000 +0200
@@ -608,7 +608,8 @@
 
 	.id = I2C_DRIVERID_SAA7111A,
 	.flags = I2C_DF_NOTIFY,
-
+	.class = I2C_CLASS_TV_ANALOG,
+	
 	.attach_adapter = saa7111_attach_adapter,
 	.detach_client = saa7111_detach_client,
 	.command = saa7111_command,
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/media/video/saa7114.c linux-2.6-6-rc3-mm2/drivers/media/video/saa7114.c
--- xx-linux-2.6-6-rc3-mm2/drivers/media/video/saa7114.c	2004-05-09 11:03:04.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/media/video/saa7114.c	2004-05-09 11:27:15.000000000 +0200
@@ -1222,6 +1222,7 @@
 
 	.id = I2C_DRIVERID_SAA7114,
 	.flags = I2C_DF_NOTIFY,
+ 	.class = I2C_CLASS_TV_ANALOG,
 
 	.attach_adapter = saa7114_attach_adapter,
 	.detach_client = saa7114_detach_client,
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/media/video/saa7185.c linux-2.6-6-rc3-mm2/drivers/media/video/saa7185.c
--- xx-linux-2.6-6-rc3-mm2/drivers/media/video/saa7185.c	2004-05-09 11:03:03.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/media/video/saa7185.c	2004-05-09 11:23:55.000000000 +0200
@@ -505,6 +505,7 @@
 
 	.id = I2C_DRIVERID_SAA7185B,
 	.flags = I2C_DF_NOTIFY,
+	.class = I2C_CLASS_TV_ANALOG,
 
 	.attach_adapter = saa7185_attach_adapter,
 	.detach_client = saa7185_detach_client,
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/media/video/tda9840.c linux-2.6-6-rc3-mm2/drivers/media/video/tda9840.c
--- xx-linux-2.6-6-rc3-mm2/drivers/media/video/tda9840.c	2004-05-09 11:03:03.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/media/video/tda9840.c	2004-05-09 11:26:35.000000000 +0200
@@ -263,6 +263,7 @@
 	.name		= "tda9840 driver",
 	.id		= I2C_DRIVERID_TDA9840,
 	.flags		= I2C_DF_NOTIFY,
+ 	.class 		= I2C_CLASS_TV_ANALOG,
         .attach_adapter = tda9840_attach,
         .detach_client	= tda9840_detach,
         .command	= tda9840_command,
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/media/video/tea6415c.c linux-2.6-6-rc3-mm2/drivers/media/video/tea6415c.c
--- xx-linux-2.6-6-rc3-mm2/drivers/media/video/tea6415c.c	2004-05-09 11:03:03.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/media/video/tea6415c.c	2004-05-09 11:26:52.000000000 +0200
@@ -212,6 +212,7 @@
 	.name		= "tea6415c driver",
 	.id		= I2C_DRIVERID_TEA6415C,
 	.flags		= I2C_DF_NOTIFY,
+ 	.class 		= I2C_CLASS_TV_ANALOG,
         .attach_adapter = tea6415c_attach,
         .detach_client	= tea6415c_detach,
         .command	= tea6415c_command,
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/media/video/tea6420.c linux-2.6-6-rc3-mm2/drivers/media/video/tea6420.c
--- xx-linux-2.6-6-rc3-mm2/drivers/media/video/tea6420.c	2004-05-09 11:03:03.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/media/video/tea6420.c	2004-05-09 11:26:09.000000000 +0200
@@ -192,8 +192,9 @@
 	.name		= "tea6420 driver",
 	.id		= I2C_DRIVERID_TEA6420,
 	.flags		= I2C_DF_NOTIFY,
-        .attach_adapter = tea6420_attach,
+ 	.class 		= I2C_CLASS_TV_ANALOG,
+	.attach_adapter = tea6420_attach,
         .detach_client	= tea6420_detach,
         .command	= tea6420_command,
 };
 
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/media/video/tuner-3036.c linux-2.6-6-rc3-mm2/drivers/media/video/tuner-3036.c
--- xx-linux-2.6-6-rc3-mm2/drivers/media/video/tuner-3036.c	2004-05-09 11:03:03.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/media/video/tuner-3036.c	2004-05-09 11:25:25.000000000 +0200
@@ -185,6 +185,7 @@
 	.name		=	"sab3036",
 	.id		=	I2C_DRIVERID_SAB3036,
         .flags		=	I2C_DF_NOTIFY,
+	.class 		=	I2C_CLASS_TV_ANALOG,
 	.attach_adapter =	tuner_probe,
 	.detach_client  =	tuner_detach,
 	.command	=	tuner_command
@@ -200,8 +201,7 @@
 int __init
 tuner3036_init(void)
 {
-	i2c_add_driver(&i2c_driver_tuner);
-	return 0;
+	return i2c_add_driver(&i2c_driver_tuner);
 }
 
 void __exit
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/media/video/vpx3220.c linux-2.6-6-rc3-mm2/drivers/media/video/vpx3220.c
--- xx-linux-2.6-6-rc3-mm2/drivers/media/video/vpx3220.c	2004-05-09 11:03:03.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/media/video/vpx3220.c	2004-05-09 11:27:33.000000000 +0200
@@ -731,6 +731,7 @@
 
 	.id = I2C_DRIVERID_VPX3220,
 	.flags = I2C_DF_NOTIFY,
+ 	.class = I2C_CLASS_TV_ANALOG,
 
 	.attach_adapter = vpx3220_attach_adapter,
 	.detach_client = vpx3220_detach_client,

--------------020504000006060008090307
Content-Type: text/plain;
 name="02-drivers-media-video-2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="02-drivers-media-video-2.diff"

diff -ura xx-linux-2.6-6-rc3-mm2/drivers/media/video/bt832.c linux-2.6-6-rc3-mm2/drivers/media/video/bt832.c
--- xx-linux-2.6-6-rc3-mm2/drivers/media/video/bt832.c	2004-05-09 11:11:10.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/media/video/bt832.c	2004-05-09 14:49:58.000000000 +0200
@@ -197,9 +197,7 @@
 
 static int bt832_probe(struct i2c_adapter *adap)
 {
-	if (adap->class & I2C_CLASS_TV_ANALOG)
-		return i2c_probe(adap, &addr_data, bt832_attach);
-	return 0;
+	return i2c_probe(adap, &addr_data, bt832_attach);
 }
 
 static int bt832_detach(struct i2c_client *client)
@@ -243,6 +241,7 @@
         .name           = "i2c bt832 driver",
         .id             = -1, /* FIXME */
         .flags          = I2C_DF_NOTIFY,
+	.class		= I2C_CLASS_TV_ANALOG,
         .attach_adapter = bt832_probe,
         .detach_client  = bt832_detach,
         .command        = bt832_command,
@@ -257,8 +256,7 @@
 
 int bt832_init_module(void)
 {
-	i2c_add_driver(&driver);
-	return 0;
+	return i2c_add_driver(&driver);
 }
 
 static void bt832_cleanup_module(void)
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/media/video/msp3400.c linux-2.6-6-rc3-mm2/drivers/media/video/msp3400.c
--- xx-linux-2.6-6-rc3-mm2/drivers/media/video/msp3400.c	2004-05-09 11:11:11.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/media/video/msp3400.c	2004-05-09 14:48:30.000000000 +0200
@@ -1222,6 +1222,7 @@
         .name           = "i2c msp3400 driver",
         .id             = I2C_DRIVERID_MSP3400,
         .flags          = I2C_DF_NOTIFY,
+	.class		= I2C_CLASS_TV_ANALOG,
         .attach_adapter = msp_probe,
         .detach_client  = msp_detach,
         .command        = msp_command,
@@ -1353,19 +1354,7 @@
 
 static int msp_probe(struct i2c_adapter *adap)
 {
-#ifdef I2C_CLASS_TV_ANALOG
-	if (adap->class & I2C_CLASS_TV_ANALOG)
-		return i2c_probe(adap, &addr_data, msp_attach);
-#else
-	switch (adap->id) {
-	case I2C_ALGO_BIT | I2C_HW_SMBUS_VOODOO3:
-	case I2C_ALGO_BIT | I2C_HW_B_BT848:
-	//case I2C_ALGO_SAA7134:
-		return i2c_probe(adap, &addr_data, msp_attach);
-		break;
-	}
-#endif
-	return 0;
+	return i2c_probe(adap, &addr_data, msp_attach);
 }
 
 static void msp_wake_thread(struct i2c_client *client)
@@ -1558,8 +1547,7 @@
 
 static int msp3400_init_module(void)
 {
-	i2c_add_driver(&driver);
-	return 0;
+	return i2c_add_driver(&driver);
 }
 
 static void msp3400_cleanup_module(void)
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/media/video/saa5246a.c linux-2.6-6-rc3-mm2/drivers/media/video/saa5246a.c
--- xx-linux-2.6-6-rc3-mm2/drivers/media/video/saa5246a.c	2004-05-09 11:11:11.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/media/video/saa5246a.c	2004-05-09 14:52:53.000000000 +0200
@@ -143,9 +143,7 @@
  */
 static int saa5246a_probe(struct i2c_adapter *adap)
 {
-	if (adap->class & I2C_CLASS_TV_ANALOG)
-		return i2c_probe(adap, &addr_data, saa5246a_attach);
-	return 0;
+	return i2c_probe(adap, &addr_data, saa5246a_attach);
 }
 
 static int saa5246a_detach(struct i2c_client *client)
@@ -174,6 +172,7 @@
 	.name 		= IF_NAME,		/* name */
 	.id 		= I2C_DRIVERID_SAA5249, /* in i2c.h */
 	.flags 		= I2C_DF_NOTIFY,
+	.class		= I2C_CLASS_TV_ANALOG,
 	.attach_adapter = saa5246a_probe,
 	.detach_client  = saa5246a_detach,
 	.command 	= saa5246a_command
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/media/video/saa5249.c linux-2.6-6-rc3-mm2/drivers/media/video/saa5249.c
--- xx-linux-2.6-6-rc3-mm2/drivers/media/video/saa5249.c	2004-05-09 11:11:11.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/media/video/saa5249.c	2004-05-09 14:50:30.000000000 +0200
@@ -219,9 +219,7 @@
  
 static int saa5249_probe(struct i2c_adapter *adap)
 {
-	if (adap->class & I2C_CLASS_TV_ANALOG)
-		return i2c_probe(adap, &addr_data, saa5249_attach);
-	return 0;
+	return i2c_probe(adap, &addr_data, saa5249_attach);
 }
 
 static int saa5249_detach(struct i2c_client *client)
@@ -249,6 +247,7 @@
 	.name 		= IF_NAME,		/* name */
 	.id 		= I2C_DRIVERID_SAA5249, /* in i2c.h */
 	.flags 		= I2C_DF_NOTIFY,
+	.class		= I2C_CLASS_TV_ANALOG,
 	.attach_adapter = saa5249_probe,
 	.detach_client  = saa5249_detach,
 	.command 	= saa5249_command
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/media/video/saa7134/saa6752hs.c linux-2.6-6-rc3-mm2/drivers/media/video/saa7134/saa6752hs.c
--- xx-linux-2.6-6-rc3-mm2/drivers/media/video/saa7134/saa6752hs.c	2004-05-09 11:11:11.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/media/video/saa7134/saa6752hs.c	2004-05-09 14:47:01.000000000 +0200
@@ -335,9 +335,7 @@
 
 static int saa6752hs_probe(struct i2c_adapter *adap)
 {
-	if (adap->class & I2C_CLASS_TV_ANALOG)
-		return i2c_probe(adap, &addr_data, saa6752hs_attach);
-	return 0;
+	return i2c_probe(adap, &addr_data, saa6752hs_attach);
 }
 
 static int saa6752hs_detach(struct i2c_client *client)
@@ -376,6 +373,7 @@
         .name           = "i2c saa6752hs MPEG encoder",
         .id             = I2C_DRIVERID_SAA6752HS,
         .flags          = I2C_DF_NOTIFY,
+	.class		= I2C_CLASS_TV_ANALOG,
         .attach_adapter = saa6752hs_probe,
         .detach_client  = saa6752hs_detach,
         .command        = saa6752hs_command,
@@ -390,8 +388,7 @@
 
 static int saa6752hs_init_module(void)
 {
-	i2c_add_driver(&driver);
-	return 0;
+	return i2c_add_driver(&driver);
 }
 
 static void saa6752hs_cleanup_module(void)
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/media/video/tda7432.c linux-2.6-6-rc3-mm2/drivers/media/video/tda7432.c
--- xx-linux-2.6-6-rc3-mm2/drivers/media/video/tda7432.c	2004-05-09 11:11:11.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/media/video/tda7432.c	2004-05-09 14:49:17.000000000 +0200
@@ -338,14 +338,7 @@
 
 static int tda7432_probe(struct i2c_adapter *adap)
 {
-#ifdef I2C_CLASS_TV_ANALOG
-	if (adap->class & I2C_CLASS_TV_ANALOG)
-		return i2c_probe(adap, &addr_data, tda7432_attach);
-#else
-	if (adap->id == (I2C_ALGO_BIT | I2C_HW_B_BT848))
-		return i2c_probe(adap, &addr_data, tda7432_attach);
-#endif
-	return 0;
+	return i2c_probe(adap, &addr_data, tda7432_attach);
 }
 
 static int tda7432_detach(struct i2c_client *client)
@@ -520,6 +513,7 @@
         .name            = "i2c tda7432 driver",
 	.id              = I2C_DRIVERID_TDA7432,
         .flags           = I2C_DF_NOTIFY,
+	.class		 = I2C_CLASS_TV_ANALOG,
 	.attach_adapter  = tda7432_probe,
         .detach_client   = tda7432_detach,
         .command         = tda7432_command,
@@ -538,8 +532,7 @@
 		printk(KERN_ERR "tda7432: loudness parameter must be between 0 and 15\n");
 		return -EINVAL;
 	}
-	i2c_add_driver(&driver);
-	return 0;
+	return i2c_add_driver(&driver);
 }
 
 static void tda7432_fini(void)
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/media/video/tda9875.c linux-2.6-6-rc3-mm2/drivers/media/video/tda9875.c
--- xx-linux-2.6-6-rc3-mm2/drivers/media/video/tda9875.c	2004-05-09 11:11:11.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/media/video/tda9875.c	2004-05-09 14:48:00.000000000 +0200
@@ -272,14 +272,7 @@
 
 static int tda9875_probe(struct i2c_adapter *adap)
 {
-#ifdef I2C_CLASS_TV_ANALOG
-	if (adap->class & I2C_CLASS_TV_ANALOG)
-		return i2c_probe(adap, &addr_data, tda9875_attach);
-#else
-	if (adap->id == (I2C_ALGO_BIT | I2C_HW_B_BT848))
-		return i2c_probe(adap, &addr_data, tda9875_attach);
-#endif
-	return 0;
+	return i2c_probe(adap, &addr_data, tda9875_attach);
 }
 
 static int tda9875_detach(struct i2c_client *client)
@@ -391,6 +384,7 @@
         .name           = "i2c tda9875 driver",
         .id             = I2C_DRIVERID_TDA9875,
         .flags          = I2C_DF_NOTIFY,
+	.class		= I2C_CLASS_TV_ANALOG,
 	.attach_adapter = tda9875_probe,
         .detach_client  = tda9875_detach,
         .command        = tda9875_command,
@@ -405,8 +399,7 @@
 
 static int tda9875_init(void)
 {
-	i2c_add_driver(&driver);
-	return 0;
+	return i2c_add_driver(&driver);
 }
 
 static void tda9875_fini(void)
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/media/video/tda9887.c linux-2.6-6-rc3-mm2/drivers/media/video/tda9887.c
--- xx-linux-2.6-6-rc3-mm2/drivers/media/video/tda9887.c	2004-05-09 11:11:11.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/media/video/tda9887.c	2004-05-09 14:46:31.000000000 +0200
@@ -370,19 +370,7 @@
 
 static int tda9887_probe(struct i2c_adapter *adap)
 {
-#ifdef I2C_CLASS_TV_ANALOG
-	if (adap->class & I2C_CLASS_TV_ANALOG)
-		return i2c_probe(adap, &addr_data, tda9887_attach);
-#else
-	switch (adap->id) {
-	case I2C_ALGO_BIT | I2C_HW_B_BT848:
-	case I2C_ALGO_BIT | I2C_HW_B_RIVA:
-	case I2C_ALGO_SAA7134:
-		return i2c_probe(adap, &addr_data, tda9887_attach);
-		break;
-	}
-#endif
-	return 0;
+	return i2c_probe(adap, &addr_data, tda9887_attach);
 }
 
 static int tda9887_detach(struct i2c_client *client)
@@ -447,6 +435,7 @@
         .name           = "i2c tda9887 driver",
         .id             = -1, /* FIXME */
         .flags          = I2C_DF_NOTIFY,
+	.class		= I2C_CLASS_TV_ANALOG,
         .attach_adapter = tda9887_probe,
         .detach_client  = tda9887_detach,
         .command        = tda9887_command,
@@ -460,8 +449,7 @@
 
 static int tda9887_init_module(void)
 {
-	i2c_add_driver(&driver);
-	return 0;
+	return i2c_add_driver(&driver);
 }
 
 static void tda9887_cleanup_module(void)
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/media/video/tuner.c linux-2.6-6-rc3-mm2/drivers/media/video/tuner.c
--- xx-linux-2.6-6-rc3-mm2/drivers/media/video/tuner.c	2004-05-09 11:11:11.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/media/video/tuner.c	2004-05-09 14:51:10.000000000 +0200
@@ -1067,21 +1067,7 @@
 	}
 	this_adap = 0;
 
-#ifdef I2C_CLASS_TV_ANALOG
-	if (adap->class & I2C_CLASS_TV_ANALOG)
-		return i2c_probe(adap, &addr_data, tuner_attach);
-#else
-	switch (adap->id) {
-	case I2C_ALGO_BIT | I2C_HW_SMBUS_VOODOO3:
-	case I2C_ALGO_BIT | I2C_HW_B_BT848:
-	case I2C_ALGO_BIT | I2C_HW_B_RIVA:
-	case I2C_ALGO_SAA7134:
-	case I2C_ALGO_SAA7146:
-		return i2c_probe(adap, &addr_data, tuner_attach);
-		break;
-	}
-#endif
-	return 0;
+	return i2c_probe(adap, &addr_data, tuner_attach);
 }
 
 static int tuner_detach(struct i2c_client *client)
@@ -1184,6 +1170,7 @@
         .name           = "i2c TV tuner driver",
         .id             = I2C_DRIVERID_TUNER,
         .flags          = I2C_DF_NOTIFY,
+	.class		= I2C_CLASS_TV_ANALOG,
         .attach_adapter = tuner_probe,
         .detach_client  = tuner_detach,
         .command        = tuner_command,
@@ -1197,8 +1184,7 @@
 
 static int tuner_init_module(void)
 {
-	i2c_add_driver(&driver);
-	return 0;
+	return i2c_add_driver(&driver);
 }
 
 static void tuner_cleanup_module(void)
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/media/video/tvaudio.c linux-2.6-6-rc3-mm2/drivers/media/video/tvaudio.c
--- xx-linux-2.6-6-rc3-mm2/drivers/media/video/tvaudio.c	2004-05-09 11:11:11.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/media/video/tvaudio.c	2004-05-09 14:47:38.000000000 +0200
@@ -1497,18 +1497,7 @@
 
 static int chip_probe(struct i2c_adapter *adap)
 {
-#ifdef I2C_CLASS_TV_ANALOG
-	if (adap->class & I2C_CLASS_TV_ANALOG)
-		return i2c_probe(adap, &addr_data, chip_attach);
-#else
-	switch (adap->id) {
-	case I2C_ALGO_BIT | I2C_HW_B_BT848:
-	case I2C_ALGO_BIT | I2C_HW_B_RIVA:
-	case I2C_ALGO_SAA7134:
-		return i2c_probe(adap, &addr_data, chip_attach);
-	}
-#endif
-	return 0;
+	return i2c_probe(adap, &addr_data, chip_attach);
 }
 
 static int chip_detach(struct i2c_client *client)
@@ -1639,6 +1628,7 @@
         .name            = "generic i2c audio driver",
         .id              = I2C_DRIVERID_TVAUDIO,
         .flags           = I2C_DF_NOTIFY,
+	.class		 = I2C_CLASS_TV_ANALOG,
         .attach_adapter  = chip_probe,
         .detach_client   = chip_detach,
         .command         = chip_command,
@@ -1659,8 +1649,7 @@
 	for (desc = chiplist; desc->name != NULL; desc++)
 		printk("%s%s", (desc == chiplist) ? "" : ",",desc->name);
 	printk("\n");
-	i2c_add_driver(&driver);
-	return 0;
+	return i2c_add_driver(&driver);
 }
 
 static void audiochip_cleanup_module(void)
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/media/video/tvmixer.c linux-2.6-6-rc3-mm2/drivers/media/video/tvmixer.c
--- xx-linux-2.6-6-rc3-mm2/drivers/media/video/tvmixer.c	2004-05-09 11:11:11.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/media/video/tvmixer.c	2004-05-09 14:52:10.000000000 +0200
@@ -232,6 +232,7 @@
 	.flags           = I2C_DF_NOTIFY,
         .detach_adapter  = tvmixer_adapters,
 #endif
+	.class		 = I2C_CLASS_TV_ANALOG,
         .attach_adapter  = tvmixer_adapters,
         .detach_client   = tvmixer_clients,
 };
@@ -263,23 +264,6 @@
 	struct video_audio va;
 	int i,minor;
 
-#ifdef I2C_CLASS_TV_ANALOG
-	if (!(client->adapter->class & I2C_CLASS_TV_ANALOG))
-		return -1;
-#else
-	/* TV card ??? */
-	switch (client->adapter->id) {
-	case I2C_ALGO_BIT | I2C_HW_SMBUS_VOODOO3:
-	case I2C_ALGO_BIT | I2C_HW_B_BT848:
-	case I2C_ALGO_BIT | I2C_HW_B_RIVA:
-		/* ok, have a look ... */
-		break;
-	default:
-		/* ignore that one */
-		return -1;
-	}
-#endif
-
 	/* unregister ?? */
 	for (i = 0; i < DEV_MAX; i++) {
 		if (devices[i].dev == client) {
@@ -334,8 +318,7 @@
 	
 	for (i = 0; i < DEV_MAX; i++)
 		devices[i].minor = -1;
-	i2c_add_driver(&driver);
-	return 0;
+	return i2c_add_driver(&driver);
 }
 
 static void tvmixer_cleanup_module(void)

--------------020504000006060008090307
Content-Type: text/plain;
 name="03-drivers-i2c-chips.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="03-drivers-i2c-chips.diff"

diff -ura xx-linux-2.6-6-rc3-mm2/drivers/i2c/chips/adm1021.c linux-2.6-6-rc3-mm2/drivers/i2c/chips/adm1021.c
--- xx-linux-2.6-6-rc3-mm2/drivers/i2c/chips/adm1021.c	2004-05-09 11:11:10.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/i2c/chips/adm1021.c	2004-05-09 16:17:00.000000000 +0200
@@ -144,6 +144,7 @@
 	.name		= "adm1021",
 	.id		= I2C_DRIVERID_ADM1021,
 	.flags		= I2C_DF_NOTIFY,
+	.class		= I2C_CLASS_HWMON,
 	.attach_adapter	= adm1021_attach_adapter,
 	.detach_client	= adm1021_detach_client,
 };
@@ -200,8 +201,6 @@
 
 static int adm1021_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
 	return i2c_detect(adapter, &addr_data, adm1021_detect);
 }
 
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/i2c/chips/asb100.c linux-2.6-6-rc3-mm2/drivers/i2c/chips/asb100.c
--- xx-linux-2.6-6-rc3-mm2/drivers/i2c/chips/asb100.c	2004-05-09 11:11:10.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/i2c/chips/asb100.c	2004-05-09 16:13:42.000000000 +0200
@@ -233,6 +233,7 @@
 	.name		= "asb100",
 	.id		= I2C_DRIVERID_ASB100,
 	.flags		= I2C_DF_NOTIFY,
+	.class		= I2C_CLASS_HWMON,
 	.attach_adapter	= asb100_attach_adapter,
 	.detach_client	= asb100_detach_client,
 };
@@ -609,8 +610,6 @@
  */
 static int asb100_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
 	return i2c_detect(adapter, &addr_data, asb100_detect);
 }
 
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/i2c/chips/ds1621.c linux-2.6-6-rc3-mm2/drivers/i2c/chips/ds1621.c
--- xx-linux-2.6-6-rc3-mm2/drivers/i2c/chips/ds1621.c	2004-05-09 11:05:29.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/i2c/chips/ds1621.c	2004-05-09 16:11:42.000000000 +0200
@@ -92,6 +92,7 @@
 	.name		= "ds1621",
 	.id		= I2C_DRIVERID_DS1621,
 	.flags		= I2C_DF_NOTIFY,
+	.class		= I2C_CLASS_HWMON,
 	.attach_adapter	= ds1621_attach_adapter,
 	.detach_client	= ds1621_detach_client,
 };
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/i2c/chips/eeprom.c linux-2.6-6-rc3-mm2/drivers/i2c/chips/eeprom.c
--- xx-linux-2.6-6-rc3-mm2/drivers/i2c/chips/eeprom.c	2004-05-09 11:05:29.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/i2c/chips/eeprom.c	2004-05-09 16:11:59.000000000 +0200
@@ -82,6 +82,7 @@
 	.name		= "eeprom",
 	.id		= I2C_DRIVERID_EEPROM,
 	.flags		= I2C_DF_NOTIFY,
+	.class		= I2C_CLASS_HWMON,
 	.attach_adapter	= eeprom_attach_adapter,
 	.detach_client	= eeprom_detach_client,
 };
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/i2c/chips/fscher.c linux-2.6-6-rc3-mm2/drivers/i2c/chips/fscher.c
--- xx-linux-2.6-6-rc3-mm2/drivers/i2c/chips/fscher.c	2004-05-09 11:11:10.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/i2c/chips/fscher.c	2004-05-09 16:13:00.000000000 +0200
@@ -124,6 +124,7 @@
 	.name		= "fscher",
 	.id		= I2C_DRIVERID_FSCHER,
 	.flags		= I2C_DF_NOTIFY,
+	.class		= I2C_CLASS_HWMON,
 	.attach_adapter	= fscher_attach_adapter,
 	.detach_client	= fscher_detach_client,
 };
@@ -293,8 +294,6 @@
 
 static int fscher_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
 	return i2c_detect(adapter, &addr_data, fscher_detect);
 }
 
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/i2c/chips/gl518sm.c linux-2.6-6-rc3-mm2/drivers/i2c/chips/gl518sm.c
--- xx-linux-2.6-6-rc3-mm2/drivers/i2c/chips/gl518sm.c	2004-05-09 11:11:10.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/i2c/chips/gl518sm.c	2004-05-09 16:12:21.000000000 +0200
@@ -156,6 +156,7 @@
 	.name		= "gl518sm",
 	.id		= I2C_DRIVERID_GL518,
 	.flags		= I2C_DF_NOTIFY,
+	.class		= I2C_CLASS_HWMON,
 	.attach_adapter	= gl518_attach_adapter,
 	.detach_client	= gl518_detach_client,
 };
@@ -335,8 +336,6 @@
 
 static int gl518_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
 	return i2c_detect(adapter, &addr_data, gl518_detect);
 }
 
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/i2c/chips/it87.c linux-2.6-6-rc3-mm2/drivers/i2c/chips/it87.c
--- xx-linux-2.6-6-rc3-mm2/drivers/i2c/chips/it87.c	2004-05-09 11:11:10.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/i2c/chips/it87.c	2004-05-09 16:16:14.000000000 +0200
@@ -173,6 +173,7 @@
 	.name		= "it87",
 	.id		= I2C_DRIVERID_IT87,
 	.flags		= I2C_DF_NOTIFY,
+	.class		= I2C_CLASS_HWMON,
 	.attach_adapter	= it87_attach_adapter,
 	.detach_client	= it87_detach_client,
 };
@@ -500,8 +501,6 @@
      * when a new adapter is inserted (and it87_driver is still present) */
 static int it87_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
 	return i2c_detect(adapter, &addr_data, it87_detect);
 }
 
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/i2c/chips/lm78.c linux-2.6-6-rc3-mm2/drivers/i2c/chips/lm78.c
--- xx-linux-2.6-6-rc3-mm2/drivers/i2c/chips/lm78.c	2004-05-09 11:11:10.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/i2c/chips/lm78.c	2004-05-09 16:15:57.000000000 +0200
@@ -229,6 +229,7 @@
 	.name		= "lm78",
 	.id		= I2C_DRIVERID_LM78,
 	.flags		= I2C_DF_NOTIFY,
+	.class		= I2C_CLASS_HWMON,
 	.attach_adapter	= lm78_attach_adapter,
 	.detach_client	= lm78_detach_client,
 };
@@ -488,8 +489,6 @@
      * when a new adapter is inserted (and lm78_driver is still present) */
 static int lm78_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
 	return i2c_detect(adapter, &addr_data, lm78_detect);
 }
 
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/i2c/chips/lm80.c linux-2.6-6-rc3-mm2/drivers/i2c/chips/lm80.c
--- xx-linux-2.6-6-rc3-mm2/drivers/i2c/chips/lm80.c	2004-05-09 11:11:10.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/i2c/chips/lm80.c	2004-05-09 16:15:28.000000000 +0200
@@ -156,6 +156,7 @@
 	.name		= "lm80",
 	.id		= I2C_DRIVERID_LM80,
 	.flags		= I2C_DF_NOTIFY,
+	.class		= I2C_CLASS_HWMON,
 	.attach_adapter	= lm80_attach_adapter,
 	.detach_client	= lm80_detach_client,
 };
@@ -376,8 +377,6 @@
 
 static int lm80_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
 	return i2c_detect(adapter, &addr_data, lm80_detect);
 }
 
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/i2c/chips/lm83.c linux-2.6-6-rc3-mm2/drivers/i2c/chips/lm83.c
--- xx-linux-2.6-6-rc3-mm2/drivers/i2c/chips/lm83.c	2004-05-09 11:11:10.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/i2c/chips/lm83.c	2004-05-09 16:15:08.000000000 +0200
@@ -125,6 +125,7 @@
 	.name		= "lm83",
 	.id		= I2C_DRIVERID_LM83,
 	.flags		= I2C_DF_NOTIFY,
+	.class		= I2C_CLASS_HWMON,
 	.attach_adapter	= lm83_attach_adapter,
 	.detach_client	= lm83_detach_client,
 };
@@ -216,8 +217,6 @@
 
 static int lm83_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
 	return i2c_detect(adapter, &addr_data, lm83_detect);
 }
 
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/i2c/chips/lm85.c linux-2.6-6-rc3-mm2/drivers/i2c/chips/lm85.c
--- xx-linux-2.6-6-rc3-mm2/drivers/i2c/chips/lm85.c	2004-05-09 11:05:29.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/i2c/chips/lm85.c	2004-05-09 16:14:53.000000000 +0200
@@ -403,6 +403,7 @@
 	.name           = "lm85",
 	.id             = I2C_DRIVERID_LM85,
 	.flags          = I2C_DF_NOTIFY,
+	.class		= I2C_CLASS_HWMON,
 	.attach_adapter = lm85_attach_adapter,
 	.detach_client  = lm85_detach_client,
 };
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/i2c/chips/lm90.c linux-2.6-6-rc3-mm2/drivers/i2c/chips/lm90.c
--- xx-linux-2.6-6-rc3-mm2/drivers/i2c/chips/lm90.c	2004-05-09 11:11:10.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/i2c/chips/lm90.c	2004-05-09 16:14:33.000000000 +0200
@@ -146,6 +146,7 @@
 	.name		= "lm90",
 	.id		= I2C_DRIVERID_LM90,
 	.flags		= I2C_DF_NOTIFY,
+	.class		= I2C_CLASS_HWMON,
 	.attach_adapter	= lm90_attach_adapter,
 	.detach_client	= lm90_detach_client,
 };
@@ -274,8 +275,6 @@
 
 static int lm90_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
 	return i2c_detect(adapter, &addr_data, lm90_detect);
 }
 
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/i2c/chips/pcf8574.c linux-2.6-6-rc3-mm2/drivers/i2c/chips/pcf8574.c
--- xx-linux-2.6-6-rc3-mm2/drivers/i2c/chips/pcf8574.c	2004-05-09 11:05:29.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/i2c/chips/pcf8574.c	2004-05-09 16:10:36.000000000 +0200
@@ -73,6 +73,7 @@
 	.name		= "pcf8574",
 	.id		= I2C_DRIVERID_PCF8574,
 	.flags		= I2C_DF_NOTIFY,
+	.class		= I2C_CLASS_HWMON,
 	.attach_adapter	= pcf8574_attach_adapter,
 	.detach_client	= pcf8574_detach_client,
 };
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/i2c/chips/pcf8591.c linux-2.6-6-rc3-mm2/drivers/i2c/chips/pcf8591.c
--- xx-linux-2.6-6-rc3-mm2/drivers/i2c/chips/pcf8591.c	2004-05-09 11:05:29.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/i2c/chips/pcf8591.c	2004-05-09 16:10:09.000000000 +0200
@@ -95,6 +95,7 @@
 	.name		= "pcf8591",
 	.id		= I2C_DRIVERID_PCF8591,
 	.flags		= I2C_DF_NOTIFY,
+	.class		= I2C_CLASS_HWMON,
 	.attach_adapter	= pcf8591_attach_adapter,
 	.detach_client	= pcf8591_detach_client,
 };
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/i2c/chips/via686a.c linux-2.6-6-rc3-mm2/drivers/i2c/chips/via686a.c
--- xx-linux-2.6-6-rc3-mm2/drivers/i2c/chips/via686a.c	2004-05-09 11:11:10.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/i2c/chips/via686a.c	2004-05-09 16:16:46.000000000 +0200
@@ -586,6 +586,7 @@
 	.name		= "via686a",
 	.id		= I2C_DRIVERID_VIA686A,
 	.flags		= I2C_DF_NOTIFY,
+	.class		= I2C_CLASS_HWMON,
 	.attach_adapter	= via686a_attach_adapter,
 	.detach_client	= via686a_detach_client,
 };
@@ -594,8 +595,6 @@
 /* This is called when the module is loaded */
 static int via686a_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
 	return i2c_detect(adapter, &addr_data, via686a_detect);
 }
 
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/i2c/chips/w83627hf.c linux-2.6-6-rc3-mm2/drivers/i2c/chips/w83627hf.c
--- xx-linux-2.6-6-rc3-mm2/drivers/i2c/chips/w83627hf.c	2004-05-09 11:05:29.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/i2c/chips/w83627hf.c	2004-05-09 16:11:27.000000000 +0200
@@ -331,6 +331,7 @@
 	.name		= "w83627hf",
 	.id		= I2C_DRIVERID_W83627HF,
 	.flags		= I2C_DF_NOTIFY,
+	.class		= I2C_CLASS_HWMON,
 	.attach_adapter	= w83627hf_attach_adapter,
 	.detach_client	= w83627hf_detach_client,
 };
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/i2c/chips/w83781d.c linux-2.6-6-rc3-mm2/drivers/i2c/chips/w83781d.c
--- xx-linux-2.6-6-rc3-mm2/drivers/i2c/chips/w83781d.c	2004-05-09 11:11:10.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/i2c/chips/w83781d.c	2004-05-09 16:17:18.000000000 +0200
@@ -281,6 +281,7 @@
 	.name = "w83781d",
 	.id = I2C_DRIVERID_W83781D,
 	.flags = I2C_DF_NOTIFY,
+	.class = I2C_CLASS_HWMON,
 	.attach_adapter = w83781d_attach_adapter,
 	.detach_client = w83781d_detach_client,
 };
@@ -905,8 +906,6 @@
 static int
 w83781d_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
 	return i2c_detect(adapter, &addr_data, w83781d_detect);
 }
 
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/i2c/chips/w83l785ts.c linux-2.6-6-rc3-mm2/drivers/i2c/chips/w83l785ts.c
--- xx-linux-2.6-6-rc3-mm2/drivers/i2c/chips/w83l785ts.c	2004-05-09 11:11:10.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/i2c/chips/w83l785ts.c	2004-05-09 16:13:22.000000000 +0200
@@ -96,6 +96,7 @@
 	.name		= "w83l785ts",
 	.id		= I2C_DRIVERID_W83L785TS,
 	.flags		= I2C_DF_NOTIFY,
+	.class		= I2C_CLASS_HWMON,
 	.attach_adapter	= w83l785ts_attach_adapter,
 	.detach_client	= w83l785ts_detach_client,
 };
@@ -145,8 +146,6 @@
 
 static int w83l785ts_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
 	return i2c_detect(adapter, &addr_data, w83l785ts_detect);
 }
 
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/i2c/i2c-dev.c linux-2.6-6-rc3-mm2/drivers/i2c/i2c-dev.c
--- xx-linux-2.6-6-rc3-mm2/drivers/i2c/i2c-dev.c	2004-05-09 11:05:29.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/i2c/i2c-dev.c	2004-05-09 16:06:33.000000000 +0200
@@ -500,6 +500,7 @@
 	.name		= "dev_driver",
 	.id		= I2C_DRIVERID_I2CDEV,
 	.flags		= I2C_DF_NOTIFY,
+	.class		= I2C_CLASS_ALL,
 	.attach_adapter	= i2cdev_attach_adapter,
 	.detach_adapter	= i2cdev_detach_adapter,
 	.detach_client	= i2cdev_detach_client,

--------------020504000006060008090307
Content-Type: text/plain;
 name="04-misc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="04-misc.diff"

diff -ura xx-linux-2.6-6-rc3-mm2/drivers/acorn/char/i2c.c linux-2.6-6-rc3-mm2/drivers/acorn/char/i2c.c
--- xx-linux-2.6-6-rc3-mm2/drivers/acorn/char/i2c.c	2004-05-09 11:03:40.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/acorn/char/i2c.c	2004-05-09 16:31:58.000000000 +0200
@@ -345,6 +345,7 @@
 static struct i2c_adapter ioc_ops = {
 	.id			= I2C_HW_B_IOC,
 	.algo_data		= &ioc_data,
+	.class			= I2C_CLASS_ALL,
 	.client_register	= ioc_client_reg,
 	.client_unregister	= ioc_client_unreg,
 };
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/acorn/char/pcf8583.c linux-2.6-6-rc3-mm2/drivers/acorn/char/pcf8583.c
--- xx-linux-2.6-6-rc3-mm2/drivers/acorn/char/pcf8583.c	2004-05-09 11:03:40.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/acorn/char/pcf8583.c	2004-05-09 16:33:20.000000000 +0200
@@ -227,6 +227,7 @@
 	.name		= "PCF8583",
 	.id		= I2C_DRIVERID_PCF8583,
 	.flags		= I2C_DF_NOTIFY,
+	.class		= I2C_CLASS_ALL, /* fixme: add another I2C_CLASS_xxx entry for Acorn? */
 	.attach_adapter	= pcf8583_probe,
 	.detach_client	= pcf8583_detach,
 	.command	= pcf8583_command
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/i2c/busses/i2c-keywest.c linux-2.6-6-rc3-mm2/drivers/i2c/busses/i2c-keywest.c
--- xx-linux-2.6-6-rc3-mm2/drivers/i2c/busses/i2c-keywest.c	2004-05-09 11:03:02.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/i2c/busses/i2c-keywest.c	2004-05-09 16:37:41.000000000 +0200
@@ -619,6 +619,7 @@
 		chan->iface = iface;
 		chan->chan_no = i;
 		chan->adapter.id = I2C_ALGO_SMBUS;
+		chan->adapter.class = I2C_CLASS_HWMON | I2C_CLASS_SOUND;
 		chan->adapter.algo = &keywest_algorithm;
 		chan->adapter.algo_data = NULL;
 		chan->adapter.client_register = NULL;
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/ieee1394/pcilynx.c linux-2.6-6-rc3-mm2/drivers/ieee1394/pcilynx.c
--- xx-linux-2.6-6-rc3-mm2/drivers/ieee1394/pcilynx.c	2004-05-09 11:05:30.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/ieee1394/pcilynx.c	2004-05-09 16:42:30.000000000 +0200
@@ -1799,6 +1799,7 @@
                 i2c_adapter = bit_ops;
                 i2c_adapter_data = bit_data;
                 i2c_adapter.algo_data = &i2c_adapter_data;
+		i2c_adapter.class = I2C_CLASS_NONE;
                 i2c_adapter_data.data = lynx;
 
 		PRINTD(KERN_DEBUG, lynx->id,"original eeprom control: %d",
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/macintosh/therm_adt746x.c linux-2.6-6-rc3-mm2/drivers/macintosh/therm_adt746x.c
--- xx-linux-2.6-6-rc3-mm2/drivers/macintosh/therm_adt746x.c	2004-05-09 11:03:40.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/macintosh/therm_adt746x.c	2004-05-09 16:30:02.000000000 +0200
@@ -164,6 +164,7 @@
 	.name		="Apple Thermostat ADT746x",
 	.id		=0xDEAD7467,
 	.flags		=I2C_DF_NOTIFY,
+	.class		=I2C_CLASS_HWMON,
 	.attach_adapter	=&attach_thermostat,
 	.detach_adapter	=&detach_thermostat,
 };
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/macintosh/therm_pm72.c linux-2.6-6-rc3-mm2/drivers/macintosh/therm_pm72.c
--- xx-linux-2.6-6-rc3-mm2/drivers/macintosh/therm_pm72.c	2004-05-09 11:03:40.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/macintosh/therm_pm72.c	2004-05-09 16:29:32.000000000 +0200
@@ -142,6 +142,7 @@
 	.name		= "therm_pm72",
 	.id		= 0xDEADBEEF,
 	.flags		= I2C_DF_NOTIFY,
+	.class		= I2C_CLASS_HWMON,
 	.attach_adapter	= therm_pm72_attach,
 	.detach_adapter	= therm_pm72_detach,
 };
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/macintosh/therm_windtunnel.c linux-2.6-6-rc3-mm2/drivers/macintosh/therm_windtunnel.c
--- xx-linux-2.6-6-rc3-mm2/drivers/macintosh/therm_windtunnel.c	2004-05-09 11:03:40.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/macintosh/therm_windtunnel.c	2004-05-09 16:29:13.000000000 +0200
@@ -357,6 +357,7 @@
 	.name		= "Apple G4 Thermostat/Fan",
 	.id		= I2C_DRIVERID_G4FAN,
 	.flags		= I2C_DF_NOTIFY,
+	.class		= I2C_CLASS_HWMON,
 	.attach_adapter = &do_attach,
 	.detach_client	= &do_detach,
 	.command	= NULL,
diff -ura xx-linux-2.6-6-rc3-mm2/include/linux/i2c.h linux-2.6-6-rc3-mm2/include/linux/i2c.h
--- xx-linux-2.6-6-rc3-mm2/include/linux/i2c.h	2004-05-09 11:11:11.000000000 +0200
+++ linux-2.6-6-rc3-mm2/include/linux/i2c.h	2004-05-09 16:42:13.000000000 +0200
@@ -285,7 +285,8 @@
 #define I2C_CLIENT_TEN	0x10			/* we have a ten bit chip address	*/
 						/* Must equal I2C_M_TEN below */
 
-/* i2c adapter classes (bitmask) */
+/* i2c classes (bitmask) */
+#define I2C_CLASS_NONE		0	/* none, don't use */
 #define I2C_CLASS_HWMON		(1<<0)	/* lm_sensors, ... */
 #define I2C_CLASS_TV_ANALOG	(1<<1)	/* bttv + friends */
 #define I2C_CLASS_TV_DIGITAL	(1<<2)	/* dvb cards */
diff -ura xx-linux-2.6-6-rc3-mm2/sound/oss/dmasound/dac3550a.c linux-2.6-6-rc3-mm2/sound/oss/dmasound/dac3550a.c
--- xx-linux-2.6-6-rc3-mm2/sound/oss/dmasound/dac3550a.c	2004-05-09 11:04:50.000000000 +0200
+++ linux-2.6-6-rc3-mm2/sound/oss/dmasound/dac3550a.c	2004-05-09 16:38:47.000000000 +0200
@@ -47,6 +47,7 @@
 	.name			= "DAC3550A driver  V " DACA_VERSION,
 	.id			= I2C_DRIVERID_DACA,
 	.flags			= I2C_DF_NOTIFY,
+	.class			= I2C_CLASS_SOUND,
 	.attach_adapter		= daca_attach_adapter,
 	.detach_client		= daca_detach_client,
 };
diff -ura xx-linux-2.6-6-rc3-mm2/sound/oss/dmasound/tas_common.c linux-2.6-6-rc3-mm2/sound/oss/dmasound/tas_common.c
--- xx-linux-2.6-6-rc3-mm2/sound/oss/dmasound/tas_common.c	2004-05-09 11:04:50.000000000 +0200
+++ linux-2.6-6-rc3-mm2/sound/oss/dmasound/tas_common.c	2004-05-09 16:39:01.000000000 +0200
@@ -50,6 +50,7 @@
 	.owner		= THIS_MODULE,
 	.name		= "tas",
 	.flags		= I2C_DF_NOTIFY,
+	.class		= I2C_CLASS_SOUND,
 	.attach_adapter	= tas_attach_adapter,
 	.detach_client	= tas_detach_client,
 };
diff -ura xx-linux-2.6-6-rc3-mm2/sound/ppc/keywest.c linux-2.6-6-rc3-mm2/sound/ppc/keywest.c
--- xx-linux-2.6-6-rc3-mm2/sound/ppc/keywest.c	2004-05-09 11:06:53.000000000 +0200
+++ linux-2.6-6-rc3-mm2/sound/ppc/keywest.c	2004-05-09 16:38:03.000000000 +0200
@@ -44,6 +44,7 @@
 	.name = "PMac Keywest Audio",
 	.id = I2C_DRIVERID_KEYWEST,
 	.flags = I2C_DF_NOTIFY,
+	.class = I2C_CLASS_SOUND,
 	.attach_adapter = &keywest_attach_adapter,
 	.detach_client = &keywest_detach_client,
 };

--------------020504000006060008090307
Content-Type: text/plain;
 name="05-unclear.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="05-unclear.diff"

diff -ura xx-linux-2.6-6-rc3-mm2/drivers/i2c/algos/i2c-algo-pcf.c linux-2.6-6-rc3-mm2/drivers/i2c/algos/i2c-algo-pcf.c
--- xx-linux-2.6-6-rc3-mm2/drivers/i2c/algos/i2c-algo-pcf.c	2004-05-09 11:03:03.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/i2c/algos/i2c-algo-pcf.c	2004-05-09 18:00:47.000000000 +0200
@@ -449,7 +449,8 @@
 
 	adap->id |= pcf_algo.id;
 	adap->algo = &pcf_algo;
-
+	adap->class = I2C_CLASS_ALL;
+	
 	adap->timeout = 100;		/* default values, should	*/
 	adap->retries = 3;		/* be replaced by defines	*/
 
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/i2c/busses/i2c-elektor.c linux-2.6-6-rc3-mm2/drivers/i2c/busses/i2c-elektor.c
--- xx-linux-2.6-6-rc3-mm2/drivers/i2c/busses/i2c-elektor.c	2004-05-09 11:03:02.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/i2c/busses/i2c-elektor.c	2004-05-09 17:57:16.000000000 +0200
@@ -171,6 +171,7 @@
 	.owner		= THIS_MODULE,
 	.id		= I2C_HW_P_ELEK,
 	.algo_data	= &pcf_isa_data,
+	.class		= I2C_CLASS_ALL,
 	.name		= "PCF8584 ISA adapter",
 };
 
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/media/dvb/bt8xx/dvb-bt8xx.c linux-2.6-6-rc3-mm2/drivers/media/dvb/bt8xx/dvb-bt8xx.c
--- xx-linux-2.6-6-rc3-mm2/drivers/media/dvb/bt8xx/dvb-bt8xx.c	2004-05-09 11:05:31.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/media/dvb/bt8xx/dvb-bt8xx.c	2004-05-09 17:38:16.000000000 +0200
@@ -261,6 +261,11 @@
 	.name            = "dvb_bt8xx",
         .id              = I2C_DRIVERID_DVB_BT878A,
 	.flags           = I2C_DF_NOTIFY,
+	/* ugly, but necessary: bt8x8 based budget dvb cards are handled by bttv on the
+	   lowest level and we fake a i2c client to get to know all bt8x8 based
+	   cards when they have been registered by bttv.
+	   we do a check for adap->id in order to find the right cards */
+	.class		 = I2C_CLASS_ALL,
         .attach_adapter  = dvb_bt8xx_attach,
         .detach_adapter  = dvb_bt8xx_detach,
 };
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/media/video/ir-kbd-i2c.c linux-2.6-6-rc3-mm2/drivers/media/video/ir-kbd-i2c.c
--- xx-linux-2.6-6-rc3-mm2/drivers/media/video/ir-kbd-i2c.c	2004-05-09 11:05:31.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/media/video/ir-kbd-i2c.c	2004-05-09 17:39:18.000000000 +0200
@@ -247,6 +247,7 @@
         .name           = "ir remote kbd driver",
         .id             = I2C_DRIVERID_EXP3, /* FIXME */
         .flags          = I2C_DF_NOTIFY,
+	.class		= I2C_CLASS_TV_ANALOG | I2C_CLASS_TV_DIGITAL;
         .attach_adapter = ir_probe,
         .detach_client  = ir_detach,
 };
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/media/video/zoran_card.c linux-2.6-6-rc3-mm2/drivers/media/video/zoran_card.c
--- xx-linux-2.6-6-rc3-mm2/drivers/media/video/zoran_card.c	2004-05-09 11:03:03.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/media/video/zoran_card.c	2004-05-09 17:40:38.000000000 +0200
@@ -740,6 +740,7 @@
 	I2C_DEVNAME("zr36057"),
 	.id = I2C_HW_B_ZR36067,
 	.algo = NULL,
+	.class = I2C_CLASS_TV_ANALOG,
 	.client_register = zoran_i2c_client_register,
 	.client_unregister = zoran_i2c_client_unregister,
 };
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/video/aty/radeon_i2c.c linux-2.6-6-rc3-mm2/drivers/video/aty/radeon_i2c.c
--- xx-linux-2.6-6-rc3-mm2/drivers/video/aty/radeon_i2c.c	2004-05-09 11:03:09.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/video/aty/radeon_i2c.c	2004-05-09 17:55:49.000000000 +0200
@@ -78,6 +78,7 @@
 	chan->adapter.id		= I2C_ALGO_ATI;
 	chan->adapter.algo_data		= &chan->algo;
 	chan->adapter.dev.parent	= &chan->rinfo->pdev->dev;
+	chan->adapter.class		= I2C_CLASS_NONE;
 	chan->algo.setsda		= radeon_gpio_setsda;
 	chan->algo.setscl		= radeon_gpio_setscl;
 	chan->algo.getsda		= radeon_gpio_getsda;
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/video/matrox/i2c-matroxfb.c linux-2.6-6-rc3-mm2/drivers/video/matrox/i2c-matroxfb.c
--- xx-linux-2.6-6-rc3-mm2/drivers/video/matrox/i2c-matroxfb.c	2004-05-09 11:03:09.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/video/matrox/i2c-matroxfb.c	2004-05-09 17:50:36.000000000 +0200
@@ -104,13 +104,14 @@
 };
 
 static int i2c_bus_reg(struct i2c_bit_adapter* b, struct matrox_fb_info* minfo, 
-		unsigned int data, unsigned int clock, const char* name) {
+		unsigned int data, unsigned int clock, const char* name, unsigned int class) {
 	int err;
 
 	b->minfo = minfo;
 	b->mask.data = data;
 	b->mask.clock = clock;
 	b->adapter = matrox_i2c_adapter_template;
+	b->class = class;
 	snprintf(b->adapter.name, I2C_NAME_SIZE, name,
 		minfo->fbcon.node);
 	i2c_set_adapdata(&b->adapter, b);
@@ -160,22 +161,22 @@
 	switch (ACCESS_FBINFO(chip)) {
 		case MGA_2064:
 		case MGA_2164:
-			err = i2c_bus_reg(&m2info->ddc1, minfo, DDC1B_DATA, DDC1B_CLK, "DDC:fb%u #0");
+			err = i2c_bus_reg(&m2info->ddc1, minfo, DDC1B_DATA, DDC1B_CLK, "DDC:fb%u #0", I2C_CLASS_DDC);
 			break;
 		default:
-			err = i2c_bus_reg(&m2info->ddc1, minfo, DDC1_DATA, DDC1_CLK, "DDC:fb%u #0");
+			err = i2c_bus_reg(&m2info->ddc1, minfo, DDC1_DATA, DDC1_CLK, "DDC:fb%u #0", I2C_CLASS_DDC);
 			break;
 	}
 	if (err)
 		goto fail_ddc1;
 	if (ACCESS_FBINFO(devflags.dualhead)) {
-		err = i2c_bus_reg(&m2info->ddc2, minfo, DDC2_DATA, DDC2_CLK, "DDC:fb%u #1");
+		err = i2c_bus_reg(&m2info->ddc2, minfo, DDC2_DATA, DDC2_CLK, "DDC:fb%u #1", I2C_CLASS_DDC);
 		if (err == -ENODEV) {
 			printk(KERN_INFO "i2c-matroxfb: VGA->TV plug detected, DDC unavailable.\n");
 		} else if (err)
 			printk(KERN_INFO "i2c-matroxfb: Could not register secondary output i2c bus. Continuing anyway.\n");
 		/* Register maven bus even on G450/G550 */
-		err = i2c_bus_reg(&m2info->maven, minfo, MAT_DATA, MAT_CLK, "MAVEN:fb%u");
+		err = i2c_bus_reg(&m2info->maven, minfo, MAT_DATA, MAT_CLK, "MAVEN:fb%u", I2C_CLASS_TV_ANALOG);
 		if (err)
 			printk(KERN_INFO "i2c-matroxfb: Could not register Maven i2c bus. Continuing anyway.\n");
 	}
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/video/matrox/matroxfb_maven.c linux-2.6-6-rc3-mm2/drivers/video/matrox/matroxfb_maven.c
--- xx-linux-2.6-6-rc3-mm2/drivers/video/matrox/matroxfb_maven.c	2004-05-09 11:03:09.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/video/matrox/matroxfb_maven.c	2004-05-09 17:46:07.000000000 +0200
@@ -1297,6 +1297,7 @@
 	.name		= "maven",
 	.id		= I2C_DRIVERID_MGATVO,
 	.flags		= I2C_DF_NOTIFY,
+	.class		= I2C_CLASS_TV_ANALOG,
 	.attach_adapter	= maven_attach_adapter,
 	.detach_client	= maven_detach_client,
 	.command	= maven_command,

--------------020504000006060008090307
Content-Type: text/plain;
 name="06-class-all.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="06-class-all.diff"

diff -ura xx-linux-2.6-6-rc3-mm2/drivers/i2c/busses/i2c-ibm_iic.c linux-2.6-6-rc3-mm2/drivers/i2c/busses/i2c-ibm_iic.c
--- xx-linux-2.6-6-rc3-mm2/drivers/i2c/busses/i2c-ibm_iic.c	2004-05-09 11:03:03.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/i2c/busses/i2c-ibm_iic.c	2004-05-09 18:19:44.000000000 +0200
@@ -607,6 +607,7 @@
 	i2c_set_adapdata(adap, dev);
 	adap->id = I2C_HW_OCP | iic_algo.id;
 	adap->algo = &iic_algo;
+	adap->class = I2C_CLASS_ALL;
 	adap->client_register = NULL;
 	adap->client_unregister = NULL;
 	adap->timeout = 1;
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/i2c/busses/i2c-iop3xx.c linux-2.6-6-rc3-mm2/drivers/i2c/busses/i2c-iop3xx.c
--- xx-linux-2.6-6-rc3-mm2/drivers/i2c/busses/i2c-iop3xx.c	2004-05-09 11:03:02.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/i2c/busses/i2c-iop3xx.c	2004-05-09 18:17:57.000000000 +0200
@@ -507,18 +507,31 @@
 	.name			= ADAPTER_NAME_ROOT "0",
 	.id			= I2C_HW_IOP321,
 	.algo_data		= &algo_iop3xx_data0,
+	.class			= I2C_CLASS_ALL,
 };
 static struct i2c_adapter iop3xx_ops1 = {
 	.owner			= THIS_MODULE,
 	.name			= ADAPTER_NAME_ROOT "1",
 	.id			= I2C_HW_IOP321,
 	.algo_data		= &algo_iop3xx_data1,
+	.class			= I2C_CLASS_ALL,
 };
 
 static int __init i2c_iop3xx_init (void)
 {
-	return i2c_iop3xx_add_bus(&iop3xx_ops0) ||
-		i2c_iop3xx_add_bus(&iop3xx_ops1);
+	int ret;
+	
+	ret = i2c_iop3xx_add_bus(&iop3xx_ops0);
+	if (ret)
+		return ret;
+		
+	ret = i2c_iop3xx_add_bus(&iop3xx_ops1);
+	if (ret) {
+		i2c_iop3xx_del_bus(&iop3xx_ops0);
+		return ret;
+	}
+
+	return 0;
 }
 
 static void __exit i2c_iop3xx_exit (void)
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/i2c/busses/i2c-ite.c linux-2.6-6-rc3-mm2/drivers/i2c/busses/i2c-ite.c
--- xx-linux-2.6-6-rc3-mm2/drivers/i2c/busses/i2c-ite.c	2004-05-09 11:03:02.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/i2c/busses/i2c-ite.c	2004-05-09 18:13:22.000000000 +0200
@@ -192,6 +192,7 @@
 	.owner		= THIS_MODULE,
 	.id		= I2C_HW_I_IIC,
 	.algo_data	= &iic_ite_data,
+	.class		= I2C_CLASS_ALL,
 	.dev		= {
 		.name	= "ITE IIC adapter",
 	},
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/i2c/busses/scx200_i2c.c linux-2.6-6-rc3-mm2/drivers/i2c/busses/scx200_i2c.c
--- xx-linux-2.6-6-rc3-mm2/drivers/i2c/busses/scx200_i2c.c	2004-05-09 11:03:02.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/i2c/busses/scx200_i2c.c	2004-05-09 18:13:55.000000000 +0200
@@ -84,6 +84,7 @@
 static struct i2c_adapter scx200_i2c_ops = {
 	.owner		   = THIS_MODULE,
 	.algo_data	   = &scx200_i2c_data,
+	.class		   = I2C_CLASS_ALL,
 	.name	= "NatSemi SCx200 I2C",
 };
 

--------------020504000006060008090307
Content-Type: text/plain;
 name="07-i2c-busses.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="07-i2c-busses.diff"

diff -ura xx-linux-2.6-6-rc3-mm2/drivers/i2c/busses/i2c-frodo.c linux-2.6-6-rc3-mm2/drivers/i2c/busses/i2c-frodo.c
--- xx-linux-2.6-6-rc3-mm2/drivers/i2c/busses/i2c-frodo.c	2004-05-09 11:03:02.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/i2c/busses/i2c-frodo.c	2004-05-09 19:56:30.000000000 +0200
@@ -62,6 +62,7 @@
 	.owner			= THIS_MODULE,
 	.id			= I2C_HW_B_FRODO,
 	.algo_data		= &bit_frodo_data,
+	.class			= I2C_CLASS_ALL,
 	.dev			= {
 		.name		= "Frodo adapter driver",
 	},
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/i2c/busses/i2c-hydra.c linux-2.6-6-rc3-mm2/drivers/i2c/busses/i2c-hydra.c
--- xx-linux-2.6-6-rc3-mm2/drivers/i2c/busses/i2c-hydra.c	2004-05-09 11:03:03.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/i2c/busses/i2c-hydra.c	2004-05-09 20:04:50.000000000 +0200
@@ -107,6 +107,7 @@
 	.owner		= THIS_MODULE,
 	.name		= "Hydra i2c",
 	.id		= I2C_HW_B_HYDRA,
+	.class		= I2C_CLASS_HWMON,
 	.algo_data	= &hydra_bit_data,
 };
 
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/i2c/busses/i2c-i810.c linux-2.6-6-rc3-mm2/drivers/i2c/busses/i2c-i810.c
--- xx-linux-2.6-6-rc3-mm2/drivers/i2c/busses/i2c-i810.c	2004-05-09 11:03:02.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/i2c/busses/i2c-i810.c	2004-05-09 19:58:12.000000000 +0200
@@ -173,6 +173,7 @@
 static struct i2c_adapter i810_i2c_adapter = {
 	.owner		= THIS_MODULE,
 	.name		= "I810/I815 I2C Adapter",
+	.class		= I2C_CLASS_ALL, /* fixme, what's the correct class? */
 	.algo_data	= &i810_i2c_bit_data,
 };
 
@@ -189,6 +190,7 @@
 static struct i2c_adapter i810_ddc_adapter = {
 	.owner		= THIS_MODULE,
 	.name		= "I810/I815 DDC Adapter",
+	.class		= I2C_CLASS_DDC,
 	.algo_data	= &i810_ddc_bit_data,
 };
 
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/i2c/busses/i2c-ixp4xx.c linux-2.6-6-rc3-mm2/drivers/i2c/busses/i2c-ixp4xx.c
--- xx-linux-2.6-6-rc3-mm2/drivers/i2c/busses/i2c-ixp4xx.c	2004-05-09 11:06:43.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/i2c/busses/i2c-ixp4xx.c	2004-05-09 20:04:01.000000000 +0200
@@ -133,8 +133,9 @@
 	drv_data->algo_data.mdelay = 10;
 	drv_data->algo_data.timeout = 100;
 
-	drv_data->adapter.id = I2C_HW_B_IXP4XX,
-	drv_data->adapter.algo_data = &drv_data->algo_data,
+	drv_data->adapter.id = I2C_HW_B_IXP4XX;
+	drv_data->adapter.algo_data = &drv_data->algo_data;
+	drv_data->adapter.class = I2C_CLASS_ALL;
 
 	drv_data->adapter.dev.parent = &plat_dev->dev;
 
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/i2c/busses/i2c-prosavage.c linux-2.6-6-rc3-mm2/drivers/i2c/busses/i2c-prosavage.c
--- xx-linux-2.6-6-rc3-mm2/drivers/i2c/busses/i2c-prosavage.c	2004-05-09 11:03:02.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/i2c/busses/i2c-prosavage.c	2004-05-09 20:00:12.000000000 +0200
@@ -181,12 +181,13 @@
 /*
  * adapter initialisation
  */
-static int i2c_register_bus(struct pci_dev *dev, struct s_i2c_bus *p, u8 *mmvga, u32 i2c_reg)
+static int i2c_register_bus(struct pci_dev *dev, struct s_i2c_bus *p, u8 *mmvga, u32 i2c_reg, unsigned int class)
 {
 	int ret;
 	p->adap.owner	  = THIS_MODULE;
 	p->adap.id	  = I2C_HW_B_S3VIA;
 	p->adap.algo_data = &p->algo;
+	p->adap.class	  = class;
 	p->adap.dev.parent = &dev->dev;
 	p->algo.setsda	  = bit_s3via_setsda;
 	p->algo.setscl	  = bit_s3via_setscl;
@@ -281,7 +282,7 @@
 	snprintf(bus->adap.name, sizeof(bus->adap.name),
 		"ProSavage I2C bus at %02x:%02x.%x",
 		dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
-	ret = i2c_register_bus(dev, bus, chip->mmio + 0x8000, CR_SERIAL1);
+	ret = i2c_register_bus(dev, bus, chip->mmio + 0x8000, CR_SERIAL1, I2C_CLASS_ALL);
 	if (ret) {
 		goto err_adap;
 	}
@@ -292,7 +293,7 @@
 	snprintf(bus->adap.name, sizeof(bus->adap.name),
 		"ProSavage DDC bus at %02x:%02x.%x",
 		dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
-	ret = i2c_register_bus(dev, bus, chip->mmio + 0x8000, CR_SERIAL2);
+	ret = i2c_register_bus(dev, bus, chip->mmio + 0x8000, CR_SERIAL2, I2C_CLASS_DDC);
 	if (ret) {
 		goto err_adap;
 	}
diff -ura xx-linux-2.6-6-rc3-mm2/drivers/i2c/busses/i2c-savage4.c linux-2.6-6-rc3-mm2/drivers/i2c/busses/i2c-savage4.c
--- xx-linux-2.6-6-rc3-mm2/drivers/i2c/busses/i2c-savage4.c	2004-05-09 11:03:02.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/i2c/busses/i2c-savage4.c	2004-05-09 20:01:31.000000000 +0200
@@ -149,6 +149,7 @@
 	.owner		= THIS_MODULE,
 	.name		= "I2C Savage4 adapter",
 	.algo_data	= &sav_i2c_bit_data,
+	.class		= I2C_CLASS_ALL, /* fixme: correct class entry? */
 };
 
 static struct pci_device_id savage4_ids[] __devinitdata = {

--------------020504000006060008090307
Content-Type: text/plain;
 name="08-i2c-core.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="08-i2c-core.diff"

diff -ura xx-linux-2.6-6-rc3-mm2/drivers/i2c/i2c-core.c linux-2.6-6-rc3-mm2/drivers/i2c/i2c-core.c
--- xx-linux-2.6-6-rc3-mm2/drivers/i2c/i2c-core.c	2004-05-09 11:03:03.000000000 +0200
+++ linux-2.6-6-rc3-mm2/drivers/i2c/i2c-core.c	2004-05-09 21:18:35.000000000 +0200
@@ -148,8 +148,11 @@
 	list_for_each(item,&drivers) {
 		driver = list_entry(item, struct i2c_driver, list);
 		if (driver->flags & I2C_DF_NOTIFY)
-			/* We ignore the return code; if it fails, too bad */
-			driver->attach_adapter(adap);
+			if (adap->class & driver->class)
+				/* We ignore the return code; if it fails, too bad */
+				driver->attach_adapter(adap);
+			else
+				printk("i2c-core: skipping driver '%s' on adapter '%s' (class mismatch)\n",driver->name, adap->name); 
 	}
 	up(&core_lists);
 
@@ -247,7 +250,10 @@
 	if (driver->flags & I2C_DF_NOTIFY) {
 		list_for_each(item,&adapters) {
 			adapter = list_entry(item, struct i2c_adapter, list);
-			driver->attach_adapter(adapter);
+			if (adapter->class & driver->class)
+				driver->attach_adapter(adapter);
+			else
+				printk("i2c-core: skipping driver '%s' on adapter '%s' (class mismatch)\n",driver->name, adap->name); 
 		}
 	}
 

--------------020504000006060008090307--
