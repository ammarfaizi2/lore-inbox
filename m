Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318792AbSH1Ls3>; Wed, 28 Aug 2002 07:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318796AbSH1Ls3>; Wed, 28 Aug 2002 07:48:29 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:49797 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S318792AbSH1LqA>; Wed, 28 Aug 2002 07:46:00 -0400
Date: Wed, 28 Aug 2002 13:47:09 +0200
From: Dominik Brodowski <devel@brodo.de>
To: torvalds@transmeta.com
Cc: cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [PATCH][2.5.32] CPUfreq i386 drivers (3/4)
Message-ID: <20020828134709.D19189@brodo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zbGR4y+acU1DwHSi"
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zbGR4y+acU1DwHSi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

CPUFreq i386 drivers for 2.5.32:
arch/i386/config.in				Necessary config
	options
arch/i386/kernel/cpu/Makefile			allow for compilation=20
	of the CPUFreq subdirectory
arch/i386/kernel/cpu/cpufreq/Makefile		Makefile for CPUFreq drivers
arch/i386/kernel/cpu/cpufreq/elanfreq.c		CPUFreq driver for AMD Elan
	processors
arch/i386/kernel/cpu/cpufreq/longhaul.c		CPUFreq driver for VIA
	Longhaul processors
arch/i386/kernel/cpu/cpufreq/powernow-k6.c	CPUFreq driver for mobile
	AMD K6-2+ and mobile AMD K6-3+ processors
arch/i386/kernel/cpu/cpufreq/speedstep.c	CPUFreq drivers for ICH2-M
	and ICH3-M chipsets and Intel Pentium 3-M and 4-M processors.



diff -ruN linux-2531orig/arch/i386/config.in linux/arch/i386/config.in
--- linux-2531orig/arch/i386/config.in	Wed Aug 28 10:06:00 2002
+++ linux/arch/i386/config.in	Wed Aug 28 10:46:27 2002
@@ -173,6 +173,15 @@
 dep_bool 'Check for non-fatal errors on Athlon/Duron' CONFIG_X86_MCE_NONFA=
TAL $CONFIG_X86_MCE
 dep_bool 'check for P4 thermal throttling interrupt.' CONFIG_X86_MCE_P4THE=
RMAL $CONFIG_X86_MCE $CONFIG_X86_UP_APIC
=20
+bool 'CPU Frequency scaling' CONFIG_CPU_FREQ
+if [ "$CONFIG_CPU_FREQ" !=3D "n" ]; then
+   tristate ' AMD Mobile K6-2/K6-3 PowerNow!' CONFIG_X86_POWERNOW_K6
+   if [ "$CONFIG_MELAN" =3D "y" ]; then
+       tristate ' AMD Elan' CONFIG_ELAN_CPUFREQ
+   fi
+   tristate ' VIA Cyrix III Longhaul' CONFIG_X86_LONGHAUL
+   tristate ' Intel Speedstep' CONFIG_X86_SPEEDSTEP
+fi
=20
 tristate 'Toshiba Laptop support' CONFIG_TOSHIBA
 tristate 'Dell laptop support' CONFIG_I8K
diff -ruN linux-2531orig/arch/i386/kernel/cpu/Makefile linux/arch/i386/kern=
el/cpu/Makefile
--- linux-2531orig/arch/i386/kernel/cpu/Makefile	Wed Aug 28 10:06:00 2002
+++ linux/arch/i386/kernel/cpu/Makefile	Wed Aug 28 10:49:07 2002
@@ -15,4 +15,10 @@
=20
 obj-$(CONFIG_MTRR)	+=3D mtrr/
=20
+ifdef CONFIG_CPU_FREQ
+subdir-y   +=3D cpufreq
+subdir-m   +=3D cpufreq
+obj-y   +=3D cpufreq/cpufreq.o
+endif
+
 include $(TOPDIR)/Rules.make
diff -ruN linux-2531orig/arch/i386/kernel/cpu/cpufreq/Makefile linux/arch/i=
386/kernel/cpu/cpufreq/Makefile
--- linux-2531orig/arch/i386/kernel/cpu/cpufreq/Makefile	Thu Jan  1 01:00:0=
0 1970
+++ linux/arch/i386/kernel/cpu/cpufreq/Makefile	Wed Aug 28 10:52:08 2002
@@ -0,0 +1,8 @@
+O_TARGET :=3D cpufreq.o
+
+obj-$(CONFIG_X86_POWERNOW_K6)	+=3D powernow-k6.o
+obj-$(CONFIG_X86_LONGHAUL)	+=3D longhaul.o
+obj-$(CONFIG_X86_SPEEDSTEP)	+=3D speedstep.o
+obj-$(CONFIG_ELAN_CPUFREQ)	+=3D elanfreq.o
+
+include $(TOPDIR)/Rules.make
diff -ruN linux-2531orig/arch/i386/kernel/cpu/cpufreq/elanfreq.c linux/arch=
/i386/kernel/cpu/cpufreq/elanfreq.c
--- linux-2531orig/arch/i386/kernel/cpu/cpufreq/elanfreq.c	Thu Jan  1 01:00=
:00 1970
+++ linux/arch/i386/kernel/cpu/cpufreq/elanfreq.c	Wed Aug 28 10:51:46 2002
@@ -0,0 +1,257 @@
+/*
+ * 	elanfreq: 	cpufreq driver for the AMD ELAN family
+ *
+ *	(c) Copyright 2002 Robert Schwebel <r.schwebel@pengutronix.de>
+ *
+ *	Parts of this code are (c) Sven Geggus <sven@geggus.net>=20
+ *
+ *      All Rights Reserved.=20
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.=20
+ *
+ *	2002-02-13: - initial revision for 2.4.18-pre9 by Robert Schwebel
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+
+#include <linux/cpufreq.h>
+
+#include <linux/sched.h>
+#include <linux/init.h>
+#include <asm/msr.h>
+#include <asm/timex.h>
+#include <asm/io.h>
+#include <linux/delay.h>
+
+#define REG_CSCIR 0x22 		/* Chip Setup and Control Index Register    */
+#define REG_CSCDR 0x23		/* Chip Setup and Control Data  Register    */
+
+#define SAFE_FREQ 33000		/* every Elan CPU can run at 33 MHz         */
+
+static int currentspeed; 	/* current frequency in kHz                 */
+static struct cpufreq_driver *elanfreq_driver;
+
+MODULE_LICENSE("GPL");
+
+MODULE_AUTHOR(
+  "Robert Schwebel <r.schwebel@pengutronix.de>, Sven Geggus <sven@geggus.n=
et>"
+);
+MODULE_DESCRIPTION("cpufreq driver for AMD's Elan CPUs");
+
+struct s_elan_multiplier {
+	int clock;		/* frequency in kHz                         */
+	int val40h;		/* PMU Force Mode register                  */
+	int val80h;		/* CPU Clock Speed Register                 */
+};
+
+/*
+ * It is important that the frequencies=20
+ * are listed in ascending order here!
+ */
+struct s_elan_multiplier elan_multiplier[] =3D {
+	{1000,	0x02,	0x18},
+	{2000,	0x02,	0x10},
+	{4000,	0x02,	0x08},
+	{8000,	0x00,	0x00},
+	{16000,	0x00,	0x02},
+	{33000,	0x00,	0x04},
+	{66000,	0x01,	0x04},
+	{99000,	0x01,	0x05}
+};
+
+
+/**
+ *	elanfreq_get_cpu_frequency: determine current cpu speed
+ *
+ *	Finds out at which frequency the CPU of the Elan SOC runs
+ *	at the moment. Frequencies from 1 to 33 MHz are generated=20
+ *	the normal way, 66 and 99 MHz are called "Hyperspeed Mode"
+ *	and have the rest of the chip running with 33 MHz.=20
+ */
+
+static unsigned int elanfreq_get_cpu_frequency(void)
+{
+        u8 clockspeed_reg;    /* Clock Speed Register */
+=09
+        cli();
+        outb_p(0x80,REG_CSCIR);
+        clockspeed_reg =3D inb_p(REG_CSCDR);
+        sti();
+
+        if ((clockspeed_reg & 0xE0) =3D=3D 0xE0) { return 0; }
+
+        /* Are we in CPU clock multiplied mode (66/99 MHz)? */
+        if ((clockspeed_reg & 0xE0) =3D=3D 0xC0) {
+                if ((clockspeed_reg & 0x01) =3D=3D 0) {
+			return 66000;
+		} else {
+			return 99000;            =20
+		}
+        }
+
+	/* 33 MHz is not 32 MHz... */
+	if ((clockspeed_reg & 0xE0)=3D=3D0xA0)
+		return 33000;
+
+        return ((1<<((clockspeed_reg & 0xE0) >> 5)) * 1000);
+}
+
+
+/**
+ *      elanfreq_set_cpu_frequency: Change the CPU core frequency
+ * 	@cpu: cpu number
+ *	@freq: frequency in kHz
+ *
+ *      This function takes a frequency value and changes the CPU frequenc=
y=20
+ *	according to this. Note that the frequency has to be checked by
+ *	elanfreq_validatespeed() for correctness!
+ *=09
+ *	There is no return value.=20
+ */
+
+static void elanfreq_set_cpu_frequency (unsigned int cpu, unsigned int fre=
q) {
+
+	int i;
+
+	if (cpu && (cpu !=3D CPUFREQ_ALL_CPUS))
+		return;
+
+	printk(KERN_INFO "elanfreq: attempting to set frequency to %i kHz\n",freq=
);
+
+	/* search table entry for given Mhz value */
+	for (i=3D0; i<(sizeof(elan_multiplier)/sizeof(struct s_elan_multiplier));=
 i++)=20
+	{
+		if (elan_multiplier[i].clock=3D=3Dfreq) break;
+	}
+
+	/* XXX Shouldn't we have a sanity check here or can we rely on=20
+           the frequency having been checked before ??? */
+
+	/*=20
+	 * Access to the Elan's internal registers is indexed via   =20
+	 * 0x22: Chip Setup & Control Register Index Register (CSCI)=20
+	 * 0x23: Chip Setup & Control Register Data  Register (CSCD)=20
+	 *
+	 */
+
+	/*=20
+	 * 0x40 is the Power Management Unit's Force Mode Register.=20
+	 * Bit 6 enables Hyperspeed Mode (66/100 MHz core frequency)
+	 */
+
+	cli();
+	outb_p(0x40,REG_CSCIR); 	/* Disable hyperspeed mode          */
+	outb_p(0x00,REG_CSCDR);
+	sti();				/* wait till internal pipelines and */
+	udelay(1000);			/* buffers have cleaned up          */
+
+	cli();
+
+	/* now, set the CPU clock speed register (0x80) */
+	outb_p(0x80,REG_CSCIR);
+	outb_p(elan_multiplier[i].val80h,REG_CSCDR);
+
+	/* now, the hyperspeed bit in PMU Force Mode Register (0x40) */
+	outb_p(0x40,REG_CSCIR);
+	outb_p(elan_multiplier[i].val40h,REG_CSCDR);
+	udelay(10000);
+	sti();
+
+	currentspeed=3Dfreq;
+
+};
+
+
+/**
+ *	elanfreq_validatespeed: test if frequency is valid=20
+ *	@cpu: cpu number
+ *	@freq: frequency in kHz
+ *
+ *	This function checks if a given frequency in kHz is valid for the=20
+ *	hardware supported by the driver. It returns a "best fit" frequency
+ * 	which might be different from the given one.=20
+ */
+
+static unsigned int elanfreq_validatespeed (unsigned int cpu, unsigned int=
 freq)
