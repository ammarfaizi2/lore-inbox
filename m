Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264683AbSLQQTa>; Tue, 17 Dec 2002 11:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264730AbSLQQTa>; Tue, 17 Dec 2002 11:19:30 -0500
Received: from gateway.cinet.co.jp ([210.166.75.129]:33609 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S264683AbSLQQTY>; Tue, 17 Dec 2002 11:19:24 -0500
Message-ID: <3DFF4FF8.FA43A1A1@cinet.co.jp>
Date: Wed, 18 Dec 2002 01:25:28 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.52-pc98smp i686)
X-Accept-Language: ja
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHSET] PC-9800 addtional for 2.5.50-ac1 (21/21)
References: <3DFC50E9.656B96D0@cinet.co.jp> <3DFC818F.80E3DC00@cinet.co.jp>
		<20021215.225942.24871004.yoshfuji@linux-ipv6.org> 
		<3DFDE4FE.755F6651@cinet.co.jp> <1040139409.20199.8.camel@irongate.swansea.linux.org.uk>
Content-Type: multipart/mixed;
 boundary="------------21BDFF6A8F91811D803B9C80"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------21BDFF6A8F91811D803B9C80
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit

Thanks for your advice.

Alan Cox wrote:
> 
> Any chance of moving the EBDA to query to be something like
> 
>         unsigned long get_bios_ebda(void)
> 
> and hiding it in the per platform includes (returning 0 for non I guess)
How about this patch? This is replace of previous smp.patch.

diffstat:
 arch/i386/kernel/mpparse.c         |   39 +++++++++++++++++++++++--------------
 arch/i386/kernel/smpboot.c         |   14 +++++++++++++
 arch/i386/mach-defaults/smp_bios.h |   14 +++++++++++++
 arch/i386/mach-pc9800/smp_bios.h   |    7 ++++++
 include/asm-i386/smpboot.h         |    9 ++++++++
 5 files changed, 69 insertions(+), 14 deletions(-)

Regards,
Osamu
--------------21BDFF6A8F91811D803B9C80
Content-Type: text/plain; charset=iso-2022-jp;
 name="smp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smp.patch"

diff -Nru linux/arch/i386/kernel/mpparse.c linux98/arch/i386/kernel/mpparse.c
--- linux/arch/i386/kernel/mpparse.c	2002-12-15 15:16:42.000000000 +0900
+++ linux98/arch/i386/kernel/mpparse.c	2002-12-18 01:07:27.000000000 +0900
@@ -31,9 +31,7 @@
 #include <asm/pgalloc.h>
 #include <asm/io_apic.h>
 #include "mach_apic.h"
-
-/* Have we found an MP table */
-int smp_found_config;
+#include "smp_bios.h"
 
 /*
  * Various Linux-internal data structures created from the
@@ -676,11 +674,14 @@
 		printk(KERN_DEBUG "Default MP configuration #%d\n", mpf->mpf_feature1);
 		construct_default_ISA_mptable(mpf->mpf_feature1);
 	} else if (mpf->mpf_physptr) {
+		extern int pc98;
+
 		/*
 		 * Read the physical hardware table.  Anything here will
 		 * override the defaults.
 		 */
