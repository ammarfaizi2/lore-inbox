Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261218AbTC3NJn>; Sun, 30 Mar 2003 08:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261242AbTC3NJn>; Sun, 30 Mar 2003 08:09:43 -0500
Received: from cpt-dial-196-30-179-50.mweb.co.za ([196.30.179.50]:21634 "EHLO
	nosferatu.lan") by vger.kernel.org with ESMTP id <S261218AbTC3NJH>;
	Sun, 30 Mar 2003 08:09:07 -0500
Subject: [PATCH-2.5] w83781d i2c driver updated for 2.5.66-bk4 (with sysfs
	support, empty tree)
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: Greg KH <greg@kroah.com>
Cc: KML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@brodo.de>,
       sensors@Stimpy.netroedge.com
In-Reply-To: <20030326234601.GB27436@kroah.com>
References: <1048582394.4774.7.camel@workshop.saharact.lan>
	 <20030325175603.GG15823@kroah.com> <1048705473.7569.10.camel@nosferatu.lan>
	 <20030326202904.GK24689@kroah.com> <1048721671.7569.46.camel@nosferatu.lan>
	 <20030326234601.GB27436@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-c2PiFYVsu/sGVUFoQuSd"
Organization: 
Message-Id: <1049028443.11721.40.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 30 Mar 2003 14:47:24 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-c2PiFYVsu/sGVUFoQuSd
Content-Type: multipart/mixed; boundary="=-c3wpRNPK/bV7ImK8mKw4"


--=-c3wpRNPK/bV7ImK8mKw4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi

This should have a working w83781d driver updated for 2.5.66-bk4.
Currently sysfs support is working, and are according to the spec
(sensors-sysfs) in the 'lm sensors sysfs file structure' thread.
Thus I used 'temp_input[1-3]', as there was not final decision
on having them temp_input[0-2] as well, for example.

This patch is against a 'vanilla' 2.5.66-bk4 (do not have w83781d.c
from lm_sensors2 cvs present).  Retry, as previous did not go through
due to size.


Regards,

--=20

Martin Schlemmer




--=-c3wpRNPK/bV7ImK8mKw4
Content-Disposition: attachment; filename=i2c-chip-w83781d-2.5.66bk4.patch
Content-Type: text/x-patch; name=i2c-chip-w83781d-2.5.66bk4.patch; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

diff -urPp ../linux-2.5.66bk4/drivers/i2c/chips/Kconfig linux.w83781d/drive=
rs/i2c/chips/Kconfig
--- ../linux-2.5.66bk4/drivers/i2c/chips/Kconfig	2003-03-25 00:00:45.000000=
000 +0200
+++ linux.w83781d/drivers/i2c/chips/Kconfig	2003-03-25 18:54:07.000000000 +=
0200
@@ -36,5 +36,19 @@ config SENSORS_LM75
 	  You will also need the latest user-space utilties: you can find them
 	  in the lm_sensors package, which you can download at=20
 	  http://www.lm-sensors.nu
+	 =20
+config SENSORS_W83781D
+	tristate "  Winbond W83781D, W83782D, W83783S, W83627HF, Asus AS99127F"
+	depends on I2C && I2C_PROC
+	help
+	  If you say yes here you get support for the Winbond W8378x series
+	  of sensor chips: the W83781D, W83782D, W83783S and W83682HF,
+	  and the similar Asus AS99127F. This
+	  can also be built as a module which can be inserted and removed
+	  while the kernel is running.
+	 =20
+	  You will also need the latest user-space utilties: you can find them
+	  in the lm_sensors package, which you can download at
+	  http://www.lm-sensors.nu
=20
 endmenu
diff -urPp ../linux-2.5.66bk4/drivers/i2c/chips/Makefile linux.w83781d/driv=
ers/i2c/chips/Makefile
--- ../linux-2.5.66bk4/drivers/i2c/chips/Makefile	2003-03-24 23:59:53.00000=
0000 +0200
+++ linux.w83781d/drivers/i2c/chips/Makefile	2003-03-25 18:54:11.000000000 =
+0200
@@ -4,3 +4,4 @@
=20
 obj-$(CONFIG_SENSORS_ADM1021)	+=3D adm1021.o
 obj-$(CONFIG_SENSORS_LM75)	+=3D lm75.o
+obj-$(CONFIG_SENSORS_W83781D)	+=3D w83781d.o
diff -urPp ../linux-2.5.66bk4/drivers/i2c/chips/w83781d.c linux.w83781d/dri=
vers/i2c/chips/w83781d.c
--- ../linux-2.5.66bk4/drivers/i2c/chips/w83781d.c	1970-01-01 02:00:00.0000=
00000 +0200
+++ linux.w83781d/drivers/i2c/chips/w83781d.c	2003-03-30 08:28:43.000000000=
 +0200
@@ -0,0 +1,1884 @@
+/*
+    w83781d.c - Part of lm_sensors, Linux kernel modules for hardware
+                monitoring
+    Copyright (c) 1998 - 2001  Frodo Looijaard <frodol@dds.nl>,
+    Philip Edelbrock <phil@netroedge.com>,
+    and Mark Studebaker <mdsxyz123@yahoo.com>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+*/
+
+/*
+    Supports following chips:
+
+    Chip	#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA
+    as99127f	7	3	1?	3	0x30	0x12c3	yes	no
+    asb100 "bach" (type_name =3D as99127f)	0x30	0x0694	yes	no
+    w83781d	7	3	0	3	0x10	0x5ca3	yes	yes
+    w83627hf	9	3	2	3	0x20	0x5ca3	yes	yes(LPC)
+    w83782d	9	3	2-4	3	0x30	0x5ca3	yes	yes
+    w83783s	5-6	3	2	1-2	0x40	0x5ca3	yes	no
+    w83697hf	8	2	2	2	0x60	0x5ca3	no	yes(LPC)
+
+*/
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/i2c-proc.h>
+#include <linux/i2c-vid.h>
+#include <asm/io.h>
+
+/* RT Table support #defined so we can take it out if it gets bothersome *=
/
+#define W83781D_RT			1
+
+/* Addresses to scan */
+static unsigned short normal_i2c[] =3D { SENSORS_I2C_END };
+static unsigned short normal_i2c_range[] =3D { 0x20, 0x2f, SENSORS_I2C_END=
 };
+static unsigned int normal_isa[] =3D { 0x0290, SENSORS_ISA_END };
+static unsigned int normal_isa_range[] =3D { SENSORS_ISA_END };
+
+/* Insmod parameters */
+SENSORS_INSMOD_6(w83781d, w83782d, w83783s, w83627hf, as99127f, w83697hf);
+SENSORS_MODULE_PARM(force_subclients, "List of subclient addresses: "
+		    "{bus, clientaddr, subclientaddr1, subclientaddr2}");
+
+static int init =3D 1;
+MODULE_PARM(init, "i");
+MODULE_PARM_DESC(init, "Set to zero to bypass chip initialization");
+
+/* Constants specified below */
+
+/* Length of ISA address segment */
+#define W83781D_EXTENT			8
+
+/* Where are the ISA address/data registers relative to the base address *=
/
+#define W83781D_ADDR_REG_OFFSET		5
+#define W83781D_DATA_REG_OFFSET		6
+
+/* The W83781D registers */
+/* The W83782D registers for nr=3D7,8 are in bank 5 */
+#define W83781D_REG_IN_MAX(nr)		((nr < 7) ? (0x2b + (nr) * 2) : \
+						    (0x554 + (((nr) - 7) * 2)))
+#define W83781D_REG_IN_MIN(nr)		((nr < 7) ? (0x2c + (nr) * 2) : \
+						    (0x555 + (((nr) - 7) * 2)))
+#define W83781D_REG_IN(nr)		((nr < 7) ? (0x20 + (nr)) : \
+						    (0x550 + (nr) - 7))
+
+#define W83781D_REG_FAN_MIN(nr)		(0x3a + (nr))
+#define W83781D_REG_FAN(nr)		(0x27 + (nr))
+
+#define W83781D_REG_BANK		0x4E
+#define W83781D_REG_TEMP2_CONFIG	0x152
+#define W83781D_REG_TEMP3_CONFIG	0x252
+#define W83781D_REG_TEMP(nr)		((nr =3D=3D 3) ? (0x0250) : \
+					((nr =3D=3D 2) ? (0x0150) : \
+						     (0x27)))
+#define W83781D_REG_TEMP_HYST(nr)	((nr =3D=3D 3) ? (0x253) : \
+					((nr =3D=3D 2) ? (0x153) : \
+						     (0x3A)))
+#define W83781D_REG_TEMP_OVER(nr)	((nr =3D=3D 3) ? (0x255) : \
+					((nr =3D=3D 2) ? (0x155) : \
+						     (0x39)))
+
+#define W83781D_REG_CONFIG		0x40
+#define W83781D_REG_ALARM1		0x41
+#define W83781D_REG_ALARM2		0x42
+#define W83781D_REG_ALARM3		0x450	/* not on W83781D */
+
+#define W83781D_REG_IRQ			0x4C
+#define W83781D_REG_BEEP_CONFIG		0x4D
+#define W83781D_REG_BEEP_INTS1		0x56
+#define W83781D_REG_BEEP_INTS2		0x57
+#define W83781D_REG_BEEP_INTS3		0x453	/* not on W83781D */
+
+#define W83781D_REG_VID_FANDIV		0x47
+
+#define W83781D_REG_CHIPID		0x49
+#define W83781D_REG_WCHIPID		0x58
+#define W83781D_REG_CHIPMAN		0x4F
+#define W83781D_REG_PIN			0x4B
+
+/* 782D/783S only */
+#define W83781D_REG_VBAT		0x5D
+
+/* PWM 782D (1-4) and 783S (1-2) only */
+#define W83781D_REG_PWM1		0x5B	/* 782d and 783s/627hf datasheets disagree =
*/
+						/* on which is which; */
+#define W83781D_REG_PWM2		0x5A	/* We follow the 782d convention here, */
+						/* However 782d is probably wrong. */
+#define W83781D_REG_PWM3		0x5E
+#define W83781D_REG_PWM4		0x5F
+#define W83781D_REG_PWMCLK12		0x5C
+#define W83781D_REG_PWMCLK34		0x45C
+static const u8 regpwm[] =3D { W83781D_REG_PWM1, W83781D_REG_PWM2,
+	W83781D_REG_PWM3, W83781D_REG_PWM4
+};
+
+#define W83781D_REG_PWM(nr)		(regpwm[(nr) - 1])
+
+#define W83781D_REG_I2C_ADDR		0x48
+#define W83781D_REG_I2C_SUBADDR		0x4A
+
+/* The following are undocumented in the data sheets however we
+   received the information in an email from Winbond tech support */
+/* Sensor selection - not on 781d */
+#define W83781D_REG_SCFG1		0x5D
+static const u8 BIT_SCFG1[] =3D { 0x02, 0x04, 0x08 };
+
+#define W83781D_REG_SCFG2		0x59
+static const u8 BIT_SCFG2[] =3D { 0x10, 0x20, 0x40 };
+
+#define W83781D_DEFAULT_BETA		3435
+
+/* RT Table registers */
+#define W83781D_REG_RT_IDX		0x50
+#define W83781D_REG_RT_VAL		0x51
+
+/* Conversions. Rounding and limit checking is only done on the TO_REG
+   variants. Note that you should be a bit careful with which arguments
+   these macros are called: arguments may be evaluated more than once.
+   Fixing this is just not worth it. */
+#define IN_TO_REG(val)			(SENSORS_LIMIT((((val) * 10 + 8)/16),0,255))
+#define IN_FROM_REG(val)		(((val) * 16) / 10)
+
+static inline u8
+FAN_TO_REG(long rpm, int div)
+{
+	if (rpm =3D=3D 0)
+		return 255;
+	rpm =3D SENSORS_LIMIT(rpm, 1, 1000000);
+	return SENSORS_LIMIT((1350000 + rpm * div / 2) / (rpm * div), 1, 254);
+}
+
+#define FAN_FROM_REG(val,div)		((val) =3D=3D 0   ? -1 : \
+					((val) =3D=3D 255 ? 0 : \
+							1350000 / ((val) * (div))))
+
+#define TEMP_TO_REG(val)		(SENSORS_LIMIT(((val / 10) < 0 ? (((val / 10) - =
5) / 10) : \
+									 ((val / 10) + 5) / 10), 0, 255))
+#define TEMP_FROM_REG(val)		((((val ) > 0x80 ? (val) - 0x100 : (val)) * 10=
) * 10)
+
+#define TEMP_ADD_TO_REG(val)		(SENSORS_LIMIT(((((val / 10) + 2) / 5) << 7)=
,\
+                                              0, 0xffff))
+#define TEMP_ADD_FROM_REG(val)		((((val) >> 7) * 5) * 10)
+
+#define AS99127_TEMP_ADD_TO_REG(val)	(SENSORS_LIMIT((((((val / 10) + 2)*4)=
/10) \
+                                               << 7), 0, 0xffff))
+#define AS99127_TEMP_ADD_FROM_REG(val)	(((((val) >> 7) * 10) / 4) * 10)
+
+#define ALARMS_FROM_REG(val)		(val)
+#define PWM_FROM_REG(val)		(val)
+#define PWM_TO_REG(val)			(SENSORS_LIMIT((val),0,255))
+#define BEEP_MASK_FROM_REG(val)		(val)
+#define BEEP_MASK_TO_REG(val)		((val) & 0xffffff)
+
+#define BEEP_ENABLE_TO_REG(val)		((val) ? 1 : 0)
+#define BEEP_ENABLE_FROM_REG(val)	((val) ? 1 : 0)
+
+#define DIV_FROM_REG(val)		(1 << (val))
+
+static inline u8
+DIV_TO_REG(long val, enum chips type)
+{
+	int i;
+	val =3D SENSORS_LIMIT(val, 1,
+			    ((type =3D=3D w83781d
+			      || type =3D=3D as99127f) ? 8 : 128)) >> 1;
+	for (i =3D 0; i < 6; i++) {
+		if (val =3D=3D 0)
+			break;
+		val >>=3D 1;
+	}
+	return ((u8) i);
+}
+
+/* Initial limits */
+#define W83781D_INIT_IN_0		(vid =3D=3D 3500 ? 280 : vid / 10)
+#define W83781D_INIT_IN_1		(vid =3D=3D 3500 ? 280 : vid / 10)
+#define W83781D_INIT_IN_2		330
+#define W83781D_INIT_IN_3		(((500)   * 100) / 168)
+#define W83781D_INIT_IN_4		(((1200)  * 10) / 38)
+#define W83781D_INIT_IN_5		(((-1200) * -604) / 2100)
+#define W83781D_INIT_IN_6		(((-500)  * -604) / 909)
+#define W83781D_INIT_IN_7		(((500)   * 100) / 168)
+#define W83781D_INIT_IN_8		300
+/* Initial limits for 782d/783s negative voltages */
+/* Note level shift. Change min/max below if you change these. */
+#define W83782D_INIT_IN_5		((((-1200) + 1491) * 100)/514)
+#define W83782D_INIT_IN_6		((( (-500)  + 771) * 100)/314)
+
+#define W83781D_INIT_IN_PERCENTAGE	10
+#define W83781D_INIT_IN_MIN(val)	(val - val * W83781D_INIT_IN_PERCENTAGE /=
 100)
