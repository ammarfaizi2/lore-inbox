Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131242AbQKXOTb>; Fri, 24 Nov 2000 09:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129803AbQKXOTS>; Fri, 24 Nov 2000 09:19:18 -0500
Received: from orbita.don.sitek.net ([213.24.25.98]:22532 "EHLO
        orbita.don.sitek.net") by vger.kernel.org with ESMTP
        id <S130205AbQKXN2P>; Fri, 24 Nov 2000 08:28:15 -0500
Date: Fri, 24 Nov 2000 15:58:18 +0300
From: Andrey Panin <pazke@orbita.don.sitek.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] linux/drivers/media/radio check_region() removal
Message-ID: <20001124155818.B3900@debian>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="s2ZSL+KKDSLx8OML"
User-Agent: Mutt/1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--s2ZSL+KKDSLx8OML
Content-Type: multipart/mixed; boundary="X1bOJ3K7DJ5YkBrT"


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable


Hi all,

attached patch removes all check_region() calls from /linux/drivers/media/r=
adio
drivers. Most changes  are obvious, except radio-cadet.c which needs some=
=20
maintainer's attention.=20

I hope it will be usefull.

Best regards,
	    Andrey

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-radio-2.4.0t11"
Content-Transfer-Encoding: quoted-printable

diff -ur -x *.flags -x media.o /mnt/disk/linux/drivers/media/radio/radio-ai=
mslab.c /linux/drivers/media/radio/radio-aimslab.c
--- /mnt/disk/linux/drivers/media/radio/radio-aimslab.c	Mon Nov 20 21:01:53=
 2000
+++ /linux/drivers/media/radio/radio-aimslab.c	Fri Nov 24 13:04:09 2000
@@ -29,7 +29,7 @@
=20
 #include <linux/module.h>	/* Modules 			*/
 #include <linux/init.h>		/* Initdata			*/
-#include <linux/ioport.h>	/* check_region, request_region	*/
+#include <linux/ioport.h>	/* request_region		*/
 #include <linux/delay.h>	/* udelay			*/
 #include <asm/io.h>		/* outb, outb_p			*/
 #include <asm/uaccess.h>	/* copy to/from user		*/
@@ -42,7 +42,7 @@
 #endif
=20
 static int io =3D CONFIG_RADIO_RTRACK_PORT;=20
-static int users =3D 0;
+static int users;
 static struct semaphore lock;
=20
 struct rt_device
@@ -338,7 +338,7 @@
 		return -EINVAL;
 	}
=20
-	if (check_region(io, 2))=20
+	if (!request_region(io, 2, "rtrack"))
 	{
 		printk(KERN_ERR "rtrack: port 0x%x already in use\n", io);
 		return -EBUSY;
@@ -346,10 +346,11 @@
=20
 	rtrack_radio.priv=3D&rtrack_unit;
 =09
-	if(video_register_device(&rtrack_radio, VFL_TYPE_RADIO)=3D=3D-1)
+	if (video_register_device(&rtrack_radio, VFL_TYPE_RADIO) =3D=3D -1) {
+		release_region(io, 2);
 		return -EINVAL;
+	}
 	=09
-	request_region(io, 2, "rtrack");
 	printk(KERN_INFO "AIMSlab RadioTrack/RadioReveal card driver.\n");
=20
 	/* Set up the I/O locking */
diff -ur -x *.flags -x media.o /mnt/disk/linux/drivers/media/radio/radio-az=
tech.c /linux/drivers/media/radio/radio-aztech.c
--- /mnt/disk/linux/drivers/media/radio/radio-aztech.c	Mon Nov 20 21:01:53 =
2000
+++ /linux/drivers/media/radio/radio-aztech.c	Fri Nov 24 13:04:09 2000
@@ -26,7 +26,7 @@
=20
 #include <linux/module.h>	/* Modules 			*/
 #include <linux/init.h>		/* Initdata			*/
-#include <linux/ioport.h>	/* check_region, request_region	*/
+#include <linux/ioport.h>	/* request_region		*/
 #include <linux/delay.h>	/* udelay			*/
 #include <asm/io.h>		/* outb, outb_p			*/
 #include <asm/uaccess.h>	/* copy to/from user		*/
@@ -41,7 +41,7 @@
=20
 static int io =3D CONFIG_RADIO_AZTECH_PORT;=20
 static int radio_wait_time =3D 1000;
-static int users =3D 0;
+static int users;
 static struct semaphore lock;
=20
 struct az_device
@@ -289,7 +289,7 @@
 		return -EINVAL;
 	}
