Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbWDEV3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWDEV3l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 17:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWDEV3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 17:29:41 -0400
Received: from smtp1.home.se ([212.78.199.21]:42571 "EHLO smtp1.home.se")
	by vger.kernel.org with ESMTP id S1751178AbWDEV3k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 17:29:40 -0400
Date: Wed, 5 Apr 2006 23:28:32 +0200
From: Martin Samuelsson <sam@home.se>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, mchehab@infradead.org, js@linuxtv.org,
       v4l-dvb-maintainer@linuxtv.org
Subject: [-mm patch] drivers/media/video/ks0127.c: code cleanup
Message-Id: <20060405232832.776cf5c1.sam@home.se>
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Code cleanup and coding style compliance changes:
- Extraneous spaces within parentheses, brackets and braces removed.
- Unnecessary initializations removed.
- All lines shorter than 80 columns.
- Constant msgs size of 2 replaced with ARRAY_SIZE(msgs).
- Single statement braces banished.
- udelay() -> msleep().
- Unused ks0127_getcrop() removed.
- schedule_timeout() -> schedule_timeout_interruptible().
- current->state = TASK_INTERRUPTIBLE removed.
- module_init/module_exit corrected.
- Removed the Emacs stuff.

Signed-off-by: Martin Samuelsson <sam@home.se>

---

 ks0127.c |  443 +++++++++++++++++++++++++++++++-----------------------------
 1 files changed, 236 insertions(+), 207 deletions(-)

The gigantic list of register name definitions; should it be moved to ks0127.h?

--- linux-2.6.17-rc1-mm1-ab-avs6eyes/drivers/media/video/ks0127-old.c	2006-04-06 00:26:07.000000000 +0200
+++ linux-2.6.16-git15-avs6eyes/drivers/media/video/ks0127.c	2006-04-06 00:37:52.000000000 +0200
@@ -1,5 +1,5 @@
 /*
- * Video Capture Driver ( Video for Linux 1/2 )
+ * Video Capture Driver (Video for Linux 1/2)
  * for the Matrox Marvel G200,G400 and Rainbow Runner-G series
  *
  * This module is an interface to the KS0127 video decoder chip.
@@ -216,24 +216,25 @@ struct ks0127 {
 };
 
 
-static int debug = 0; /* insmod parameter */
+static int debug; /* insmod parameter */
 
 module_param(debug, int, 0);
 MODULE_PARM_DESC(debug, "Debug output");
 MODULE_LICENSE("GPL");
 
-static u8 reg_defaults[ 64 ];
+static u8 reg_defaults[64];
 
 
 
 static void init_reg_defaults(void)
 {
-	u8* table = reg_defaults;
+	u8 *table = reg_defaults;
 
 	table[KS_CMDA]     = 0x2c;  /* VSE=0, CCIR 601, autodetect standard */
 	table[KS_CMDB]     = 0x12;  /* VALIGN=0, AGC control and input */
 	table[KS_CMDC]     = 0x00;  /* Test options */
-	table[KS_CMDD]     = 0x01;  /* clock & input select, write 1 to PORTA */
+	/* clock & input select, write 1 to PORTA */
+	table[KS_CMDD]     = 0x01;
 	table[KS_HAVB]     = 0x00;  /* HAV Start Control */
 	table[KS_HAVE]     = 0x00;  /* HAV End Control */
 	table[KS_HS1B]     = 0x10;  /* HS1 Start Control */
@@ -253,15 +254,18 @@ static void init_reg_defaults(void)
 	table[KS_SAT]      = 0x00;  /* Color Saturation Control*/
 	table[KS_HUE]      = 0x00;  /* Hue Control */
 	table[KS_VERTIA]   = 0x00;  /* Vertical Processing Control A */
-	table[KS_VERTIB]   = 0x12;  /* Vertical Processing Control B, luma 1 line delayed */
+	/* Vertical Processing Control B, luma 1 line delayed */
+	table[KS_VERTIB]   = 0x12;
 	table[KS_VERTIC]   = 0x0b;  /* Vertical Processing Control C */
 	table[KS_HSCLL]    = 0x00;  /* Horizontal Scaling Ratio Low */
 	table[KS_HSCLH]    = 0x00;  /* Horizontal Scaling Ratio High */
 	table[KS_VSCLL]    = 0x00;  /* Vertical Scaling Ratio Low */
 	table[KS_VSCLH]    = 0x00;  /* Vertical Scaling Ratio High */
-	table[KS_OFMTA]    = 0x30;  /* 16 bit YCbCr 4:2:2 output; I can't make the bt866 like 8 bit /Sam */
+	/* 16 bit YCbCr 4:2:2 output; I can't make the bt866 like 8 bit /Sam */
+	table[KS_OFMTA]    = 0x30;
 	table[KS_OFMTB]    = 0x00;  /* Output Control B */
-	table[KS_VBICTL]   = 0x5d;  /* VBI Decoder Control; 4bit fmt: avoid Y overflow */
+	/* VBI Decoder Control; 4bit fmt: avoid Y overflow */
+	table[KS_VBICTL]   = 0x5d;
 	table[KS_CCDAT2]   = 0x00;  /* Read Only register */
 	table[KS_CCDAT1]   = 0x00;  /* Read Only register */
 	table[KS_VBIL30]   = 0xa8;  /* VBI data decoding options */
@@ -277,8 +281,8 @@ static void init_reg_defaults(void)
 	table[KS_VAVB]     = 0x07;  /* VAV Begin */
 	table[KS_VAVE]     = 0x00;  /* VAV End */
 	table[KS_CTRACK]   = 0x00;  /* Chroma Tracking Control */
-	table[KS_POLCTL]   = 0x41; //0x01;  /* Timing Signal Polarity Control */
-	table[KS_REFCOD]   = 0x80; /*0xa4;*/  /* Reference Code Insertion Control */
+	table[KS_POLCTL]   = 0x41;  /* Timing Signal Polarity Control */
+	table[KS_REFCOD]   = 0x80;  /* Reference Code Insertion Control */
 	table[KS_INVALY]   = 0x10;  /* Invalid Y Code */
 	table[KS_INVALU]   = 0x80;  /* Invalid U Code */
 	table[KS_INVALV]   = 0x80;  /* Invalid V Code */
@@ -288,11 +292,14 @@ static void init_reg_defaults(void)
 	table[KS_USRSAV]   = 0x00;  /* reserved */
 	table[KS_USREAV]   = 0x00;  /* reserved */
 	table[KS_SHS1A]    = 0x00;  /* User Defined SHS1 A */
-	table[KS_SHS1B]    = 0x80;  /* User Defined SHS1 B, ALT656=1 on 0127B */
+	/* User Defined SHS1 B, ALT656=1 on 0127B */
+	table[KS_SHS1B]    = 0x80;
 	table[KS_SHS1C]    = 0x00;  /* User Defined SHS1 C */
 	table[KS_CMDE]     = 0x00;  /* Command Register E */
 	table[KS_VSDEL]    = 0x00;  /* VS Delay Control */
-	table[KS_CMDF]     = 0x02;  /* Command Register F, update -immediately- (there might come no vsync)*/
+	/* Command Register F, update -immediately- */
+	/* (there might come no vsync)*/
+	table[KS_CMDF]     = 0x02;
 }
 
 
