Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271324AbUJVNLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271324AbUJVNLI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 09:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271310AbUJVNKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 09:10:19 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:2737 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S271313AbUJVNAb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 09:00:31 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Fri, 22 Oct 2004 14:51:01 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: tuner update
Message-ID: <20041022125101.GA5364@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This is an update for the v4l tuner modules (tuner.o + tda9887.o).
Changes:

  * fix two tuner config entries.
  * switch insmod options to new 2.6-ish style.
  * add suspend/resume functions.

The patch also removes all trailing whitespaces.  I've a script
to remove them from my sources now, that should kill those no-op
whitespace changes in my patches after merging this initial cleanup.

  Gerd

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 drivers/media/video/tda9887.c |   31 +++++-
 drivers/media/video/tuner.c   |  169 ++++++++++++++++++++--------------
 include/media/tuner.h         |    2 
 3 files changed, 131 insertions(+), 71 deletions(-)

Index: linux-2004-10-20/include/media/tuner.h
===================================================================
--- linux-2004-10-20.orig/include/media/tuner.h	2004-10-21 11:44:59.000000000 +0200
+++ linux-2004-10-20/include/media/tuner.h	2004-10-21 14:59:24.000000000 +0200
@@ -1,5 +1,5 @@
 
-/* 
+/*
     tuner.h - definition for different tuners
 
     Copyright (C) 1997 Markus Schroeder (schroedm@uni-duesseldorf.de)
Index: linux-2004-10-20/drivers/media/video/tuner.c
===================================================================
--- linux-2004-10-20.orig/drivers/media/video/tuner.c	2004-10-21 11:45:23.000000000 +0200
+++ linux-2004-10-20/drivers/media/video/tuner.c	2004-10-21 15:38:19.311450244 +0200
@@ -1,4 +1,9 @@
+/*
+ * $Id: tuner.c,v 1.27 2004/10/20 09:43:34 kraxel Exp $
+ */
+
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/string.h>
@@ -15,30 +20,34 @@
 #include <media/tuner.h>
 #include <media/audiochip.h>
 
-/* Addresses to scan */
+#define UNSET (-1U)
+
+/* standard i2c insmod options */
 static unsigned short normal_i2c[] = {I2C_CLIENT_END};
 static unsigned short normal_i2c_range[] = {0x60,0x6f,I2C_CLIENT_END};
 I2C_CLIENT_INSMOD;
 
-#define UNSET (-1U)
-
-/* insmod options */
-static unsigned int debug =  0;
+/* insmod options used at init time => read/only */
 static unsigned int type  =  UNSET;
 static unsigned int addr  =  0;
+module_param(type, int, 444);
+module_param(addr, int, 444);
+
+/* insmod options used at runtime => read/write */
+static unsigned int debug         = 0;
+static unsigned int tv_antenna    = 1;
+static unsigned int radio_antenna = 0;
+static unsigned int optimize_vco  = 1;
+module_param(debug,             int, 644);
+module_param(tv_antenna,        int, 644);
+module_param(radio_antenna,     int, 644);
+module_param(optimize_vco,      int, 644);
+
 static unsigned int tv_range[2]    = { 44, 958 };
 static unsigned int radio_range[2] = { 65, 108 };
-static unsigned int tv_antenna = 1;
-static unsigned int radio_antenna = 0;
-MODULE_PARM(debug,"i");
-MODULE_PARM(type,"i");
-MODULE_PARM(addr,"i");
-MODULE_PARM(tv_range,"2i");
-MODULE_PARM(radio_range,"2i");
-MODULE_PARM(tv_antenna,"i");
-MODULE_PARM(radio_antenna,"i");
 
-#define optimize_vco 1
+module_param_array(tv_range,    int, NULL, 644);
+module_param_array(radio_range, int, NULL, 644);
 
 MODULE_DESCRIPTION("device driver for various TV and TV+FM radio tuners");
 MODULE_AUTHOR("Ralph Metzler, Gerd Knorr, Gunther Mayer");
