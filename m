Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268769AbUHaPm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268769AbUHaPm4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 11:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268772AbUHaPm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 11:42:56 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:33750 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S268769AbUHaPmr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 11:42:47 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 31 Aug 2004 17:15:28 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch 1/4] v4l: i2c cleanups
Message-ID: <20040831151528.GA15535@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch has some minor cleanups for the v4l i2c modules:  Don't
ignore the i2c_add_driver return value and mark the init+exit
functions with __init + __exit.

please apply,

  Gerd

diff -up linux-2.6.9-rc1/drivers/media/video/msp3400.c linux/drivers/media/video/msp3400.c
--- linux-2.6.9-rc1/drivers/media/video/msp3400.c	2004-08-25 16:12:38.000000000 +0200
+++ linux/drivers/media/video/msp3400.c	2004-08-25 18:20:57.876559437 +0200
@@ -737,7 +737,7 @@ autodetect_stereo(struct i2c_client *cli
 static int msp34xx_sleep(struct msp3400c *msp, int timeout)
 {
 	DECLARE_WAITQUEUE(wait, current);
-
+	
 	add_wait_queue(&msp->wq, &wait);
 	if (!msp->rmmod) {
 		set_current_state(TASK_INTERRUPTIBLE);
@@ -1444,7 +1444,7 @@ static int msp_command(struct i2c_client
 			msp3400c_setcarrier(client, MSP_CARRIER(10.7),
 					    MSP_CARRIER(10.7));
 			msp3400c_setvolume(client, msp->muted,
-					   msp->volume, msp->balance);
+					   msp->volume, msp->balance);	
 		}
 		if (msp->active)
 			msp->restart = 1;
@@ -1552,13 +1552,12 @@ static int msp_command(struct i2c_client
 
 /* ----------------------------------------------------------------------- */
 
-static int msp3400_init_module(void)
+static int __init msp3400_init_module(void)
 {
-	i2c_add_driver(&driver);
-	return 0;
+	return i2c_add_driver(&driver);
 }
 
-static void msp3400_cleanup_module(void)
+static void __exit msp3400_cleanup_module(void)
 {
 	i2c_del_driver(&driver);
 }
diff -up linux-2.6.9-rc1/drivers/media/video/tda7432.c linux/drivers/media/video/tda7432.c
--- linux-2.6.9-rc1/drivers/media/video/tda7432.c	2004-08-25 16:12:51.000000000 +0200
+++ linux/drivers/media/video/tda7432.c	2004-08-25 18:20:57.879558876 +0200
@@ -532,17 +532,17 @@ static struct i2c_client client_template
 	.driver     = &driver, 
 };
 
-static int tda7432_init(void)
+static int __init tda7432_init(void)
 {
 	if ( (loudness < 0) || (loudness > 15) ) {
 		printk(KERN_ERR "tda7432: loudness parameter must be between 0 and 15\n");
 		return -EINVAL;
 	}
-	i2c_add_driver(&driver);
-	return 0;
+
+	return i2c_add_driver(&driver);
 }
 
-static void tda7432_fini(void)
+static void __exit tda7432_fini(void)
 {
 	i2c_del_driver(&driver);
 }
diff -up linux-2.6.9-rc1/drivers/media/video/tda9875.c linux/drivers/media/video/tda9875.c
--- linux-2.6.9-rc1/drivers/media/video/tda9875.c	2004-08-25 16:12:07.000000000 +0200
+++ linux/drivers/media/video/tda9875.c	2004-08-25 18:20:57.881558502 +0200
@@ -403,13 +403,12 @@ static struct i2c_client client_template
         .driver    = &driver,
 };
 
-static int tda9875_init(void)
+static int __init tda9875_init(void)
 {
-	i2c_add_driver(&driver);
-	return 0;
+	return i2c_add_driver(&driver);
 }
 
-static void tda9875_fini(void)
+static void __exit tda9875_fini(void)
 {
 	i2c_del_driver(&driver);
 }
diff -up linux-2.6.9-rc1/drivers/media/video/tvaudio.c linux/drivers/media/video/tvaudio.c
--- linux-2.6.9-rc1/drivers/media/video/tvaudio.c	2004-08-25 16:11:53.000000000 +0200
+++ linux/drivers/media/video/tvaudio.c	2004-08-25 18:20:57.885557754 +0200
@@ -277,7 +277,7 @@ static int chip_thread(void *data)
 	daemonize("%s",i2c_clientname(&chip->c));
 	allow_signal(SIGTERM);
 	dprintk("%s: thread started\n", i2c_clientname(&chip->c));
-
+	
 	for (;;) {
 		add_wait_queue(&chip->wq, &wait);
 		if (!chip->done) {
@@ -1651,7 +1651,7 @@ static struct i2c_client client_template
         .driver     = &driver,
 };
 
-static int audiochip_init_module(void)
+static int __init audiochip_init_module(void)
 {
 	struct CHIPDESC  *desc;
 	printk(KERN_INFO "tvaudio: TV audio decoder + audio/video mux driver\n");
@@ -1659,11 +1659,11 @@ static int audiochip_init_module(void)
 	for (desc = chiplist; desc->name != NULL; desc++)
 		printk("%s%s", (desc == chiplist) ? "" : ",",desc->name);
 	printk("\n");
-	i2c_add_driver(&driver);
-	return 0;
+
+	return i2c_add_driver(&driver);
 }
 
-static void audiochip_cleanup_module(void)
+static void __exit audiochip_cleanup_module(void)
 {
 	i2c_del_driver(&driver);
 }
diff -up linux-2.6.9-rc1/drivers/media/video/tvmixer.c linux/drivers/media/video/tvmixer.c
--- linux-2.6.9-rc1/drivers/media/video/tvmixer.c	2004-08-25 16:13:26.000000000 +0200
+++ linux/drivers/media/video/tvmixer.c	2004-08-25 18:20:57.887557380 +0200
@@ -330,17 +330,17 @@ static int tvmixer_clients(struct i2c_cl
 
 /* ----------------------------------------------------------------------- */
 
-static int tvmixer_init_module(void)
+static int __init tvmixer_init_module(void)
 {
 	int i;
 	
 	for (i = 0; i < DEV_MAX; i++)
 		devices[i].minor = -1;
-	i2c_add_driver(&driver);
-	return 0;
+
+	return i2c_add_driver(&driver);
 }
 
-static void tvmixer_cleanup_module(void)
+static void __exit tvmixer_cleanup_module(void)
 {
 	int i;
 	
diff -up linux-2.6.9-rc1/include/media/id.h linux/include/media/id.h
--- linux-2.6.9-rc1/include/media/id.h	2004-08-25 16:12:15.000000000 +0200
+++ linux/include/media/id.h	2004-08-25 18:20:57.889557007 +0200
@@ -35,4 +35,3 @@
 #ifndef I2C_ALGO_SAA7134
 # define I2C_ALGO_SAA7134 0x090000
 #endif
-

-- 
return -ENOSIG;
