Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143493AbRA1V21>; Sun, 28 Jan 2001 16:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130335AbRA1V2S>; Sun, 28 Jan 2001 16:28:18 -0500
Received: from mailgate.rz.uni-karlsruhe.de ([129.13.64.97]:56076 "EHLO
	mailgate.rz.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id <S143481AbRA1V2G>; Sun, 28 Jan 2001 16:28:06 -0500
To: Thomas Kalla <xTx@gmx.de>, linux-sound@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] aci.c and related files reworked for 2.4.0
From: Robert Siemer <Robert.Siemer@gmx.de>
In-Reply-To: <3A5CF3BF.2EFB52B5@gmx.de>
In-Reply-To: <3A5CF3BF.2EFB52B5@gmx.de>
X-Mailer: Mew version 1.94b25 on Emacs 20.5 / Mule 4.0 (HANANOEN)
Reply-To: Robert Siemer <siemer@panorama.hadiko.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010128222753R.siemer@panorama.hadiko.de>
Date: Sun, 28 Jan 2001 22:27:53 +0100
X-Dispatcher: imput version 990425(IM115)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas an linux-sound (:  !

I made up a new patch for the aci.c and related files. It's for
miroSOUND sound cards.

It applies cleanly against 2.4.0, but problems can occur when not
compiled as modules. - I will work on this issue, but my box has
problems booting completely into 2.4.0 (PCI IRQ routing...). So it
will take some time.

The patch is technically the same as in my initially post on
linux-kernel for test8:
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0009.2/0260.html


Thomas, please try it and tell me if it fits your needs.

Further I would be pleased to hear from more people using this sound
hardware... (:


Bye,
	Robert

diff -urN -X dontdiff linux-vanilla/CREDITS linux/CREDITS
--- linux-vanilla/CREDITS	Sun Dec 31 18:27:57 2000
+++ linux/CREDITS	Sat Jan 27 16:25:01 2001
@@ -2427,6 +2427,14 @@
 S: San Jose, California
 S: USA
 
+N: Robert Siemer
+E: Robert.Siemer@gmx.de
+P: 2048/C99A4289 2F DC 17 2E 56 62 01 C8  3D F2 AC 09 F2 E5 DD EE
+D: miroSOUND PCM20 radio RDS driver, ACI rewrite
+S: Klosterweg 28 / i309
+S: 76131 Karlsruhe
+S: Germany
+
 N: Jaspreet Singh
 E: jaspreet@sangoma.com
 W: www.sangoma.com
diff -urN -X dontdiff linux-vanilla/Documentation/Configure.help linux/Documentation/Configure.help
--- linux-vanilla/Documentation/Configure.help	Thu Jan  4 22:00:55 2001
+++ linux/Documentation/Configure.help	Sat Jan 27 16:25:02 2001
@@ -14336,7 +14336,7 @@
 
   If unsure, say Y.
 
-ACI mixer (miroPCM12/PCM20)
+ACI mixer (miroSOUND PCM1-pro/PCM12/PCM20)
 CONFIG_SOUND_ACI_MIXER
   ACI (Audio Command Interface) is a protocol used to communicate with
   the microcontroller on some sound cards produced by miro, e.g. the
@@ -14345,8 +14345,8 @@
 
   This Voxware ACI driver currently only supports the ACI functions on
   the miroSOUND PCM12 and PCM20 cards. On the PCM20, ACI also controls
-  the radio tuner. This is supported in the video4linux
-  radio-miropcm20 driver.
+  the radio tuner. This is supported in the video4linux miropcm20
+  driver.
 
 SB32/AWE support
 CONFIG_SOUND_AWE32_SYNTH
@@ -16087,11 +16087,11 @@
   say M here and read Documentation/modules.txt. The module will be
   called i2c-parport.o.
 
-Miro PCM20 Radio
+miroSOUND PCM20 radio
 CONFIG_RADIO_MIROPCM20
   Choose Y here if you have this FM radio card. You also need to say Y
-  to "ACI mixer (miroPCM12/PCM20)" (in "additional low level sound
-  drivers") for this to work.
+  to "ACI mixer (miroSOUND PCM1-pro/PCM12/PCM20)" (in "Sound") for
+  this to work.
 
   In order to control your radio card, you will need to use programs
   that are compatible with the Video for Linux API. Information on 
@@ -16101,7 +16101,7 @@
   If you want to compile this driver as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want),
   say M here and read Documentation/modules.txt. The module will be
-  called radio-miropcm20.o
+  called miropcm20.o
 
 GemTek Radio Card
 CONFIG_RADIO_GEMTEK
diff -urN -X dontdiff linux-vanilla/Documentation/sound/PCM1-pro linux/Documentation/sound/PCM1-pro
--- linux-vanilla/Documentation/sound/PCM1-pro	Tue Apr 13 01:18:27 1999
+++ linux/Documentation/sound/PCM1-pro	Thu Jan  1 01:00:00 1970
@@ -1,17 +0,0 @@
-In Documentation/sound/README.OSS was a remark saying noone was sure the
-mixer on the PCM1-pro worked with the ACI driver. Well, it does.
-I've been using the drivers for the MAD16 and the driver for the mixer
-since kernel 2.0.32 with a MiroSound PCM1-pro and it works great.
-
-I've got it working with the following configuration:
-
-MAD16 audio I/O base = 530
-MAD16  audio IRQ = 7
-MAD16 Audio DMA = 1
-MAD16 MIDI I/O = 330
-MAD16 MIDI IRQ = 9
-
-And I've enabled the ACI mixer (miro PCM12) .
-
-
-Bas van der Linden.
diff -urN -X dontdiff linux-vanilla/Documentation/sound/README.OSS linux/Documentation/sound/README.OSS
--- linux-vanilla/Documentation/sound/README.OSS	Fri Jul 28 21:50:52 2000
+++ linux/Documentation/sound/README.OSS	Sat Jan 27 16:23:15 2001
@@ -17,6 +17,7 @@
 document can be still interesting and very helpful.
 
 [ File edited 17.01.1999 - Riccardo Facchetti ]
+[ Edited miroSOUND section 17.09.2000 - Robert Siemer ]
 
 OSS/Free version 3.8 release notes
 ----------------------------------
@@ -1325,26 +1326,38 @@
 miroSOUND
 ---------
 
-The miroSOUND PCM12 has been used successfully. This card is based on
-the MAD16, OPL4, and CS4231A chips and everything said in the section
-about MAD16 cards applies here, too. The only major difference between
-the PCM12 and other MAD16 cards is that instead of the mixer in the
-CS4231 codec a separate mixer controlled by an on-board 80C32
-microcontroller is used. Control of the mixer takes place via the ACI
-(miro's audio control interface) protocol that is implemented in a
-separate lowlevel driver. Make sure you compile this ACI driver
-together with the normal MAD16 support when you use a miroSOUND PCM12
-card. The ACI mixer is controlled by /dev/mixer and the CS4231 mixer
-by /dev/mixer2. You usually don't want to change anything on the
-CS4231 mixer.
-
-The miroSOUND PCM12 is capable of full duplex operation (simultaneous
-PCM replay and recording), which allows you to implement nice
-real-time signal processing audio effect software and network
-telephones. The ACI mixer has to be configured into a special "solo"
+The miroSOUND PCM1-pro, PCM12 and PCM20 radio has been used
+successfully. This card is based on the MAD16, OPL4, and CS4231A chips
+and everything said in the section about MAD16 cards applies here,
+too. The only major difference between the PCMxx and other MAD16 cards
+is that instead of the mixer in the CS4231 codec a separate mixer
+controlled by an on-board 80C32 microcontroller is used. Control of
+the mixer takes place via the ACI (miro's audio control interface)
+protocol that is implemented in a separate lowlevel driver. Make sure
+you compile this ACI driver together with the normal MAD16 support
+when you use a miroSOUND PCMxx card. The ACI mixer is controlled by
+/dev/mixer and the CS4231 mixer by /dev/mixer1 (depends on load
+time). Only in special cases you want to change something on the CS4231
+mixer.
+
+The miroSOUND PCM12 and PCM20 radio is capable of full duplex
+operation (simultaneous PCM replay and recording), which allows you to
+implement nice real-time signal processing audio effect software and
+network telephones. The ACI mixer has to be switched into the "solo"
 mode for duplex operation in order to avoid feedback caused by the
-mixer (input hears output signal). See lowlevel/aci.c for details on
-the ioctl() for activating the "solo" mode.
+mixer (input hears output signal). You can de-/activate this mode
+through toggleing the record button for the wave controller with an
+OSS-mixer.
+
+The PCM20 contains a radio tuner, which is also controlled by
+ACI. This radio tuner is supported by the ACI driver together with the
+miropcm20-radio.o module. Also the 7-band equalizer is integrated
+(limited by the OSS-design). Developement has started and maybe
+finished for the RDS decoder on this card, too. You will be able to
+read radio text, the program service name, program type and
+others. Even the v4l radio module benefits from it with a refined
+strength value. See aci.c, radio-miropcm20.c and rds-miropcm20.c for
+more details.
 
 The following configuration parameters have worked fine for the PCM12
 in Markus Kuhn's system, many other configurations might work, too:
@@ -1352,13 +1365,8 @@
 CONFIG_MAD16_DMA2=0, CONFIG_MAD16_MPU_BASE=0x330, CONFIG_MAD16_MPU_IRQ=10,
 DSP_BUFFSIZE=65536, SELECTED_SOUND_OPTIONS=0x00281000.
 
-The miroSOUND PCM1 pro and the PCM20 are very similar to the PCM12.
-Perhaps the same ACI driver also works for these cards, however this
-has never actually been tested. The PCM20 contains a radio tuner,
-which is also controlled by ACI. This radio tuner is currently not
-supported by the ACI driver, but documentation for it was provided by
-miro and ACI tuner support could easily be added if someone is really
-interested.
+Bas van der Linden is using his PCM1-pro with a configuration that
+differs in: CONFIG_MAD16_IRQ=7, CONFIG_MAD16_DMA=1, CONFIG_MAD16_MPU_IRQ=9
 
 Compaq Deskpro XL
 -----------------
diff -urN -X dontdiff linux-vanilla/MAINTAINERS linux/MAINTAINERS
--- linux-vanilla/MAINTAINERS	Sun Dec 31 18:31:15 2000
+++ linux/MAINTAINERS	Sat Jan 27 18:07:16 2001
@@ -106,6 +106,13 @@
 L:	linux-net@vger.kernel.org
 S:	Maintained
 
+ACI MIXER DRIVER
+P:	Robert Siemer
+M:	Robert.Siemer@gmx.de
+L:	linux-sound@vger.kernel.org
+W:	http://www.uni-karlsruhe.de/~Robert.Siemer/Private/
+S:	Maintained
+
 ACPI
 P:	Andy Grover
 M:	andrew.grover@intel.com
diff -urN -X dontdiff linux-vanilla/drivers/media/radio/Config.in linux/drivers/media/radio/Config.in
--- linux-vanilla/drivers/media/radio/Config.in	Tue Sep 19 17:01:34 2000
+++ linux/drivers/media/radio/Config.in	Sat Jan 27 16:30:03 2001
@@ -22,7 +22,7 @@
    hex '    GemTek i/o port (0x20c, 0x30c, 0x24c or 0x34c)' CONFIG_RADIO_GEMTEK_PORT 34c
 fi
 dep_tristate '  Maestro on board radio' CONFIG_RADIO_MAESTRO $CONFIG_VIDEO_DEV
-dep_tristate '  Miro PCM20 Radio' CONFIG_RADIO_MIROPCM20 $CONFIG_VIDEO_DEV
+dep_tristate '  miroSOUND PCM20 radio' CONFIG_RADIO_MIROPCM20 $CONFIG_VIDEO_DEV
 dep_tristate '  SF16FMI Radio' CONFIG_RADIO_SF16FMI $CONFIG_VIDEO_DEV
 if [ "$CONFIG_RADIO_SF16FMI" = "y" ]; then
    hex '    SF16FMI I/O port (0x284 or 0x384)' CONFIG_RADIO_SF16FMI_PORT 284
diff -urN -X dontdiff linux-vanilla/drivers/media/radio/Makefile linux/drivers/media/radio/Makefile
--- linux-vanilla/drivers/media/radio/Makefile	Fri Dec 29 23:07:22 2000
+++ linux/drivers/media/radio/Makefile	Sat Jan 27 16:25:02 2001
@@ -23,7 +23,9 @@
 
 export-objs     :=	
 
-list-multi	:=	
+list-multi	:= miropcm20.o
+
+miropcm20-objs	:= radio-miropcm20.o rds-miropcm20.o
 
 obj-$(CONFIG_RADIO_AZTECH) += radio-aztech.o
 obj-$(CONFIG_RADIO_RTRACK2) += radio-rtrack2.o
@@ -33,9 +35,12 @@
 obj-$(CONFIG_RADIO_TERRATEC) += radio-terratec.o
 obj-$(CONFIG_RADIO_RTRACK) += radio-aimslab.o
 obj-$(CONFIG_RADIO_ZOLTRIX) += radio-zoltrix.o
-obj-$(CONFIG_RADIO_MIROPCM20) += radio-miropcm20.o
+obj-$(CONFIG_RADIO_MIROPCM20) += miropcm20.o
 obj-$(CONFIG_RADIO_GEMTEK) += radio-gemtek.o
 obj-$(CONFIG_RADIO_TRUST) += radio-trust.o
 obj-$(CONFIG_RADIO_MAESTRO) += radio-maestro.o
 
 include $(TOPDIR)/Rules.make
+
+miropcm20.o: $(miropcm20-objs)
+	$(LD) -r -o $@ $(miropcm20-objs)
diff -urN -X dontdiff linux-vanilla/drivers/media/radio/radio-miropcm20.c linux/drivers/media/radio/radio-miropcm20.c
--- linux-vanilla/drivers/media/radio/radio-miropcm20.c	Sat Nov 18 02:56:51 2000
+++ linux/drivers/media/radio/radio-miropcm20.c	Sat Jan 27 16:48:08 2001
@@ -2,62 +2,53 @@
  * (c) 1998 Ruurd Reitsma <R.A.Reitsma@wbmt.tudelft.nl>
  * Thanks to Norberto Pellici for the ACI device interface specification
  * The API part is based on the radiotrack driver by M. Kirkwood
- * This driver relies on the aci mixer (drivers/sound/lowlevel/aci.c)
+ * This driver relies on the aci mixer (drivers/sound/aci.c)
  * Look there for further info...
  */
 
-#include <linux/module.h>		/* Modules 			*/
-#include <linux/init.h>			/* Initdata			*/
-#include <asm/uaccess.h>		/* copy to/from user		*/
-#include <linux/videodev.h>		/* kernel radio structs		*/
-#include "../../sound/miroaci.h"	/* ACI Control by acimixer      */
+/* Revision history:
+ *
+ *   1998        Ruurd Reitsma <R.A.Reitsma@wbmt.tudelft.nl>
+ *   2000-09-05  Robert Siemer <Robert.Siemer@gmx.de>
+ *        removed unfinished volume control (maybe adding it later again)
+ *        use OSS-mixer; added stereo control
+ */
+
+/* What ever you think about the ACI, version 0x07 is not very well!
+ * I cant get frequency, 'tuner status', 'tuner flags' or mute/mono
+ * conditions...                Robert 
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/videodev.h>
+#include <linux/devfs_fs_kernel.h>
+#include <asm/uaccess.h>
+
+char * aci_radio_name;
+
+#include "../../sound/aci.h"
 
 static int users = 0;
 
 struct pcm20_device
 {
-	int port;
-	int curvol;
-	unsigned long curfreq;
+	unsigned long freq;
 	int muted;
+	int stereo;
 };
 
 
-/* local things */
-
-
-static void pcm20_mute(struct pcm20_device *dev)
+static int pcm20_mute(struct pcm20_device *dev, unsigned char mute)
 {
-
-	dev->muted = 1;
-	aci_write_cmd(0xa3,0x01);			
-
+	dev->muted = mute;
+	return aci_write_cmd(0xa3, mute);
 }
 
-static int pcm20_setvol(struct pcm20_device *dev, int vol)
+static int pcm20_stereo(struct pcm20_device *dev, unsigned char stereo)
 {
-
-	if(vol == dev->curvol) {	/* requested volume = current */
-		if (dev->muted) {	/* user is unmuting the card  */
-			dev->muted = 0;
-			aci_write_cmd(0xa3,0x00); 	/* enable card */
-		}	
-	
-		return 0;
-	}
-
-	if(vol == 0) {			/* volume = 0 means mute the card */
-		aci_write_cmd(0x3d, 0x20);
-		aci_write_cmd(0x35, 0x20);
-		return 0;
-	}
-
-	dev->muted = 0;
-	aci_write_cmd(0x3d, 32-vol); 	/* Right Channel */
-	aci_write_cmd(0x35, 32-vol);	/* Left Channel */
-	dev->curvol = vol;
-
-	return 0;
+	dev->stereo = stereo;
+	return aci_write_cmd(0xa4, !stereo);
 }
 
 static int pcm20_setfreq(struct pcm20_device *dev, unsigned long freq)
@@ -65,28 +56,79 @@
 	unsigned char freql;
 	unsigned char freqh;
 
-	freq = (freq * 10) / 16;
-	freql = freq & 0xff;
-	freqh = freq >> 8;	
+	dev->freq=freq;
 
+	freq /= 160;
+	if (!(aci_version==0x07 || aci_version>=0xb0))
+		freq /= 10;  /* I don't know exactly which version
+			      * needs this hack */
+	freql = freq & 0xff;
+	freqh = freq >> 8;
 
-	aci_write_cmd_d(0xa7, freql, freqh);	/*  Tune to frequency	*/
+	aci_rds_cmd(RDS_RESET, 0, 0);
+	pcm20_stereo(dev, 1);
 
-	return 0;
+	return aci_rw_cmd(0xa7, freql, freqh);	/*  Tune to frequency	*/
 }
 
-int pcm20_getsigstr(struct pcm20_device *dev)
+static int pcm20_getflags(struct pcm20_device *dev, __u32 *flags, __u16 *signal)
 {
+	/* okay, check for signal, stereo and rds here... */
+	int i;
 	unsigned char buf;
-	aci_indexed_cmd(0xf0, 0x32, &buf);
-	if ((buf & 0x80) == 0x80)	
+
+	if ((i=aci_rw_cmd(0xa9, -1, -1))<0)
+		return i;
+#if DEBUG
+	printk("check_sig: 0x%x\n", i);
+#endif
+	if (i & 0x80) {
+		/* no signal from tuner */
+		*flags=0;
+		*signal=0;
+		return 0;
+	} else
+		*signal=0xffff;
+
+	if ((i=aci_rw_cmd(0xa8, -1, -1))<0)
+		return i;
+	if (i & 0x40) {
+		*flags=0;
+	} else {
+		/* stereo */
+		*flags=VIDEO_TUNER_STEREO_ON;
+		/* I cant see stereo, when forced to mono */
+		dev->stereo=1;
+	}
+
+	if ((i=aci_rds_cmd(RDS_STATUS, &buf, 1))<0)
+		return i;
+	if (buf & 1)
+		/* RDS available */
+		*flags|=VIDEO_TUNER_RDS_ON;
+	else
 		return 0;
-	return 1;		/* signal present		*/
+
+	if ((i=aci_rds_cmd(RDS_RXVALUE, &buf, 1))<0)
+		return i;
+#if DEBUG
+	printk("rds-signal: %d\n", buf);
+#endif
+	if (buf > 15) {
+		printk("rds-miropcm20: RX strengths unexpected high...\n");
+		buf=15;
+	}
+	/* refine signal */
+	if ((*signal=SCALE(15, 0xffff, buf))==0)
+		*signal = 1;
+
+	return 0;
 }
 
 static int pcm20_ioctl(struct video_device *dev, unsigned int cmd, void *arg)
 {
 	struct pcm20_device *pcm20=dev->priv;
+	int i;
 	
 	switch(cmd)
 	{
@@ -113,11 +155,11 @@
 				return -EFAULT;
 			if(v.tuner)	/* Only 1 tuner */ 
 				return -EINVAL;
-			v.rangelow=(int)(87.5*16);
-			v.rangehigh=(int)(108.0*16);
-			v.flags=0;
+			v.rangelow=87*16000;
+			v.rangehigh=108*16000;
+			pcm20_getflags(pcm20, &v.flags, &v.signal);
+			v.flags|=VIDEO_TUNER_LOW;
 			v.mode=VIDEO_MODE_AUTO;
-			v.signal=0xFFFF*pcm20_getsigstr(pcm20);
 			strcpy(v.name, "FM");
 			if(copy_to_user(arg,&v, sizeof(v)))
 				return -EFAULT;
@@ -134,20 +176,28 @@
 			return 0;
 		}
 		case VIDIOCGFREQ:
-			if(copy_to_user(arg, &pcm20->curfreq, sizeof(pcm20->curfreq)))
+			if(copy_to_user(arg, &pcm20->freq, sizeof(pcm20->freq)))
 				return -EFAULT;
 			return 0;
 		case VIDIOCSFREQ:
-			if(copy_from_user(&pcm20->curfreq, arg,sizeof(pcm20->curfreq)))
+			if(copy_from_user(&pcm20->freq, arg, sizeof(pcm20->freq)))
 				return -EFAULT;
-			pcm20_setfreq(pcm20, pcm20->curfreq);
-			return 0;
+			i=pcm20_setfreq(pcm20, pcm20->freq);
+#if DEBUG
+			printk("First view (setfreq): 0x%x\n", i);
+#endif
+			return i;
 		case VIDIOCGAUDIO:
 		{	
 			struct video_audio v;
 			memset(&v,0, sizeof(v));
-			v.flags|=VIDEO_AUDIO_MUTABLE|VIDEO_AUDIO_VOLUME;
-			v.volume=pcm20->curvol * 2048;
+			v.flags=VIDEO_AUDIO_MUTABLE;
+			if (pcm20->muted)
+				v.flags|=VIDEO_AUDIO_MUTE;
+			v.mode=VIDEO_SOUND_STEREO;
+			if (pcm20->stereo)
+				v.mode|=VIDEO_SOUND_MONO;
+			/* v.step=2048; */
 			strcpy(v.name, "Radio");
 			if(copy_to_user(arg,&v, sizeof(v)))
 				return -EFAULT;
@@ -157,14 +207,15 @@
 		{
 			struct video_audio v;
 			if(copy_from_user(&v, arg, sizeof(v))) 
-				return -EFAULT;	
+				return -EFAULT;
 			if(v.audio) 
 				return -EINVAL;
 
-			if(v.flags&VIDEO_AUDIO_MUTE) 
-				pcm20_mute(pcm20);
-			else
-				pcm20_setvol(pcm20,v.volume/2048);	
+			pcm20_mute(pcm20, !!(v.flags&VIDEO_AUDIO_MUTE));
+			if(v.flags&VIDEO_SOUND_MONO)
+				pcm20_stereo(pcm20, 0);
+			if(v.flags&VIDEO_SOUND_STEREO)
+				pcm20_stereo(pcm20, 1);
 
 			return 0;
 		}
@@ -188,7 +239,12 @@
 	MOD_DEC_USE_COUNT;
 }
 
-static struct pcm20_device pcm20_unit;
+static struct pcm20_device pcm20_unit=
+{
+	freq:   87*16000,
+	muted:  1,
+	stereo: 0
+};
 
 static struct video_device pcm20_radio=
 {
@@ -198,24 +254,23 @@
 	open:		pcm20_open,
 	close:		pcm20_close,
 	ioctl:		pcm20_ioctl,
+	priv:		&pcm20_unit
 };
 
 static int __init pcm20_init(void)
 {
-
-	pcm20_radio.priv=&pcm20_unit;
-	
 	if(video_register_device(&pcm20_radio, VFL_TYPE_RADIO)==-1)
 		return -EINVAL;
 		
+	if(attach_aci_rds()<0) {
+		video_unregister_device(&pcm20_radio);
+		return -EINVAL;
+	}
+#if DEBUG
+	printk("v4l-name: %s\n", devfs_get_name(pcm20_radio.devfs_handle, 0));
+#endif
 	printk(KERN_INFO "Miro PCM20 radio card driver.\n");
 
- 	/* mute card - prevents noisy bootups */
-
-	/* this ensures that the volume is all the way down  */
-
-	pcm20_unit.curvol = 0;
-
 	return 0;
 }
 
@@ -226,9 +281,9 @@
 
 static void __exit pcm20_cleanup(void)
 {
+	unload_aci_rds();
 	video_unregister_device(&pcm20_radio);
 }
 
 module_init(pcm20_init);
 module_exit(pcm20_cleanup);
-
diff -urN -X dontdiff linux-vanilla/drivers/media/radio/rds-miropcm20.c linux/drivers/media/radio/rds-miropcm20.c
--- linux-vanilla/drivers/media/radio/rds-miropcm20.c	Thu Jan  1 01:00:00 1970
+++ linux/drivers/media/radio/rds-miropcm20.c	Sat Jan 27 16:25:02 2001
@@ -0,0 +1,249 @@
+/*
+ *  Many thanks to Fred Seidel <seidel@metabox.de>, the
+ *  designer of the RDS decoder hardware. With his help
+ *  I was able to code this driver.
+ *  Thanks also to Norberto Pellicci, Dominic Mounteney
+ *  <DMounteney@pinnaclesys.com> and www.teleauskunft.de
+ *  for good hints on finding Fred. It was somewhat hard
+ *  to locate him here in Germany... [:
+ *
+ * Revision history:
+ *
+ *   2000-08-09  Robert Siemer <Robert.Siemer@gmx.de>
+ *        RDS support for MiroSound PCM20 radio
+ */
+
+#define _NO_VERSION_
+
+/* #include <linux/kernel.h> */
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <asm/semaphore.h>
+#include <asm/io.h>
+#include "../../sound/aci.h"
+
+#define WATCHMASK       0352 /* 11101010 */
+
+#define DEBUG 0
+
+static struct semaphore aci_rds_sem;
+
+
+#define RDS_BUSYMASK        0x10   /* Bit 4 */
+#define RDS_CLOCKMASK       0x08   /* Bit 3 */
+#define RDS_DATAMASK        0x04   /* Bit 2 */
+
+
+static void print_matrix(char array[], unsigned int length)
+{
+        int i, j;
+
+        for (i=0; i<length; i++) {
+                printk("aci-rds: ");
+                for (j=7; j>=0; j--) {
+                        printk("%d", (array[i] >> j) & 0x1);
+                }
+                if (i%8 == 0)
+                        printk(" byte-border\n");
+                else
+                        printk("\n");
+        }
+}
+
+static int byte2trans(unsigned char byte, unsigned char sendbuffer[], int size)
+{
+	int i;
+
+	if (size != 8)
+		return -1;
+	for (i = 7; i >= 0; i--)
+		sendbuffer[7-i] = (byte & (1 << i)) ? RDS_DATAMASK : 0;
+	sendbuffer[0] |= RDS_CLOCKMASK;
+
+	return 0;
+}
+
+static int trans2byte(unsigned char buffer[], int size)
+{
+	int i;
+	unsigned char byte=0;
+
+	if (size != 8)
+		return -1;
+	for (i = 7; i >= 0; i--)
+		byte |= ((buffer[7-i] & RDS_DATAMASK) ? 1 : 0) << i;
+
+	return byte;
+}
+
+static int trans2data(unsigned char readbuffer[], int readsize, unsigned char data[], int datasize)
+{
+	int i,j;
+
+	if (readsize != datasize*8)
+		return -1;
+	for (i = 0; i < datasize; i++)
+		if ((j=trans2byte(&readbuffer[i*8], 8)) < 0)
+			return -1;
+		else
+			data[i]=j;
+	return 0;
+}
+
+static int rds_waitread(void)
+{
+	unsigned char byte;
+	int i=2000;
+
+	do {
+		byte=inb(RDS_REGISTER);
+		if ((byte & WATCHMASK) != WATCHMASK)
+			printk("aci-rds: Hidden information discoverd!\n");
+		i--;
+	}
+	while ((byte & RDS_BUSYMASK) && i);
+
+	if (i) {
+#if DEBUG
+		printk("rds_waitread()");
+		print_matrix(&byte, 1);
+#endif
+		return (byte);
+	} else {
+		printk("aci-rds: rds_waitread() timeout...\n");
+		return -1;
+	}
+}
+
+/* dont use any ..._nowait() function if you are not sure what you do... */
+
+static inline void rds_rawwrite_nowait(unsigned char byte)
+{
+#if DEBUG
+	printk("rds_rawwrite()");
+	print_matrix(&byte, 1);
+#endif
+	outb(byte, RDS_REGISTER);
+}
+
+static int rds_rawwrite(unsigned char byte)
+{
+	if (rds_waitread() >= 0) {
+		rds_rawwrite_nowait(byte);
+		return 0;
+	} else
+		return -1;
+}
+
+static int rds_write(unsigned char cmd)
+{
+	unsigned char sendbuffer[8];
+	int i;
+	
+	if (byte2trans(cmd, sendbuffer, 8) != 0){
+		return -1;
+	} else {
+		for (i=0; i<8; i++) {
+			rds_rawwrite(sendbuffer[i]);
+		}
+	}
+	return 0;
+}
+
+static int rds_readcycle_nowait(void)
+{
+	rds_rawwrite_nowait(0);
+	return rds_waitread();
+}
+
+static int rds_readcycle(void)
+{
+	if (rds_rawwrite(0) < 0)
+		return -1;
+	return rds_waitread();
+}
+
+static int rds_read(unsigned char databuffer[], int datasize)
+{
+
+#define READSIZE (8*datasize)
+
+	int i,j;
+	unsigned char* readbuffer;
+
+	if (!datasize)  /* nothing to read */
+		return 0;
+
+	/* to be able to use rds_readcycle_nowait()
+	   I have to readwait() here */
+	if (rds_waitread() < 0)
+		return -1;
+	
+	if ((readbuffer=kmalloc(READSIZE, GFP_KERNEL)) == 0) {
+		printk("aci-rds: Out of memory...\n");
+		return -ENOMEM;
+	} else {
+		if (signal_pending(current)) {
+			kfree(readbuffer);
+			return -EINTR;
+		}
+	}
+	
+	for (i=0; i< READSIZE; i++)
+		if((j=rds_readcycle_nowait()) < 0) {
+			kfree(readbuffer);
+			return -1;
+		} else
+			readbuffer[i]=j;
+	if (trans2data(readbuffer, READSIZE, databuffer, datasize) < 0) {
+		kfree(readbuffer);
+		return -1;
+	}
+	kfree(readbuffer);
+	return 0;
+}
+
+static int rds_ack(void)
+{
+	int i=rds_readcycle();
+
+	if (i < 0)
+		return -1;
+	if (i & RDS_DATAMASK) {
+		return 0;  /* ACK  */
+	} else {
+		return 1;  /* NACK */
+	}
+}
+
+int aci_rds_cmd(unsigned char cmd, unsigned char databuffer[], int datasize)
+{
+	int ret;
+
+	if (down_interruptible(&aci_rds_sem))
+		return -EINTR;
+
+	if (rds_write(cmd))
+		ret = -2;
+
+	/* RDS_RESET doesn't need further processing */
+	if (cmd!=RDS_RESET && (rds_ack() || rds_read(databuffer, datasize)))
+		ret = -1;
+	else
+		ret = 0;
+
+	up(&aci_rds_sem);
+	
+	return ret;
+}
+
+int __init attach_aci_rds(void)
+{
+	init_MUTEX(&aci_rds_sem);
+	return 0;
+}
+
+void __exit unload_aci_rds(void)
+{
+}
diff -urN -X dontdiff linux-vanilla/drivers/sound/Config.in linux/drivers/sound/Config.in
--- linux-vanilla/drivers/sound/Config.in	Wed Dec  6 20:43:05 2000
+++ linux/drivers/sound/Config.in	Sat Jan 27 16:25:02 2001
@@ -91,7 +91,7 @@
    fi
    dep_tristate '    Aztech Sound Galaxy (non-PnP) cards' CONFIG_SOUND_SGALAXY $CONFIG_SOUND_OSS
    dep_tristate '    Adlib Cards' CONFIG_SOUND_ADLIB $CONFIG_SOUND_OSS
-   dep_tristate '    ACI mixer (miroPCM12)' CONFIG_SOUND_ACI_MIXER $CONFIG_SOUND_OSS
+   dep_tristate '    ACI mixer (miroSOUND PCM1-pro/PCM12/PCM20)' CONFIG_SOUND_ACI_MIXER $CONFIG_SOUND_OSS
    dep_tristate '    Crystal CS4232 based (PnP) cards' CONFIG_SOUND_CS4232 $CONFIG_SOUND_OSS
    dep_tristate '    Ensoniq SoundScape support' CONFIG_SOUND_SSCAPE $CONFIG_SOUND_OSS
    dep_tristate '    Gravis Ultrasound support' CONFIG_SOUND_GUS $CONFIG_SOUND_OSS
diff -urN -X dontdiff linux-vanilla/drivers/sound/aci.c linux/drivers/sound/aci.c
--- linux-vanilla/drivers/sound/aci.c	Thu Nov 16 21:51:28 2000
+++ linux/drivers/sound/aci.c	Sat Jan 27 17:35:26 2001
@@ -10,15 +10,17 @@
  * The main function of the ACI is to control the mixer and to get a
  * product identification. On the PCM20, ACI also controls the radio
  * tuner on this card, this is supported in the Video for Linux 
- * radio-miropcm20 driver.
- * 
- * This Voxware ACI driver currently only supports the ACI functions
- * on the miroSOUND PCM12 and PCM20 card. Support for miro sound cards 
- * with additional ACI functions can easily be added later.
- *
- * / NOTE / When compiling as a module, make sure to load the module 
- * after loading the mad16 module. The initialisation code expects the
- * MAD16 default mixer to be already available.
+ * miropcm20 driver.
+ * -
+ * This is a fullfeatured implementation. Unsupported features
+ * are bugs... (:
+ *
+ * It is not longer necessary to load the mad16 module first. The
+ * user is currently responsible to set the mad16 mixer correctly.
+ *
+ * To toggle the solo mode for full duplex operation just use the OSS
+ * record switch for the pcm ('wave') controller.           Robert
+ * -
  *
  * Revision history:
  *
@@ -34,72 +36,74 @@
  *   1998-08-18  Ruurd Reitsma <R.A.Reitsma@wbmt.tudelft.nl>
  *	  Small modification to export ACI functions and 
  *	  complete modularisation.
+ *   2000-06-20  Robert Siemer <Robert.Siemer@gmx.de>
+ *        Don't initialize the CS4231A mixer anymore, so the code is
+ *        working again, and other small changes to fit in todays
+ *        kernels.
+ *   2000-08-26  Robert Siemer
+ *        Clean up and rewrite for 2.4.x. Maybe it's SMP safe now... (:
+ *        ioctl bugfix, and integration of solo-mode into OSS-API,
+ *        added (OSS-limited) equalizer support, return value bugfix,
+ *        changed param aci_reset to reset, new params: ide, wss.
  */
 
-/*
- * Some driver specific information and features:
- *
- * This mixer driver identifies itself to applications as "ACI" in
- * mixer_info.id as retrieved by ioctl(fd, SOUND_MIXER_INFO, &mixer_info).
- *
- * Proprietary mixer features that go beyond the standard OSS mixer
- * interface are:
- * 
- * Full duplex solo configuration:
- *
- *   int solo_mode;
- *   ioctl(fd, SOUND_MIXER_PRIVATE1, &solo_mode);
- *
- *   solo_mode = 0: deactivate solo mode (default)
- *   solo_mode > 0: activate solo mode
- *                  With activated solo mode, the PCM input can not any
- *                  longer hear the signals produced by the PCM output.
- *                  Activating solo mode is important in duplex mode in order
- *                  to avoid feedback distortions.
- *   solo_mode < 0: do not change solo mode (just retrieve the status)
- *
- *   When the ioctl() returns 0, solo_mode contains the previous
- *   status (0 = deactivated, 1 = activated). If solo mode is not
- *   implemented on this card, ioctl() returns -1 and sets errno to
- *   EINVAL.
- *
- */
-
+#include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/module.h> 
-
+#include <linux/proc_fs.h>
+#include <linux/slab.h>
+#include <asm/semaphore.h>
+#include <asm/io.h>
+#include <asm/uaccess.h>
 #include "sound_config.h"
 
-#undef  DEBUG		/* if defined, produce a verbose report via syslog */
+int aci_port;	/* as determined by bit 4 in the OPTi 929 MC4 register */
+int aci_idcode[2];	/* manufacturer and product ID */
+int aci_version;	/* ACI firmware version	*/
 
-int aci_port = 0x354;	/* as determined by bit 4 in the OPTi 929 MC4 register */
-unsigned char aci_idcode[2] = {0, 0};	/* manufacturer and product ID */
-unsigned char aci_version = 0;		/* ACI firmware version	*/
-int aci_solo;		/* status bit of the card that can't be		*
+#include "aci.h"
+
+
+static int aci_solo=0;	/* status bit of the card that can't be		*
+			 * checked with ACI versions prior to 0xb0	*/
+static int aci_amp=0;   /* status bit for power-amp/line-out level
+			   but I have no docs about what is what... */
+static int aci_micpreamp=3; /* microphone preamp-level that can't be    *
 			 * checked with ACI versions prior to 0xb0	*/
 
-static int aci_present = 0;
+static int mixer_device;
+static struct semaphore aci_sem;
 
-#ifdef MODULE                  /* Whether the aci mixer is to be reset.    */
-int aci_reset = 0;             /* Default: don't reset if the driver is a  */
-MODULE_PARM(aci_reset,"i");
-#else                          /* module; use "insmod aci.o aci_reset=1" */
-int aci_reset = 1;             /* to override.                             */
+#ifdef MODULE
+static int reset = 0;
+MODULE_PARM(reset,"i");
+MODULE_PARM_DESC(reset,"When set to 1, reset aci mixer.");
+#else
+static int reset = 1;
 #endif
 
+static int ide=-1;
+MODULE_PARM(ide,"i");
+MODULE_PARM_DESC(ide,"1 enable, 0 disable ide-port - untested"
+		 " default: do nothing");
+static int wss=-1;
+MODULE_PARM(wss,"i");
+MODULE_PARM_DESC(wss,"change between ACI/WSS-mixer; use 0 and 1 - untested"
+		 " default: do nothing; for PCM1-pro only");
 
-#define COMMAND_REGISTER    (aci_port)
-#define STATUS_REGISTER     (aci_port + 1)
-#define BUSY_REGISTER       (aci_port + 2)
+static void print_bits(unsigned char c)
+{
+	int j;
+	printk("aci: ");
+
+	for (j=7; j>=0; j--) {
+		printk("%d", (c >> j) & 0x1);
+	}
+
+	printk("\n");
+}
 
 /*
- * Wait until the ACI microcontroller has set the READYFLAG in the
- * Busy/IRQ Source Register to 0. This is required to avoid
- * overrunning the sound card microcontroller. We do a busy wait here,
- * because the microcontroller is not supposed to signal a busy
- * condition for more than a few clock cycles. In case of a time-out,
- * this function returns -1.
- *
  * This busy wait code normally requires less than 15 loops and
  * practically always less than 100 loops on my i486/DX2 66 MHz.
  *
@@ -107,459 +111,458 @@
  * function can take a VERY long time, because the PCM12 does some kind
  * of fade-in effect. For this reason, access to the MUTE function has
  * not been implemented at all.
+ * -
+ * The mute function is unusable anyway: it takes hours for unmute and
+ * does no fade-in on my PCM20 radio.			Robert
  */
 
 static int busy_wait(void)
 {
 	long timeout;
+	unsigned char byte;
 
+	schedule();	/* maybe loose some time */
 	for (timeout = 0; timeout < 10000000L; timeout++)
-		if ((inb_p(BUSY_REGISTER) & 1) == 0)
-			return 0;
-
-#ifdef DEBUG
-	printk("ACI: READYFLAG timed out.\n");
-#endif
-
-	return -1;
+		if (((byte=inb(BUSY_REGISTER)) & 1) == 0) {
+			if (timeout >= 500000)
+				printk("aci: READYFLAG needed %ld polls.\n", timeout+1);
+			return byte;
+		}
+	printk("aci: busy_wait() time out.\n");
+	return -EBUSY;
 }
 
-
-/*
- * Read the GENERAL STATUS register.
+/* The four ACI command types are fucked up. [-:
+ * implied is: 1w      - special case for INIT
+ * write   is: 2w1r
+ * read    is: x(1w1r) where x is 1 or 2 (1 CHECK_SIG, 1 CHECK_STER,
+ *                                        1 VERSION, 2 IDCODE)
+ *  the command is only in the first write, rest is protocol overhead
+ *
+ * indexed is technically a write and used for STATUS
+ * and the special case for TUNE is: 3w1r
+ * 
+ * Here the new general sheme: TUNE --> aci_rw_cmd(x,  y,  z)
+ *                indexed and write --> aci_rw_cmd(x,  y, -1)
+ *           implied and read (x=1) --> aci_rw_cmd(x, -1, -1)
+ *
+ * Read (x>=2) is not implemented (only used during initialization).
+ * Use aci_idcode[2] and aci_version...                    Robert
  */
 
-static int read_general_status(void)
-{
-	unsigned long flags;
-	int status;
-
-	save_flags(flags);
-	cli();
-	
-	if (busy_wait()) {
-		restore_flags(flags);
-		return -1;
-	}
-	
-	status = (unsigned) inb_p(STATUS_REGISTER);
-	restore_flags(flags);
-	return status;
-}
-
-
-/*
- * The four ACI command types (implied, write, read and indexed) can
- * be sent to the microcontroller using the following four functions.
- * If a problem occurred, they return -1.
+/* Some notes for error detection: theoretically it is possible.
+ * But it doubles the I/O-traffic from ww(r) to wwwrw(r) in the normal 
+ * case and doesn't seem to be designed for that...        Robert
  */
 
-int aci_implied_cmd(unsigned char opcode)
+static inline int aci_rawwrite(unsigned char byte)
 {
-	unsigned long flags;
-
-#ifdef DEBUG
-	printk("ACI: aci_implied_cmd(0x%02x)\n", opcode);
+	if (busy_wait() >= 0) {
+#if DEBUG
+		printk("aci_rawwrite(%d)\n", byte);
 #endif
-
-	save_flags(flags);
-	cli();
-  
-  	if (read_general_status() < 0 || busy_wait()) {
-		restore_flags(flags);
-		return -1;
-	}
-	
-	outb_p(opcode, COMMAND_REGISTER);
-
-	restore_flags(flags);
-	return 0;
+		outb(byte, COMMAND_REGISTER);
+		return 0;
+	} else
+		return -EBUSY;
 }
 
-
-int aci_write_cmd(unsigned char opcode, unsigned char parameter)
+static inline int aci_rawread(void)
 {
-	unsigned long flags;
-	int status;
+	unsigned char byte;
 
-#ifdef DEBUG
-	printk("ACI: aci_write_cmd(0x%02x, 0x%02x)\n", opcode, parameter);
+	if (busy_wait() >= 0) {
+		byte=inb(STATUS_REGISTER);
+#if DEBUG
+		printk("%d = aci_rawread()\n", byte);
 #endif
+		return byte;
+	} else
+		return -EBUSY;
+}
 
-	save_flags(flags);
-	cli();
-	
-	if (read_general_status() < 0 || busy_wait()) {
-		restore_flags(flags);
-		return -1;
-	}
 
-	outb_p(opcode, COMMAND_REGISTER);
-	if (busy_wait()) {
-		restore_flags(flags);
-		return -1;
-	}
+int aci_rw_cmd(int write1, int write2, int write3)
+{
+	int write[] = {write1, write2, write3};
+	int read, i;
 
-	outb_p(parameter, COMMAND_REGISTER);
+	if (down_interruptible(&aci_sem))
+		return -EINTR;
 
-	if ((status = read_general_status()) < 0) {
-		restore_flags(flags);
-		return -1;
+	for (i=0; i<3; i++) {
+		if (write[i]< 0 || write[i] > 255)
+			break;
+		else
+			if (aci_rawwrite(write[i])<0) {
+				up(&aci_sem);
+				return -EBUSY;
+			}
 	}
-
-	/* polarity of the INVALID flag depends on ACI version */
-	if ((aci_version <  0xb0 && (status & 0x40) != 0) ||
-	  (aci_version >= 0xb0 && (status & 0x40) == 0)) {
-	  	restore_flags(flags);
-		printk("ACI: invalid write command 0x%02x, 0x%02x.\n",
-			opcode, parameter);
-		return -1;
+	
+	if ((read=aci_rawread())<0) {
+		up(&aci_sem);
+		return -EBUSY;
 	}
 
-	restore_flags(flags);
-	return 0;
+	up(&aci_sem);
+	return read;
 }
 
-/*
- * This write command send 2 parameters instead of one.
- * Only used in PCM20 radio frequency tuning control
- */
-
-int aci_write_cmd_d(unsigned char opcode, unsigned char parameter, unsigned char parameter2)
+static int setvolume(caddr_t arg, 
+		     unsigned char left_index, unsigned char right_index)
 {
-	unsigned long flags;
-	int status;
+	int vol, ret, uservol, buf;
 
-#ifdef DEBUG
-	printk("ACI: aci_write_cmd_d(0x%02x, 0x%02x)\n", opcode, parameter, parameter2);
-#endif
+	__get_user(uservol, (int *)arg);
 
-	save_flags(flags);
-	cli();
-	
-	if (read_general_status() < 0 || busy_wait()) {
-		restore_flags(flags);
-		return -1;
-	}
-
-	outb_p(opcode, COMMAND_REGISTER);
-	if (busy_wait()) {
-		restore_flags(flags);
-		return -1;
-	}
+	/* left channel */
+	vol = uservol & 0xff;
+	if (vol > 100)
+		vol = 100;
+	vol = SCALE(100, 0x20, vol);
+	if ((buf=aci_write_cmd(left_index, 0x20 - vol))<0)
+		return buf;
+	ret = SCALE(0x20, 100, vol);
 
-	outb_p(parameter, COMMAND_REGISTER);
-	if (busy_wait()) {
-		restore_flags(flags);
-		return -1;
-	}
-	
-	outb_p(parameter2, COMMAND_REGISTER);
-	
-	if ((status = read_general_status()) < 0) {
-		restore_flags(flags);
-		return -1;
-	}
-	
-	/* polarity of the INVALID flag depends on ACI version */
-	if ((aci_version <  0xb0 && (status & 0x40) != 0) ||
-	  (aci_version >= 0xb0 && (status & 0x40) == 0)) {
-		restore_flags(flags);
-#if 0	/* Frequency tuning works, but the INVALID flag is set ??? */
-		printk("ACI: invalid write (double) command 0x%02x, 0x%02x, 0x%02x.\n",
-			opcode, parameter, parameter2);
-#endif
-		return -1;
-  	}
-	
-	restore_flags(flags);
-	return 0;
-}
 
-int aci_read_cmd(unsigned char opcode, int length, unsigned char *parameter)
-{
-	unsigned long flags;
-	int i = 0;
-	
-	save_flags(flags);
-	cli();
+	/* right channel */
+	vol = (uservol >> 8) & 0xff;
+	if (vol > 100)
+		vol = 100;
+	vol = SCALE(100, 0x20, vol);
+	if ((buf=aci_write_cmd(right_index, 0x20 - vol))<0)
+		return buf;
+	ret |= SCALE(0x20, 100, vol) << 8;
  
- 	if (read_general_status() < 0) {
-		restore_flags(flags);
-		return -1;
-	}
-	while (i < length) {
-		if (busy_wait()) {
-			restore_flags(flags);
-			return -1;
-		}
-			
-		outb_p(opcode, COMMAND_REGISTER);
-		if (busy_wait()) {
-			restore_flags(flags);
-			return -1;
-		}
-			
-		parameter[i++] = inb_p(STATUS_REGISTER);
-#ifdef DEBUG
-		if (i == 1)
-			printk("ACI: aci_read_cmd(0x%02x, %d) = 0x%02x\n",
-				opcode, length, parameter[i-1]);
-		else
-			printk("ACI: aci_read_cmd cont.: 0x%02x\n", parameter[i-1]);
-#endif
-	}
+	__put_user(ret, (int *)arg);
 
-	restore_flags(flags);
 	return 0;
 }
 
-
-int aci_indexed_cmd(unsigned char opcode, unsigned char index,
-		       unsigned char *parameter)
+static int getvolume(caddr_t arg,
+		     unsigned char left_index, unsigned char right_index)
 {
-	unsigned long flags;
+	int vol;
+	int buf;
 
-	save_flags(flags);
-	cli();
-  
-	if (read_general_status() < 0 || busy_wait()) {
-	  	restore_flags(flags);
-		return -1;
-	}
-	
-	outb_p(opcode, COMMAND_REGISTER);
-	if (busy_wait()) {
-		restore_flags(flags);
-		return -1;
-	}
-	
-	outb_p(index, COMMAND_REGISTER);
-	if (busy_wait()) {
-		restore_flags(flags);
-		return -1;
-	}
+	/* left channel */
+	if ((buf=aci_indexed_cmd(0xf0, left_index))<0)
+		return buf;
+	vol = SCALE(0x20, 100, buf < 0x20 ? 0x20-buf : 0);
 	
-	*parameter = inb_p(STATUS_REGISTER);
-#ifdef DEBUG
-	printk("ACI: aci_indexed_cmd(0x%02x, 0x%02x) = 0x%02x\n", opcode, index,
-		*parameter);
-#endif
+	/* right channel */
+	if ((buf=aci_indexed_cmd(0xf0, right_index))<0)
+		return buf;
+	vol |= SCALE(0x20, 100, buf < 0x20 ? 0x20-buf : 0) << 8;
+
+	__put_user(vol, (int *)arg);
 
-	restore_flags(flags);
 	return 0;
 }
 
 
-/*
- * The following macro SCALE can be used to scale one integer volume
- * value into another one using only integer arithmetic. If the input
- * value x is in the range 0 <= x <= xmax, then the result will be in
- * the range 0 <= SCALE(xmax,ymax,x) <= ymax.
- *
- * This macro has for all xmax, ymax > 0 and all 0 <= x <= xmax the
- * following nice properties:
- *
- * - SCALE(xmax,ymax,xmax) = ymax
- * - SCALE(xmax,ymax,0) = 0
- * - SCALE(xmax,ymax,SCALE(ymax,xmax,SCALE(xmax,ymax,x))) = SCALE(xmax,ymax,x)
- *
- * In addition, the rounding error is minimal and nicely distributed.
- * The proofs are left as an exercise to the reader.
+/* The equalizer is somewhat strange on the ACI. From -12dB to +12dB
+ * write:  0xff..down.to..0x80==0x00..up.to..0x7f
  */
 
-#define SCALE(xmax,ymax,x) (((x)*(ymax)+(xmax)/2)/(xmax))
+static inline unsigned int eq_oss2aci(unsigned int vol)
+{
+	int boost=0;
+	unsigned int ret;
+
+	if (vol > 100)
+		vol = 100;
+	if (vol > 50) {
+		vol -= 51;
+		boost=1;
+	}
+	if (boost)
+		ret=SCALE(49, 0x7e, vol)+1;
+	else
+		ret=0xff - SCALE(50, 0x7f, vol);
+	return ret;
+}
+
+static inline unsigned int eq_aci2oss(unsigned int vol)
+{
+	if (vol < 0x80)
+		return SCALE(0x7f, 50, vol) + 50;
+	else
+		return SCALE(0x7f, 50, 0xff-vol);
+}
 
 
-static int getvolume(caddr_t arg,
-		     unsigned char left_index, unsigned char right_index)
+static int setequalizer(caddr_t arg, 
+			unsigned char left_index, unsigned char right_index)
 {
-	int vol;
-	unsigned char buf;
+	int buf;
+	unsigned int vol;
+
+	__get_user(vol, (int *)arg);
 
 	/* left channel */
-	if (aci_indexed_cmd(0xf0, left_index, &buf))
-		return -EIO;
-	vol = SCALE(0x20, 100, buf < 0x20 ? 0x20-buf : 0);
-	
+	if ((buf=aci_write_cmd(left_index, eq_oss2aci(vol & 0xff)))<0)
+		return buf;
+
 	/* right channel */
-	if (aci_indexed_cmd(0xf0, right_index, &buf))
-		return -EIO;
-	vol |= SCALE(0x20, 100, buf < 0x20 ? 0x20-buf : 0) << 8;
+	if ((buf=aci_write_cmd(right_index, eq_oss2aci((vol>>8) & 0xff)))<0)
+		return buf;
 
-	return (*(int *) arg = vol);
+	/* the ACI equalizer is more precise */
+	return 0;
 }
 
-
-static int setvolume(caddr_t arg, 
-		     unsigned char left_index, unsigned char right_index)
+static int getequalizer(caddr_t arg,
+			unsigned char left_index, unsigned char right_index)
 {
-	int vol, ret;
+	int buf;
+	unsigned int vol;
 
 	/* left channel */
-	vol = *(int *)arg & 0xff;
-	if (vol > 100)
-		vol = 100;
-	vol = SCALE(100, 0x20, vol);
-	if (aci_write_cmd(left_index, 0x20 - vol))
-		return -EIO;
-	ret = SCALE(0x20, 100, vol);
+	if ((buf=aci_indexed_cmd(0xf0, left_index))<0)
+		return buf;
+	vol = eq_aci2oss(buf);
+	
+	/* right channel */
+	if ((buf=aci_indexed_cmd(0xf0, right_index))<0)
+		return buf;
+	vol |= eq_aci2oss(buf) << 8;
 
+	__put_user(vol, (int *)arg);
 
-	/* right channel */
-	vol = (*(int *)arg >> 8) & 0xff;
-	if (vol > 100)
-		vol = 100;
-	vol = SCALE(100, 0x20, vol);
-	if (aci_write_cmd(right_index, 0x20 - vol))
-		return -EIO;
-	ret |= SCALE(0x20, 100, vol) << 8;
- 
-	return (*(int *) arg = ret);
+	return 0;
 }
 
-
-static int
-aci_mixer_ioctl (int dev, unsigned int cmd, caddr_t arg)
+static int aci_mixer_ioctl (int dev, unsigned int cmd, caddr_t arg)
 {
-	int status, vol;
-	unsigned char buf;
+	int vol, buf;
 
-	/* handle solo mode control */
-	if (cmd == SOUND_MIXER_PRIVATE1) {
-		if (*(int *) arg >= 0) {
-			aci_solo = !!*(int *) arg;
-			if (aci_write_cmd(0xd2, aci_solo))
-				return -EIO;
-		} else if (aci_version >= 0xb0) {
-			if ((status = read_general_status()) < 0)
-				return -EIO;
-			return (*(int *) arg = (status & 0x20) == 0);
+	switch (cmd) {
+	case SOUND_MIXER_WRITE_VOLUME:
+		return setvolume(arg, 0x01, 0x00);
+	case SOUND_MIXER_WRITE_CD:
+		return setvolume(arg, 0x3c, 0x34);
+	case SOUND_MIXER_WRITE_MIC:
+		return setvolume(arg, 0x38, 0x30);
+	case SOUND_MIXER_WRITE_LINE:
+		return setvolume(arg, 0x39, 0x31);
+	case SOUND_MIXER_WRITE_SYNTH:
+		return setvolume(arg, 0x3b, 0x33);
+	case SOUND_MIXER_WRITE_PCM:
+		return setvolume(arg, 0x3a, 0x32);
+	case MIXER_WRITE(SOUND_MIXER_RADIO): /* fall through */
+	case SOUND_MIXER_WRITE_LINE1:  /* AUX1 or radio */
+		return setvolume(arg, 0x3d, 0x35);
+	case SOUND_MIXER_WRITE_LINE2:  /* AUX2 */
+		return setvolume(arg, 0x3e, 0x36);
+	case SOUND_MIXER_WRITE_BASS:   /* set band one and two */
+		if (aci_idcode[1]=='C') {
+			if ((buf=setequalizer(arg, 0x48, 0x40)) || 
+			    (buf=setequalizer(arg, 0x49, 0x41)));
+			return buf;
 		}
-		
-		return (*(int *) arg = aci_solo);
-	}
-	
-	if (((cmd >> 8) & 0xff) == 'M') {
-		if (cmd & SIOC_IN)
-			/* read and write */
-			switch (cmd & 0xff) {
-				case SOUND_MIXER_VOLUME:
-					return setvolume(arg, 0x01, 0x00);
-				case SOUND_MIXER_CD:
-					return setvolume(arg, 0x3c, 0x34);
-				case SOUND_MIXER_MIC:
-					return setvolume(arg, 0x38, 0x30);
-				case SOUND_MIXER_LINE:
-					return setvolume(arg, 0x39, 0x31);
-				case SOUND_MIXER_SYNTH:
-					return setvolume(arg, 0x3b, 0x33);
-				case SOUND_MIXER_PCM:
-					return setvolume(arg, 0x3a, 0x32);
-				case SOUND_MIXER_LINE1:  /* AUX1 */
-					return setvolume(arg, 0x3d, 0x35);
-				case SOUND_MIXER_LINE2:  /* AUX2 */
-					return setvolume(arg, 0x3e, 0x36);
-				case SOUND_MIXER_IGAIN:  /* MIC pre-amp */
-					vol = *(int *) arg & 0xff;
-					if (vol > 100)
-						vol = 100;
-					vol = SCALE(100, 3, vol);
-					if (aci_write_cmd(0x03, vol))
-						return -EIO;
-					vol = SCALE(3, 100, vol);
-					return (*(int *) arg = vol | (vol << 8));
-				case SOUND_MIXER_RECSRC:
-					return (*(int *) arg = 0);
-					break;
-				default:
-					return -EINVAL;
+		break;
+	case SOUND_MIXER_WRITE_TREBLE: /* set band six and seven */
+		if (aci_idcode[1]=='C') {
+			if ((buf=setequalizer(arg, 0x4d, 0x45)) || 
+			    (buf=setequalizer(arg, 0x4e, 0x46)));
+			return buf;
+		}
+		break;
+	case SOUND_MIXER_WRITE_IGAIN:  /* MIC pre-amp */
+		if (aci_idcode[1]=='B' || aci_idcode[1]=='C') {
+			__get_user(vol, (int *)arg);
+			vol = vol & 0xff;
+			if (vol > 100)
+				vol = 100;
+			vol = SCALE(100, 3, vol);
+			if ((buf=aci_write_cmd(0x03, vol))<0)
+				return buf;
+			aci_micpreamp = vol;
+			vol = SCALE(3, 100, vol);
+			vol |= (vol << 8);
+			__put_user(vol, (int *)arg);
+			return 0;
+		}
+		break;
+	case SOUND_MIXER_WRITE_OGAIN:  /* Power-amp/line-out level */
+		if (aci_idcode[1]=='A' || aci_idcode[1]=='B') {
+			__get_user(buf, (int *)arg);
+			buf = buf & 0xff;
+			if (buf > 50)
+				vol = 1;
+			else
+				vol = 0;
+			if ((buf=aci_write_cmd(0x0f, vol))<0)
+				return buf;
+			aci_amp = vol;
+			if (aci_amp)
+				buf = (100 || 100<<8);
+			else
+				buf = 0;
+			__put_user(buf, (int *)arg);
+			return 0;
+		}
+		break;
+	case SOUND_MIXER_WRITE_RECSRC:
+		/* handle solo mode control */
+		__get_user(buf, (int *)arg);
+		/* unset solo when RECSRC for PCM is requested */
+		if (aci_idcode[1]=='B' || aci_idcode[1]=='C') {
+			vol = !(buf & SOUND_MASK_PCM);
+			if ((buf=aci_write_cmd(0xd2, vol))<0)
+				return buf;
+			aci_solo = vol;
+		}
+		buf = (SOUND_MASK_CD| SOUND_MASK_MIC| SOUND_MASK_LINE|
+		       SOUND_MASK_SYNTH| SOUND_MASK_LINE2);
+		if (aci_idcode[1] == 'C') /* PCM20 radio */
+			buf |= SOUND_MASK_RADIO;
+		else
+			buf |= SOUND_MASK_LINE1;
+		if (!aci_solo)
+			buf |= SOUND_MASK_PCM;
+		__put_user(buf, (int *)arg);
+		return 0;
+	case SOUND_MIXER_READ_DEVMASK:
+		buf = (SOUND_MASK_VOLUME | SOUND_MASK_CD    |
+		       SOUND_MASK_MIC    | SOUND_MASK_LINE  |
+		       SOUND_MASK_SYNTH  | SOUND_MASK_PCM   |
+		       SOUND_MASK_LINE2);
+		switch (aci_idcode[1]) {
+		case 'C': /* PCM20 radio */
+			buf |= (SOUND_MASK_RADIO | SOUND_MASK_IGAIN |
+				SOUND_MASK_BASS  | SOUND_MASK_TREBLE);
+			break;
+		case 'B': /* PCM12 */
+			buf |= (SOUND_MASK_LINE1 | SOUND_MASK_IGAIN |
+				SOUND_MASK_OGAIN);
+			break;
+		case 'A': /* PCM1-pro */
+			buf |= (SOUND_MASK_LINE1 | SOUND_MASK_OGAIN);
+			break;
+		default:
+			buf |= SOUND_MASK_LINE1;
+		}
+		__put_user(buf, (int *)arg);
+		return 0;
+	case SOUND_MIXER_READ_STEREODEVS:
+		buf = (SOUND_MASK_VOLUME | SOUND_MASK_CD    |
+		       SOUND_MASK_MIC    | SOUND_MASK_LINE  |
+		       SOUND_MASK_SYNTH  | SOUND_MASK_PCM   |
+		       SOUND_MASK_LINE2);
+		switch (aci_idcode[1]) {
+		case 'C': /* PCM20 radio */
+			buf |= (SOUND_MASK_RADIO |
+				SOUND_MASK_BASS  | SOUND_MASK_TREBLE);
+			break;
+		default:
+			buf |= SOUND_MASK_LINE1;
+		}
+		__put_user(buf, (int *)arg);
+		return 0;
+	case SOUND_MIXER_READ_RECMASK:
+		buf = (SOUND_MASK_CD| SOUND_MASK_MIC| SOUND_MASK_LINE|
+		       SOUND_MASK_SYNTH| SOUND_MASK_LINE2| SOUND_MASK_PCM);
+		if (aci_idcode[1] == 'C') /* PCM20 radio */
+			buf |= SOUND_MASK_RADIO;
+		else
+			buf |= SOUND_MASK_LINE1;
+
+		__put_user(buf, (int *)arg);
+		return 0;
+	case SOUND_MIXER_READ_RECSRC:
+		buf = (SOUND_MASK_CD    | SOUND_MASK_MIC   | SOUND_MASK_LINE  |
+		       SOUND_MASK_SYNTH | SOUND_MASK_LINE2);
+		/* do we need aci_solo or can I get it from the ACI? */
+		switch (aci_idcode[1]) {
+		case 'B': /* PCM12 */
+		case 'C': /* PCM20 radio */
+			if (aci_version >= 0xb0) {
+				if ((vol=aci_rw_cmd(0xf0, 0x00, -1))<0)
+					return vol;
+				if (vol & 0x20)
+					buf |= SOUND_MASK_PCM;
 			}
+			else
+				if (!aci_solo)
+					buf |= SOUND_MASK_PCM;
+			break;
+		default:
+			buf |= SOUND_MASK_PCM;
+		}
+		if (aci_idcode[1] == 'C') /* PCM20 radio */
+			buf |= SOUND_MASK_RADIO;
 		else
-			/* only read */
-			switch (cmd & 0xff) {
-				case SOUND_MIXER_DEVMASK:
-					return (*(int *) arg =
-				 SOUND_MASK_VOLUME | SOUND_MASK_CD    |
-				 SOUND_MASK_MIC    | SOUND_MASK_LINE  |
-				 SOUND_MASK_SYNTH  | SOUND_MASK_PCM   |
-#if 0
-				 SOUND_MASK_IGAIN  |
-#endif
-				 SOUND_MASK_LINE1  | SOUND_MASK_LINE2);
-				 	break;
-				case SOUND_MIXER_STEREODEVS:
-					return (*(int *) arg =
-				 SOUND_MASK_VOLUME | SOUND_MASK_CD   |
-				 SOUND_MASK_MIC    | SOUND_MASK_LINE |
-				 SOUND_MASK_SYNTH  | SOUND_MASK_PCM  |
-				 SOUND_MASK_LINE1  | SOUND_MASK_LINE2);
-				 	break;
-				case SOUND_MIXER_RECMASK:
-					return (*(int *) arg = 0);
-					break;
-				case SOUND_MIXER_RECSRC:
-					return (*(int *) arg = 0);
-					break;
-				case SOUND_MIXER_CAPS:
-					return (*(int *) arg = 0);
-					break;
-				case SOUND_MIXER_VOLUME:
-					return getvolume(arg, 0x04, 0x03);
-				case SOUND_MIXER_CD:
-					return getvolume(arg, 0x0a, 0x09);
-				case SOUND_MIXER_MIC:
-					return getvolume(arg, 0x06, 0x05);
-				case SOUND_MIXER_LINE:
-					return getvolume(arg, 0x08, 0x07);
-				case SOUND_MIXER_SYNTH:
-					return getvolume(arg, 0x0c, 0x0b);
-				case SOUND_MIXER_PCM:
-					return getvolume(arg, 0x0e, 0x0d);
-				case SOUND_MIXER_LINE1:  /* AUX1 */
-					return getvolume(arg, 0x11, 0x10);
-				case SOUND_MIXER_LINE2:  /* AUX2 */
-					return getvolume(arg, 0x13, 0x12);
-				case SOUND_MIXER_IGAIN:  /* MIC pre-amp */
-					if (aci_indexed_cmd(0xf0, 0x21, &buf))
-						return -EIO;
-					vol = SCALE(3, 100, buf <= 3 ? buf : 3);
-					vol |= vol << 8;
-					return (*(int *) arg = vol);
-				default:
-					return -EINVAL;
+			buf |= SOUND_MASK_LINE1;
+
+		__put_user(buf, (int *)arg);
+		return 0;
+	case SOUND_MIXER_READ_CAPS:
+		__put_user(0, (int *)arg);
+		return 0;
+	case SOUND_MIXER_READ_VOLUME:
+		return getvolume(arg, 0x04, 0x03);
+	case SOUND_MIXER_READ_CD:
+		return getvolume(arg, 0x0a, 0x09);
+	case SOUND_MIXER_READ_MIC:
+		return getvolume(arg, 0x06, 0x05);
+	case SOUND_MIXER_READ_LINE:
+		return getvolume(arg, 0x08, 0x07);
+	case SOUND_MIXER_READ_SYNTH:
+		return getvolume(arg, 0x0c, 0x0b);
+	case SOUND_MIXER_READ_PCM:
+		return getvolume(arg, 0x0e, 0x0d);
+	case MIXER_READ(SOUND_MIXER_RADIO): /* fall through */
+	case SOUND_MIXER_READ_LINE1:  /* AUX1 */
+		return getvolume(arg, 0x11, 0x10);
+	case SOUND_MIXER_READ_LINE2:  /* AUX2 */
+		return getvolume(arg, 0x13, 0x12);
+	case SOUND_MIXER_READ_BASS:   /* get band one */
+		if (aci_idcode[1]=='C') {
+			return getequalizer(arg, 0x23, 0x22);
+		}
+		break;
+	case SOUND_MIXER_READ_TREBLE: /* get band seven */
+		if (aci_idcode[1]=='C') {
+			return getequalizer(arg, 0x2f, 0x2e);
+		}
+		break;
+	case SOUND_MIXER_READ_IGAIN:  /* MIC pre-amp */
+		if (aci_idcode[1]=='B' || aci_idcode[1]=='C') {
+			/* aci_micpreamp or ACI? */
+			if (aci_version >= 0xb0) {
+				if ((buf=aci_indexed_cmd(0xf0, 0x21))<0)
+					return buf;
 			}
+			else
+				buf=aci_micpreamp;
+			vol = SCALE(3, 100, buf <= 3 ? buf : 3);
+			vol |= vol << 8;
+			__put_user(vol, (int *)arg);
+			return 0;
+		}
+		break;
+	case SOUND_MIXER_READ_OGAIN:
+		if (aci_amp)
+			buf = (100 || 100<<8);
+		else
+			buf = 0;
+		__put_user(buf, (int *)arg);
+		return 0;
 	}
-	
 	return -EINVAL;
 }
 
-
 static struct mixer_operations aci_mixer_operations =
 {
-	owner:	THIS_MODULE,
-	id:	"ACI",
-	name:	"ACI mixer",
-	ioctl:	aci_mixer_ioctl
+	owner: THIS_MODULE,
+	id:    "ACI",
+	ioctl: aci_mixer_ioctl
 };
 
-static unsigned char
-mad_read (int port)
-{
-	outb (0xE3, 0xf8f); /* Write MAD16 password */
-	return inb (port);  /* Read from port */
-}
-
-
 /*
- * Check, whether there actually is any ACI port operational and if
- * one was found, then initialize the ACI interface, reserve the I/O
- * addresses and attach the new mixer to the relevant VoxWare data
- * structures.
- *
- * Returns:  1   ACI mixer detected
- *           0   nothing there
- *
  * There is also an internal mixer in the codec (CS4231A or AD1845),
  * that deserves no purpose in an ACI based system which uses an
  * external ACI controlled stereo mixer. Make sure that this codec
@@ -570,148 +573,107 @@
 
 static int __init attach_aci(void)
 {
-	char *boardname = "unknown";
-	int volume;
+	char *boardname;
+	int i;
 
-#define MC4_PORT	0xf90
+	init_MUTEX(&aci_sem);
 
-	aci_port =
-		(mad_read(MC4_PORT) & 0x10) ? 0x344 : 0x354;
+	outb(0xE3, 0xf8f); /* Write MAD16 password */
+	aci_port = (inb(0xf90) & 0x10) ?
+		0x344: 0x354; /* Get aci_port from MC4_PORT */
 
 	if (check_region(aci_port, 3)) {
-#ifdef DEBUG
-		printk("ACI: I/O area 0x%03x-0x%03x already used.\n",
-			aci_port, aci_port+2);
-#endif
-		return 0;
+		printk("aci: I/O area 0x%03x-0x%03x already used.\n",
+		       aci_port, aci_port+2);
+		return -EBUSY;
 	}
-	
-	if (aci_read_cmd(0xf2, 2, aci_idcode)) {
-#ifdef DEBUG
-		printk("ACI: Failed to read idcode.\n");
-#endif
-		return 0;
+
+	/* force ACI into a known state */
+	for (i=0; i<3; i++)
+		if (aci_rw_cmd(0xdf, -1, -1)<0)
+			return -EFAULT;
+
+	/* official this is one aci read call: */
+	if ((aci_idcode[0]=aci_rw_cmd(0xf2, -1, -1))<0 ||
+	    (aci_idcode[1]=aci_rw_cmd(0xf2, -1, -1))<0) {
+		printk("aci: Failed to read idcode on 0x%03x.\n", aci_port);
+		return -EFAULT;
 	}
-	
-	if (aci_read_cmd(0xf1, 1, &aci_version)) {
-#ifdef DEBUG
-		printk("ACI: Failed to read version.\n");
-#endif
-		return 0;
+
+	if ((aci_version=aci_rw_cmd(0xf1, -1, -1))<0) {
+		printk("aci: Failed to read version on 0x%03x.\n", aci_port);
+		return -EFAULT;
 	}
 
-	if (aci_idcode[0] == 0x6d) {
+	if (aci_idcode[0] == 'm') {
 		/* It looks like a miro sound card. */
 		switch (aci_idcode[1]) {
-			case 0x41:
-				boardname = "PCM1 pro / early PCM12";
-				break;
-			case 0x42:
-				boardname = "PCM12";
-				break;
-			case 0x43:
-				boardname = "PCM20";
-				break;
-			default:
-				boardname = "unknown miro";
+		case 'A':
+			boardname = "PCM1 pro / early PCM12";
+			break;
+		case 'B':
+			boardname = "PCM12";
+			break;
+		case 'C':
+			boardname = "PCM20 radio";
+			break;
+		default:
+			boardname = "unknown miro";
 		}
-	} else
-#ifndef DEBUG
-	return 0;
-#endif
-  
-  	printk("<ACI %02x, id %02x %02x (%s)> at 0x%03x\n",
-		aci_version, aci_idcode[0], aci_idcode[1], boardname, aci_port);
-
-	if (aci_reset) {
-		/* initialize ACI mixer */
-		aci_implied_cmd(0xff);
-		aci_solo = 0;
-	}
-
-	/* attach the mixer */
-	request_region(aci_port, 3, "sound mixer (ACI)");
-	if (num_mixers < MAX_MIXER_DEV) {
-		if (num_mixers > 0 &&
-		  !strncmp("MAD16 WSS", mixer_devs[num_mixers-1]->name, 9)) {
-			/*
-			 * The previously registered mixer device is the CS4231A which
-			 * has no function on an ACI card. Make the ACI mixer the first
-			 * of the two mixer devices.
-			 */
-			mixer_devs[num_mixers] = mixer_devs[num_mixers-1];
-			mixer_devs[num_mixers-1] = &aci_mixer_operations;
-			/*
-			 * Initialize the CS4231A mixer with reasonable values. It is
-			 * unlikely that the user ever will want to change these as all
-			 * channels can be mixed via ACI.
-			 */
-			volume = 0x6464;
-			mixer_devs[num_mixers]->ioctl(num_mixers,
-				SOUND_MIXER_WRITE_PCM, (caddr_t) &volume);
-			volume = 0x6464;
-			mixer_devs[num_mixers]->ioctl(num_mixers,
-				SOUND_MIXER_WRITE_IGAIN,   (caddr_t) &volume);
-			volume = 0;
-			mixer_devs[num_mixers]->ioctl(num_mixers,
-				SOUND_MIXER_WRITE_SPEAKER, (caddr_t) &volume);
-			volume = 0;
-			mixer_devs[num_mixers]->ioctl(num_mixers,
-				SOUND_MIXER_WRITE_MIC, (caddr_t) &volume);
-			volume = 0;
-			mixer_devs[num_mixers]->ioctl(num_mixers,
-				SOUND_MIXER_WRITE_IMIX, (caddr_t) &volume);
-			volume = 0;
-			mixer_devs[num_mixers]->ioctl(num_mixers,
-				SOUND_MIXER_WRITE_LINE1, (caddr_t) &volume);
-			volume = 0;
-			mixer_devs[num_mixers]->ioctl(num_mixers,
-				SOUND_MIXER_WRITE_LINE2, (caddr_t) &volume);
-			volume = 0;
-			mixer_devs[num_mixers]->ioctl(num_mixers,
-				SOUND_MIXER_WRITE_LINE3, (caddr_t) &volume);
-			volume = SOUND_MASK_LINE1;
-			mixer_devs[num_mixers]->ioctl(num_mixers,
-				SOUND_MIXER_WRITE_RECSRC, (caddr_t) &volume);
-			num_mixers++;
-		} else
-			mixer_devs[num_mixers++] = &aci_mixer_operations;
-	}
-
-	/* Just do something; otherwise the first write command fails, at
-	 * least with my PCM20.
-	 */
-	aci_mixer_ioctl(num_mixers-1, SOUND_MIXER_READ_VOLUME, (caddr_t) &volume);
-	
-	if (aci_reset) {
-		/* Initialize ACI mixer with reasonable power-up values */
-		volume = 0x3232;
-		aci_mixer_ioctl(num_mixers-1, SOUND_MIXER_WRITE_VOLUME, (caddr_t) &volume);
-		volume = 0x3232;
-		aci_mixer_ioctl(num_mixers-1, SOUND_MIXER_WRITE_SYNTH,  (caddr_t) &volume);
-		volume = 0x3232;
-		aci_mixer_ioctl(num_mixers-1, SOUND_MIXER_WRITE_PCM,    (caddr_t) &volume);
-		volume = 0x3232;
-		aci_mixer_ioctl(num_mixers-1, SOUND_MIXER_WRITE_LINE,   (caddr_t) &volume);
-		volume = 0x3232;
-		aci_mixer_ioctl(num_mixers-1, SOUND_MIXER_WRITE_MIC,    (caddr_t) &volume);
-		volume = 0x3232;
-		aci_mixer_ioctl(num_mixers-1, SOUND_MIXER_WRITE_CD,     (caddr_t) &volume);
-		volume = 0x3232;
-		aci_mixer_ioctl(num_mixers-1, SOUND_MIXER_WRITE_LINE1,  (caddr_t) &volume);
-		volume = 0x3232;
-		aci_mixer_ioctl(num_mixers-1, SOUND_MIXER_WRITE_LINE2,  (caddr_t) &volume);
+	} else {
+		printk("aci: Warning: unsupported card! - "
+		       "no hardware, no specs...\n");
+		boardname = "unknown Cardinal Technologies";
+	}
+
+	printk("<ACI 0x%02x, id %02x/%02x \"%c/%c\", (%s)> at 0x%03x\n",
+	       aci_version,
+	       aci_idcode[0], aci_idcode[1],
+	       aci_idcode[0], aci_idcode[1],
+	       boardname, aci_port);
+
+	if (reset) {
+		/* first write()s after reset fail with my PCM20 */
+		if (aci_rw_cmd(0xff, -1, -1)<0 ||
+		    aci_rw_cmd(0xdf, 0xdf, 0xdf)<0 ||
+		    aci_rw_cmd(0xdf, 0xdf, 0xdf)<0)
+			return -EBUSY;
+	}
+
+	/* the PCM20 is muted after reset (and reboot) */
+	if (aci_rw_cmd(0x0d, 0x00, -1)<0)
+		return -EBUSY;
+
+	if (ide>=0)
+		if (aci_rw_cmd(0xd0, !ide, -1)<0)
+			return -EBUSY;
+	
+	if (wss>=0 && aci_idcode[1]=='A')
+		if (aci_rw_cmd(0xd1, !!wss, -1)<0)
+			return -EBUSY;
+
+	if (!request_region(aci_port, 3, "sound mixer (ACI)"))
+		return -ENOMEM;
+
+	if ((mixer_device = sound_install_mixer(MIXER_DRIVER_VERSION,
+						boardname,
+						&aci_mixer_operations,
+						sizeof(aci_mixer_operations),
+						NULL)) >= 0) {
+		/* Maybe initialize the CS4231A mixer here... */
+	} else {
+		printk("aci: Failed to install mixer.\n");
+		release_region(aci_port, 3);
+		return mixer_device;
 	}
 
-	aci_present = 1;
-
-	return 1;
+	return 0;
 }
 
 static void __exit unload_aci(void)
 {
-	if (aci_present)
-		release_region(aci_port, 3);
+	sound_unload_mixerdev(mixer_device);
+	release_region(aci_port, 3);
 }
 
 module_init(attach_aci);
diff -urN -X dontdiff linux-vanilla/drivers/sound/aci.h linux/drivers/sound/aci.h
--- linux-vanilla/drivers/sound/aci.h	Thu Jan  1 01:00:00 1970
+++ linux/drivers/sound/aci.h	Sat Jan 27 16:25:02 2001
@@ -0,0 +1,55 @@
+#ifndef _ACI_H_
+#define _ACI_H_
+
+extern int aci_port;
+extern int aci_idcode[2];	/* manufacturer and product ID */
+extern int aci_version;		/* ACI firmware version	*/
+extern int aci_rw_cmd(int write1, int write2, int write3);
+
+extern char * aci_radio_name;
+extern int aci_rds_cmd(unsigned char cmd, unsigned char databuffer[], int datasize);
+
+#define aci_indexed_cmd(a, b) aci_rw_cmd(a, b, -1)
+#define aci_write_cmd(a, b)   aci_rw_cmd(a, b, -1)
+#define aci_read_cmd(a)       aci_rw_cmd(a,-1, -1)
+
+#define COMMAND_REGISTER    (aci_port)      /* write register */
+#define STATUS_REGISTER     (aci_port + 1)  /* read register */
+#define BUSY_REGISTER       (aci_port + 2)  /* also used for rds */
+
+#define RDS_REGISTER        BUSY_REGISTER
+
+#define RDS_STATUS      0x01
+#define RDS_STATIONNAME 0x02
+#define RDS_TEXT        0x03
+#define RDS_ALTFREQ     0x04
+#define RDS_TIMEDATE    0x05
+#define RDS_PI_CODE     0x06
+#define RDS_PTYTATP     0x07
+#define RDS_RESET       0x08
+#define RDS_RXVALUE     0x09
+
+/*
+ * The following macro SCALE can be used to scale one integer volume
+ * value into another one using only integer arithmetic. If the input
+ * value x is in the range 0 <= x <= xmax, then the result will be in
+ * the range 0 <= SCALE(xmax,ymax,x) <= ymax.
+ *
+ * This macro has for all xmax, ymax > 0 and all 0 <= x <= xmax the
+ * following nice properties:
+ *
+ * - SCALE(xmax,ymax,xmax) = ymax
+ * - SCALE(xmax,ymax,0) = 0
+ * - SCALE(xmax,ymax,SCALE(ymax,xmax,SCALE(xmax,ymax,x))) = SCALE(xmax,ymax,x)
+ *
+ * In addition, the rounding error is minimal and nicely distributed.
+ * The proofs are left as an exercise to the reader.
+ */
+
+#define SCALE(xmax,ymax,x) (((x)*(ymax)+(xmax)/2)/(xmax))
+
+extern void __exit unload_aci_rds(void);
+extern int __init attach_aci_rds(void);
+
+
+#endif  /* _ACI_H_ */
diff -urN -X dontdiff linux-vanilla/drivers/sound/miroaci.h linux/drivers/sound/miroaci.h
--- linux-vanilla/drivers/sound/miroaci.h	Mon Mar 13 04:13:06 2000
+++ linux/drivers/sound/miroaci.h	Thu Jan  1 01:00:00 1970
@@ -1,5 +0,0 @@
-extern int aci_implied_cmd(unsigned char opcode);
-extern int aci_write_cmd(unsigned char opcode, unsigned char parameter);
-extern int aci_write_cmd_d(unsigned char opcode, unsigned char parameter, unsigned char parameter2);
-extern int aci_read_cmd(unsigned char opcode, int length, unsigned char *parameter);
-extern int aci_indexed_cmd(unsigned char opcode, unsigned char index, unsigned char *parameter);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
