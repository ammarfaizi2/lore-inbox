Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280807AbRKOKJu>; Thu, 15 Nov 2001 05:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280808AbRKOKJn>; Thu, 15 Nov 2001 05:09:43 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19723 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280807AbRKOKJ1>; Thu, 15 Nov 2001 05:09:27 -0500
Subject: CS423x audio driver updates for testing
To: linux-kernel@vger.kernel.org
Date: Thu, 15 Nov 2001 10:17:12 +0000 (GMT)
Cc: whampton@staffnet.com, cobra@linse.ufsc.br
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E164Ja5-0007qT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This gets rid of the nasty clicks on the thinkpad. On the TP600 this leaves
us with fully functional sound including save/restore (if your bios is
not too ancient at least). The mixer changes are from Daniel Cobra, I added
the ident changes and made the driver pick the right (I hope) feature sets
for each board.

Can folks with cs42xx series audio give it a test make sure it doesn't break
anything

Alan


--- linux.vanilla/drivers/sound/ad1848.c	Thu Oct 11 13:52:12 2001
+++ linux.merge/drivers/sound/ad1848.c	Wed Nov 14 17:08:55 2001
@@ -30,6 +30,12 @@
  * Aki Laukkanen	: added power management support
  * Arnaldo C. de Melo	: added missing restore_flags in ad1848_resume
  * Miguel Freitas       : added ISA PnP support
+ * Alan Cox		: Added CS4236->4239 identification
+ * Daniel T. Cobra	: Alernate config/mixer for later chips
+ * Alan Cox		: Merged chip idents and config code
+ *
+ * TODO
+ *		APM save restore assist code on IBM thinkpad
  *
  * Status:
  *		Tested. Believed fully functional.
@@ -57,7 +63,7 @@
 	int             dual_dma;	/* 1, when two DMA channels allocated */
 	int 		subtype;
 	unsigned char   MCE_bit;
-	unsigned char   saved_regs[32];
+	unsigned char   saved_regs[64];	/* Includes extended register space */
 	int             debug_flag;
 
 	int             audio_flags;
@@ -78,6 +84,9 @@
 #define MD_IWAVE	7
 #define MD_4235         8 /* Crystal Audio CS4235  */
 #define MD_1845_SSCAPE  9 /* Ensoniq Soundscape PNP*/
+#define MD_4236		10 /* 4236 and higher */
+#define MD_42xB		11 /* CS 42xB */
+#define MD_4239		12 /* CS4239 */
 
 	/* Mixer parameters */
 	int             recmask;
@@ -202,9 +211,22 @@
 
 	save_flags(flags);
 	cli();
-	outb(((unsigned char) (reg & 0xff) | devc->MCE_bit), io_Index_Addr(devc));
-	x = inb(io_Indexed_Data(devc));
-/* printk("(%02x<-%02x) ", reg|devc->MCE_bit, x); */
+	
+	if(reg < 32)
+	{
+		outb(((unsigned char) (reg & 0xff) | devc->MCE_bit), io_Index_Addr(devc));
+		x = inb(io_Indexed_Data(devc));
+	}
+	else
+	{
+		int xreg, xra;
+
+		xreg = (reg & 0xff) - 32;
+		xra = (((xreg & 0x0f) << 4) & 0xf0) | 0x08 | ((xreg & 0x10) >> 2);
+		outb(((unsigned char) (23 & 0xff) | devc->MCE_bit), io_Index_Addr(devc));
+		outb(((unsigned char) (xra & 0xff)), io_Indexed_Data(devc));
+		x = inb(io_Indexed_Data(devc));
+	}
 	restore_flags(flags);
 
 	return x;
@@ -220,9 +242,22 @@
 
 	save_flags(flags);
 	cli();
-	outb(((unsigned char) (reg & 0xff) | devc->MCE_bit), io_Index_Addr(devc));
-	outb(((unsigned char) (data & 0xff)), io_Indexed_Data(devc));
-	/* printk("(%02x->%02x) ", reg|devc->MCE_bit, data); */
+	
+	if(reg < 32)
+	{
+		outb(((unsigned char) (reg & 0xff) | devc->MCE_bit), io_Index_Addr(devc));
+		outb(((unsigned char) (data & 0xff)), io_Indexed_Data(devc));
+	}
+	else
+	{
+		int xreg, xra;
+		
+		xreg = (reg & 0xff) - 32;
+		xra = (((xreg & 0x0f) << 4) & 0xf0) | 0x08 | ((xreg & 0x10) >> 2);
+		outb(((unsigned char) (23 & 0xff) | devc->MCE_bit), io_Index_Addr(devc));
+		outb(((unsigned char) (xra & 0xff)), io_Indexed_Data(devc));
+		outb((unsigned char) (data & 0xff), io_Indexed_Data(devc));
+	}
 	restore_flags(flags);
 }
 