+{
+	unsigned int best =3D 0;
+	int i;
+=09
+	if (cpu && (cpu !=3D CPUFREQ_ALL_CPUS))
+		return 0;
+
+	for (i=3D(sizeof(elan_multiplier)/sizeof(struct s_elan_multiplier) - 1); =
i>=3D0; i++)
+	{
+		if (freq < elan_multiplier[i].clock)
+		{
+			best =3D elan_multiplier[i].clock;
+		=09
+		}
+	}=20
+
+	return best;
+}
+
+
+
+/*
+ *	Module init and exit code
+ */
+
+static int __init elanfreq_init(void)=20
+{=09
+	struct cpuinfo_x86 *c =3D cpu_data;
+	struct cpufreq_driver *driver;
+	int ret;
+
+	/* Test if we have the right hardware */
+	if ((c->x86_vendor !=3D X86_VENDOR_AMD) ||
+		(c->x86 !=3D 4) || (c->x86_model!=3D10))
+	{
+		printk(KERN_INFO "elanfreq: error: no Elan processor found!\n");
+                return -ENODEV;
+	}
+=09
+	driver =3D kmalloc(sizeof(struct cpufreq_driver) +
+			 sizeof(struct cpufreq_freqs), GFP_KERNEL);
+	if (!driver)
+		return -ENOMEM;
+	=09
+	driver->freq =3D (struct cpufreq_freqs*) (driver + sizeof(struct cpufreq_=
driver));
+	=09
+	driver->sync =3D CPUFREQ_SYNC;
+	driver->freq->cpu =3D CPUFREQ_ALL_CPUS;
+	driver->freq->cur =3D elanfreq_get_cpu_frequency();
+	driver->validate =3D &elanfreq_validatespeed;
+	driver->setspeed =3D &elanfreq_set_cpu_frequency;
+
+	ret =3D cpufreq_register(driver);
+	if (ret) {
+		kfree(driver);
+		return ret;
+	}
+
+	elanfreq_driver =3D driver;
+
+	return 0;
+}
+
+
+static void __exit elanfreq_exit(void)=20
+{
+	if (elanfreq_driver) {
+		cpufreq_unregister();
+		kfree(elanfreq_driver);
+	}
+}
+
+module_init(elanfreq_init);
+module_exit(elanfreq_exit);
+
diff -ruN linux-2531orig/arch/i386/kernel/cpu/cpufreq/longhaul.c linux/arch=
/i386/kernel/cpu/cpufreq/longhaul.c
--- linux-2531orig/arch/i386/kernel/cpu/cpufreq/longhaul.c	Thu Jan  1 01:00=
:00 1970
+++ linux/arch/i386/kernel/cpu/cpufreq/longhaul.c	Wed Aug 28 10:51:46 2002
@@ -0,0 +1,700 @@
+/*
+ *  $Id: longhaul.c,v 1.66 2002/08/28 10:59:46 db Exp $
+ *
+ *  (C) 2001  Dave Jones. <davej@suse.de>
+ *  (C) 2002  Padraig Brady. <padraig@antefacto.com>
+ *
+ *  Licensed under the terms of the GNU GPL License version 2.
+ *  Based upon datasheets & sample CPUs kindly provided by VIA.
+ *
+ *  VIA have currently 3 different versions of Longhaul.
+ *
+ *  +---------------------+----------+---------------------------------+
+ *  | Marketing name      | Codename | longhaul version / features.    |
+ *  +---------------------+----------+---------------------------------+
+ *  |  Samuel/CyrixIII    |   C5A    | v1 : multipliers only           |
+ *  |  Samuel2/C3         | C3E/C5B  | v1 : multiplier only            |
+ *  |  Ezra               |   C5C    | v2 : multipliers & voltage      |
+ *  |  Ezra-T             | C5M/C5N  | v3 : multipliers, voltage & FSB |
+ *  +---------------------+----------+---------------------------------+
+ *
+ *  BIG FAT DISCLAIMER: Work in progress code. Possibly *dangerous*
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>=20
+#include <linux/sched.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/proc_fs.h>
+#include <linux/cpufreq.h>
+#include <linux/slab.h>
+
+#include <asm/msr.h>
+#include <asm/timex.h>
+#include <asm/io.h>
+
+#define DEBUG
+
+#ifdef DEBUG
+#define dprintk(msg...) printk(msg)
+#else
+#define dprintk(msg...) do { } while(0);
+#endif
+
+static int numscales=3D16, numvscales;
+static int minvid, maxvid;
+static int can_scale_voltage;
+static int can_scale_fsb;
+static int vrmrev;
+
+
+/* Module parameters */
+static int dont_scale_voltage;
+static int dont_scale_fsb;
+static int current_fsb;
+static int favour_fast_fsb;
+
+#define __hlt()     __asm__ __volatile__("hlt": : :"memory")
+
+/*
+ * Clock ratio tables.
+ * The eblcr ones specify the ratio read from the CPU.
+ * The clock_ratio ones specify what to write to the CPU.
+ */
+
+/* VIA C3 Samuel 1  & Samuel 2 (stepping 0)*/
+static int __initdata longhaul1_clock_ratio[16] =3D {
+	-1, /* 0000 -> RESERVED */
+	30, /* 0001 ->  3.0x */
+	40, /* 0010 ->  4.0x */
+	-1, /* 0011 -> RESERVED */
+	-1, /* 0100 -> RESERVED */
+	35, /* 0101 ->  3.5x */
+	45, /* 0110 ->  4.5x */
+	55, /* 0111 ->  5.5x */
+	60, /* 1000 ->  6.0x */
+	70, /* 1001 ->  7.0x */
+	80, /* 1010 ->  8.0x */
+	50, /* 1011 ->  5.0x */
+	65, /* 1100 ->  6.5x */
+	75, /* 1101 ->  7.5x */
+	-1, /* 1110 -> RESERVED */
+	-1, /* 1111 -> RESERVED */
+};
+
+static int __initdata samuel1_eblcr[16] =3D {
+	50, /* 0000 -> RESERVED */
+	30, /* 0001 ->  3.0x */
+	40, /* 0010 ->  4.0x */
+	-1, /* 0011 -> RESERVED */
+	55, /* 0100 ->  5.5x */
+	35, /* 0101 ->  3.5x */
+	45, /* 0110 ->  4.5x */
+	-1, /* 0111 -> RESERVED */
+	-1, /* 1000 -> RESERVED */
+	70, /* 1001 ->  7.0x */
+	80, /* 1010 ->  8.0x */
+	60, /* 1011 ->  6.0x */
+	-1, /* 1100 -> RESERVED */
+	75, /* 1101 ->  7.5x */
+	-1, /* 1110 -> RESERVED */
+	65, /* 1111 ->  6.5x */
+};
+
+/* VIA C3 Samuel2 Stepping 1->15 & VIA C3 Ezra */
+static int __initdata longhaul2_clock_ratio[16] =3D {
+	100, /* 0000 -> 10.0x */
+	30,  /* 0001 ->  3.0x */
+	40,  /* 0010 ->  4.0x */
+	90,  /* 0011 ->  9.0x */
+	95,  /* 0100 ->  9.5x */
+	35,  /* 0101 ->  3.5x */
+	45,  /* 0110 ->  4.5x */
+	55,  /* 0111 ->  5.5x */
+	60,  /* 1000 ->  6.0x */
+	70,  /* 1001 ->  7.0x */
+	80,  /* 1010 ->  8.0x */
+	50,  /* 1011 ->  5.0x */
+	65,  /* 1100 ->  6.5x */
+	75,  /* 1101 ->  7.5x */
+	85,  /* 1110 ->  8.5x */
+	120, /* 1111 -> 12.0x */
+};
+
+static int __initdata samuel2_eblcr[16] =3D {
+	50,  /* 0000 ->  5.0x */
+	30,  /* 0001 ->  3.0x */
+	40,  /* 0010 ->  4.0x */
+	100, /* 0011 -> 10.0x */
+	55,  /* 0100 ->  5.5x */
+	35,  /* 0101 ->  3.5x */
+	45,  /* 0110 ->  4.5x */
+	110, /* 0111 -> 11.0x */
+	90,  /* 1000 ->  9.0x */
+	70,  /* 1001 ->  7.0x */
+	80,  /* 1010 ->  8.0x */
+	60,  /* 1011 ->  6.0x */
+	120, /* 1100 -> 12.0x */
+	75,  /* 1101 ->  7.5x */
+	130, /* 1110 -> 13.0x */
+	65,  /* 1111 ->  6.5x */
+};
+
+static int __initdata ezra_eblcr[16] =3D {
+	50,  /* 0000 ->  5.0x */
+	30,  /* 0001 ->  3.0x */
+	40,  /* 0010 ->  4.0x */
+	100, /* 0011 -> 10.0x */
+	55,  /* 0100 ->  5.5x */
+	35,  /* 0101 ->  3.5x */
+	45,  /* 0110 ->  4.5x */
+	95,  /* 0111 ->  9.5x */
+	90,  /* 1000 ->  9.0x */
+	70,  /* 1001 ->  7.0x */
+	80,  /* 1010 ->  8.0x */
+	60,  /* 1011 ->  6.0x */
+	120, /* 1100 -> 12.0x */
+	75,  /* 1101 ->  7.5x */
+	85,  /* 1110 ->  8.5x */
+	65,  /* 1111 ->  6.5x */
+};
+
+/* VIA C5M. */
+static int __initdata longhaul3_clock_ratio[32] =3D {
+	100, /* 0000 -> 10.0x */
+	30,  /* 0001 ->  3.0x */
+	40,  /* 0010 ->  4.0x */
+	90,  /* 0011 ->  9.0x */
+	95,  /* 0100 ->  9.5x */
+	35,  /* 0101 ->  3.5x */
+	45,  /* 0110 ->  4.5x */
+	55,  /* 0111 ->  5.5x */
+	60,  /* 1000 ->  6.0x */
+	70,  /* 1001 ->  7.0x */
+	80,  /* 1010 ->  8.0x */
+	50,  /* 1011 ->  5.0x */
+	65,  /* 1100 ->  6.5x */
+	75,  /* 1101 ->  7.5x */
+	85,  /* 1110 ->  8.5x */
+	120, /* 1111 ->  12.0x */
+
+	-1,  /* 0000 -> RESERVED (10.0x) */
+	110, /* 0001 -> 11.0x */
+	120, /* 0010 -> 12.0x */
+	-1,  /* 0011 -> RESERVED (9.0x)*/
+	105, /* 0100 -> 10.5x */
+	115, /* 0101 -> 11.5x */
+	125, /* 0110 -> 12.5x */
+	135, /* 0111 -> 13.5x */
+	140, /* 1000 -> 14.0x */
+	150, /* 1001 -> 15.0x */
+	160, /* 1010 -> 16.0x */
+	130, /* 1011 -> 13.0x */
+	145, /* 1100 -> 14.5x */
+	155, /* 1101 -> 15.5x */
+	-1,  /* 1110 -> RESERVED (13.0x) */
+	-1,  /* 1111 -> RESERVED (12.0x) */
+};
+
+static int __initdata c5m_eblcr[32] =3D {
+	50,  /* 0000 ->  5.0x */
+	30,  /* 0001 ->  3.0x */
+	40,  /* 0010 ->  4.0x */
+	100, /* 0011 -> 10.0x */
+	55,  /* 0100 ->  5.5x */
+	35,  /* 0101 ->  3.5x */
+	45,  /* 0110 ->  4.5x */
+	95,  /* 0111 ->  9.5x */
+	90,  /* 1000 ->  9.0x */
+	70,  /* 1001 ->  7.0x */
+	80,  /* 1010 ->  8.0x */
+	60,  /* 1011 ->  6.0x */
+	120, /* 1100 -> 12.0x */
+	75,  /* 1101 ->  7.5x */
+	85,  /* 1110 ->  8.5x */
+	65,  /* 1111 ->  6.5x */
+
+	-1,  /* 0000 -> RESERVED (9.0x) */
+	110, /* 0001 -> 11.0x */
+	120, /* 0010 -> 12.0x */
+	-1,  /* 0011 -> RESERVED (10.0x)*/
+	135, /* 0100 -> 13.5x */
+	115, /* 0101 -> 11.5x */
+	125, /* 0110 -> 12.5x */
+	105, /* 0111 -> 10.5x */
+	130, /* 1000 -> 13.0x */
+	150, /* 1001 -> 15.0x */
+	160, /* 1010 -> 16.0x */
+	140, /* 1011 -> 14.0x */
+	-1,  /* 1100 -> RESERVED (12.0x) */
+	155, /* 1101 -> 15.5x */
+	-1,  /* 1110 -> RESERVED (13.0x) */
+	145, /* 1111 -> 14.5x */
+};
+
+/* fsb values as defined in CPU */
+static unsigned int eblcr_fsb_table[] =3D { 66, 133, 100, -1 };
+/* fsb values to favour low fsb speed (lower power) */
+static unsigned int power_fsb_table[] =3D { 66, 100, 133, -1 };
+/* fsb values to favour high fsb speed (for e.g. if lowering CPU=20
+   freq because of heat, but want to maintain highest performance possible=
) */
+static unsigned int perf_fsb_table[] =3D { 133, 100, 66, -1 };
+static unsigned int *fsb_search_table;
+
+/* Voltage scales. Div by 1000 to get actual voltage. */
+static int __initdata vrm85scales[32] =3D {
+	1250, 1200, 1150, 1100, 1050, 1800, 1750, 1700,
+	1650, 1600, 1550, 1500, 1450, 1400, 1350, 1300,
+	1275, 1225, 1175, 1125, 1075, 1825, 1775, 1725,
+	1675, 1625, 1575, 1525, 1475, 1425, 1375, 1325,
+};
+
+static int __initdata mobilevrmscales[32] =3D {
+	2000, 1950, 1900, 1850, 1800, 1750, 1700, 1650,
+	1600, 1550, 1500, 1450, 1500, 1350, 1300, -1,
+	1275, 1250, 1225, 1200, 1175, 1150, 1125, 1100,
+	1075, 1050, 1025, 1000, 975, 950, 925, -1,
+};
+
+/* Clock ratios multiplied by 10 */
+static int clock_ratio[32];
+static int eblcr_table[32];
+static int voltage_table[32];
+static int highest_speed, lowest_speed; /* kHz */
+static int longhaul; /* version. */
+static struct cpufreq_driver *longhaul_driver;
+
+static unsigned int longhaul_validatespeed_fsb(unsigned int freq, unsigned=
 fsb, unsigned int oldbest)
