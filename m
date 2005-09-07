Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbVIGLtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbVIGLtu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 07:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbVIGLtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 07:49:50 -0400
Received: from smtp1.brturbo.com.br ([200.199.201.163]:59339 "EHLO
	smtp1.brturbo.com.br") by vger.kernel.org with ESMTP
	id S1751157AbVIGLtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 07:49:50 -0400
Subject: [PATCH 1/2] V4L: TVaudio cleanup and better degug messages
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux and Kernel Video <video4linux-list@redhat.com>,
       Andrew Morton <akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-ODZnKcmVMvHovzpN2WHI"
Date: Wed, 07 Sep 2005 08:49:45 -0300
Message-Id: <1126093786.5784.13.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3-8mdk 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ODZnKcmVMvHovzpN2WHI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit




--=-ODZnKcmVMvHovzpN2WHI
Content-Disposition: attachment; filename=v4l_fixup_tvaudio.diff
Content-Type: text/x-patch; name=v4l_fixup_tvaudio.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

- adds the adapter number + i2c address to printk msgs.
- Some CodingStyle cleanups.

Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

 linux/drivers/media/video/tvaudio.c |  206 +++++++++++++++-------------
 1 files changed, 112 insertions(+), 94 deletions(-)

diff -u /tmp/dst.20048 linux/drivers/media/video/tvaudio.c
--- /tmp/dst.20048	2005-09-07 07:53:38.000000000 -0300
+++ linux/drivers/media/video/tvaudio.c	2005-09-07 07:53:38.000000000 -0300
@@ -46,7 +46,17 @@ MODULE_AUTHOR("Eric Sandeen, Steve VanDe
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
@@ -162,23 +172,24 @@ static int chip_write(struct CHIPSTATE *
 	unsigned char buffer[2];
 
 	if (-1 == subaddr) {
-		dprintk("%s: chip_write: 0x%x\n", chip->c.name, val);
+		tvaudio_dbg("%s: chip_write: 0x%x\n",
+			chip->c.name, val);
 		chip->shadow.bytes[1] = val;
 		buffer[0] = val;
 		if (1 != i2c_master_send(&chip->c,buffer,1)) {
-			printk(KERN_WARNING "%s: I/O error (write 0x%x)\n",
-			       chip->c.name, val);
+			tvaudio_warn("%s: I/O error (write 0x%x)\n",
+				chip->c.name, val);
 			return -1;
 		}
 	} else {
-		dprintk("%s: chip_write: reg%d=0x%x\n",
+		tvaudio_dbg("%s: chip_write: reg%d=0x%x\n",
 			chip->c.name, subaddr, val);
 		chip->shadow.bytes[subaddr+1] = val;
 		buffer[0] = subaddr;
 		buffer[1] = val;
 		if (2 != i2c_master_send(&chip->c,buffer,2)) {
-			printk(KERN_WARNING "%s: I/O error (write reg%d=0x%x)\n",
-			       chip->c.name, subaddr, val);
+			tvaudio_warn("%s: I/O error (write reg%d=0x%x)\n",
+						chip->c.name, subaddr, val);
 			return -1;
 		}
 	}
@@ -202,29 +213,30 @@ static int chip_read(struct CHIPSTATE *c
 	unsigned char buffer;
 
 	if (1 != i2c_master_recv(&chip->c,&buffer,1)) {
-		printk(KERN_WARNING "%s: I/O error (read)\n", chip->c.name);
+		tvaudio_warn("%s: I/O error (read)\n",
+		chip->c.name);
 		return -1;
 	}
-	dprintk("%s: chip_read: 0x%x\n", chip->c.name, buffer);
+	tvaudio_dbg("%s: chip_read: 0x%x\n",chip->c.name,buffer);
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
-		printk(KERN_WARNING "%s: I/O error (read2)\n", chip->c.name);
+		tvaudio_warn("%s: I/O error (read2)\n", chip->c.name);
 		return -1;
 	}
-	dprintk("%s: chip_read2: reg%d=0x%x\n",
-		chip->c.name, subaddr, read[0]);
+	tvaudio_dbg("%s: chip_read2: reg%d=0x%x\n",
+			chip->c.name,subaddr,read[0]);
 	return read[0];
 }
 
@@ -236,17 +248,19 @@ static int chip_cmd(struct CHIPSTATE *ch
 		return 0;
 
 	/* update our shadow register set; print bytes if (debug > 0) */
-	dprintk("%s: chip_cmd(%s): reg=%d, data:",
-		chip->c.name, name, cmd->bytes[0]);
+	tvaudio_dbg("%s: chip_cmd(%s): reg=%d, data:",
+		chip->c.name,name,cmd->bytes[0]);
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
-		printk(KERN_WARNING "%s: I/O error (%s)\n", chip->c.name, name);
+		tvaudio_warn("%s: I/O error (%s)\n", chip->c.name, name);
 		return -1;
 	}
 	return 0;
@@ -261,19 +275,19 @@ static int chip_cmd(struct CHIPSTATE *ch
 
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
 
 	daemonize("%s", chip->c.name);
 	allow_signal(SIGTERM);
-	dprintk("%s: thread started\n", chip->c.name);
+	tvaudio_dbg("%s: thread started\n", chip->c.name);
 
 	for (;;) {
 		add_wait_queue(&chip->wq, &wait);
@@ -285,7 +299,7 @@ static int chip_thread(void *data)
 		try_to_freeze();
 		if (chip->done || signal_pending(current))
 			break;
-		dprintk("%s: thread wakeup\n", chip->c.name);
+		tvaudio_dbg("%s: thread wakeup\n", chip->c.name);
 
 		/* don't do anything for radio or if mode != auto */
 		if (chip->norm == VIDEO_MODE_RADIO || chip->mode != 0)
@@ -298,8 +312,8 @@ static int chip_thread(void *data)
 		mod_timer(&chip->wt, jiffies+2*HZ);
 	}
 
-	dprintk("%s: thread exiting\n", chip->c.name);
-        complete_and_exit(&chip->texit, 0);
+	tvaudio_dbg("%s: thread exiting\n", chip->c.name);
+	complete_and_exit(&chip->texit, 0);
 	return 0;
 }
 
@@ -309,9 +323,9 @@ static void generic_checkmode(struct CHI
 	int mode = desc->getmode(chip);
 
 	if (mode == chip->prevmode)
-	    return;
+		return;
 
-	dprintk("%s: thread checkmode\n", chip->c.name);
+	tvaudio_dbg("%s: thread checkmode\n", chip->c.name);
 	chip->prevmode = mode;
 
 	if (mode & VIDEO_SOUND_STEREO)
@@ -358,8 +372,8 @@ static int tda9840_getmode(struct CHIPST
 	if (val & TDA9840_ST_STEREO)
 		mode |= VIDEO_SOUND_STEREO;
 
-	dprintk ("tda9840_getmode(): raw chip read: %d, return: %d\n",
-		 val, mode);
+	tvaudio_dbg ("tda9840_getmode(): raw chip read: %d, return: %d\n",
+		val, mode);
 	return mode;
 }
 
@@ -654,8 +668,8 @@ static int tda9873_getmode(struct CHIPST
 		mode |= VIDEO_SOUND_STEREO;
 	if (val & TDA9873_DUAL)
 		mode |= VIDEO_SOUND_LANG1 | VIDEO_SOUND_LANG2;
-	dprintk ("tda9873_getmode(): raw chip read: %d, return: %d\n",
-		 val, mode);
+	tvaudio_dbg ("tda9873_getmode(): raw chip read: %d, return: %d\n",
+		val, mode);
 	return mode;
 }
 
@@ -665,12 +679,12 @@ static void tda9873_setmode(struct CHIPS
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
@@ -691,7 +705,7 @@ static void tda9873_setmode(struct CHIPS
 	}
 
 	chip_write(chip, TDA9873_SW, sw_data);
-	dprintk("tda9873_setmode(): req. mode %d; chip_write: %d\n",
+	tvaudio_dbg("tda9873_setmode(): req. mode %d; chip_write: %d\n",
 		mode, sw_data);
 }
 
@@ -828,9 +842,9 @@ static int tda9874a_setup(struct CHIPSTA
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
@@ -873,7 +887,7 @@ static int tda9874a_getmode(struct CHIPS
 			mode |= VIDEO_SOUND_LANG1 | VIDEO_SOUND_LANG2;
 	}
 
-	dprintk("tda9874a_getmode(): DSR=0x%X, NSR=0x%X, NECR=0x%X, return: %d.\n",
+	tvaudio_dbg("tda9874a_getmode(): DSR=0x%X, NSR=0x%X, NECR=0x%X, return: %d.\n",
 		 dsr, nsr, necr, mode);
 	return mode;
 }
@@ -919,7 +933,7 @@ static void tda9874a_setmode(struct CHIP
 		chip_write(chip, TDA9874A_AOSR, aosr);
 		chip_write(chip, TDA9874A_MDACOSR, mdacosr);
 
-		dprintk("tda9874a_setmode(): req. mode %d; AOSR=0x%X, MDACOSR=0x%X.\n",
+		tvaudio_dbg("tda9874a_setmode(): req. mode %d; AOSR=0x%X, MDACOSR=0x%X.\n",
 			mode, aosr, mdacosr);
 
 	} else { /* dic == 0x07 */
@@ -954,7 +968,7 @@ static void tda9874a_setmode(struct CHIP
 		chip_write(chip, TDA9874A_FMMR, fmmr);
 		chip_write(chip, TDA9874A_AOSR, aosr);
 
-		dprintk("tda9874a_setmode(): req. mode %d; FMMR=0x%X, AOSR=0x%X.\n",
+		tvaudio_dbg("tda9874a_setmode(): req. mode %d; FMMR=0x%X, AOSR=0x%X.\n",
 			mode, fmmr, aosr);
 	}
 }
@@ -968,10 +982,10 @@ static int tda9874a_checkit(struct CHIPS
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
@@ -1146,7 +1160,7 @@ static void tda8425_setmode(struct CHIPS
 /* ---------------------------------------------------------------------- */
 /* audio chip descriptions - defines+functions for TA8874Z                */
 
-// write 1st byte
+/* write 1st byte */
 #define TA8874Z_LED_STE	0x80
 #define TA8874Z_LED_BIL	0x40
 #define TA8874Z_LED_EXT	0x20
@@ -1156,21 +1170,22 @@ static void tda8425_setmode(struct CHIPS
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
@@ -1182,7 +1197,7 @@ static int ta8874z_getmode(struct CHIPST
 	}else if (!(val & TA8874Z_B0)){
 		mode |= VIDEO_SOUND_STEREO;
 	}
-	//dprintk ("ta8874z_getmode(): raw chip read: 0x%02x, return: 0x%02x\n", val, mode);
+	/* tvaudio_dbg ("ta8874z_getmode(): raw chip read: 0x%02x, return: 0x%02x\n", val, mode); */
 	return mode;
 }
 
@@ -1195,7 +1210,7 @@ static void ta8874z_setmode(struct CHIPS
 {
 	int update = 1;
 	audiocmd *t = NULL;
-	dprintk("ta8874z_setmode(): mode: 0x%02x\n", mode);
+	tvaudio_dbg("ta8874z_setmode(): mode: 0x%02x\n", mode);
 
 	switch(mode){
 	case VIDEO_SOUND_MONO:
@@ -1235,11 +1250,11 @@ static int tda9850  = 1;
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
@@ -1441,7 +1456,7 @@ static struct CHIPDESC chiplist[] = {
 	{
 		.name       = "ta8874z",
 		.id         = -1,
-		//.id         = I2C_DRIVERID_TA8874Z,
+		/*.id         = I2C_DRIVERID_TA8874Z, */
 		.checkit    = ta8874z_checkit,
 		.insmodopt  = &ta8874z,
 		.addr_lo    = I2C_TDA9840 >> 1,
@@ -1476,7 +1491,7 @@ static int chip_attach(struct i2c_adapte
 	i2c_set_clientdata(&chip->c, chip);
 
 	/* find description for the chip */
-	dprintk("tvaudio: chip found @ i2c-addr=0x%x\n", addr<<1);
+	tvaudio_dbg("chip found @ 0x%x\n", addr<<1);
 	for (desc = chiplist; desc->name != NULL; desc++) {
 		if (0 == *(desc->insmodopt))
 			continue;
@@ -1488,17 +1503,19 @@ static int chip_attach(struct i2c_adapte
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
-	strcpy(chip->c.name, desc->name);
+	strcpy(chip->c.name,desc->name);
 	chip->type = desc-chiplist;
 	chip->shadow.count = desc->registers+1;
         chip->prevmode = -1;
@@ -1534,7 +1551,7 @@ static int chip_attach(struct i2c_adapte
 		init_completion(&chip->texit);
 		chip->tpid = kernel_thread(chip_thread,(void *)chip,0);
 		if (chip->tpid < 0)
-			printk(KERN_WARNING "%s: kernel_thread() failed\n",
+			tvaudio_warn("%s: kernel_thread() failed\n",
 			       chip->c.name);
 		wake_up_interruptible(&chip->wq);
 	}
@@ -1545,7 +1562,7 @@ static int chip_probe(struct i2c_adapter
 {
 	/* don't attach on saa7146 based cards,
 	   because dedicated drivers are used */
-	if (adap->id == I2C_HW_SAA7146)
+	if ((adap->id == I2C_HW_SAA7146))
 		return 0;
 #ifdef I2C_CLASS_TV_ANALOG
 	if (adap->class & I2C_CLASS_TV_ANALOG)
@@ -1584,11 +1601,11 @@ static int chip_detach(struct i2c_client
 static int chip_command(struct i2c_client *client,
 			unsigned int cmd, void *arg)
 {
-        __u16 *sarg = arg;
+	__u16 *sarg = arg;
 	struct CHIPSTATE *chip = i2c_get_clientdata(client);
 	struct CHIPDESC  *desc = chiplist + chip->type;
 
-	dprintk("%s: chip_command 0x%x\n", chip->c.name, cmd);
+	tvaudio_dbg("%s: chip_command 0x%x\n",chip->c.name,cmd);
 
 	switch (cmd) {
 	case AUDC_SET_INPUT:
@@ -1601,7 +1618,6 @@ static int chip_command(struct i2c_clien
 		break;
 
 	case AUDC_SET_RADIO:
-		dprintk(KERN_DEBUG "tvaudio: AUDC_SET_RADIO\n");
 		chip->norm = VIDEO_MODE_RADIO;
 		chip->watch_stereo = 0;
 		/* del_timer(&chip->wt); */
@@ -1609,7 +1625,7 @@ static int chip_command(struct i2c_clien
 
 	/* --- v4l ioctls --- */
 	/* take care: bttv does userspace copying, we'll get a
-	   kernel pointer here... */
+					kernel pointer here... */
 	case VIDIOCGAUDIO:
 	{
 		struct video_audio *va = arg;
@@ -1643,9 +1659,9 @@ static int chip_command(struct i2c_clien
 
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
@@ -1667,17 +1683,16 @@ static int chip_command(struct i2c_clien
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
@@ -1689,29 +1704,32 @@ static int chip_command(struct i2c_clien
 
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
 	.name       = "(unset)",
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

--=-ODZnKcmVMvHovzpN2WHI--

