Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266530AbUAOMWg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 07:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266515AbUAOMWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 07:22:01 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:23219 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S265051AbUAOMUH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 07:20:07 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 15 Jan 2004 12:58:23 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l-07 tuner update
Message-ID: <20040115115823.GA16303@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This is a i2c tuner module update.  Changes:

  * adds support for more tunes (mt2050, atsc, ...)
  * some reorganization, uses function pointers to
    branch to different functions for different
    tuner types.

please apply,

  Gerd

diff -u linux-2.6.1/drivers/media/video/tuner.c linux/drivers/media/video/tuner.c
--- linux-2.6.1/drivers/media/video/tuner.c	2004-01-14 15:06:27.000000000 +0100
+++ linux/drivers/media/video/tuner.c	2004-01-14 15:09:35.000000000 +0100
@@ -45,18 +45,21 @@
 static int this_adap;
 #define dprintk     if (debug) printk
 
-struct tuner
-{
+struct tuner {
 	unsigned int type;            /* chip type */
 	unsigned int freq;            /* keep track of the current settings */
 	unsigned int std;
 	
 	unsigned int radio;
 	unsigned int mode;            /* current norm for multi-norm tuners */
+	unsigned int input;
 	
 	// only for MT2032
 	unsigned int xogc;
 	unsigned int radio_if2;
+
+	void (*tv_freq)(struct i2c_client *c, unsigned int freq);
+	void (*radio_freq)(struct i2c_client *c, unsigned int freq);
 };
 
 static struct i2c_driver driver;
@@ -207,7 +210,7 @@
 
 	{ "Samsung PAL TCPM9091PD27", Samsung, PAL,  /* from sourceforge v3tv */
           16*169,16*464,0xA0,0x90,0x30,0x8e,623},
-	{ "MT2032 universal", Microtune,PAL|NTSC,
+	{ "MT20xx universal", Microtune,PAL|NTSC,
                0,0,0,0,0,0,0},
 	{ "Temic PAL_BG (4106 FH5)", TEMIC, PAL,
           16*141.00, 16*464.00, 0xa0,0x90,0x30,0x8e,623},
@@ -225,6 +228,12 @@
 
 	{ "HITACHI V7-J180AT", HITACHI, NTSC,
 	  16*170.00, 16*450.00, 0x01,0x02,0x00,0x8e,940 },
+	{ "Philips PAL_MK (FI1216 MK)", Philips, PAL,
+	  16*140.25,16*463.25,0x01,0xc2,0xcf,0x8e,623},
+	{ "Philips 1236D ATSC/NTSC daul in",Philips,ATSC,
+	  16*157.25,16*454.00,0xa0,0x90,0x30,0x8e,732},
+        { "Philips NTSC MK3 (FM1236MK3 or FM1236/F)", Philips, NTSC,
+          16*160.00,16*442.00,0x01,0x02,0x04,0x8,732},
 };
 #define TUNERS ARRAY_SIZE(tuners)
 
@@ -279,86 +288,19 @@
 }
 #endif
 