+#define W83781D_INIT_IN_MAX(val)	(val + val * W83781D_INIT_IN_PERCENTAGE /=
 100)
+
+#define W83781D_INIT_IN_MIN_0		W83781D_INIT_IN_MIN(W83781D_INIT_IN_0)
+#define W83781D_INIT_IN_MAX_0		W83781D_INIT_IN_MAX(W83781D_INIT_IN_0)
+#define W83781D_INIT_IN_MIN_1		W83781D_INIT_IN_MIN(W83781D_INIT_IN_1)
+#define W83781D_INIT_IN_MAX_1		W83781D_INIT_IN_MAX(W83781D_INIT_IN_1)
+#define W83781D_INIT_IN_MIN_2		W83781D_INIT_IN_MIN(W83781D_INIT_IN_2)
+#define W83781D_INIT_IN_MAX_2		W83781D_INIT_IN_MAX(W83781D_INIT_IN_2)
+#define W83781D_INIT_IN_MIN_3		W83781D_INIT_IN_MIN(W83781D_INIT_IN_3)
+#define W83781D_INIT_IN_MAX_3		W83781D_INIT_IN_MAX(W83781D_INIT_IN_3)
+#define W83781D_INIT_IN_MIN_4		W83781D_INIT_IN_MIN(W83781D_INIT_IN_4)
+#define W83781D_INIT_IN_MAX_4		W83781D_INIT_IN_MAX(W83781D_INIT_IN_4)
+#define W83781D_INIT_IN_MIN_5		W83781D_INIT_IN_MIN(W83781D_INIT_IN_5)
+#define W83781D_INIT_IN_MAX_5		W83781D_INIT_IN_MAX(W83781D_INIT_IN_5)
+#define W83781D_INIT_IN_MIN_6		W83781D_INIT_IN_MIN(W83781D_INIT_IN_6)
+#define W83781D_INIT_IN_MAX_6		W83781D_INIT_IN_MAX(W83781D_INIT_IN_6)
+#define W83781D_INIT_IN_MIN_7		W83781D_INIT_IN_MIN(W83781D_INIT_IN_7)
+#define W83781D_INIT_IN_MAX_7		W83781D_INIT_IN_MAX(W83781D_INIT_IN_7)
+#define W83781D_INIT_IN_MIN_8		W83781D_INIT_IN_MIN(W83781D_INIT_IN_8)
+#define W83781D_INIT_IN_MAX_8		W83781D_INIT_IN_MAX(W83781D_INIT_IN_8)
+
+/* Initial limits for 782d/783s negative voltages */
+/* These aren't direct multiples because of level shift */
+/* Beware going negative - check */
+#define W83782D_INIT_IN_MIN_5_TMP \
+	(((-1200 * (100 + W83781D_INIT_IN_PERCENTAGE)) + (1491 * 100))/514)
+#define W83782D_INIT_IN_MIN_5 \
+	((W83782D_INIT_IN_MIN_5_TMP > 0) ? W83782D_INIT_IN_MIN_5_TMP : 0)
+#define W83782D_INIT_IN_MAX_5 \
+	(((-1200 * (100 - W83781D_INIT_IN_PERCENTAGE)) + (1491 * 100))/514)
+#define W83782D_INIT_IN_MIN_6_TMP \
+	((( -500 * (100 + W83781D_INIT_IN_PERCENTAGE)) +  (771 * 100))/314)
+#define W83782D_INIT_IN_MIN_6 \
+	((W83782D_INIT_IN_MIN_6_TMP > 0) ? W83782D_INIT_IN_MIN_6_TMP : 0)
+#define W83782D_INIT_IN_MAX_6 \
+	((( -500 * (100 - W83781D_INIT_IN_PERCENTAGE)) +  (771 * 100))/314)
+
+#define W83781D_INIT_FAN_MIN_1		3000
+#define W83781D_INIT_FAN_MIN_2		3000
+#define W83781D_INIT_FAN_MIN_3		3000
+
+/* temp =3D value / 100 */
+#define W83781D_INIT_TEMP_OVER		6000
+#define W83781D_INIT_TEMP_HYST		12700	/* must be 127 for ALARM to work */
+#define W83781D_INIT_TEMP2_OVER		6000
+#define W83781D_INIT_TEMP2_HYST		5000
+#define W83781D_INIT_TEMP3_OVER		6000
+#define W83781D_INIT_TEMP3_HYST		5000
+
+/* There are some complications in a module like this. First off, W83781D =
chips
+   may be both present on the SMBus and the ISA bus, and we have to handle
+   those cases separately at some places. Second, there might be several
+   W83781D chips available (well, actually, that is probably never done; b=
ut
+   it is a clean illustration of how to handle a case like that). Finally,
+   a specific chip may be attached to *both* ISA and SMBus, and we would
+   not like to detect it double. Fortunately, in the case of the W83781D a=
t
+   least, a register tells us what SMBus address we are on, so that helps
+   a bit - except if there could be more than one SMBus. Groan. No solutio=
n
+   for this yet. */
+
+/* This module may seem overly long and complicated. In fact, it is not so
+   bad. Quite a lot of bookkeeping is done. A real driver can often cut
+   some corners. */
+
+/* For each registered W83781D, we need to keep some data in memory. That
+   data is pointed to by w83781d_list[NR]->data. The structure itself is
+   dynamically allocated, at the same time when a new w83781d client is
+   allocated. */
+struct w83781d_data {
+	struct semaphore lock;
+	enum chips type;
+
+	struct semaphore update_lock;
+	char valid;		/* !=3D0 if following fields are valid */
+	unsigned long last_updated;	/* In jiffies */
+
+	struct i2c_client *lm75;	/* for secondary I2C addresses */
+	/* pointer to array of 2 subclients */
+
+	u8 in[9];		/* Register value - 8 & 9 for 782D only */
+	u8 in_max[9];		/* Register value - 8 & 9 for 782D only */
+	u8 in_min[9];		/* Register value - 8 & 9 for 782D only */
+	u8 fan[3];		/* Register value */
+	u8 fan_min[3];		/* Register value */
+	u8 temp;
+	u8 temp_min;		/* Register value */
+	u8 temp_max;		/* Register value */
+	u16 temp_add[2];	/* Register value */
+	u16 temp_max_add[2];	/* Register value */
+	u16 temp_min_add[2];	/* Register value */
+	u8 fan_div[3];		/* Register encoding, shifted right */
+	u8 vid;			/* Register encoding, combined */
+	u32 alarms;		/* Register encoding, combined */
+	u32 beep_mask;		/* Register encoding, combined */
+	u8 beep_enable;		/* Boolean */
+	u8 pwm[4];		/* Register value */
+	u8 pwmenable[4];	/* Boolean */
+	u16 sens[3];		/* 782D/783S only.
+				   1 =3D pentium diode; 2 =3D 3904 diode;
+				   3000-5000 =3D thermistor beta.
+				   Default =3D 3435.=20
+				   Other Betas unimplemented */
+#ifdef W83781D_RT
+	u8 rt[3][32];		/* Register value */
+#endif
+	u8 vrm;
+};
+
+static int w83781d_attach_adapter(struct i2c_adapter *adapter);
+static int w83781d_detect(struct i2c_adapter *adapter, int address,
+			  unsigned short flags, int kind);
+static int w83781d_detach_client(struct i2c_client *client);
+
+static int w83781d_read_value(struct i2c_client *client, u16 register);
+static int w83781d_write_value(struct i2c_client *client, u16 register,
+			       u16 value);
+static void w83781d_update_client(struct i2c_client *client);
+static void w83781d_init_client(struct i2c_client *client);
+
+static inline u16 swap_bytes(u16 val)
+{
+	return (val >> 8) | (val << 8);
+}
+
+static struct i2c_driver w83781d_driver =3D {
+	.owner =3D THIS_MODULE,
+	.name =3D "w83781d",
+	.id =3D I2C_DRIVERID_W83781D,
+	.flags =3D I2C_DF_NOTIFY,
+	.attach_adapter =3D w83781d_attach_adapter,
+	.detach_client =3D w83781d_detach_client,
+};
+
+/* following are the sysfs callback functions */
+#define show_in_reg(reg) \
+static ssize_t show_##reg (struct device *dev, char *buf, int nr) \
+{ \
+	struct i2c_client *client =3D to_i2c_client(dev); \
+	struct w83781d_data *data =3D i2c_get_clientdata(client); \
+	 \
+	w83781d_update_client(client); \
+	 \
+	return sprintf(buf,"%ld\n", (long)IN_FROM_REG(data->reg[nr])); \
+}
+show_in_reg(in);
+show_in_reg(in_min);
+show_in_reg(in_max);
+
+#define store_in_reg(REG, reg) \
+static ssize_t store_in_##reg (struct device *dev, const char *buf, size_t=
 count, int nr) \
