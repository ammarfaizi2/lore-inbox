Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129175AbRBOTBp>; Thu, 15 Feb 2001 14:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129066AbRBOTB1>; Thu, 15 Feb 2001 14:01:27 -0500
Received: from singular.sch.bme.hu ([152.66.227.213]:260 "EHLO
	singular.sch.bme.hu") by vger.kernel.org with ESMTP
	id <S129175AbRBOTBP>; Thu, 15 Feb 2001 14:01:15 -0500
Date: Thu, 15 Feb 2001 20:01:34 +0100 (CET)
From: Kajtar Zsolt <soci@singular.sch.bme.hu>
To: linux-kernel@vger.kernel.org
Subject: 2.4.1ac13/14 problem
Message-ID: <Pine.LNX.4.21.0102151917150.233-100000@singular.sch.bme.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi
	I have't seen any posts about this, maybe nobody haveing
problems? I can't boot ac13/ac14 on my machine. 2.4.1ac12 was ok.

Linux version 2.4.1-ac13 (root@singular) (gcc version 2.95.3 20010125
(prerelease)) #2 Thu Feb 15 02:23:31 CET 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (usable)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
 BIOS-e820: 0000000003f00000 @ 0000000000100000 (usable)
On node 0 totalpages: 16384
zone(0): 4096 pages.
zone(1): 12288 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=o ro root=30a reboot=warm hdb=none
hdd=none
ide_setup: hdb=none
ide_setup: hdd=none
Initializing CPU#0
Detected 233.866 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 466.94 BogoMIPS
Memory: 62836k/65536k available (712k kernel code, 2312k reserved, 188k
data, 56k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode...

Here it freezes forever... My cpu:

processor	: 0
vendor_id	: CyrixInstead
cpu family	: 6
model		: 2
model name	: M II 3.5x Core/Bus Clock
stepping	: 8
cpu MHz		: 233.866
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu de tsc msr cx8 pge cmov mmx cyrix_arr
bogomips	: 466.94

I reality it`s an IBM 6x86 MX and have to run at 2.5x83, however I
overclockd it to 3.5x66 for a year now. (maybe this is why it seems to be
a M II?)

My other problem exists since 1999.okt. when I first installed Linux with
kernel 2.2.x. I get random floating point exceptions in every math
intensive program (at xmms it's really anoying). It's impossible to listen
to mp3 more than 5 minutes if I do not patch signal.c to re-execute
SIGFPE. (this has some sideeffects, like 1/0 is a forever loop...) This
does also accour if I run the processor at 2.5x66, so the problem is not
overclocking/heating. Should I buy a new processor+motherboard or is it
kernel related? (I did not had this problem before linux) I normally
compile the kernel for Pentium-Pro/Celeron/Pentium-II, but same happens
when compiled for 386.

I've made a little patch just for fun, maybe you could include it in
kernel (removes not compiled devices for root=/dev/x, and saves a few
bytes):
-----------------------------------
diff -u --recursive --new-file v2.4.1/linux/init/main.c linux/init/main.c
--- v2.4.1/linux/init/main.c	Thu Jan  4 05:45:26 2001
+++ linux/init/main.c	Sat Jan 13 13:46:18 2001
@@ -148,7 +148,10 @@
 	const char *name;
 	const int num;
 } root_dev_names[] __initdata = {
+#ifdef CONFIG_NFS_FS
 	{ "nfs",     0x00ff },
+#endif
+#ifdef CONFIG_IDE
 	{ "hda",     0x0300 },
 	{ "hdb",     0x0340 },
 	{ "hdc",     0x1600 },
@@ -169,6 +172,9 @@
 	{ "hdr",     0x5A40 },
 	{ "hds",     0x5B00 },
 	{ "hdt",     0x5B40 },
+#endif
+#ifdef CONFIG_SCSI
+	{ "scd",     0x0b00 },
 	{ "sda",     0x0800 },
 	{ "sdb",     0x0810 },
 	{ "sdc",     0x0820 },
@@ -185,35 +191,69 @@
 	{ "sdn",     0x08d0 },
 	{ "sdo",     0x08e0 },
 	{ "sdp",     0x08f0 },
+#endif
+#ifdef CONFIG_ATARI_ACSI
 	{ "ada",     0x1c00 },
 	{ "adb",     0x1c10 },
 	{ "adc",     0x1c20 },
 	{ "add",     0x1c30 },
 	{ "ade",     0x1c40 },
+#endif
+#if defined(CONFIG_BLK_DEV_FD) || defined(CONFIG_AMIGA_FLOPPY) || defined(CONFIG_ATARI_FLOPPY) || defined(CONFIG_BLK_DEV_SWIM_IOP)
 	{ "fd",      0x0200 },
-	{ "md",      0x0900 },	     
+#endif
+#ifdef CONFIG_MD
+	{ "md",      0x0900 },
+#endif
+#ifdef CONFIG_BLK_DEV_XD
 	{ "xda",     0x0d00 },
 	{ "xdb",     0x0d40 },
+#endif
+#if defined(CONFIG_BLK_DEV_RAM) || defined(CONFIG_AMIGA_Z2RAM)
 	{ "ram",     0x0100 },
-	{ "scd",     0x0b00 },
+#endif
+#ifdef CONFIG_MCD
 	{ "mcd",     0x1700 },
+#endif
+#ifdef CONFIG_CDU535
 	{ "cdu535",  0x1800 },
+#endif
+#ifdef CONFIG_CDU31A
 	{ "sonycd",  0x1800 },
+#endif
+#ifdef CONFIG_AZTCD
 	{ "aztcd",   0x1d00 },
+#endif
+#ifdef CONFIG_CM206
 	{ "cm206cd", 0x2000 },
+#endif
+#ifdef CONFIG_GSCD
 	{ "gscd",    0x1000 },
+#endif
+#ifdef CONFIG_SBPCD
 	{ "sbpcd",   0x1900 },
+#endif
+#ifdef CONFIG_BLK_DEV_PS2
 	{ "eda",     0x2400 },
 	{ "edb",     0x2440 },
+#endif
+#ifdef CONFIG_PARIDE
 	{ "pda",	0x2d00 },
 	{ "pdb",	0x2d10 },
 	{ "pdc",	0x2d20 },
 	{ "pdd",	0x2d30 },
 	{ "pcd",	0x2e00 },
 	{ "pf",		0x2f00 },
+#endif
+#ifdef CONFIG_APBLOCK
 	{ "apblock", APBLOCK_MAJOR << 8},
+#endif
+#ifdef CONFIG_DDV
 	{ "ddv", DDV_MAJOR << 8},
+#endif
+#ifdef CONFIG_SUN_JSFLASH
 	{ "jsfd",    JSFD_MAJOR << 8},
+#endif
 #ifdef CONFIG_MDISK
         { "mnda", (MDISK_MAJOR << MINORBITS)},
         { "mndb", (MDISK_MAJOR << MINORBITS) + 1},
---------------------------------
                                                      -soci-