-// Initalization as described in "MT203x Programming Procedures", Rev 1.2, Feb.2001
-static int mt2032_init(struct i2c_client *c)
-{
-        unsigned char buf[21];
-        int ret,xogc,xok=0;
-	struct tuner *t = i2c_get_clientdata(c);
-
-        buf[0]=0;
-        ret=i2c_master_send(c,buf,1);
-        i2c_master_recv(c,buf,21);
-
-        printk("MT2032: Companycode=%02x%02x Part=%02x Revision=%02x\n",
-                buf[0x11],buf[0x12],buf[0x13],buf[0x14]);
-
-        if(debug) {
-                int i;
-                printk("MT2032 hexdump:\n");
-                for(i=0;i<21;i++) {
-                        printk(" %02x",buf[i]);
-                        if(((i+1)%8)==0) printk(" ");
-                        if(((i+1)%16)==0) printk("\n ");
-                }
-                printk("\n ");
-        }
-	// Look for MT2032 id:
-	// part= 0x04(MT2032), 0x06(MT2030), 0x07(MT2040)
-        if((buf[0x11] != 0x4d) || (buf[0x12] != 0x54) || (buf[0x13] != 0x04)) {
-                printk("not a MT2032.\n");
-                return 0;
-        }
-
-
-        // Initialize Registers per spec.
-        buf[1]=2; // Index to register 2
-        buf[2]=0xff;
-        buf[3]=0x0f;
-        buf[4]=0x1f;
-        ret=i2c_master_send(c,buf+1,4);
-
-        buf[5]=6; // Index register 6
-        buf[6]=0xe4;
-        buf[7]=0x8f;
-        buf[8]=0xc3;
-        buf[9]=0x4e;
-        buf[10]=0xec;
-        ret=i2c_master_send(c,buf+5,6);
-
-        buf[12]=13;  // Index register 13
-        buf[13]=0x32;
-        ret=i2c_master_send(c,buf+12,2);
-
-        // Adjust XOGC (register 7), wait for XOK
-        xogc=7;
-        do {
-		dprintk("mt2032: xogc = 0x%02x\n",xogc&0x07);
-                mdelay(10);
-                buf[0]=0x0e;
-                i2c_master_send(c,buf,1);
-                i2c_master_recv(c,buf,1);
-                xok=buf[0]&0x01;
-                dprintk("mt2032: xok = 0x%02x\n",xok);
-                if (xok == 1) break;
-
-                xogc--;
-                dprintk("mt2032: xogc = 0x%02x\n",xogc&0x07);
-                if (xogc == 3) {
-                        xogc=4; // min. 4 per spec
-                        break;
-                }
-                buf[0]=0x07;
-                buf[1]=0x88 + xogc;
-                ret=i2c_master_send(c,buf,2);
-                if (ret!=2)
-                        printk("mt2032_init failed with %d\n",ret);
-        } while (xok != 1 );
-	t->xogc=xogc;
-
-        return(1);
-}
+/* ---------------------------------------------------------------------- */
 
+#define MT2032 0x04
+#define MT2030 0x06
+#define MT2040 0x07
+#define MT2050 0x42
+
+static char *microtune_part[] = {
+	[ MT2030 ] = "MT2030",
+	[ MT2032 ] = "MT2032",
+	[ MT2040 ] = "MT2040",
+	[ MT2050 ] = "MT2050",
+};
 
 // IsSpurInBand()?
 static int mt2032_spurcheck(int f1, int f2, int spectrum_from,int spectrum_to)
@@ -583,13 +525,13 @@
 }
 
 