@@ -52,10 +61,10 @@ struct tuner {
 	unsigned int freq;            /* keep track of the current settings */
 	v4l2_std_id  std;
 	int          using_v4l2;
-	
+
 	unsigned int radio;
 	unsigned int input;
-	
+
 	// only for MT2032
 	unsigned int xogc;
 	unsigned int radio_if2;
@@ -71,11 +80,11 @@ static struct i2c_client client_template
 
 /* tv standard selection for Temic 4046 FM5
    this value takes the low bits of control byte 2
-   from datasheet Rev.01, Feb.00 
+   from datasheet Rev.01, Feb.00
      standard     BG      I       L       L2      D
      picture IF   38.9    38.9    38.9    33.95   38.9
      sound 1      33.4    32.9    32.4    40.45   32.4
-     sound 2      33.16   
+     sound 2      33.16
      NICAM        33.05   32.348  33.05           33.05
  */
 #define TEMIC_SET_PAL_I         0x05
@@ -97,7 +106,7 @@ static struct i2c_client client_template
 #define PHILIPS_SET_PAL_I	0x01 /* Bit 2 always zero !*/
 #define PHILIPS_SET_PAL_BGDK	0x09
 #define PHILIPS_SET_PAL_L2	0x0a
-#define PHILIPS_SET_PAL_L	0x0b	
+#define PHILIPS_SET_PAL_L	0x0b
 
 /* system switching for Philips FI1216MF MK2
    from datasheet "1996 Jul 09",
@@ -115,20 +124,20 @@ static struct i2c_client client_template
 
 /* ---------------------------------------------------------------------- */
 
-struct tunertype 
+struct tunertype
 {
 	char *name;
 	unsigned char Vendor;
 	unsigned char Type;
-  
+
 	unsigned short thresh1;  /*  band switch VHF_LO <=> VHF_HI  */
 	unsigned short thresh2;  /*  band switch VHF_HI <=> UHF     */
 	unsigned char VHF_L;
 	unsigned char VHF_H;
 	unsigned char UHF;
-	unsigned char config; 
-	unsigned short IFPCoff; /* 622.4=16*38.90 MHz PAL, 
-				   732  =16*45.75 NTSCi, 
+	unsigned char config;
+	unsigned short IFPCoff; /* 622.4=16*38.90 MHz PAL,
+				   732  =16*45.75 NTSCi,
 				   940  =16*58.75 NTSC-Japan
 				   704  =16*44    ATSC */
 };
@@ -171,7 +180,7 @@ static struct tunertype tuners[] = {
         { "Alps TSBC5", Alps, PAL, /* untested - data sheet guess. Only IF differs. */
 	  16*133.25,16*351.25,0x01,0x02,0x08,0x8e,608},
 	{ "Temic PAL_BG (4006FH5)", TEMIC, PAL,
-	  16*170.00,16*450.00,0xa0,0x90,0x30,0x8e,623}, 
+	  16*170.00,16*450.00,0xa0,0x90,0x30,0x8e,623},
   	{ "Alps TSCH6",Alps,NTSC,
   	  16*137.25,16*385.25,0x14,0x12,0x11,0x8e,732},
 
@@ -245,14 +254,14 @@ static struct tunertype tuners[] = {
 	{ "Panasonic VP27s/ENGE4324D", Panasonic, NTSC,
 	  16*160.00,16*454.00,0x01,0x02,0x08,0xce,940},
         { "LG NTSC (TAPE series)", LGINNOTEK, NTSC,
-          16*160.00,16*442.00,0x01,0x02,0x04,0xc8,732 },
+          16*160.00,16*442.00,0x01,0x02,0x04,0x8e,732 },
 
         { "Tenna TNF 8831 BGFF)", Philips, PAL,
           16*161.25,16*463.25,0xa0,0x90,0x30,0x8e,623},
 	{ "Microtune 4042 FI5 ATSC/NTSC dual in", Microtune, NTSC,
 	  16*162.00,16*457.00,0xa2,0x94,0x31,0x8e,732},
         { "TCL 2002N", TCL, NTSC,
-          16*172.00,16*448.00,0x01,0x02,0x08,0x88,732},
+          16*172.00,16*448.00,0x01,0x02,0x08,0x8e,732},
 
 };
 #define TUNERS ARRAY_SIZE(tuners)
