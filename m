Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263986AbSIQJlM>; Tue, 17 Sep 2002 05:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264002AbSIQJlM>; Tue, 17 Sep 2002 05:41:12 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:55028 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S263986AbSIQJji>; Tue, 17 Sep 2002 05:39:38 -0400
Date: Tue, 17 Sep 2002 11:34:50 +0200
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: hpa@transmeta.com, linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: [PATCH][2.5.35] CPUfreq i386 drivers (3/5)
Message-ID: <20020917113450.G25385@brodo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5L6AZ1aJH5mDrqCQ"
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5L6AZ1aJH5mDrqCQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

CPUFreq i386 drivers for 2.5.35:
arch/i386/config.in				Necessary config options
arch/i386/kernel/cpu/Makefile			allow for compilation of the CPUFreq subdir=
ectory
arch/i386/kernel/cpu/cpufreq/Makefile		Makefile for CPUFreq drivers
arch/i386/kernel/cpu/cpufreq/elanfreq.c		CPUFreq driver for AMD Elan proces=
sors
arch/i386/kernel/cpu/cpufreq/longhaul.c		CPUFreq driver for VIA Longhaul pr=
ocessors
arch/i386/kernel/cpu/cpufreq/longrun.c		CPUFreq driver for Transmeta Crusoe=
 processors
arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	CPUFreq driver for Pentium 4 Xeo=
n processors (using clock modulation)
arch/i386/kernel/cpu/cpufreq/powernow-k6.c	CPUFreq driver for mobile AMD K6=
-2+ and mobile AMD K6-3+ processors
arch/i386/kernel/cpu/cpufreq/speedstep.c	CPUFreq drivers for ICH2-M and ICH=
3-M chipsets and Intel Pentium 3-M and 4-M processors.

diff -ruN linux-2535original/arch/i386/config.in linux/arch/i386/config.in
--- linux-2535original/arch/i386/config.in	Tue Sep 17 09:25:17 2002
+++ linux/arch/i386/config.in	Tue Sep 17 10:02:14 2002
@@ -190,6 +190,18 @@
 dep_bool 'Check for non-fatal errors on Athlon/Duron' CONFIG_X86_MCE_NONFA=
TAL $CONFIG_X86_MCE
 dep_bool 'check for P4 thermal throttling interrupt.' CONFIG_X86_MCE_P4THE=
RMAL $CONFIG_X86_MCE $CONFIG_X86_UP_APIC
=20
+bool 'CPU Frequency scaling' CONFIG_CPU_FREQ
+if [ "$CONFIG_CPU_FREQ" =3D "y" ]; then
+   define_bool CONFIG_CPU_FREQ_26_API y
+   tristate ' AMD Mobile K6-2/K6-3 PowerNow!' CONFIG_X86_POWERNOW_K6
+   if [ "$CONFIG_MELAN" =3D "y" ]; then
+       tristate ' AMD Elan' CONFIG_ELAN_CPUFREQ
+   fi
+   tristate ' VIA Cyrix III Longhaul' CONFIG_X86_LONGHAUL
+   tristate ' Intel Speedstep' CONFIG_X86_SPEEDSTEP
+   tristate ' Intel Pentium 4 clock modulation' CONFIG_X86_P4_CLOCKMOD
+   tristate ' Transmeta LongRun' CONFIG_X86_LONGRUN
+fi
=20
 tristate 'Toshiba Laptop support' CONFIG_TOSHIBA
 tristate 'Dell laptop support' CONFIG_I8K
diff -ruN linux-2535original/arch/i386/kernel/cpu/Makefile linux/arch/i386/=
kernel/cpu/Makefile
--- linux-2535original/arch/i386/kernel/cpu/Makefile	Tue Sep 17 09:22:43 20=
02
+++ linux/arch/i386/kernel/cpu/Makefile	Tue Sep 17 09:34:25 2002
@@ -15,4 +15,9 @@
=20
 obj-$(CONFIG_MTRR)	+=3D mtrr/
=20
+ifdef CONFIG_CPU_FREQ
+obj-y   +=3D	cpufreq/
+obj-m   +=3D	cpufreq/
+endif
+
 include $(TOPDIR)/Rules.make