=20
-	if (check_region(io, 2))=20
+	if (!request_region(io, 2, "aztech"))=20
 	{
 		printk(KERN_ERR "aztech: port 0x%x already in use\n", io);
 		return -EBUSY;
@@ -298,10 +298,11 @@
 	init_MUTEX(&lock);
 	aztech_radio.priv=3D&aztech_unit;
 =09
-	if(video_register_device(&aztech_radio, VFL_TYPE_RADIO)=3D=3D-1)
+	if (video_register_device(&aztech_radio, VFL_TYPE_RADIO) =3D=3D -1) {
+		release_region(io, 2);
 		return -EINVAL;
+	}
 	=09
-	request_region(io, 2, "aztech");
 	printk(KERN_INFO "Aztech radio card driver v1.00/19990224 rkroll@exploits=
.org\n");
 	/* mute card - prevents noisy bootups */
 	outb (0, io);
diff -ur -x *.flags -x media.o /mnt/disk/linux/drivers/media/radio/radio-ca=
det.c /linux/drivers/media/radio/radio-cadet.c
--- /mnt/disk/linux/drivers/media/radio/radio-cadet.c	Mon Nov 20 21:01:54 2=
000
+++ /linux/drivers/media/radio/radio-cadet.c	Fri Nov 24 13:17:22 2000
@@ -20,7 +20,7 @@
=20
 #include <linux/module.h>	/* Modules 			*/
 #include <linux/init.h>		/* Initdata			*/
-#include <linux/ioport.h>	/* check_region, request_region	*/
+#include <linux/ioport.h>	/* request_region		*/
 #include <linux/delay.h>	/* udelay			*/
 #include <asm/io.h>		/* outb, outb_p			*/
 #include <asm/uaccess.h>	/* copy to/from user		*/
@@ -34,15 +34,15 @@
 #define RDS_BUFFER 256
=20
 static int io=3DCONFIG_RADIO_CADET_PORT;=20
-static int users=3D0;
-static int curtuner=3D0;
-static int tunestat=3D0;
-static int sigstrength=3D0;
+static int users;
+static int curtuner;
+static int tunestat;
+static int sigstrength;
 static wait_queue_head_t tunerq,rdsq,readq;
 struct timer_list tunertimer,rdstimer,readtimer;
-static __u8 rdsin=3D0,rdsout=3D0,rdsstat=3D0;
+static __u8 rdsin,rdsout,rdsstat;
 static unsigned char rdsbuf[RDS_BUFFER];
-static int cadet_lock=3D0;
+static int cadet_lock;
=20
 #ifndef MODULE
 static int cadet_probe(void);
@@ -551,9 +551,28 @@
 	ioctl:		cadet_ioctl,
 };
=20
+#ifdef MODULE
+static int __init cadet_probe(int ioaddr)
+{
+	if (!request_region(ioaddr, 2, "cadet"))
+		return -EBUSY;
+
+	cadet_setfreq(1410);
+	if (cadet_getfreq() =3D=3D 1410) {
+		io =3D ioaddr;
+		return 0;
+	}
+
+	release_region(ioaddr, 2);
+	return -ENODEV;
+}
+#endif		/* MODULE */
+
 #ifdef CONFIG_ISAPNP
-static int isapnp_cadet_probe(void)
+static int __init isapnp_cadet_probe(void)
 {
+	int retval;
+
 	dev =3D isapnp_find_dev (NULL, ISAPNP_VENDOR('M','S','M'),
 	                       ISAPNP_FUNCTION(0x0c24), NULL);
=20
@@ -564,60 +583,61 @@
 	if (!(dev->resource[0].flags & IORESOURCE_IO))
 		return -ENODEV;
 	if (dev->activate(dev)<0) {
-		printk ("radio-cadet: isapnp configure failed (out of resources?)\n");
+		printk (KERN_ERR "radio-cadet: isapnp configure failed (out of resources=
?)\n");
 		return -ENOMEM;
 	}
=20
-	io =3D dev->resource[0].start;
+	printk (KERN_INFO "radio-cadet: ISAPnP reports card at %#x\n", io);
+
+	if ((retval =3D cadet_probe(dev->resource[0].start))) {
+		dev->deactivate(dev);
+		return retval;
+	}
=20
-	printk ("radio-cadet: ISAPnP reports card at %#x\n", io);
+	io =3D dev->resource[0].start;
=20
-	return io;
+	return 0;
 }
 #endif		/* CONFIG_ISAPNP */
=20
-#ifdef MODULE
-static int cadet_probe(void)
+static int __init cadet_init(void)
 {
-        static int iovals[8]=3D{0x330,0x332,0x334,0x336,0x338,0x33a,0x33c,=
0x33e};
 	int i;
=20
-	for(i=3D0;i<8;i++) {
-	        io=3Diovals[i];
-	        if(check_region(io,2)>=3D0) {
-		        cadet_setfreq(1410);
-			if(cadet_getfreq()=3D=3D1410) {
-			        return io;
-			}
-		}
-	}
-	return -1;
-}
-#endif		/* MODULE */
-
-static int __init cadet_init(void)
-{
 #ifdef CONFIG_ISAPNP
-	io =3D isapnp_cadet_probe();
-
-	if (io < 0)
-		return (io);
+	if (isapnp_cadet_probe() =3D=3D 0)
+		goto found;
 #else
+
 #ifndef MODULE		/* only probe on non-ISAPnP monolithic compiles */
-	io =3D cadet_probe ();
+	{
+		int *port;
+		static int __initdata cadet_portlist[] =3D {
+			0x330, 0x332, 0x334, 0x336, 0x338,
+			0x33a, 0x33c, 0x33e, 0
+		};
+
+		for (port =3D cadet_portlist; *port; port++)
+			if (cadet_probe(*port) =3D=3D 0)
+				goto found;
+	}
 #endif /* MODULE */
+
 #endif /* CONFIG_ISAPNP */
=20
-        if(io < 0) {
-#ifdef MODULE       =20
+        if(io =3D=3D 0) {
+#ifdef MODULE
 		printk(KERN_ERR "You must set an I/O address with io=3D0x???\n");
 #endif
 	        return -EINVAL;
 	}
-	if (!request_region(io,2,"cadet"))
-		return -EBUSY;
-	if(video_register_device(&cadet_radio,VFL_TYPE_RADIO)=3D=3D-1) {
-		release_region(io,2);
+
+	if ((i =3D cadet_probe(io)))
+		return i;
+
+found:
+	if (video_register_device(&cadet_radio, VFL_TYPE_RADIO) =3D=3D -1) {
+		release_region(io, 2);
 		return -EINVAL;
 	}
 	printk(KERN_INFO "ADS Cadet Radio Card at 0x%x\n",io);
diff -ur -x *.flags -x media.o /mnt/disk/linux/drivers/media/radio/radio-ge=
mtek.c /linux/drivers/media/radio/radio-gemtek.c
--- /mnt/disk/linux/drivers/media/radio/radio-gemtek.c	Mon Nov 20 21:01:54 =
2000
+++ /linux/drivers/media/radio/radio-gemtek.c	Fri Nov 24 13:04:09 2000
@@ -17,7 +17,7 @@
=20
 #include <linux/module.h>	/* Modules 			*/
 #include <linux/init.h>		/* Initdata			*/
-#include <linux/ioport.h>	/* check_region, request_region	*/
+#include <linux/ioport.h>	/* request_region		*/
 #include <linux/delay.h>	/* udelay			*/
 #include <asm/io.h>		/* outb, outb_p			*/
 #include <asm/uaccess.h>	/* copy to/from user		*/
@@ -30,7 +30,7 @@
 #endif
=20
 static int io =3D CONFIG_RADIO_GEMTEK_PORT;=20
-static int users =3D 0;
+static int users;
 static spinlock_t lock;
=20
 struct gemtek_device
@@ -265,7 +265,7 @@
 		return -EINVAL;
 	}
=20
-	if (check_region(io, 4))=20
+	if (!request_region(io, 4, "gemtek"))
 	{
 		printk(KERN_ERR "gemtek: port 0x%x already in use\n", io);
 		return -EBUSY;
@@ -273,10 +273,11 @@
=20
 	gemtek_radio.priv=3D&gemtek_unit;
 =09
-	if(video_register_device(&gemtek_radio, VFL_TYPE_RADIO)=3D=3D-1)
+	if (video_register_device(&gemtek_radio, VFL_TYPE_RADIO) =3D=3D -1) {
+		release_region(io, 4);
 		return -EINVAL;
-	=09
-	request_region(io, 4, "gemtek");
+	}
+
 	printk(KERN_INFO "GemTek Radio Card driver.\n");
=20
 	spin_lock_init(&lock);
diff -ur -x *.flags -x media.o /mnt/disk/linux/drivers/media/radio/radio-ma=
estro.c /linux/drivers/media/radio/radio-maestro.c
--- /mnt/disk/linux/drivers/media/radio/radio-maestro.c	Mon Nov 20 21:01:54=
 2000
+++ /linux/drivers/media/radio/radio-maestro.c	Fri Nov 24 13:04:09 2000
@@ -84,9 +84,9 @@
 		stereo,	/* VIDEO_TUNER_STEREO_ON */=09
 		tuned;	/* signal strength (0 or 0xffff) */
 	struct  semaphore lock;
-} radio_unit =3D {0, 0, 0, 0, };
+} radio_unit;
=20
-static int users =3D 0;
+static int users;
=20
 static void sleep_125ms(void)
 {
@@ -361,7 +361,7 @@
 =09
 	if(radio_power_on(&radio_unit)) {
 		if(video_register_device(&maestro_radio, VFL_TYPE_RADIO)=3D=3D-1) {
-			printk("radio-maestro: can't register device!");
+			printk(KERN_ERR "radio-maestro: can't register device!");
 			return 0;
 		}
 		printk(KERN_INFO "radio-maestro: version "
diff -ur -x *.flags -x media.o /mnt/disk/linux/drivers/media/radio/radio-mi=
ropcm20.c /linux/drivers/media/radio/radio-miropcm20.c
--- /mnt/disk/linux/drivers/media/radio/radio-miropcm20.c	Mon Nov 20 21:01:=
54 2000
+++ /linux/drivers/media/radio/radio-miropcm20.c	Fri Nov 24 13:04:09 2000
@@ -12,7 +12,7 @@
 #include <linux/videodev.h>		/* kernel radio structs		*/
 #include "../../sound/miroaci.h"	/* ACI Control by acimixer      */
=20
-static int users =3D 0;
+static int users;
=20
 struct pcm20_device
 {
diff -ur -x *.flags -x media.o /mnt/disk/linux/drivers/media/radio/radio-rt=
rack2.c /linux/drivers/media/radio/radio-rtrack2.c
--- /mnt/disk/linux/drivers/media/radio/radio-rtrack2.c	Mon Nov 20 21:01:54=
 2000
+++ /linux/drivers/media/radio/radio-rtrack2.c	Fri Nov 24 13:04:09 2000
@@ -10,7 +10,7 @@
=20
 #include <linux/module.h>	/* Modules 			*/
 #include <linux/init.h>		/* Initdata			*/
-#include <linux/ioport.h>	/* check_region, request_region	*/
+#include <linux/ioport.h>	/* request_region		*/
 #include <linux/delay.h>	/* udelay			*/
 #include <asm/io.h>		/* outb, outb_p			*/
 #include <asm/uaccess.h>	/* copy to/from user		*/
@@ -23,7 +23,7 @@
 #endif
=20
 static int io =3D CONFIG_RADIO_RTRACK2_PORT;=20
-static int users =3D 0;
+static int users;
 static spinlock_t lock;
=20
 struct rt_device
@@ -230,7 +230,7 @@
 		printk(KERN_ERR "You must set an I/O address with io=3D0x20c or io=3D0x3=
0c\n");
 		return -EINVAL;
 	}
-	if (check_region(io, 4))=20
+	if (!request_region(io, 4, "rtrack2"))=20
 	{
 		printk(KERN_ERR "rtrack2: port 0x%x already in use\n", io);
 		return -EBUSY;
@@ -242,7 +242,6 @@
 	if(video_register_device(&rtrack2_radio, VFL_TYPE_RADIO)=3D=3D-1)
 		return -EINVAL;
 	=09
-	request_region(io, 4, "rtrack2");
 	printk(KERN_INFO "AIMSlab Radiotrack II card driver.\n");
=20
  	/* mute card - prevents noisy bootups */
diff -ur -x *.flags -x media.o /mnt/disk/linux/drivers/media/radio/radio-sf=
16fmi.c /linux/drivers/media/radio/radio-sf16fmi.c
--- /mnt/disk/linux/drivers/media/radio/radio-sf16fmi.c	Mon Nov 20 21:01:54=
 2000
+++ /linux/drivers/media/radio/radio-sf16fmi.c	Fri Nov 24 13:04:09 2000
@@ -16,7 +16,7 @@
=20
 #include <linux/module.h>	/* Modules 			*/
 #include <linux/init.h>		/* Initdata			*/
-#include <linux/ioport.h>	/* check_region, request_region	*/
+#include <linux/ioport.h>	/* request_region		*/
 #include <linux/delay.h>	/* udelay			*/
 #include <asm/io.h>		/* outb, outb_p			*/
 #include <asm/uaccess.h>	/* copy to/from user		*/
@@ -37,7 +37,7 @@
 #endif
=20
 static int io =3D CONFIG_RADIO_SF16FMI_PORT;=20
-static int users =3D 0;
+static int users;
 static struct semaphore lock;
=20
 /* freq is in 1/16 kHz to internal number, hw precision is 50 kHz */
@@ -291,7 +291,7 @@
 		printk(KERN_ERR "You must set an I/O address with io=3D0x???\n");
 		return -EINVAL;
 	}
-	if (check_region(io, 2))=20
+	if (!request_region(io, 2, "fmi"))
 	{
 		printk(KERN_ERR "fmi: port 0x%x already in use\n", io);
 		return -EBUSY;
@@ -304,11 +304,12 @@
 	fmi_radio.priv =3D &fmi_unit;
 =09
 	init_MUTEX(&lock);
-=09
-	if(video_register_device(&fmi_radio, VFL_TYPE_RADIO)=3D=3D-1)
+
+	if(video_register_device(&fmi_radio, VFL_TYPE_RADIO)=3D=3D-1) {
+		release_region(io, 2);
 		return -EINVAL;
-	=09
-	request_region(io, 2, "fmi");
+	}
+
 	printk(KERN_INFO "SF16FMx radio card driver at 0x%x.\n", io);
 	printk(KERN_INFO "(c) 1998 Petr Vandrovec, vandrove@vc.cvut.cz.\n");
 	/* mute card - prevents noisy bootups */
diff -ur -x *.flags -x media.o /mnt/disk/linux/drivers/media/radio/radio-te=
rratec.c /linux/drivers/media/radio/radio-terratec.c
--- /mnt/disk/linux/drivers/media/radio/radio-terratec.c	Mon Nov 20 21:01:5=
4 2000
+++ /linux/drivers/media/radio/radio-terratec.c	Fri Nov 24 13:04:09 2000
@@ -25,7 +25,7 @@
=20
 #include <linux/module.h>	/* Modules 			*/
 #include <linux/init.h>		/* Initdata			*/
-#include <linux/ioport.h>	/* check_region, request_region	*/
+#include <linux/ioport.h>	/* request_region		*/
 #include <linux/delay.h>	/* udelay			*/
 #include <asm/io.h>		/* outb, outb_p			*/
 #include <asm/uaccess.h>	/* copy to/from user		*/
@@ -50,7 +50,7 @@
 /*******************************************************************/
=20
 static int io =3D CONFIG_RADIO_TERRATEC_PORT;=20
-static int users =3D 0;
+static int users;
 static spinlock_t lock;
=20
 struct tt_device
@@ -309,7 +309,7 @@
 		printk(KERN_ERR "You must set an I/O address with io=3D0x???\n");
 		return -EINVAL;
 	}
-	if (check_region(io, 2))=20
+	if (!request_region(io, 2, "terratec"))=20
 	{
 		printk(KERN_ERR "TerraTec: port 0x%x already in use\n", io);
 		return -EBUSY;
@@ -319,10 +319,11 @@
 =09
 	spin_lock_init(&lock);
 =09
-	if(video_register_device(&terratec_radio, VFL_TYPE_RADIO)=3D=3D-1)
+	if(video_register_device(&terratec_radio, VFL_TYPE_RADIO)=3D=3D-1) {
+		release_region(io, 2);
 		return -EINVAL;
+	}
 	=09
-	request_region(io, 2, "terratec");
 	printk(KERN_INFO "TERRATEC ActivRadio Standalone card driver.\n");
=20
  	/* mute card - prevents noisy bootups */
diff -ur -x *.flags -x media.o /mnt/disk/linux/drivers/media/radio/radio-tr=
ust.c /linux/drivers/media/radio/radio-trust.c
--- /mnt/disk/linux/drivers/media/radio/radio-trust.c	Mon Nov 20 21:01:54 2=
000
+++ /linux/drivers/media/radio/radio-trust.c	Fri Nov 24 13:04:09 2000
@@ -32,7 +32,7 @@
=20
 static int io =3D CONFIG_RADIO_TRUST_PORT;=20
 static int ioval =3D 0xf;
-static int users =3D 0;
+static int users;
 static __u16 curvol;
 static __u16 curbass;
 static __u16 curtreble;
@@ -300,15 +300,15 @@
 		printk(KERN_ERR "You must set an I/O address with io=3D0x???\n");
 		return -EINVAL;
 	}
-	if(check_region(io, 2)) {
+	if (!request_region(io, 2, "Trust FM Radio")) {
 		printk(KERN_ERR "trust: port 0x%x already in use\n", io);
 		return -EBUSY;
 	}
-	if(video_register_device(&trust_radio, VFL_TYPE_RADIO)=3D=3D-1)
+	if(video_register_device(&trust_radio, VFL_TYPE_RADIO)=3D=3D-1) {
+		release_region(io, 2);
 		return -EINVAL;
+	}
 	=09
-	request_region(io, 2, "Trust FM Radio");
-
 	printk(KERN_INFO "Trust FM Radio card driver v1.0.\n");
=20
 	write_i2c(2, TDA7318_ADDR, 0x80);	/* speaker att. LF =3D 0 dB */
diff -ur -x *.flags -x media.o /mnt/disk/linux/drivers/media/radio/radio-ty=
phoon.c /linux/drivers/media/radio/radio-typhoon.c
--- /mnt/disk/linux/drivers/media/radio/radio-typhoon.c	Mon Nov 20 21:01:54=
 2000
+++ /linux/drivers/media/radio/radio-typhoon.c	Fri Nov 24 13:04:09 2000
@@ -29,14 +29,14 @@
  * completely silent.
  */
=20
-#include <linux/module.h>	/* Modules                        */
-#include <linux/init.h>		/* Initdata                       */
-#include <linux/ioport.h>	/* check_region, request_region   */
-#include <linux/proc_fs.h>	/* radio card status report	  */
-#include <asm/io.h>		/* outb, outb_p                   */
-#include <asm/uaccess.h>	/* copy to/from user              */
-#include <linux/videodev.h>	/* kernel radio structs           */
-#include <linux/config.h>	/* CONFIG_RADIO_TYPHOON_*         */
+#include <linux/module.h>	/* Modules			*/
+#include <linux/init.h>		/* Initdata			*/
+#include <linux/ioport.h>	/* request_region		*/
+#include <linux/proc_fs.h>	/* radio card status report	*/
+#include <asm/io.h>		/* outb, outb_p			*/
+#include <asm/uaccess.h>	/* copy to/from user		*/
+#include <linux/videodev.h>	/* kernel radio structs		*/
+#include <linux/config.h>	/* CONFIG_RADIO_TYPHOON_*	*/
=20
 #define BANNER "Typhoon Radio Card driver v0.1\n"
=20
@@ -328,7 +328,7 @@
 static int io =3D -1;
=20
 #ifdef MODULE
-static unsigned long mutefreq =3D 0;
+static unsigned long mutefreq;
 #endif
=20
 static int __init typhoon_init(void)
@@ -350,17 +350,18 @@
=20
 	printk(KERN_INFO BANNER);
 	io =3D typhoon_unit.iobase;
-	if (check_region(io, 8)) {
+	if (!request_region(io, 8, "typhoon")) {
 		printk(KERN_ERR "radio-typhoon: port 0x%x already in use\n",
 		       typhoon_unit.iobase);
 		return -EBUSY;
 	}
=20
 	typhoon_radio.priv =3D &typhoon_unit;
-	if (video_register_device(&typhoon_radio, VFL_TYPE_RADIO) =3D=3D -1)
+	if (video_register_device(&typhoon_radio, VFL_TYPE_RADIO) =3D=3D -1) {
+		release_region(io, 8);
 		return -EINVAL;
+	}
=20
-	request_region(typhoon_unit.iobase, 8, "typhoon");
 	printk(KERN_INFO "radio-typhoon: port 0x%x.\n", typhoon_unit.iobase);
 	printk(KERN_INFO "radio-typhoon: mute frequency is %lu kHz.\n",
 	       typhoon_unit.mutefreq);
diff -ur -x *.flags -x media.o /mnt/disk/linux/drivers/media/radio/radio-zo=
ltrix.c /linux/drivers/media/radio/radio-zoltrix.c
--- /mnt/disk/linux/drivers/media/radio/radio-zoltrix.c	Mon Nov 20 21:01:54=
 2000
+++ /linux/drivers/media/radio/radio-zoltrix.c	Fri Nov 24 13:04:09 2000
@@ -25,21 +25,21 @@
  *	      - Reworked ioctl functions
  */
=20
-#include <linux/module.h>	/* Modules                        */
-#include <linux/init.h>		/* Initdata                       */
-#include <linux/ioport.h>	/* check_region, request_region   */
-#include <linux/delay.h>	/* udelay                 */
-#include <asm/io.h>		/* outb, outb_p                   */
-#include <asm/uaccess.h>	/* copy to/from user              */
-#include <linux/videodev.h>	/* kernel radio structs           */
-#include <linux/config.h>	/* CONFIG_RADIO_ZOLTRIX_PORT      */
+#include <linux/module.h>	/* Modules			*/
+#include <linux/init.h>		/* Initdata			*/
+#include <linux/ioport.h>	/* request_region		*/
+#include <linux/delay.h>	/* udelay			*/
+#include <asm/io.h>		/* outb, outb_p			*/
+#include <asm/uaccess.h>	/* copy to/from user		*/
+#include <linux/videodev.h>	/* kernel radio structs		*/
+#include <linux/config.h>	/* CONFIG_RADIO_ZOLTRIX_PORT	*/
=20
 #ifndef CONFIG_RADIO_ZOLTRIX_PORT
 #define CONFIG_RADIO_ZOLTRIX_PORT -1
 #endif
=20
 static int io =3D CONFIG_RADIO_ZOLTRIX_PORT;
-static int users =3D 0;
+static int users;
=20
 struct zol_device {
 	int port;
@@ -355,20 +355,22 @@
 		printk(KERN_ERR "You must set an I/O address with io=3D0x???\n");
 		return -EINVAL;
 	}
-	if (check_region(io, 2)) {
+	if (!request_region(io, 2, "zoltrix")) {
 		printk(KERN_ERR "zoltrix: port 0x%x already in use\n", io);
 		return -EBUSY;
 	}
 	if ((io !=3D 0x20c) && (io !=3D 0x30c)) {
 		printk(KERN_ERR "zoltrix: invalid port, try 0x20c or 0x30c\n");
+		release_region(io, 2);
 		return -ENXIO;
 	}
 	zoltrix_radio.priv =3D &zoltrix_unit;
=20
-	if (video_register_device(&zoltrix_radio, VFL_TYPE_RADIO) =3D=3D -1)
+	if (video_register_device(&zoltrix_radio, VFL_TYPE_RADIO) =3D=3D -1) {
+		release_region(io, 2);
 		return -EINVAL;
+	}
=20
-	request_region(io, 2, "zoltrix");
 	printk(KERN_INFO "Zoltrix Radio Plus card driver.\n");
=20
 	init_MUTEX(&zoltrix_unit.lock);

--X1bOJ3K7DJ5YkBrT--

--s2ZSL+KKDSLx8OML
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6HmXqBm4rlNOo3YgRAkhYAJ0TmsF5j1L78syoRrNl1wIsqsMlMwCfXMQF
OrWCiUyG8exPnhny7kB44Pg=
=7+cV
-----END PGP SIGNATURE-----

--s2ZSL+KKDSLx8OML--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