@@ -421,7 +430,7 @@ static int mt2032_compute_freq(unsigned 
  	if(rfin >400*1000*1000)
                 buf[6]=0xe4;
         else
-                buf[6]=0xf4; // set PKEN per rev 1.2 
+                buf[6]=0xf4; // set PKEN per rev 1.2
 	buf[7]=8+xogc;
 	buf[8]=0xc3; //reserved
 	buf[9]=0x4e; //reserved
@@ -442,10 +451,10 @@ static int mt2032_check_lo_lock(struct i
 		i2c_master_recv(c,buf,1);
 		dprintk("mt2032 Reg.E=0x%02x\n",buf[0]);
 		lock=buf[0] &0x06;
-		
+
 		if (lock==6)
 			break;
-		
+
 		dprintk("mt2032: pll wait 1ms for lock (0x%2x)\n",buf[0]);
 		udelay(1000);
 	}
@@ -467,7 +476,7 @@ static int mt2032_optimize_vco(struct i2
 	if(tad1 ==1) return lock;
 
 	if(tad1==2) {
-		if(sel==0) 
+		if(sel==0)
 			return lock;
 		else sel--;
 	}
@@ -520,13 +529,13 @@ static void mt2032_set_if_freq(struct i2
 	// wait for PLLs to lock (per manual), retry LINT if not.
 	for(lint_try=0; lint_try<2; lint_try++) {
 		lock=mt2032_check_lo_lock(c);
-		
+
 		if(optimize_vco)
 			lock=mt2032_optimize_vco(c,sel,lock);
 		if(lock==6) break;
-		
-		printk("mt2032: re-init PLLs by LINT\n"); 
-		buf[0]=7; 
+
+		printk("mt2032: re-init PLLs by LINT\n");
+		buf[0]=7;
 		buf[1]=0x80 +8+t->xogc; // set LINT to re-init PLLs
 		i2c_master_send(c,buf,2);
 		mdelay(10);
@@ -651,46 +660,46 @@ static void mt2050_set_if_freq(struct i2
 	unsigned int f_lo1,f_lo2,lo1,lo2,f_lo1_modulo,f_lo2_modulo,num1,num2,div1a,div1b,div2a,div2b;
 	int ret;
 	unsigned char buf[6];
-	
+
 	dprintk("mt2050_set_if_freq freq=%d\n",freq);
-	
+
 	f_lo1=freq+if1;
 	f_lo1=(f_lo1/1000000)*1000000;
-	
+
 	f_lo2=f_lo1-freq-if2;
 	f_lo2=(f_lo2/50000)*50000;
-	
+
 	lo1=f_lo1/4000000;
 	lo2=f_lo2/4000000;
-	
+
 	f_lo1_modulo= f_lo1-(lo1*4000000);
 	f_lo2_modulo= f_lo2-(lo2*4000000);
-	
+
 	num1=4*f_lo1_modulo/4000000;
 	num2=4096*(f_lo2_modulo/1000)/4000;
-	
+
 	// todo spurchecks
-	
+
 	div1a=(lo1/12)-1;
 	div1b=lo1-(div1a+1)*12;
-	
+
 	div2a=(lo2/8)-1;
 	div2b=lo2-(div2a+1)*8;
-	
+
 	dprintk("lo1 lo2 = %d %d\n", lo1, lo2);
         dprintk("num1 num2 div1a div1b div2a div2b= %x %x %x %x %x %x\n",num1,num2,div1a,div1b,div2a,div2b);
-	
-	
+
+
 	buf[0]=1;
 	buf[1]= 4*div1b + num1;
 	if(freq<275*1000*1000) buf[1] = buf[1]|0x80;
-	
+
 	buf[2]=div1a;
 	buf[3]=32*div2b + num2/256;
 	buf[4]=num2-(num2/256)*256;
 	buf[5]=div2a;
 	if(num2!=0) buf[5]=buf[5]|0x40;
-	
+
 	if(debug) {
 		int i;
 		printk("bufs is: ");
@@ -698,7 +707,7 @@ static void mt2050_set_if_freq(struct i2
 			printk("%x ",buf[i]);
 		printk("\n");
 	}
-	
+
 	ret=i2c_master_send(c,buf,6);
         if (ret!=6)
                 printk("mt2050_set_if_freq failed with %d\n",ret);
@@ -708,7 +717,7 @@ static void mt2050_set_tv_freq(struct i2
 {
 	struct tuner *t = i2c_get_clientdata(c);
 	unsigned int if2;
-	
+
 	if (t->std & V4L2_STD_525_60) {
 		// NTSC
                 if2 = 45750*1000;
@@ -724,7 +733,7 @@ static void mt2050_set_radio_freq(struct
 {
 	struct tuner *t = i2c_get_clientdata(c);
 	int if2 = t->radio_if2;
-	
+
 	mt2050_set_if_freq(c, freq*62500, if2);
 	mt2050_set_antenna(c, radio_antenna);
 }
@@ -734,19 +743,19 @@ static int mt2050_init(struct i2c_client
 	struct tuner *t = i2c_get_clientdata(c);
 	unsigned char buf[2];
 	int ret;
-	
+
 	buf[0]=6;
 	buf[1]=0x10;
 	ret=i2c_master_send(c,buf,2); //  power
-	
+
 	buf[0]=0x0f;
 	buf[1]=0x0f;
 	ret=i2c_master_send(c,buf,2); // m1lo
-	
+
 	buf[0]=0x0d;
 	ret=i2c_master_send(c,buf,1);
 	i2c_master_recv(c,buf,1);
-	
+
 	dprintk("mt2050: sro is %x\n",buf[0]);
 	t->tv_freq    = mt2050_set_tv_freq;
 	t->radio_freq = mt2050_set_radio_freq;
@@ -759,7 +768,7 @@ static int microtune_init(struct i2c_cli
 	char *name;
         unsigned char buf[21];
 	int company_code;
-	
+
 	memset(buf,0,sizeof(buf));
 	t->tv_freq    = NULL;
 	t->radio_freq = NULL;
@@ -828,13 +837,17 @@ static void default_set_tv_freq(struct i
         unsigned char buffer[4];
 	int rc;
 
-	tun=&tuners[t->type];
-	if (freq < tun->thresh1) 
+	tun = &tuners[t->type];
+	if (freq < tun->thresh1) {
 		config = tun->VHF_L;
-	else if (freq < tun->thresh2) 
+		dprintk("tv: VHF lowrange\n");
+	} else if (freq < tun->thresh2) {
 		config = tun->VHF_H;
-	else
+		dprintk("tv: VHF high range\n");
+	} else {
 		config = tun->UHF;
+		dprintk("tv: UHF range\n");
+	}
 
 
 	/* tv norm specific stuff for multi-norm tuners */
@@ -887,7 +900,7 @@ static void default_set_tv_freq(struct i
 		/* 0x02 -> NTSC antenna input 1 */
 		/* 0x03 -> NTSC antenna input 2 */
 		config &= ~0x03;
-		if (t->std & V4L2_STD_ATSC)
+		if (!(t->std & V4L2_STD_ATSC))
 			config |= 2;
 		/* FIXME: input */
 		break;
@@ -897,7 +910,7 @@ static void default_set_tv_freq(struct i
 		tun->config |= 0x40;
 		break;
 	}
-	
+
 	/*
 	 * Philips FI1216MK2 remark from specification :
 	 * for channel selection involving band switching, and to ensure
@@ -1131,7 +1144,7 @@ static int tuner_attach(struct i2c_adapt
 	if (this_adap > 0)
 		return -1;
 	this_adap++;
-	
+
         client_template.adapter = adap;
         client_template.addr = addr;
 
@@ -1233,7 +1246,7 @@ tuner_command(struct i2c_client *client,
 			break;
 		}
                 break;
-		
+
 	/* --- v4l ioctls --- */
 	/* take care: bttv does userspace copying, we'll get a
 	   kernel pointer here... */
@@ -1328,7 +1341,25 @@ tuner_command(struct i2c_client *client,
 		/* nothing */
 		break;
 	}
-	
+
+	return 0;
+}
+
+static int tuner_suspend(struct device * dev, u32 state, u32 level)
+{
+	dprintk("tuner: suspend\n");
+	/* FIXME: power down ??? */
+	return 0;
+}
+
+static int tuner_resume(struct device * dev, u32 level)
+{
+	struct i2c_client *c = container_of(dev, struct i2c_client, dev);
+	struct tuner *t = i2c_get_clientdata(c);
+
+	dprintk("tuner: resume\n");
+	if (t->freq)
+		set_freq(c,t->freq);
 	return 0;
 }
 
@@ -1342,6 +1373,10 @@ static struct i2c_driver driver = {
         .attach_adapter = tuner_probe,
         .detach_client  = tuner_detach,
         .command        = tuner_command,
+	.driver = {
+		.suspend = tuner_suspend,
+		.resume  = tuner_resume,
+	},
 };
 static struct i2c_client client_template =
 {
Index: linux-2004-10-20/drivers/media/video/tda9887.c
===================================================================
--- linux-2004-10-20.orig/drivers/media/video/tda9887.c	2004-10-21 11:46:23.000000000 +0200
+++ linux-2004-10-20/drivers/media/video/tda9887.c	2004-10-21 14:59:24.000000000 +0200
@@ -535,6 +535,11 @@ static int tda9887_configure(struct tda9
 	tda9887_set_config(t,buf);
 	tda9887_set_insmod(t,buf);
 
+	if (t->std & V4L2_STD_SECAM_L) {
+		/* secam fixup (FIXME: move this to tvnorms array?) */
+		buf[1] &= ~cOutputPort2Inactive;
+	}
+
 	dprintk(PREFIX "writing: b=0x%02x c=0x%02x e=0x%02x\n",
 		buf[1],buf[2],buf[3]);
 	if (debug > 1)
@@ -565,11 +570,11 @@ static int tda9887_attach(struct i2c_ada
                 return -ENOMEM;
 	memset(t,0,sizeof(*t));
 	t->client      = client_template;
-	t->std         = 0;;
+	t->std         = 0;
 	t->pinnacle_id = UNSET;
         i2c_set_clientdata(&t->client, t);
         i2c_attach_client(&t->client);
-        
+
 	return 0;
 }
 
@@ -618,7 +623,7 @@ tda9887_command(struct i2c_client *clien
 		t->radio = 1;
 		tda9887_configure(t);
 		break;
-		
+
 	case AUDC_CONFIG_PINNACLE:
 	{
 		int *i = arg;
@@ -712,6 +717,22 @@ tda9887_command(struct i2c_client *clien
 	return 0;
 }
 
+static int tda9887_suspend(struct device * dev, u32 state, u32 level)
+{
+	dprintk("tda9887: suspend\n");
+	return 0;
+}
+
+static int tda9887_resume(struct device * dev, u32 level)
+{
+	struct i2c_client *c = container_of(dev, struct i2c_client, dev);
+	struct tda9887 *t = i2c_get_clientdata(c);
+
+	dprintk("tda9887: resume\n");
+	tda9887_configure(t);
+	return 0;
+}
+
 /* ----------------------------------------------------------------------- */
 
 static struct i2c_driver driver = {
@@ -722,6 +743,10 @@ static struct i2c_driver driver = {
         .attach_adapter = tda9887_probe,
         .detach_client  = tda9887_detach,
         .command        = tda9887_command,
+	.driver = {
+		.suspend = tda9887_suspend,
+		.resume  = tda9887_resume,
+	},
 };
 static struct i2c_client client_template =
 {

-- 
return -ENOSIG;