diff -ruN linux-2535original/arch/i386/kernel/cpu/cpufreq/Makefile linux/ar=
ch/i386/kernel/cpu/cpufreq/Makefile
--- linux-2535original/arch/i386/kernel/cpu/cpufreq/Makefile	Thu Jan  1 01:=
00:00 1970
+++ linux/arch/i386/kernel/cpu/cpufreq/Makefile	Tue Sep 17 09:35:42 2002
@@ -0,0 +1,10 @@
+O_TARGET :=3D built-in.o
+
+obj-$(CONFIG_X86_POWERNOW_K6)	+=3D powernow-k6.o
+obj-$(CONFIG_X86_LONGHAUL)	+=3D longhaul.o
+obj-$(CONFIG_X86_SPEEDSTEP)	+=3D speedstep.o
+obj-$(CONFIG_X86_P4_CLOCKMOD)	+=3D p4-clockmod.o
+obj-$(CONFIG_ELAN_CPUFREQ)	+=3D elanfreq.o
+obj-$(CONFIG_X86_LONGRUN)	+=3D longrun.o =20
+
+include $(TOPDIR)/Rules.make
diff -ruN linux-2535original/arch/i386/kernel/cpu/cpufreq/elanfreq.c linux/=
arch/i386/kernel/cpu/cpufreq/elanfreq.c
--- linux-2535original/arch/i386/kernel/cpu/cpufreq/elanfreq.c	Thu Jan  1 0=
1:00:00 1970
+++ linux/arch/i386/kernel/cpu/cpufreq/elanfreq.c	Tue Sep 17 09:35:10 2002
@@ -0,0 +1,336 @@
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
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/cpufreq.h>
+
+#include <asm/msr.h>
+#include <asm/timex.h>
+#include <asm/io.h>
+
+#define REG_CSCIR 0x22 		/* Chip Setup and Control Index Register    */
+#define REG_CSCDR 0x23		/* Chip Setup and Control Data  Register    */
+
+#define SAFE_FREQ 33000		/* every Elan CPU can run at 33 MHz         */
+
+static struct cpufreq_driver *elanfreq_driver;
+
+/* Module parameter */
+static int max_freq;
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Robert Schwebel <r.schwebel@pengutronix.de>, Sven Geggus <s=
ven@geggus.net>");
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
+	local_irq_disable();
+        outb_p(0x80,REG_CSCIR);
+        clockspeed_reg =3D inb_p(REG_CSCDR);
+	local_irq_enable();
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
+static void elanfreq_set_cpu_state (unsigned int state) {
+
+	struct cpufreq_freqs    freqs;
+
+	if (!elanfreq_driver) {
+		printk(KERN_ERR "cpufreq: initialization problem or invalid target frequ=
ency\n");
+		return;
+	}
+
+	freqs.old =3D elanfreq_get_cpu_frequency();
+	freqs.new =3D elan_multiplier[state].clock;
+	freqs.cpu =3D CPUFREQ_ALL_CPUS; /* elanfreq.c is UP only driver */
+=09
+	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+
+	printk(KERN_INFO "elanfreq: attempting to set frequency to %i kHz\n",elan=
_multiplier[state].clock);
+
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
+	local_irq_disable();
+	outb_p(0x40,REG_CSCIR); 	/* Disable hyperspeed mode          */
+	outb_p(0x00,REG_CSCDR);
+	local_irq_enable();		/* wait till internal pipelines and */
+	udelay(1000);			/* buffers have cleaned up          */
+
+	local_irq_disable();
+
+	/* now, set the CPU clock speed register (0x80) */
+	outb_p(0x80,REG_CSCIR);
+	outb_p(elan_multiplier[state].val80h,REG_CSCDR);
+
+	/* now, the hyperspeed bit in PMU Force Mode Register (0x40) */
+	outb_p(0x40,REG_CSCIR);
+	outb_p(elan_multiplier[state].val40h,REG_CSCDR);
+	udelay(10000);
+	local_irq_enable();
+
+	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+};
+
+
+/**
+ *	elanfreq_validatespeed: test if frequency range is valid=20
+ *
+ *	This function checks if a given frequency range in kHz is valid=20
+ *      for the hardware supported by the driver.=20
+ */
+
+static void elanfreq_verify (struct cpufreq_policy *policy)
+{
+	unsigned int    number_states =3D 0;
+	unsigned int    i;
+
+	if (!policy || !max_freq)
+		return;
+
+	policy->cpu =3D 0;
+
+	cpufreq_verify_within_limits(policy, 1000, max_freq);
+
+	for (i=3D(sizeof(elan_multiplier)/sizeof(struct s_elan_multiplier) - 1); =
i>=3D0; i--)
+		if ((elan_multiplier[i].clock >=3D policy->min) &&
+		    (elan_multiplier[i].clock <=3D policy->max))
+			number_states++;
+
+	if (number_states)
+		return;
+
+	for (i=3D(sizeof(elan_multiplier)/sizeof(struct s_elan_multiplier) - 1); =
i>=3D0; i--)
+		if (elan_multiplier[i].clock < policy->max)
+			break;
+
+	policy->max =3D elan_multiplier[i+1].clock;
+
+	return;
+}
+
+static void elanfreq_setpolicy (struct cpufreq_policy *policy)
+{
+	unsigned int    number_states =3D 0;
+	unsigned int    i, j=3D4;
+
+	if (!elanfreq_driver)
+		return;
+
+	for (i=3D(sizeof(elan_multiplier)/sizeof(struct s_elan_multiplier) - 1); =
i>=3D0; i--)
+		if ((elan_multiplier[i].clock >=3D policy->min) &&
+		    (elan_multiplier[i].clock <=3D policy->max))
+		{
+			number_states++;
+			j =3D i;
+		}
+
+	if (number_states =3D=3D 1) {
+		elanfreq_set_cpu_state(j);
+		return;
+	}
+
+	switch (policy->policy) {
+	case CPUFREQ_POLICY_POWERSAVE:
+		for (i=3D(sizeof(elan_multiplier)/sizeof(struct s_elan_multiplier) - 1);=
 i>=3D0; i--)
+			if ((elan_multiplier[i].clock >=3D policy->min) &&
+			    (elan_multiplier[i].clock <=3D policy->max))
+				j =3D i;
+		break;
+	case CPUFREQ_POLICY_PERFORMANCE:
+		for (i=3D0; i<(sizeof(elan_multiplier)/sizeof(struct s_elan_multiplier) =
- 1); i++)
+			if ((elan_multiplier[i].clock >=3D policy->min) &&
+			    (elan_multiplier[i].clock <=3D policy->max))
+				j =3D i;
+		break;
+	default:
+		return;
+	}
+
+	if (elan_multiplier[j].clock > max_freq)
+		BUG();
+
+	elanfreq_set_cpu_state(j);
+	return;
+}
+
+
+/*
+ *	Module init and exit code
+ */
+
+#ifndef MODULE
+/**
+ * elanfreq_setup - elanfreq command line parameter parsing
+ *
+ * elanfreq command line parameter.  Use:
+ *  elanfreq=3D66000
+ * to set the maximum CPU frequency to 66 MHz. Note that in
+ * case you do not give this boot parameter, the maximum
+ * frequency will fall back to _current_ CPU frequency which
+ * might be lower. If you build this as a module, use the
+ * max_freq module parameter instead.
+ */
+static int __init elanfreq_setup(char *str)
+{
+	max_freq =3D simple_strtoul(str, &str, 0);
+	return 1;
+}
+__setup("elanfreq=3D", elanfreq_setup);
+#endif
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
+			 NR_CPUS * sizeof(struct cpufreq_policy), GFP_KERNEL);
+	if (!driver)
+		return -ENOMEM;
+
+	driver->policy =3D (struct cpufreq_policy *) (driver + sizeof(struct cpuf=
req_driver));
+
+	if (!max_freq)
+		max_freq =3D elanfreq_get_cpu_frequency();
+
+#ifdef CONFIG_CPU_FREQ_24_API
+	driver->cpu_min_freq    =3D 1000;
+	driver->cpu_cur_freq[0] =3D elanfreq_get_cpu_frequency();
+#endif
+
+	driver->verify        =3D &elanfreq_verify;
+	driver->setpolicy     =3D &elanfreq_setpolicy;
+
+	driver->policy[0].cpu    =3D 0;
+	driver->policy[0].min    =3D 1000;
+	driver->policy[0].max    =3D max_freq;
+	driver->policy[0].policy =3D CPUFREQ_POLICY_PERFORMANCE;
+	driver->policy[0].max_cpu_freq  =3D max_freq;
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
+MODULE_PARM (max_freq, "i");
+
diff -ruN linux-2535original/arch/i386/kernel/cpu/cpufreq/longhaul.c linux/=
arch/i386/kernel/cpu/cpufreq/longhaul.c
--- linux-2535original/arch/i386/kernel/cpu/cpufreq/longhaul.c	Thu Jan  1 0=
1:00:00 1970
+++ linux/arch/i386/kernel/cpu/cpufreq/longhaul.c	Tue Sep 17 09:35:18 2002
@@ -0,0 +1,820 @@
+/*
+ *  $Id: longhaul.c,v 1.70 2002/09/12 10:22:17 db Exp $
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
+#include <linux/init.h>
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
+
+static int longhaul_get_cpu_fsb (void)
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
+static int longhaul_get_cpu_mult (void)
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
+/**
+ * longhaul_set_cpu_frequency()
+ * @clock_ratio_index : index of clock_ratio[] for new frequency
+ * @newfsb: the new FSB
+ *
+ * Sets a new clock ratio, and -if applicable- a new Front Side Bus
+ */
+
+static void longhaul_setstate (unsigned int clock_ratio_index, unsigned in=
t newfsb)
+{
+	unsigned long lo, hi;
+	unsigned int bits;
+	int revkey;
+	int vidindex, i;
+	struct cpufreq_freqs freqs;
+=09
+	if (!newfsb || (clock_ratio[clock_ratio_index] =3D=3D -1))
+		return;
+
+	if ((!can_scale_fsb) && (newfsb !=3D current_fsb))
+		return;
+
+	freqs.old =3D longhaul_get_cpu_mult() * longhaul_get_cpu_fsb() * 100;
+	freqs.new =3D clock_ratio[clock_ratio_index] * newfsb * 100;
+	freqs.cpu =3D CPUFREQ_ALL_CPUS; /* longhaul.c is UP only driver */
+=09
+	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+
+	dprintk (KERN_INFO "longhaul: New FSB:%d Mult(x10):%d\n",
+				newfsb, clock_ratio[clock_ratio_index]);
+
+	bits =3D clock_ratio_index;
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
+				vidindex =3D (((highest_speed-lowest_speed) / (newfsb/2)) -
+						((highest_speed-((clock_ratio[clock_ratio_index] * newfsb * 100)/100=
0)) / (newfsb/2)));
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
+			switch (newfsb) {
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
+
+	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
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
+static inline unsigned int longhaul_statecount_fsb(struct cpufreq_policy *=
policy, unsigned int fsb) {
+	unsigned int i, count =3D 0;
+
+	for(i=3D0; i<numscales; i++) {
+		if ((clock_ratio[i] !=3D -1) &&
+		    ((clock_ratio[i] * fsb * 100) <=3D policy->max) &&
+		    ((clock_ratio[i] * fsb * 100) >=3D policy->min))
+			count++;
+	}
+
+	return count;
+}
+
+
+static void longhaul_verify(struct cpufreq_policy *policy)
+{
+	unsigned int    number_states =3D 0;
+	unsigned int    i;
+	unsigned int    fsb_index =3D 0;
+	unsigned int    tmpfreq =3D 0;
+	unsigned int    newmax =3D -1;
+
+	if (!policy || !longhaul_driver)
+		return;
+
+	policy->cpu =3D 0;
+	cpufreq_verify_within_limits(policy, lowest_speed, highest_speed);
+
+	if (can_scale_fsb=3D=3D1) {
+		for (fsb_index=3D0; fsb_search_table[fsb_index]!=3D-1; fsb_index++)
+			number_states +=3D longhaul_statecount_fsb(policy, fsb_search_table[fsb=
_index]);
+	} else
+		number_states =3D longhaul_statecount_fsb(policy, current_fsb);
+
+	if (number_states)
+		return;
+
+	/* get frequency closest above current policy->max */
+	if (can_scale_fsb=3D=3D1) {
+		for (fsb_index=3D0; fsb_search_table[fsb_index] !=3D -1; fsb_index++)
+			for(i=3D0; i<numscales; i++) {
+				if (clock_ratio[i] =3D=3D -1)
+					continue;
+
+				tmpfreq =3D clock_ratio[i] * fsb_search_table[fsb_index];
+				if ((tmpfreq > policy->max) &&
+				    (tmpfreq < newmax))
+					newmax =3D tmpfreq;
+			}
+	} else {
+		for(i=3D0; i<numscales; i++) {
+			if (clock_ratio[i] =3D=3D -1)
+				continue;
+
+			tmpfreq =3D clock_ratio[i] * current_fsb;
+			if ((tmpfreq > policy->max) &&
+			    (tmpfreq < newmax))
+				newmax =3D tmpfreq;
+			}
+	}
+
+	policy->max =3D newmax;
+}
+
+
+static void longhaul_setpolicy (struct cpufreq_policy *policy)
+{
+	unsigned int    number_states =3D 0;
+	unsigned int    i;
+	unsigned int    fsb_index =3D 0;
+	unsigned int    new_fsb =3D 0;
+	unsigned int    new_clock_ratio =3D 0;
+	unsigned int    best_freq =3D -1;
+
+	if (!longhaul_driver)
+		return;
+
+	if (policy->policy=3D=3DCPUFREQ_POLICY_PERFORMANCE)
+		fsb_search_table =3D perf_fsb_table;
+	else
+		fsb_search_table =3D power_fsb_table;
+
+	if (can_scale_fsb=3D=3D1) {
+		for (fsb_index=3D0; fsb_search_table[fsb_index]!=3D-1; fsb_index++)=20
+		{
+			unsigned int tmpcount =3D longhaul_statecount_fsb(policy, fsb_search_ta=
ble[fsb_index]);
+			if (tmpcount =3D=3D 1)
+				new_fsb =3D fsb_search_table[fsb_index];
+			number_states +=3D tmpcount;
+		}
+	} else {
+		number_states =3D longhaul_statecount_fsb(policy, current_fsb);
+		new_fsb =3D current_fsb;
+	}
+
+	if (!number_states)
+		return;
+	else if (number_states =3D=3D 1) {
+		for(i=3D0; i<numscales; i++) {
+			if ((clock_ratio[i] !=3D -1) &&
+			    ((clock_ratio[i] * new_fsb * 100) <=3D policy->max) &&
+			    ((clock_ratio[i] * new_fsb * 100) >=3D policy->min))
+				new_clock_ratio =3D i;
+		}
+		longhaul_setstate(new_clock_ratio, new_fsb);
+	}
+
+	switch (policy->policy) {
+	case CPUFREQ_POLICY_POWERSAVE:
+		best_freq =3D -1;
+		if (can_scale_fsb=3D=3D1) {
+			for (fsb_index=3D0; fsb_search_table[fsb_index]!=3D-1; fsb_index++)=20
+			{
+				for(i=3D0; i<numscales; i++) {
+					unsigned int tmpfreq =3D fsb_search_table[fsb_index] * clock_ratio[i]=
 * 100;
+					if (clock_ratio[i] =3D=3D -1)
+						continue;
+
+					if ((tmpfreq >=3D policy->min) &&
+					    (tmpfreq <=3D policy->max) &&
+					    (tmpfreq < best_freq)) {
+						new_clock_ratio =3D i;
+						new_fsb =3D fsb_search_table[fsb_index];
+					}
+				}
+			}
+		} else {
+			for(i=3D0; i<numscales; i++) {
+				unsigned int tmpfreq =3D current_fsb * clock_ratio[i] * 100;
+					if (clock_ratio[i] =3D=3D -1)
+						continue;
+
+					if ((tmpfreq >=3D policy->min) &&
+					    (tmpfreq <=3D policy->max) &&
+					    (tmpfreq < best_freq)) {
+						new_clock_ratio =3D i;
+						new_fsb =3D current_fsb;
+					}
+				}
+		}
+		break;
+	case CPUFREQ_POLICY_PERFORMANCE:
+		best_freq =3D 0;
+		if (can_scale_fsb=3D=3D1) {
+			for (fsb_index=3D0; fsb_search_table[fsb_index]!=3D-1; fsb_index++)=20
+			{
+				for(i=3D0; i<numscales; i++) {
+					unsigned int tmpfreq =3D fsb_search_table[fsb_index] * clock_ratio[i]=
 * 100;
+					if (clock_ratio[i] =3D=3D -1)
+						continue;
+
+					if ((tmpfreq >=3D policy->min) &&
+					    (tmpfreq <=3D policy->max) &&
+					    (tmpfreq > best_freq)) {
+						new_clock_ratio =3D i;
+						new_fsb =3D fsb_search_table[fsb_index];
+					}
+				}
+			}
+		} else {
+			for(i=3D0; i<numscales; i++) {
+				unsigned int tmpfreq =3D current_fsb * clock_ratio[i] * 100;
+					if (clock_ratio[i] =3D=3D -1)
+						continue;
+
+					if ((tmpfreq >=3D policy->min) &&
+					    (tmpfreq <=3D policy->max) &&
+					    (tmpfreq > best_freq)) {
+						new_clock_ratio =3D i;
+						new_fsb =3D current_fsb;
+					}
+				}
+		}
+		break;
+	default:
+		return;
+	}
+
+	longhaul_setstate(new_clock_ratio, new_fsb);
+	return;
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
+	driver =3D kmalloc(sizeof(struct cpufreq_driver) +=20
+			 NR_CPUS * sizeof(struct cpufreq_policy), GFP_KERNEL);
+	if (!driver)
+		return -ENOMEM;
+
+	driver->policy =3D (struct cpufreq_policy *) (driver + sizeof(struct cpuf=
req_driver));
+
+#ifdef CONFIG_CPU_FREQ_24_API
+	driver->cpu_min_freq    =3D (unsigned int) lowest_speed;
+	driver->cpu_cur_freq[0] =3D currentspeed;
+#endif
+
+	driver->verify    =3D &longhaul_verify;
+	driver->setpolicy =3D &longhaul_setpolicy;
+
+	driver->policy[0].cpu =3D 0;
+	driver->policy[0].min =3D (unsigned int) lowest_speed;
+	driver->policy[0].max =3D (unsigned int) highest_speed;
+	driver->policy[0].policy =3D CPUFREQ_POLICY_PERFORMANCE;
+	driver->policy[0].max_cpu_freq =3D (unsigned int) highest_speed;
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
+
+MODULE_AUTHOR ("Dave Jones <davej@suse.de>");
+MODULE_DESCRIPTION ("Longhaul driver for VIA Cyrix processors.");
+MODULE_LICENSE ("GPL");
+
+module_init(longhaul_init);
+module_exit(longhaul_exit);
+
diff -ruN linux-2535original/arch/i386/kernel/cpu/cpufreq/longrun.c linux/a=
rch/i386/kernel/cpu/cpufreq/longrun.c
--- linux-2535original/arch/i386/kernel/cpu/cpufreq/longrun.c	Thu Jan  1 01=
:00:00 1970
+++ linux/arch/i386/kernel/cpu/cpufreq/longrun.c	Tue Sep 17 09:35:15 2002
@@ -0,0 +1,175 @@
+/*
+ *  $Id: longrun.c,v 1.6 2002/09/12 10:22:18 db Exp $
+ *
+ * (C) 2002  Dominik Brodowski <devel@brodo.de>
+ *
+ *  Licensed under the terms of the GNU GPL License version 2.
+ *
+ *  BIG FAT DISCLAIMER: Work in progress code. Possibly *dangerous*
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>=20
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/cpufreq.h>
+
+#include <asm/msr.h>
+#include <asm/processor.h>
+#include <asm/timex.h>
+
+static struct cpufreq_driver	*longrun_driver;
+
+
+/**
+ * longrun_get_policy - get the current LongRun policy
+ * @policy: struct cpufreq_policy where current policy is written into
+ *
+ * Reads the current LongRun policy by access to MSR_TMTA_LONGRUN_FLAGS
+ * and MSR_TMTA_LONGRUN_CTRL
+ */
+static void longrun_get_policy(struct cpufreq_policy *policy)
+{
+	u32 msr_lo, msr_hi;
+
+	if (!longrun_driver)
+		return;
+
+	rdmsr(MSR_TMTA_LONGRUN_FLAGS, msr_lo, msr_hi);
+	if (msr_lo & 0x01)
+		policy->policy =3D CPUFREQ_POLICY_PERFORMANCE;
+	else
+		policy->policy =3D CPUFREQ_POLICY_POWERSAVE;
+=09
+	rdmsr(MSR_TMTA_LONGRUN_CTRL, msr_lo, msr_hi);
+	msr_lo &=3D 0x0000007F;
+	msr_hi &=3D 0x0000007F;
+
+	policy->min =3D msr_lo * (longrun_driver->policy[0].max_cpu_freq / 100);
+	policy->max =3D msr_hi * (longrun_driver->policy[0].max_cpu_freq / 100);
+	policy->cpu =3D 0;
+}
+
+
+/**
+ * longrun_set_policy - sets a new CPUFreq policy
+ * @policy - new policy
+ *
+ * Sets a new CPUFreq policy on LongRun-capable processors. This function
+ * has to be called with cpufreq_driver locked.
+ */
+static void longrun_set_policy(struct cpufreq_policy *policy)
+{
+	u32 msr_lo, msr_hi;
+	u32 pctg_lo, pctg_hi;
+
+	if (!longrun_driver || !policy)
+		return;
+
+	pctg_lo =3D (policy->min * 100) / policy->max_cpu_freq;
+	pctg_hi =3D (policy->max * 100) / policy->max_cpu_freq;
+
+	if (pctg_hi > 100)
+		pctg_hi =3D 100;
+	if (pctg_lo > pctg_hi)
+		pctg_lo =3D pctg_hi;
+
+	/* performance or economy mode */
+	rdmsr(MSR_TMTA_LONGRUN_FLAGS, msr_lo, msr_hi);
+	msr_lo &=3D 0xFFFFFFFE;
+	switch (policy->policy) {
+	case CPUFREQ_POLICY_PERFORMANCE:
+		msr_lo |=3D 0x00000001;
+		break;
+	case CPUFREQ_POLICY_POWERSAVE:
+		break;
+	}
+	wrmsr(MSR_TMTA_LONGRUN_FLAGS, msr_lo, msr_hi);
+
+	/* lower and upper boundary */
+	rdmsr(MSR_TMTA_LONGRUN_CTRL, msr_lo, msr_hi);
+	msr_lo &=3D 0xFFFFFF80;
+	msr_hi &=3D 0xFFFFFF80;
+	msr_lo |=3D pctg_lo;
+	msr_hi |=3D pctg_hi;
+	wrmsr(MSR_TMTA_LONGRUN_CTRL, msr_lo, msr_hi);=09
+
+	return;
+}
+
+
+/**
+ * longrun_verify_poliy - verifies a new CPUFreq policy
+ *
+ * Validates a new CPUFreq policy. This function has to be called with=20
+ * cpufreq_driver locked.
+ */
+static void longrun_verify_policy(struct cpufreq_policy *policy)
+{
+	if (!policy || !longrun_driver)
+		return;
+
+	policy->cpu =3D 0;
+	cpufreq_verify_within_limits(policy, 0,=20
+		longrun_driver->policy[0].max_cpu_freq);
+
+	return;
+}
+
+
+/**
+ * longrun_init - initializes the Transmeta Crusoe LongRun CPUFreq driver
+ *
+ * Initializes the LongRun support.
+ */
+static int __init longrun_init(void)
+{
+	int                     result;
+	struct cpufreq_driver   *driver;
+	struct cpuinfo_x86 *c =3D cpu_data;
+
+	if (c->x86_vendor !=3D X86_VENDOR_TRANSMETA ||=20
+	    !cpu_has(c, X86_FEATURE_LONGRUN))
+		return 0;
+
+	/* initialization of main "cpufreq" code*/
+	driver =3D kmalloc(sizeof(struct cpufreq_driver) +=20
+			 NR_CPUS * sizeof(struct cpufreq_policy), GFP_KERNEL);
+	if (!driver)
+		return -ENOMEM;
+
+	driver->policy =3D (struct cpufreq_policy *) (driver + sizeof(struct cpuf=
req_driver));
+
+	driver->policy[0].max_cpu_freq  =3D cpu_khz;
+	longrun_get_policy(&driver->policy[0]);
+
+	driver->verify         =3D &longrun_verify_policy;
+	driver->setpolicy      =3D &longrun_set_policy;
+	result =3D cpufreq_register(driver);
+	if (result) {
+		kfree(driver);
+		return result;
+	}
+	longrun_driver =3D driver;
+
+	return 0;
+}
+
+
+/**
+ * longrun_exit - unregisters LongRun support
+ */
+static void __exit longrun_exit(void)
+{
+	if (longrun_driver) {
+		cpufreq_unregister();
+		kfree(longrun_driver);
+	}
+}
+
+
+MODULE_AUTHOR ("Dominik Brodowski <devel@brodo.de>");
+MODULE_DESCRIPTION ("LongRun driver for Transmeta Crusoe processors.");
+MODULE_LICENSE ("GPL");
+module_init(longrun_init);
+module_exit(longrun_exit);
diff -ruN linux-2535original/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c lin=
ux/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
--- linux-2535original/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	Thu Jan  =
1 01:00:00 1970
+++ linux/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	Tue Sep 17 09:35:22 20=
02
@@ -0,0 +1,285 @@
+/*
+ *	Pentium 4/Xeon CPU on demand clock modulation/speed scaling
+ *	(C) 2002 Zwane Mwaikambo <zwane@commfireservices.com>
+ *	(C) 2002 Arjan van de Ven <arjanv@redhat.com>
+ *	(C) 2002 Tora T. Engstad
+ *	All Rights Reserved
+ *
+ *	This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ *
+ *      The author(s) of this software shall not be held liable for damages
+ *      of any nature resulting due to the use of this software. This
+ *      software is provided AS-IS with no warranties.
+ *=09
+ *	Date		Errata			Description
+ *	20020525	N44, O17	12.5% or 25% DC causes lockup
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>=20
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/cpufreq.h>
+#include <linux/slab.h>
+#include <linux/sched.h>
+
+#include <asm/processor.h>=20
+#include <asm/msr.h>
+#include <asm/timex.h>
+
+#define PFX	"cpufreq: "
+
+/*
+ * Duty Cycle (3bits), note DC_DISABLE is not specified in
+ * intel docs i just use it to mean disable
+ */
+enum {
+	DC_RESV, DC_DFLT, DC_25PT, DC_38PT, DC_50PT,
+	DC_64PT, DC_75PT, DC_88PT, DC_DISABLE
+};
+
+#define DC_ENTRIES	8
+
+
+static int has_N44_O17_errata;
+static int stock_freq;
+MODULE_PARM(stock_freq, "i");
+
+static struct cpufreq_driver *cpufreq_p4_driver;
+static unsigned int cpufreq_p4_old_state =3D 0;
+
+
+static int cpufreq_p4_setdc(unsigned int cpu, unsigned int newstate)
+{
+	u32 l, h;
+	unsigned long cpus_allowed;
+	struct cpufreq_freqs    freqs;
+
+	if (!cpu_online(cpu) || (newstate > DC_DISABLE) ||=20
+		(newstate =3D=3D DC_RESV))
+		return -EINVAL;
+	cpu =3D cpu >> 1; /* physical CPU #nr */
+
+	/* notifiers */
+	freqs.old =3D stock_freq * cpufreq_p4_old_state / 8;
+	freqs.new =3D stock_freq * newstate / 8;
+	freqs.cpu =3D 2*cpu;
+	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	freqs.cpu++;
+	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+
+	/* switch to physical CPU where state is to be changed*/
+	cpus_allowed =3D current->cpus_allowed;
+	set_cpus_allowed(current, 2 << (2 * cpu));
+	BUG_ON(cpu !=3D (smp_processor_id() >> 1));
+
+	rdmsr(MSR_IA32_THERM_STATUS, l, h);
+	if (l & 0x01)
+		printk(KERN_DEBUG PFX "CPU#%d currently thermal throttled\n", cpu);
+
+	if (has_N44_O17_errata && (newstate =3D=3D DC_25PT || newstate =3D=3D DC_=
DFLT))
+		newstate =3D DC_38PT;
+
+	rdmsr(MSR_IA32_THERM_CONTROL, l, h);
+	if (newstate =3D=3D DC_DISABLE) {
+		printk(KERN_INFO PFX "CPU#%d,%d disabling modulation\n", cpu, (cpu + 1));
+		wrmsr(MSR_IA32_THERM_CONTROL, l & ~(1<<4), h);
+	} else {
+		printk(KERN_INFO PFX "CPU#%d,%d setting duty cycle to %d%%\n", cpu, (cpu=
 + 1), ((125 * newstate) / 10));
+		/* bits 63 - 5	: reserved=20
+		 * bit  4	: enable/disable
+		 * bits 3-1	: duty cycle
+		 * bit  0	: reserved
+		 */
+		l =3D (l & ~14);
+		l =3D l | (1<<4) | ((newstate & 0x7)<<1);
+		wrmsr(MSR_IA32_THERM_CONTROL, l, h);
+	}
+
+	set_cpus_allowed(current, cpus_allowed);
+
+	/* notifiers */
+	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	freqs.cpu--;
+	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	cpufreq_p4_old_state =3D newstate;
+
+	return 0;
+}
+
+
+static void cpufreq_p4_setpolicy(struct cpufreq_policy *policy)
+{
+	unsigned int    i;
+	unsigned int    newstate =3D 0;
+	unsigned int    number_states =3D 0;
+
+	if (!cpufreq_p4_driver || !stock_freq || !policy)
+		return;
+
+	if (policy->policy =3D=3D CPUFREQ_POLICY_POWERSAVE)
+	{
+		for (i=3D8; i>0; i++)
+			if ((policy->min <=3D ((stock_freq / 8) * i)) &&
+			    (policy->max >=3D ((stock_freq / 8) * i)))=20
+			{
+				newstate =3D i;
+				number_states++;
+			}
+	} else {
+		for (i=3D0; i<=3D8; i--)
+			if ((policy->min <=3D ((stock_freq / 8) * i)) &&
+			    (policy->max >=3D ((stock_freq / 8) * i)))=20
+			{
+				newstate =3D i;
+				number_states++;
+			}
+	}
+
+	/* if (number_states =3D=3D 1) */
+	{
+		if (policy->cpu =3D=3D CPUFREQ_ALL_CPUS) {
+			for (i=3D0; i<(NR_CPUS/2); i++)
+				if (cpu_online(2*i))
+					cpufreq_p4_setdc((2*i), newstate);
+		} else {
+			cpufreq_p4_setdc(policy->cpu, newstate);
+		}
+	}
+	/* else {
+		if (policy->policy =3D=3D CPUFREQ_POLICY_POWERSAVE) {
+			min_state =3D newstate;
+			max_state =3D newstate + (number_states - 1);
+		} else {
+			max_state =3D newstate;
+			min_state =3D newstate - (number_states - 1);
+		}
+	} */
+}
+
+
+static void cpufreq_p4_verify(struct cpufreq_policy *policy)
+{
+	unsigned int    number_states =3D 0;
+	unsigned int    i;
+
+	if (!cpufreq_p4_driver || !stock_freq || !policy)
+		return;
+
+	if (!cpu_online(policy->cpu))
+		policy->cpu =3D CPUFREQ_ALL_CPUS;
+	cpufreq_verify_within_limits(policy, (stock_freq / 8), stock_freq);
+
+	/* is there at least one state within limit? */
+	for (i=3D1; i<=3D8; i++)
+		if ((policy->min <=3D ((stock_freq / 8) * i)) &&
+		    (policy->max >=3D ((stock_freq / 8) * i)))
+			number_states++;
+
+	if (number_states)
+		return;
+
+	policy->max =3D (stock_freq / 8) * (((unsigned int) ((policy->max * 8) / =
stock_freq)) + 1);
+	return;
+}
+
+
+int __init cpufreq_p4_init(void)
+{=09
+	struct cpuinfo_x86 *c =3D cpu_data;
+	int cpuid;
+	int ret;
+	struct cpufreq_driver *driver;
+	unsigned int i;
+
+	/*
+	 * THERM_CONTROL is architectural for IA32 now, so=20
+	 * we can rely on the capability checks
+	 */
+	if (c->x86_vendor !=3D X86_VENDOR_INTEL)
+		return -ENODEV;
+
+	if (!test_bit(X86_FEATURE_ACPI, c->x86_capability) ||
+		!test_bit(X86_FEATURE_ACC, c->x86_capability))
+		return -ENODEV;
+
+	/* Errata workarounds */
+	cpuid =3D (c->x86 << 8) | (c->x86_model << 4) | c->x86_mask;
+	switch (cpuid) {
+		case 0x0f07:
+		case 0x0f0a:
+		case 0x0f11:
+		case 0x0f12:
+			has_N44_O17_errata =3D 1;
+		default:
+			break;
+	}
+
+	printk(KERN_INFO PFX "P4/Xeon(TM) CPU On-Demand Clock Modulation availabl=
e\n");
+	driver =3D kmalloc(sizeof(struct cpufreq_driver) +
+			 NR_CPUS * sizeof(struct cpufreq_freqs), GFP_KERNEL);
+	if (!driver)
+		return -ENOMEM;
+
+	driver->policy =3D (struct cpufreq_policy *) (driver + sizeof(struct cpuf=
req_driver));
+
+	if (!stock_freq)
+		stock_freq =3D cpu_khz;
+
+#ifdef CONFIG_CPU_FREQ_24_API
+	driver->cpu_min_freq    =3D stock_freq / 8;
+	for (i=3D0;i<NR_CPUS;i++)
+		driver->cpu_cur_freq[i] =3D stock_freq;
+#endif
+	cpufreq_p4_old_state  =3D DC_DISABLE;
+
+	driver->verify        =3D &cpufreq_p4_verify;
+	driver->setpolicy     =3D &cpufreq_p4_setpolicy;
+
+	for (i=3D0;i<NR_CPUS;i++) {
+		if (has_N44_O17_errata)
+			driver->policy[i].min    =3D (stock_freq * 3) / 8;
+		else
+			driver->policy[i].min    =3D stock_freq / 8;
+		driver->policy[i].max    =3D stock_freq;
+		driver->policy[i].policy =3D CPUFREQ_POLICY_PERFORMANCE;
+		driver->policy[i].max_cpu_freq  =3D stock_freq;
+		driver->policy[i].cpu    =3D i;
+	}
+
+	ret =3D cpufreq_register(driver);
+	if (ret) {
+		kfree(driver);
+		return ret;
+	}
+
+	cpufreq_p4_driver =3D driver;
+=09
+	return 0;
+}
+
+
+void __exit cpufreq_p4_exit(void)
+{
+	u32 l, h;
+
+	if (cpufreq_p4_driver) {
+		cpufreq_unregister();
+		/* return back to a non modulated state */
+		rdmsr(MSR_IA32_THERM_CONTROL, l, h);
+		wrmsr(MSR_IA32_THERM_CONTROL, l & ~(1<<4), h);
+		kfree(cpufreq_p4_driver);
+	}
+}
+
+MODULE_AUTHOR ("Zwane Mwaikambo <zwane@commfireservices.com>");
+MODULE_DESCRIPTION ("cpufreq driver for Pentium(TM) 4/Xeon(TM)");
+MODULE_LICENSE ("GPL");
+
+module_init(cpufreq_p4_init);
+module_exit(cpufreq_p4_exit);
+
diff -ruN linux-2535original/arch/i386/kernel/cpu/cpufreq/powernow-k6.c lin=
ux/arch/i386/kernel/cpu/cpufreq/powernow-k6.c
--- linux-2535original/arch/i386/kernel/cpu/cpufreq/powernow-k6.c	Thu Jan  =
1 01:00:00 1970
+++ linux/arch/i386/kernel/cpu/cpufreq/powernow-k6.c	Tue Sep 17 09:35:26 20=
02
@@ -0,0 +1,294 @@
+/*
+ *  $Id: powernow-k6.c,v 1.30 2002/09/12 10:22:18 db Exp $
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
+#include <linux/init.h>
+#include <linux/cpufreq.h>
+#include <linux/ioport.h>
+#include <linux/slab.h>
+
+#include <asm/msr.h>
+#include <asm/timex.h>
+#include <asm/io.h>
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
+ * powernow_k6_set_state - set the PowerNow! multiplier
+ * @best_i: clock_ratio[best_i] is the target multiplier
+ *
+ *   Tries to change the PowerNow! multiplier
+ */
+static void powernow_k6_set_state (unsigned int best_i)
+{
+	unsigned long           outvalue=3D0, invalue=3D0;
+	unsigned long           msrval;
+	struct cpufreq_freqs    freqs;
+
+	if (!powernow_driver) {
+		printk(KERN_ERR "cpufreq: initialization problem or invalid target frequ=
ency\n");
+		return;
+	}
+
+	freqs.old =3D busfreq * powernow_k6_get_cpu_multiplier();
+	freqs.new =3D busfreq * clock_ratio[best_i];
+	freqs.cpu =3D CPUFREQ_ALL_CPUS; /* powernow-k6.c is UP only driver */
+=09
+	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+
+	/* we now need to transform best_i to the BVC format, see AMD#23446 */
+
+	outvalue =3D (1<<12) | (1<<10) | (1<<9) | (best_i<<5);
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
+	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+
+	return;
+}
+
+
+/**
+ * powernow_k6_verify - verifies a new CPUfreq policy
+ * @policy: new policy
+ *
+ * Policy must be within lowest and highest possible CPU Frequency,
+ * and at least one possible state must be within min and max.
+ */
+static void powernow_k6_verify(struct cpufreq_policy *policy)
+{
+	unsigned int    number_states =3D 0;
+	unsigned int    i, j;
+
+	if (!policy || !busfreq)
+		return;
+
+	policy->cpu =3D 0;
+	cpufreq_verify_within_limits(policy, (20 * busfreq),
+				     (max_multiplier * busfreq));
+
+	for (i=3D0; i<8; i++)
+		if ((policy->min <=3D (busfreq * clock_ratio[i])) &&
+		    (policy->max >=3D (busfreq * clock_ratio[i])))
+			number_states++;
+
+	if (number_states)
+		return;
+
+	/* no state is available within range -- find next larger state */
+
+	j =3D 6;
+
+	for (i=3D0; i<8; i++)
+		if (((clock_ratio[i] * busfreq) >=3D policy->min) &&
+		    (clock_ratio[i] < clock_ratio[j]))
+			j =3D i;
+
+	policy->max =3D clock_ratio[j] * busfreq;
+
+	return;
+}
+
+
+/**
+ * powernow_k6_setpolicy - sets a new CPUFreq policy
+ * @policy - new policy
+ *
+ * sets a new CPUFreq policy
+ */
+static void powernow_k6_setpolicy (struct cpufreq_policy *policy)
+{
+	unsigned int    number_states =3D 0;
+	unsigned int    i, j=3D4;
+
+	if (!powernow_driver)
+		return;
+
+	for (i=3D0; i<8; i++)
+		if ((policy->min <=3D (busfreq * clock_ratio[i])) &&
+		    (policy->max >=3D (busfreq * clock_ratio[i])))
+		{
+			number_states++;
+			j =3D i;
+		}
+
+	if (number_states =3D=3D 1) {
+		/* if only one state is within the limit borders, it
+		   is easily detected and set */
+		powernow_k6_set_state(j);
+		return;
+	}
+
+	/* more than one state within limit */
+	switch (policy->policy) {
+	case CPUFREQ_POLICY_POWERSAVE:
+		j =3D 6;
+		for (i=3D0; i<8; i++)
+		if ((policy->min <=3D (busfreq * clock_ratio[i])) &&
+		    (policy->max >=3D (busfreq * clock_ratio[i])) &&
+			    (clock_ratio[i] < clock_ratio[j]))
+				j =3D i;
+		break;
+	case CPUFREQ_POLICY_PERFORMANCE:
+		j =3D 4;
+		for (i=3D0; i<8; i++)
+		if ((policy->min <=3D (busfreq * clock_ratio[i])) &&
+		    (policy->max >=3D (busfreq * clock_ratio[i])) &&
+			    (clock_ratio[i] > clock_ratio[j]))
+				j =3D i;
+		break;
+	default:
+		return;
+	}
+
+	if (clock_ratio[i] > max_multiplier)
+		BUG();
+
+	powernow_k6_set_state(j);
+	return;
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
+
+	if ((c->x86_vendor !=3D X86_VENDOR_AMD) || (c->x86 !=3D 5) ||
+		((c->x86_model !=3D 12) && (c->x86_model !=3D 13)))
+		return -ENODEV;
+
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
+			 NR_CPUS * sizeof(struct cpufreq_freqs), GFP_KERNEL);
+	if (!driver) {
+		release_region (POWERNOW_IOPORT, 16);
+		return -ENOMEM;
+	}
+	driver->policy =3D (struct cpufreq_policy *) (driver + sizeof(struct cpuf=
req_driver));
+
+#ifdef CONFIG_CPU_FREQ_24_API
+	driver->cpu_min_freq     =3D busfreq * 20;
+	driver->cpu_cur_freq[0]  =3D busfreq * max_multiplier;
+#endif
+
+	driver->verify        =3D &powernow_k6_verify;
+	driver->setpolicy     =3D &powernow_k6_setpolicy;
+
+	driver->policy[0].cpu    =3D 0;
+	driver->policy[0].min    =3D busfreq * 20;
+	driver->policy[0].max    =3D busfreq * max_multiplier;
+	driver->policy[0].policy =3D CPUFREQ_POLICY_PERFORMANCE;
+	driver->policy[0].max_cpu_freq  =3D busfreq * max_multiplier;
+
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
+	unsigned int i;
+
+	if (powernow_driver) {
+		for (i=3D0;i<8;i++)
+			if (clock_ratio[i] =3D=3D max_multiplier)
+				powernow_k6_set_state(i);	=09
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
diff -ruN linux-2535original/arch/i386/kernel/cpu/cpufreq/speedstep.c linux=
/arch/i386/kernel/cpu/cpufreq/speedstep.c
--- linux-2535original/arch/i386/kernel/cpu/cpufreq/speedstep.c	Thu Jan  1 =
01:00:00 1970
+++ linux/arch/i386/kernel/cpu/cpufreq/speedstep.c	Tue Sep 17 09:35:29 2002
@@ -0,0 +1,706 @@
+/*
+ *  $Id: speedstep.c,v 1.48 2002/09/12 10:22:18 db Exp $
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
+#include <linux/init.h>
+#include <linux/cpufreq.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+
+#include <asm/msr.h>
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
+#define SPEEDSTEP_HIGH                  0x00000000
+#define SPEEDSTEP_LOW                   0x00000001
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
+ * speedstep_get_state - read the current SpeedStep state
+ * @state: Speedstep state (SPEEDSTEP_LOW or SPEEDSTEP_HIGH)
+ *
+ *   Tries to read the SpeedStep state. Returns -EIO when there has been
+ * trouble to read the status or write to the control register, -EINVAL
+ * on an unsupported chipset, and zero on success.
+ */
+static int speedstep_get_state (unsigned int *state)
+{
+	u32             pmbase;
+	u8              value;
+
+	if (!speedstep_chipset_dev || !state)
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
+		*state =3D value & 0x01;
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
+ * speedstep_set_state - set the SpeedStep state
+ * @state: new processor frequency state (SPEEDSTEP_LOW or SPEEDSTEP_HIGH)
+ *
+ *   Tries to change the SpeedStep state.=20
+ */
+static void speedstep_set_state (unsigned int state)
+{
+	u32                     pmbase;
+	u8	                pm2_blk;
+	u8                      value;
+	unsigned long           flags;
+	unsigned int            oldstate;
+	struct cpufreq_freqs    freqs;
+
+	if (!speedstep_chipset_dev || !state || (state > 0x1))
+		return;
+
+	if (speedstep_get_state(&oldstate))
+		return;
+
+	if (oldstate =3D=3D state)
+		return;
+
+	freqs.old =3D (oldstate =3D=3D SPEEDSTEP_HIGH) ? speedstep_high_freq : sp=
eedstep_low_freq;
+	freqs.new =3D (state =3D=3D SPEEDSTEP_HIGH) ? speedstep_high_freq : speed=
step_low_freq;
+	freqs.cpu =3D CPUFREQ_ALL_CPUS; /* speedstep.c is UP only driver */
+=09
+	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+
+	switch (speedstep_chipset) {
+	case SPEEDSTEP_CHIPSET_ICH2M:
+	case SPEEDSTEP_CHIPSET_ICH3M:
+		/* get PMBASE */
+		pci_read_config_dword(speedstep_chipset_dev, 0x40, &pmbase);
+		if (!(pmbase & 0x01))
+		{
+			printk(KERN_ERR "cpufreq: could not find speedstep register\n");
+			return;
+		}
+
+		pmbase &=3D 0xFFFFFFFE;
+		if (!pmbase) {
+			printk(KERN_ERR "cpufreq: could not find speedstep register\n");
+			return;
+		}
+
+		/* read state */
+		local_irq_disable();
+		value =3D inb(pmbase + 0x50);
+		local_irq_enable();
+
+		dprintk(KERN_DEBUG "cpufreq: read at pmbase 0x%x + 0x50 returned 0x%x\n"=
, pmbase, value);
+
+		/* write new state */
+		value &=3D 0xFE;
+		value |=3D state;
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
+		if (state =3D=3D (value & 0x1)) {
+			dprintk (KERN_INFO "cpufreq: change to %u MHz succeded\n", (freq / 1000=
));
+		} else {
+			printk (KERN_ERR "cpufreq: change failed - I/O error\n");
+		}
+		break;
+	default:
+		printk (KERN_ERR "cpufreq: setting CPU frequency on this chipset unsuppo=
rted.\n");
+	}
+
+	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+
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
+		result =3D speedstep_get_state(&state);
+		if (result)
+			return result;
+
+		/* save the correct value, and switch to other */
+		if (state =3D=3D SPEEDSTEP_LOW) {
+			switch (speedstep_processor) {
+			case SPEEDSTEP_PROCESSOR_PIII_C:
+			case SPEEDSTEP_PROCESSOR_PIII_T:
+				speedstep_low_freq =3D pentium3_get_frequency();
+				break;
+			case SPEEDSTEP_PROCESSOR_P4M:
+				speedstep_low_freq =3D pentium4_get_frequency();
+			}
+			speedstep_set_state(SPEEDSTEP_HIGH);
+		} else {
+			switch (speedstep_processor) {
+			case SPEEDSTEP_PROCESSOR_PIII_C:
+			case SPEEDSTEP_PROCESSOR_PIII_T:
+				speedstep_high_freq =3D pentium3_get_frequency();
+				break;
+			case SPEEDSTEP_PROCESSOR_P4M:
+				speedstep_high_freq =3D pentium4_get_frequency();
+			}
+			speedstep_set_state(SPEEDSTEP_LOW);
+		}
+
+		if (!speedstep_low_freq || !speedstep_high_freq ||=20
+		    (speedstep_low_freq =3D=3D speedstep_high_freq))
+			return -EIO;
+	}
+
+	return 0;
+}
+
+
+/**
+ * speedstep_setpolicy - set a new CPUFreq policy
+ * @policy: new policy
+ *
+ * Sets a new CPUFreq policy.
+ */
+static void speedstep_setpolicy (struct cpufreq_policy *policy)
+{
+	if (!speedstep_driver || !policy)
+		return;
+
+	if (policy->min > speedstep_low_freq)=20
+		speedstep_set_state(SPEEDSTEP_HIGH);
+	else {
+		if (policy->max < speedstep_high_freq)
+			speedstep_set_state(SPEEDSTEP_LOW);
+		else {
+			/* both frequency states are allowed */
+			if (policy->policy =3D=3D CPUFREQ_POLICY_POWERSAVE)
+				speedstep_set_state(SPEEDSTEP_LOW);
+			else
+				speedstep_set_state(SPEEDSTEP_HIGH);
+		}
+	}
+}
+
+
+/**
+ * speedstep_verify - verifies a new CPUFreq policy
+ * @freq: new policy
+ *
+ * Limit must be within speedstep_low_freq and speedstep_high_freq, with
+ * at least one border included.
+ */
+static void speedstep_verify (struct cpufreq_policy *policy)
+{
+	if (!policy || !speedstep_driver ||=20
+	    !speedstep_low_freq || !speedstep_high_freq)
+		return;
+
+	policy->cpu =3D 0; /* UP only */
+
+	cpufreq_verify_within_limits(policy, speedstep_low_freq, speedstep_high_f=
req);
+
+	if ((policy->min > speedstep_low_freq) &&=20
+	    (policy->max < speedstep_high_freq))
+		policy->max =3D speedstep_high_freq;
+=09
+	return;
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
8 $\n");
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
+	result =3D speedstep_get_state(&speed);
+	if (result)
+		return result;
+
+	speed =3D (speed =3D=3D SPEEDSTEP_LOW) ? speedstep_low_freq : speedstep_h=
igh_freq;
+
+	dprintk(KERN_INFO "cpufreq: currently at %s speed setting - %i MHz\n",=20
+	       (speed =3D=3D speedstep_low_freq) ? "low" : "high",
+	       (speed / 1000));
+
+	/* initialization of main "cpufreq" code*/
+	driver =3D kmalloc(sizeof(struct cpufreq_driver) +=20
+			 NR_CPUS * sizeof(struct cpufreq_policy), GFP_KERNEL);
+	if (!driver)
+		return -ENOMEM;
+
+	driver->policy =3D (struct cpufreq_policy *) (driver + sizeof(struct cpuf=
req_driver));
+=09
+#ifdef CONFIG_CPU_FREQ_24_API
+	driver->cpu_min_freq    =3D speedstep_low_freq;
+	driver->cpu_cur_freq[0] =3D speed;
+#endif
+
+	driver->verify      =3D &speedstep_verify;
+	driver->setpolicy   =3D &speedstep_setpolicy;
+
+	driver->policy[0].cpu    =3D 0;
+	driver->policy[0].min    =3D speedstep_low_freq;
+	driver->policy[0].max    =3D speedstep_high_freq;
+	driver->policy[0].max_cpu_freq =3D speedstep_high_freq;
+	driver->policy[0].policy =3D (speed =3D=3D speedstep_low_freq) ?=20
+	    CPUFREQ_POLICY_POWERSAVE : CPUFREQ_POLICY_PERFORMANCE;
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



--5L6AZ1aJH5mDrqCQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iD8DBQE9hvc5Z8MDCHJbN8YRAq7kAJ9bbCHsPqLezJo7ophntOZD3AA7/ACglyjB
3Da0PpJRNarTYb0lXJLJTqY=
=19L2
-----END PGP SIGNATURE-----

--5L6AZ1aJH5mDrqCQ--