@@ -591,7 +626,13 @@
 			devc->mix_devices = &(iwave_mix_devices[0]);
 			break;
 
+		case MD_42xB:
+		case MD_4239:
+			devc->mix_devices = &(cs42xb_mix_devices[0]);
+			devc->supported_devices = MODE3_MIXER_DEVICES;
+			break;
 		case MD_4232:
+		case MD_4236:
 			devc->supported_devices = MODE3_MIXER_DEVICES;
 			break;
 
@@ -1118,7 +1159,7 @@
 	}
 	old_fs = ad_read(devc, 8);
 
-	if (devc->model == MD_4232)
+	if (devc->model == MD_4232 || devc->model >= MD_4236)
 	{
 		tmp = ad_read(devc, 16);
 		ad_write(devc, 16, tmp | 0x30);
@@ -1139,7 +1180,7 @@
 	while (timeout < 10000 && inb(devc->base) == 0x80)
 		timeout++;
 
-	if (devc->model == MD_4232)
+	if (devc->model >= MD_4232)
 		ad_write(devc, 16, tmp & ~0x30);
 
 	ad_leave_MCE(devc);	/*
@@ -1403,11 +1444,12 @@
 static void ad1848_init_hw(ad1848_info * devc)
 {
 	int i;
+	int *init_values;
 
 	/*
 	 * Initial values for the indirect registers of CS4248/AD1848.
 	 */
-	static int      init_values[] =
+	static int      init_values_a[] =
 	{
 		0xa8, 0xa8, 0x08, 0x08, 0x08, 0x08, 0x00, 0x00,
 		0x00, 0x0c, 0x02, 0x00, 0x8a, 0x01, 0x00, 0x00,
@@ -1417,6 +1459,31 @@
 		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
 	};
 
+	static int      init_values_b[] =
+	{
+		/* 
+		   Values for the newer chips
+		   Some of the register initialization values were changed. In
+		   order to get rid of the click that preceded PCM playback,
+		   calibration was disabled on the 10th byte. On that same byte,
+		   dual DMA was enabled; on the 11th byte, ADC dithering was
+		   enabled, since that is theoretically desirable; on the 13th
+		   byte, Mode 3 was selected, to enable access to extended
+		   registers.
+		 */
+		0xa8, 0xa8, 0x08, 0x08, 0x08, 0x08, 0x00, 0x00,
+		0x00, 0x00, 0x06, 0x00, 0xe0, 0x01, 0x00, 0x00,
+ 		0x80, 0x00, 0x10, 0x10, 0x00, 0x00, 0x1f, 0x40,
+ 		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+	};
+
+	/*
+	 *	Select initialisation data
+	 */
+	 
+	init_values = init_values_a;
+	if(devc->model >= MD_4236)
+		init_values = init_values_b;
 
 	for (i = 0; i < 16; i++)
 		ad_write(devc, i, init_values[i]);
@@ -1768,19 +1835,49 @@
 				else
 				{
 					switch (id & 0x1f) {
-					case 3: /* CS4236/CS4235 */
+					case 3: /* CS4236/CS4235/CS42xB/CS4239 */
 						{
 							int xid;
 							ad_write(devc, 12, ad_read(devc, 12) | 0x60); /* switch to mode 3 */
 							ad_write(devc, 23, 0x9c); /* select extended register 25 */
 							xid = inb(io_Indexed_Data(devc));
 							ad_write(devc, 12, ad_read(devc, 12) & ~0x60); /* back to mode 0 */
-							if ((xid & 0x1f) == 0x1d) {
-								devc->chip_name = "CS4235";
-								devc->model = MD_4235;
-							} else {
-								devc->chip_name = "CS4236";
-								devc->model = MD_4232;
+							switch (xid & 0x1f)
+							{
+								case 0x00:
+									devc->chip_name = "CS4237B(B)";
+									devc->model = MD_42xB;
+									break;
+								case 0x08:
+									/* Seems to be a 4238 ?? */
+									devc->chip_name = "CS4238";
+									devc->model = MD_42xB;
+									break;
+								case 0x09:
+									devc->chip_name = "CS4238B";
+									devc->model = MD_42xB;
+									break;
+								case 0x0b:
+									devc->chip_name = "CS4236B";
+									devc->model = MD_4236;
+									break;
+								case 0x10:
+									devc->chip_name = "CS4237B";
+									devc->model = MD_42xB;
+									break;
+								case 0x1d:
+									devc->chip_name = "CS4235";
+									devc->model = MD_4235;
+									break;
+								case 0x1e:
+									devc->chip_name = "CS4239";
+									devc->model = MD_4239;
+									break;
+								default:
+									printk("Chip ident is %X.\n", xid&0x1F);
+									devc->chip_name = "CS42xx";
+									devc->model = MD_4232;
+									break;
 							}
 						}
 						break;
@@ -2747,6 +2844,10 @@
 
 	save_flags(flags);
 	cli();
+	
+	/* Thinkpad is a bit more of PITA than normal. The BIOS tends to
+	   restore it in a different config to the one we use.  Need to
+	   fix this somehow */
 
 	/* store old mixer levels */
 	memcpy(mixer_levels, devc->levels, sizeof (mixer_levels));  
--- linux.vanilla/drivers/sound/ad1848_mixer.h	Sun Mar  7 23:22:06 1999
+++ linux.merge/drivers/sound/ad1848_mixer.h	Wed Nov 14 14:40:42 2001
@@ -57,14 +57,14 @@
 				 SOUND_MASK_OGAIN)
 
 struct mixer_def {
-	unsigned int regno:5;		/* register number for volume */
+	unsigned int regno:6;		/* register number for volume */
 	unsigned int polarity:1;	/* volume polarity: 0=normal, 1=reversed */
 	unsigned int bitpos:3;		/* position of bits in register for volume */
 	unsigned int nbits:3;		/* number of bits in register for volume */
-	unsigned int mutereg:5;		/* register number for mute bit */
+	unsigned int mutereg:6;		/* register number for mute bit */
 	unsigned int mutepol:1;		/* mute polarity: 0=normal, 1=reversed */
 	unsigned int mutepos:4;		/* position of mute bit in register */
-	unsigned int recreg:5;		/* register number for recording bit */
+	unsigned int recreg:6;		/* register number for recording bit */
 	unsigned int recpol:1;		/* recording polarity: 0=normal, 1=reversed */
 	unsigned int recpos:4;		/* position of recording bit in register */
 };
@@ -104,43 +104,69 @@
 		    rec_reg_r, rec_pola_r, rec_pos_r}}
 
 static mixer_ents ad1848_mix_devices[32] = {
-MIX_ENT(SOUND_MIXER_VOLUME,	27, 1, 0, 4,	29, 1, 0, 4,  8),
-MIX_ENT(SOUND_MIXER_BASS,	 0, 0, 0, 0,	 0, 0, 0, 0,  8),
-MIX_ENT(SOUND_MIXER_TREBLE,	 0, 0, 0, 0,	 0, 0, 0, 0,  8),
-MIX_ENT(SOUND_MIXER_SYNTH,	 4, 1, 0, 5,	 5, 1, 0, 5,  7),
-MIX_ENT(SOUND_MIXER_PCM,	 6, 1, 0, 6,	 7, 1, 0, 6,  7),
-MIX_ENT(SOUND_MIXER_SPEAKER,	26, 1, 0, 4,	 0, 0, 0, 0,  8),
-MIX_ENT(SOUND_MIXER_LINE,	18, 1, 0, 5,	19, 1, 0, 5,  7),
-MIX_ENT(SOUND_MIXER_MIC,	 0, 0, 5, 1,	 1, 0, 5, 1,  8),
-MIX_ENT(SOUND_MIXER_CD,		 2, 1, 0, 5,	 3, 1, 0, 5,  7),
-MIX_ENT(SOUND_MIXER_IMIX,	13, 1, 2, 6,	 0, 0, 0, 0,  8),
-MIX_ENT(SOUND_MIXER_ALTPCM,	 0, 0, 0, 0,	 0, 0, 0, 0,  8),
-MIX_ENT(SOUND_MIXER_RECLEV,	 0, 0, 0, 0,	 0, 0, 0, 0,  8),
-MIX_ENT(SOUND_MIXER_IGAIN,	 0, 0, 0, 4,	 1, 0, 0, 4,  8),
-MIX_ENT(SOUND_MIXER_OGAIN,	 0, 0, 0, 0,	 0, 0, 0, 0,  8),
-MIX_ENT(SOUND_MIXER_LINE1,	 2, 1, 0, 5,	 3, 1, 0, 5,  7),
-MIX_ENT(SOUND_MIXER_LINE2,	 4, 1, 0, 5,	 5, 1, 0, 5,  7),
-MIX_ENT(SOUND_MIXER_LINE3,	18, 1, 0, 5,	19, 1, 0, 5,  7)
+	MIX_ENT(SOUND_MIXER_VOLUME,	27, 1, 0, 4,	29, 1, 0, 4,  8),
+	MIX_ENT(SOUND_MIXER_BASS,	 0, 0, 0, 0,	 0, 0, 0, 0,  8),
+	MIX_ENT(SOUND_MIXER_TREBLE,	 0, 0, 0, 0,	 0, 0, 0, 0,  8),
+	MIX_ENT(SOUND_MIXER_SYNTH,	 4, 1, 0, 5,	 5, 1, 0, 5,  7),
+	MIX_ENT(SOUND_MIXER_PCM,	 6, 1, 0, 6,	 7, 1, 0, 6,  7),
+	MIX_ENT(SOUND_MIXER_SPEAKER,	26, 1, 0, 4,	 0, 0, 0, 0,  8),
+	MIX_ENT(SOUND_MIXER_LINE,	18, 1, 0, 5,	19, 1, 0, 5,  7),
+	MIX_ENT(SOUND_MIXER_MIC,	 0, 0, 5, 1,	 1, 0, 5, 1,  8),
+	MIX_ENT(SOUND_MIXER_CD,		 2, 1, 0, 5,	 3, 1, 0, 5,  7),
+	MIX_ENT(SOUND_MIXER_IMIX,	13, 1, 2, 6,	 0, 0, 0, 0,  8),
+	MIX_ENT(SOUND_MIXER_ALTPCM,	 0, 0, 0, 0,	 0, 0, 0, 0,  8),
+	MIX_ENT(SOUND_MIXER_RECLEV,	 0, 0, 0, 0,	 0, 0, 0, 0,  8),
+	MIX_ENT(SOUND_MIXER_IGAIN,	 0, 0, 0, 4,	 1, 0, 0, 4,  8),
+	MIX_ENT(SOUND_MIXER_OGAIN,	 0, 0, 0, 0,	 0, 0, 0, 0,  8),
+	MIX_ENT(SOUND_MIXER_LINE1,	 2, 1, 0, 5,	 3, 1, 0, 5,  7),
+	MIX_ENT(SOUND_MIXER_LINE2,	 4, 1, 0, 5,	 5, 1, 0, 5,  7),
+	MIX_ENT(SOUND_MIXER_LINE3,	18, 1, 0, 5,	19, 1, 0, 5,  7)
 };
 
 static mixer_ents iwave_mix_devices[32] = {
-MIX_ENT(SOUND_MIXER_VOLUME,	25, 1, 0, 5,	27, 1, 0, 5,  8),
-MIX_ENT(SOUND_MIXER_BASS,	 0, 0, 0, 0,	 0, 0, 0, 0,  8),
-MIX_ENT(SOUND_MIXER_TREBLE,	 0, 0, 0, 0,	 0, 0, 0, 0,  8),
-MIX_ENT(SOUND_MIXER_SYNTH,	 4, 1, 0, 5,	 5, 1, 0, 5,  7),
-MIX_ENT(SOUND_MIXER_PCM,	 6, 1, 0, 6,	 7, 1, 0, 6,  7),
-MIX_ENT(SOUND_MIXER_SPEAKER,	26, 1, 0, 4,	 0, 0, 0, 0,  8),
-MIX_ENT(SOUND_MIXER_LINE,	18, 1, 0, 5,	19, 1, 0, 5,  7),
-MIX_ENT(SOUND_MIXER_MIC,	 0, 0, 5, 1,	 1, 0, 5, 1,  8),
-MIX_ENT(SOUND_MIXER_CD,		 2, 1, 0, 5,	 3, 1, 0, 5,  7),
-MIX_ENT(SOUND_MIXER_IMIX,	16, 1, 0, 5,	17, 1, 0, 5,  8),
-MIX_ENT(SOUND_MIXER_ALTPCM,	 0, 0, 0, 0,	 0, 0, 0, 0,  8),
-MIX_ENT(SOUND_MIXER_RECLEV,	 0, 0, 0, 0,	 0, 0, 0, 0,  8),
-MIX_ENT(SOUND_MIXER_IGAIN,	 0, 0, 0, 4,	 1, 0, 0, 4,  8),
-MIX_ENT(SOUND_MIXER_OGAIN,	 0, 0, 0, 0,	 0, 0, 0, 0,  8),
-MIX_ENT(SOUND_MIXER_LINE1,	 2, 1, 0, 5,	 3, 1, 0, 5,  7),
-MIX_ENT(SOUND_MIXER_LINE2,	 4, 1, 0, 5,	 5, 1, 0, 5,  7),
-MIX_ENT(SOUND_MIXER_LINE3,	18, 1, 0, 5,	19, 1, 0, 5,  7)
+	MIX_ENT(SOUND_MIXER_VOLUME,	25, 1, 0, 5,	27, 1, 0, 5,  8),
+	MIX_ENT(SOUND_MIXER_BASS,	 0, 0, 0, 0,	 0, 0, 0, 0,  8),
+	MIX_ENT(SOUND_MIXER_TREBLE,	 0, 0, 0, 0,	 0, 0, 0, 0,  8),
+	MIX_ENT(SOUND_MIXER_SYNTH,	 4, 1, 0, 5,	 5, 1, 0, 5,  7),
+	MIX_ENT(SOUND_MIXER_PCM,	 6, 1, 0, 6,	 7, 1, 0, 6,  7),
+	MIX_ENT(SOUND_MIXER_SPEAKER,	26, 1, 0, 4,	 0, 0, 0, 0,  8),
+	MIX_ENT(SOUND_MIXER_LINE,	18, 1, 0, 5,	19, 1, 0, 5,  7),
+	MIX_ENT(SOUND_MIXER_MIC,	 0, 0, 5, 1,	 1, 0, 5, 1,  8),
+	MIX_ENT(SOUND_MIXER_CD,		 2, 1, 0, 5,	 3, 1, 0, 5,  7),
+	MIX_ENT(SOUND_MIXER_IMIX,	16, 1, 0, 5,	17, 1, 0, 5,  8),
+	MIX_ENT(SOUND_MIXER_ALTPCM,	 0, 0, 0, 0,	 0, 0, 0, 0,  8),
+	MIX_ENT(SOUND_MIXER_RECLEV,	 0, 0, 0, 0,	 0, 0, 0, 0,  8),
+	MIX_ENT(SOUND_MIXER_IGAIN,	 0, 0, 0, 4,	 1, 0, 0, 4,  8),
+	MIX_ENT(SOUND_MIXER_OGAIN,	 0, 0, 0, 0,	 0, 0, 0, 0,  8),
+	MIX_ENT(SOUND_MIXER_LINE1,	 2, 1, 0, 5,	 3, 1, 0, 5,  7),
+	MIX_ENT(SOUND_MIXER_LINE2,	 4, 1, 0, 5,	 5, 1, 0, 5,  7),
+	MIX_ENT(SOUND_MIXER_LINE3,	18, 1, 0, 5,	19, 1, 0, 5,  7)
+};
+
+static mixer_ents cs42xb_mix_devices[32] = {
+	/* Digital master volume actually has seven bits, but we only use
+	   six to avoid the discontinuity when the analog gain kicks in. */
+	MIX_ENT(SOUND_MIXER_VOLUME,	46, 1, 0, 6,	47, 1, 0, 6,  7),
+	MIX_ENT(SOUND_MIXER_BASS,	 0, 0, 0, 0,	 0, 0, 0, 0,  8),
+	MIX_ENT(SOUND_MIXER_TREBLE,	 0, 0, 0, 0,	 0, 0, 0, 0,  8),
+	MIX_ENT(SOUND_MIXER_SYNTH,	 4, 1, 0, 5,	 5, 1, 0, 5,  7),
+	MIX_ENT(SOUND_MIXER_PCM,	 6, 1, 0, 6,	 7, 1, 0, 6,  7),
+	MIX_ENT(SOUND_MIXER_SPEAKER,	26, 1, 0, 4,	 0, 0, 0, 0,  8),
+	MIX_ENT(SOUND_MIXER_LINE,	18, 1, 0, 5,	19, 1, 0, 5,  7),
+	MIX_ENT(SOUND_MIXER_MIC,	34, 1, 0, 5,	35, 1, 0, 5,  7),
+	MIX_ENT(SOUND_MIXER_CD,		 2, 1, 0, 5,	 3, 1, 0, 5,  7),
+	/* For the IMIX entry, it was not possible to use the MIX_ENT macro
+	   because the mute bit is in different positions for the two
+	   channels and requires reverse polarity. */
+	[SOUND_MIXER_IMIX] = {{13, 1, 2, 6, 13, 1, 0, 0, 0, 8},
+		      {42, 1, 0, 6, 42, 1, 7, 0, 0, 8}},
+	MIX_ENT(SOUND_MIXER_ALTPCM,	 0, 0, 0, 0,	 0, 0, 0, 0,  8),
+	MIX_ENT(SOUND_MIXER_RECLEV,	 0, 0, 0, 0,	 0, 0, 0, 0,  8),
+	MIX_ENT(SOUND_MIXER_IGAIN,	 0, 0, 0, 4,	 1, 0, 0, 4,  8),
+	MIX_ENT(SOUND_MIXER_OGAIN,	 0, 0, 0, 0,	 0, 0, 0, 0,  8),
+	MIX_ENT(SOUND_MIXER_LINE1,	 2, 1, 0, 5,	 3, 1, 0, 5,  7),
+	MIX_ENT(SOUND_MIXER_LINE2,	 4, 1, 0, 5,	 5, 1, 0, 5,  7),
+	MIX_ENT(SOUND_MIXER_LINE3,	38, 1, 0, 6,	39, 1, 0, 6,  7)
 };
 
 /* OPTi 82C930 has somewhat different port addresses.
@@ -149,68 +175,68 @@
  * MIC is level of mic monitoring direct to output. Same for CD, LINE, etc.
  */
 static mixer_ents c930_mix_devices[32] = {
-MIX_ENT(SOUND_MIXER_VOLUME,	22, 1, 1, 5,	23, 1, 1, 5,  7),
-MIX_ENT(SOUND_MIXER_BASS,	 0, 0, 0, 0,	 0, 0, 0, 0,  8),
-MIX_ENT(SOUND_MIXER_TREBLE,	 0, 0, 0, 0,	 0, 0, 0, 0,  8),
-MIX_ENT(SOUND_MIXER_SYNTH,	 4, 1, 1, 4,	 5, 1, 1, 4,  7),
-MIX_ENT(SOUND_MIXER_PCM,	 6, 1, 0, 5,	 7, 1, 0, 5,  7),
-MIX_ENT(SOUND_MIXER_SPEAKER,	22, 1, 1, 5,	23, 1, 1, 5,  7),
-MIX_ENT(SOUND_MIXER_LINE,	18, 1, 1, 4,	19, 1, 1, 4,  7),
-MIX_ENT(SOUND_MIXER_MIC,	20, 1, 1, 4,	21, 1, 1, 4,  7),
-MIX_ENT(SOUND_MIXER_CD,		 2, 1, 1, 4,	 3, 1, 1, 4,  7),
-MIX_ENT(SOUND_MIXER_IMIX,	 0, 0, 0, 0,	 0, 0, 0, 0,  8),
-MIX_ENT(SOUND_MIXER_ALTPCM,	 0, 0, 0, 0,	 0, 0, 0, 0,  8),
-MIX_ENT(SOUND_MIXER_RECLEV,	 0, 0, 0, 0,	 0, 0, 0, 0,  8),
-MIX_ENT(SOUND_MIXER_IGAIN,	 0, 0, 0, 4,	 1, 0, 0, 4,  8),
-MIX_ENT(SOUND_MIXER_OGAIN,	 0, 0, 0, 0,	 0, 0, 0, 0,  8),
-MIX_ENT(SOUND_MIXER_LINE1,	 2, 1, 1, 4,	 3, 1, 1, 4,  7),
-MIX_ENT(SOUND_MIXER_LINE2,	 4, 1, 1, 4,	 5, 1, 1, 4,  7),
-MIX_ENT(SOUND_MIXER_LINE3,	18, 1, 1, 4,	19, 1, 1, 4,  7)
+	MIX_ENT(SOUND_MIXER_VOLUME,	22, 1, 1, 5,	23, 1, 1, 5,  7),
+	MIX_ENT(SOUND_MIXER_BASS,	 0, 0, 0, 0,	 0, 0, 0, 0,  8),
+	MIX_ENT(SOUND_MIXER_TREBLE,	 0, 0, 0, 0,	 0, 0, 0, 0,  8),
+	MIX_ENT(SOUND_MIXER_SYNTH,	 4, 1, 1, 4,	 5, 1, 1, 4,  7),
+	MIX_ENT(SOUND_MIXER_PCM,	 6, 1, 0, 5,	 7, 1, 0, 5,  7),
+	MIX_ENT(SOUND_MIXER_SPEAKER,	22, 1, 1, 5,	23, 1, 1, 5,  7),
+	MIX_ENT(SOUND_MIXER_LINE,	18, 1, 1, 4,	19, 1, 1, 4,  7),
+	MIX_ENT(SOUND_MIXER_MIC,	20, 1, 1, 4,	21, 1, 1, 4,  7),
+	MIX_ENT(SOUND_MIXER_CD,		 2, 1, 1, 4,	 3, 1, 1, 4,  7),
+	MIX_ENT(SOUND_MIXER_IMIX,	 0, 0, 0, 0,	 0, 0, 0, 0,  8),
+	MIX_ENT(SOUND_MIXER_ALTPCM,	 0, 0, 0, 0,	 0, 0, 0, 0,  8),
+	MIX_ENT(SOUND_MIXER_RECLEV,	 0, 0, 0, 0,	 0, 0, 0, 0,  8),
+	MIX_ENT(SOUND_MIXER_IGAIN,	 0, 0, 0, 4,	 1, 0, 0, 4,  8),
+	MIX_ENT(SOUND_MIXER_OGAIN,	 0, 0, 0, 0,	 0, 0, 0, 0,  8),
+	MIX_ENT(SOUND_MIXER_LINE1,	 2, 1, 1, 4,	 3, 1, 1, 4,  7),
+	MIX_ENT(SOUND_MIXER_LINE2,	 4, 1, 1, 4,	 5, 1, 1, 4,  7),
+	MIX_ENT(SOUND_MIXER_LINE3,	18, 1, 1, 4,	19, 1, 1, 4,  7)
 };
 
 static mixer_ents spro_mix_devices[32] = {
-MIX_ENT (SOUND_MIXER_VOLUME,	19, 0, 4, 4,			 19, 0, 0, 4,  8),
-MIX_ENT (SOUND_MIXER_BASS,	 0, 0, 0, 0,			  0, 0, 0, 0,  8),
-MIX_ENT (SOUND_MIXER_TREBLE,	 0, 0, 0, 0,			  0, 0, 0, 0,  8),
-MIX_ENT2(SOUND_MIXER_SYNTH,	 4, 1, 1, 4, 23, 0, 3,  0, 0, 8,
-	 			 5, 1, 1, 4, 23, 0, 3, 0, 0, 8),
-MIX_ENT (SOUND_MIXER_PCM,	 6, 1, 1, 4,			  7, 1, 1, 4,  8),
-MIX_ENT (SOUND_MIXER_SPEAKER,	18, 0, 3, 2,			  0, 0, 0, 0,  8),
-MIX_ENT2(SOUND_MIXER_LINE,	20, 0, 4, 4, 17, 1, 4, 16, 0, 2,
-	 			20, 0, 0, 4, 17, 1, 3, 16, 0, 1),
-MIX_ENT2(SOUND_MIXER_MIC,	18, 0, 0, 3, 17, 1, 0, 16, 0, 0,
-	 			 0, 0, 0, 0,  0, 0, 0,  0, 0, 0),
-MIX_ENT2(SOUND_MIXER_CD,	21, 0, 4, 4, 17, 1, 2, 16, 0, 4,
-				21, 0, 0, 4, 17, 1, 1, 16, 0, 3),
-MIX_ENT (SOUND_MIXER_IMIX,	 0, 0, 0, 0,			  0, 0, 0, 0,  8),
-MIX_ENT (SOUND_MIXER_ALTPCM,	 0, 0, 0, 0,			  0, 0, 0, 0,  8),
-MIX_ENT (SOUND_MIXER_RECLEV,	 0, 0, 0, 0,			  0, 0, 0, 0,  8),
-MIX_ENT (SOUND_MIXER_IGAIN,	 0, 0, 0, 0,			  0, 0, 0, 0,  8),
-MIX_ENT (SOUND_MIXER_OGAIN,	17, 1, 6, 1,			  0, 0, 0, 0,  8),
-/* This is external wavetable */
-MIX_ENT2(SOUND_MIXER_LINE1,	22, 0, 4, 4, 23, 1, 1, 23, 0, 4,
-	 			22, 0, 0, 4, 23, 1, 0, 23, 0, 5),
+	MIX_ENT (SOUND_MIXER_VOLUME,	19, 0, 4, 4,			 19, 0, 0, 4,  8),
+	MIX_ENT (SOUND_MIXER_BASS,	 0, 0, 0, 0,			  0, 0, 0, 0,  8),
+	MIX_ENT (SOUND_MIXER_TREBLE,	 0, 0, 0, 0,			  0, 0, 0, 0,  8),
+	MIX_ENT2(SOUND_MIXER_SYNTH,	 4, 1, 1, 4, 23, 0, 3,  0, 0, 8,
+		 			 5, 1, 1, 4, 23, 0, 3, 0, 0, 8),
+	MIX_ENT (SOUND_MIXER_PCM,	 6, 1, 1, 4,			  7, 1, 1, 4,  8),
+	MIX_ENT (SOUND_MIXER_SPEAKER,	18, 0, 3, 2,			  0, 0, 0, 0,  8),
+	MIX_ENT2(SOUND_MIXER_LINE,	20, 0, 4, 4, 17, 1, 4, 16, 0, 2,
+		 			20, 0, 0, 4, 17, 1, 3, 16, 0, 1),
+	MIX_ENT2(SOUND_MIXER_MIC,	18, 0, 0, 3, 17, 1, 0, 16, 0, 0,
+		 			 0, 0, 0, 0,  0, 0, 0,  0, 0, 0),
+	MIX_ENT2(SOUND_MIXER_CD,	21, 0, 4, 4, 17, 1, 2, 16, 0, 4,
+					21, 0, 0, 4, 17, 1, 1, 16, 0, 3),
+	MIX_ENT (SOUND_MIXER_IMIX,	 0, 0, 0, 0,			  0, 0, 0, 0,  8),
+	MIX_ENT (SOUND_MIXER_ALTPCM,	 0, 0, 0, 0,			  0, 0, 0, 0,  8),
+	MIX_ENT (SOUND_MIXER_RECLEV,	 0, 0, 0, 0,			  0, 0, 0, 0,  8),
+	MIX_ENT (SOUND_MIXER_IGAIN,	 0, 0, 0, 0,			  0, 0, 0, 0,  8),
+	MIX_ENT (SOUND_MIXER_OGAIN,	17, 1, 6, 1,			  0, 0, 0, 0,  8),
+	/* This is external wavetable */
+	MIX_ENT2(SOUND_MIXER_LINE1,	22, 0, 4, 4, 23, 1, 1, 23, 0, 4,
+		 			22, 0, 0, 4, 23, 1, 0, 23, 0, 5),
 };
 
 static int default_mixer_levels[32] =
 {
-  0x3232,			/* Master Volume */
-  0x3232,			/* Bass */
-  0x3232,			/* Treble */
-  0x4b4b,			/* FM */
-  0x3232,			/* PCM */
-  0x1515,			/* PC Speaker */
-  0x2020,			/* Ext Line */
-  0x1010,			/* Mic */
-  0x4b4b,			/* CD */
-  0x0000,			/* Recording monitor */
-  0x4b4b,			/* Second PCM */
-  0x4b4b,			/* Recording level */
-  0x4b4b,			/* Input gain */
-  0x4b4b,			/* Output gain */
-  0x2020,			/* Line1 */
-  0x2020,			/* Line2 */
-  0x1515			/* Line3 (usually line in)*/
+	0x3232,			/* Master Volume */
+	0x3232,			/* Bass */
+	0x3232,			/* Treble */
+	0x4b4b,			/* FM */
+	0x3232,			/* PCM */
+	0x1515,			/* PC Speaker */
+	0x2020,			/* Ext Line */
+	0x1010,			/* Mic */
+	0x4b4b,			/* CD */
+	0x0000,			/* Recording monitor */
+	0x4b4b,			/* Second PCM */
+	0x4b4b,			/* Recording level */
+	0x4b4b,			/* Input gain */
+	0x4b4b,			/* Output gain */
+	0x2020,			/* Line1 */
+	0x2020,			/* Line2 */
+	0x1515			/* Line3 (usually line in)*/
 };
 
 #define LEFT_CHN	0
