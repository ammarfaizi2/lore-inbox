Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131985AbRDNKts>; Sat, 14 Apr 2001 06:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131986AbRDNKtk>; Sat, 14 Apr 2001 06:49:40 -0400
Received: from postfix2-1.free.fr ([213.228.0.9]:25604 "HELO
	postfix2-1.free.fr") by vger.kernel.org with SMTP
	id <S131985AbRDNKtX>; Sat, 14 Apr 2001 06:49:23 -0400
From: Fabien CHEVALIER <fabchev@free.fr>
Reply-To: fabchev@free.fr
Date: Sat, 14 Apr 2001 12:46:57 +0000
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="iso-8859-15"
To: linux-kernel@vger.kernel.org
In-Reply-To: <01041412302602.00723@localhost.localdomain>
In-Reply-To: <01041412302602.00723@localhost.localdomain>
Subject: Re: [PATCH- new driver] Maxi Radio FM 2 driver (GemTek) (3)
MIME-Version: 1.0
Message-Id: <01041412465703.00723@localhost.localdomain>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't send any attachment to the list, what's wrong?

I got this mail :

/************************/
Norton AntiVirus quarantined an attachment in a message you sent.
De : NAV for Microsoft Exchange-EXCHANGE <NAVMSE-EXCHANGE@advent-comm.co.uk>
À : 'Fabien CHEVALIER' <fabchev2@free.fr>
Date : Sat, 14 Apr 2001 11:35:10 +0100


Recipient of the attachment:  Jonathan Spillett\Personal\Linux Kernel
Subject of the message:  [PATCH- new driver] Maxi Radio FM 2 driver (GemTek)
(2)
One or more attachments were quarantined.
  Attachment patch-maxifm2-v0.12-2.4.3.gz was Quarantined for the following
reasons:
        Scan Engine Failure (0x80004005)
        General Scan Engine error
/**************************/

Sorry, for now i will send the patch uncompressed...

diff -Nru linux/drivers/media/radio/Config.in 
linuxm/drivers/media/radio/Config.in
--- linux/drivers/media/radio/Config.in	Fri Apr 13 12:46:46 2001
+++ linuxm/drivers/media/radio/Config.in	Fri Apr 13 12:24:24 2001
@@ -21,6 +21,10 @@
 if [ "$CONFIG_RADIO_GEMTEK" = "y" ]; then
    hex '    GemTek i/o port (0x20c, 0x30c, 0x24c or 0x34c)' 
CONFIG_RADIO_GEMTEK_PORT 34c
 fi
+dep_tristate '  Guillemot MAXI Radio FM 2 card support' CONFIG_RADIO_MAXIFM2 
$CONFIG_VIDEO_DEV
+if [ "$CONFIG_RADIO_MAXIFM2" = "y" ]; then
+   hex '    Maxi FM 2 i/o port (0x20c, 0x30c, 0x24c or 0x34c)' 
CONFIG_RADIO_MAXIFM2_PORT 34c
+fi
 dep_tristate '  Guillemot MAXI Radio FM 2000 radio' CONFIG_RADIO_MAXIRADIO 
$CONFIG_VIDEO_DEV
 dep_tristate '  Maestro on board radio' CONFIG_RADIO_MAESTRO 
$CONFIG_VIDEO_DEV
 dep_tristate '  Miro PCM20 Radio' CONFIG_RADIO_MIROPCM20 $CONFIG_VIDEO_DEV
diff -Nru linux/drivers/media/radio/Makefile 
linuxm/drivers/media/radio/Makefile
--- linux/drivers/media/radio/Makefile	Fri Apr 13 12:46:46 2001
+++ linuxm/drivers/media/radio/Makefile	Fri Apr 13 12:24:24 2001
@@ -31,6 +31,7 @@
 obj-$(CONFIG_RADIO_CADET) += radio-cadet.o
 obj-$(CONFIG_RADIO_TYPHOON) += radio-typhoon.o
 obj-$(CONFIG_RADIO_TERRATEC) += radio-terratec.o
+obj-$(CONFIG_RADIO_MAXIFM2) += radio-maxifm2.o
 obj-$(CONFIG_RADIO_MAXIRADIO) += radio-maxiradio.o
 obj-$(CONFIG_RADIO_RTRACK) += radio-aimslab.o
 obj-$(CONFIG_RADIO_ZOLTRIX) += radio-zoltrix.o
diff -Nru linux/drivers/media/radio/radio-maxifm2.c 
linuxm/drivers/media/radio/radio-maxifm2.c
--- linux/drivers/media/radio/radio-maxifm2.c	Thu Jan  1 00:00:00 1970
+++ linuxm/drivers/media/radio/radio-maxifm2.c	Fri Apr 13 12:48:46 2001
@@ -0,0 +1,347 @@
+/*
+ * Guillemot Maxi Radio FM 2 ISA radio card driver for Linux
+ * (C) 2001 Fabien Chevalier <fabchev@free.fr>
+ *
+ *  contains code from Maxi Radio FM 2000 and GemTek  drivers
+ *
+ * I reversed engineered the protocol from the win16 driver radio.exe
+ * with wine
+ * This driver contains as many features as the windows one : it
+ * even has card detection
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/delay.h>
+#include <asm/uaccess.h>
+#include <asm/semaphore.h>
+#include <asm/io.h>
+#include <linux/videodev.h>
+
+#define DRIVER_VERSION	"0.12"
+
+#ifndef CONFIG_RADIO_MAXIFM2_PORT
+#define CONFIG_RADIO_MAXIFM2_PORT -1
+#endif
+
+static int io = CONFIG_RADIO_MAXIFM2_PORT;
+
+#define PORTWIDTH 4
+
+/* Maybe this is too small, but i had to choose one
+(works perfectly on my computer)*/
+#define IODELAY 10
+
+#define FREQ_LO		 87*16000
+#define FREQ_HI		108*16000
+
+static __u8 powerbit = 16;
+static __u8 stereobit = 8;
+
+static int radio_open(struct video_device *, int);
+static int radio_ioctl(struct video_device *, unsigned int, void *);
+static void radio_close(struct video_device *);
+
+static struct video_device maxifm2_radio=
+{
+	owner:		THIS_MODULE,
+	name:		"Maxi Radio FM2 radio",
+	type:		VID_TYPE_TUNER,
+	hardware:	VID_HARDWARE_GEMTEK,
+	open:		radio_open,
+	close:		radio_close,
+	ioctl:		radio_ioctl,
+};
+
+static struct radio_device
+{
+	__u16	muted,	/* VIDEO_AUDIO_MUTE */
+		tuned;	/* signal strength (0 or 0xffff) */
+
+	unsigned long freq;
+
+	struct  semaphore lock;
+} card = {0, 0, 0, };
+
+
+/* to change the frequency, the card wants a 32 bit number : bits = a*f + b
+ * where f is the frequency in Mhz, where "a" is 78.12 and b is 1,107,297,092
+ *
+ * the final formula is :
+ * bits = ( 7812 * ( [video for linux value]  / 16000 ) ) / 100 + 1107297092
+ * I had to arrange it because there are no floating points -- Anybody has
+ * a better idea?
+ */
+
+inline __u32 freq_2_bits(unsigned long v4lfreq)
+{
+	__u32 fm2freq;
+	v4lfreq /= 16;
+	v4lfreq *= 7812;
+	v4lfreq /= 100000;
+	fm2freq = v4lfreq + 1107297092;
+	return fm2freq;
+}
+
+int __init card_detect()
+{
+	__u8 read, count;
+	int anything = 0;
+
+	for(count=0; count <= 3; count++) {
+		read = inb(io);
+		if (read != 0xff)
+			anything = 1; //There is something on this io port
+		outb_p( (read & 0xfc) | count, io);
+		udelay(IODELAY);
+	}
+
+	/*When we read, we must have 0xff or 0xf7, otherwise there
+	is not any maxi radio fm 2 card here*/
+	read = inb(io);
+
+	if(anything)
+		if(read == 0xf7 || read == 0xff)
+			return 1;
+		else
+			printk(KERN_ERR "Maxi Radio FM2 driver: Card not found on  I/O port 
0x%x\n", io);
+	else
+		printk(KERN_ERR "Maxi Radio FM2 driver: Nothing on I/O port 0x%x\n", io);
+
+	return 0;
+}
+
+/*This function is the result of the reverse engineering */
+
+static void set_freq(unsigned long v4lfreq)
+{
+	__u32 fm2freq;
+	int i;
+
+	fm2freq = freq_2_bits(v4lfreq);
+
+	outb_p(0x03, io);
+	udelay(IODELAY);
+	outb_p(0x07, io);
+	udelay(IODELAY);
+
+	for(i=0; i<=31; i++)
+		if((fm2freq >> i) & 1) {
+			//we send a 1 bit
+			outb_p(0x06, io);
+			udelay(IODELAY);
+			outb_p(0x07, io);
+			udelay(IODELAY);
+		} else {
+			//we send a 0 bit
+			outb_p(0x04, io);
+			udelay(IODELAY);
+			outb_p(0x05, io);
+			udelay(IODELAY);
+		}
+
+	outb_p(0x03, io);
+	udelay(IODELAY);
+	outb_p(0x07, io);
+	udelay(IODELAY);
+}
+
+
+static int get_tuned()
+{
+	return (~inb(io)) & stereobit;
+}
+
+static void turn_power(int p)
+{
+	if(p != 0)
+		outb_p(~powerbit, io);
+	else
+		outb_p(0xff, io);
+	udelay(IODELAY);
+}
+
+inline static int radio_function(struct video_device *dev,
+				 unsigned int cmd, void *arg)
+{
+	switch(cmd) {
+		case VIDIOCGCAP: {
+			struct video_capability v;
+
+			strcpy(v.name, "Maxi Radio FM2 radio");
+			v.type=VID_TYPE_TUNER;
+			v.channels=v.audios=1;
+			v.maxwidth=v.maxheight=v.minwidth=v.minheight=0;
+
+			if(copy_to_user(arg,&v,sizeof(v)))
+				return -EFAULT;
+
+			return 0;
+		}
+		case VIDIOCGTUNER: {
+			struct video_tuner v;
+
+			if(copy_from_user(&v, arg,sizeof(v))!=0)
+				return -EFAULT;
+
+			if(v.tuner)
+				return -EINVAL;
+
+			card.tuned = 0xffff * get_tuned();
+
+			v.flags = VIDEO_TUNER_LOW;
+			v.signal = card.tuned;
+
+			strcpy(v.name, "FM");
+
+			v.rangelow = FREQ_LO;
+			v.rangehigh = FREQ_HI;
+			v.mode = VIDEO_MODE_AUTO;
+
+			if(copy_to_user(arg,&v, sizeof(v)))
+				return -EFAULT;
+
+		  return 0;
+		}
+		case VIDIOCSTUNER: {
+			struct video_tuner v;
+
+			if(copy_from_user(&v, arg, sizeof(v)))
+				return -EFAULT;
+
+			if(v.tuner!=0)
+				return -EINVAL;
+
+			return 0;
+		}
+		case VIDIOCGFREQ: {
+			unsigned long tmp=card.freq;
+
+			if(copy_to_user(arg, &tmp, sizeof(tmp)))
+				return -EFAULT;
+
+			return 0;
+		}
+
+		case VIDIOCSFREQ: {
+			unsigned long tmp;
+
+			if(copy_from_user(&tmp, arg, sizeof(tmp)))
+				return -EFAULT;
+
+			if ( tmp<FREQ_LO || tmp>FREQ_HI )
+				return -EINVAL;
+
+			card.freq = tmp;
+
+			set_freq(card.freq);
+
+			return 0;
+		}
+		case VIDIOCGAUDIO: {
+			struct video_audio v;
+
+			strcpy(v.name, "Radio");
+			v.audio=v.volume=v.bass=v.treble=v.balance=v.step=0;
+			v.flags=VIDEO_AUDIO_MUTABLE | card.muted;
+			v.mode=VIDEO_SOUND_MONO;
+			if(copy_to_user(arg,&v, sizeof(v)))
+				return -EFAULT;
+			return 0;
+		}
+
+		case VIDIOCSAUDIO: {
+			struct video_audio v;
+
+			if(copy_from_user(&v, arg, sizeof(v)))
+				return -EFAULT;
+
+			if(v.audio)
+				return -EINVAL;
+
+
+			card.muted = v.flags & VIDEO_AUDIO_MUTE;
+			turn_power(!card.muted);
+
+			return 0;
+		}
+
+		default: return -ENOIOCTLCMD;
+	}
+}
+
+static int radio_ioctl(struct video_device *dev, unsigned int cmd, void *arg)
+{
+	int ret;
+	down(&card.lock);
+	ret = radio_function(dev, cmd, arg);
+	up(&card.lock);
+	return ret;
+}
+
+static int radio_open(struct video_device *dev, int flags)
+{
+	return 0;
+}
+
+static void radio_close(struct video_device *dev)
+{
+}
+
+int __init maxifm2_radio_init(void)
+{
+	if(io==-1) {
+		printk(KERN_ERR "You must set an I/O address with io=0x20c, io=0x30c, 
io=0x24c or io=0x34c\n");
+		return -EINVAL;
+	}
+
+	if(!request_region(io, PORTWIDTH, "Maxi Radio FM2")) {
+		printk(KERN_ERR "Maxi Radio FM2 driver: can't reserve I/O port 0x%x\n", 
io);
+		return -ENODEV;
+	}
+
+	if(!card_detect()) {
+		release_region(io, PORTWIDTH);
+		return -ENODEV;
+	}
+
+	if(video_register_device(&maxifm2_radio, VFL_TYPE_RADIO)==-1) {
+		printk(KERN_ERR "Maxi Radio FM2 driver: can't register video4linux 
device!");
+		release_region(io, PORTWIDTH);
+		return -ENODEV;
+	}
+
+	printk(KERN_INFO "Maxi Radio FM2 : v"
+		DRIVER_VERSION
+		" driver loaded\n");
+
+	card.muted = 1;
+	turn_power(!card.muted);
+
+	init_MUTEX(&card.lock);
+
+	return 0;
+}
+
+void __exit maxifm2_radio_exit(void)
+{
+	video_unregister_device(&maxifm2_radio);
+	release_region(io, PORTWIDTH);
+	printk(KERN_INFO "Maxi Radio FM2 : driver unloaded\n");
+}
+
+MODULE_AUTHOR("Fabien Chevalier, fabchev@free.fr");
+MODULE_DESCRIPTION("Radio driver for the Guillemot Maxi Radio FM2 radio.");
+MODULE_PARM(io, "i");
+MODULE_PARM_DESC(io, "I/O address of the Maxi Radio card. \
+			 If you don't know try 0x34c");
+
+EXPORT_NO_SYMBOLS;
+
+module_init(maxifm2_radio_init);
+module_exit(maxifm2_radio_exit);
+
+
+
