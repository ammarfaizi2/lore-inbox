Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964947AbVIEX0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964947AbVIEX0U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 19:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964951AbVIEX0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 19:26:20 -0400
Received: from smtp1.brturbo.com.br ([200.199.201.163]:21429 "EHLO
	smtp1.brturbo.com.br") by vger.kernel.org with ESMTP
	id S964947AbVIEX0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 19:26:19 -0400
Date: Mon, 05 Sep 2005 18:26:15 -0300
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org
Cc: video4linux-list@redhat.com, akpm@osdl.org
Subject: [PATCH 11/24] V4L: adds the adapter number and i2c address to
 printk msgs.
Message-ID: <431cb7f7.kUX57hRjsEaYVoYx%mchehab@brturbo.com.br>
User-Agent: nail 11.25 7/29/05
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_431cb7f7.9wH4LsIqQgekvmCH6/XZLSxa56rTbf05BSHJ02NQap4jslnE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--=_431cb7f7.9wH4LsIqQgekvmCH6/XZLSxa56rTbf05BSHJ02NQap4jslnE
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

.

--=_431cb7f7.9wH4LsIqQgekvmCH6/XZLSxa56rTbf05BSHJ02NQap4jslnE
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="v4l-11-patch.diff"

- adds the adapter number + i2c address to printk msgs.
- Some CodingStyle cleanups.

Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

 linux/drivers/media/video/tvaudio.c  |  200 +++++----
 linux/drivers/media/video/tveeprom.c |  552 +++++++++++++--------------
 2 files changed, 385 insertions(+), 367 deletions(-)

diff -u /tmp/dst.32540 linux/drivers/media/video/tvaudio.c
--- /tmp/dst.32540	2005-09-05 11:42:53.000000000 -0300
+++ linux/drivers/media/video/tvaudio.c	2005-09-05 11:42:53.000000000 -0300
@@ -46,7 +46,17 @@
 MODULE_LICENSE("GPL");
 
 #define UNSET    (-1U)
-#define dprintk  if (debug) printk
+
+#define tvaudio_info(fmt, arg...) do {\
+	printk(KERN_INFO "tvaudio %d-%04x: " fmt, \
+			chip->c.adapter->nr, chip->c.addr, ## arg); } while (0)
+#define tvaudio_warn(fmt, arg...) do {\
+	printk(KERN_WARNING "tvaudio %d-%04x: " fmt, \
+			chip->c.adapter->nr, chip->c.addr, ## arg); } while (0)
+#define tvaudio_dbg(fmt, arg...) do {\
+	if (debug) \
+		printk(KERN_INFO "tvaudio %d-%04x: " fmt, \
+			chip->c.adapter->nr, chip->c.addr, ## arg); } while (0)
 
 /* ---------------------------------------------------------------------- */
 /* our structs                                                            */
@@ -162,24 +172,24 @@
 	unsigned char buffer[2];
 
 	if (-1 == subaddr) {
-		dprintk("%s: chip_write: 0x%x\n",
+		tvaudio_dbg("%s: chip_write: 0x%x\n",
 			i2c_clientname(&chip->c), val);
 		chip->shadow.bytes[1] = val;
 		buffer[0] = val;
 		if (1 != i2c_master_send(&chip->c,buffer,1)) {
-			printk(KERN_WARNING "%s: I/O error (write 0x%x)\n",
-			       i2c_clientname(&chip->c), val);
+			tvaudio_warn("%s: I/O error (write 0x%x)\n",
+				i2c_clientname(&chip->c), val);
 			return -1;
 		}
 	} else {
-		dprintk("%s: chip_write: reg%d=0x%x\n",
+		tvaudio_dbg("%s: chip_write: reg%d=0x%x\n",
 			i2c_clientname(&chip->c), subaddr, val);
 		chip->shadow.bytes[subaddr+1] = val;
 		buffer[0] = subaddr;
 		buffer[1] = val;
 		if (2 != i2c_master_send(&chip->c,buffer,2)) {
-			printk(KERN_WARNING "%s: I/O error (write reg%d=0x%x)\n",
-			       i2c_clientname(&chip->c), subaddr, val);
+			tvaudio_warn("%s: I/O error (write reg%d=0x%x)\n",
+			i2c_clientname(&chip->c), subaddr, val);
 			return -1;
 		}
 	}
@@ -203,30 +213,30 @@
 	unsigned char buffer;
 
 	if (1 != i2c_master_recv(&chip->c,&buffer,1)) {
-		printk(KERN_WARNING "%s: I/O error (read)\n",
-		       i2c_clientname(&chip->c));
+		tvaudio_warn("%s: I/O error (read)\n",
+		i2c_clientname(&chip->c));
 		return -1;
 	}
-	dprintk("%s: chip_read: 0x%x\n",i2c_clientname(&chip->c),buffer);
+	tvaudio_dbg("%s: chip_read: 0x%x\n",i2c_clientname(&chip->c),buffer);
 	return buffer;
 }
 
 static int chip_read2(struct CHIPSTATE *chip, int subaddr)
 {
-        unsigned char write[1];
-        unsigned char read[1];
-        struct i2c_msg msgs[2] = {
-                { chip->c.addr, 0,        1, write },
-                { chip->c.addr, I2C_M_RD, 1, read  }
-        };
-        write[0] = subaddr;
+	unsigned char write[1];
+	unsigned char read[1];
+	struct i2c_msg msgs[2] = {
+		{ chip->c.addr, 0,        1, write },
+		{ chip->c.addr, I2C_M_RD, 1, read  }
+	};
+	write[0] = subaddr;
 
 	if (2 != i2c_transfer(chip->c.adapter,msgs,2)) {
-		printk(KERN_WARNING "%s: I/O error (read2)\n",
-		       i2c_clientname(&chip->c));
+		tvaudio_warn("%s: I/O error (read2)\n",
+		i2c_clientname(&chip->c));
 		return -1;
 	}
-	dprintk("%s: chip_read2: reg%d=0x%x\n",
+	tvaudio_dbg("%s: chip_read2: reg%d=0x%x\n",
 		i2c_clientname(&chip->c),subaddr,read[0]);
 	return read[0];
 }
@@ -239,17 +249,19 @@
 		return 0;
 
 	/* update our shadow register set; print bytes if (debug > 0) */
-	dprintk("%s: chip_cmd(%s): reg=%d, data:",
+	tvaudio_dbg("%s: chip_cmd(%s): reg=%d, data:",
 		i2c_clientname(&chip->c),name,cmd->bytes[0]);
 	for (i = 1; i < cmd->count; i++) {
-		dprintk(" 0x%x",cmd->bytes[i]);
+		if (debug)
+			printk(" 0x%x",cmd->bytes[i]);
 		chip->shadow.bytes[i+cmd->bytes[0]] = cmd->bytes[i];
 	}
-	dprintk("\n");
+	if (debug)
+		printk("\n");
 
 	/* send data to the chip */
 	if (cmd->count != i2c_master_send(&chip->c,cmd->bytes,cmd->count)) {
-		printk(KERN_WARNING "%s: I/O error (%s)\n", i2c_clientname(&chip->c), name);
+		tvaudio_warn("%s: I/O error (%s)\n", i2c_clientname(&chip->c), name);
 		return -1;
 	}
 	return 0;
@@ -264,19 +276,19 @@
 
 static void chip_thread_wake(unsigned long data)
 {
-        struct CHIPSTATE *chip = (struct CHIPSTATE*)data;
+	struct CHIPSTATE *chip = (struct CHIPSTATE*)data;
 	wake_up_interruptible(&chip->wq);
 }
 
 static int chip_thread(void *data)
 {
 	DECLARE_WAITQUEUE(wait, current);
-        struct CHIPSTATE *chip = data;
+	struct CHIPSTATE *chip = data;
 	struct CHIPDESC  *desc = chiplist + chip->type;
 
 	daemonize("%s",i2c_clientname(&chip->c));
 	allow_signal(SIGTERM);
-	dprintk("%s: thread started\n", i2c_clientname(&chip->c));
+	tvaudio_dbg("%s: thread started\n", i2c_clientname(&chip->c));
 
 	for (;;) {
 		add_wait_queue(&chip->wq, &wait);
@@ -288,7 +300,7 @@
 		try_to_freeze();
 		if (chip->done || signal_pending(current))
 			break;
-		dprintk("%s: thread wakeup\n", i2c_clientname(&chip->c));
+		tvaudio_dbg("%s: thread wakeup\n", i2c_clientname(&chip->c));
 
 		/* don't do anything for radio or if mode != auto */
 		if (chip->norm == VIDEO_MODE_RADIO || chip->mode != 0)
@@ -301,8 +313,8 @@
 		mod_timer(&chip->wt, jiffies+2*HZ);
 	}
 
-	dprintk("%s: thread exiting\n", i2c_clientname(&chip->c));
-        complete_and_exit(&chip->texit, 0);
+	tvaudio_dbg("%s: thread exiting\n", i2c_clientname(&chip->c));
+	complete_and_exit(&chip->texit, 0);
 	return 0;
 }
 
@@ -312,9 +324,9 @@
 	int mode = desc->getmode(chip);
 
 	if (mode == chip->prevmode)
-	    return;
+	return;
 
-	dprintk("%s: thread checkmode\n", i2c_clientname(&chip->c));
+	tvaudio_dbg("%s: thread checkmode\n", i2c_clientname(&chip->c));
 	chip->prevmode = mode;
 
 	if (mode & VIDEO_SOUND_STEREO)
@@ -361,8 +373,8 @@
 	if (val & TDA9840_ST_STEREO)
 		mode |= VIDEO_SOUND_STEREO;
 
-	dprintk ("tda9840_getmode(): raw chip read: %d, return: %d\n",
-		 val, mode);
+	tvaudio_dbg ("tda9840_getmode(): raw chip read: %d, return: %d\n",
+		val, mode);
 	return mode;
 }
 
@@ -657,8 +669,8 @@
 		mode |= VIDEO_SOUND_STEREO;
 	if (val & TDA9873_DUAL)
 		mode |= VIDEO_SOUND_LANG1 | VIDEO_SOUND_LANG2;
-	dprintk ("tda9873_getmode(): raw chip read: %d, return: %d\n",
-		 val, mode);
+	tvaudio_dbg ("tda9873_getmode(): raw chip read: %d, return: %d\n",
+		val, mode);
 	return mode;
 }
 
@@ -668,12 +680,12 @@
 	/*	int adj_data = chip->shadow.bytes[TDA9873_AD+1] ; */
 
 	if ((sw_data & TDA9873_INP_MASK) != TDA9873_INTERNAL) {
-		dprintk("tda9873_setmode(): external input\n");
+		tvaudio_dbg("tda9873_setmode(): external input\n");
 		return;
 	}
 
-	dprintk("tda9873_setmode(): chip->shadow.bytes[%d] = %d\n", TDA9873_SW+1, chip->shadow.bytes[TDA9873_SW+1]);
-	dprintk("tda9873_setmode(): sw_data  = %d\n", sw_data);
+	tvaudio_dbg("tda9873_setmode(): chip->shadow.bytes[%d] = %d\n", TDA9873_SW+1, chip->shadow.bytes[TDA9873_SW+1]);
+	tvaudio_dbg("tda9873_setmode(): sw_data  = %d\n", sw_data);
 
 	switch (mode) {
 	case VIDEO_SOUND_MONO:
@@ -694,7 +706,7 @@
 	}
 
 	chip_write(chip, TDA9873_SW, sw_data);
-	dprintk("tda9873_setmode(): req. mode %d; chip_write: %d\n",
+	tvaudio_dbg("tda9873_setmode(): req. mode %d; chip_write: %d\n",
 		mode, sw_data);
 }
 
@@ -831,9 +843,9 @@
 	} else { /* dic == 0x07 */
 		chip_write(chip, TDA9874A_AMCONR, 0xfb);
 		chip_write(chip, TDA9874A_SDACOSR, (tda9874a_mode) ? 0x81:0x80);
-		chip_write(chip, TDA9874A_AOSR, 0x00); // or 0x10
+		chip_write(chip, TDA9874A_AOSR, 0x00); /* or 0x10 */
 	}
-	dprintk("tda9874a_setup(): %s [0x%02X].\n",
+	tvaudio_dbg("tda9874a_setup(): %s [0x%02X].\n",
 		tda9874a_modelist[tda9874a_STD].name,tda9874a_STD);
 	return 1;
 }
@@ -876,7 +888,7 @@
 			mode |= VIDEO_SOUND_LANG1 | VIDEO_SOUND_LANG2;
 	}
 
-	dprintk("tda9874a_getmode(): DSR=0x%X, NSR=0x%X, NECR=0x%X, return: %d.\n",
+	tvaudio_dbg("tda9874a_getmode(): DSR=0x%X, NSR=0x%X, NECR=0x%X, return: %d.\n",
 		 dsr, nsr, necr, mode);
 	return mode;
 }
@@ -922,7 +934,7 @@
 		chip_write(chip, TDA9874A_AOSR, aosr);
 		chip_write(chip, TDA9874A_MDACOSR, mdacosr);
 
-		dprintk("tda9874a_setmode(): req. mode %d; AOSR=0x%X, MDACOSR=0x%X.\n",
+		tvaudio_dbg("tda9874a_setmode(): req. mode %d; AOSR=0x%X, MDACOSR=0x%X.\n",
 			mode, aosr, mdacosr);
 
 	} else { /* dic == 0x07 */
@@ -957,7 +969,7 @@
 		chip_write(chip, TDA9874A_FMMR, fmmr);
 		chip_write(chip, TDA9874A_AOSR, aosr);
 
-		dprintk("tda9874a_setmode(): req. mode %d; FMMR=0x%X, AOSR=0x%X.\n",
+		tvaudio_dbg("tda9874a_setmode(): req. mode %d; FMMR=0x%X, AOSR=0x%X.\n",
 			mode, fmmr, aosr);
 	}
 }
@@ -971,10 +983,10 @@
 	if(-1 == (sic = chip_read2(chip,TDA9874A_SIC)))
 		return 0;
 
-	dprintk("tda9874a_checkit(): DIC=0x%X, SIC=0x%X.\n", dic, sic);
+	tvaudio_dbg("tda9874a_checkit(): DIC=0x%X, SIC=0x%X.\n", dic, sic);
 
 	if((dic == 0x11)||(dic == 0x07)) {
-		printk("tvaudio: found tda9874%s.\n", (dic == 0x11) ? "a":"h");
+		tvaudio_info("found tda9874%s.\n", (dic == 0x11) ? "a":"h");
 		tda9874a_dic = dic;	/* remember device id. */
 		return 1;
 	}
@@ -1149,7 +1161,7 @@
 /* ---------------------------------------------------------------------- */
 /* audio chip descriptions - defines+functions for TA8874Z                */
 
-// write 1st byte
+/* write 1st byte */
 #define TA8874Z_LED_STE	0x80
 #define TA8874Z_LED_BIL	0x40
 #define TA8874Z_LED_EXT	0x20
@@ -1159,21 +1171,22 @@
 #define TA8874Z_MODE_SUB	0x02
 #define TA8874Z_MODE_MAIN	0x01
 
-// write 2nd byte
-//#define TA8874Z_TI	0x80  // test mode
+/* write 2nd byte */
+/*#define TA8874Z_TI	0x80  */ /* test mode */
 #define TA8874Z_SEPARATION	0x3f
 #define TA8874Z_SEPARATION_DEFAULT	0x10
 
-// read
+/* read */
 #define TA8874Z_B1	0x80
 #define TA8874Z_B0	0x40
 #define TA8874Z_CHAG_FLAG	0x20
 
-//        B1 B0
-// mono    L  H
-// stereo  L  L
-// BIL     H  L
-
+/*
+ *        B1 B0
+ * mono    L  H
+ * stereo  L  L
+ * BIL     H  L
+ */
 static int ta8874z_getmode(struct CHIPSTATE *chip)
 {
 	int val, mode;
@@ -1185,7 +1198,7 @@
 	}else if (!(val & TA8874Z_B0)){
 		mode |= VIDEO_SOUND_STEREO;
 	}
-	//dprintk ("ta8874z_getmode(): raw chip read: 0x%02x, return: 0x%02x\n", val, mode);
+	/* tvaudio_dbg ("ta8874z_getmode(): raw chip read: 0x%02x, return: 0x%02x\n", val, mode); */
 	return mode;
 }
 
@@ -1198,7 +1211,7 @@
 {
 	int update = 1;
 	audiocmd *t = NULL;
-	dprintk("ta8874z_setmode(): mode: 0x%02x\n", mode);
+	tvaudio_dbg("ta8874z_setmode(): mode: 0x%02x\n", mode);
 
 	switch(mode){
 	case VIDEO_SOUND_MONO:
@@ -1238,11 +1251,11 @@
 static int tda9855  = 1;
 static int tda9873  = 1;
 static int tda9874a = 1;
-static int tea6300  = 0;  // address clash with msp34xx
-static int tea6320  = 0;  // address clash with msp34xx
+static int tea6300  = 0;  /* address clash with msp34xx */
+static int tea6320  = 0;  /* address clash with msp34xx */
 static int tea6420  = 1;
 static int pic16c54 = 1;
-static int ta8874z  = 0;  // address clash with tda9840
+static int ta8874z  = 0;  /* address clash with tda9840 */
 
 module_param(tda8425, int, 0444);
 module_param(tda9840, int, 0444);
@@ -1444,7 +1457,7 @@
 	{
 		.name       = "ta8874z",
 		.id         = -1,
-		//.id         = I2C_DRIVERID_TA8874Z,
+		/*.id         = I2C_DRIVERID_TA8874Z, */
 		.checkit    = ta8874z_checkit,
 		.insmodopt  = &ta8874z,
 		.addr_lo    = I2C_TDA9840 >> 1,
@@ -1479,7 +1492,7 @@
 	i2c_set_clientdata(&chip->c, chip);
 
 	/* find description for the chip */
-	dprintk("tvaudio: chip found @ i2c-addr=0x%x\n", addr<<1);
+	tvaudio_dbg("chip found @ 0x%x\n", addr<<1);
 	for (desc = chiplist; desc->name != NULL; desc++) {
 		if (0 == *(desc->insmodopt))
 			continue;
@@ -1491,14 +1504,16 @@
 		break;
 	}
 	if (desc->name == NULL) {
-		dprintk("tvaudio: no matching chip description found\n");
+		tvaudio_dbg("no matching chip description found\n");
 		return -EIO;
 	}
-	printk("tvaudio: found %s @ 0x%x\n", desc->name, addr<<1);
-	dprintk("tvaudio: matches:%s%s%s.\n",
-		(desc->flags & CHIP_HAS_VOLUME)     ? " volume"      : "",
-		(desc->flags & CHIP_HAS_BASSTREBLE) ? " bass/treble" : "",
-		(desc->flags & CHIP_HAS_INPUTSEL)   ? " audiomux"    : "");
+	tvaudio_info("%s found @ 0x%x (%s)\n", desc->name, addr<<1, adap->name);
+        if (desc->flags) {
+                tvaudio_dbg("matches:%s%s%s.\n",
+                        (desc->flags & CHIP_HAS_VOLUME)     ? " volume"      : "",
+                        (desc->flags & CHIP_HAS_BASSTREBLE) ? " bass/treble" : "",
+                        (desc->flags & CHIP_HAS_INPUTSEL)   ? " audiomux"    : "");
+        }
 
 	/* fill required data structures */
 	strcpy(i2c_clientname(&chip->c),desc->name);
@@ -1537,7 +1552,7 @@
 		init_completion(&chip->texit);
 		chip->tpid = kernel_thread(chip_thread,(void *)chip,0);
 		if (chip->tpid < 0)
-			printk(KERN_WARNING "%s: kernel_thread() failed\n",
+			tvaudio_warn("%s: kernel_thread() failed\n",
 			       i2c_clientname(&chip->c));
 		wake_up_interruptible(&chip->wq);
 	}
@@ -1587,11 +1602,11 @@
 static int chip_command(struct i2c_client *client,
 			unsigned int cmd, void *arg)
 {
-        __u16 *sarg = arg;
+	__u16 *sarg = arg;
 	struct CHIPSTATE *chip = i2c_get_clientdata(client);
 	struct CHIPDESC  *desc = chiplist + chip->type;
 
-	dprintk("%s: chip_command 0x%x\n",i2c_clientname(&chip->c),cmd);
+	tvaudio_dbg("%s: chip_command 0x%x\n",i2c_clientname(&chip->c),cmd);
 
 	switch (cmd) {
 	case AUDC_SET_INPUT:
@@ -1604,7 +1619,6 @@
 		break;
 
 	case AUDC_SET_RADIO:
-		dprintk(KERN_DEBUG "tvaudio: AUDC_SET_RADIO\n");
 		chip->norm = VIDEO_MODE_RADIO;
 		chip->watch_stereo = 0;
 		/* del_timer(&chip->wt); */
@@ -1612,7 +1626,7 @@
 
 	/* --- v4l ioctls --- */
 	/* take care: bttv does userspace copying, we'll get a
-	   kernel pointer here... */
+	kernel pointer here... */
 	case VIDIOCGAUDIO:
 	{
 		struct video_audio *va = arg;
@@ -1646,9 +1660,9 @@
 
 		if (desc->flags & CHIP_HAS_VOLUME) {
 			chip->left = (min(65536 - va->balance,32768) *
-				      va->volume) / 32768;
+				va->volume) / 32768;
 			chip->right = (min(va->balance,(__u16)32768) *
-				       va->volume) / 32768;
+				va->volume) / 32768;
 			chip_write(chip,desc->leftreg,desc->volfunc(chip->left));
 			chip_write(chip,desc->rightreg,desc->volfunc(chip->right));
 		}
@@ -1670,17 +1684,16 @@
 	{
 		struct video_channel *vc = arg;
 
-		dprintk(KERN_DEBUG "tvaudio: VIDIOCSCHAN\n");
 		chip->norm = vc->norm;
 		break;
 	}
 	case VIDIOCSFREQ:
 	{
-	    	chip->mode = 0; /* automatic */
+		chip->mode = 0; /* automatic */
 		if (desc->checkmode) {
 			desc->setmode(chip,VIDEO_SOUND_MONO);
-		    	if (chip->prevmode != VIDEO_SOUND_MONO)
-		    		chip->prevmode = -1; /* reset previous mode */
+			if (chip->prevmode != VIDEO_SOUND_MONO)
+				chip->prevmode = -1; /* reset previous mode */
 			mod_timer(&chip->wt, jiffies+2*HZ);
 			/* the thread will call checkmode() later */
 		}
@@ -1692,29 +1705,32 @@
 
 static struct i2c_driver driver = {
 	.owner           = THIS_MODULE,
-        .name            = "generic i2c audio driver",
-        .id              = I2C_DRIVERID_TVAUDIO,
-        .flags           = I2C_DF_NOTIFY,
-        .attach_adapter  = chip_probe,
-        .detach_client   = chip_detach,
-        .command         = chip_command,
+	.name            = "generic i2c audio driver",
+	.id              = I2C_DRIVERID_TVAUDIO,
+	.flags           = I2C_DF_NOTIFY,
+	.attach_adapter  = chip_probe,
+	.detach_client   = chip_detach,
+	.command         = chip_command,
 };
 
 static struct i2c_client client_template =
 {
 	I2C_DEVNAME("(unset)"),
 	.flags      = I2C_CLIENT_ALLOW_USE,
-        .driver     = &driver,
+	.driver     = &driver,
 };
 
 static int __init audiochip_init_module(void)
 {
 	struct CHIPDESC  *desc;
-	printk(KERN_INFO "tvaudio: TV audio decoder + audio/video mux driver\n");
-	printk(KERN_INFO "tvaudio: known chips: ");
-	for (desc = chiplist; desc->name != NULL; desc++)
-		printk("%s%s", (desc == chiplist) ? "" : ",",desc->name);
-	printk("\n");
+
+	if (debug) {
+		printk(KERN_INFO "tvaudio: TV audio decoder + audio/video mux driver\n");
+		printk(KERN_INFO "tvaudio: known chips: ");
+		for (desc = chiplist; desc->name != NULL; desc++)
+			printk("%s%s", (desc == chiplist) ? "" : ", ", desc->name);
+		printk("\n");
+	}
 
 	return i2c_add_driver(&driver);
 }
diff -u /tmp/dst.32540 linux/drivers/media/video/tveeprom.c
--- /tmp/dst.32540	2005-09-05 11:42:53.000000000 -0300
+++ linux/drivers/media/video/tveeprom.c	2005-09-05 11:42:53.000000000 -0300
@@ -63,227 +63,233 @@
 /* ----------------------------------------------------------------------- */
 /* some hauppauge specific stuff                                           */
 
-static struct HAUPPAUGE_TUNER_FMT
-{
-	int	id;
+static struct HAUPPAUGE_TUNER_FMT {
+	int id;
 	char *name;
-}
-hauppauge_tuner_fmt[] =
-{
-	{ 0x00000000, "unknown1" },
-	{ 0x00000000, "unknown2" },
-	{ 0x00000007, "PAL(B/G)" },
-	{ 0x00001000, "NTSC(M)" },
-	{ 0x00000010, "PAL(I)" },
-	{ 0x00400000, "SECAM(L/L´)" },
-	{ 0x00000e00, "PAL(D/K)" },
-	{ 0x03000000, "ATSC Digital" },
-};
+} hauppauge_tuner_fmt[] = {
+	{
+	0x00000000, "unknown1"}, {
+	0x00000000, "unknown2"}, {
+	0x00000007, "PAL(B/G)"}, {
+	0x00001000, "NTSC(M)"}, {
+	0x00000010, "PAL(I)"}, {
+	0x00400000, "SECAM(L/L´)"}, {
+	0x00000e00, "PAL(D/K)"}, {
+0x03000000, "ATSC Digital"},};
 
 /* This is the full list of possible tuners. Many thanks to Hauppauge for
    supplying this information. Note that many tuners where only used for
    testing and never made it to the outside world. So you will only see
    a subset in actual produced cards. */
-static struct HAUPPAUGE_TUNER
-{
-	int  id;
+static struct HAUPPAUGE_TUNER {
+	int id;
 	char *name;
-}
-hauppauge_tuner[] =
-{
+} hauppauge_tuner[] = {
 	/* 0-9 */
-	{ TUNER_ABSENT,        "None" },
-	{ TUNER_ABSENT,        "External" },
-	{ TUNER_ABSENT,        "Unspecified" },
-	{ TUNER_PHILIPS_PAL,   "Philips FI1216" },
-	{ TUNER_PHILIPS_SECAM, "Philips FI1216MF" },
-	{ TUNER_PHILIPS_NTSC,  "Philips FI1236" },
-	{ TUNER_PHILIPS_PAL_I, "Philips FI1246" },
-	{ TUNER_PHILIPS_PAL_DK,"Philips FI1256" },
-	{ TUNER_PHILIPS_PAL,   "Philips FI1216 MK2" },
-	{ TUNER_PHILIPS_SECAM, "Philips FI1216MF MK2" },
-	/* 10-19 */
-	{ TUNER_PHILIPS_NTSC,  "Philips FI1236 MK2" },
-	{ TUNER_PHILIPS_PAL_I, "Philips FI1246 MK2" },
-	{ TUNER_PHILIPS_PAL_DK,"Philips FI1256 MK2" },
-	{ TUNER_TEMIC_NTSC,    "Temic 4032FY5" },
-	{ TUNER_TEMIC_PAL,     "Temic 4002FH5" },
-	{ TUNER_TEMIC_PAL_I,   "Temic 4062FY5" },
-	{ TUNER_PHILIPS_PAL,   "Philips FR1216 MK2" },
-	{ TUNER_PHILIPS_SECAM, "Philips FR1216MF MK2" },
-	{ TUNER_PHILIPS_NTSC,  "Philips FR1236 MK2" },
-	{ TUNER_PHILIPS_PAL_I, "Philips FR1246 MK2" },
-	/* 20-29 */
-	{ TUNER_PHILIPS_PAL_DK,"Philips FR1256 MK2" },
-	{ TUNER_PHILIPS_PAL,   "Philips FM1216" },
-	{ TUNER_PHILIPS_SECAM, "Philips FM1216MF" },
-	{ TUNER_PHILIPS_NTSC,  "Philips FM1236" },
-	{ TUNER_PHILIPS_PAL_I, "Philips FM1246" },
-	{ TUNER_PHILIPS_PAL_DK,"Philips FM1256" },
-	{ TUNER_TEMIC_4036FY5_NTSC, "Temic 4036FY5" },
-	{ TUNER_ABSENT,        "Samsung TCPN9082D" },
-	{ TUNER_ABSENT,        "Samsung TCPM9092P" },
-	{ TUNER_TEMIC_4006FH5_PAL, "Temic 4006FH5" },
-	/* 30-39 */
-	{ TUNER_ABSENT,        "Samsung TCPN9085D" },
-	{ TUNER_ABSENT,        "Samsung TCPB9085P" },
-	{ TUNER_ABSENT,        "Samsung TCPL9091P" },
-	{ TUNER_TEMIC_4039FR5_NTSC, "Temic 4039FR5" },
-	{ TUNER_PHILIPS_FQ1216ME,   "Philips FQ1216 ME" },
-	{ TUNER_TEMIC_4066FY5_PAL_I, "Temic 4066FY5" },
-        { TUNER_PHILIPS_NTSC,        "Philips TD1536" },
-        { TUNER_PHILIPS_NTSC,        "Philips TD1536D" },
-	{ TUNER_PHILIPS_NTSC,  "Philips FMR1236" }, /* mono radio */
-	{ TUNER_ABSENT,        "Philips FI1256MP" },
-	/* 40-49 */
-	{ TUNER_ABSENT,        "Samsung TCPQ9091P" },
-	{ TUNER_TEMIC_4006FN5_MULTI_PAL, "Temic 4006FN5" },
-	{ TUNER_TEMIC_4009FR5_PAL, "Temic 4009FR5" },
-	{ TUNER_TEMIC_4046FM5,     "Temic 4046FM5" },
-	{ TUNER_TEMIC_4009FN5_MULTI_PAL_FM, "Temic 4009FN5" },
-	{ TUNER_ABSENT,        "Philips TD1536D FH 44"},
-	{ TUNER_LG_NTSC_FM,    "LG TP18NSR01F"},
-	{ TUNER_LG_PAL_FM,     "LG TP18PSB01D"},
-	{ TUNER_LG_PAL,        "LG TP18PSB11D"},
-	{ TUNER_LG_PAL_I_FM,   "LG TAPC-I001D"},
-	/* 50-59 */
-	{ TUNER_LG_PAL_I,      "LG TAPC-I701D"},
-	{ TUNER_ABSENT,        "Temic 4042FI5"},
-	{ TUNER_MICROTUNE_4049FM5, "Microtune 4049 FM5"},
-	{ TUNER_ABSENT,        "LG TPI8NSR11F"},
-	{ TUNER_ABSENT,        "Microtune 4049 FM5 Alt I2C"},
-	{ TUNER_PHILIPS_FM1216ME_MK3, "Philips FQ1216ME MK3"},
-	{ TUNER_ABSENT,        "Philips FI1236 MK3"},
-	{ TUNER_PHILIPS_FM1216ME_MK3, "Philips FM1216 ME MK3"},
-	{ TUNER_PHILIPS_FM1236_MK3, "Philips FM1236 MK3"},
-	{ TUNER_ABSENT,        "Philips FM1216MP MK3"},
-	/* 60-69 */
-	{ TUNER_PHILIPS_FM1216ME_MK3, "LG S001D MK3"},
-	{ TUNER_ABSENT,        "LG M001D MK3"},
-	{ TUNER_ABSENT,        "LG S701D MK3"},
-	{ TUNER_ABSENT,        "LG M701D MK3"},
-	{ TUNER_ABSENT,        "Temic 4146FM5"},
-	{ TUNER_ABSENT,        "Temic 4136FY5"},
-	{ TUNER_ABSENT,        "Temic 4106FH5"},
-	{ TUNER_ABSENT,        "Philips FQ1216LMP MK3"},
-	{ TUNER_LG_NTSC_TAPE,  "LG TAPE H001F MK3"},
-	{ TUNER_LG_NTSC_TAPE,  "LG TAPE H701F MK3"},
-	/* 70-79 */
-	{ TUNER_ABSENT,        "LG TALN H200T"},
-	{ TUNER_ABSENT,        "LG TALN H250T"},
-	{ TUNER_ABSENT,        "LG TALN M200T"},
-	{ TUNER_ABSENT,        "LG TALN Z200T"},
-	{ TUNER_ABSENT,        "LG TALN S200T"},
-	{ TUNER_ABSENT,        "Thompson DTT7595"},
-	{ TUNER_ABSENT,        "Thompson DTT7592"},
-	{ TUNER_ABSENT,        "Silicon TDA8275C1 8290"},
-	{ TUNER_ABSENT,        "Silicon TDA8275C1 8290 FM"},
-	{ TUNER_ABSENT,        "Thompson DTT757"},
-	/* 80-89 */
-	{ TUNER_ABSENT,        "Philips FQ1216LME MK3"},
-	{ TUNER_ABSENT,        "LG TAPC G701D"},
-	{ TUNER_LG_NTSC_NEW_TAPC, "LG TAPC H791F"},
-	{ TUNER_LG_PAL_NEW_TAPC, "TCL 2002MB 3"},
-	{ TUNER_LG_PAL_NEW_TAPC, "TCL 2002MI 3"},
-	{ TUNER_TCL_2002N,     "TCL 2002N 6A"},
-	{ TUNER_ABSENT,        "Philips FQ1236 MK3"},
-	{ TUNER_ABSENT,        "Samsung TCPN 2121P30A"},
-	{ TUNER_ABSENT,        "Samsung TCPE 4121P30A"},
-	{ TUNER_PHILIPS_FM1216ME_MK3, "TCL MFPE05 2"},
-	/* 90-99 */
-	{ TUNER_ABSENT,        "LG TALN H202T"},
-	{ TUNER_PHILIPS_FQ1216AME_MK4, "Philips FQ1216AME MK4"},
-	{ TUNER_PHILIPS_FQ1236A_MK4, "Philips FQ1236A MK4"},
-	{ TUNER_ABSENT,        "Philips FQ1286A MK4"},
-	{ TUNER_ABSENT,        "Philips FQ1216ME MK5"},
-	{ TUNER_ABSENT,        "Philips FQ1236 MK5"},
-	{ TUNER_ABSENT,        "Unspecified"},
-	{ TUNER_LG_PAL_TAPE,   "LG PAL (TAPE Series)"},
-        { TUNER_ABSENT,        "Unspecified"},
-        { TUNER_TCL_2002N,     "TCL 2002N 5H"},
-	/* 100-103 */
-	{ TUNER_ABSENT,        "Unspecified"},
-        { TUNER_ABSENT,        "Unspecified"},
-        { TUNER_ABSENT,        "Unspecified"},
-        { TUNER_PHILIPS_FM1236_MK3, "TCL MFNM05 4"},
-};
+	{
+	TUNER_ABSENT, "None"}, {
+	TUNER_ABSENT, "External"}, {
+	TUNER_ABSENT, "Unspecified"}, {
+	TUNER_PHILIPS_PAL, "Philips FI1216"}, {
+	TUNER_PHILIPS_SECAM, "Philips FI1216MF"}, {
+	TUNER_PHILIPS_NTSC, "Philips FI1236"}, {
+	TUNER_PHILIPS_PAL_I, "Philips FI1246"}, {
+	TUNER_PHILIPS_PAL_DK, "Philips FI1256"}, {
+	TUNER_PHILIPS_PAL, "Philips FI1216 MK2"}, {
+	TUNER_PHILIPS_SECAM, "Philips FI1216MF MK2"},
+	    /* 10-19 */
+	{
+	TUNER_PHILIPS_NTSC, "Philips FI1236 MK2"}, {
+	TUNER_PHILIPS_PAL_I, "Philips FI1246 MK2"}, {
+	TUNER_PHILIPS_PAL_DK, "Philips FI1256 MK2"}, {
+	TUNER_TEMIC_NTSC, "Temic 4032FY5"}, {
+	TUNER_TEMIC_PAL, "Temic 4002FH5"}, {
+	TUNER_TEMIC_PAL_I, "Temic 4062FY5"}, {
+	TUNER_PHILIPS_PAL, "Philips FR1216 MK2"}, {
+	TUNER_PHILIPS_SECAM, "Philips FR1216MF MK2"}, {
+	TUNER_PHILIPS_NTSC, "Philips FR1236 MK2"}, {
+	TUNER_PHILIPS_PAL_I, "Philips FR1246 MK2"},
+	    /* 20-29 */
+	{
+	TUNER_PHILIPS_PAL_DK, "Philips FR1256 MK2"}, {
+	TUNER_PHILIPS_PAL, "Philips FM1216"}, {
+	TUNER_PHILIPS_SECAM, "Philips FM1216MF"}, {
+	TUNER_PHILIPS_NTSC, "Philips FM1236"}, {
+	TUNER_PHILIPS_PAL_I, "Philips FM1246"}, {
+	TUNER_PHILIPS_PAL_DK, "Philips FM1256"}, {
+	TUNER_TEMIC_4036FY5_NTSC, "Temic 4036FY5"}, {
+	TUNER_ABSENT, "Samsung TCPN9082D"}, {
+	TUNER_ABSENT, "Samsung TCPM9092P"}, {
+	TUNER_TEMIC_4006FH5_PAL, "Temic 4006FH5"},
+	    /* 30-39 */
+	{
+	TUNER_ABSENT, "Samsung TCPN9085D"}, {
+	TUNER_ABSENT, "Samsung TCPB9085P"}, {
+	TUNER_ABSENT, "Samsung TCPL9091P"}, {
+	TUNER_TEMIC_4039FR5_NTSC, "Temic 4039FR5"}, {
+	TUNER_PHILIPS_FQ1216ME, "Philips FQ1216 ME"}, {
+	TUNER_TEMIC_4066FY5_PAL_I, "Temic 4066FY5"}, {
+	TUNER_PHILIPS_NTSC, "Philips TD1536"}, {
+	TUNER_PHILIPS_NTSC, "Philips TD1536D"}, {
+	TUNER_PHILIPS_NTSC, "Philips FMR1236"},	/* mono radio */
+	{
+	TUNER_ABSENT, "Philips FI1256MP"},
+	    /* 40-49 */
+	{
+	TUNER_ABSENT, "Samsung TCPQ9091P"}, {
+	TUNER_TEMIC_4006FN5_MULTI_PAL, "Temic 4006FN5"}, {
+	TUNER_TEMIC_4009FR5_PAL, "Temic 4009FR5"}, {
+	TUNER_TEMIC_4046FM5, "Temic 4046FM5"}, {
+	TUNER_TEMIC_4009FN5_MULTI_PAL_FM, "Temic 4009FN5"}, {
+	TUNER_ABSENT, "Philips TD1536D FH 44"}, {
+	TUNER_LG_NTSC_FM, "LG TP18NSR01F"}, {
+	TUNER_LG_PAL_FM, "LG TP18PSB01D"}, {
+	TUNER_LG_PAL, "LG TP18PSB11D"}, {
+	TUNER_LG_PAL_I_FM, "LG TAPC-I001D"},
+	    /* 50-59 */
+	{
+	TUNER_LG_PAL_I, "LG TAPC-I701D"}, {
+	TUNER_ABSENT, "Temic 4042FI5"}, {
+	TUNER_MICROTUNE_4049FM5, "Microtune 4049 FM5"}, {
+	TUNER_ABSENT, "LG TPI8NSR11F"}, {
+	TUNER_ABSENT, "Microtune 4049 FM5 Alt I2C"}, {
+	TUNER_PHILIPS_FM1216ME_MK3, "Philips FQ1216ME MK3"}, {
+	TUNER_ABSENT, "Philips FI1236 MK3"}, {
+	TUNER_PHILIPS_FM1216ME_MK3, "Philips FM1216 ME MK3"}, {
+	TUNER_PHILIPS_FM1236_MK3, "Philips FM1236 MK3"}, {
+	TUNER_ABSENT, "Philips FM1216MP MK3"},
+	    /* 60-69 */
+	{
+	TUNER_PHILIPS_FM1216ME_MK3, "LG S001D MK3"}, {
+	TUNER_ABSENT, "LG M001D MK3"}, {
+	TUNER_ABSENT, "LG S701D MK3"}, {
+	TUNER_ABSENT, "LG M701D MK3"}, {
+	TUNER_ABSENT, "Temic 4146FM5"}, {
+	TUNER_ABSENT, "Temic 4136FY5"}, {
+	TUNER_ABSENT, "Temic 4106FH5"}, {
+	TUNER_ABSENT, "Philips FQ1216LMP MK3"}, {
+	TUNER_LG_NTSC_TAPE, "LG TAPE H001F MK3"}, {
+	TUNER_LG_NTSC_TAPE, "LG TAPE H701F MK3"},
+	    /* 70-79 */
+	{
+	TUNER_ABSENT, "LG TALN H200T"}, {
+	TUNER_ABSENT, "LG TALN H250T"}, {
+	TUNER_ABSENT, "LG TALN M200T"}, {
+	TUNER_ABSENT, "LG TALN Z200T"}, {
+	TUNER_ABSENT, "LG TALN S200T"}, {
+	TUNER_ABSENT, "Thompson DTT7595"}, {
+	TUNER_ABSENT, "Thompson DTT7592"}, {
+	TUNER_ABSENT, "Silicon TDA8275C1 8290"}, {
+	TUNER_ABSENT, "Silicon TDA8275C1 8290 FM"}, {
+	TUNER_ABSENT, "Thompson DTT757"},
+	    /* 80-89 */
+	{
+	TUNER_ABSENT, "Philips FQ1216LME MK3"}, {
+	TUNER_ABSENT, "LG TAPC G701D"}, {
+	TUNER_LG_NTSC_NEW_TAPC, "LG TAPC H791F"}, {
+	TUNER_LG_PAL_NEW_TAPC, "TCL 2002MB 3"}, {
+	TUNER_LG_PAL_NEW_TAPC, "TCL 2002MI 3"}, {
+	TUNER_TCL_2002N, "TCL 2002N 6A"}, {
+	TUNER_ABSENT, "Philips FQ1236 MK3"}, {
+	TUNER_ABSENT, "Samsung TCPN 2121P30A"}, {
+	TUNER_ABSENT, "Samsung TCPE 4121P30A"}, {
+	TUNER_PHILIPS_FM1216ME_MK3, "TCL MFPE05 2"},
+	    /* 90-99 */
+	{
+	TUNER_ABSENT, "LG TALN H202T"}, {
+	TUNER_PHILIPS_FQ1216AME_MK4, "Philips FQ1216AME MK4"}, {
+	TUNER_PHILIPS_FQ1236A_MK4, "Philips FQ1236A MK4"}, {
+	TUNER_ABSENT, "Philips FQ1286A MK4"}, {
+	TUNER_ABSENT, "Philips FQ1216ME MK5"}, {
+	TUNER_ABSENT, "Philips FQ1236 MK5"}, {
+	TUNER_ABSENT, "Unspecified"}, {
+	TUNER_LG_PAL_TAPE, "LG PAL (TAPE Series)"}, {
+	TUNER_ABSENT, "Unspecified"}, {
+	TUNER_TCL_2002N, "TCL 2002N 5H"},
+	    /* 100-103 */
+	{
+	TUNER_ABSENT, "Unspecified"}, {
+	TUNER_ABSENT, "Unspecified"}, {
+	TUNER_ABSENT, "Unspecified"}, {
+TUNER_PHILIPS_FM1236_MK3, "TCL MFNM05 4"},};
 
 static char *sndtype[] = {
 	"None", "TEA6300", "TEA6320", "TDA9850", "MSP3400C", "MSP3410D",
 	"MSP3415", "MSP3430", "MSP3438", "CS5331", "MSP3435", "MSP3440",
 	"MSP3445", "MSP3411", "MSP3416", "MSP3425",
 
-	"Type 0x10","Type 0x11","Type 0x12","Type 0x13",
-	"Type 0x14","Type 0x15","Type 0x16","Type 0x17",
-	"Type 0x18","MSP4418","Type 0x1a","MSP4448",
-	"Type 0x1c","Type 0x1d","Type 0x1e","Type 0x1f",
+	"Type 0x10", "Type 0x11", "Type 0x12", "Type 0x13",
+	"Type 0x14", "Type 0x15", "Type 0x16", "Type 0x17",
+	"Type 0x18", "MSP4418", "Type 0x1a", "MSP4448",
+	"Type 0x1c", "Type 0x1d", "Type 0x1e", "Type 0x1f",
 };
 
 static int hasRadioTuner(int tunerType)
 {
-        switch (tunerType) {
-                case 18: //PNPEnv_TUNER_FR1236_MK2:
-                case 23: //PNPEnv_TUNER_FM1236:
-                case 38: //PNPEnv_TUNER_FMR1236:
-                case 16: //PNPEnv_TUNER_FR1216_MK2:
-                case 19: //PNPEnv_TUNER_FR1246_MK2:
-                case 21: //PNPEnv_TUNER_FM1216:
-                case 24: //PNPEnv_TUNER_FM1246:
-                case 17: //PNPEnv_TUNER_FR1216MF_MK2:
-                case 22: //PNPEnv_TUNER_FM1216MF:
-                case 20: //PNPEnv_TUNER_FR1256_MK2:
-                case 25: //PNPEnv_TUNER_FM1256:
-                case 33: //PNPEnv_TUNER_4039FR5:
-                case 42: //PNPEnv_TUNER_4009FR5:
-                case 52: //PNPEnv_TUNER_4049FM5:
-                case 54: //PNPEnv_TUNER_4049FM5_AltI2C:
-                case 44: //PNPEnv_TUNER_4009FN5:
-                case 31: //PNPEnv_TUNER_TCPB9085P:
-                case 30: //PNPEnv_TUNER_TCPN9085D:
-                case 46: //PNPEnv_TUNER_TP18NSR01F:
-                case 47: //PNPEnv_TUNER_TP18PSB01D:
-                case 49: //PNPEnv_TUNER_TAPC_I001D:
-                case 60: //PNPEnv_TUNER_TAPE_S001D_MK3:
-                case 57: //PNPEnv_TUNER_FM1216ME_MK3:
-                case 59: //PNPEnv_TUNER_FM1216MP_MK3:
-                case 58: //PNPEnv_TUNER_FM1236_MK3:
-                case 68: //PNPEnv_TUNER_TAPE_H001F_MK3:
-                case 61: //PNPEnv_TUNER_TAPE_M001D_MK3:
-                case 78: //PNPEnv_TUNER_TDA8275C1_8290_FM:
-                case 89: //PNPEnv_TUNER_TCL_MFPE05_2:
-                case 92: //PNPEnv_TUNER_PHILIPS_FQ1236A_MK4:
-                    return 1;
-        }
-        return 0;
+	switch (tunerType) {
+	case 18:		//PNPEnv_TUNER_FR1236_MK2:
+	case 23:		//PNPEnv_TUNER_FM1236:
+	case 38:		//PNPEnv_TUNER_FMR1236:
+	case 16:		//PNPEnv_TUNER_FR1216_MK2:
+	case 19:		//PNPEnv_TUNER_FR1246_MK2:
+	case 21:		//PNPEnv_TUNER_FM1216:
+	case 24:		//PNPEnv_TUNER_FM1246:
+	case 17:		//PNPEnv_TUNER_FR1216MF_MK2:
+	case 22:		//PNPEnv_TUNER_FM1216MF:
+	case 20:		//PNPEnv_TUNER_FR1256_MK2:
+	case 25:		//PNPEnv_TUNER_FM1256:
+	case 33:		//PNPEnv_TUNER_4039FR5:
+	case 42:		//PNPEnv_TUNER_4009FR5:
+	case 52:		//PNPEnv_TUNER_4049FM5:
+	case 54:		//PNPEnv_TUNER_4049FM5_AltI2C:
+	case 44:		//PNPEnv_TUNER_4009FN5:
+	case 31:		//PNPEnv_TUNER_TCPB9085P:
+	case 30:		//PNPEnv_TUNER_TCPN9085D:
+	case 46:		//PNPEnv_TUNER_TP18NSR01F:
+	case 47:		//PNPEnv_TUNER_TP18PSB01D:
+	case 49:		//PNPEnv_TUNER_TAPC_I001D:
+	case 60:		//PNPEnv_TUNER_TAPE_S001D_MK3:
+	case 57:		//PNPEnv_TUNER_FM1216ME_MK3:
+	case 59:		//PNPEnv_TUNER_FM1216MP_MK3:
+	case 58:		//PNPEnv_TUNER_FM1236_MK3:
+	case 68:		//PNPEnv_TUNER_TAPE_H001F_MK3:
+	case 61:		//PNPEnv_TUNER_TAPE_M001D_MK3:
+	case 78:		//PNPEnv_TUNER_TDA8275C1_8290_FM:
+	case 89:		//PNPEnv_TUNER_TCL_MFPE05_2:
+	case 92:		//PNPEnv_TUNER_PHILIPS_FQ1236A_MK4:
+		return 1;
+	}
+	return 0;
 }
 
-void tveeprom_hauppauge_analog(struct tveeprom *tvee, unsigned char *eeprom_data)
+void tveeprom_hauppauge_analog(struct tveeprom *tvee,
+			       unsigned char *eeprom_data)
 {
 	/* ----------------------------------------------
-	** The hauppauge eeprom format is tagged
-	**
-	** if packet[0] == 0x84, then packet[0..1] == length
-	** else length = packet[0] & 3f;
-	** if packet[0] & f8 == f8, then EOD and packet[1] == checksum
-	**
-	** In our (ivtv) case we're interested in the following:
-	** tuner type: tag [00].05 or [0a].01 (index into hauppauge_tuner)
-	** tuner fmts: tag [00].04 or [0a].00 (bitmask index into hauppauge_tuner_fmt)
-	** radio:      tag [00].{last} or [0e].00  (bitmask.  bit2=FM)
-	** audio proc: tag [02].01 or [05].00 (lower nibble indexes lut?)
-
-	** Fun info:
-	** model:      tag [00].07-08 or [06].00-01
-	** revision:   tag [00].09-0b or [06].04-06
-	** serial#:    tag [01].05-07 or [04].04-06
+	 ** The hauppauge eeprom format is tagged
+	 **
+	 ** if packet[0] == 0x84, then packet[0..1] == length
+	 ** else length = packet[0] & 3f;
+	 ** if packet[0] & f8 == f8, then EOD and packet[1] == checksum
+	 **
+	 ** In our (ivtv) case we're interested in the following:
+	 ** tuner type: tag [00].05 or [0a].01 (index into hauppauge_tuner)
+	 ** tuner fmts: tag [00].04 or [0a].00 (bitmask index into hauppauge_tuner_fmt)
+	 ** radio:      tag [00].{last} or [0e].00  (bitmask.  bit2=FM)
+	 ** audio proc: tag [02].01 or [05].00 (lower nibble indexes lut?)
+
+	 ** Fun info:
+	 ** model:      tag [00].07-08 or [06].00-01
+	 ** revision:   tag [00].09-0b or [06].04-06
+	 ** serial#:    tag [01].05-07 or [04].04-06
 
-	** # of inputs/outputs ???
-	*/
+	 ** # of inputs/outputs ???
+	 */
 
 	int i, j, len, done, beenhere, tag, tuner = 0, t_format = 0;
 	char *t_name = NULL, *t_fmt_name = NULL;
 
-	dprintk(1, "%s\n",__FUNCTION__);
+	dprintk(1, "%s\n", __FUNCTION__);
 	tvee->revision = done = len = beenhere = 0;
 	for (i = 0; !done && i < 256; i += len) {
 		dprintk(2, "processing pos = %02x (%02x, %02x)\n",
@@ -291,7 +297,7 @@
 
 		if (eeprom_data[i] == 0x84) {
 			len = eeprom_data[i + 1] + (eeprom_data[i + 2] << 8);
-			i+=3;
+			i += 3;
 		} else if ((eeprom_data[i] & 0xf0) == 0x70) {
 			if ((eeprom_data[i] & 0x08)) {
 				/* verify checksum! */
@@ -301,13 +307,15 @@
 			len = eeprom_data[i] & 0x07;
 			++i;
 		} else {
-			TVEEPROM_KERN_ERR("Encountered bad packet header [%02x]. "
-				   "Corrupt or not a Hauppauge eeprom.\n", eeprom_data[i]);
+			TVEEPROM_KERN_ERR
+			    ("Encountered bad packet header [%02x]. "
+			     "Corrupt or not a Hauppauge eeprom.\n",
+			     eeprom_data[i]);
 			return;
 		}
 
 		dprintk(1, "%3d [%02x] ", len, eeprom_data[i]);
-		for(j = 1; j < len; j++) {
+		for (j = 1; j < len; j++) {
 			dprintk(1, "%02x ", eeprom_data[i + j]);
 		}
 		dprintk(1, "\n");
@@ -316,56 +324,55 @@
 		tag = eeprom_data[i];
 		switch (tag) {
 		case 0x00:
-			tuner = eeprom_data[i+6];
-			t_format = eeprom_data[i+5];
-			tvee->has_radio = eeprom_data[i+len-1];
+			tuner = eeprom_data[i + 6];
+			t_format = eeprom_data[i + 5];
+			tvee->has_radio = eeprom_data[i + len - 1];
 			tvee->model =
-				eeprom_data[i+8] +
-				(eeprom_data[i+9] << 8);
-			tvee->revision = eeprom_data[i+10] +
-				(eeprom_data[i+11] << 8) +
-				(eeprom_data[i+12] << 16);
+			    eeprom_data[i + 8] + (eeprom_data[i + 9] << 8);
+			tvee->revision = eeprom_data[i + 10] +
+			    (eeprom_data[i + 11] << 8) +
+			    (eeprom_data[i + 12] << 16);
 			break;
 		case 0x01:
 			tvee->serial_number =
-				eeprom_data[i+6] +
-				(eeprom_data[i+7] << 8) +
-				(eeprom_data[i+8] << 16);
+			    eeprom_data[i + 6] +
+			    (eeprom_data[i + 7] << 8) +
+			    (eeprom_data[i + 8] << 16);
 			break;
 		case 0x02:
-			tvee->audio_processor = eeprom_data[i+2] & 0x0f;
+			tvee->audio_processor = eeprom_data[i + 2] & 0x0f;
 			break;
 		case 0x04:
 			tvee->serial_number =
-				eeprom_data[i+5] +
-				(eeprom_data[i+6] << 8) +
-				(eeprom_data[i+7] << 16);
+			    eeprom_data[i + 5] +
+			    (eeprom_data[i + 6] << 8) +
+			    (eeprom_data[i + 7] << 16);
 			break;
 		case 0x05:
-			tvee->audio_processor = eeprom_data[i+1] & 0x0f;
+			tvee->audio_processor = eeprom_data[i + 1] & 0x0f;
 			break;
 		case 0x06:
 			tvee->model =
-				eeprom_data[i+1] +
-				(eeprom_data[i+2] << 8);
-			tvee->revision = eeprom_data[i+5] +
-				(eeprom_data[i+6] << 8) +
-				(eeprom_data[i+7] << 16);
+			    eeprom_data[i + 1] + (eeprom_data[i + 2] << 8);
+			tvee->revision = eeprom_data[i + 5] +
+			    (eeprom_data[i + 6] << 8) +
+			    (eeprom_data[i + 7] << 16);
 			break;
 		case 0x0a:
-			if(beenhere == 0) {
-				tuner = eeprom_data[i+2];
-				t_format = eeprom_data[i+1];
+			if (beenhere == 0) {
+				tuner = eeprom_data[i + 2];
+				t_format = eeprom_data[i + 1];
 				beenhere = 1;
 				break;
 			} else {
 				break;
 			}
 		case 0x0e:
-			tvee->has_radio = eeprom_data[i+1];
+			tvee->has_radio = eeprom_data[i + 1];
 			break;
 		default:
-			dprintk(1, "Not sure what to do with tag [%02x]\n", tag);
+			dprintk(1, "Not sure what to do with tag [%02x]\n",
+				tag);
 			/* dump the rest of the packet? */
 		}
 
@@ -379,18 +386,20 @@
 	if (tvee->revision != 0) {
 		tvee->rev_str[0] = 32 + ((tvee->revision >> 18) & 0x3f);
 		tvee->rev_str[1] = 32 + ((tvee->revision >> 12) & 0x3f);
-		tvee->rev_str[2] = 32 + ((tvee->revision >>  6) & 0x3f);
-		tvee->rev_str[3] = 32 + ( tvee->revision        & 0x3f);
+		tvee->rev_str[2] = 32 + ((tvee->revision >> 6) & 0x3f);
+		tvee->rev_str[3] = 32 + (tvee->revision & 0x3f);
 		tvee->rev_str[4] = 0;
 	}
 
-        if (hasRadioTuner(tuner) && !tvee->has_radio) {
-	    TVEEPROM_KERN_INFO("The eeprom says no radio is present, but the tuner type\n");
-	    TVEEPROM_KERN_INFO("indicates otherwise. I will assume that radio is present.\n");
-            tvee->has_radio = 1;
-        }
+	if (hasRadioTuner(tuner) && !tvee->has_radio) {
+		TVEEPROM_KERN_INFO
+		    ("The eeprom says no radio is present, but the tuner type\n");
+		TVEEPROM_KERN_INFO
+		    ("indicates otherwise. I will assume that radio is present.\n");
+		tvee->has_radio = 1;
+	}
 
-	if (tuner < sizeof(hauppauge_tuner)/sizeof(struct HAUPPAUGE_TUNER)) {
+	if (tuner < sizeof(hauppauge_tuner) / sizeof(struct HAUPPAUGE_TUNER)) {
 		tvee->tuner_type = hauppauge_tuner[tuner].id;
 		t_name = hauppauge_tuner[tuner].name;
 	} else {
@@ -400,7 +409,7 @@
 	tvee->tuner_formats = 0;
 	t_fmt_name = "<none>";
 	for (i = 0; i < 8; i++) {
-		if (t_format & (1<<i)) {
+		if (t_format & (1 << i)) {
 			tvee->tuner_formats |= hauppauge_tuner_fmt[i].id;
 			/* yuck */
 			t_fmt_name = hauppauge_tuner_fmt[i].name;
@@ -409,23 +418,18 @@
 
 
 	TVEEPROM_KERN_INFO("Hauppauge: model = %d, rev = %s, serial# = %d\n",
-		   tvee->model,
-		   tvee->rev_str,
-		   tvee->serial_number);
+			   tvee->model, tvee->rev_str, tvee->serial_number);
 	TVEEPROM_KERN_INFO("tuner = %s (idx = %d, type = %d)\n",
-		   t_name,
-		   tuner,
-		   tvee->tuner_type);
+			   t_name, tuner, tvee->tuner_type);
 	TVEEPROM_KERN_INFO("tuner fmt = %s (eeprom = 0x%02x, v4l2 = 0x%08x)\n",
-		   t_fmt_name,
-		   t_format,
-		   tvee->tuner_formats);
+			   t_fmt_name, t_format, tvee->tuner_formats);
 
 	TVEEPROM_KERN_INFO("audio_processor = %s (type = %d)\n",
-		   STRM(sndtype,tvee->audio_processor),
-		   tvee->audio_processor);
+			   STRM(sndtype, tvee->audio_processor),
+			   tvee->audio_processor);
 
 }
+
 EXPORT_SYMBOL(tveeprom_hauppauge_analog);
 
 /* ----------------------------------------------------------------------- */
@@ -436,20 +440,23 @@
 	unsigned char buf;
 	int err;
 
-	dprintk(1, "%s\n",__FUNCTION__);
+	dprintk(1, "%s\n", __FUNCTION__);
 	buf = 0;
-	if (1 != (err = i2c_master_send(c,&buf,1))) {
-		printk(KERN_INFO "tveeprom(%s): Huh, no eeprom present (err=%d)?\n",
-		       c->name,err);
+	if (1 != (err = i2c_master_send(c, &buf, 1))) {
+		printk(KERN_INFO
+		       "tveeprom(%s): Huh, no eeprom present (err=%d)?\n",
+		       c->name, err);
 		return -1;
 	}
-	if (len != (err = i2c_master_recv(c,eedata,len))) {
-		printk(KERN_WARNING "tveeprom(%s): i2c eeprom read error (err=%d)\n",
-		       c->name,err);
+	if (len != (err = i2c_master_recv(c, eedata, len))) {
+		printk(KERN_WARNING
+		       "tveeprom(%s): i2c eeprom read error (err=%d)\n",
+		       c->name, err);
 		return -1;
 	}
 	return 0;
 }
+
 EXPORT_SYMBOL(tveeprom_read);
 
 
@@ -467,14 +474,13 @@
 	I2C_CLIENT_END,
 };
 
+
 I2C_CLIENT_INSMOD;
 
 static struct i2c_driver i2c_driver_tveeprom;
 
 static int
-tveeprom_command(struct i2c_client *client,
-		 unsigned int       cmd,
-		 void              *arg)
+tveeprom_command(struct i2c_client *client, unsigned int cmd, void *arg)
 {
 	struct tveeprom eeprom;
 	u32 *eeprom_props = arg;
@@ -482,10 +488,10 @@
 
 	switch (cmd) {
 	case 0:
-		buf = kmalloc(256,GFP_KERNEL);
-		memset(buf,0,256);
-		tveeprom_read(client,buf,256);
-		tveeprom_hauppauge_analog(&eeprom,buf);
+		buf = kmalloc(256, GFP_KERNEL);
+		memset(buf, 0, 256);
+		tveeprom_read(client, buf, 256);
+		tveeprom_hauppauge_analog(&eeprom, buf);
 		kfree(buf);
 		eeprom_props[0] = eeprom.tuner_type;
 		eeprom_props[1] = eeprom.tuner_formats;
@@ -500,14 +506,12 @@
 }
 
 static int
-tveeprom_detect_client(struct i2c_adapter *adapter,
-		       int                 address,
-		       int                 kind)
+tveeprom_detect_client(struct i2c_adapter *adapter, int address, int kind)
 {
 	struct i2c_client *client;
 
-	dprintk(1,"%s: id 0x%x @ 0x%x\n",__FUNCTION__,
-	       adapter->id, address << 1);
+	dprintk(1, "%s: id 0x%x @ 0x%x\n", __FUNCTION__,
+		adapter->id, address << 1);
 	client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
 	if (NULL == client)
 		return -ENOMEM;
@@ -517,21 +521,19 @@
 	client->driver = &i2c_driver_tveeprom;
 	client->flags = I2C_CLIENT_ALLOW_USE;
 	snprintf(client->name, sizeof(client->name), "tveeprom");
-        i2c_attach_client(client);
+	i2c_attach_client(client);
 	return 0;
 }
 
-static int
-tveeprom_attach_adapter (struct i2c_adapter *adapter)
+static int tveeprom_attach_adapter(struct i2c_adapter *adapter)
 {
-	dprintk(1,"%s: id 0x%x\n",__FUNCTION__,adapter->id);
+	dprintk(1, "%s: id 0x%x\n", __FUNCTION__, adapter->id);
 	if (adapter->id != (I2C_ALGO_BIT | I2C_HW_B_BT848))
 		return 0;
 	return i2c_probe(adapter, &addr_data, tveeprom_detect_client);
 }
 
-static int
-tveeprom_detach_client (struct i2c_client *client)
+static int tveeprom_detach_client(struct i2c_client *client)
 {
 	int err;
 
@@ -543,13 +545,13 @@
 }
 
 static struct i2c_driver i2c_driver_tveeprom = {
-	.owner          = THIS_MODULE,
-	.name           = "tveeprom",
-	.id             = I2C_DRIVERID_TVEEPROM,
-	.flags          = I2C_DF_NOTIFY,
+	.owner = THIS_MODULE,
+	.name = "tveeprom",
+	.id = I2C_DRIVERID_TVEEPROM,
+	.flags = I2C_DF_NOTIFY,
 	.attach_adapter = tveeprom_attach_adapter,
-	.detach_client  = tveeprom_detach_client,
-	.command        = tveeprom_command,
+	.detach_client = tveeprom_detach_client,
+	.command = tveeprom_command,
 };
 
 static int __init tveeprom_init(void)

--=_431cb7f7.9wH4LsIqQgekvmCH6/XZLSxa56rTbf05BSHJ02NQap4jslnE--
