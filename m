Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129258AbQJaUrs>; Tue, 31 Oct 2000 15:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130499AbQJaUri>; Tue, 31 Oct 2000 15:47:38 -0500
Received: from pizda.ninka.net ([216.101.162.242]:47241 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129258AbQJaUr1>;
	Tue, 31 Oct 2000 15:47:27 -0500
Date: Tue, 31 Oct 2000 12:32:02 -0800
Message-Id: <200010312032.MAA09369@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: rzm@icm.edu.pl
CC: linux-kernel@vger.kernel.org
In-Reply-To: <20001031191123.A9831@burza.icm.edu.pl> (message from Rafal
	Maszkowski on Tue, 31 Oct 2000 19:11:23 +0100)
Subject: Re: test10-pre7 on Sparc
In-Reply-To: <20001031191123.A9831@burza.icm.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Tue, 31 Oct 2000 19:11:23 +0100
   From: Rafal Maszkowski <rzm@icm.edu.pl>

   I am trying to run 2.4 kernel to have up to date ATM on SPARCstation 10,
   possibly with 2 CPUs. Did not succeed to boot neither Linus nor CVS version
   recently.  Compilation of 2.4.0.10.7:

Current CVS has both of these errors fixed, and such patches
were sent to Linus (included below):

diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/arch/sparc64/defconfig linux/arch/sparc64/defconfig
--- vanilla/linux/arch/sparc64/defconfig	Mon Oct 30 11:24:56 2000
+++ linux/arch/sparc64/defconfig	Fri Oct 27 16:15:59 2000
@@ -263,6 +263,7 @@
 # CONFIG_BLK_DEV_OPTI621 is not set
 # CONFIG_BLK_DEV_PDC202XX is not set
 # CONFIG_PDC202XX_BURST is not set
+# CONFIG_BLK_DEV_OSB4 is not set
 # CONFIG_BLK_DEV_SIS5513 is not set
 # CONFIG_BLK_DEV_SLC90E66 is not set
 # CONFIG_BLK_DEV_TRM290 is not set
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/arch/sparc64/kernel/smp.c linux/arch/sparc64/kernel/smp.c
--- vanilla/linux/arch/sparc64/kernel/smp.c	Sun Aug  6 11:43:17 2000
+++ linux/arch/sparc64/kernel/smp.c	Fri Oct 27 11:23:45 2000
@@ -28,6 +28,7 @@
 #include <asm/softirq.h>
 #include <asm/uaccess.h>
 #include <asm/timer.h>
+#include <asm/starfire.h>
 
 #define __KERNEL_SYSCALLS__
 #include <linux/unistd.h>
@@ -302,9 +303,17 @@
 
 static inline void xcall_deliver(u64 data0, u64 data1, u64 data2, u64 pstate, unsigned long cpu)
 {
-	u64 result, target = (cpu << 14) | 0x70;
+	u64 result, target;
 	int stuck, tmp;
 
+	if (this_is_starfire) {
+		/* map to real upaid */
+		cpu = (((cpu & 0x3c) << 1) |
+			((cpu & 0x40) >> 4) |
+			(cpu & 0x3));
+	}
+
+	target = (cpu << 14) | 0x70;
 #ifdef XCALL_DEBUG
 	printk("CPU[%d]: xcall(data[%016lx:%016lx:%016lx],tgt[%016lx])\n",
 	       smp_processor_id(), data0, data1, data2, target);
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/arch/sparc64/kernel/sparc64_ksyms.c linux/arch/sparc64/kernel/sparc64_ksyms.c
--- vanilla/linux/arch/sparc64/kernel/sparc64_ksyms.c	Mon Oct 30 11:24:56 2000
+++ linux/arch/sparc64/kernel/sparc64_ksyms.c	Mon Oct 30 13:01:40 2000
@@ -1,4 +1,4 @@
-/* $Id: sparc64_ksyms.c,v 1.92 2000/08/09 08:45:40 anton Exp $
+/* $Id: sparc64_ksyms.c,v 1.95 2000/10/30 21:01:40 davem Exp $
  * arch/sparc64/kernel/sparc64_ksyms.c: Sparc64 specific ksyms support.
  *
  * Copyright (C) 1996 David S. Miller (davem@caip.rutgers.edu)
@@ -18,6 +18,8 @@
 #include <linux/in6.h>
 #include <linux/pci.h>
 #include <linux/interrupt.h>
+#include <linux/fs_struct.h>
+#include <linux/mm.h>
 
 #include <asm/oplib.h>
 #include <asm/delay.h>
@@ -29,6 +31,7 @@
 #include <asm/hardirq.h>
 #include <asm/idprom.h>
 #include <asm/svr4.h>
+#include <asm/elf.h>
 #include <asm/head.h>
 #include <asm/smp.h>
 #include <asm/mostek.h>
@@ -37,6 +40,7 @@
 #include <asm/uaccess.h>
 #include <asm/checksum.h>
 #include <asm/fpumacro.h>
+#include <asm/pgalloc.h>
 #ifdef CONFIG_SBUS
 #include <asm/sbus.h>
 #include <asm/dma.h>
@@ -88,6 +92,7 @@
 extern int __ashrdi3(int, int);
 
 extern void dump_thread(struct pt_regs *, struct user *);
+extern int dump_fpu (struct pt_regs * regs, elf_fpregset_t * fpregs);
 
 #ifdef CONFIG_SMP
 extern spinlock_t kernel_flag;
@@ -230,6 +235,13 @@
 
 /* Should really be in linux/kernel/ksyms.c */
 EXPORT_SYMBOL(dump_thread);
+EXPORT_SYMBOL(dump_fpu);
+EXPORT_SYMBOL(get_pmd_slow);
+EXPORT_SYMBOL(get_pte_slow);
+#ifndef CONFIG_SMP
+EXPORT_SYMBOL(pgt_quicklists);
+#endif
+EXPORT_SYMBOL(put_fs_struct);
 
 /* math-emu wants this */
 EXPORT_SYMBOL(die_if_kernel);
@@ -264,6 +276,7 @@
 EXPORT_SYMBOL(__strlen);
 EXPORT_SYMBOL(strlen);
 EXPORT_SYMBOL(strnlen);
+EXPORT_SYMBOL(__strlen_user);
 EXPORT_SYMBOL(strcpy);
 EXPORT_SYMBOL(strncpy);
 EXPORT_SYMBOL(strcat);
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/arch/sparc64/kernel/starfire.c linux/arch/sparc64/kernel/starfire.c
--- vanilla/linux/arch/sparc64/kernel/starfire.c	Tue Oct  3 09:24:41 2000
+++ linux/arch/sparc64/kernel/starfire.c	Fri Oct 27 11:25:36 2000
@@ -1,4 +1,4 @@
-/* $Id: starfire.c,v 1.7 2000/09/22 23:02:13 davem Exp $
+/* $Id: starfire.c,v 1.8 2000/10/27 18:36:47 anton Exp $
  * starfire.c: Starfire/E10000 support.
  *
  * Copyright (C) 1998 David S. Miller (davem@redhat.com)
@@ -31,7 +31,12 @@
 void starfire_cpu_setup(void)
 {
 	if (this_is_starfire) {
-/* We do this in starfire_translate - Anton */
+/*
+ * We do this in starfire_translate and xcall_deliver. When we fix our cpu
+ * arrays to support > 64 processors we can use the real upaid instead
+ * of the logical cpuid in __cpu_number_map etc, then we can get rid of
+ * the translations everywhere. - Anton
+ */
 #if 0
 		int i;
 
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/drivers/sbus/audio/cs4215.h linux/drivers/sbus/audio/cs4215.h
--- vanilla/linux/drivers/sbus/audio/cs4215.h	Mon Dec 20 22:06:42 1999
+++ linux/drivers/sbus/audio/cs4215.h	Fri Oct 27 11:34:10 2000
@@ -1,4 +1,4 @@
-/* $Id: cs4215.h,v 1.7 1999/09/21 14:37:19 davem Exp $
+/* $Id: cs4215.h,v 1.8 2000/10/27 07:01:38 uzi Exp $
  * drivers/sbus/audio/cs4215.h
  *
  * Copyright (C) 1997 Rudolf Koenig (rfkoenig@immd4.informatik.uni-erlangen.de)
@@ -103,7 +103,7 @@
 
 /* Time Slot 6, Output Setting  */
 #define CS4215_RO(v)	v	/* Right Output Attenuation 0x3f: -94.5 dB */
-#define CS4215_SE	(1<<6)	/* Line Out Enable */
+#define CS4215_SE	(1<<6)	/* Speaker Enable */
 #define CS4215_ADI	(1<<7)	/* A/D Data Invalid: Busy in calibration */
 
 /* Time Slot 7, Input Setting */
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/drivers/sbus/audio/dbri.c linux/drivers/sbus/audio/dbri.c
--- vanilla/linux/drivers/sbus/audio/dbri.c	Thu Sep  7 08:32:01 2000
+++ linux/drivers/sbus/audio/dbri.c	Fri Oct 27 11:34:10 2000
@@ -1,4 +1,4 @@
-/* $Id: dbri.c,v 1.21 2000/08/31 23:44:17 davem Exp $
+/* $Id: dbri.c,v 1.22 2000/10/27 07:01:38 uzi Exp $
  * drivers/sbus/audio/dbri.c
  *
  * Copyright (C) 1997 Rudolf Koenig (rfkoenig@immd4.informatik.uni-erlangen.de)
@@ -486,6 +486,7 @@
 		else if ((dbri->dbri_irqp & (DBRI_INT_BLK-1)) == 0)
 			dbri->dbri_irqp++;
 
+		tprintk(("dbri->dbri_irqp == %d\n", dbri->dbri_irqp));
 		dbri_process_one_interrupt(dbri, x);
 	}
 }
@@ -1269,6 +1270,7 @@
 	} else {
 		int left_gain = (dbri->perchip_info.play.gain / 4) % 64;
 		int right_gain = (dbri->perchip_info.play.gain / 4) % 64;
+		int outport = dbri->perchip_info.play.port;
 
 		if (dbri->perchip_info.play.balance < AUDIO_MID_BALANCE) {
 			right_gain *= dbri->perchip_info.play.balance;
@@ -1282,8 +1284,11 @@
 		dprintk(D_MM, ("DBRI: Setting codec gain left: %d right: %d\n",
 			       left_gain, right_gain));
 
-		dbri->mm.data[0] = CS4215_LE | CS4215_HE | (63 - left_gain);
-		dbri->mm.data[1] = CS4215_SE | (63 - right_gain);
+		dbri->mm.data[0] = (63 - left_gain);
+		if (outport & AUDIO_HEADPHONE) dbri->mm.data[0] |= CS4215_HE;
+		if (outport & AUDIO_LINE_OUT)  dbri->mm.data[0] |= CS4215_LE;
+		dbri->mm.data[1] = (63 - right_gain);
+		if (outport & AUDIO_SPEAKER)   dbri->mm.data[1] |= CS4215_SE;
 	}
 
 	xmit_fixed(dbri, 20, *(int *)dbri->mm.data);
@@ -1484,8 +1489,14 @@
 
 	dbri->perchip_info.play.channels = 1;
 	dbri->perchip_info.play.precision = 8;
-	dbri->perchip_info.play.gain = 255;
+	dbri->perchip_info.play.gain = (AUDIO_MAX_GAIN * 7 / 10);  /* 70% */
 	dbri->perchip_info.play.balance = AUDIO_MID_BALANCE;
+	dbri->perchip_info.play.port = dbri->perchip_info.play.avail_ports = 
+		AUDIO_SPEAKER | AUDIO_HEADPHONE | AUDIO_LINE_OUT;
+	dbri->perchip_info.record.port = AUDIO_MICROPHONE;
+	dbri->perchip_info.record.avail_ports =
+		AUDIO_MICROPHONE | AUDIO_LINE_IN;
+
 	mmcodec_init_data(dbri);
 
 	return 0;
@@ -1834,32 +1845,52 @@
 
 static int dbri_set_output_port(struct sparcaudio_driver *drv, int port)
 {
-        return 0;
+	struct dbri *dbri = (struct dbri *) drv->private;
+
+	port &= dbri->perchip_info.play.avail_ports;
+	dbri->perchip_info.play.port = port;
+	mmcodec_setgain(dbri, 0);
+
+	return 0;
 }
 
 static int dbri_get_output_port(struct sparcaudio_driver *drv)
 {
-        return 0;
+	struct dbri *dbri = (struct dbri *) drv->private;
+
+	return dbri->perchip_info.play.port;
 }
 
 static int dbri_set_input_port(struct sparcaudio_driver *drv, int port)
 {
-        return 0;
+	struct dbri *dbri = (struct dbri *) drv->private;
+
+	port &= dbri->perchip_info.record.avail_ports;
+	dbri->perchip_info.record.port = port;
+	mmcodec_setgain(dbri, 0);
+
+	return 0;
 }
 
 static int dbri_get_input_port(struct sparcaudio_driver *drv)
 {
-        return 0;
+	struct dbri *dbri = (struct dbri *) drv->private;
+
+	return dbri->perchip_info.record.port;
 }
 
 static int dbri_get_output_ports(struct sparcaudio_driver *drv)
 {
-        return 0;
+	struct dbri *dbri = (struct dbri *) drv->private;
+
+	return dbri->perchip_info.play.avail_ports;
 }
 
 static int dbri_get_input_ports(struct sparcaudio_driver *drv)
 {
-        return 0;
+	struct dbri *dbri = (struct dbri *) drv->private;
+
+	return dbri->perchip_info.record.avail_ports;
 }
 
 /******************* sparcaudio midlevel - driver ID ********************/
@@ -1888,12 +1919,6 @@
 		     struct sparcaudio_driver *drv)
 {
 	MOD_INC_USE_COUNT;
-
-        /* I've taken the liberty of setting half gain and
-	 * mid balance, to put the codec in a known state.
-	 */
-	dbri_set_output_balance(drv, AUDIO_MID_BALANCE);
-	dbri_set_output_volume(drv, AUDIO_MAX_GAIN / 2);
 
 	return 0;
 }
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/include/asm-sparc/page.h linux/include/asm-sparc/page.h
--- vanilla/linux/include/asm-sparc/page.h	Mon Oct 30 11:25:15 2000
+++ linux/include/asm-sparc/page.h	Mon Oct 30 13:01:41 2000
@@ -1,4 +1,4 @@
-/* $Id: page.h,v 1.54 2000/08/10 01:04:53 davem Exp $
+/* $Id: page.h,v 1.55 2000/10/30 21:01:41 davem Exp $
  * page.h:  Various defines and such for MMU operations on the Sparc for
  *          the Linux kernel.
  *
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/include/asm-sparc/param.h linux/include/asm-sparc/param.h
--- vanilla/linux/include/asm-sparc/param.h	Sat Nov  9 00:29:52 1996
+++ linux/include/asm-sparc/param.h	Mon Oct 30 13:01:41 2000
@@ -1,4 +1,4 @@
-/* $Id: param.h,v 1.3 1995/11/25 02:32:18 davem Exp $ */
+/* $Id: param.h,v 1.4 2000/10/30 21:01:41 davem Exp $ */
 #ifndef _ASMSPARC_PARAM_H
 #define _ASMSPARC_PARAM_H
 
@@ -17,5 +17,9 @@
 #endif
 
 #define MAXHOSTNAMELEN	64	/* max length of hostname */
+
+#ifdef __KERNEL__
+# define CLOCKS_PER_SEC	HZ	/* frequency at which times() counts */
+#endif
 
 #endif
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/include/asm-sparc/pgtable.h linux/include/asm-sparc/pgtable.h
--- vanilla/linux/include/asm-sparc/pgtable.h	Mon Oct 30 11:25:15 2000
+++ linux/include/asm-sparc/pgtable.h	Mon Oct 30 13:01:41 2000
@@ -1,4 +1,4 @@
-/* $Id: pgtable.h,v 1.104 2000/10/19 00:50:16 davem Exp $ */
+/* $Id: pgtable.h,v 1.105 2000/10/30 21:01:41 davem Exp $ */
 #ifndef _SPARC_PGTABLE_H
 #define _SPARC_PGTABLE_H
 
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/include/asm-sparc64/param.h linux/include/asm-sparc64/param.h
--- vanilla/linux/include/asm-sparc64/param.h	Fri Dec 13 01:37:47 1996
+++ linux/include/asm-sparc64/param.h	Mon Oct 30 13:01:41 2000
@@ -1,4 +1,4 @@
-/* $Id: param.h,v 1.1 1996/12/02 00:08:24 davem Exp $ */
+/* $Id: param.h,v 1.2 2000/10/30 21:01:41 davem Exp $ */
 #ifndef _ASMSPARC64_PARAM_H
 #define _ASMSPARC64_PARAM_H
 
@@ -17,5 +17,9 @@
 #endif
 
 #define MAXHOSTNAMELEN	64	/* max length of hostname */
+
+#ifdef __KERNEL__
+# define CLOCKS_PER_SEC	HZ	/* frequency at which times() counts */
+#endif
 
 #endif /* _ASMSPARC64_PARAM_H */
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/include/asm-sparc64/string.h linux/include/asm-sparc64/string.h
--- vanilla/linux/include/asm-sparc64/string.h	Mon Oct 30 11:25:15 2000
+++ linux/include/asm-sparc64/string.h	Mon Oct 30 13:01:41 2000
@@ -1,4 +1,4 @@
-/* $Id: string.h,v 1.17 2000/06/19 06:24:58 davem Exp $
+/* $Id: string.h,v 1.18 2000/10/30 21:01:41 davem Exp $
  * string.h: External definitions for optimized assembly string
  *           routines for the Linux Kernel.
  *
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