@@ -311,40 +318,40 @@ static void init_reg_defaults(void)
  */
 
 
-static u8 ks0127_read( struct ks0127* ks, u8 reg )
+static u8 ks0127_read(struct ks0127 *ks, u8 reg)
 {
 	struct i2c_client *c = ks->client;
 	char val = 0;
 	struct i2c_msg msgs[] = {
-		{ c->addr, 0, sizeof(reg), &reg },
-		{ c->addr, I2C_M_RD | I2C_M_NO_RD_ACK, sizeof(val), &val}};
+		{c->addr, 0, sizeof(reg), &reg},
+		{c->addr, I2C_M_RD | I2C_M_NO_RD_ACK, sizeof(val), &val}};
 	int ret;
 
-	ret = i2c_transfer(c->adapter, msgs, 2);
-	if (ret != 2)
-		dprintk( "ks0127_write error\n" );
+	ret = i2c_transfer(c->adapter, msgs, ARRAY_SIZE(msgs));
+	if (ret != ARRAY_SIZE(msgs))
+		dprintk("ks0127_write error\n");
 
 	return val;
 }
 
 
-static void ks0127_write( struct ks0127* ks, u8 reg, u8 val )
+static void ks0127_write(struct ks0127 *ks, u8 reg, u8 val)
 {
-	char msg[] = { reg, val };
+	char msg[] = {reg, val};
 
-	if ( i2c_master_send(ks->client, msg, sizeof(msg) ) != sizeof(msg) ) {
-		dprintk( "ks0127_write error\n" );
-	}
-	ks->regs[ reg ] = val;
+	if (i2c_master_send(ks->client, msg, sizeof(msg)) != sizeof(msg))
+		dprintk("ks0127_write error\n");
+
+	ks->regs[reg] = val;
 }
 
 
 /* generic bit-twiddling */
-static void ks0127_and_or( struct ks0127* ks, u8 reg, u8 and_v, u8 or_v )
+static void ks0127_and_or(struct ks0127 *ks, u8 reg, u8 and_v, u8 or_v)
 {
-	u8 val = ks->regs[ reg ];
+	u8 val = ks->regs[reg];
 	val = (val & and_v) | or_v;
-	ks0127_write( ks, reg, val );
+	ks0127_write(ks, reg, val);
 }
 
 