+{ \
+	struct i2c_client *client =3D to_i2c_client(dev); \
+	struct w83781d_data *data =3D i2c_get_clientdata(client); \
+	u32 val; \
+	 \
+	val =3D simple_strtoul(buf, NULL, 10); \
+	data->in_##reg[nr] =3D IN_TO_REG(val); \
+	w83781d_write_value(client, W83781D_REG_IN_##REG(nr), data->in_##reg[nr])=
; \
+	 \
+	return count; \
+}
+store_in_reg(MIN, min);
+store_in_reg(MAX, max);
+
+#define sysfs_in_offset(offset) \
+static ssize_t \
+show_regs_in_##offset (struct device *dev, char *buf) \
+{ \
+        return show_in(dev, buf, 0x##offset); \
+} \
+static DEVICE_ATTR(in_input##offset, S_IRUGO, show_regs_in_##offset, NULL)
+
+#define sysfs_in_reg_offset(reg, offset) \
+static ssize_t show_regs_in_##reg##offset (struct device *dev, char *buf) =
\
+{ \
+	return show_in_##reg (dev, buf, 0x##offset); \
+} \
+static ssize_t store_regs_in_##reg##offset (struct device *dev, const char=
 *buf, size_t count) \
+{ \
+	return store_in_##reg (dev, buf, count, 0x##offset); \
+} \
+static DEVICE_ATTR(in_##reg##offset, S_IRUGO| S_IWUSR, show_regs_in_##reg#=
#offset, store_regs_in_##reg##offset)
+
+#define sysfs_in_offsets(offset) \
+sysfs_in_offset(offset); \
+sysfs_in_reg_offset(min, offset); \
+sysfs_in_reg_offset(max, offset);
+
+sysfs_in_offsets(0);
+sysfs_in_offsets(1);
+sysfs_in_offsets(2);
+sysfs_in_offsets(3);
+sysfs_in_offsets(4);
+sysfs_in_offsets(5);
+sysfs_in_offsets(6);
+sysfs_in_offsets(7);
+sysfs_in_offsets(8);
+
+#define device_create_file_in(client, offset) \
+device_create_file(&client->dev, &dev_attr_in_input##offset); \
+device_create_file(&client->dev, &dev_attr_in_min##offset); \
+device_create_file(&client->dev, &dev_attr_in_max##offset);
+
+#define show_fan_reg(reg) \
+static ssize_t show_##reg (struct device *dev, char *buf, int nr) \
+{ \
+	struct i2c_client *client =3D to_i2c_client(dev); \
+	struct w83781d_data *data =3D i2c_get_clientdata(client); \
+	 \
+	w83781d_update_client(client); \
+	 \
+	return sprintf(buf,"%ld\n", \
+		FAN_FROM_REG(data->reg[nr-1], (long)DIV_FROM_REG(data->fan_div[nr-1])));=
 \
+}
+show_fan_reg(fan);
+show_fan_reg(fan_min);
+
+static ssize_t
+store_fan_min(struct device *dev, const char *buf, size_t count, int nr)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct w83781d_data *data =3D i2c_get_clientdata(client);
+	u32 val;
+
+	val =3D simple_strtoul(buf, NULL, 10);
+	data->fan_min[nr - 1] =3D
+	    FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr - 1]));
+	w83781d_write_value(client, W83781D_REG_FAN_MIN(nr),
+			    data->fan_min[nr - 1]);
+
+	return count;
+}
+
+#define sysfs_fan_offset(offset) \
+static ssize_t show_regs_fan_##offset (struct device *dev, char *buf) \
+{ \
+	return show_fan(dev, buf, 0x##offset); \
+} \
+static DEVICE_ATTR(fan_input##offset, S_IRUGO, show_regs_fan_##offset, NUL=
L)
+
+#define sysfs_fan_min_offset(offset) \
+static ssize_t show_regs_fan_min##offset (struct device *dev, char *buf) \
+{ \
+	return show_fan_min(dev, buf, 0x##offset); \
+} \
+static ssize_t store_regs_fan_min##offset (struct device *dev, const char =
*buf, size_t count) \
+{ \
+	return store_fan_min(dev, buf, count, 0x##offset); \
+} \
+static DEVICE_ATTR(fan_min##offset, S_IRUGO | S_IWUSR, show_regs_fan_min##=
offset, store_regs_fan_min##offset)
+
+sysfs_fan_offset(1);
+sysfs_fan_min_offset(1);
+sysfs_fan_offset(2);
+sysfs_fan_min_offset(2);
+sysfs_fan_offset(3);
+sysfs_fan_min_offset(3);
+
+#define device_create_file_fan(client, offset) \
+device_create_file(&client->dev, &dev_attr_fan_input##offset); \
+device_create_file(&client->dev, &dev_attr_fan_min##offset); \
+
+#define show_temp_reg(reg) \
+static ssize_t show_##reg (struct device *dev, char *buf, int nr) \
+{ \
+	struct i2c_client *client =3D to_i2c_client(dev); \
+	struct w83781d_data *data =3D i2c_get_clientdata(client); \
+	 \
+	w83781d_update_client(client); \
+	 \
+	if (nr >=3D 2) {	/* TEMP2 and TEMP3 */ \
+		if (data->type =3D=3D as99127f) { \
+			return sprintf(buf,"%ld\n", \
+				(long)AS99127_TEMP_ADD_FROM_REG(data->reg##_add[nr-2])); \
+		} else { \
+			return sprintf(buf,"%ld\n", \
+				(long)TEMP_ADD_FROM_REG(data->reg##_add[nr-2])); \
+		} \
+	} else {	/* TEMP1 */ \
+		return sprintf(buf,"%ld\n", (long)TEMP_FROM_REG(data->reg)); \
+	} \
+}
+show_temp_reg(temp);
+show_temp_reg(temp_min);
+show_temp_reg(temp_max);
+
+#define store_temp_reg(REG, reg) \
+static ssize_t store_temp_##reg (struct device *dev, const char *buf, size=
_t count, int nr) \
+{ \
+	struct i2c_client *client =3D to_i2c_client(dev); \
+	struct w83781d_data *data =3D i2c_get_clientdata(client); \
+	u32 val; \
+	 \
+	val =3D simple_strtoul(buf, NULL, 10); \
+	 \
+	if (nr >=3D 2) {	/* TEMP2 and TEMP3 */ \
+		if (data->type =3D=3D as99127f) \
+			data->temp_##reg##_add[nr-2] =3D AS99127_TEMP_ADD_TO_REG(val); \
+		else \
+			data->temp_##reg##_add[nr-2] =3D TEMP_ADD_TO_REG(val); \
+		 \
+		w83781d_write_value(client, W83781D_REG_TEMP_##REG(nr), \
+				data->temp_##reg##_add[nr-2]); \
+	} else {	/* TEMP1 */ \
+		data->temp_##reg =3D TEMP_TO_REG(val); \
+		w83781d_write_value(client, W83781D_REG_TEMP_##REG(nr), \
+			data->temp_##reg); \
+	} \
+	 \
+	return count; \
+}
+store_temp_reg(OVER, min);
+store_temp_reg(HYST, max);
+
+#define sysfs_temp_offset(offset) \
+static ssize_t \
+show_regs_temp_##offset (struct device *dev, char *buf) \
+{ \
+	return show_temp(dev, buf, 0x##offset); \
+} \
+static DEVICE_ATTR(temp_input##offset, S_IRUGO, show_regs_temp_##offset, N=
ULL)
+
+#define sysfs_temp_reg_offset(reg, offset) \
+static ssize_t show_regs_temp_##reg##offset (struct device *dev, char *buf=
) \
+{ \
+	return show_temp_##reg (dev, buf, 0x##offset); \
+} \
+static ssize_t store_regs_temp_##reg##offset (struct device *dev, const ch=
ar *buf, size_t count) \
+{ \
+	return store_temp_##reg (dev, buf, count, 0x##offset); \
+} \
+static DEVICE_ATTR(temp_##reg##offset, S_IRUGO| S_IWUSR, show_regs_temp_##=
reg##offset, store_regs_temp_##reg##offset)
+
+#define sysfs_temp_offsets(offset) \
+sysfs_temp_offset(offset); \
+sysfs_temp_reg_offset(min, offset); \
+sysfs_temp_reg_offset(max, offset);
+
+sysfs_temp_offsets(1);
+sysfs_temp_offsets(2);
+sysfs_temp_offsets(3);
+
+#define device_create_file_temp(client, offset) \
+device_create_file(&client->dev, &dev_attr_temp_input##offset); \
+device_create_file(&client->dev, &dev_attr_temp_max##offset); \
+device_create_file(&client->dev, &dev_attr_temp_min##offset);
+
+static ssize_t
+show_vid_reg(struct device *dev, char *buf)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct w83781d_data *data =3D i2c_get_clientdata(client);
+
+	w83781d_update_client(client);
+
+	return sprintf(buf, "%ld\n", (long) vid_from_reg(data->vid, data->vrm));
+}
+
+static
+DEVICE_ATTR(vid, S_IRUGO, show_vid_reg, NULL)
+#define device_create_file_vid(client) \
+device_create_file(&client->dev, &dev_attr_vid);
+static ssize_t
+show_vrm_reg(struct device *dev, char *buf)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct w83781d_data *data =3D i2c_get_clientdata(client);
+
+	w83781d_update_client(client);
+
+	return sprintf(buf, "%ld\n", (long) data->vrm);
+}
+
+static ssize_t
+store_vrm_reg(struct device *dev, const char *buf, size_t count)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct w83781d_data *data =3D i2c_get_clientdata(client);
+	u32 val;
+
+	val =3D simple_strtoul(buf, NULL, 10);
+	data->vrm =3D val;
+
+	return count;
+}
+
+static
+DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm_reg, store_vrm_reg)
+#define device_create_file_vrm(client) \
+device_create_file(&client->dev, &dev_attr_vrm);
+static ssize_t
+show_alarms_reg(struct device *dev, char *buf)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct w83781d_data *data =3D i2c_get_clientdata(client);
+
+	w83781d_update_client(client);
+
+	return sprintf(buf, "%ld\n", (long) ALARMS_FROM_REG(data->alarms));
+}
+
+static
+DEVICE_ATTR(alarms, S_IRUGO, show_alarms_reg, NULL)
+#define device_create_file_alarms(client) \
+device_create_file(&client->dev, &dev_attr_alarms);
+#define show_beep_reg(REG, reg) \
+static ssize_t show_beep_##reg (struct device *dev, char *buf) \
+{ \
+	struct i2c_client *client =3D to_i2c_client(dev); \
+	struct w83781d_data *data =3D i2c_get_clientdata(client); \
+	 \
+	w83781d_update_client(client); \
+	 \
+	return sprintf(buf,"%ld\n", (long)BEEP_##REG##_FROM_REG(data->beep_##reg)=
); \
+}
+show_beep_reg(ENABLE, enable);
+show_beep_reg(MASK, mask);
+
+#define BEEP_ENABLE			0	/* Store beep_enable */
+#define BEEP_MASK			1	/* Store beep_mask */
+
+static ssize_t
+store_beep_reg(struct device *dev, const char *buf, size_t count,
+	       int update_mask)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct w83781d_data *data =3D i2c_get_clientdata(client);
+	u32 val, val2;
+
+	val =3D simple_strtoul(buf, NULL, 10);
+
+	if (update_mask =3D=3D BEEP_MASK) {	/* We are storing beep_mask */
+		data->beep_mask =3D BEEP_MASK_TO_REG(val);
+		w83781d_write_value(client, W83781D_REG_BEEP_INTS1,
+				    data->beep_mask & 0xff);
+
+		if ((data->type !=3D w83781d) && (data->type !=3D as99127f)) {
+			w83781d_write_value(client, W83781D_REG_BEEP_INTS3,
+					    ((data->beep_mask) >> 16) & 0xff);
+		}
+
+		val2 =3D (data->beep_mask >> 8) & 0x7f;
+	} else {		/* We are storing beep_enable */
+		val2 =3D w83781d_read_value(client, W83781D_REG_BEEP_INTS2) & 0x7f;
+		data->beep_enable =3D BEEP_ENABLE_TO_REG(val);
+	}
+
+	w83781d_write_value(client, W83781D_REG_BEEP_INTS2,
+			    val2 | data->beep_enable << 7);
+
+	return count;
+}
+
+#define sysfs_beep(REG, reg) \
+static ssize_t show_regs_beep_##reg (struct device *dev, char *buf) \
+{ \
+	return show_beep_##reg(dev, buf); \
+} \
+static ssize_t store_regs_beep_##reg (struct device *dev, const char *buf,=
 size_t count) \
+{ \
+	return store_beep_reg(dev, buf, count, BEEP_##REG); \
+} \
+static DEVICE_ATTR(beep_##reg, S_IRUGO | S_IWUSR, show_regs_beep_##reg, st=
ore_regs_beep_##reg)
+
+sysfs_beep(ENABLE, enable);
+sysfs_beep(MASK, mask);
+
+#define device_create_file_beep(client) \
+device_create_file(&client->dev, &dev_attr_beep_enable); \
+device_create_file(&client->dev, &dev_attr_beep_mask);
+
+/* w83697hf only has two fans */
+static ssize_t
+show_fan_div_reg(struct device *dev, char *buf, int nr)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct w83781d_data *data =3D i2c_get_clientdata(client);
+
+	w83781d_update_client(client);
+
+	return sprintf(buf, "%ld\n",
+		       (long) DIV_FROM_REG(data->fan_div[nr - 1]));
+}
+
+/* w83697hf only has two fans */
+static ssize_t
+store_fan_div_reg(struct device *dev, const char *buf, size_t count, int n=
r)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct w83781d_data *data =3D i2c_get_clientdata(client);
+	u32 val, old, old2, old3;
+
+	val =3D simple_strtoul(buf, NULL, 10);
+	old =3D w83781d_read_value(client, W83781D_REG_VID_FANDIV);
+
+	data->fan_div[nr - 1] =3D DIV_TO_REG(val, data->type);
+
+	/* w83781d and as99127f don't have extended divisor bits */
+	if ((data->type !=3D w83781d) && data->type !=3D as99127f) {
+		old3 =3D w83781d_read_value(client, W83781D_REG_VBAT);
+	}
+	if (nr >=3D 3 && data->type !=3D w83697hf) {
+		old2 =3D w83781d_read_value(client, W83781D_REG_PIN);
+		old2 =3D (old2 & 0x3f) | ((data->fan_div[2] & 0x03) << 6);
+		w83781d_write_value(client, W83781D_REG_PIN, old2);
+
+		if ((data->type !=3D w83781d) && (data->type !=3D as99127f)) {
+			old3 =3D (old3 & 0x7f) | ((data->fan_div[2] & 0x04) << 5);
+		}
+	}
+	if (nr >=3D 2) {
+		old =3D (old & 0x3f) | ((data->fan_div[1] & 0x03) << 6);
+
+		if ((data->type !=3D w83781d) && (data->type !=3D as99127f)) {
+			old3 =3D (old3 & 0xbf) | ((data->fan_div[1] & 0x04) << 4);
+		}
+	}
+	if (nr >=3D 1) {
+		old =3D (old & 0xcf) | ((data->fan_div[0] & 0x03) << 4);
+		w83781d_write_value(client, W83781D_REG_VID_FANDIV, old);
+
+		if ((data->type !=3D w83781d) && (data->type !=3D as99127f)) {
+			old3 =3D (old3 & 0xdf) | ((data->fan_div[0] & 0x04) << 3);
+			w83781d_write_value(client, W83781D_REG_VBAT, old3);
+		}
+	}
+
+	return count;
+}
+
+#define sysfs_fan_div(offset) \
+static ssize_t show_regs_fan_div_##offset (struct device *dev, char *buf) =
\
+{ \
+	return show_fan_div_reg(dev, buf, offset); \
+} \
+static ssize_t store_regs_fan_div_##offset (struct device *dev, const char=
 *buf, size_t count) \
+{ \
+	return store_fan_div_reg(dev, buf, count, offset); \
+} \
+static DEVICE_ATTR(fan_div##offset, S_IRUGO | S_IWUSR, show_regs_fan_div_#=
#offset, store_regs_fan_div_##offset)
+
+sysfs_fan_div(1);
+sysfs_fan_div(2);
+sysfs_fan_div(3);
+
+#define device_create_file_fan_div(client, offset) \
+device_create_file(&client->dev, &dev_attr_fan_div##offset); \
+
+/* w83697hf only has two fans */
+static ssize_t
+show_pwm_reg(struct device *dev, char *buf, int nr)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct w83781d_data *data =3D i2c_get_clientdata(client);
+
+	w83781d_update_client(client);
+
+	return sprintf(buf, "%ld\n", (long) PWM_FROM_REG(data->pwm[nr - 1]));
+}
+
+/* w83697hf only has two fans */
+static ssize_t
+show_pwmenable_reg(struct device *dev, char *buf, int nr)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct w83781d_data *data =3D i2c_get_clientdata(client);
+
+	w83781d_update_client(client);
+
+	return sprintf(buf, "%ld\n", (long) data->pwmenable[nr - 1]);
+}
+
+static ssize_t
+store_pwm_reg(struct device *dev, const char *buf, size_t count, int nr)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct w83781d_data *data =3D i2c_get_clientdata(client);
+	u32 val;
+
+	val =3D simple_strtoul(buf, NULL, 10);
+
+	data->pwm[nr - 1] =3D PWM_TO_REG(val);
+	w83781d_write_value(client, W83781D_REG_PWM(nr), data->pwm[nr - 1]);
+
+	return count;
+}
+
+static ssize_t
+store_pwmenable_reg(struct device *dev, const char *buf, size_t count, int=
 nr)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct w83781d_data *data =3D i2c_get_clientdata(client);
+	u32 val, j, k;
+
+	val =3D simple_strtoul(buf, NULL, 10);
+
+	/* only PWM2 can be enabled/disabled */
+	if (nr =3D=3D 2) {
+		j =3D w83781d_read_value(client, W83781D_REG_PWMCLK12);
+		k =3D w83781d_read_value(client, W83781D_REG_BEEP_CONFIG);
+
+		if (val > 0) {
+			if (!(j & 0x08))
+				w83781d_write_value(client,
+						    W83781D_REG_PWMCLK12,
+						    j | 0x08);
+			if (k & 0x10)
+				w83781d_write_value(client,
+						    W83781D_REG_BEEP_CONFIG,
+						    k & 0xef);
+
+			data->pwmenable[1] =3D 1;
+		} else {
+			if (j & 0x08)
+				w83781d_write_value(client,
+						    W83781D_REG_PWMCLK12,
+						    j & 0xf7);
+			if (!(k & 0x10))
+				w83781d_write_value(client,
+						    W83781D_REG_BEEP_CONFIG,
+						    j | 0x10);
+
+			data->pwmenable[1] =3D 0;
+		}
+	}
+
+	return count;
+}
+
+#define sysfs_pwm(offset) \
+static ssize_t show_regs_pwm_##offset (struct device *dev, char *buf) \
+{ \
+	return show_pwm_reg(dev, buf, offset); \
+} \
+static ssize_t store_regs_pwm_##offset (struct device *dev, const char *bu=
f, size_t count) \
+{ \
+	return store_pwm_reg(dev, buf, count, offset); \
+} \
+static DEVICE_ATTR(pwm##offset, S_IRUGO | S_IWUSR, show_regs_pwm_##offset,=
 store_regs_pwm_##offset)
+
+#define sysfs_pwmenable(offset) \
+static ssize_t show_regs_pwmenable_##offset (struct device *dev, char *buf=
) \
+{ \
+	return show_pwmenable_reg(dev, buf, offset); \
+} \
+static ssize_t store_regs_pwmenable_##offset (struct device *dev, const ch=
ar *buf, size_t count) \
+{ \
+	return store_pwmenable_reg(dev, buf, count, offset); \
+} \
+static DEVICE_ATTR(pwm_enable##offset, S_IRUGO | S_IWUSR, show_regs_pwmena=
ble_##offset, store_regs_pwmenable_##offset)
+
+sysfs_pwm(1);
+sysfs_pwm(2);
+sysfs_pwmenable(2);		/* only PWM2 can be enabled/disabled */
+sysfs_pwm(3);
+sysfs_pwm(4);
+
+#define device_create_file_pwm(client, offset) \
+device_create_file(&client->dev, &dev_attr_pwm##offset); \
+
+#define device_create_file_pwmenable(client, offset) \
+device_create_file(&client->dev, &dev_attr_pwm_enable##offset); \
+
+static ssize_t
+show_sensor_reg(struct device *dev, char *buf, int nr)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct w83781d_data *data =3D i2c_get_clientdata(client);
+
+	w83781d_update_client(client);
+
+	return sprintf(buf, "%ld\n", (long) data->sens[nr - 1]);
+}
+
+static ssize_t
+store_sensor_reg(struct device *dev, const char *buf, size_t count, int nr=
)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct w83781d_data *data =3D i2c_get_clientdata(client);
+	u32 val, tmp;
+
+	val =3D simple_strtoul(buf, NULL, 10);
+
+	switch (val) {
+	case 1:		/* PII/Celeron diode */
+		tmp =3D w83781d_read_value(client, W83781D_REG_SCFG1);
+		w83781d_write_value(client, W83781D_REG_SCFG1,
+				    tmp | BIT_SCFG1[nr - 1]);
+		tmp =3D w83781d_read_value(client, W83781D_REG_SCFG2);
+		w83781d_write_value(client, W83781D_REG_SCFG2,
+				    tmp | BIT_SCFG2[nr - 1]);
+		data->sens[nr - 1] =3D val;
+		break;
+	case 2:		/* 3904 */
+		tmp =3D w83781d_read_value(client, W83781D_REG_SCFG1);
+		w83781d_write_value(client, W83781D_REG_SCFG1,
+				    tmp | BIT_SCFG1[nr - 1]);
+		tmp =3D w83781d_read_value(client, W83781D_REG_SCFG2);
+		w83781d_write_value(client, W83781D_REG_SCFG2,
+				    tmp & ~BIT_SCFG2[nr - 1]);
+		data->sens[nr - 1] =3D val;
+		break;
+	case W83781D_DEFAULT_BETA:	/* thermistor */
+		tmp =3D w83781d_read_value(client, W83781D_REG_SCFG1);
+		w83781d_write_value(client, W83781D_REG_SCFG1,
+				    tmp & ~BIT_SCFG1[nr - 1]);
+		data->sens[nr - 1] =3D val;
+		break;
+	default:
+		dev_err(&client->dev,
+		       "Invalid sensor type %ld; must be 1, 2, or %d\n",
+		       (long) val, W83781D_DEFAULT_BETA);
+		break;
+	}
+
+	return count;
+}
+
+#define sysfs_sensor(offset) \
+static ssize_t show_regs_sensor_##offset (struct device *dev, char *buf) \
+{ \
+    return show_sensor_reg(dev, buf, offset); \
+} \
+static ssize_t store_regs_sensor_##offset (struct device *dev, const char =
*buf, size_t count) \
+{ \
+    return store_sensor_reg(dev, buf, count, offset); \
+} \
+static DEVICE_ATTR(sensor##offset, S_IRUGO | S_IWUSR, show_regs_sensor_##o=
ffset, store_regs_sensor_##offset)
+
+sysfs_sensor(1);
+sysfs_sensor(2);
+sysfs_sensor(3);
+
+#define device_create_file_sensor(client, offset) \
+device_create_file(&client->dev, &dev_attr_sensor##offset); \
+
+#ifdef W83781D_RT
+static ssize_t
+show_rt_reg(struct device *dev, char *buf, int nr)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct w83781d_data *data =3D i2c_get_clientdata(client);
+	int i, j =3D 0;
+
+	w83781d_update_client(client);
+
+	for (i =3D 0; i < 32; i++) {
+		if (i > 0)
+			j +=3D sprintf(buf, " %ld", (long) data->rt[nr - 1][i]);
+		else
+			j +=3D sprintf(buf, "%ld", (long) data->rt[nr - 1][i]);
+	}
+	j +=3D sprintf(buf, "\n");
+
+	return j;
+}
+
+static ssize_t
+store_rt_reg(struct device *dev, const char *buf, size_t count, int nr)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct w83781d_data *data =3D i2c_get_clientdata(client);
+	u32 val, i;
+
+	for (i =3D 0; i < count; i++) {
+		val =3D simple_strtoul(buf + count, NULL, 10);
+
+		/* fixme: no bounds checking 0-255 */
+		data->rt[nr - 1][i] =3D val & 0xff;
+		w83781d_write_value(client, W83781D_REG_RT_IDX, i);
+		w83781d_write_value(client, W83781D_REG_RT_VAL,
+				    data->rt[nr - 1][i]);
+	}
+
+	return count;
+}
+
+#define sysfs_rt(offset) \
+static ssize_t show_regs_rt_##offset (struct device *dev, char *buf) \
+{ \
+	return show_rt_reg(dev, buf, offset); \
+} \
+static ssize_t store_regs_rt_##offset (struct device *dev, const char *buf=
, size_t count) \
+{ \
+    return store_rt_reg(dev, buf, count, offset); \
+} \
+static DEVICE_ATTR(rt##offset, S_IRUGO | S_IWUSR, show_regs_rt_##offset, s=
tore_regs_rt_##offset)
+
+sysfs_rt(1);
+sysfs_rt(2);
+sysfs_rt(3);
+
+#define device_create_file_rt(client, offset) \
+device_create_file(&client->dev, &dev_attr_rt##offset); \
+
+#endif				/* ifdef W83781D_RT */
+
+/* This function is called when:
+     * w83781d_driver is inserted (when this module is loaded), for each
+       available adapter
+     * when a new adapter is inserted (and w83781d_driver is still present=
) */
+static int
+w83781d_attach_adapter(struct i2c_adapter *adapter)
+{
+	return i2c_detect(adapter, &addr_data, w83781d_detect);
+}
+
+static int
+w83781d_detect(struct i2c_adapter *adapter, int address,
+	       unsigned short flags, int kind)
+{
+	int i =3D 0, val1 =3D 0, val2, id;
+	struct i2c_client *new_client;
+	struct w83781d_data *data;
+	int err =3D 0;
+	const char *type_name =3D "";
+	const char *client_name =3D "";
+	int is_isa =3D i2c_is_isa_adapter(adapter);
+	enum vendor { winbond, asus } vendid;
+
+	if (!is_isa
+	    && !i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		goto ERROR0;
+
+	if (is_isa) {
+		if (!request_region(address, W83781D_EXTENT, "w83781d"))
+			goto ERROR0;
+		release_region(address, W83781D_EXTENT);
+	}
+
+	/* Probe whether there is anything available on this address. Already
+	   done for SMBus clients */
+	if (kind < 0) {
+		if (is_isa) {
+
+#define REALLY_SLOW_IO
+			/* We need the timeouts for at least some LM78-like chips. But only
+			   if we read 'undefined' registers. */
+			i =3D inb_p(address + 1);
+			if (inb_p(address + 2) !=3D i)
+				goto ERROR0;
+			if (inb_p(address + 3) !=3D i)
+				goto ERROR0;
+			if (inb_p(address + 7) !=3D i)
+				goto ERROR0;
+#undef REALLY_SLOW_IO
+
+			/* Let's just hope nothing breaks here */
+			i =3D inb_p(address + 5) & 0x7f;
+			outb_p(~i & 0x7f, address + 5);
+			if ((inb_p(address + 5) & 0x7f) !=3D (~i & 0x7f)) {
+				outb_p(i, address + 5);
+				return 0;
+			}
+		}
+	}
+
+	/* OK. For now, we presume we have a valid client. We now create the
+	   client structure, even though we cannot fill it completely yet.
+	   But it allows us to access w83781d_{read,write}_value. */
+
+	if (!(new_client =3D kmalloc(sizeof (struct i2c_client) +
+				   sizeof (struct w83781d_data), GFP_KERNEL))) {
+		err =3D -ENOMEM;
+		goto ERROR0;
+	}
+
+	memset(new_client, 0x00, sizeof (struct i2c_client) +
+	       sizeof (struct w83781d_data));
+
+	data =3D (struct w83781d_data *) (new_client + 1);
+	i2c_set_clientdata(new_client, data);
+	new_client->addr =3D address;
+	init_MUTEX(&data->lock);
+	new_client->adapter =3D adapter;
+	new_client->driver =3D &w83781d_driver;
+	new_client->flags =3D 0;
+
+	/* Now, we do the remaining detection. */
+
+	/* The w8378?d may be stuck in some other bank than bank 0. This may
+	   make reading other information impossible. Specify a force=3D... or
+	   force_*=3D... parameter, and the Winbond will be reset to the right
+	   bank. */
+	if (kind < 0) {
+		if (w83781d_read_value(new_client, W83781D_REG_CONFIG) & 0x80)
+			goto ERROR1;
+		val1 =3D w83781d_read_value(new_client, W83781D_REG_BANK);
+		val2 =3D w83781d_read_value(new_client, W83781D_REG_CHIPMAN);
+		/* Check for Winbond or Asus ID if in bank 0 */
+		if ((!(val1 & 0x07)) &&
+		    (((!(val1 & 0x80)) && (val2 !=3D 0xa3) && (val2 !=3D 0xc3)
+		      && (val2 !=3D 0x94))
+		     || ((val1 & 0x80) && (val2 !=3D 0x5c) && (val2 !=3D 0x12)
+			 && (val2 !=3D 0x06))))
+			goto ERROR1;
+		/* If Winbond SMBus, check address at 0x48. Asus doesn't support */
+		if ((!is_isa) && (((!(val1 & 0x80)) && (val2 =3D=3D 0xa3)) ||
+				  ((val1 & 0x80) && (val2 =3D=3D 0x5c)))) {
+			if (w83781d_read_value
+			    (new_client, W83781D_REG_I2C_ADDR) !=3D address)
+				goto ERROR1;
+		}
+	}
+
+	/* We have either had a force parameter, or we have already detected the
+	   Winbond. Put it now into bank 0 and Vendor ID High Byte */
+	w83781d_write_value(new_client, W83781D_REG_BANK,
+			    (w83781d_read_value(new_client,
+						W83781D_REG_BANK) & 0x78) |
+			    0x80);
+
+	/* Determine the chip type. */
+	if (kind <=3D 0) {
+		/* get vendor ID */
+		val2 =3D w83781d_read_value(new_client, W83781D_REG_CHIPMAN);
+		if (val2 =3D=3D 0x5c)
+			vendid =3D winbond;
+		else if ((val2 =3D=3D 0x12) || (val2 =3D=3D 0x06))
+			vendid =3D asus;
+		else
+			goto ERROR1;
+		/* mask off lower bit, not reliable */
+		val1 =3D
+		    w83781d_read_value(new_client, W83781D_REG_WCHIPID) & 0xfe;
+		if (val1 =3D=3D 0x10 && vendid =3D=3D winbond)
+			kind =3D w83781d;
+		else if (val1 =3D=3D 0x30 && vendid =3D=3D winbond)
+			kind =3D w83782d;
+		else if (val1 =3D=3D 0x40 && vendid =3D=3D winbond && !is_isa)
+			kind =3D w83783s;
+		else if (val1 =3D=3D 0x20 && vendid =3D=3D winbond)
+			kind =3D w83627hf;
+		else if (val1 =3D=3D 0x30 && vendid =3D=3D asus && !is_isa)
+			kind =3D as99127f;
+		else if (val1 =3D=3D 0x60 && vendid =3D=3D winbond && is_isa)
+			kind =3D w83697hf;
+		else {
+			if (kind =3D=3D 0)
+				dev_warn(&new_client->dev,
+				       "Ignoring 'force' parameter for unknown chip at"
+				       "adapter %d, address 0x%02x\n",
+				       i2c_adapter_id(adapter), address);
+			goto ERROR1;
+		}
+	}
+
+	if (kind =3D=3D w83781d) {
+		type_name =3D "w83781d";
+		client_name =3D "W83781D chip";
+	} else if (kind =3D=3D w83782d) {
+		type_name =3D "w83782d";
+		client_name =3D "W83782D chip";
+	} else if (kind =3D=3D w83783s) {
+		type_name =3D "w83783s";
+		client_name =3D "W83783S chip";
+	} else if (kind =3D=3D w83627hf) {
+		type_name =3D "w83627hf";
+		client_name =3D "W83627HF chip";
+	} else if (kind =3D=3D as99127f) {
+		type_name =3D "as99127f";
+		client_name =3D "AS99127F chip";
+	} else if (kind =3D=3D w83697hf) {
+		type_name =3D "w83697hf";
+		client_name =3D "W83697HF chip";
+	} else {
+		dev_err(&new_client->dev, "Internal error: unknown kind (%d)?!?", kind);
+		goto ERROR1;
+	}
+
+	/* Reserve the ISA region */
+	if (is_isa)
+		request_region(address, W83781D_EXTENT, type_name);
+
+	/* Fill in the remaining client fields and put it into the global list */
+	strncpy(new_client->dev.name, client_name, DEVICE_NAME_SIZE);
+	data->type =3D kind;
+
+	data->valid =3D 0;
+	init_MUTEX(&data->update_lock);
+
+	/* Tell the I2C layer a new client has arrived */
+	if ((err =3D i2c_attach_client(new_client)))
+		goto ERROR3;
+
+	/* attach secondary i2c lm75-like clients */
+	if (!is_isa) {
+		if (!(data->lm75 =3D kmalloc(2 * sizeof (struct i2c_client),
+					   GFP_KERNEL))) {
+			err =3D -ENOMEM;
+			goto ERROR4;
+		}
+
+		memset(data->lm75, 0x00, 2 * sizeof (struct i2c_client));
+
+		id =3D i2c_adapter_id(adapter);
+		if (force_subclients[0] =3D=3D id && force_subclients[1] =3D=3D address)=
 {
+			for (i =3D 2; i <=3D 3; i++) {
+				if (force_subclients[i] < 0x48 ||
+				    force_subclients[i] > 0x4f) {
+					dev_err(&new_client->dev,
+					       "Invalid subclient address %d; must be 0x48-0x4f\n",
+					       force_subclients[i]);
+					goto ERROR5;
+				}
+			}
+			w83781d_write_value(new_client,
+					    W83781D_REG_I2C_SUBADDR,
+					    (force_subclients[2] & 0x07) |
+					    ((force_subclients[3] & 0x07) <<
+					     4));
+			data->lm75[0].addr =3D force_subclients[2];
+		} else {
+			val1 =3D w83781d_read_value(new_client,
+						  W83781D_REG_I2C_SUBADDR);
+			data->lm75[0].addr =3D 0x48 + (val1 & 0x07);
+		}
+		if (kind !=3D w83783s) {
+			if (force_subclients[0] =3D=3D id &&
+			    force_subclients[1] =3D=3D address) {
+				data->lm75[1].addr =3D force_subclients[3];
+			} else {
+				data->lm75[1].addr =3D
+				    0x48 + ((val1 >> 4) & 0x07);
+			}
+			if (data->lm75[0].addr =3D=3D data->lm75[1].addr) {
+				dev_err(&new_client->dev,
+				       "Duplicate addresses 0x%x for subclients.\n",
+				       data->lm75[0].addr);
+				goto ERROR5;
+			}
+		}
+		if (kind =3D=3D w83781d)
+			client_name =3D "W83781D subclient";
+		else if (kind =3D=3D w83782d)
+			client_name =3D "W83782D subclient";
+		else if (kind =3D=3D w83783s)
+			client_name =3D "W83783S subclient";
+		else if (kind =3D=3D w83627hf)
+			client_name =3D "W83627HF subclient";
+		else if (kind =3D=3D as99127f)
+			client_name =3D "AS99127F subclient";
+
+		for (i =3D 0; i <=3D 1; i++) {
+			i2c_set_clientdata(&data->lm75[i], NULL);	/* store all data in w83781d =
*/
+			data->lm75[i].adapter =3D adapter;
+			data->lm75[i].driver =3D &w83781d_driver;
+			data->lm75[i].flags =3D 0;
+			strncpy(data->lm75[i].dev.name, client_name,
+				DEVICE_NAME_SIZE);
+			if (kind =3D=3D w83783s)
+				break;
+		}
+	} else {
+		data->lm75 =3D NULL;
+	}
+
+	device_create_file_in(new_client, 0);
+	if (kind !=3D w83783s && kind !=3D w83697hf)
+		device_create_file_in(new_client, 1);
+	device_create_file_in(new_client, 2);
+	device_create_file_in(new_client, 3);
+	device_create_file_in(new_client, 4);
+	device_create_file_in(new_client, 5);
+	device_create_file_in(new_client, 6);
+	if (kind !=3D as99127f && kind !=3D w83781d && kind !=3D w83783s) {
+		device_create_file_in(new_client, 7);
+		device_create_file_in(new_client, 8);
+	}
+
+	device_create_file_fan(new_client, 1);
+	device_create_file_fan(new_client, 2);
+	if (kind !=3D w83697hf)
+		device_create_file_fan(new_client, 3);
+
+	device_create_file_temp(new_client, 1);
+	device_create_file_temp(new_client, 2);
+	if (kind !=3D w83783s && kind !=3D w83697hf)
+		device_create_file_temp(new_client, 3);
+
+	if (kind !=3D w83697hf)
+		device_create_file_vid(new_client);
+
+	if (kind !=3D w83697hf)
+		device_create_file_vrm(new_client);
+
+	device_create_file_fan_div(new_client, 1);
+	device_create_file_fan_div(new_client, 2);
+	if (kind !=3D w83697hf)
+		device_create_file_fan_div(new_client, 3);
+
+	device_create_file_alarms(new_client);
+
+	device_create_file_beep(new_client);
+
+	if (kind !=3D w83781d) {
+		device_create_file_pwm(new_client, 1);
+		device_create_file_pwm(new_client, 2);
+		device_create_file_pwmenable(new_client, 2);
+	}
+	if (kind =3D=3D w83782d && !is_isa) {
+		device_create_file_pwm(new_client, 3);
+		device_create_file_pwm(new_client, 4);
+	}
+
+	if (kind !=3D as99127f && kind !=3D w83781d) {
+		device_create_file_sensor(new_client, 1);
+		device_create_file_sensor(new_client, 2);
+		if (kind !=3D w83783s && kind !=3D w83697hf)
+			device_create_file_sensor(new_client, 3);
+	}
+#ifdef W83781D_RT
+	if (kind =3D=3D w83781d) {
+		device_create_file_rt(new_client, 1);
+		device_create_file_rt(new_client, 2);
+		device_create_file_rt(new_client, 3);
+	}
+#endif
+
+	/* Initialize the chip */
+	w83781d_init_client(new_client);
+	return 0;
+
+/* OK, this is not exactly good programming practice, usually. But it is
+   very code-efficient in this case. */
+
+      ERROR5:
+	if (!is_isa) {
+		i2c_detach_client(&data->lm75[0]);
+		if (data->type !=3D w83783s)
+			i2c_detach_client(&data->lm75[1]);
+		kfree(data->lm75);
+	}
+      ERROR4:
+	i2c_detach_client(new_client);
+      ERROR3:
+	if (is_isa)
+		release_region(address, W83781D_EXTENT);
+      ERROR1:
+	kfree(new_client);
+      ERROR0:
+	return err;
+}
+
+static int
+w83781d_detach_client(struct i2c_client *client)
+{
+	struct w83781d_data *data =3D i2c_get_clientdata(client);
+	int err;
+
+	if ((err =3D i2c_detach_client(client))) {
+		dev_err(&client->dev,
+		       "Client deregistration failed, client not detached.\n");
+		return err;
+	}
+
+	if (i2c_is_isa_client(client)) {
+		release_region(client->addr, W83781D_EXTENT);
+	} else {
+		i2c_detach_client(&data->lm75[0]);
+		if (data->type !=3D w83783s)
+			i2c_detach_client(&data->lm75[1]);
+		kfree(data->lm75);
+	}
+	kfree(client);
+
+	return 0;
+}
+
+/* The SMBus locks itself, usually, but nothing may access the Winbond bet=
ween
+   bank switches. ISA access must always be locked explicitly!=20
+   We ignore the W83781D BUSY flag at this moment - it could lead to deadl=
ocks,
+   would slow down the W83781D access and should not be necessary.=20
+   There are some ugly typecasts here, but the good news is - they should
+   nowhere else be necessary! */
+static int
+w83781d_read_value(struct i2c_client *client, u16 reg)
+{
+	struct w83781d_data *data =3D i2c_get_clientdata(client);
+	int res, word_sized, bank;
+	struct i2c_client *cl;
+
+	down(&data->lock);
+	if (i2c_is_isa_client(client)) {
+		word_sized =3D (((reg & 0xff00) =3D=3D 0x100)
+			      || ((reg & 0xff00) =3D=3D 0x200))
+		    && (((reg & 0x00ff) =3D=3D 0x50)
+			|| ((reg & 0x00ff) =3D=3D 0x53)
+			|| ((reg & 0x00ff) =3D=3D 0x55));
+		if (reg & 0xff00) {
+			outb_p(W83781D_REG_BANK,
+			       client->addr + W83781D_ADDR_REG_OFFSET);
+			outb_p(reg >> 8,
+			       client->addr + W83781D_DATA_REG_OFFSET);
+		}
+		outb_p(reg & 0xff, client->addr + W83781D_ADDR_REG_OFFSET);
+		res =3D inb_p(client->addr + W83781D_DATA_REG_OFFSET);
+		if (word_sized) {
+			outb_p((reg & 0xff) + 1,
+			       client->addr + W83781D_ADDR_REG_OFFSET);
+			res =3D
+			    (res << 8) + inb_p(client->addr +
+					       W83781D_DATA_REG_OFFSET);
+		}
+		if (reg & 0xff00) {
+			outb_p(W83781D_REG_BANK,
+			       client->addr + W83781D_ADDR_REG_OFFSET);
+			outb_p(0, client->addr + W83781D_DATA_REG_OFFSET);
+		}
+	} else {
+		bank =3D (reg >> 8) & 0x0f;
+		if (bank > 2)
+			/* switch banks */
+			i2c_smbus_write_byte_data(client, W83781D_REG_BANK,
+						  bank);
+		if (bank =3D=3D 0 || bank > 2) {
+			res =3D i2c_smbus_read_byte_data(client, reg & 0xff);
+		} else {
+			/* switch to subclient */
+			cl =3D &data->lm75[bank - 1];
+			/* convert from ISA to LM75 I2C addresses */
+			switch (reg & 0xff) {
+			case 0x50:	/* TEMP */
+				res =3D
+				    swap_bytes(i2c_smbus_read_word_data(cl, 0));
+				break;
+			case 0x52:	/* CONFIG */
+				res =3D i2c_smbus_read_byte_data(cl, 1);
+				break;
+			case 0x53:	/* HYST */
+				res =3D
+				    swap_bytes(i2c_smbus_read_word_data(cl, 2));
+				break;
+			case 0x55:	/* OVER */
+			default:
+				res =3D
+				    swap_bytes(i2c_smbus_read_word_data(cl, 3));
+				break;
+			}
+		}
+		if (bank > 2)
+			i2c_smbus_write_byte_data(client, W83781D_REG_BANK, 0);
+	}
+	up(&data->lock);
+	return res;
+}
+
+static int
+w83781d_write_value(struct i2c_client *client, u16 reg, u16 value)
+{
+	struct w83781d_data *data =3D i2c_get_clientdata(client);
+	int word_sized, bank;
+	struct i2c_client *cl;
+
+	down(&data->lock);
+	if (i2c_is_isa_client(client)) {
+		word_sized =3D (((reg & 0xff00) =3D=3D 0x100)
+			      || ((reg & 0xff00) =3D=3D 0x200))
+		    && (((reg & 0x00ff) =3D=3D 0x53)
+			|| ((reg & 0x00ff) =3D=3D 0x55));
+		if (reg & 0xff00) {
+			outb_p(W83781D_REG_BANK,
+			       client->addr + W83781D_ADDR_REG_OFFSET);
+			outb_p(reg >> 8,
+			       client->addr + W83781D_DATA_REG_OFFSET);
+		}
+		outb_p(reg & 0xff, client->addr + W83781D_ADDR_REG_OFFSET);
+		if (word_sized) {
+			outb_p(value >> 8,
+			       client->addr + W83781D_DATA_REG_OFFSET);
+			outb_p((reg & 0xff) + 1,
+			       client->addr + W83781D_ADDR_REG_OFFSET);
+		}
+		outb_p(value & 0xff, client->addr + W83781D_DATA_REG_OFFSET);
+		if (reg & 0xff00) {
+			outb_p(W83781D_REG_BANK,
+			       client->addr + W83781D_ADDR_REG_OFFSET);
+			outb_p(0, client->addr + W83781D_DATA_REG_OFFSET);
+		}
+	} else {
+		bank =3D (reg >> 8) & 0x0f;
+		if (bank > 2)
+			/* switch banks */
+			i2c_smbus_write_byte_data(client, W83781D_REG_BANK,
+						  bank);
+		if (bank =3D=3D 0 || bank > 2) {
+			i2c_smbus_write_byte_data(client, reg & 0xff,
+						  value & 0xff);
+		} else {
+			/* switch to subclient */
+			cl =3D &data->lm75[bank - 1];
+			/* convert from ISA to LM75 I2C addresses */
+			switch (reg & 0xff) {
+			case 0x52:	/* CONFIG */
+				i2c_smbus_write_byte_data(cl, 1, value & 0xff);
+				break;
+			case 0x53:	/* HYST */
+				i2c_smbus_write_word_data(cl, 2,
+							  swap_bytes(value));
+				break;
+			case 0x55:	/* OVER */
+				i2c_smbus_write_word_data(cl, 3,
+							  swap_bytes(value));
+				break;
+			}
+		}
+		if (bank > 2)
+			i2c_smbus_write_byte_data(client, W83781D_REG_BANK, 0);
+	}
+	up(&data->lock);
+	return 0;
+}
+
+/* Called when we have found a new W83781D. It should set limits, etc. */
+static void
+w83781d_init_client(struct i2c_client *client)
+{
+	struct w83781d_data *data =3D i2c_get_clientdata(client);
+	int vid =3D 0, i, p;
+	int type =3D data->type;
+	u8 tmp;
+
+	if (init && type !=3D as99127f) {	/* this resets registers we don't have
+					   documentation for on the as99127f */
+		/* save these registers */
+		i =3D w83781d_read_value(client, W83781D_REG_BEEP_CONFIG);
+		p =3D w83781d_read_value(client, W83781D_REG_PWMCLK12);
+		/* Reset all except Watchdog values and last conversion values
+		   This sets fan-divs to 2, among others */
+		w83781d_write_value(client, W83781D_REG_CONFIG, 0x80);
+		/* Restore the registers and disable power-on abnormal beep.
+		   This saves FAN 1/2/3 input/output values set by BIOS. */
+		w83781d_write_value(client, W83781D_REG_BEEP_CONFIG, i | 0x80);
+		w83781d_write_value(client, W83781D_REG_PWMCLK12, p);
+		/* Disable master beep-enable (reset turns it on).
+		   Individual beep_mask should be reset to off but for some reason
+		   disabling this bit helps some people not get beeped */
+		w83781d_write_value(client, W83781D_REG_BEEP_INTS2, 0);
+	}
+
+	if (type !=3D w83697hf) {
+		vid =3D w83781d_read_value(client, W83781D_REG_VID_FANDIV) & 0x0f;
+		vid |=3D
+		    (w83781d_read_value(client, W83781D_REG_CHIPID) & 0x01) <<
+		    4;
+		data->vrm =3D DEFAULT_VRM;
+		vid =3D vid_from_reg(vid, data->vrm);
+	}
+
+	if ((type !=3D w83781d) && (type !=3D as99127f)) {
+		tmp =3D w83781d_read_value(client, W83781D_REG_SCFG1);
+		for (i =3D 1; i <=3D 3; i++) {
+			if (!(tmp & BIT_SCFG1[i - 1])) {
+				data->sens[i - 1] =3D W83781D_DEFAULT_BETA;
+			} else {
+				if (w83781d_read_value
+				    (client,
+				     W83781D_REG_SCFG2) & BIT_SCFG2[i - 1])
+					data->sens[i - 1] =3D 1;
+				else
+					data->sens[i - 1] =3D 2;
+			}
+			if ((type =3D=3D w83783s || type =3D=3D w83697hf) && (i =3D=3D 2))
+				break;
+		}
+	}
+#ifdef W83781D_RT
+/*
+   Fill up the RT Tables.
+   We assume that they are 32 bytes long, in order for temp 1-3.
+   Data sheet documentation is sparse.
+   We also assume that it is only for the 781D although I suspect
+   that the others support it as well....
+*/
+
+	if (init && type =3D=3D w83781d) {
+		u16 k =3D 0;
+/*
+    Auto-indexing doesn't seem to work...
+    w83781d_write_value(client,W83781D_REG_RT_IDX,0);
+*/
+		for (i =3D 0; i < 3; i++) {
+			int j;
+			for (j =3D 0; j < 32; j++) {
+				w83781d_write_value(client,
+						    W83781D_REG_RT_IDX, k++);
+				data->rt[i][j] =3D
+				    w83781d_read_value(client,
+						       W83781D_REG_RT_VAL);
+			}
+		}
+	}
+#endif				/* W83781D_RT */
+
+	if (init) {
+		w83781d_write_value(client, W83781D_REG_IN_MIN(0),
+				    IN_TO_REG(W83781D_INIT_IN_MIN_0));
+		w83781d_write_value(client, W83781D_REG_IN_MAX(0),
+				    IN_TO_REG(W83781D_INIT_IN_MAX_0));
+		if (type !=3D w83783s && type !=3D w83697hf) {
+			w83781d_write_value(client, W83781D_REG_IN_MIN(1),
+					    IN_TO_REG(W83781D_INIT_IN_MIN_1));
+			w83781d_write_value(client, W83781D_REG_IN_MAX(1),
+					    IN_TO_REG(W83781D_INIT_IN_MAX_1));
+		}
+
+		w83781d_write_value(client, W83781D_REG_IN_MIN(2),
+				    IN_TO_REG(W83781D_INIT_IN_MIN_2));
+		w83781d_write_value(client, W83781D_REG_IN_MAX(2),
+				    IN_TO_REG(W83781D_INIT_IN_MAX_2));
+		w83781d_write_value(client, W83781D_REG_IN_MIN(3),
+				    IN_TO_REG(W83781D_INIT_IN_MIN_3));
+		w83781d_write_value(client, W83781D_REG_IN_MAX(3),
+				    IN_TO_REG(W83781D_INIT_IN_MAX_3));
+		w83781d_write_value(client, W83781D_REG_IN_MIN(4),
+				    IN_TO_REG(W83781D_INIT_IN_MIN_4));
+		w83781d_write_value(client, W83781D_REG_IN_MAX(4),
+				    IN_TO_REG(W83781D_INIT_IN_MAX_4));
+		if (type =3D=3D w83781d || type =3D=3D as99127f) {
+			w83781d_write_value(client, W83781D_REG_IN_MIN(5),
+					    IN_TO_REG(W83781D_INIT_IN_MIN_5));
+			w83781d_write_value(client, W83781D_REG_IN_MAX(5),
+					    IN_TO_REG(W83781D_INIT_IN_MAX_5));
+		} else {
+			w83781d_write_value(client, W83781D_REG_IN_MIN(5),
+					    IN_TO_REG(W83782D_INIT_IN_MIN_5));
+			w83781d_write_value(client, W83781D_REG_IN_MAX(5),
+					    IN_TO_REG(W83782D_INIT_IN_MAX_5));
+		}
+		if (type =3D=3D w83781d || type =3D=3D as99127f) {
+			w83781d_write_value(client, W83781D_REG_IN_MIN(6),
+					    IN_TO_REG(W83781D_INIT_IN_MIN_6));
+			w83781d_write_value(client, W83781D_REG_IN_MAX(6),
+					    IN_TO_REG(W83781D_INIT_IN_MAX_6));
+		} else {
+			w83781d_write_value(client, W83781D_REG_IN_MIN(6),
+					    IN_TO_REG(W83782D_INIT_IN_MIN_6));
+			w83781d_write_value(client, W83781D_REG_IN_MAX(6),
+					    IN_TO_REG(W83782D_INIT_IN_MAX_6));
+		}
+		if ((type =3D=3D w83782d) || (type =3D=3D w83627hf) ||
+		    (type =3D=3D w83697hf)) {
+			w83781d_write_value(client, W83781D_REG_IN_MIN(7),
+					    IN_TO_REG(W83781D_INIT_IN_MIN_7));
+			w83781d_write_value(client, W83781D_REG_IN_MAX(7),
+					    IN_TO_REG(W83781D_INIT_IN_MAX_7));
+			w83781d_write_value(client, W83781D_REG_IN_MIN(8),
+					    IN_TO_REG(W83781D_INIT_IN_MIN_8));
+			w83781d_write_value(client, W83781D_REG_IN_MAX(8),
+					    IN_TO_REG(W83781D_INIT_IN_MAX_8));
+			w83781d_write_value(client, W83781D_REG_VBAT,
+					    (w83781d_read_value
+					     (client,
+					      W83781D_REG_VBAT) | 0x01));
+		}
+		w83781d_write_value(client, W83781D_REG_FAN_MIN(1),
+				    FAN_TO_REG(W83781D_INIT_FAN_MIN_1, 2));
+		w83781d_write_value(client, W83781D_REG_FAN_MIN(2),
+				    FAN_TO_REG(W83781D_INIT_FAN_MIN_2, 2));
+		if (type !=3D w83697hf) {
+			w83781d_write_value(client, W83781D_REG_FAN_MIN(3),
+					    FAN_TO_REG(W83781D_INIT_FAN_MIN_3,
+						       2));
+		}
+
+		w83781d_write_value(client, W83781D_REG_TEMP_OVER(1),
+				    TEMP_TO_REG(W83781D_INIT_TEMP_OVER));
+		w83781d_write_value(client, W83781D_REG_TEMP_HYST(1),
+				    TEMP_TO_REG(W83781D_INIT_TEMP_HYST));
+
+		if (type =3D=3D as99127f) {
+			w83781d_write_value(client, W83781D_REG_TEMP_OVER(2),
+					    AS99127_TEMP_ADD_TO_REG
+					    (W83781D_INIT_TEMP2_OVER));
+			w83781d_write_value(client, W83781D_REG_TEMP_HYST(2),
+					    AS99127_TEMP_ADD_TO_REG
+					    (W83781D_INIT_TEMP2_HYST));
+		} else {
+			w83781d_write_value(client, W83781D_REG_TEMP_OVER(2),
+					    TEMP_ADD_TO_REG
+					    (W83781D_INIT_TEMP2_OVER));
+			w83781d_write_value(client, W83781D_REG_TEMP_HYST(2),
+					    TEMP_ADD_TO_REG
+					    (W83781D_INIT_TEMP2_HYST));
+		}
+		w83781d_write_value(client, W83781D_REG_TEMP2_CONFIG, 0x00);
+
+		if (type =3D=3D as99127f) {
+			w83781d_write_value(client, W83781D_REG_TEMP_OVER(3),
+					    AS99127_TEMP_ADD_TO_REG
+					    (W83781D_INIT_TEMP3_OVER));
+			w83781d_write_value(client, W83781D_REG_TEMP_HYST(3),
+					    AS99127_TEMP_ADD_TO_REG
+					    (W83781D_INIT_TEMP3_HYST));
+		} else if (type !=3D w83783s && type !=3D w83697hf) {
+			w83781d_write_value(client, W83781D_REG_TEMP_OVER(3),
+					    TEMP_ADD_TO_REG
+					    (W83781D_INIT_TEMP3_OVER));
+			w83781d_write_value(client, W83781D_REG_TEMP_HYST(3),
+					    TEMP_ADD_TO_REG
+					    (W83781D_INIT_TEMP3_HYST));
+		}
+		if (type !=3D w83783s && type !=3D w83697hf) {
+			w83781d_write_value(client, W83781D_REG_TEMP3_CONFIG,
+					    0x00);
+		}
+		if (type !=3D w83781d) {
+			/* enable comparator mode for temp2 and temp3 so
+			   alarm indication will work correctly */
+			w83781d_write_value(client, W83781D_REG_IRQ, 0x41);
+			for (i =3D 0; i < 3; i++)
+				data->pwmenable[i] =3D 1;
+		}
+	}
+
+	/* Start monitoring */
+	w83781d_write_value(client, W83781D_REG_CONFIG,
+			    (w83781d_read_value(client,
+						W83781D_REG_CONFIG) & 0xf7)
+			    | 0x01);
+}
+
+static void
+w83781d_update_client(struct i2c_client *client)
+{
+	struct w83781d_data *data =3D i2c_get_clientdata(client);
+	int i;
+
+	down(&data->update_lock);
+
+	if (time_after
+	    (jiffies - data->last_updated, (unsigned long) (HZ + HZ / 2))
+	    || time_before(jiffies, data->last_updated) || !data->valid) {
+		pr_debug(KERN_DEBUG "Starting device update\n");
+
+		for (i =3D 0; i <=3D 8; i++) {
+			if ((data->type =3D=3D w83783s || data->type =3D=3D w83697hf)
+			    && (i =3D=3D 1))
+				continue;	/* 783S has no in1 */
+			data->in[i] =3D
+			    w83781d_read_value(client, W83781D_REG_IN(i));
+			data->in_min[i] =3D
+			    w83781d_read_value(client, W83781D_REG_IN_MIN(i));
+			data->in_max[i] =3D
+			    w83781d_read_value(client, W83781D_REG_IN_MAX(i));
+			if ((data->type !=3D w83782d) && (data->type !=3D w83697hf)
+			    && (data->type !=3D w83627hf) && (i =3D=3D 6))
+				break;
+		}
+		for (i =3D 1; i <=3D 3; i++) {
+			data->fan[i - 1] =3D
+			    w83781d_read_value(client, W83781D_REG_FAN(i));
+			data->fan_min[i - 1] =3D
+			    w83781d_read_value(client, W83781D_REG_FAN_MIN(i));
+		}
+		if (data->type !=3D w83781d) {
+			for (i =3D 1; i <=3D 4; i++) {
+				data->pwm[i - 1] =3D
+				    w83781d_read_value(client,
+						       W83781D_REG_PWM(i));
+				if (((data->type =3D=3D w83783s)
+				     || (data->type =3D=3D w83627hf)
+				     || (data->type =3D=3D as99127f)
+				     || (data->type =3D=3D w83697hf)
+				     || ((data->type =3D=3D w83782d)
+					 && i2c_is_isa_client(client)))
+				    && i =3D=3D 2)
+					break;
+			}
+		}
+
+		data->temp =3D w83781d_read_value(client, W83781D_REG_TEMP(1));
+		data->temp_min =3D
+		    w83781d_read_value(client, W83781D_REG_TEMP_OVER(1));
+		data->temp_max =3D
+		    w83781d_read_value(client, W83781D_REG_TEMP_HYST(1));
+		data->temp_add[0] =3D
+		    w83781d_read_value(client, W83781D_REG_TEMP(2));
+		data->temp_max_add[0] =3D
+		    w83781d_read_value(client, W83781D_REG_TEMP_OVER(2));
+		data->temp_min_add[0] =3D
+		    w83781d_read_value(client, W83781D_REG_TEMP_HYST(2));
+		if (data->type !=3D w83783s && data->type !=3D w83697hf) {
+			data->temp_add[1] =3D
+			    w83781d_read_value(client, W83781D_REG_TEMP(3));
+			data->temp_max_add[1] =3D
+			    w83781d_read_value(client,
+					       W83781D_REG_TEMP_OVER(3));
+			data->temp_min_add[1] =3D
+			    w83781d_read_value(client,
+					       W83781D_REG_TEMP_HYST(3));
+		}
+		i =3D w83781d_read_value(client, W83781D_REG_VID_FANDIV);
+		if (data->type !=3D w83697hf) {
+			data->vid =3D i & 0x0f;
+			data->vid |=3D
+			    (w83781d_read_value(client, W83781D_REG_CHIPID) &
+			     0x01)
+			    << 4;
+		}
+		data->fan_div[0] =3D (i >> 4) & 0x03;
+		data->fan_div[1] =3D (i >> 6) & 0x03;
+		if (data->type !=3D w83697hf) {
+			data->fan_div[2] =3D (w83781d_read_value(client,
+							       W83781D_REG_PIN)
+					    >> 6) & 0x03;
+		}
+		if ((data->type !=3D w83781d) && (data->type !=3D as99127f)) {
+			i =3D w83781d_read_value(client, W83781D_REG_VBAT);
+			data->fan_div[0] |=3D (i >> 3) & 0x04;
+			data->fan_div[1] |=3D (i >> 4) & 0x04;
+			if (data->type !=3D w83697hf)
+				data->fan_div[2] |=3D (i >> 5) & 0x04;
+		}
+		data->alarms =3D
+		    w83781d_read_value(client,
+				       W83781D_REG_ALARM1) +
+		    (w83781d_read_value(client, W83781D_REG_ALARM2) << 8);
+		if ((data->type =3D=3D w83782d) || (data->type =3D=3D w83627hf)) {
+			data->alarms |=3D
+			    w83781d_read_value(client,
+					       W83781D_REG_ALARM3) << 16;
+		}
+		i =3D w83781d_read_value(client, W83781D_REG_BEEP_INTS2);
+		data->beep_enable =3D i >> 7;
+		data->beep_mask =3D ((i & 0x7f) << 8) +
+		    w83781d_read_value(client, W83781D_REG_BEEP_INTS1);
+		if ((data->type !=3D w83781d) && (data->type !=3D as99127f)) {
+			data->beep_mask |=3D
+			    w83781d_read_value(client,
+					       W83781D_REG_BEEP_INTS3) << 16;
+		}
+		data->last_updated =3D jiffies;
+		data->valid =3D 1;
+	}
+
+	up(&data->update_lock);
+}
+
+static int __init
+sensors_w83781d_init(void)
+{
+	return i2c_add_driver(&w83781d_driver);
+}
+
+static void __exit
+sensors_w83781d_exit(void)
+{
+	i2c_del_driver(&w83781d_driver);
+}
+
+MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>, "
+	      "Philip Edelbrock <phil@netroedge.com>, "
+	      "and Mark Studebaker <mdsxyz123@yahoo.com>");
+MODULE_DESCRIPTION("W83781D driver");
+MODULE_LICENSE("GPL");
+
+module_init(sensors_w83781d_init);
+module_exit(sensors_w83781d_exit);
diff -urPp ../linux-2.5.66bk4/include/linux/i2c-vid.h linux.w83781d/include=
/linux/i2c-vid.h
--- ../linux-2.5.66bk4/include/linux/i2c-vid.h	1970-01-01 02:00:00.00000000=
0 +0200
+++ linux.w83781d/include/linux/i2c-vid.h	2003-03-30 06:28:53.000000000 +02=
00
@@ -0,0 +1,62 @@
+/*
+    vrm.c - Part of lm_sensors, Linux kernel modules for hardware
+               monitoring
+    Copyright (c) 2002 Mark D. Studebaker <mdsxyz123@yahoo.com>
+    With assistance from Trent Piepho <xyzzy@speakeasy.org>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+*/
+
+/*
+    This file contains common code for decoding VID pins.
+    This file is #included in various chip drivers in this directory.
+    As the user is unlikely to load more than one driver which
+    includes this code we don't worry about the wasted space.
+    Reference: VRM x.y DC-DC Converter Design Guidelines,
+    available at http://developer.intel.com
+*/
+
+/*
+    Legal val values 00 - 1F.
+    vrm is the Intel VRM document version.
+    Note: vrm version is scaled by 10 and the return value is scaled by 10=
00
+    to avoid floating point in the kernel.
+*/
+
+#define DEFAULT_VRM	82
+
+static inline int vid_from_reg(int val, int vrm)
+{
+	switch(vrm) {
+
+	case 91:		/* VRM 9.1 */
+	case 90:		/* VRM 9.0 */
+		return(val =3D=3D 0x1f ? 0 :
+		                       1850 - val * 25);
+
+	case 85:		/* VRM 8.5 */
+		return((val & 0x10  ? 25 : 0) +
+		       ((val & 0x0f) > 0x04 ? 2050 : 1250) -
+		       ((val & 0x0f) * 50));
+
+	case 84:		/* VRM 8.4 */
+		val &=3D 0x0f;
+				/* fall through */
+	default:		/* VRM 8.2 */
+		return(val =3D=3D 0x1f ? 0 :
+		       val & 0x10  ? 5100 - (val) * 100 :
+		                     2050 - (val) * 50);
+	}
+}

--=-c3wpRNPK/bV7ImK8mKw4--

--=-c2PiFYVsu/sGVUFoQuSd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+hudbqburzKaJYLYRArHhAKCJDCmgvK8aLvrHGijFm8MflLC1bACcCIiq
ALz+88O0fDFSwDqKA/toJpc=
=1XA9
-----END PGP SIGNATURE-----

--=-c2PiFYVsu/sGVUFoQuSd--