+{
+	int i;
+	unsigned int newclock;
+	unsigned int best=3D0;
+
+	best =3D oldbest;
+
+	/* Find closest MHz match. */
+	for (i=3D0; i<numscales; i++) {
+		if (clock_ratio[i]=3D=3D-1)	/* skip RESERVED entries */
+			continue;
+
+		newclock =3D clock_ratio[i] * fsb * 100;
+
+		if ((newclock < best) && (newclock >=3D freq))
+			if ((newclock>=3Dlowest_speed) && (newclock<=3Dhighest_speed))
+				best =3D newclock;
+	}
+	return best;
+}
+
+/* Determine nearest speed possible for the desired fsb speed */
+static unsigned int longhaul_validatespeed (unsigned int cpu, unsigned int=
 freq)
+{
+	unsigned int best=3D-1;
+=09
+	if (cpu && (cpu !=3D CPUFREQ_ALL_CPUS))
+		return 0;
+
+	if (freq<lowest_speed)
+		freq=3Dlowest_speed;
+	if (freq>highest_speed)
+		freq=3Dhighest_speed;
+
+	if (can_scale_fsb=3D=3D1) {
+		int fsb_index;
+		for (fsb_index=3D0; fsb_search_table[fsb_index]!=3D-1; fsb_index++)
+			best =3D longhaul_validatespeed_fsb (freq, fsb_search_table[fsb_index],=
 best);
+	} else {
+		/* Can only scale multiplier. */
+		best =3D longhaul_validatespeed_fsb (freq, current_fsb, best);
+	}
+
+	return  best;
+}
+
+/**
+ * longhaul_set_cpu_frequency()
+ * @cpu: CPU number
+ * @freq: new processor frequency in kHz that has been
+ *        validated with longhaul_validatespeed().
+ *
+ * Note this function is only called if a new frequency has been selected.
+ */
+
+static void longhaul_set_cpu_frequency (unsigned int cpu, unsigned int fre=
q)
+{
+	int index;
+	unsigned int bestfsb=3D-1;
+	unsigned long lo, hi;
+	int bits=3D-1;
+	int revkey;
+	int vidindex, i;
+=09
+	if (cpu && (cpu !=3D CPUFREQ_ALL_CPUS))
+		return;
+
+	/* Find out which mult bit-pattern & FSB we want */
+	for (index=3D0; index<numscales; index++) {
+		if (clock_ratio[index]=3D=3D-1)	/* skip RESERVED entries */
+			continue;
+
+		if (can_scale_fsb=3D=3D1) {
+			int fsb_index;
+			for (fsb_index=3D0; fsb_search_table[fsb_index]!=3D-1; fsb_index++) {
+				if ((clock_ratio[index] * fsb_search_table[fsb_index] * 100) =3D=3D fr=
eq) {
+					bestfsb=3Dfsb_search_table[fsb_index];
+					break;
+				}
+			}
+		} else {
+			/* Can't scale FSB. */
+			bestfsb =3D current_fsb;
+			if ((clock_ratio[index] * bestfsb * 100) =3D=3D freq)
+				break;
+		}
+	}
+
+	if (clock_ratio[index]=3D=3D-1)
+		return;
+
+	dprintk (KERN_INFO "longhaul: New FSB:%d Mult(x10):%d\n",
+				bestfsb, clock_ratio[index]);
+
+	bits =3D index;
+	/* "bits" contains the bitpattern of the new multiplier.
+	   we now need to transform it to the desired format. */
+
+	switch (longhaul) {
+	case 1:
+		rdmsr (MSR_VIA_BCR2, lo, hi);
+		revkey =3D (lo & 0xf)<<4; /* Rev key. */
+		lo &=3D ~(1<<23|1<<24|1<<25|1<<26);
+		lo |=3D (1<<19);		/* Enable software clock multiplier */
+		lo |=3D (bits<<23);	/* desired multiplier */
+		lo |=3D revkey;
+		wrmsr (MSR_VIA_BCR2, lo, hi);
+
+		__hlt();
+
+		/* Disable software clock multiplier */
+		rdmsr (MSR_VIA_BCR2, lo, hi);
+		lo &=3D ~(1<<19);
+		lo |=3D revkey;
+		wrmsr (MSR_VIA_BCR2, lo, hi);
+		break;
+
+	case 2:
+		rdmsr (MSR_VIA_LONGHAUL, lo, hi);
+		revkey =3D (lo & 0xf)<<4;	/* Rev key. */
+		lo &=3D 0xfff0bf0f;	/* reset [19:16,14](bus ratio) and [7:4](rev key) to=
 0 */
+		lo |=3D (bits<<16);
+		lo |=3D (1<<8);	/* EnableSoftBusRatio */
+		lo |=3D revkey;
+
+		if (can_scale_voltage) {
+			if (can_scale_fsb=3D=3D1) {
+				dprintk (KERN_INFO "longhaul: Voltage scaling + FSB scaling not done y=
et.\n");
+				goto bad_voltage;
+			} else {
+				/* PB: TODO fix this up */
+				vidindex =3D (((highest_speed-lowest_speed) / (bestfsb/2)) -
+						((highest_speed-(freq/1000)) / (bestfsb/2)));
+			}
+			for (i=3D0;i<32;i++) {
+				dprintk (KERN_INFO "VID hunting. Looking for %d, found %d\n",
+						minvid+(vidindex*25), voltage_table[i]);
+				if (voltage_table[i]=3D=3D(minvid + (vidindex * 25)))
+					break;
+			}
+			if (i=3D=3D32)
+				goto bad_voltage;
+
+			dprintk (KERN_INFO "longhaul: Desired vid index=3D%d\n", i);
+#if 0
+			lo &=3D 0xfe0fffff;/* reset [24:20](voltage) to 0 */
+			lo |=3D (i<<20);   /* set voltage */
+			lo |=3D (1<<9);    /* EnableSoftVID */
+#endif
+		}
+
+bad_voltage:
+		wrmsr (MSR_VIA_LONGHAUL, lo, hi);
+		__hlt();
+
+		rdmsr (MSR_VIA_LONGHAUL, lo, hi);
+		lo &=3D ~(1<<8);
+		if (can_scale_voltage)
+			lo &=3D ~(1<<9);
+		lo |=3D revkey;
+		wrmsr (MSR_VIA_LONGHAUL, lo, hi);
+		break;
+
+	case 3:
+		rdmsr (MSR_VIA_LONGHAUL, lo, hi);
+		revkey =3D (lo & 0xf)<<4;	/* Rev key. */
+		lo &=3D 0xfff0bf0f;	/* reset longhaul[19:16,14] to 0 */
+		lo |=3D (bits<<16);
+		lo |=3D (1<<8);	/* EnableSoftBusRatio */
+		lo |=3D revkey;
+
+		/* Set FSB */
+		if (can_scale_fsb=3D=3D1) {
+			lo &=3D ~(1<<28|1<<29);
+			switch (bestfsb) {
+				case 66:	lo |=3D (1<<28|1<<29); /* 11 */
+							break;
+				case 100:	lo |=3D 1<<28;	/* 01 */
+							break;
+				case 133:	break;	/* 00*/
+			}
+		}
+		wrmsr (MSR_VIA_LONGHAUL, lo, hi);
+		__hlt();
+
+		rdmsr (MSR_VIA_LONGHAUL, lo, hi);
+		lo &=3D ~(1<<8);
+		lo |=3D revkey;
+		wrmsr (MSR_VIA_LONGHAUL, lo, hi);
+		break;
+	}
+}
+
+static int __init longhaul_get_cpu_fsb (void)
+{
+	unsigned long invalue=3D0,lo, hi;
+
+	if (current_fsb =3D=3D 0) {
+		rdmsr (MSR_IA32_EBL_CR_POWERON, lo, hi);
+		invalue =3D (lo & (1<<18|1<<19)) >>18;
+		return eblcr_fsb_table[invalue];
+	} else {
+		return current_fsb;
+	}
+}
+
+
+static int __init longhaul_get_cpu_mult (void)
+{
+	unsigned long invalue=3D0,lo, hi;
+
+	rdmsr (MSR_IA32_EBL_CR_POWERON, lo, hi);
+	invalue =3D (lo & (1<<22|1<<23|1<<24|1<<25)) >>22;
+	if (longhaul=3D=3D3) {
+		if (lo & (1<<27))
+			invalue+=3D16;
+	}
+	return eblcr_table[invalue];
+}
+
+
+static void __init longhaul_get_ranges (void)
+{
+	unsigned long lo, hi, invalue;
+	unsigned int minmult=3D0, maxmult=3D0, minfsb=3D0, maxfsb=3D0;
+	unsigned int multipliers[32]=3D {
+		50,30,40,100,55,35,45,95,90,70,80,60,120,75,85,65,
+		-1,110,120,-1,135,115,125,105,130,150,160,140,-1,155,-1,145 };
+	unsigned int fsb_table[4] =3D { 133, 100, -1, 66 };
+
+	switch (longhaul) {
+	case 1:
+		/* Ugh, Longhaul v1 didn't have the min/max MSRs.
+		   Assume max =3D whatever we booted at. */
+		maxmult =3D longhaul_get_cpu_mult();
+		break;
+
+	case 2 ... 3:
+		rdmsr (MSR_VIA_LONGHAUL, lo, hi);
+
+		invalue =3D (hi & (1<<0|1<<1|1<<2|1<<3));
+		if (hi & (1<<11))
+			invalue +=3D 16;
+		maxmult=3Dmultipliers[invalue];
+
+#if 0	/* This is MaxMhz @ Min Voltage. Ignore for now */
+		invalue =3D (hi & (1<<16|1<<17|1<<18|1<<19)) >> 16;
+		if (hi & (1<<27))
+		invalue +=3D 16;
+		minmult =3D multipliers[invalue];
+#else
+		minmult =3D 30; /* as per spec */
+#endif
+
+		if (can_scale_fsb=3D=3D1) {
+			invalue =3D (hi & (1<<9|1<<10)) >> 9;
+			maxfsb =3D fsb_table[invalue];
+
+			invalue =3D (hi & (1<<25|1<<26)) >> 25;
+			minfsb =3D fsb_table[invalue];
+
+			dprintk (KERN_INFO "longhaul: Min FSB=3D%d Max FSB=3D%d\n",
+				minfsb, maxfsb);
+		} else {
+			minfsb =3D maxfsb =3D current_fsb;
+		}
+		break;
+	}
+
+	highest_speed =3D maxmult * maxfsb * 100;
+	lowest_speed =3D minmult * minfsb * 100;
+
+	dprintk (KERN_INFO "longhaul: MinMult(x10)=3D%d MaxMult(x10)=3D%d\n",
+		minmult, maxmult);
+	dprintk (KERN_INFO "longhaul: Lowestspeed=3D%d Highestspeed=3D%d\n",
+		lowest_speed, highest_speed);
+}
+
+
+static void __init longhaul_setup_voltagescaling (unsigned long lo, unsign=
ed long hi)
+{
+	int revkey;
+
+	can_scale_voltage =3D 1;
+
+	minvid =3D (hi & (1<<20|1<<21|1<<22|1<<23|1<<24)) >> 20; /* 56:52 */
+	maxvid =3D (hi & (1<<4|1<<5|1<<6|1<<7|1<<8)) >> 4;       /* 40:36 */
+	vrmrev =3D (lo & (1<<15))>>15;
+
+	if (vrmrev=3D=3D0) {
+		dprintk (KERN_INFO "longhaul: VRM 8.5 : ");
+		memcpy (voltage_table, vrm85scales, sizeof(voltage_table));
+		numvscales =3D (voltage_table[maxvid]-voltage_table[minvid])/25;
+	} else {
+		dprintk (KERN_INFO "longhaul: Mobile VRM : ");
+		memcpy (voltage_table, mobilevrmscales, sizeof(voltage_table));
+		numvscales =3D (voltage_table[maxvid]-voltage_table[minvid])/5;
+	}
+
+	/* Current voltage isn't readable at first, so we need to
+	   set it to a known value. The spec says to use maxvid */
+	revkey =3D (lo & 0xf)<<4;	/* Rev key. */
+	lo &=3D 0xfe0fff0f;	/* Mask unneeded bits */
+	lo |=3D (1<<9);		/* EnableSoftVID */
+	lo |=3D revkey;		/* Reinsert key */
+	lo |=3D maxvid << 20;
+	wrmsr (MSR_VIA_LONGHAUL, lo, hi);
+	minvid =3D voltage_table[minvid];
+	maxvid =3D voltage_table[maxvid];
+	dprintk ("Min VID=3D%d.%03d Max VID=3D%d.%03d, %d possible voltage scales=
\n",
+		maxvid/1000, maxvid%1000, minvid/1000, minvid%1000, numvscales);
+}
+
+
+static int __init longhaul_init (void)
+{
+	struct cpuinfo_x86 *c =3D cpu_data;
+	unsigned int currentspeed;
+	static int currentmult;
+	unsigned long lo, hi;
+	int ret;
+	struct cpufreq_driver *driver;
+
+	if ((c->x86_vendor !=3D X86_VENDOR_CENTAUR) || (c->x86 !=3D6) )
+		return -ENODEV;
+
+	switch (c->x86_model) {
+	case 6:		/* VIA C3 Samuel C5A */
+		longhaul=3D1;
+		memcpy (clock_ratio, longhaul1_clock_ratio, sizeof(longhaul1_clock_ratio=
));
+		memcpy (eblcr_table, samuel1_eblcr, sizeof(samuel1_eblcr));
+		break;
+
+	case 7:		/* C5B / C5C */
+		switch (c->x86_mask) {
+		case 0:
+			longhaul=3D1;
+			memcpy (clock_ratio, longhaul1_clock_ratio, sizeof(longhaul1_clock_rati=
o));
+			memcpy (eblcr_table, samuel2_eblcr, sizeof(samuel2_eblcr));
+			break;
+		case 1 ... 15:
+			longhaul=3D2;
+			memcpy (clock_ratio, longhaul2_clock_ratio, sizeof(longhaul2_clock_rati=
o));
+			memcpy (eblcr_table, ezra_eblcr, sizeof(ezra_eblcr));
+			break;
+		}
+		break;
+
+	case 8:		/* C5M/C5N */
+		return -ENODEV; // Waiting on updated docs from VIA before this is usable
+		longhaul=3D3;
+		numscales=3D32;
+		memcpy (clock_ratio, longhaul3_clock_ratio, sizeof(longhaul3_clock_ratio=
));
+		memcpy (eblcr_table, c5m_eblcr, sizeof(c5m_eblcr));
+		break;
+
+	default:
+		printk (KERN_INFO "longhaul: Unknown VIA CPU. Contact davej@suse.de\n");
+		return -ENODEV;
+	}
+
+	printk (KERN_INFO "longhaul: VIA CPU detected. Longhaul version %d suppor=
ted\n", longhaul);
+
+	if (favour_fast_fsb=3D=3D1)
+		fsb_search_table =3D perf_fsb_table;
+	else
+		fsb_search_table =3D power_fsb_table;
+
+	current_fsb =3D longhaul_get_cpu_fsb();
+	currentmult =3D longhaul_get_cpu_mult();
+	currentspeed =3D currentmult * current_fsb * 100;
+
+	dprintk (KERN_INFO "longhaul: CPU currently at %dMHz (%d x %d.%d)\n",
+		(currentspeed/1000), current_fsb, currentmult/10, currentmult%10);
+
+	if (longhaul=3D=3D2 || longhaul=3D=3D3) {
+		rdmsr (MSR_VIA_LONGHAUL, lo, hi);
+		if ((lo & (1<<0)) && (dont_scale_voltage=3D=3D0))
+			longhaul_setup_voltagescaling (lo, hi);
+
+		if ((lo & (1<<1)) && (dont_scale_fsb=3D=3D0) && (current_fsb=3D=3D0))
+			can_scale_fsb =3D 1;
+	}
+
+	longhaul_get_ranges();
+
+	driver =3D kmalloc(sizeof(struct cpufreq_driver) +
+			 sizeof(struct cpufreq_freqs), GFP_KERNEL);
+	if (!driver)
+		return -ENOMEM;
+
+	driver->freq =3D (struct cpufreq_freqs*) (driver + sizeof(struct cpufreq_=
driver));
+	driver->sync =3D CPUFREQ_SYNC;
+	driver->freq->cpu =3D CPUFREQ_ALL_CPUS;
+	driver->freq->min =3D (unsigned int) lowest_speed;
+	driver->freq->max =3D (unsigned int) highest_speed;
+	driver->freq->cur =3D currentspeed;
+	driver->validate =3D &longhaul_validatespeed;
+	driver->setspeed =3D &longhaul_set_cpu_frequency;
+
+	ret =3D cpufreq_register(driver);
+
+	if (ret) {
+		kfree(driver);
+		return ret;
+	}
+
+	longhaul_driver =3D driver;
+	return 0;
+}
+
+
+static void __exit longhaul_exit (void)
+{
+	if (longhaul_driver) {
+		cpufreq_unregister();
+		kfree(longhaul_driver);
+	}
+}
+
+MODULE_PARM (dont_scale_fsb, "i");
+MODULE_PARM (dont_scale_voltage, "i");
+MODULE_PARM (current_fsb, "i");
+MODULE_PARM (favour_fast_fsb, "i");
+
+MODULE_AUTHOR ("Dave Jones <davej@suse.de>");
+MODULE_DESCRIPTION ("Longhaul driver for VIA Cyrix processors.");
+MODULE_LICENSE ("GPL");
+
+module_init(longhaul_init);
+module_exit(longhaul_exit);
+
diff -ruN linux-2531orig/arch/i386/kernel/cpu/cpufreq/powernow-k6.c linux/a=
rch/i386/kernel/cpu/cpufreq/powernow-k6.c
--- linux-2531orig/arch/i386/kernel/cpu/cpufreq/powernow-k6.c	Thu Jan  1 01=
:00:00 1970
+++ linux/arch/i386/kernel/cpu/cpufreq/powernow-k6.c	Wed Aug 28 10:51:46 20=
02
@@ -0,0 +1,242 @@
+/*
+ *  $Id: powernow-k6.c,v 1.26 2002/08/19 15:00:57 davej Exp $
+ *  This file was part of Powertweak Linux (http://powertweak.sf.net)
+ *  and is shared with the Linux Kernel module.
+ *
+ *  (C) 2000-2002  Dave Jones, Arjan van de Ven, Janne P=E4nk=E4l=E4.
+ *
+ *  Licensed under the terms of the GNU GPL License version 2.
+ *
+ *  BIG FAT DISCLAIMER: Work in progress code. Possibly *dangerous*
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>=20
+#include <linux/sched.h>
+#include <linux/init.h>
+#include <asm/msr.h>
+#include <asm/timex.h>
+#include <asm/io.h>
+#include <linux/delay.h>
+#include <linux/proc_fs.h>
+#include <linux/cpufreq.h>
+#include <linux/ioport.h>
+
+
+#define POWERNOW_IOPORT 0xfff0         /* it doesn't matter where, as long
+					  as it is unused */
+
+static struct cpufreq_driver		*powernow_driver;
+static unsigned int                     busfreq;   /* FSB, in 10 kHz */
+static unsigned int                     max_multiplier;
+
+
+/* Clock ratio multiplied by 10 - see table 27 in AMD#23446 */
+static int clock_ratio[8] =3D {
+	45,  /* 000 -> 4.5x */
+	50,  /* 001 -> 5.0x */
+	40,  /* 010 -> 4.0x */
+	55,  /* 011 -> 5.5x */
+	20,  /* 100 -> 2.0x */
+	30,  /* 101 -> 3.0x */
+	60,  /* 110 -> 6.0x */
+	35   /* 111 -> 3.5x */
+};
+
+
+/**
+ * powernow_k6_set_frequency - set the PowerNow! multiplier
+ * @cpu: CPU number
+ * @freq: new processor frequency in kHz
+ *
+ *   Tries to change the PowerNow! multiplier
+ */
+void powernow_k6_set_frequency (unsigned int cpu, unsigned int freq)
+{
+	unsigned int    i;
+	unsigned int    best_i =3D 4;
+	unsigned int    tmpfreq;
+	unsigned int    newfreq =3D busfreq * 65;
+	unsigned long   outvalue=3D0, invalue=3D0;
+	unsigned long   msrval;
+	unsigned long   cpus_allowed;
+
+	if (!powernow_driver || !freq || (freq > busfreq * max_multiplier)) {
+		printk(KERN_ERR "cpufreq: initialization problem or invalid target frequ=
ency\n");
+		return;
+	}
+
+	if (!cpu_online(cpu)) {
+		printk(KERN_ERR "cpufreq: CPU not present!\n");
+		return;
+	}
+
+	/* Find out which bit-pattern we want */
+	for (i=3D0; i<8; i++) {
+		tmpfreq =3D busfreq * clock_ratio[i];
+		if ((tmpfreq < newfreq) && (newfreq >=3D freq)) {
+			newfreq =3D tmpfreq;
+			best_i =3D i;
+		}
+	}
+
+	/* "best_i" now contains the bitpattern of the new multiplier.
+	   we now need to transform it to the BVC format, see AMD#23446 */
+
+	outvalue =3D (1<<12) | (1<<10) | (1<<9) | (best_i<<5);
+
+	/*
+	 * Save this threads cpus_allowed mask, and bind to the
+	 * specified CPU.  When this call returns, we should be
+	 * running on the right CPU.
+	 */
+	cpus_allowed =3D current->cpus_allowed;
+	set_cpus_allowed(current, 1 << cpu);
+	BUG_ON(cpu !=3D smp_processor_id());
+
+	msrval =3D POWERNOW_IOPORT + 0x1;
+	wrmsr(MSR_K6_EPMR, msrval, 0); /* enable the PowerNow port */
+	invalue=3Dinl(POWERNOW_IOPORT + 0x8);
+	invalue =3D invalue & 0xf;
+	outvalue =3D outvalue | invalue;
+	outl(outvalue ,(POWERNOW_IOPORT + 0x8));
+	msrval =3D POWERNOW_IOPORT + 0x0;
+	wrmsr(MSR_K6_EPMR, msrval, 0); /* disable it again */
+
+	/*
+	 * Restore the CPUs allowed mask.
+	 */
+	set_cpus_allowed(current, cpus_allowed);
+
+	return;
+}
+
+
+/**
+ * powernow_k6_get_cpu_multiplier - returns the current FSB multiplier
+ *
+ *   Returns the current setting of the frequency multiplier. Core clock
+ * speed is frequency of the Front-Side Bus multiplied with this value.
+ */
+static int powernow_k6_get_cpu_multiplier(void)
+{
+	u64             invalue =3D 0;
+	u32             msrval;
+=09
+	msrval =3D POWERNOW_IOPORT + 0x1;
+	wrmsr(MSR_K6_EPMR, msrval, 0); /* enable the PowerNow port */
+	invalue=3Dinl(POWERNOW_IOPORT + 0x8);
+	msrval =3D POWERNOW_IOPORT + 0x0;
+	wrmsr(MSR_K6_EPMR, msrval, 0); /* disable it again */
+
+	return clock_ratio[(invalue >> 5)&7];
+}
+
+
+/**
+ * powernow_k6_validate_frequency - validates the CPU frequency to be set
+ * @cpu: CPU number
+ * @kHz: suggested new CPU frequency
+ *
+ *   Makes sure the CPU frequency to be set is valid.
+ */
+unsigned int powernow_k6_validate_frequency(unsigned int cpu, unsigned int=
 kHz)
+{
+	int             i;
+	unsigned int    tmpfreq;
+	unsigned int    newfreq =3D busfreq * 65;
+
+	if (kHz >=3D busfreq * max_multiplier)
+		return (busfreq * max_multiplier);
+
+	for (i=3D0; i<8; i++) {
+		tmpfreq =3D busfreq * clock_ratio[i];
+		if ((tmpfreq < newfreq) && (newfreq >=3D kHz))
+			newfreq =3D tmpfreq;
+	}
+
+	return tmpfreq;
+}
+
+
+/**
+ * powernow_k6_init - initializes the k6 PowerNow! CPUFreq driver
+ *
+ *   Initializes the K6 PowerNow! support. Returns -ENODEV on unsupported
+ * devices, -EINVAL or -ENOMEM on problems during initiatization, and zero
+ * on success.
+ */
+static int __init powernow_k6_init(void)
+{=09
+	struct cpuinfo_x86      *c =3D cpu_data;
+	struct cpufreq_driver   *driver;
+	unsigned int            result;
+	unsigned int            i;
+
+	if ((c->x86_vendor !=3D X86_VENDOR_AMD) || (c->x86 !=3D 5) ||
+		((c->x86_model !=3D 12) && (c->x86_model !=3D 13)))
+		return -ENODEV;
+
+	/* it is assumed that all CPUs run at the same, highest frequency */
+	max_multiplier =3D powernow_k6_get_cpu_multiplier();
+	busfreq =3D cpu_khz / max_multiplier;
+
+	if (!request_region(POWERNOW_IOPORT, 16, "PowerNow!")) {
+		printk("cpufreq: PowerNow IOPORT region already used.\n");
+		return -EIO;
+	}
+
+	/* initialization of main "cpufreq" code*/
+	driver =3D kmalloc(sizeof(struct cpufreq_driver) +
+		NR_CPUS * sizeof(struct cpufreq_freqs), GFP_KERNEL);
+	if (!driver) {
+		release_region (POWERNOW_IOPORT, 16);
+		return -ENOMEM;
+	}
+=09
+	driver->freq =3D (struct cpufreq_freqs*) (driver + sizeof(struct cpufreq_=
driver));
+	driver->sync =3D CPUFREQ_ASYNC;
+
+	for (i=3D0; i<NR_CPUS; i++) {
+		if (!cpu_online(i))
+			continue;
+		driver->freq[i].cpu =3D i;
+		driver->freq[i].min =3D busfreq * 2.0;
+		driver->freq[i].max =3D busfreq * max_multiplier;
+		driver->freq[i].cur =3D busfreq * max_multiplier;
+	}
+
+	driver->validate =3D &powernow_k6_validate_frequency;
+	driver->setspeed =3D &powernow_k6_set_frequency;
+
+	result =3D cpufreq_register(driver);
+	if (result) {
+		release_region (POWERNOW_IOPORT, 16);
+		kfree(driver);
+		return result;
+	}
+	powernow_driver =3D driver;
+
+	return 0;
+}
+
+
+/**
+ * powernow_k6_exit - unregisters AMD K6-2+/3+ PowerNow! support
+ *
+ *   Unregisters AMD K6-2+ / K6-3+ PowerNow! support.
+ */
+static void __exit powernow_k6_exit(void)
+{
+	if (powernow_driver) {
+		cpufreq_unregister();
+		kfree(powernow_driver);
+	}
+}
+
+
+MODULE_AUTHOR ("Arjan van de Ven <arjanv@redhat.com>, Dave Jones <davej@su=
se.de>, Dominik Brodowski <devel@brodo.de>");
+MODULE_DESCRIPTION ("PowerNow! driver for AMD K6-2+ / K6-3+ processors.");
+MODULE_LICENSE ("GPL");
+module_init(powernow_k6_init);
+module_exit(powernow_k6_exit);
diff -ruN linux-2531orig/arch/i386/kernel/cpu/cpufreq/speedstep.c linux/arc=
h/i386/kernel/cpu/cpufreq/speedstep.c
--- linux-2531orig/arch/i386/kernel/cpu/cpufreq/speedstep.c	Thu Jan  1 01:0=
0:00 1970
+++ linux/arch/i386/kernel/cpu/cpufreq/speedstep.c	Wed Aug 28 10:51:46 2002
@@ -0,0 +1,656 @@
+/*
+ *  $Id: speedstep.c,v 1.44 2002/08/17 17:28:25 db Exp $
+ *
+ * (C) 2001  Dave Jones, Arjan van de ven.
+ * (C) 2002  Dominik Brodowski <devel@brodo.de>
+ *
+ *  Licensed under the terms of the GNU GPL License version 2.
+ *  Based upon reverse engineered information, and on Intel documentation
+ *  for chipsets ICH2-M and ICH3-M.
+ *
+ *  Many thanks to Ducrot Bruno for finding and fixing the last
+ *  "missing link" for ICH2-M/ICH3-M support, and to Thomas Winkler=20
+ *  for extensive testing.
+ *
+ *  BIG FAT DISCLAIMER: Work in progress code. Possibly *dangerous*
+ */
+
+
+/*********************************************************************
+ *                        SPEEDSTEP - DEFINITIONS                    *
+ *********************************************************************/
+
+#include <linux/kernel.h>
+#include <linux/module.h>=20
+#include <linux/sched.h>
+#include <linux/init.h>
+#include <asm/msr.h>
+#include <asm/timex.h>
+#include <asm/io.h>
+#include <asm/processor.h>
+#include <linux/delay.h>
+#include <linux/proc_fs.h>
+#include <linux/cpufreq.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+
+
+static struct cpufreq_driver		*speedstep_driver;
+
+/* speedstep_chipset:
+ *   It is necessary to know which chipset is used. As accesses to=20
+ * this device occur at various places in this module, we need a=20
+ * static struct pci_dev * pointing to that device.
+ */
+static unsigned int                     speedstep_chipset;
+static struct pci_dev                   *speedstep_chipset_dev;
+
+#define SPEEDSTEP_CHIPSET_ICH2M         0x00000002
+#define SPEEDSTEP_CHIPSET_ICH3M         0x00000003
+
+
+/* speedstep_processor
+ */
+static unsigned int                     speedstep_processor;
+
+#define SPEEDSTEP_PROCESSOR_PIII_C      0x00000001  /* Coppermine core */
+#define SPEEDSTEP_PROCESSOR_PIII_T      0x00000002  /* Tualatin core */
+#define SPEEDSTEP_PROCESSOR_P4M         0x00000003  /* P4-M with 100 MHz F=
SB */
+
+
+/* speedstep_[low,high]_freq
+ *   There are only two frequency states for each processor. Values
+ * are in kHz for the time being.
+ */
+static unsigned int                     speedstep_low_freq;
+static unsigned int                     speedstep_high_freq;
+
+
+/* DEBUG
+ *   Define it if you want verbose debug output, e.g. for bug reporting
+ */
+//#define SPEEDSTEP_DEBUG
+
+#ifdef SPEEDSTEP_DEBUG
+#define dprintk(msg...) printk(msg)
+#else
+#define dprintk(msg...) do { } while(0);
+#endif
+
+
+
+/*********************************************************************
+ *                    LOW LEVEL CHIPSET INTERFACE                    *
+ *********************************************************************/
+
+/**
+ * speedstep_get_frequency - read the current SpeedStep state
+ * @freq: current processor frequency in kHz
+ *
+ *   Tries to read the SpeedStep state. Returns -EIO when there has been
+ * trouble to read the status or write to the control register, -EINVAL
+ * on an unsupported chipset, and zero on success.
+ */
+static int speedstep_get_frequency (unsigned int *freq)
+{
+	u32             pmbase;
+	u8              value;
+
+	if (!speedstep_chipset_dev || !freq)
+		return -EINVAL;
+
+	switch (speedstep_chipset) {
+	case SPEEDSTEP_CHIPSET_ICH2M:
+	case SPEEDSTEP_CHIPSET_ICH3M:
+		/* get PMBASE */
+		pci_read_config_dword(speedstep_chipset_dev, 0x40, &pmbase);
+		if (!(pmbase & 0x01))
+			return -EIO;
+
+		pmbase &=3D 0xFFFFFFFE;
+		if (!pmbase)=20
+			return -EIO;
+
+		/* read state */
+		local_irq_disable();
+		value =3D inb(pmbase + 0x50);
+		local_irq_enable();
+
+		dprintk(KERN_DEBUG "cpufreq: read at pmbase 0x%x + 0x50 returned 0x%x\n"=
, pmbase, value);
+
+		*freq =3D (value & 0x01) ? speedstep_low_freq : \
+			speedstep_high_freq;
+		return 0;
+
+	}
+
+	printk (KERN_ERR "cpufreq: setting CPU frequency on this chipset unsuppor=
ted.\n");
+	return -EINVAL;
+}
+
+
+/**
+ * speedstep_set_frequency - set the SpeedStep state
+ * @cpu: CPU number
+ * @freq: new processor frequency in kHz
+ *
+ *   Tries to change the SpeedStep state.=20
+ */
+void speedstep_set_frequency (unsigned int cpu, unsigned int freq)
+{
+	u32             pmbase;
+	u8	        pm2_blk;
+	u8              value;
+	unsigned long   flags;
+
+	if (cpu && (cpu !=3D CPUFREQ_ALL_CPUS))
+		return;
+
+	if (!speedstep_chipset_dev || !freq) {
+		printk(KERN_ERR "cpufreq: unknown chipset or state\n");
+		return;
+	}
+
+	switch (speedstep_chipset) {
+	case SPEEDSTEP_CHIPSET_ICH2M:
+	case SPEEDSTEP_CHIPSET_ICH3M:
+		/* get PMBASE */
+		pci_read_config_dword(speedstep_chipset_dev, 0x40, &pmbase);
+		if (!(pmbase & 0x01))
+			return;
+
+		pmbase &=3D 0xFFFFFFFE;
+		if (!pmbase)
+			return;
+
+		/* read state */
+		local_irq_disable();
+		value =3D inb(pmbase + 0x50);
+		local_irq_enable();
+
+		dprintk(KERN_DEBUG "cpufreq: read at pmbase 0x%x + 0x50 returned 0x%x\n"=
, pmbase, value);
+
+		/* write new state, but only if indeed a transition=20
+		 * is necessary */
+		if (freq =3D=3D ((value & 0x01) ? speedstep_low_freq : \
+			      speedstep_high_freq))
+			return;
+
+		value =3D (freq =3D=3D speedstep_high_freq) ? 0x00 : 0x01;
+
+		dprintk(KERN_DEBUG "cpufreq: writing 0x%x to pmbase 0x%x + 0x50\n", valu=
e, pmbase);
+
+		/* Disable IRQs */
+		local_irq_save(flags);
+		local_irq_disable();
+
+		/* Disable bus master arbitration */
+		pm2_blk =3D inb(pmbase + 0x20);
+		pm2_blk |=3D 0x01;
+		outb(pm2_blk, (pmbase + 0x20));
+
+		/* Actual transition */
+		outb(value, (pmbase + 0x50));
+
+		/* Restore bus master arbitration */
+		pm2_blk &=3D 0xfe;
+		outb(pm2_blk, (pmbase + 0x20));
+
+		/* Enable IRQs */
+		local_irq_enable();
+		local_irq_restore(flags);
+
+		/* check if transition was sucessful */
+		local_irq_disable();
+		value =3D inb(pmbase + 0x50);
+		local_irq_enable();
+
+		dprintk(KERN_DEBUG "cpufreq: read at pmbase 0x%x + 0x50 returned 0x%x\n"=
, pmbase, value);
+
+		if (freq =3D=3D ((value & 0x01) ? speedstep_low_freq : \
+			    speedstep_high_freq)) {
+			dprintk (KERN_INFO "cpufreq: change to %u MHz succeded\n", (freq / 1000=
));
+			return;
+		}
+
+		printk (KERN_ERR "cpufreq: change failed - I/O error\n");
+		return;
+	}
+
+	printk (KERN_ERR "cpufreq: setting CPU frequency on this chipset unsuppor=
ted.\n");
+	return;
+}
+
+
+/**
+ * speedstep_activate - activate SpeedStep control in the chipset
+ *
+ *   Tries to activate the SpeedStep status and control registers.
+ * Returns -EINVAL on an unsupported chipset, and zero on success.
+ */
+static int speedstep_activate (void)
+{
+	if (!speedstep_chipset_dev)
+		return -EINVAL;
+
+	switch (speedstep_chipset) {
+	case SPEEDSTEP_CHIPSET_ICH2M:
+	case SPEEDSTEP_CHIPSET_ICH3M:
+	{
+		u16             value =3D 0;
+
+		pci_read_config_word(speedstep_chipset_dev,=20
+				     0x00A0, &value);
+		if (!(value & 0x08)) {
+			value |=3D 0x08;
+			dprintk(KERN_DEBUG "cpufreq: activating SpeedStep (TM) registers\n");
+			pci_write_config_word(speedstep_chipset_dev,=20
+					      0x00A0, value);
+		}
+
+		return 0;
+	}
+	}
+=09
+	printk (KERN_ERR "cpufreq: SpeedStep (TM) on this chipset unsupported.\n"=
);
+	return -EINVAL;
+}
+
+
+/**
+ * speedstep_detect_chipset - detect the Southbridge which contains SpeedS=
tep logic
+ *
+ *   Detects PIIX4, ICH2-M and ICH3-M so far. The pci_dev points to=20
+ * the LPC bridge / PM module which contains all power-management=20
+ * functions. Returns the SPEEDSTEP_CHIPSET_-number for the detected
+ * chipset, or zero on failure.
+ */
+static unsigned int speedstep_detect_chipset (void)
+{
+	speedstep_chipset_dev =3D pci_find_subsys(PCI_VENDOR_ID_INTEL,
+			      PCI_DEVICE_ID_INTEL_82801CA_12,=20
+			      PCI_ANY_ID,
+			      PCI_ANY_ID,
+			      NULL);
+	if (speedstep_chipset_dev)
+		return SPEEDSTEP_CHIPSET_ICH3M;
+
+
+	speedstep_chipset_dev =3D pci_find_subsys(PCI_VENDOR_ID_INTEL,
+			      PCI_DEVICE_ID_INTEL_82801BA_10,
+			      PCI_ANY_ID,
+			      PCI_ANY_ID,
+			      NULL);
+	if (speedstep_chipset_dev)
+		return SPEEDSTEP_CHIPSET_ICH2M;
+
+
+	return 0;
+}
+
+
+
+/*********************************************************************
+ *                   LOW LEVEL PROCESSOR INTERFACE                   *
+ *********************************************************************/
+
+
+/**
+ * pentium3_get_frequency - get the core frequencies for PIIIs
+ *
+ *   Returns the core frequency of a Pentium III processor (in kHz)
+ */
+static unsigned int pentium3_get_frequency (void)
+{
+        /* See table 14 of p3_ds.pdf and table 22 of 29834003.pdf */
+	struct {
+		unsigned int ratio;	/* Frequency Multiplier (x10) */
+		u8 bitmap;	        /* power on configuration bits
+					   [27, 25:22] (in MSR 0x2a) */
+	} msr_decode_mult [] =3D {
+		{ 30, 0x01 },
+		{ 35, 0x05 },
+		{ 40, 0x02 },
+		{ 45, 0x06 },
+		{ 50, 0x00 },
+		{ 55, 0x04 },
+		{ 60, 0x0b },
+		{ 65, 0x0f },
+		{ 70, 0x09 },
+		{ 75, 0x0d },
+		{ 80, 0x0a },
+		{ 85, 0x26 },
+		{ 90, 0x20 },
+		{ 100, 0x2b },
+		{ 0, 0xff }     /* error or unknown value */
+	};
+	/* PIII(-M) FSB settings: see table b1-b of 24547206.pdf */
+	struct {
+		unsigned int value;     /* Front Side Bus speed in MHz */
+		u8 bitmap;              /* power on configuration bits [18: 19]
+					   (in MSR 0x2a) */
+	} msr_decode_fsb [] =3D {
+		{  66, 0x0 },
+		{ 100, 0x2 },
+		{ 133, 0x1 },
+		{   0, 0xff}
+	};
+	u32     msr_lo, msr_tmp;
+	int     i =3D 0, j =3D 0;
+	struct  cpuinfo_x86 *c =3D cpu_data;
+
+	/* read MSR 0x2a - we only need the low 32 bits */
+	rdmsr(MSR_IA32_EBL_CR_POWERON, msr_lo, msr_tmp);
+	dprintk(KERN_DEBUG "cpufreq: P3 - MSR_IA32_EBL_CR_POWERON: 0x%x 0x%x\n", =
msr_lo, msr_tmp);
+	msr_tmp =3D msr_lo;
+
+	/* decode the FSB */
+	msr_tmp &=3D 0x00c0000;
+	msr_tmp >>=3D 18;
+	while (msr_tmp !=3D msr_decode_fsb[i].bitmap) {
+		if (msr_decode_fsb[i].bitmap =3D=3D 0xff)
+			return -EINVAL;
+		i++;
+	}
+
+	/* decode the multiplier */
+	if ((c->x86_model =3D=3D 0x08) && (c->x86_mask =3D=3D 0x01))=20
+                /* different on early Coppermine PIII */
+		msr_lo &=3D 0x03c00000;
+	else
+		msr_lo &=3D 0x0bc00000;
+	msr_lo >>=3D 22;
+	while (msr_lo !=3D msr_decode_mult[j].bitmap) {
+		if (msr_decode_mult[j].bitmap =3D=3D 0xff)
+			return -EINVAL;
+		j++;
+	}
+
+	return (msr_decode_mult[j].ratio * msr_decode_fsb[i].value * 100);
+}
+
+
+/**
+ * pentium4_get_frequency - get the core frequency for P4-Ms
+ *
+ *   Should return the core frequency (in kHz) for P4-Ms.=20
+ */
+static unsigned int pentium4_get_frequency(void)
+{
+	u32 msr_lo, msr_hi;
+
+	rdmsr(0x2c, msr_lo, msr_hi);
+
+	dprintk(KERN_DEBUG "cpufreq: P4 - MSR_EBC_FREQUENCY_ID: 0x%x 0x%x\n", msr=
_lo, msr_hi);
+
+	/* First 12 bits seem to change a lot (0x511, 0x410 and 0x30f seen=20
+	 * yet). Next 12 bits always seem to be 0x300. If this is not true=20
+	 * on this CPU, complain. Last 8 bits are frequency (in 100MHz).
+	 */
+	if (msr_hi || ((msr_lo & 0x00FFF000) !=3D 0x300000)) {
+		printk(KERN_DEBUG "cpufreq: P4 - MSR_EBC_FREQUENCY_ID: 0x%x 0x%x\n", msr=
_lo, msr_hi);
+		printk(KERN_INFO "cpufreq: problem in initialization. Please contact Dom=
inik Brodowski\n");
+		printk(KERN_INFO "cpufreq: <devel@brodo.de> and attach this dmesg. Thank=
s in advance\n");
+		return 0;
+	}
+
+	msr_lo >>=3D 24;
+	return (msr_lo * 100000);
+}
+
+
+/**=20
+ * speedstep_detect_processor - detect Intel SpeedStep-capable processors.
+ *
+ *   Returns the SPEEDSTEP_PROCESSOR_-number for the detected chipset,=20
+ * or zero on failure.
+ */
+static unsigned int speedstep_detect_processor (void)
+{
+	struct cpuinfo_x86 *c =3D cpu_data;
+	u32                     ebx;
+
+	if ((c->x86_vendor !=3D X86_VENDOR_INTEL) ||=20
+	    ((c->x86 !=3D 6) && (c->x86 !=3D 0xF)))
+		return 0;
+
+	if (c->x86 =3D=3D 0xF) {
+		/* Intel Pentium 4 Mobile P4-M */
+		if (c->x86_model !=3D 2)
+			return 0;
+
+		if (c->x86_mask !=3D 4)
+			return 0;
+
+		ebx =3D cpuid_ebx(0x00000001);
+		ebx &=3D 0x000000FF;
+		if ((ebx !=3D 0x0e) && (ebx !=3D 0x0f))
+			return 0;
+
+		return SPEEDSTEP_PROCESSOR_P4M;
+	}
+
+	switch (c->x86_model) {
+	case 0x0B: /* Intel PIII [Tualatin] */
+		/* cpuid_ebx(1) is 0x04 for desktop PIII,=20
+		                   0x06 for mobile PIII-M */
+		ebx =3D cpuid_ebx(0x00000001);
+
+		ebx &=3D 0x000000FF;
+		if (ebx !=3D 0x06)
+			return 0;
+
+		/* So far all PIII-M processors support SpeedStep. See
+		 * Intel's 24540633.pdf of August 2002=20
+		 */
+
+		return SPEEDSTEP_PROCESSOR_PIII_T;
+
+	case 0x08: /* Intel PIII [Coppermine] */
+		/* based on reverse-engineering information and
+		 * some guessing. HANDLE WITH CARE! */
+ 	        {
+			u32     msr_lo, msr_hi;
+
+			/* all mobile PIII Coppermines have FSB 100 MHz
+			 * =3D=3D> sort out a few desktop PIIIs. */
+			rdmsr(MSR_IA32_EBL_CR_POWERON, msr_lo, msr_hi);
+			dprintk(KERN_DEBUG "cpufreq: Coppermine: MSR_IA32_EBL_Cr_POWERON is 0x%=
x, 0x%x\n", msr_lo, msr_hi);
+			msr_lo &=3D 0x00c0000;
+			if (msr_lo !=3D 0x0080000)
+				return 0;
+
+			/* platform ID seems to be 0x00140000 */
+			rdmsr(MSR_IA32_PLATFORM_ID, msr_lo, msr_hi);
+			dprintk(KERN_DEBUG "cpufreq: Coppermine: MSR_IA32_PLATFORM ID is 0x%x, =
0x%x\n", msr_lo, msr_hi);
+			msr_hi =3D msr_lo & 0x001c0000;
+			if (msr_hi !=3D 0x00140000)
+				return 0;
+
+			/* and these bits seem to be either 00_b, 01_b or
+			 * 10_b but never 11_b */
+			msr_lo &=3D 0x00030000;
+			if (msr_lo =3D=3D 0x0030000)
+				return 0;
+
+			/* let's hope this is correct... */
+			return SPEEDSTEP_PROCESSOR_PIII_C;
+		}
+
+	default:
+		return 0;
+	}
+}
+
+
+
+/*********************************************************************
+ *                        HIGH LEVEL FUNCTIONS                       *
+ *********************************************************************/
+
+
+/**
+ * speedstep_detect_speeds - detects low and high CPU frequencies.
+ *
+ *   Detects the low and high CPU frequencies in kHz. Returns 0 on
+ * success or -EINVAL / -EIO on problems.=20
+ */
+static int speedstep_detect_speeds (void)
+{
+	unsigned int    state;
+	int             i, result;
+   =20
+	for (i=3D0; i<2; i++) {
+		/* read the current state */
+		result =3D speedstep_get_frequency(&state);
+		if (result)
+			return result;
+
+		/* save the correct value, and switch to other */
+		if (state =3D=3D speedstep_low_freq) {
+			switch (speedstep_processor) {
+			case SPEEDSTEP_PROCESSOR_PIII_C:
+			case SPEEDSTEP_PROCESSOR_PIII_T:
+				speedstep_low_freq =3D pentium3_get_frequency();
+				break;
+			case SPEEDSTEP_PROCESSOR_P4M:
+				speedstep_low_freq =3D pentium4_get_frequency();
+			}
+			speedstep_set_frequency(0, speedstep_high_freq);
+		} else {
+			switch (speedstep_processor) {
+			case SPEEDSTEP_PROCESSOR_PIII_C:
+			case SPEEDSTEP_PROCESSOR_PIII_T:
+				speedstep_high_freq =3D pentium3_get_frequency();
+				break;
+			case SPEEDSTEP_PROCESSOR_P4M:
+				speedstep_high_freq =3D pentium4_get_frequency();
+			}
+			speedstep_set_frequency(0, speedstep_low_freq);
+		}
+
+		if (!speedstep_low_freq || !speedstep_high_freq || (speedstep_low_freq =
=3D=3D speedstep_high_freq))
+			return -EIO;
+	}
+
+	return 0;
+}
+
+
+/**
+ * speedstep_validate_frequency - validates the CPU frequency to be set
+ * @cpu: CPU number
+ * @kHz: suggested new CPU frequency
+ *
+ *   Makes sure the CPU frequency to be set is valid.
+ */
+unsigned int speedstep_validate_frequency(unsigned int cpu, unsigned int k=
Hz)
+{
+	if (cpu && (cpu !=3D CPUFREQ_ALL_CPUS))
+		return 0;
+
+	if (kHz <=3D speedstep_low_freq)
+		return speedstep_low_freq;
+	else=20
+		return speedstep_high_freq;
+}
+
+
+/**
+ * speedstep_init - initializes the SpeedStep CPUFreq driver
+ *
+ *   Initializes the SpeedStep support. Returns -ENODEV on unsupported
+ * devices, -EINVAL on problems during initiatization, and zero on
+ * success.
+ */
+static int __init speedstep_init(void)
+{
+	int                     result;
+	unsigned int            speed;
+	struct cpufreq_driver   *driver;
+
+
+	/* detect chipset */
+	speedstep_chipset =3D speedstep_detect_chipset();
+
+	/* detect chipset */
+	if (speedstep_chipset)
+		speedstep_processor =3D speedstep_detect_processor();
+
+	if ((!speedstep_chipset) || (!speedstep_processor)) {
+		dprintk(KERN_INFO "cpufreq: Intel(R) SpeedStep(TM) for this %s not (yet)=
 available.\n", speedstep_processor ? "chipset" : "processor");
+		return -ENODEV;
+	}
+
+	/* startup values, correct ones will be detected later */
+	speedstep_low_freq =3D 1;
+	speedstep_high_freq =3D 2;
+
+	dprintk(KERN_INFO "cpufreq: Intel(R) SpeedStep(TM) support $Revision: 1.4=
4 $\n");
+	dprintk(KERN_DEBUG "cpufreq: chipset 0x%x - processor 0x%x\n",=20
+	       speedstep_chipset, speedstep_processor);
+
+	/* activate speedstep support */
+	result =3D speedstep_activate();
+	if (result)
+		return result;
+
+	/* detect low and high frequency */
+	result =3D speedstep_detect_speeds();
+	if (result)
+		return result;
+
+	/* get current speed setting */
+	result =3D speedstep_get_frequency(&speed);
+	if (result)
+		return result;
+
+	dprintk(KERN_INFO "cpufreq: currently at %s speed setting - %i MHz\n",=20
+	       (speed =3D=3D speedstep_low_freq) ? "low" : "high",
+	       (speed / 1000));
+
+	/* initialization of main "cpufreq" code*/
+	driver =3D kmalloc(sizeof(struct cpufreq_driver) +
+		sizeof(struct cpufreq_freqs), GFP_KERNEL);
+	if (!driver)
+		return -ENOMEM;
+=09
+	driver->freq =3D (struct cpufreq_freqs*) (driver + sizeof(struct cpufreq_=
driver));
+	driver->sync =3D CPUFREQ_SYNC;
+	driver->freq->cpu =3D CPUFREQ_ALL_CPUS;
+	driver->freq->min =3D speedstep_low_freq;
+	driver->freq->max =3D speedstep_high_freq;
+	driver->freq->cur =3D speed;
+	driver->validate =3D &speedstep_validate_frequency;
+	driver->setspeed =3D &speedstep_set_frequency;
+
+	result =3D cpufreq_register(driver);
+	if (result) {
+		kfree(driver);
+		return result;
+	}
+	speedstep_driver =3D driver;
+
+	return 0;
+}
+
+
+/**
+ * speedstep_exit - unregisters SpeedStep support
+ *
+ *   Unregisters SpeedStep support.
+ */
+static void __exit speedstep_exit(void)
+{
+	if (speedstep_driver) {
+		cpufreq_unregister();
+		kfree(speedstep_driver);
+	}
+}
+
+
+MODULE_AUTHOR ("Dave Jones <davej@suse.de>, Dominik Brodowski <devel@brodo=
.de>");
+MODULE_DESCRIPTION ("Speedstep driver for Intel mobile processors.");
+MODULE_LICENSE ("GPL");
+module_init(speedstep_init);
+module_exit(speedstep_exit);

--zbGR4y+acU1DwHSi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iD8DBQE9bLg8Z8MDCHJbN8YRAswyAJ9lvpRCVSsj6AOORvWrPCxUyBrMdgCffRSQ
RBndPG/F9VF/+bXNcKzmg1g=
=Yw/b
-----END PGP SIGNATURE-----

--zbGR4y+acU1DwHSi--
