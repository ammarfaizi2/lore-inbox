Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261857AbTCZS5u>; Wed, 26 Mar 2003 13:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261856AbTCZS5t>; Wed, 26 Mar 2003 13:57:49 -0500
Received: from cpt-dial-196-30-180-122.mweb.co.za ([196.30.180.122]:17536 "EHLO
	nosferatu.lan") by vger.kernel.org with ESMTP id <S261857AbTCZS5G>;
	Wed, 26 Mar 2003 13:57:06 -0500
Subject: w83781d i2c driver updated for 2.5.66 (without sysfs support)
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: Greg KH <greg@kroah.com>
Cc: KML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@brodo.de>,
       sensors@stimpy.netroedge.com
In-Reply-To: <20030325175603.GG15823@kroah.com>
References: <1048582394.4774.7.camel@workshop.saharact.lan>
	 <20030325175603.GG15823@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Ew4QMLdaDV8jPbXAw5a5"
Organization: 
Message-Id: <1048705473.7569.10.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 26 Mar 2003 21:04:33 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Ew4QMLdaDV8jPbXAw5a5
Content-Type: multipart/mixed; boundary="=-zCbyfS/Mzc/bn5zLWz+1"


--=-zCbyfS/Mzc/bn5zLWz+1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi

Ok, this is the w83781d driver updated for 2.5.66bk2.  It works
over here.

I did look at the changes needed for sysfs, but this beast have
about 6 ctl_tables, and is hairy in general.  I am not sure what
is the best way to do it for the different chips, so here is what
I have until I or somebody else can do the sysfs stuff.


Regards,

--=20

Martin Schlemmer



--=-zCbyfS/Mzc/bn5zLWz+1
Content-Disposition: attachment; filename=i2c-chip-w83781d-2.5.66bk2.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=i2c-chip-w83781d-2.5.66bk2.patch; charset=ISO-8859-1

--- linux-2.5.66bk2/drivers/i2c/chips/Kconfig	2003-03-25 00:00:45.000000000=
 +0200
+++ linux-2.5.66bk2/drivers/i2c/chips/Kconfig	2003-03-25 18:54:07.000000000=
 +0200
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
--- linux-2.5.66bk2/drivers/i2c/chips/Makefile	2003-03-24 23:59:53.00000000=
0 +0200
+++ linux-2.5.66bk2/drivers/i2c/chips/Makefile	2003-03-25 18:54:11.00000000=
0 +0200
@@ -4,3 +4,4 @@
=20
 obj-$(CONFIG_SENSORS_ADM1021)	+=3D adm1021.o
 obj-$(CONFIG_SENSORS_LM75)	+=3D lm75.o
+obj-$(CONFIG_SENSORS_W83781D)	+=3D w83781d.o
--- linux-2.5.66bk2/drivers/i2c/chips/w83781d.c	1970-01-01 02:00:00.0000000=
00 +0200
+++ linux-2.5.66bk2/drivers/i2c/chips/w83781d.c	2003-03-26 20:21:14.0000000=
00 +0200
@@ -0,0 +1,2073 @@
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
+#include <asm/io.h>
+
+
+/* Registers */
+#define W83781D_SYSCTL_IN0 1000	/* Volts * 100 */
+#define W83781D_SYSCTL_IN1 1001
+#define W83781D_SYSCTL_IN2 1002
+#define W83781D_SYSCTL_IN3 1003
+#define W83781D_SYSCTL_IN4 1004
+#define W83781D_SYSCTL_IN5 1005
+#define W83781D_SYSCTL_IN6 1006
+#define W83781D_SYSCTL_IN7 1007
+#define W83781D_SYSCTL_IN8 1008
+#define W83781D_SYSCTL_FAN1 1101	/* Rotations/min */
+#define W83781D_SYSCTL_FAN2 1102
+#define W83781D_SYSCTL_FAN3 1103
+#define W83781D_SYSCTL_TEMP1 1200	/* Degrees Celcius * 10 */
+#define W83781D_SYSCTL_TEMP2 1201	/* Degrees Celcius * 10 */
+#define W83781D_SYSCTL_TEMP3 1202	/* Degrees Celcius * 10 */
+#define W83781D_SYSCTL_VID 1300	/* Volts * 1000 */
+#define W83781D_SYSCTL_VRM 1301
+#define W83781D_SYSCTL_PWM1 1401
+#define W83781D_SYSCTL_PWM2 1402
+#define W83781D_SYSCTL_PWM3 1403
+#define W83781D_SYSCTL_PWM4 1404
+#define W83781D_SYSCTL_SENS1 1501	/* 1, 2, or Beta (3000-5000) */
+#define W83781D_SYSCTL_SENS2 1502
+#define W83781D_SYSCTL_SENS3 1503
+#define W83781D_SYSCTL_RT1   1601	/* 32-entry table */
+#define W83781D_SYSCTL_RT2   1602	/* 32-entry table */
+#define W83781D_SYSCTL_RT3   1603	/* 32-entry table */
+#define W83781D_SYSCTL_FAN_DIV 2000	/* 1, 2, 4 or 8 */
+#define W83781D_SYSCTL_ALARMS 2001	/* bitvector */
+#define W83781D_SYSCTL_BEEP 2002	/* bitvector */
+
+#define W83781D_ALARM_IN0 0x0001
+#define W83781D_ALARM_IN1 0x0002
+#define W83781D_ALARM_IN2 0x0004
+#define W83781D_ALARM_IN3 0x0008
+#define W83781D_ALARM_IN4 0x0100
+#define W83781D_ALARM_IN5 0x0200
+#define W83781D_ALARM_IN6 0x0400
+#define W83782D_ALARM_IN7 0x10000
+#define W83782D_ALARM_IN8 0x20000
+#define W83781D_ALARM_FAN1 0x0040
+#define W83781D_ALARM_FAN2 0x0080
+#define W83781D_ALARM_FAN3 0x0800
+#define W83781D_ALARM_TEMP1 0x0010
+#define W83781D_ALARM_TEMP23 0x0020	/* 781D only */
+#define W83781D_ALARM_TEMP2 0x0020	/* 782D/783S */
+#define W83781D_ALARM_TEMP3 0x2000	/* 782D only */
+#define W83781D_ALARM_CHAS 0x1000
+
+/* RT Table support #defined so we can take it out if it gets bothersome *=
/
+#define W83781D_RT 1
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
+#define W83781D_EXTENT 8
+
+/* Where are the ISA address/data registers relative to the base address *=
/
+#define W83781D_ADDR_REG_OFFSET 5
+#define W83781D_DATA_REG_OFFSET 6
+
+/* The W83781D registers */
+/* The W83782D registers for nr=3D7,8 are in bank 5 */
+#define W83781D_REG_IN_MAX(nr) ((nr < 7) ? (0x2b + (nr) * 2) : \
+					   (0x554 + (((nr) - 7) * 2)))
+#define W83781D_REG_IN_MIN(nr) ((nr < 7) ? (0x2c + (nr) * 2) : \
+					   (0x555 + (((nr) - 7) * 2)))
+#define W83781D_REG_IN(nr)     ((nr < 7) ? (0x20 + (nr)) : \
+					   (0x550 + (nr) - 7))
+
+#define W83781D_REG_FAN_MIN(nr) (0x3a + (nr))
+#define W83781D_REG_FAN(nr) (0x27 + (nr))
+
+#define W83781D_REG_TEMP2 0x0150
+#define W83781D_REG_TEMP3 0x0250
+#define W83781D_REG_TEMP2_HYST 0x153
+#define W83781D_REG_TEMP3_HYST 0x253
+#define W83781D_REG_TEMP2_CONFIG 0x152
+#define W83781D_REG_TEMP3_CONFIG 0x252
+#define W83781D_REG_TEMP2_OVER 0x155
+#define W83781D_REG_TEMP3_OVER 0x255
+
+#define W83781D_REG_TEMP 0x27
+#define W83781D_REG_TEMP_OVER 0x39
+#define W83781D_REG_TEMP_HYST 0x3A
+#define W83781D_REG_BANK 0x4E
+
+#define W83781D_REG_CONFIG 0x40
+#define W83781D_REG_ALARM1 0x41
+#define W83781D_REG_ALARM2 0x42
+#define W83781D_REG_ALARM3 0x450	/* not on W83781D */
+
+#define W83781D_REG_IRQ 0x4C
+#define W83781D_REG_BEEP_CONFIG 0x4D
+#define W83781D_REG_BEEP_INTS1 0x56
+#define W83781D_REG_BEEP_INTS2 0x57
+#define W83781D_REG_BEEP_INTS3 0x453	/* not on W83781D */
+
+#define W83781D_REG_VID_FANDIV 0x47
+
+#define W83781D_REG_CHIPID 0x49
+#define W83781D_REG_WCHIPID 0x58
+#define W83781D_REG_CHIPMAN 0x4F
+#define W83781D_REG_PIN 0x4B
+
+/* 782D/783S only */
+#define W83781D_REG_VBAT 0x5D
+
+/* PWM 782D (1-4) and 783S (1-2) only */
+#define W83781D_REG_PWM1 0x5B	/* 782d and 783s/627hf datasheets disagree *=
/
+				/* on which is which; */
+#define W83781D_REG_PWM2 0x5A	/* We follow the 782d convention here, */
+				/* However 782d is probably wrong. */
+#define W83781D_REG_PWM3 0x5E
+#define W83781D_REG_PWM4 0x5F
+#define W83781D_REG_PWMCLK12 0x5C
+#define W83781D_REG_PWMCLK34 0x45C
+static const u8 regpwm[] =3D { W83781D_REG_PWM1, W83781D_REG_PWM2,
+	W83781D_REG_PWM3, W83781D_REG_PWM4
+};
+
+#define W83781D_REG_PWM(nr) (regpwm[(nr) - 1])
+
+#define W83781D_REG_I2C_ADDR 0x48
+#define W83781D_REG_I2C_SUBADDR 0x4A
+
+/* The following are undocumented in the data sheets however we
+   received the information in an email from Winbond tech support */
+/* Sensor selection - not on 781d */
+#define W83781D_REG_SCFG1 0x5D
+static const u8 BIT_SCFG1[] =3D { 0x02, 0x04, 0x08 };
+
+#define W83781D_REG_SCFG2 0x59
+static const u8 BIT_SCFG2[] =3D { 0x10, 0x20, 0x40 };
+
+#define W83781D_DEFAULT_BETA 3435
+
+/* RT Table registers */
+#define W83781D_REG_RT_IDX 0x50
+#define W83781D_REG_RT_VAL 0x51
+
+/* Conversions. Rounding and limit checking is only done on the TO_REG
+   variants. Note that you should be a bit careful with which arguments
+   these macros are called: arguments may be evaluated more than once.
+   Fixing this is just not worth it. */
+#define IN_TO_REG(val)  (SENSORS_LIMIT((((val) * 10 + 8)/16),0,255))
+#define IN_FROM_REG(val) (((val) * 16) / 10)
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
+#define FAN_FROM_REG(val,div) ((val)=3D=3D0?-1:(val)=3D=3D255?0:1350000/((=
val)*(div)))
+
+#define TEMP_TO_REG(val) (SENSORS_LIMIT(((val)<0?(((val)-5)/10):\
+                                                 ((val)+5)/10),0,255))
+#define TEMP_FROM_REG(val) (((val)>0x80?(val)-0x100:(val))*10)
+
+#define TEMP_ADD_TO_REG(val)   (SENSORS_LIMIT(((((val) + 2) / 5) << 7),\
+                                              0,0xffff))
+#define TEMP_ADD_FROM_REG(val) (((val) >> 7) * 5)
+
+#define AS99127_TEMP_ADD_TO_REG(val) (SENSORS_LIMIT((((((val) + 2)*4)/10) =
\
+                                               << 7),0,0xffff))
+#define AS99127_TEMP_ADD_FROM_REG(val) ((((val) >> 7) * 10) / 4)
+
+#define ALARMS_FROM_REG(val) (val)
+#define PWM_FROM_REG(val) (val)
+#define PWM_TO_REG(val) (SENSORS_LIMIT((val),0,255))
+#define BEEPS_FROM_REG(val) (val)
+#define BEEPS_TO_REG(val) ((val) & 0xffffff)
+
+#define BEEP_ENABLE_TO_REG(val)   ((val)?1:0)
+#define BEEP_ENABLE_FROM_REG(val) ((val)?1:0)
+
+#define DIV_FROM_REG(val) (1 << (val))
+
+#define DEFAULT_VRM 82
+
+/*
+ * Legal val values 00 - 1F.
+ * vrm is the Intel VRM document version.
+ * Note: vrm version is scaled by 10 and the return value is scaled
+ *       by 1000 to avoid floating point in the kernel.
+ *                =20
+ */
+
+static inline int
+vid_from_reg(int val, int vrm)
+{
+	switch (vrm) {
+
+	case 91:		/* VRM 9.1 */
+	case 90:		/* VRM 9.0 */
+		return (val =3D=3D 0x1f ? 0 : 1850 - val * 25);
+
+	case 85:		/* VRM 8.5 */
+		return ((val & 0x10 ? 25 : 0) +
+			((val & 0x0f) > 0x04 ? 2050 : 1250) -
+			((val & 0x0f) * 50));
+
+	case 84:		/* VRM 8.4 */
+		val &=3D 0x0f;
+		/* fall through */
+	default:		/* VRM 8.2 */
+		return (val =3D=3D 0x1f ? 0 :
+			val & 0x10 ? 5100 - (val) * 100 : 2050 - (val) * 50);
+	}
+}
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
+#define W83781D_INIT_IN_0 (vid=3D=3D3500?280:vid/10)
+#define W83781D_INIT_IN_1 (vid=3D=3D3500?280:vid/10)
+#define W83781D_INIT_IN_2 330
+#define W83781D_INIT_IN_3 (((500)   * 100)/168)
+#define W83781D_INIT_IN_4 (((1200)  * 10)/38)
+#define W83781D_INIT_IN_5 (((-1200) * -604)/2100)
+#define W83781D_INIT_IN_6 (((-500)  * -604)/909)
+#define W83781D_INIT_IN_7 (((500)   * 100)/168)
+#define W83781D_INIT_IN_8 300
+/* Initial limits for 782d/783s negative voltages */
+/* Note level shift. Change min/max below if you change these. */
+#define W83782D_INIT_IN_5 ((((-1200) + 1491) * 100)/514)
+#define W83782D_INIT_IN_6 ((( (-500)  + 771) * 100)/314)
+
+#define W83781D_INIT_IN_PERCENTAGE 10
+
+#define W83781D_INIT_IN_MIN_0 \
+        (W83781D_INIT_IN_0 - W83781D_INIT_IN_0 * W83781D_INIT_IN_PERCENTAG=
E \
+         / 100)
+#define W83781D_INIT_IN_MAX_0 \
+        (W83781D_INIT_IN_0 + W83781D_INIT_IN_0 * W83781D_INIT_IN_PERCENTAG=
E \
+         / 100)
+#define W83781D_INIT_IN_MIN_1 \
+        (W83781D_INIT_IN_1 - W83781D_INIT_IN_1 * W83781D_INIT_IN_PERCENTAG=
E \
+         / 100)
+#define W83781D_INIT_IN_MAX_1 \
+        (W83781D_INIT_IN_1 + W83781D_INIT_IN_1 * W83781D_INIT_IN_PERCENTAG=
E \
+         / 100)
+#define W83781D_INIT_IN_MIN_2 \
+        (W83781D_INIT_IN_2 - W83781D_INIT_IN_2 * W83781D_INIT_IN_PERCENTAG=
E \
+         / 100)
+#define W83781D_INIT_IN_MAX_2 \
+        (W83781D_INIT_IN_2 + W83781D_INIT_IN_2 * W83781D_INIT_IN_PERCENTAG=
E \
+         / 100)
+#define W83781D_INIT_IN_MIN_3 \
+        (W83781D_INIT_IN_3 - W83781D_INIT_IN_3 * W83781D_INIT_IN_PERCENTAG=
E \
+         / 100)
+#define W83781D_INIT_IN_MAX_3 \
+        (W83781D_INIT_IN_3 + W83781D_INIT_IN_3 * W83781D_INIT_IN_PERCENTAG=
E \
+         / 100)
+#define W83781D_INIT_IN_MIN_4 \
+        (W83781D_INIT_IN_4 - W83781D_INIT_IN_4 * W83781D_INIT_IN_PERCENTAG=
E \
+         / 100)
+#define W83781D_INIT_IN_MAX_4 \
+        (W83781D_INIT_IN_4 + W83781D_INIT_IN_4 * W83781D_INIT_IN_PERCENTAG=
E \
+         / 100)
+#define W83781D_INIT_IN_MIN_5 \
+        (W83781D_INIT_IN_5 - W83781D_INIT_IN_5 * W83781D_INIT_IN_PERCENTAG=
E \
+         / 100)
+#define W83781D_INIT_IN_MAX_5 \
+        (W83781D_INIT_IN_5 + W83781D_INIT_IN_5 * W83781D_INIT_IN_PERCENTAG=
E \
+         / 100)
+#define W83781D_INIT_IN_MIN_6 \
+        (W83781D_INIT_IN_6 - W83781D_INIT_IN_6 * W83781D_INIT_IN_PERCENTAG=
E \
+         / 100)
+#define W83781D_INIT_IN_MAX_6 \
+        (W83781D_INIT_IN_6 + W83781D_INIT_IN_6 * W83781D_INIT_IN_PERCENTAG=
E \
+         / 100)
+#define W83781D_INIT_IN_MIN_7 \
+        (W83781D_INIT_IN_7 - W83781D_INIT_IN_7 * W83781D_INIT_IN_PERCENTAG=
E \
+         / 100)
+#define W83781D_INIT_IN_MAX_7 \
+        (W83781D_INIT_IN_7 + W83781D_INIT_IN_7 * W83781D_INIT_IN_PERCENTAG=
E \
+         / 100)
+#define W83781D_INIT_IN_MIN_8 \
+        (W83781D_INIT_IN_8 - W83781D_INIT_IN_8 * W83781D_INIT_IN_PERCENTAG=
E \
+         / 100)
+#define W83781D_INIT_IN_MAX_8 \
+        (W83781D_INIT_IN_8 + W83781D_INIT_IN_8 * W83781D_INIT_IN_PERCENTAG=
E \
+         / 100)
+/* Initial limits for 782d/783s negative voltages */
+/* These aren't direct multiples because of level shift */
+/* Beware going negative - check */
+#define W83782D_INIT_IN_MIN_5_TMP \
+        (((-1200 * (100 + W83781D_INIT_IN_PERCENTAGE)) + (1491 * 100))/514=
)
+#define W83782D_INIT_IN_MIN_5 \
+        ((W83782D_INIT_IN_MIN_5_TMP > 0) ? W83782D_INIT_IN_MIN_5_TMP : 0)
+#define W83782D_INIT_IN_MAX_5 \
+        (((-1200 * (100 - W83781D_INIT_IN_PERCENTAGE)) + (1491 * 100))/514=
)
+#define W83782D_INIT_IN_MIN_6_TMP \
+        ((( -500 * (100 + W83781D_INIT_IN_PERCENTAGE)) +  (771 * 100))/314=
)
+#define W83782D_INIT_IN_MIN_6 \
+        ((W83782D_INIT_IN_MIN_6_TMP > 0) ? W83782D_INIT_IN_MIN_6_TMP : 0)
+#define W83782D_INIT_IN_MAX_6 \
+        ((( -500 * (100 - W83781D_INIT_IN_PERCENTAGE)) +  (771 * 100))/314=
)
+
+#define W83781D_INIT_FAN_MIN_1 3000
+#define W83781D_INIT_FAN_MIN_2 3000
+#define W83781D_INIT_FAN_MIN_3 3000
+
+#define W83781D_INIT_TEMP_OVER 600
+#define W83781D_INIT_TEMP_HYST 1270	/* must be 127 for ALARM to work */
+#define W83781D_INIT_TEMP2_OVER 600
+#define W83781D_INIT_TEMP2_HYST 500
+#define W83781D_INIT_TEMP3_OVER 600
+#define W83781D_INIT_TEMP3_HYST 500
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
+	int sysctl_id;
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
+	u8 temp_over;		/* Register value */
+	u8 temp_hyst;		/* Register value */
+	u16 temp_add[2];	/* Register value */
+	u16 temp_add_over[2];	/* Register value */
+	u16 temp_add_hyst[2];	/* Register value */
+	u8 fan_div[3];		/* Register encoding, shifted right */
+	u8 vid;			/* Register encoding, combined */
+	u32 alarms;		/* Register encoding, combined */
+	u32 beeps;		/* Register encoding, combined */
+	u8 beep_enable;		/* Boolean */
+	u8 pwm[4];		/* Register value */
+	u8 pwmenable[4];	/* bool */
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
+static void w83781d_in(struct i2c_client *client, int operation,
+		       int ctl_name, int *nrels_mag, long *results);
+static void w83781d_fan(struct i2c_client *client, int operation,
+			int ctl_name, int *nrels_mag, long *results);
+static void w83781d_temp(struct i2c_client *client, int operation,
+			 int ctl_name, int *nrels_mag, long *results);
+static void w83781d_temp_add(struct i2c_client *client, int operation,
+			     int ctl_name, int *nrels_mag, long *results);
+static void w83781d_vid(struct i2c_client *client, int operation,
+			int ctl_name, int *nrels_mag, long *results);
+static void w83781d_vrm(struct i2c_client *client, int operation,
+			int ctl_name, int *nrels_mag, long *results);
+static void w83781d_alarms(struct i2c_client *client, int operation,
+			   int ctl_name, int *nrels_mag, long *results);
+static void w83781d_beep(struct i2c_client *client, int operation,
+			 int ctl_name, int *nrels_mag, long *results);
+static void w83781d_fan_div(struct i2c_client *client, int operation,
+			    int ctl_name, int *nrels_mag, long *results);
+static void w83781d_pwm(struct i2c_client *client, int operation,
+			int ctl_name, int *nrels_mag, long *results);
+static void w83781d_sens(struct i2c_client *client, int operation,
+			 int ctl_name, int *nrels_mag, long *results);
+#ifdef W83781D_RT
+static void w83781d_rt(struct i2c_client *client, int operation,
+		       int ctl_name, int *nrels_mag, long *results);
+#endif
+static u16 swap_bytes(u16 val);
+
+static int w83781d_id =3D 0;
+
+static struct i2c_driver w83781d_driver =3D {
+	.owner =3D THIS_MODULE,
+	.name =3D "W83781D sensor",
+	.id =3D I2C_DRIVERID_W83781D,
+	.flags =3D I2C_DF_NOTIFY,
+	.attach_adapter =3D w83781d_attach_adapter,
+	.detach_client =3D w83781d_detach_client,
+};
+
+/* These files are created for each detected chip. This is just a template=
;
+   though at first sight, you might think we could use a statically
+   allocated list, we need some way to get back to the parent - which
+   is done through one of the 'extra' fields which are initialized=20
+   when a new copy is allocated. */
+
+/* just a guess - no datasheet */
+static ctl_table as99127f_dir_table_template[] =3D {
+	{W83781D_SYSCTL_IN0, "in0", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_IN1, "in1", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_IN2, "in2", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_IN3, "in3", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_IN4, "in4", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_IN5, "in5", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_IN6, "in6", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_FAN1, "fan1", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_fan},
+	{W83781D_SYSCTL_FAN2, "fan2", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_fan},
+	{W83781D_SYSCTL_FAN3, "fan3", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_fan},
+	{W83781D_SYSCTL_TEMP1, "temp1", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_temp},
+	{W83781D_SYSCTL_TEMP2, "temp2", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_temp_add},
+	{W83781D_SYSCTL_TEMP3, "temp3", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_temp_add},
+	{W83781D_SYSCTL_VID, "vid", NULL, 0, 0444, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_vid},
+	{W83781D_SYSCTL_VRM, "vrm", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_vrm},
+	{W83781D_SYSCTL_FAN_DIV, "fan_div", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_fan_div},
+	{W83781D_SYSCTL_ALARMS, "alarms", NULL, 0, 0444, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_alarms},
+	{W83781D_SYSCTL_BEEP, "beep", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_beep},
+	{W83781D_SYSCTL_PWM1, "pwm1", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_pwm},
+	{W83781D_SYSCTL_PWM2, "pwm2", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_pwm},
+	{0}
+};
+
+static ctl_table w83781d_dir_table_template[] =3D {
+	{W83781D_SYSCTL_IN0, "in0", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_IN1, "in1", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_IN2, "in2", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_IN3, "in3", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_IN4, "in4", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_IN5, "in5", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_IN6, "in6", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_FAN1, "fan1", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_fan},
+	{W83781D_SYSCTL_FAN2, "fan2", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_fan},
+	{W83781D_SYSCTL_FAN3, "fan3", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_fan},
+	{W83781D_SYSCTL_TEMP1, "temp1", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_temp},
+	{W83781D_SYSCTL_TEMP2, "temp2", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_temp_add},
+	{W83781D_SYSCTL_TEMP3, "temp3", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_temp_add},
+	{W83781D_SYSCTL_VID, "vid", NULL, 0, 0444, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_vid},
+	{W83781D_SYSCTL_VRM, "vrm", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_vrm},
+	{W83781D_SYSCTL_FAN_DIV, "fan_div", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_fan_div},
+	{W83781D_SYSCTL_ALARMS, "alarms", NULL, 0, 0444, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_alarms},
+	{W83781D_SYSCTL_BEEP, "beep", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_beep},
+#ifdef W83781D_RT
+	{W83781D_SYSCTL_RT1, "rt1", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_rt},
+	{W83781D_SYSCTL_RT2, "rt2", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_rt},
+	{W83781D_SYSCTL_RT3, "rt3", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_rt},
+#endif
+	{0}
+};
+
+/* without pwm3-4 */
+static ctl_table w83782d_isa_dir_table_template[] =3D {
+	{W83781D_SYSCTL_IN0, "in0", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_IN1, "in1", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_IN2, "in2", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_IN3, "in3", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_IN4, "in4", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_IN5, "in5", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_IN6, "in6", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_IN7, "in7", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_IN8, "in8", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_FAN1, "fan1", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_fan},
+	{W83781D_SYSCTL_FAN2, "fan2", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_fan},
+	{W83781D_SYSCTL_FAN3, "fan3", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_fan},
+	{W83781D_SYSCTL_TEMP1, "temp1", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_temp},
+	{W83781D_SYSCTL_TEMP2, "temp2", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_temp_add},
+	{W83781D_SYSCTL_TEMP3, "temp3", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_temp_add},
+	{W83781D_SYSCTL_VID, "vid", NULL, 0, 0444, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_vid},
+	{W83781D_SYSCTL_VRM, "vrm", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_vrm},
+	{W83781D_SYSCTL_FAN_DIV, "fan_div", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_fan_div},
+	{W83781D_SYSCTL_ALARMS, "alarms", NULL, 0, 0444, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_alarms},
+	{W83781D_SYSCTL_BEEP, "beep", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_beep},
+	{W83781D_SYSCTL_PWM1, "pwm1", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_pwm},
+	{W83781D_SYSCTL_PWM2, "pwm2", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_pwm},
+	{W83781D_SYSCTL_SENS1, "sensor1", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_sens},
+	{W83781D_SYSCTL_SENS2, "sensor2", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_sens},
+	{W83781D_SYSCTL_SENS3, "sensor3", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_sens},
+	{0}
+};
+
+/* with pwm3-4 */
+static ctl_table w83782d_i2c_dir_table_template[] =3D {
+	{W83781D_SYSCTL_IN0, "in0", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_IN1, "in1", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_IN2, "in2", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_IN3, "in3", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_IN4, "in4", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_IN5, "in5", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_IN6, "in6", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_IN7, "in7", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_IN8, "in8", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_FAN1, "fan1", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_fan},
+	{W83781D_SYSCTL_FAN2, "fan2", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_fan},
+	{W83781D_SYSCTL_FAN3, "fan3", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_fan},
+	{W83781D_SYSCTL_TEMP1, "temp1", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_temp},
+	{W83781D_SYSCTL_TEMP2, "temp2", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_temp_add},
+	{W83781D_SYSCTL_TEMP3, "temp3", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_temp_add},
+	{W83781D_SYSCTL_VID, "vid", NULL, 0, 0444, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_vid},
+	{W83781D_SYSCTL_VRM, "vrm", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_vrm},
+	{W83781D_SYSCTL_FAN_DIV, "fan_div", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_fan_div},
+	{W83781D_SYSCTL_ALARMS, "alarms", NULL, 0, 0444, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_alarms},
+	{W83781D_SYSCTL_BEEP, "beep", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_beep},
+	{W83781D_SYSCTL_PWM1, "pwm1", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_pwm},
+	{W83781D_SYSCTL_PWM2, "pwm2", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_pwm},
+	{W83781D_SYSCTL_PWM3, "pwm3", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_pwm},
+	{W83781D_SYSCTL_PWM4, "pwm4", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_pwm},
+	{W83781D_SYSCTL_SENS1, "sensor1", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_sens},
+	{W83781D_SYSCTL_SENS2, "sensor2", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_sens},
+	{W83781D_SYSCTL_SENS3, "sensor3", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_sens},
+	{0}
+};
+
+static ctl_table w83783s_dir_table_template[] =3D {
+	{W83781D_SYSCTL_IN0, "in0", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	/* no in1 to maintain compatibility with 781d and 782d. */
+	{W83781D_SYSCTL_IN2, "in2", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_IN3, "in3", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_IN4, "in4", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_IN5, "in5", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_IN6, "in6", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_FAN1, "fan1", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_fan},
+	{W83781D_SYSCTL_FAN2, "fan2", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_fan},
+	{W83781D_SYSCTL_FAN3, "fan3", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_fan},
+	{W83781D_SYSCTL_TEMP1, "temp1", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_temp},
+	{W83781D_SYSCTL_TEMP2, "temp2", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_temp_add},
+	{W83781D_SYSCTL_VID, "vid", NULL, 0, 0444, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_vid},
+	{W83781D_SYSCTL_VRM, "vrm", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_vrm},
+	{W83781D_SYSCTL_FAN_DIV, "fan_div", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_fan_div},
+	{W83781D_SYSCTL_ALARMS, "alarms", NULL, 0, 0444, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_alarms},
+	{W83781D_SYSCTL_BEEP, "beep", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_beep},
+	{W83781D_SYSCTL_PWM1, "pwm1", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_pwm},
+	{W83781D_SYSCTL_PWM2, "pwm2", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_pwm},
+	{W83781D_SYSCTL_SENS1, "sensor1", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_sens},
+	{W83781D_SYSCTL_SENS2, "sensor2", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_sens},
+	{0}
+};
+
+/* similar to w83782d but no fan3, no vid */
+static ctl_table w83697hf_dir_table_template[] =3D {
+	{W83781D_SYSCTL_IN0, "in0", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	/* no in1 to maintain compatibility with 781d and 782d. */
+	{W83781D_SYSCTL_IN2, "in2", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_IN3, "in3", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_IN4, "in4", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_IN5, "in5", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_IN6, "in6", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_IN7, "in7", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_IN8, "in8", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_FAN1, "fan1", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_fan},
+	{W83781D_SYSCTL_FAN2, "fan2", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_fan},
+	{W83781D_SYSCTL_TEMP1, "temp1", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_temp},
+	{W83781D_SYSCTL_TEMP2, "temp2", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_temp_add},
+	{W83781D_SYSCTL_FAN_DIV, "fan_div", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_fan_div},
+	{W83781D_SYSCTL_ALARMS, "alarms", NULL, 0, 0444, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_alarms},
+	{W83781D_SYSCTL_BEEP, "beep", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_beep},
+	{W83781D_SYSCTL_PWM1, "pwm1", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_pwm},
+	{W83781D_SYSCTL_PWM2, "pwm2", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_pwm},
+	{W83781D_SYSCTL_SENS1, "sensor1", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_sens},
+	{W83781D_SYSCTL_SENS2, "sensor2", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_sens},
+	{0}
+};
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
+				printk(KERN_WARNING
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
+		printk(KERN_ERR "Internal error: unknown kind (%d)?!?", kind);
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
+	new_client->id =3D w83781d_id++;
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
+	=09
+		id =3D i2c_adapter_id(adapter);
+		if (force_subclients[0] =3D=3D id && force_subclients[1] =3D=3D address)=
 {
+			for (i =3D 2; i <=3D 3; i++) {
+				if (force_subclients[i] < 0x48 ||
+				    force_subclients[i] > 0x4f) {
+					printk(KERN_ERR
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
+				printk(KERN_ERR
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
+			i2c_set_clientdata(&data->lm75[i], NULL); /* store all data in w83781d =
*/
+			data->lm75[i].adapter =3D adapter;
+			data->lm75[i].driver =3D &w83781d_driver;
+			data->lm75[i].flags =3D 0;
+			strncpy(data->lm75[i].dev.name, client_name, DEVICE_NAME_SIZE);
+			data->lm75[i].id =3D w83781d_id++;
+			if ((err =3D i2c_attach_client(&(data->lm75[i])))) {
+				printk(KERN_ERR
+				       "Subclient %d registration at address 0x%x failed.\n",
+				       i, data->lm75[i].addr);
+				if (i =3D=3D 1)
+					goto ERROR6;
+				goto ERROR5;
+			}
+			if (kind =3D=3D w83783s)
+				break;
+		}
+	} else {
+		data->lm75 =3D NULL;
+	}
+
+	/* Register a new directory entry with module sensors */
+	if ((i =3D i2c_register_entry(new_client,
+				    type_name,
+				    (kind =3D=3D as99127f) ?
+				    as99127f_dir_table_template :
+				    (kind =3D=3D w83781d) ?
+				    w83781d_dir_table_template :
+				    (kind =3D=3D w83783s) ?
+				    w83783s_dir_table_template :
+				    (kind =3D=3D w83697hf) ?
+				    w83697hf_dir_table_template :
+				    (is_isa || kind =3D=3D w83627hf) ?
+				    w83782d_isa_dir_table_template :
+				    w83782d_i2c_dir_table_template)) < 0) {
+		err =3D i;
+		goto ERROR7;
+	}
+	data->sysctl_id =3D i;
+
+	/* Initialize the chip */
+	w83781d_init_client(new_client);
+	return 0;
+
+/* OK, this is not exactly good programming practice, usually. But it is
+   very code-efficient in this case. */
+
+      ERROR7:
+	if (!is_isa)
+		i2c_detach_client(&
+				  (((struct w83781d_data
+				     *) (i2c_get_clientdata(new_client)))->
+				   lm75[1]));
+      ERROR6:
+	if (!is_isa)
+		i2c_detach_client(&
+				  (((struct w83781d_data
+				     *) (i2c_get_clientdata(new_client)))->
+				   lm75[0]));
+      ERROR5:
+	if (!is_isa)
+		kfree(((struct w83781d_data *) (i2c_get_clientdata(new_client)))->
+		      lm75);
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
+	i2c_deregister_entry(data->sysctl_id);
+
+	if ((err =3D i2c_detach_client(client))) {
+		printk(KERN_ERR
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
+static inline u16
+swap_bytes(u16 val)
+{
+	return (val >> 8) | (val << 8);
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
+		   Individual beeps should be reset to off but for some reason
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
+		w83781d_write_value(client, W83781D_REG_TEMP_OVER,
+				    TEMP_TO_REG(W83781D_INIT_TEMP_OVER));
+		w83781d_write_value(client, W83781D_REG_TEMP_HYST,
+				    TEMP_TO_REG(W83781D_INIT_TEMP_HYST));
+
+		if (type =3D=3D as99127f) {
+			w83781d_write_value(client, W83781D_REG_TEMP2_OVER,
+					    AS99127_TEMP_ADD_TO_REG
+					    (W83781D_INIT_TEMP2_OVER));
+			w83781d_write_value(client, W83781D_REG_TEMP2_HYST,
+					    AS99127_TEMP_ADD_TO_REG
+					    (W83781D_INIT_TEMP2_HYST));
+		} else {
+			w83781d_write_value(client, W83781D_REG_TEMP2_OVER,
+					    TEMP_ADD_TO_REG
+					    (W83781D_INIT_TEMP2_OVER));
+			w83781d_write_value(client, W83781D_REG_TEMP2_HYST,
+					    TEMP_ADD_TO_REG
+					    (W83781D_INIT_TEMP2_HYST));
+		}
+		w83781d_write_value(client, W83781D_REG_TEMP2_CONFIG, 0x00);
+
+		if (type =3D=3D as99127f) {
+			w83781d_write_value(client, W83781D_REG_TEMP3_OVER,
+					    AS99127_TEMP_ADD_TO_REG
+					    (W83781D_INIT_TEMP3_OVER));
+			w83781d_write_value(client, W83781D_REG_TEMP3_HYST,
+					    AS99127_TEMP_ADD_TO_REG
+					    (W83781D_INIT_TEMP3_HYST));
+		} else if (type !=3D w83783s && type !=3D w83697hf) {
+			w83781d_write_value(client, W83781D_REG_TEMP3_OVER,
+					    TEMP_ADD_TO_REG
+					    (W83781D_INIT_TEMP3_OVER));
+			w83781d_write_value(client, W83781D_REG_TEMP3_HYST,
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
+	if (time_after(jiffies - data->last_updated, (unsigned long)(HZ + HZ / 2)=
) ||
+	    time_before(jiffies, data->last_updated) || !data->valid) {
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
+		data->temp =3D w83781d_read_value(client, W83781D_REG_TEMP);
+		data->temp_over =3D
+		    w83781d_read_value(client, W83781D_REG_TEMP_OVER);
+		data->temp_hyst =3D
+		    w83781d_read_value(client, W83781D_REG_TEMP_HYST);
+		data->temp_add[0] =3D
+		    w83781d_read_value(client, W83781D_REG_TEMP2);
+		data->temp_add_over[0] =3D
+		    w83781d_read_value(client, W83781D_REG_TEMP2_OVER);
+		data->temp_add_hyst[0] =3D
+		    w83781d_read_value(client, W83781D_REG_TEMP2_HYST);
+		if (data->type !=3D w83783s && data->type !=3D w83697hf) {
+			data->temp_add[1] =3D
+			    w83781d_read_value(client, W83781D_REG_TEMP3);
+			data->temp_add_over[1] =3D
+			    w83781d_read_value(client, W83781D_REG_TEMP3_OVER);
+			data->temp_add_hyst[1] =3D
+			    w83781d_read_value(client, W83781D_REG_TEMP3_HYST);
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
+		data->beeps =3D ((i & 0x7f) << 8) +
+		    w83781d_read_value(client, W83781D_REG_BEEP_INTS1);
+		if ((data->type !=3D w83781d) && (data->type !=3D as99127f)) {
+			data->beeps |=3D
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
+/* The next few functions are the call-back functions of the /proc/sys and
+   sysctl files. Which function is used is defined in the ctl_table in
+   the extra1 field.
+   Each function must return the magnitude (power of 10 to divide the date
+   with) if it is called with operation=3D=3DSENSORS_PROC_REAL_INFO. It mu=
st
+   put a maximum of *nrels elements in results reflecting the data of this
+   file, and set *nrels to the number it actually put in it, if operation=
=3D=3D
+   SENSORS_PROC_REAL_READ. Finally, it must get upto *nrels elements from
+   results and write them to the chip, if operations=3D=3DSENSORS_PROC_REA=
L_WRITE.
+   Note that on SENSORS_PROC_REAL_READ, I do not check whether results is
+   large enough (by checking the incoming value of *nrels). This is not ve=
ry
+   good practice, but as long as you put less than about 5 values in resul=
ts,
+   you can assume it is large enough. */
+static void
+w83781d_in(struct i2c_client *client, int operation, int ctl_name,
+	   int *nrels_mag, long *results)
+{
+	struct w83781d_data *data =3D i2c_get_clientdata(client);
+	int nr =3D ctl_name - W83781D_SYSCTL_IN0;
+
+	if (operation =3D=3D SENSORS_PROC_REAL_INFO)
+		*nrels_mag =3D 2;
+	else if (operation =3D=3D SENSORS_PROC_REAL_READ) {
+		w83781d_update_client(client);
+		results[0] =3D IN_FROM_REG(data->in_min[nr]);
+		results[1] =3D IN_FROM_REG(data->in_max[nr]);
+		results[2] =3D IN_FROM_REG(data->in[nr]);
+		*nrels_mag =3D 3;
+	} else if (operation =3D=3D SENSORS_PROC_REAL_WRITE) {
+		if (*nrels_mag >=3D 1) {
+			data->in_min[nr] =3D IN_TO_REG(results[0]);
+			w83781d_write_value(client, W83781D_REG_IN_MIN(nr),
+					    data->in_min[nr]);
+		}
+		if (*nrels_mag >=3D 2) {
+			data->in_max[nr] =3D IN_TO_REG(results[1]);
+			w83781d_write_value(client, W83781D_REG_IN_MAX(nr),
+					    data->in_max[nr]);
+		}
+	}
+}
+
+static void
+w83781d_fan(struct i2c_client *client, int operation, int ctl_name,
+	    int *nrels_mag, long *results)
+{
+	struct w83781d_data *data =3D i2c_get_clientdata(client);
+	int nr =3D ctl_name - W83781D_SYSCTL_FAN1 + 1;
+
+	if (operation =3D=3D SENSORS_PROC_REAL_INFO)
+		*nrels_mag =3D 0;
+	else if (operation =3D=3D SENSORS_PROC_REAL_READ) {
+		w83781d_update_client(client);
+		results[0] =3D FAN_FROM_REG(data->fan_min[nr - 1],
+					  DIV_FROM_REG(data->fan_div[nr - 1]));
+		results[1] =3D FAN_FROM_REG(data->fan[nr - 1],
+					  DIV_FROM_REG(data->fan_div[nr - 1]));
+		*nrels_mag =3D 2;
+	} else if (operation =3D=3D SENSORS_PROC_REAL_WRITE) {
+		if (*nrels_mag >=3D 1) {
+			data->fan_min[nr - 1] =3D
+			    FAN_TO_REG(results[0],
+				       DIV_FROM_REG(data->fan_div[nr - 1]));
+			w83781d_write_value(client,
+					    W83781D_REG_FAN_MIN(nr),
+					    data->fan_min[nr - 1]);
+		}
+	}
+}
+
+static void
+w83781d_temp(struct i2c_client *client, int operation, int ctl_name,
+	     int *nrels_mag, long *results)
+{
+	struct w83781d_data *data =3D i2c_get_clientdata(client);
+	if (operation =3D=3D SENSORS_PROC_REAL_INFO)
+		*nrels_mag =3D 1;
+	else if (operation =3D=3D SENSORS_PROC_REAL_READ) {
+		w83781d_update_client(client);
+		results[0] =3D TEMP_FROM_REG(data->temp_over);
+		results[1] =3D TEMP_FROM_REG(data->temp_hyst);
+		results[2] =3D TEMP_FROM_REG(data->temp);
+		*nrels_mag =3D 3;
+	} else if (operation =3D=3D SENSORS_PROC_REAL_WRITE) {
+		if (*nrels_mag >=3D 1) {
+			data->temp_over =3D TEMP_TO_REG(results[0]);
+			w83781d_write_value(client, W83781D_REG_TEMP_OVER,
+					    data->temp_over);
+		}
+		if (*nrels_mag >=3D 2) {
+			data->temp_hyst =3D TEMP_TO_REG(results[1]);
+			w83781d_write_value(client, W83781D_REG_TEMP_HYST,
+					    data->temp_hyst);
+		}
+	}
+}
+
+static void
+w83781d_temp_add(struct i2c_client *client, int operation,
+		 int ctl_name, int *nrels_mag, long *results)
+{
+	struct w83781d_data *data =3D i2c_get_clientdata(client);
+	int nr =3D ctl_name - W83781D_SYSCTL_TEMP2;
+
+	if (operation =3D=3D SENSORS_PROC_REAL_INFO)
+		*nrels_mag =3D 1;
+	else if (operation =3D=3D SENSORS_PROC_REAL_READ) {
+		w83781d_update_client(client);
+		if (data->type =3D=3D as99127f) {
+			results[0] =3D
+			    AS99127_TEMP_ADD_FROM_REG(data->temp_add_over[nr]);
+			results[1] =3D
+			    AS99127_TEMP_ADD_FROM_REG(data->temp_add_hyst[nr]);
+			results[2] =3D
+			    AS99127_TEMP_ADD_FROM_REG(data->temp_add[nr]);
+		} else {
+			results[0] =3D TEMP_ADD_FROM_REG(data->temp_add_over[nr]);
+			results[1] =3D TEMP_ADD_FROM_REG(data->temp_add_hyst[nr]);
+			results[2] =3D TEMP_ADD_FROM_REG(data->temp_add[nr]);
+		}
+		*nrels_mag =3D 3;
+	} else if (operation =3D=3D SENSORS_PROC_REAL_WRITE) {
+		if (*nrels_mag >=3D 1) {
+			if (data->type =3D=3D as99127f)
+				data->temp_add_over[nr] =3D
+				    AS99127_TEMP_ADD_TO_REG(results[0]);
+			else
+				data->temp_add_over[nr] =3D
+				    TEMP_ADD_TO_REG(results[0]);
+			w83781d_write_value(client,
+					    nr ? W83781D_REG_TEMP3_OVER :
+					    W83781D_REG_TEMP2_OVER,
+					    data->temp_add_over[nr]);
+		}
+		if (*nrels_mag >=3D 2) {
+			if (data->type =3D=3D as99127f)
+				data->temp_add_hyst[nr] =3D
+				    AS99127_TEMP_ADD_TO_REG(results[1]);
+			else
+				data->temp_add_hyst[nr] =3D
+				    TEMP_ADD_TO_REG(results[1]);
+			w83781d_write_value(client,
+					    nr ? W83781D_REG_TEMP3_HYST :
+					    W83781D_REG_TEMP2_HYST,
+					    data->temp_add_hyst[nr]);
+		}
+	}
+}
+
+static void
+w83781d_vid(struct i2c_client *client, int operation, int ctl_name,
+	    int *nrels_mag, long *results)
+{
+	struct w83781d_data *data =3D i2c_get_clientdata(client);
+	if (operation =3D=3D SENSORS_PROC_REAL_INFO)
+		*nrels_mag =3D 3;
+	else if (operation =3D=3D SENSORS_PROC_REAL_READ) {
+		w83781d_update_client(client);
+		results[0] =3D vid_from_reg(data->vid, data->vrm);
+		*nrels_mag =3D 1;
+	}
+}
+
+static void
+w83781d_vrm(struct i2c_client *client, int operation, int ctl_name,
+	    int *nrels_mag, long *results)
+{
+	struct w83781d_data *data =3D i2c_get_clientdata(client);
+	if (operation =3D=3D SENSORS_PROC_REAL_INFO)
+		*nrels_mag =3D 1;
+	else if (operation =3D=3D SENSORS_PROC_REAL_READ) {
+		results[0] =3D data->vrm;
+		*nrels_mag =3D 1;
+	} else if (operation =3D=3D SENSORS_PROC_REAL_WRITE) {
+		if (*nrels_mag >=3D 1)
+			data->vrm =3D results[0];
+	}
+}
+
+static void
+w83781d_alarms(struct i2c_client *client, int operation, int ctl_name,
+	       int *nrels_mag, long *results)
+{
+	struct w83781d_data *data =3D i2c_get_clientdata(client);
+	if (operation =3D=3D SENSORS_PROC_REAL_INFO)
+		*nrels_mag =3D 0;
+	else if (operation =3D=3D SENSORS_PROC_REAL_READ) {
+		w83781d_update_client(client);
+		results[0] =3D ALARMS_FROM_REG(data->alarms);
+		*nrels_mag =3D 1;
+	}
+}
+
+static void
+w83781d_beep(struct i2c_client *client, int operation, int ctl_name,
+	     int *nrels_mag, long *results)
+{
+	struct w83781d_data *data =3D i2c_get_clientdata(client);
+	int val;
+
+	if (operation =3D=3D SENSORS_PROC_REAL_INFO)
+		*nrels_mag =3D 0;
+	else if (operation =3D=3D SENSORS_PROC_REAL_READ) {
+		w83781d_update_client(client);
+		results[0] =3D BEEP_ENABLE_FROM_REG(data->beep_enable);
+		results[1] =3D BEEPS_FROM_REG(data->beeps);
+		*nrels_mag =3D 2;
+	} else if (operation =3D=3D SENSORS_PROC_REAL_WRITE) {
+		if (*nrels_mag >=3D 2) {
+			data->beeps =3D BEEPS_TO_REG(results[1]);
+			w83781d_write_value(client, W83781D_REG_BEEP_INTS1,
+					    data->beeps & 0xff);
+			if ((data->type !=3D w83781d) && (data->type !=3D as99127f)) {
+				w83781d_write_value(client,
+						    W83781D_REG_BEEP_INTS3,
+						    ((data->beeps) >> 16) &
+						    0xff);
+			}
+			val =3D (data->beeps >> 8) & 0x7f;
+		} else if (*nrels_mag >=3D 1)
+			val =3D
+			    w83781d_read_value(client,
+					       W83781D_REG_BEEP_INTS2) & 0x7f;
+		if (*nrels_mag >=3D 1) {
+			data->beep_enable =3D BEEP_ENABLE_TO_REG(results[0]);
+			w83781d_write_value(client, W83781D_REG_BEEP_INTS2,
+					    val | data->beep_enable << 7);
+		}
+	}
+}
+
+/* w83697hf only has two fans */
+static void
+w83781d_fan_div(struct i2c_client *client, int operation,
+		int ctl_name, int *nrels_mag, long *results)
+{
+	struct w83781d_data *data =3D i2c_get_clientdata(client);
+	int old, old2, old3 =3D 0;
+
+	if (operation =3D=3D SENSORS_PROC_REAL_INFO)
+		*nrels_mag =3D 0;
+	else if (operation =3D=3D SENSORS_PROC_REAL_READ) {
+		w83781d_update_client(client);
+		results[0] =3D DIV_FROM_REG(data->fan_div[0]);
+		results[1] =3D DIV_FROM_REG(data->fan_div[1]);
+		if (data->type =3D=3D w83697hf) {
+			*nrels_mag =3D 2;
+		} else {
+			results[2] =3D DIV_FROM_REG(data->fan_div[2]);
+			*nrels_mag =3D 3;
+		}
+	} else if (operation =3D=3D SENSORS_PROC_REAL_WRITE) {
+		old =3D w83781d_read_value(client, W83781D_REG_VID_FANDIV);
+		/* w83781d and as99127f don't have extended divisor bits */
+		if ((data->type !=3D w83781d) && data->type !=3D as99127f) {
+			old3 =3D w83781d_read_value(client, W83781D_REG_VBAT);
+		}
+		if (*nrels_mag >=3D 3 && data->type !=3D w83697hf) {
+			data->fan_div[2] =3D DIV_TO_REG(results[2], data->type);
+			old2 =3D w83781d_read_value(client, W83781D_REG_PIN);
+			old2 =3D (old2 & 0x3f) | ((data->fan_div[2] & 0x03) << 6);
+			w83781d_write_value(client, W83781D_REG_PIN, old2);
+			if ((data->type !=3D w83781d) && (data->type !=3D as99127f)) {
+				old3 =3D
+				    (old3 & 0x7f) |
+				    ((data->fan_div[2] & 0x04) << 5);
+			}
+		}
+		if (*nrels_mag >=3D 2) {
+			data->fan_div[1] =3D DIV_TO_REG(results[1], data->type);
+			old =3D (old & 0x3f) | ((data->fan_div[1] & 0x03) << 6);
+			if ((data->type !=3D w83781d) && (data->type !=3D as99127f)) {
+				old3 =3D
+				    (old3 & 0xbf) |
+				    ((data->fan_div[1] & 0x04) << 4);
+			}
+		}
+		if (*nrels_mag >=3D 1) {
+			data->fan_div[0] =3D DIV_TO_REG(results[0], data->type);
+			old =3D (old & 0xcf) | ((data->fan_div[0] & 0x03) << 4);
+			w83781d_write_value(client, W83781D_REG_VID_FANDIV,
+					    old);
+			if ((data->type !=3D w83781d) && (data->type !=3D as99127f)) {
+				old3 =3D
+				    (old3 & 0xdf) |
+				    ((data->fan_div[0] & 0x04) << 3);
+				w83781d_write_value(client,
+						    W83781D_REG_VBAT, old3);
+			}
+		}
+	}
+}
+
+static void
+w83781d_pwm(struct i2c_client *client, int operation, int ctl_name,
+	    int *nrels_mag, long *results)
+{
+	struct w83781d_data *data =3D i2c_get_clientdata(client);
+	int nr =3D 1 + ctl_name - W83781D_SYSCTL_PWM1;
+	int j, k;
+
+	if (operation =3D=3D SENSORS_PROC_REAL_INFO)
+		*nrels_mag =3D 0;
+	else if (operation =3D=3D SENSORS_PROC_REAL_READ) {
+		w83781d_update_client(client);
+		results[0] =3D PWM_FROM_REG(data->pwm[nr - 1]);
+		results[1] =3D data->pwmenable[nr - 1];
+		*nrels_mag =3D 2;
+	} else if (operation =3D=3D SENSORS_PROC_REAL_WRITE) {
+		if (*nrels_mag >=3D 1) {
+			data->pwm[nr - 1] =3D PWM_TO_REG(results[0]);
+			w83781d_write_value(client, W83781D_REG_PWM(nr),
+					    data->pwm[nr - 1]);
+		}
+		/* only PWM2 can be enabled/disabled */
+		if (*nrels_mag >=3D 2 && nr =3D=3D 2) {
+			j =3D w83781d_read_value(client, W83781D_REG_PWMCLK12);
+			k =3D w83781d_read_value(client, W83781D_REG_BEEP_CONFIG);
+			if (results[1]) {
+				if (!(j & 0x08))
+					w83781d_write_value(client,
+							    W83781D_REG_PWMCLK12,
+							    j | 0x08);
+				if (k & 0x10)
+					w83781d_write_value(client,
+							    W83781D_REG_BEEP_CONFIG,
+							    k & 0xef);
+				data->pwmenable[1] =3D 1;
+			} else {
+				if (j & 0x08)
+					w83781d_write_value(client,
+							    W83781D_REG_PWMCLK12,
+							    j & 0xf7);
+				if (!(k & 0x10))
+					w83781d_write_value(client,
+							    W83781D_REG_BEEP_CONFIG,
+							    j | 0x10);
+				data->pwmenable[1] =3D 0;
+			}
+		}
+	}
+}
+
+static void
+w83781d_sens(struct i2c_client *client, int operation, int ctl_name,
+	     int *nrels_mag, long *results)
+{
+	struct w83781d_data *data =3D i2c_get_clientdata(client);
+	int nr =3D 1 + ctl_name - W83781D_SYSCTL_SENS1;
+	u8 tmp;
+
+	if (operation =3D=3D SENSORS_PROC_REAL_INFO)
+		*nrels_mag =3D 0;
+	else if (operation =3D=3D SENSORS_PROC_REAL_READ) {
+		results[0] =3D data->sens[nr - 1];
+		*nrels_mag =3D 1;
+	} else if (operation =3D=3D SENSORS_PROC_REAL_WRITE) {
+		if (*nrels_mag >=3D 1) {
+			switch (results[0]) {
+			case 1:	/* PII/Celeron diode */
+				tmp =3D w83781d_read_value(client,
+							 W83781D_REG_SCFG1);
+				w83781d_write_value(client,
+						    W83781D_REG_SCFG1,
+						    tmp | BIT_SCFG1[nr - 1]);
+				tmp =3D w83781d_read_value(client,
+							 W83781D_REG_SCFG2);
+				w83781d_write_value(client,
+						    W83781D_REG_SCFG2,
+						    tmp | BIT_SCFG2[nr - 1]);
+				data->sens[nr - 1] =3D results[0];
+				break;
+			case 2:	/* 3904 */
+				tmp =3D w83781d_read_value(client,
+							 W83781D_REG_SCFG1);
+				w83781d_write_value(client,
+						    W83781D_REG_SCFG1,
+						    tmp | BIT_SCFG1[nr - 1]);
+				tmp =3D w83781d_read_value(client,
+							 W83781D_REG_SCFG2);
+				w83781d_write_value(client,
+						    W83781D_REG_SCFG2,
+						    tmp & ~BIT_SCFG2[nr - 1]);
+				data->sens[nr - 1] =3D results[0];
+				break;
+			case W83781D_DEFAULT_BETA:	/* thermistor */
+				tmp =3D w83781d_read_value(client,
+							 W83781D_REG_SCFG1);
+				w83781d_write_value(client,
+						    W83781D_REG_SCFG1,
+						    tmp & ~BIT_SCFG1[nr - 1]);
+				data->sens[nr - 1] =3D results[0];
+				break;
+			default:
+				printk(KERN_ERR
+				       "Invalid sensor type %ld; must be 1, 2, or %d\n",
+				       results[0], W83781D_DEFAULT_BETA);
+				break;
+			}
+		}
+	}
+}
+
+#ifdef W83781D_RT
+static void
+w83781d_rt(struct i2c_client *client, int operation, int ctl_name,
+	   int *nrels_mag, long *results)
+{
+	struct w83781d_data *data =3D i2c_get_clientdata(client);
+	int nr =3D 1 + ctl_name - W83781D_SYSCTL_RT1;
+	int i;
+
+	if (operation =3D=3D SENSORS_PROC_REAL_INFO)
+		*nrels_mag =3D 0;
+	else if (operation =3D=3D SENSORS_PROC_REAL_READ) {
+		for (i =3D 0; i < 32; i++) {
+			results[i] =3D data->rt[nr - 1][i];
+		}
+		*nrels_mag =3D 32;
+	} else if (operation =3D=3D SENSORS_PROC_REAL_WRITE) {
+		if (*nrels_mag > 32)
+			*nrels_mag =3D 32;
+		for (i =3D 0; i < *nrels_mag; i++) {
+			/* fixme: no bounds checking 0-255 */
+			data->rt[nr - 1][i] =3D results[i];
+			w83781d_write_value(client, W83781D_REG_RT_IDX, i);
+			w83781d_write_value(client, W83781D_REG_RT_VAL,
+					    data->rt[nr - 1][i]);
+		}
+	}
+}
+#endif
+
+static int __init sensors_w83781d_init(void)
+{
+	return i2c_add_driver(&w83781d_driver);
+}
+
+static void __exit sensors_w83781d_exit(void)
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

--=-zCbyfS/Mzc/bn5zLWz+1--

--=-Ew4QMLdaDV8jPbXAw5a5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+gfnBqburzKaJYLYRAo4RAJ0b75J3Y7GfwLmqLyXUKpj1/T5VbQCeMN4M
Mpqxd8xyA1QdhEeUXHV6h3c=
=AZTC
-----END PGP SIGNATURE-----

--=-Ew4QMLdaDV8jPbXAw5a5--