-		if (!smp_read_mpc((void *)mpf->mpf_physptr)) {
+		if (!smp_read_mpc(pc98 ? phys_to_virt(mpf->mpf_physptr)
+					: (void *)mpf->mpf_physptr)) {
 			smp_found_config = 0;
 			printk(KERN_ERR "BIOS bug, MP table errors detected!...\n");
 			printk(KERN_ERR "... disabling SMP support. (tell your hw vendor)\n");
@@ -734,8 +735,25 @@
 			Dprintk("found SMP MP-table at %08lx\n",
 						virt_to_phys(mpf));
 			reserve_bootmem(virt_to_phys(mpf), PAGE_SIZE);
-			if (mpf->mpf_physptr)
-				reserve_bootmem(mpf->mpf_physptr, PAGE_SIZE);
+			/*
+			 * PC-9800's MPC table places on the very last of
+			 * physical memory; so that simply reserving PAGE_SIZE
+			 * from mpg->mpf_physptr yields BUG() in
+			 * reserve_bootmem.
+			 */
+			if (mpf->mpf_physptr) {
+				/*
+				 * We cannot access to MPC table to compute
+				 * table size yet, as only few megabytes from
+				 * the bottom is mapped now.
+				 */
+				unsigned long size = PAGE_SIZE;
+				unsigned long end = max_low_pfn * PAGE_SIZE;
+				if (mpf->mpf_physptr + size > end)
+					size = end - mpf->mpf_physptr;
+				reserve_bootmem(mpf->mpf_physptr, size);
+			}
+
 			mpf_found = mpf;
 			return 1;
 		}
@@ -747,8 +765,6 @@
 
 void __init find_smp_config (void)
 {
-	unsigned int address;
-
 	/*
 	 * FIXME: Linux assumes you have 640K of base ram..
 	 * this continues the error...
@@ -778,12 +794,7 @@
 	 * MP1.4 SPEC states to only scan first 1K of 4K EBDA.
 	 */
 
-	address = *(unsigned short *)phys_to_virt(0x40E);
-	address <<= 4;
-	smp_scan_config(address, 0x400);
-	/* This has been safe for ages */
-	if (smp_found_config)
-		Dprintk(KERN_WARNING "WARNING: MP table in the EBDA can be UNSAFE, contact linux-smp@vger.kernel.org if you experience SMP problems!\n");
+	get_bios_ebda();
 }
 
 
diff -Nru linux/arch/i386/mach-defaults/smp_bios.h linux98/arch/i386/mach-defaults/smp_bios.h
--- linux/arch/i386/mach-defaults/smp_bios.h	1970-01-01 09:00:00.000000000 +0900
+++ linux98/arch/i386/mach-defaults/smp_bios.h	2002-12-18 00:53:48.000000000 +0900
@@ -0,0 +1,14 @@
+static int __init smp_scan_config (unsigned long base, unsigned long length);
+
+/* Have we found an MP table */
+int smp_found_config;
+
+static inline void get_bios_ebda(void)
+{
+	unsigned int address = *(unsigned short *)phys_to_virt(0x40E);
+	address <<= 4;
+	smp_scan_config(address, 0x400);
+	/* This has been safe for ages */
+	if (smp_found_config)
+		Dprintk(KERN_WARNING "WARNING: MP table in the EBDA can be UNSAFE, contact linux-smp@vger.kernel.org if you experience SMP problems!\n");
+}
diff -Nru linux/arch/i386/mach-pc9800/smp_bios.h linux98/arch/i386/mach-pc9800/smp_bios.h
--- linux/arch/i386/mach-pc9800/smp_bios.h	1970-01-01 09:00:00.000000000 +0900
+++ linux98/arch/i386/mach-pc9800/smp_bios.h	2002-12-18 00:49:50.000000000 +0900
@@ -0,0 +1,7 @@
+/* Have we found an MP table */
+int smp_found_config;
+
+static inline void get_bios_ebda(void)
+{
+	/* PC-9800 has no EBDA */
+}
diff -Nru linux/arch/i386/kernel/smpboot.c linux98/arch/i386/kernel/smpboot.c
--- linux/arch/i386/kernel/smpboot.c	2002-11-23 06:40:42.000000000 +0900
+++ linux98/arch/i386/kernel/smpboot.c	2002-11-25 11:14:21.000000000 +0900
@@ -823,13 +823,27 @@
 		nmi_low = *((volatile unsigned short *) TRAMPOLINE_LOW);
 	} 
 
+#ifndef CONFIG_PC9800
 	CMOS_WRITE(0xa, 0xf);
+#else
+	/* reset code is stored in 8255 on PC-9800. */
+	outb(0x0e, 0x37);	/* SHUT0 = 0 */
+#endif
 	local_flush_tlb();
 	Dprintk("1.\n");
 	*((volatile unsigned short *) TRAMPOLINE_HIGH) = start_eip >> 4;
 	Dprintk("2.\n");
 	*((volatile unsigned short *) TRAMPOLINE_LOW) = start_eip & 0xf;
 	Dprintk("3.\n");
+#ifdef CONFIG_PC9800
+	/*
+	 * On PC-9800, continuation on warm reset is done by loading
+	 * %ss:%sp from 0x0000:0404 and executing 'lret', so:
+	 */
+	/* 0x3f0 is on unused interrupt vector and should be safe... */
+	*((volatile unsigned long *) phys_to_virt(0x404)) = 0x000003f0;
+	Dprintk("4.\n");
+#endif
 
 	/*
 	 * Be paranoid about clearing APIC errors.
diff -Nru linux/include/asm-i386/smpboot.h linux98/include/asm-i386/smpboot.h
--- linux/include/asm-i386/smpboot.h	2002-10-12 13:22:19.000000000 +0900
+++ linux98/include/asm-i386/smpboot.h	2002-10-12 19:33:46.000000000 +0900
@@ -13,8 +13,17 @@
  #define TRAMPOLINE_LOW phys_to_virt(0x8)
  #define TRAMPOLINE_HIGH phys_to_virt(0xa)
 #else /* !CONFIG_CLUSTERED_APIC */
+ #ifndef CONFIG_PC9800
  #define TRAMPOLINE_LOW phys_to_virt(0x467)
  #define TRAMPOLINE_HIGH phys_to_virt(0x469)
+ #else  /* CONFIG_PC9800 */
+  /*
+   * On PC-9800, continuation on warm reset is done by loading
+   * %ss:%sp from 0x0000:0404 and executing 'lret', so:
+   */
+  #define TRAMPOLINE_LOW phys_to_virt(0x4fa)
+  #define TRAMPOLINE_HIGH phys_to_virt(0x4fc)
+ #endif /* !CONFIG_PC9800 */
 #endif /* CONFIG_CLUSTERED_APIC */
 
 #ifdef CONFIG_CLUSTERED_APIC

--------------21BDFF6A8F91811D803B9C80--