@@ -352,29 +359,30 @@ static void ks0127_and_or( struct ks0127
 /****************************************************************************
 * ks0127 private api
 ****************************************************************************/
-static void ks0127_reset( struct ks0127* ks )
+static void ks0127_reset(struct ks0127* ks)
 {
 	int i;
-	u8* table = reg_defaults;
+	u8 *table = reg_defaults;
 
 	ks->ks_type = KS_TYPE_UNKNOWN;
 
-	dprintk( "ks0127: reset\n" );
-	udelay(1000);
+	dprintk("ks0127: reset\n");
+	msleep(1);
 
-	/* initialize all registers to known values (except STAT, 0x21, 0x22, TEST and 0x38,0x39 ) */
+	/* initialize all registers to known values */
+	/* (except STAT, 0x21, 0x22, TEST and 0x38,0x39) */
 
-	for(i = 1; i < 33; i++ )
-		ks0127_write( ks, i, table[i] );
+	for(i = 1; i < 33; i++)
+		ks0127_write(ks, i, table[i]);
 
 	for(i = 35; i < 40; i++)
-		ks0127_write( ks, i, table[i] );
+		ks0127_write(ks, i, table[i]);
 
 	for(i = 41; i < 56; i++)
-		ks0127_write( ks, i, table[i] );
+		ks0127_write(ks, i, table[i]);
 
 	for(i = 58; i < 64; i++)
-		ks0127_write( ks, i, table[i] );
+		ks0127_write(ks, i, table[i]);
 
 
 	if ((ks0127_read(ks, KS_STAT) & 0x80) == 0) {
@@ -401,32 +409,8 @@ static void ks0127_reset( struct ks0127*
 	}
 }
 
-
-void ks0127_getcrop(struct ks0127 *ks, int *xstart, int *xend, int *ystart, int *yend)
-{
-	*xstart = ((ks0127_read(ks, KS_HXTRA) & 0xe0) << 3) +
-		ks0127_read(ks, KS_HAVB);
-
-	*xend = ((ks0127_read(ks, KS_HXTRA) & 0x1c) << 6) +
-		ks0127_read(ks, KS_HAVE);
-
-	if ((*xstart) & 0x400)
-		*xstart |= ~0x3ff;
-
-	if ((*xend) & 0x400)
-		*xend |= ~0x3ff;
-
-	*ystart = ks0127_read(ks, KS_VAVB) >> 2;
-	*yend = ks0127_read(ks, KS_VAVE);
-	dprintk("ks0127: ystart=%d yend=%d\n", *ystart, *yend);
-
-	*ystart = (*ystart - 2) * 2;
-	*yend = (*yend - 2) * 2;
-}
-
-
-static int
-ks0127_command(struct i2c_client *client, unsigned int cmd, void *arg)
+static int ks0127_command(struct i2c_client *client,
+			  unsigned int cmd, void *arg)
 {
 	struct ks0127 *ks = i2c_get_clientdata(client);
 
@@ -434,195 +418,244 @@ ks0127_command(struct i2c_client *client
 
 	int		status;
 
-	if( !ks )
+	if (!ks)
 		return -ENODEV;
 
 	switch (cmd) {
 
 	case DECODER_INIT:
-		dprintk( "ks0127: command DECODER_INIT\n" );
-		ks0127_reset( ks );
+		dprintk("ks0127: command DECODER_INIT\n");
+		ks0127_reset(ks);
 		break;
 
 	case DECODER_SET_INPUT:
-		switch( *iarg ) {
+		switch(*iarg) {
 		case KS_INPUT_COMPOSITE_1:
 		case KS_INPUT_COMPOSITE_2:
 		case KS_INPUT_COMPOSITE_3:
 		case KS_INPUT_COMPOSITE_4:
 		case KS_INPUT_COMPOSITE_5:
 		case KS_INPUT_COMPOSITE_6:
-			dprintk( "ks0127: command DECODER_SET_INPUT %d: Composite\n", *iarg );
-			ks0127_and_or( ks, KS_CMDA,   0xfc, 0x00 ); /* autodetect 50/60 Hz */
-			ks0127_and_or( ks, KS_CMDA,   ~0x40, 0x00 ); /* VSE=0 */
-			ks0127_and_or( ks, KS_CMDB,   0xb0, *iarg ); /* set input line */
-			ks0127_and_or( ks, KS_CMDC,   0x70, 0x0a ); /* non-freerunning mode */
-			ks0127_and_or( ks, KS_CMDD,   0x03, 0x00 ); /* analog input */
-			ks0127_and_or( ks, KS_CTRACK, 0xcf, 0x00 ); /* enable chroma demodulation */
-			ks0127_and_or( ks, KS_LUMA,   0x00, (reg_defaults[KS_LUMA])|0x0c ); /* chroma trap, HYBWR=1 */
-			ks0127_and_or( ks, KS_VERTIA, 0x08, 0x81 ); /* scaler fullbw, luma comb off */
-			ks0127_and_or( ks, KS_VERTIC, 0x0f, 0x90 ); /* manual chroma comb .25 .5 .25 */
-
-			ks0127_and_or( ks, KS_CHROMB, 0x0f, 0x90 ); /* chroma path delay */
-
-			ks0127_write( ks, KS_UGAIN, reg_defaults[KS_UGAIN] );
-			ks0127_write( ks, KS_VGAIN, reg_defaults[KS_VGAIN] );
-			ks0127_write( ks, KS_UVOFFH, reg_defaults[KS_UVOFFH] );
-			ks0127_write( ks, KS_UVOFFL, reg_defaults[KS_UVOFFL] );
+			dprintk("ks0127: command DECODER_SET_INPUT %d: "
+				"Composite\n", *iarg);
+			/* autodetect 50/60 Hz */
+			ks0127_and_or(ks, KS_CMDA,   0xfc, 0x00);
+			/* VSE=0 */
+			ks0127_and_or(ks, KS_CMDA,   ~0x40, 0x00);
+			/* set input line */
+			ks0127_and_or(ks, KS_CMDB,   0xb0, *iarg);
+			/* non-freerunning mode */
+			ks0127_and_or(ks, KS_CMDC,   0x70, 0x0a);
+			/* analog input */
+			ks0127_and_or(ks, KS_CMDD,   0x03, 0x00);
+			/* enable chroma demodulation */
+			ks0127_and_or(ks, KS_CTRACK, 0xcf, 0x00);
+			/* chroma trap, HYBWR=1 */
+			ks0127_and_or(ks, KS_LUMA,   0x00,
+				       (reg_defaults[KS_LUMA])|0x0c);
+			/* scaler fullbw, luma comb off */
+			ks0127_and_or(ks, KS_VERTIA, 0x08, 0x81);
+			/* manual chroma comb .25 .5 .25 */
+			ks0127_and_or(ks, KS_VERTIC, 0x0f, 0x90);
+
+			/* chroma path delay */
+			ks0127_and_or(ks, KS_CHROMB, 0x0f, 0x90);
+
+			ks0127_write(ks, KS_UGAIN, reg_defaults[KS_UGAIN]);
+			ks0127_write(ks, KS_VGAIN, reg_defaults[KS_VGAIN]);
+			ks0127_write(ks, KS_UVOFFH, reg_defaults[KS_UVOFFH]);
+			ks0127_write(ks, KS_UVOFFL, reg_defaults[KS_UVOFFL]);
 			break;
 
 		case KS_INPUT_SVIDEO_1:
 		case KS_INPUT_SVIDEO_2:
 		case KS_INPUT_SVIDEO_3:
-			dprintk( "ks0127: command DECODER_SET_INPUT %d: S-Video\n", *iarg );
-			ks0127_and_or( ks, KS_CMDA,   0xfc, 0x00 ); /* autodetect 50/60 Hz */
-			ks0127_and_or( ks, KS_CMDA,   ~0x40, 0x00 ); /* VSE=0 */
-			ks0127_and_or( ks, KS_CMDB,   0xb0, *iarg ); /* set input line */
-			ks0127_and_or( ks, KS_CMDC,   0x70, 0x0a ); /* non-freerunning mode */
-			ks0127_and_or( ks, KS_CMDD,   0x03, 0x00 ); /* analog input */
-			ks0127_and_or( ks, KS_CTRACK, 0xcf, 0x00 ); /* enable chroma demodulation */
-			ks0127_and_or( ks, KS_LUMA,   0x00, reg_defaults[KS_LUMA] );
-			ks0127_and_or( ks, KS_VERTIA, 0x08, (reg_defaults[KS_VERTIA]&0xf0)|0x01 ); /* disable luma comb */
-			ks0127_and_or( ks, KS_VERTIC, 0x0f, reg_defaults[KS_VERTIC]&0xf0 );
-
-			ks0127_and_or( ks, KS_CHROMB, 0x0f, reg_defaults[KS_CHROMB]&0xf0 );
-
-			ks0127_write( ks, KS_UGAIN, reg_defaults[KS_UGAIN] );
-			ks0127_write( ks, KS_VGAIN, reg_defaults[KS_VGAIN] );
-			ks0127_write( ks, KS_UVOFFH, reg_defaults[KS_UVOFFH] );
-			ks0127_write( ks, KS_UVOFFL, reg_defaults[KS_UVOFFL] );
+			dprintk("ks0127: command DECODER_SET_INPUT %d: "
+				"S-Video\n", *iarg);
+			/* autodetect 50/60 Hz */
+			ks0127_and_or(ks, KS_CMDA,   0xfc, 0x00);
+			/* VSE=0 */
+			ks0127_and_or(ks, KS_CMDA,   ~0x40, 0x00);
+			/* set input line */
+			ks0127_and_or(ks, KS_CMDB,   0xb0, *iarg);
+			/* non-freerunning mode */
+			ks0127_and_or(ks, KS_CMDC,   0x70, 0x0a);
+			/* analog input */
+			ks0127_and_or(ks, KS_CMDD,   0x03, 0x00);
+			/* enable chroma demodulation */
+			ks0127_and_or(ks, KS_CTRACK, 0xcf, 0x00);
+			ks0127_and_or(ks, KS_LUMA, 0x00,
+				       reg_defaults[KS_LUMA]);
+			/* disable luma comb */
+			ks0127_and_or(ks, KS_VERTIA, 0x08,
+				       (reg_defaults[KS_VERTIA]&0xf0)|0x01);
+			ks0127_and_or(ks, KS_VERTIC, 0x0f,
+				       reg_defaults[KS_VERTIC]&0xf0);
+
+			ks0127_and_or(ks, KS_CHROMB, 0x0f,
+				       reg_defaults[KS_CHROMB]&0xf0);
+
+			ks0127_write(ks, KS_UGAIN, reg_defaults[KS_UGAIN]);
+			ks0127_write(ks, KS_VGAIN, reg_defaults[KS_VGAIN]);
+			ks0127_write(ks, KS_UVOFFH, reg_defaults[KS_UVOFFH]);
+			ks0127_write(ks, KS_UVOFFL, reg_defaults[KS_UVOFFL]);
 			break;
 
 		case KS_INPUT_YUV656:
-			dprintk( "ks0127: command DECODER_SET_INPUT 15: YUV656\n" );
-			if (ks->norm == VIDEO_MODE_NTSC || ks->norm == KS_STD_PAL_M) {
-				ks0127_and_or( ks, KS_CMDA,   0xfc, 0x03 ); /* force 60 Hz */
-			} else {
-				ks0127_and_or( ks, KS_CMDA,   0xfc, 0x02 ); /* force 50 Hz */
-			}
-
-			ks0127_and_or( ks, KS_CMDA,   0xff, 0x40 ); /* VSE=1 */
-			ks0127_and_or( ks, KS_CMDB,   0xb0, (*iarg | 0x40)); /* set input line and VALIGN */
-			ks0127_and_or( ks, KS_CMDC,   0x70, 0x87 ); /* freerunning mode, TSTGEN = 1 TSTGFR=11 TSTGPH=0 TSTGPK=0  VMEM=1*/
-			ks0127_and_or( ks, KS_CMDD,   0x03, 0x08); /* digital input, SYNDIR = 0 INPSL=01 CLKDIR=0 EAV=0 */
-			ks0127_and_or( ks, KS_CTRACK, 0xcf, 0x30 ); /* disable chroma demodulation */
-			ks0127_and_or( ks, KS_LUMA,   0x00, 0x71 ); /* HYPK =01 CTRAP = 0 HYBWR=0 PED=1 RGBH=1 UNIT=1 */
-			ks0127_and_or( ks, KS_VERTIC, 0x0f, reg_defaults[KS_VERTIC]&0xf0 );
-
-			ks0127_and_or( ks, KS_VERTIA, 0x08, 0x81 ); /* scaler fullbw, luma comb off */
-
-			ks0127_and_or( ks, KS_CHROMB, 0x0f, reg_defaults[KS_CHROMB]&0xf0 );
-
-			ks0127_and_or( ks, KS_CON, 0x00, 0x00);
-			ks0127_and_or( ks, KS_BRT, 0x00, 32);	/* spec: 34 */
-			ks0127_and_or( ks, KS_SAT, 0x00, 0xe8);	/* spec: 229 (e5) */
-			ks0127_and_or( ks, KS_HUE, 0x00, 0);
-
-			ks0127_and_or( ks, KS_UGAIN, 0x00, 238);
-			ks0127_and_or( ks, KS_VGAIN, 0x00, 0x00);
-
-			ks0127_and_or( ks, KS_UVOFFH, 0x00, 0x4f); /*UOFF:0x30, VOFF:0x30, TSTCGN=1 */
-			ks0127_and_or( ks, KS_UVOFFL, 0x00, 0x00);
+			dprintk("ks0127: command DECODER_SET_INPUT 15: "
+				"YUV656\n");
+			if (ks->norm == VIDEO_MODE_NTSC ||
+			    ks->norm == KS_STD_PAL_M)
+				/* force 60 Hz */
+				ks0127_and_or(ks, KS_CMDA,   0xfc, 0x03);
+			else
+				/* force 50 Hz */
+				ks0127_and_or(ks, KS_CMDA,   0xfc, 0x02);
+
+			ks0127_and_or(ks, KS_CMDA,   0xff, 0x40); /* VSE=1 */
+			/* set input line and VALIGN */
+			ks0127_and_or(ks, KS_CMDB,   0xb0, (*iarg | 0x40));
+			/* freerunning mode, */
+			/* TSTGEN = 1 TSTGFR=11 TSTGPH=0 TSTGPK=0  VMEM=1*/
+			ks0127_and_or(ks, KS_CMDC,   0x70, 0x87);
+			/* digital input, SYNDIR = 0 INPSL=01 CLKDIR=0 EAV=0 */
+			ks0127_and_or(ks, KS_CMDD,   0x03, 0x08);
+			/* disable chroma demodulation */
+			ks0127_and_or(ks, KS_CTRACK, 0xcf, 0x30);
+			/* HYPK =01 CTRAP = 0 HYBWR=0 PED=1 RGBH=1 UNIT=1 */
+			ks0127_and_or(ks, KS_LUMA,   0x00, 0x71);
+			ks0127_and_or(ks, KS_VERTIC, 0x0f,
+				       reg_defaults[KS_VERTIC]&0xf0);
+
+			/* scaler fullbw, luma comb off */
+			ks0127_and_or(ks, KS_VERTIA, 0x08, 0x81);
+
+			ks0127_and_or(ks, KS_CHROMB, 0x0f,
+				       reg_defaults[KS_CHROMB]&0xf0);
+
+			ks0127_and_or(ks, KS_CON, 0x00, 0x00);
+			ks0127_and_or(ks, KS_BRT, 0x00, 32);	/* spec: 34 */
+				/* spec: 229 (e5) */
+			ks0127_and_or(ks, KS_SAT, 0x00, 0xe8);
+			ks0127_and_or(ks, KS_HUE, 0x00, 0);
+
+			ks0127_and_or(ks, KS_UGAIN, 0x00, 238);
+			ks0127_and_or(ks, KS_VGAIN, 0x00, 0x00);
+
+			/*UOFF:0x30, VOFF:0x30, TSTCGN=1 */
+			ks0127_and_or(ks, KS_UVOFFH, 0x00, 0x4f);
+			ks0127_and_or(ks, KS_UVOFFL, 0x00, 0x00);
 			break;
 
 		default:
-			dprintk( "ks0127: command DECODER_SET_INPUT: Unknown input %d\n", *iarg );
+			dprintk("ks0127: command DECODER_SET_INPUT: "
+				"Unknown input %d\n", *iarg);
 			break;
 		}
 
-		/* hack: CDMLPF sometimes spontaneously switches on; force back off */
-		ks0127_write( ks, KS_DEMOD, reg_defaults[KS_DEMOD] );
+		/* hack: CDMLPF sometimes spontaneously switches on; */
+		/* force back off */
+		ks0127_write(ks, KS_DEMOD, reg_defaults[KS_DEMOD]);
 		break;
 
 	case DECODER_SET_OUTPUT:
-		switch( *iarg ) {
+		switch(*iarg) {
 		case KS_OUTPUT_YUV656E:
-			dprintk( "ks0127: command DECODER_SET_OUTPUT: OUTPUT_YUV656E (Missing)\n" );
+			dprintk("ks0127: command DECODER_SET_OUTPUT: "
+				"OUTPUT_YUV656E (Missing)\n");
 			return -EINVAL;
 			break;
 
 		case KS_OUTPUT_EXV:
-			dprintk( "ks0127: command DECODER_SET_OUTPUT: OUTPUT_EXV\n" );
-			ks0127_and_or( ks, KS_OFMTA, 0xf0, 0x09 );
+			dprintk("ks0127: command DECODER_SET_OUTPUT: "
+				"OUTPUT_EXV\n");
+			ks0127_and_or(ks, KS_OFMTA, 0xf0, 0x09);
 			break;
 		}
 		break;
 
 	case DECODER_SET_NORM: //sam This block mixes old and new norm names...
 		/* Set to automatic SECAM/Fsc mode */
-		ks0127_and_or( ks, KS_DEMOD, 0xf0, 0x00 );
+		ks0127_and_or(ks, KS_DEMOD, 0xf0, 0x00);
 
 		ks->norm = *iarg;
-		switch( *iarg )
+		switch(*iarg)
 		{
-		/* this is untested !! It just detects PAL_N/NTSC_M (no special frequencies)
-		And you have to set the standard a second time afterwards */
+		/* this is untested !! */
+		/* It just detects PAL_N/NTSC_M (no special frequencies) */
+		/* And you have to set the standard a second time afterwards */
 		case VIDEO_MODE_AUTO:
-			dprintk( "ks0127: command DECODER_SET_NORM: AUTO\n" );
+			dprintk("ks0127: command DECODER_SET_NORM: AUTO\n");
 
-			/* The chip determines the format based on the current field rate */
-			ks0127_and_or( ks, KS_CMDA,   0xfc, 0x00 );
-			ks0127_and_or( ks, KS_CHROMA, 0x9f, 0x20 ); //0x40 );
-			/* This is wrong for PAL ! As I said, you need to set the standard once again !! */
+			/* The chip determines the format */
+			/* based on the current field rate */
+			ks0127_and_or(ks, KS_CMDA,   0xfc, 0x00);
+			ks0127_and_or(ks, KS_CHROMA, 0x9f, 0x20);
+			/* This is wrong for PAL ! As I said, */
+			/* you need to set the standard once again !! */
 			ks->format_height = 240;
 			ks->format_width = 704;
 			break;
 
 		case VIDEO_MODE_NTSC:
-			dprintk( "ks0127: command DECODER_SET_NORM: NTSC_M\n" );
-			ks0127_and_or( ks, KS_CHROMA, 0x9f, 0x20 ); //0x00 );
+			dprintk("ks0127: command DECODER_SET_NORM: NTSC_M\n");
+			ks0127_and_or(ks, KS_CHROMA, 0x9f, 0x20);
 			ks->format_height = 240;
 			ks->format_width = 704;
 			break;
 
 		case KS_STD_NTSC_N:
-			dprintk( "ks0127: command KS0127_SET_STANDARD: NTSC_N (fixme)\n" );
-			ks0127_and_or( ks, KS_CHROMA, 0x9f, 0x40 ); //0x00 );
+			dprintk("ks0127: command KS0127_SET_STANDARD: "
+				"NTSC_N (fixme)\n");
+			ks0127_and_or(ks, KS_CHROMA, 0x9f, 0x40);
 			ks->format_height = 240;
 			ks->format_width = 704;
 			break;
 
 		case VIDEO_MODE_PAL:
-			dprintk( "ks0127: command DECODER_SET_NORM: PAL_N\n" );
-			ks0127_and_or( ks, KS_CHROMA, 0x9f, 0x20 ); //0x60 );
+			dprintk("ks0127: command DECODER_SET_NORM: PAL_N\n");
+			ks0127_and_or(ks, KS_CHROMA, 0x9f, 0x20);
 			ks->format_height = 290;
 			ks->format_width = 704;
 			break;
 
 		case KS_STD_PAL_M:
-			dprintk( "ks0127: command KS0127_SET_STANDARD: PAL_M (fixme)\n" );
-			ks0127_and_or( ks, KS_CHROMA, 0x9f, 0x40 ); //0x60 );
+			dprintk("ks0127: command KS0127_SET_STANDARD: "
+				"PAL_M (fixme)\n");
+			ks0127_and_or(ks, KS_CHROMA, 0x9f, 0x40);
 			ks->format_height = 290;
 			ks->format_width = 704;
 			break;
 
 		case VIDEO_MODE_SECAM:
-			dprintk( "ks0127: command KS0127_SET_STANDARD: SECAM\n" );
+			dprintk("ks0127: command KS0127_SET_STANDARD: "
+				"SECAM\n");
 			ks->format_height = 290;
 			ks->format_width = 704;
 
 			/* set to secam autodetection */
-			ks0127_and_or( ks, KS_CHROMA, 0xdf, 0x20 );
-			ks0127_and_or( ks, KS_DEMOD, 0xf0, 0x00 );
-			current->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(HZ/10+1);
+			ks0127_and_or(ks, KS_CHROMA, 0xdf, 0x20);
+			ks0127_and_or(ks, KS_DEMOD, 0xf0, 0x00);
+			schedule_timeout_interruptible(HZ/10+1);
 
 			/* did it autodetect? */
-			if( ks0127_read( ks, KS_DEMOD ) & 0x40 )
+			if (ks0127_read(ks, KS_DEMOD) & 0x40)
 				break;
 
 			/* force to secam mode */
-			ks0127_and_or( ks, KS_DEMOD, 0xf0, 0x0f );
+			ks0127_and_or(ks, KS_DEMOD, 0xf0, 0x0f);
 			break;
 
 		default:
-			dprintk( "ks0127: command DECODER_SET_NORM: Unknown norm %d\n", *iarg );
+			dprintk("ks0127: command DECODER_SET_NORM: "
+				"Unknown norm %d\n", *iarg);
 			break;
 		}
 		break;
 
 	case DECODER_SET_PICTURE:
-		dprintk( "ks0127: command DECODER_SET_PICTURE not yet supported (fixme)\n" );
+		dprintk("ks0127: command DECODER_SET_PICTURE "
+			"not yet supported (fixme)\n");
 		return -EINVAL;
 
 	//sam todo: KS0127_SET_BRIGHTNESS: Merge into DECODER_SET_PICTURE
@@ -650,13 +683,21 @@ ks0127_command(struct i2c_client *client
 		int *iarg = arg;
 		int enable = (*iarg != 0);
 			if (enable) {
-				dprintk( "ks0127: command DECODER_ENABLE_OUTPUT on (%d)\n", enable );
-				ks0127_and_or( ks, KS_OFMTA, 0xcf, 0x30 ); // All output pins on
-				ks0127_and_or( ks, KS_CDEM, 0x7f, 0x00 ); // Obey the OEN pin
+				dprintk("ks0127: command "
+					"DECODER_ENABLE_OUTPUT on "
+					"(%d)\n", enable);
+				/* All output pins on */
+				ks0127_and_or(ks, KS_OFMTA, 0xcf, 0x30);
+				/* Obey the OEN pin */
+				ks0127_and_or(ks, KS_CDEM, 0x7f, 0x00);
 			} else {
-				dprintk( "ks0127: command DECODER_ENABLE_OUTPUT off (%d)\n", enable );
-				ks0127_and_or( ks, KS_OFMTA, 0xcf, 0x00 ); // Video output pins off
-				ks0127_and_or( ks, KS_CDEM, 0x7f, 0x80 ); // Ignore the OEN pin
+				dprintk("ks0127: command "
+					"DECODER_ENABLE_OUTPUT off "
+					"(%d)\n", enable);
+				/* Video output pins off */
+				ks0127_and_or(ks, KS_OFMTA, 0xcf, 0x00);
+				/* Ignore the OEN pin */
+				ks0127_and_or(ks, KS_CDEM, 0x7f, 0x80);
 			}
 	}
 		break;
@@ -667,23 +708,22 @@ ks0127_command(struct i2c_client *client
 	//sam todo: KS0127_SET_HSCALE:
 
 	case DECODER_GET_STATUS:
-		dprintk( "ks0127: command DECODER_GET_STATUS\n" );
+		dprintk("ks0127: command DECODER_GET_STATUS\n");
 		*iarg = 0;
-		status = ks0127_read( ks, KS_STAT );
-		if(!(status & 0x20))		 /* NOVID not set */
+		status = ks0127_read(ks, KS_STAT);
+		if (!(status & 0x20))		 /* NOVID not set */
 			*iarg = (*iarg & DECODER_STATUS_GOOD);
-		if((status & 0x01))		      /* CLOCK set */
+		if ((status & 0x01))		      /* CLOCK set */
 			*iarg = (*iarg & DECODER_STATUS_COLOR);
-		if((status & 0x08)) {		   /* PALDET set */
+		if ((status & 0x08))		   /* PALDET set */
 			*iarg = (*iarg & DECODER_STATUS_PAL);
-		} else {
+		else
 			*iarg = (*iarg & DECODER_STATUS_NTSC);
-		}
 		break;
 
 	//Catch any unknown command
 	default:
-		dprintk( "ks0127: command unknown: %04X\n", cmd );
+		dprintk("ks0127: command unknown: %04X\n", cmd);
 		return -EINVAL;
 	}
 	return 0;
@@ -694,14 +734,16 @@ ks0127_command(struct i2c_client *client
 
 static int ks0127_probe(struct i2c_adapter *adapter);
 static int ks0127_detach(struct i2c_client *client);
-static int ks0127_command(struct i2c_client *client, unsigned int cmd, void *arg );
+static int ks0127_command(struct i2c_client *client,
+			  unsigned int cmd, void *arg);
 
 
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { I2C_KS0127_ADDON>>1, I2C_KS0127_ONBOARD>>1, I2C_CLIENT_END };
-static unsigned short probe[2]	= 	{ I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short ignore[2]       = 	{ I2C_CLIENT_END, I2C_CLIENT_END };
+static unsigned short normal_i2c[] = {I2C_KS0127_ADDON>>1,
+				       I2C_KS0127_ONBOARD>>1, I2C_CLIENT_END};
+static unsigned short probe[2] =	{I2C_CLIENT_END, I2C_CLIENT_END};
+static unsigned short ignore[2] = 	{I2C_CLIENT_END, I2C_CLIENT_END};
 static struct i2c_client_address_data addr_data = {
 	normal_i2c,
 	probe,
@@ -709,12 +751,8 @@ static struct i2c_client_address_data ad
 };
 
 static struct i2c_driver i2c_driver_ks0127 = {
-	.driver = {
-		.name = "ks0127",
-	},
-
+	.driver.name = "ks0127",
 	.id             = I2C_DRIVERID_KS0127,
-
 	.attach_adapter = ks0127_probe,
 	.detach_client  = ks0127_detach,
 	.command        = ks0127_command
@@ -735,13 +773,13 @@ static int ks0127_found_proc(struct i2c_
 	struct i2c_client *client;
 
 	client = kzalloc(sizeof(*client), GFP_KERNEL);
-	if(client == NULL)
+	if (client == NULL)
 		return -ENOMEM;
-	memcpy( client, &ks0127_client_tmpl, sizeof(*client) );
+	memcpy(client, &ks0127_client_tmpl, sizeof(*client));
 
-	ks = kzalloc( sizeof(*ks), GFP_KERNEL );
-	if( ks == NULL ) {
-		kfree( client );
+	ks = kzalloc(sizeof(*ks), GFP_KERNEL);
+	if (ks == NULL) {
+		kfree(client);
 		return -ENOMEM;
 	}
 
@@ -755,11 +793,11 @@ static int ks0127_found_proc(struct i2c_
 	ks->ks_type = KS_TYPE_UNKNOWN;
 
 	/* power up */
-	ks0127_write( ks, KS_CMDA, 0x2c );
+	ks0127_write(ks, KS_CMDA, 0x2c);
 	mdelay(10);
 
 	/* reset the device */
-	ks0127_reset( ks );
+	ks0127_reset(ks);
 	printk(KERN_INFO "ks0127: attach: %s video decoder\n",
 	       ks->addr==(I2C_KS0127_ADDON>>1) ? "addon" : "on-board");
 
@@ -779,26 +817,26 @@ static int ks0127_detach(struct i2c_clie
 {
 	struct ks0127 *ks = i2c_get_clientdata(client);
 
-	ks0127_write( ks, KS_OFMTA, 0x20 ); /*tristate*/
-	ks0127_write( ks, KS_CMDA, 0x2c | 0x80 ); /* power down */
+	ks0127_write(ks, KS_OFMTA, 0x20); /*tristate*/
+	ks0127_write(ks, KS_CMDA, 0x2c | 0x80); /* power down */
 
 	i2c_detach_client(client);
 	kfree(ks);
 	kfree(client);
 
-	dprintk( "ks0127: detach\n" );
+	dprintk("ks0127: detach\n");
 	return 0;
 }
 
 
-static int ks0127_init_module(void)
+static int __devinit ks0127_init_module(void)
 {
 	init_reg_defaults();
 	i2c_add_driver(&i2c_driver_ks0127);
 	return 0;
 }
 
-static void ks0127_cleanup_module(void)
+static void __devexit ks0127_cleanup_module(void)
 {
 	i2c_del_driver(&i2c_driver_ks0127);
 }
@@ -806,12 +844,3 @@ static void ks0127_cleanup_module(void)
 
 module_init(ks0127_init_module);
 module_exit(ks0127_cleanup_module);
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-basic-offset: 8
- * compile-command: "cd ../../.. && make modules SUBDIRS=drivers/media/video"
- * End:
- */