-static void mt2032_set_tv_freq(struct i2c_client *c,
-			       unsigned int freq, unsigned int norm)
+static void mt2032_set_tv_freq(struct i2c_client *c, unsigned int freq)
 {
+	struct tuner *t = i2c_get_clientdata(c);
 	int if2,from,to;
 
 	// signal bandwidth and picture carrier
-	if (norm==VIDEO_MODE_NTSC) {
+	if (t->mode == VIDEO_MODE_NTSC) {
 		from=40750*1000;
 		to=46750*1000;
 		if2=45750*1000; 
@@ -604,36 +546,248 @@
 			   1090*1000*1000, if2, from, to);
 }
 
+static void mt2032_set_radio_freq(struct i2c_client *c, unsigned int freq)
+{
+	struct tuner *t = i2c_get_clientdata(c);
+	int if2 = t->radio_if2;
 
-// Set tuner frequency,  freq in Units of 62.5kHz = 1/16MHz
-static void set_tv_freq(struct i2c_client *c, unsigned int freq)
+	// per Manual for FM tuning: first if center freq. 1085 MHz
+        mt2032_set_if_freq(c, freq*62500 /* freq*1000*1000/16 */,
+			   1085*1000*1000,if2,if2,if2);
+}
+
+// Initalization as described in "MT203x Programming Procedures", Rev 1.2, Feb.2001
+static int mt2032_init(struct i2c_client *c)
 {
-	u8 config;
-	u16 div;
-	struct tunertype *tun;
 	struct tuner *t = i2c_get_clientdata(c);
-        unsigned char buffer[4];
-	int rc;
+        unsigned char buf[21];
+        int ret,xogc,xok=0;
 
-	if (t->type == UNSET) {
-		printk("tuner: tuner type not set\n");
-		return;
-	}
-	if (t->type == TUNER_MT2032) {
-		mt2032_set_tv_freq(c,freq,t->mode);
-		return;
+	// Initialize Registers per spec.
+        buf[1]=2; // Index to register 2
+        buf[2]=0xff;
+        buf[3]=0x0f;
+        buf[4]=0x1f;
+        ret=i2c_master_send(c,buf+1,4);
+
+        buf[5]=6; // Index register 6
+        buf[6]=0xe4;
+        buf[7]=0x8f;
+        buf[8]=0xc3;
+        buf[9]=0x4e;
+        buf[10]=0xec;
+        ret=i2c_master_send(c,buf+5,6);
+
+        buf[12]=13;  // Index register 13
+        buf[13]=0x32;
+        ret=i2c_master_send(c,buf+12,2);
+
+        // Adjust XOGC (register 7), wait for XOK
+        xogc=7;
+        do {
+		dprintk("mt2032: xogc = 0x%02x\n",xogc&0x07);
+                mdelay(10);
+                buf[0]=0x0e;
+                i2c_master_send(c,buf,1);
+                i2c_master_recv(c,buf,1);
+                xok=buf[0]&0x01;
+                dprintk("mt2032: xok = 0x%02x\n",xok);
+                if (xok == 1) break;
+
+                xogc--;
+                dprintk("mt2032: xogc = 0x%02x\n",xogc&0x07);
+                if (xogc == 3) {
+                        xogc=4; // min. 4 per spec
+                        break;
+                }
+                buf[0]=0x07;
+                buf[1]=0x88 + xogc;
+                ret=i2c_master_send(c,buf,2);
+                if (ret!=2)
+                        printk("mt2032_init failed with %d\n",ret);
+        } while (xok != 1 );
+	t->xogc=xogc;
+
+	t->tv_freq    = mt2032_set_tv_freq;
+	t->radio_freq = mt2032_set_radio_freq;
+        return(1);
+}
+
+static void mt2050_set_if_freq(struct i2c_client *c,unsigned int freq, unsigned int if2)
+{
+	unsigned int if1=1218*1000*1000;
+	unsigned int f_lo1,f_lo2,lo1,lo2,f_lo1_modulo,f_lo2_modulo,num1,num2,div1a,div1b,div2a,div2b;
+	int ret;
+	unsigned char buf[6];
+	
+	dprintk("mt2050_set_if_freq freq=%d\n",freq);
+	
+	f_lo1=freq+if1;
+	f_lo1=(f_lo1/1000000)*1000000;
+	
+	f_lo2=f_lo1-freq-if2;
+	f_lo2=(f_lo2/50000)*50000;
+	
+	lo1=f_lo1/4000000;
+	lo2=f_lo2/4000000;
+	
+	f_lo1_modulo= f_lo1-(lo1*4000000);
+	f_lo2_modulo= f_lo2-(lo2*4000000);
+	
+	num1=4*f_lo1_modulo/4000000;
+	num2=4096*(f_lo2_modulo/1000)/4000;
+	
+	// todo spurchecks
+	
+	div1a=(lo1/12)-1;
+	div1b=lo1-(div1a+1)*12;
+	
+	div2a=(lo2/8)-1;
+	div2b=lo2-(div2a+1)*8;
+	
+	dprintk("lo1 lo2 = %d %d\n", lo1, lo2);
+        dprintk("num1 num2 div1a div1b div2a div2b= %x %x %x %x %x %x\n",num1,num2,div1a,div1b,div2a,div2b);
+	
+	
+	buf[0]=1;
+	buf[1]= 4*div1b + num1;
+	if(freq<275*1000*1000) buf[1] = buf[1]|0x80;
+	
+	buf[2]=div1a;
+	buf[3]=32*div2b + num2/256;
+	buf[4]=num2-(num2/256)*256;
+	buf[5]=div2a;
+	if(num2!=0) buf[5]=buf[5]|0x40;
+	
+	if(debug) {
+		int i;
+		printk("bufs is: ");
+		for(i=0;i<6;i++)
+			printk("%x ",buf[i]);
+		printk("\n");
 	}
+	
+	ret=i2c_master_send(c,buf,6);
+        if (ret!=6)
+                printk("mt2050_set_if_freq failed with %d\n",ret);
+}
 
-	if (freq < tv_range[0]*16 || freq > tv_range[1]*16) {
-		/* FIXME: better do that chip-specific, but
-		   right now we don't have that in the config
-		   struct and this way is still better than no
-		   check at all */
-		printk("tuner: TV freq (%d.%02d) out of range (%d-%d)\n",
-		       freq/16,freq%16*100/16,tv_range[0],tv_range[1]);
-		return;
+static void mt2050_set_tv_freq(struct i2c_client *c, unsigned int freq)
+{
+	struct tuner *t = i2c_get_clientdata(c);
+	unsigned int if2;
+	
+	if (t->mode == VIDEO_MODE_NTSC) {
+                if2=45750*1000;
+        } else {
+                // Pal
+                if2=38900*1000;
+        }
+	mt2050_set_if_freq(c,freq*62500,if2);
+}
+
+static void mt2050_set_radio_freq(struct i2c_client *c, unsigned int freq)
+{
+	struct tuner *t = i2c_get_clientdata(c);
+	int if2 = t->radio_if2;
+	
+	mt2050_set_if_freq(c, freq*62500, if2);
+}
+
+static int mt2050_init(struct i2c_client *c)
+{
+	struct tuner *t = i2c_get_clientdata(c);
+	unsigned char buf[2];
+	int ret;
+	
+	buf[0]=6;
+	buf[1]=0x10;
+	ret=i2c_master_send(c,buf,2); //  power
+	
+	buf[0]=0x0f;
+	buf[1]=0x0f;
+	ret=i2c_master_send(c,buf,2); // m1lo
+	
+	buf[0]=0x0d;
+	ret=i2c_master_send(c,buf,1);
+	i2c_master_recv(c,buf,1);
+	
+	dprintk("mt2050: sro is %x\n",buf[0]);
+	t->tv_freq    = mt2050_set_tv_freq;
+	t->radio_freq = mt2050_set_radio_freq;
+	return 0;
+}
+
+static int microtune_init(struct i2c_client *c)
+{
+	struct tuner *t = i2c_get_clientdata(c);
+	char *name;
+        unsigned char buf[21];
+	int company_code;
+	
+        buf[0] = 0;
+	t->tv_freq = NULL;
+	t->radio_freq = NULL;
+	name = "unknown";
+
+        i2c_master_send(c,buf,1);
+        i2c_master_recv(c,buf,21);
+        if(debug) {
+                int i;
+                printk(KERN_DEBUG "tuner: MT2032 hexdump:\n");
+                for(i=0;i<21;i++) {
+                        printk(" %02x",buf[i]);
+                        if(((i+1)%8)==0) printk(" ");
+                        if(((i+1)%16)==0) printk("\n ");
+                }
+                printk("\n ");
+        }
+	company_code = buf[0x11] << 8 | buf[0x12];
+        printk("tuner: microtune: companycode=%04x part=%02x rev=%02x\n",
+	       company_code,buf[0x13],buf[0x14]);
+	switch (company_code) {
+	case 0x3cbf:
+	case 0x3dbf:
+	case 0x4d54:
+	case 0x8e81:
+	case 0x8e91:
+		/* ok (?) */
+		break;
+	default:
+		printk("tuner: microtune: unknown companycode\n");
+		return 0;
 	}
 
+	if (buf[0x13] < ARRAY_SIZE(microtune_part) &&
+	    NULL != microtune_part[buf[0x13]])
+		name = microtune_part[buf[0x13]];
+	switch (buf[0x13]) {
+	case MT2032:
+		mt2032_init(c);
+		break;
+	case MT2050:
+		mt2050_init(c);
+		break;
+	default:
+		printk("tuner: microtune %s found, not (yet?) supported, sorry :-/\n",
+		       name);
+                return 0;
+        }
+	printk("tuner: microtune %s found, OK\n",name);
+	return 0;
+}
+
+/* ---------------------------------------------------------------------- */
+
+static void default_set_tv_freq(struct i2c_client *c, unsigned int freq)
+{
+	struct tuner *t = i2c_get_clientdata(c);
+	u8 config;
+	u16 div;
+	struct tunertype *tun;
+        unsigned char buffer[4];
+	int rc;
+
 	tun=&tuners[t->type];
 	if (freq < tun->thresh1) 
 		config = tun->VHF_L;
@@ -700,6 +854,20 @@
 			break;
 		}
 		break;
+
+	case TUNER_PHILIPS_ATSC:
+		/* 0x00 -> ATSC antenna input 1 */
+		/* 0x01 -> ATSC antenna input 2 */
+		/* 0x02 -> NTSC antenna input 1 */
+		/* 0x03 -> NTSC antenna input 2 */
+		
+		config &= ~0x03;
+#ifdef VIDEO_MODE_ATSC
+		if (VIDEO_MODE_ATSC != t->mode)
+			config |= 2;
+#endif
+		/* FIXME: input */
+		break;
 	}
 
 	
@@ -737,17 +905,7 @@
 
 }
 
-static void mt2032_set_radio_freq(struct i2c_client *c, unsigned int freq)
-{
-	struct tuner *t = i2c_get_clientdata(c);
-	int if2 = t->radio_if2;
-
-	// per Manual for FM tuning: first if center freq. 1085 MHz
-        mt2032_set_if_freq(c, freq*62500 /* freq*1000*1000/16 */,
-			   1085*1000*1000,if2,if2,if2);
-}
-
-static void set_radio_freq(struct i2c_client *c, unsigned int freq)
+static void default_set_radio_freq(struct i2c_client *c, unsigned int freq)
 {
 	struct tunertype *tun;
 	struct tuner *t = i2c_get_clientdata(c);
@@ -755,22 +913,6 @@
 	unsigned div;
 	int rc;
 
-	if (freq < radio_range[0]*16 || freq > radio_range[1]*16) {
-		printk("tuner: radio freq (%d.%02d) out of range (%d-%d)\n",
-		       freq/16,freq%16*100/16,
-		       radio_range[0],radio_range[1]);
-		return;
-	}
-	if (t->type == UNSET) {
-		printk("tuner: tuner type not set\n");
-		return;
-	}
-
-        if (t->type == TUNER_MT2032) {
-                mt2032_set_radio_freq(c,freq);
-		return;
-	}
-
 	tun=&tuners[t->type];
 	div = freq + (int)(16*10.7);
         buffer[0] = (div>>8) & 0x7f;
@@ -778,6 +920,7 @@
 	buffer[2] = tun->config;
 	switch (t->type) {
 	case TUNER_PHILIPS_FM1216ME_MK3:
+	case TUNER_PHILIPS_FM1236_MK3:
 		buffer[3] = 0x19;
 		break;
 	default:
@@ -794,6 +937,80 @@
 
 /* ---------------------------------------------------------------------- */
 
+// Set tuner frequency,  freq in Units of 62.5kHz = 1/16MHz
+static void set_tv_freq(struct i2c_client *c, unsigned int freq)
+{
+	struct tuner *t = i2c_get_clientdata(c);
+
+	if (t->type == UNSET) {
+		printk("tuner: tuner type not set\n");
+		return;
+	}
+	if (NULL == t->tv_freq) {
+		printk("tuner: Huh? tv_set is NULL?\n");
+		return;
+	}
+	if (freq < tv_range[0]*16 || freq > tv_range[1]*16) {
+		/* FIXME: better do that chip-specific, but
+		   right now we don't have that in the config
+		   struct and this way is still better than no
+		   check at all */
+		printk("tuner: TV freq (%d.%02d) out of range (%d-%d)\n",
+		       freq/16,freq%16*100/16,tv_range[0],tv_range[1]);
+		return;
+	}
+	t->tv_freq(c,freq);
+}
+
+static void set_radio_freq(struct i2c_client *c, unsigned int freq)
+{
+	struct tuner *t = i2c_get_clientdata(c);
+
+	if (t->type == UNSET) {
+		printk("tuner: tuner type not set\n");
+		return;
+	}
+	if (NULL == t->radio_freq) {
+		printk("tuner: no radio tuning for this one, sorry.\n");
+		return;
+	}
+	if (freq < radio_range[0]*16 || freq > radio_range[1]*16) {
+		printk("tuner: radio freq (%d.%02d) out of range (%d-%d)\n",
+		       freq/16,freq%16*100/16,
+		       radio_range[0],radio_range[1]);
+		return;
+	}
+	t->radio_freq(c,freq);
+}
+
+static void set_type(struct i2c_client *c, unsigned int type)
+{
+	struct tuner *t = i2c_get_clientdata(c);
+
+	if (t->type != UNSET) {
+		printk("tuner: type already set (%d)\n",t->type);
+		return;
+	}
+	if (type >= TUNERS)
+		return;
+
+	t->type = type;
+	printk("tuner: type set to %d (%s)\n", t->type,tuners[t->type].name);
+	strlcpy(c->name, tuners[t->type].name, sizeof(c->name));
+
+	switch (t->type) {
+	case TUNER_MT2032:
+		microtune_init(c);
+		break;
+	default:
+		t->tv_freq    = default_set_tv_freq;
+		t->radio_freq = default_set_radio_freq;
+		break;
+	}
+}
+
+/* ---------------------------------------------------------------------- */
+
 static int tuner_attach(struct i2c_adapter *adap, int addr, int kind)
 {
 	struct tuner *t;
@@ -821,15 +1038,12 @@
 	t->type       = UNSET;
 	t->radio_if2  = 10700*1000; // 10.7MHz - FM radio
 
+        i2c_attach_client(client);
 	if (type < TUNERS) {
-		t->type = type;
-		printk("tuner(bttv): type forced to %d (%s) [insmod]\n",t->type,tuners[t->type].name);
-		strlcpy(client->name, tuners[t->type].name, I2C_NAME_SIZE);
+		printk("tuner: type forced to %d (%s) [insmod]\n",
+		       t->type,tuners[t->type].name);
+		set_type(client,type);
 	}
-        i2c_attach_client(client);
-        if (t->type == TUNER_MT2032)
-                 mt2032_init(client);
-
 	return 0;
 }
 
@@ -841,8 +1055,19 @@
 	}
 	this_adap = 0;
 
+#ifdef I2C_ADAP_CLASS_TV_ANALOG
 	if (adap->class & I2C_ADAP_CLASS_TV_ANALOG)
 		return i2c_probe(adap, &addr_data, tuner_attach);
+#else
+	switch (adap->id) {
+	case I2C_ALGO_BIT | I2C_HW_B_BT848:
+	case I2C_ALGO_BIT | I2C_HW_B_RIVA:
+	case I2C_ALGO_SAA7134:
+	case I2C_ALGO_SAA7146:
+		return i2c_probe(adap, &addr_data, tuner_attach);
+		break;
+	}
+#endif
 	return 0;
 }
 
@@ -866,21 +1091,13 @@
 
 	/* --- configuration --- */
 	case TUNER_SET_TYPE:
-		if (t->type != UNSET) {
-			printk("tuner: type already set (%d)\n",t->type);
-			return 0;
-		}
-		if (*iarg >= TUNERS)
-			return 0;
-		t->type = *iarg;
-		printk("tuner: type set to %d (%s)\n",
-                        t->type,tuners[t->type].name);
-		strlcpy(client->name, tuners[t->type].name, I2C_NAME_SIZE);
-		if (t->type == TUNER_MT2032)
-                        mt2032_init(client);
+		set_type(client,*iarg);
 		break;
 	case AUDC_SET_RADIO:
-		t->radio = 1;
+		if (!t->radio) {
+			set_tv_freq(client,400 * 16);
+			t->radio = 1;
+		}
 		break;
 	case AUDC_CONFIG_PINNACLE:
 		switch (*iarg) {
@@ -913,12 +1130,12 @@
 		unsigned long *v = arg;
 
 		if (t->radio) {
-			dprintk("tuner: radio freq set to %d.%02d\n",
-				(*iarg)/16,(*iarg)%16*100/16);
+			dprintk("tuner: radio freq set to %lu.%02lu\n",
+				(*v)/16,(*v)%16*100/16);
 			set_radio_freq(client,*v);
 		} else {
-			dprintk("tuner: tv freq set to %d.%02d\n",
-				(*iarg)/16,(*iarg)%16*100/16);
+			dprintk("tuner: tv freq set to %lu.%02lu\n",
+				(*v)/16,(*v)%16*100/16);
 			set_tv_freq(client,*v);
 		}
 		t->freq = *v;
@@ -960,9 +1177,9 @@
 };
 static struct i2c_client client_template =
 {
-	.flags  = I2C_CLIENT_ALLOW_USE,
-	.driver = &driver,
-	.name   = "(tuner unset)",
+	I2C_DEVNAME("(tuner unset)"),
+	.flags      = I2C_CLIENT_ALLOW_USE,
+        .driver     = &driver,
 };
 
 static int tuner_init_module(void)
diff -u linux-2.6.1/include/media/tuner.h linux/include/media/tuner.h
--- linux-2.6.1/include/media/tuner.h	2004-01-14 15:06:15.000000000 +0100
+++ linux/include/media/tuner.h	2004-01-14 15:09:35.000000000 +0100
@@ -65,14 +65,16 @@
 #define TUNER_PHILIPS_FM1216ME_MK3  38
 #define TUNER_LG_NTSC_NEW_TAPC   39
 #define TUNER_HITACHI_NTSC       40
-
-
+#define TUNER_PHILIPS_PAL_MK     41
+#define TUNER_PHILIPS_ATSC       42
+#define TUNER_PHILIPS_FM1236_MK3  43
 
 #define NOTUNER 0
 #define PAL     1	/* PAL_BG */
 #define PAL_I   2
 #define NTSC    3
 #define SECAM   4
+#define ATSC    5
 
 #define NoTuner 0
 #define Philips 1

-- 
You have a new virus in /var/mail/kraxel
