Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267254AbSLROeR>; Wed, 18 Dec 2002 09:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267261AbSLROeQ>; Wed, 18 Dec 2002 09:34:16 -0500
Received: from gateway.cinet.co.jp ([210.166.75.129]:64085 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S267254AbSLROeN>; Wed, 18 Dec 2002 09:34:13 -0500
Message-ID: <3E0088D8.31788F10@cinet.co.jp>
Date: Wed, 18 Dec 2002 23:40:24 +0900
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
		<3DFDE4FE.755F6651@cinet.co.jp>
		<1040139409.20199.8.camel@irongate.swansea.linux.org.uk> 
		<3DFF4FF8.FA43A1A1@cinet.co.jp> <1040145474.20018.27.camel@irongate.swansea.linux.org.uk>
Content-Type: multipart/mixed;
 boundary="------------2055F5970CCB115ACE3088DE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------2055F5970CCB115ACE3088DE
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit

Alan Cox wrote:
> Slight misunderstanding: I just meant put the
> 
> static inline int get_ebda(void)
> {
>    unsigned int address = *(unsigned short *)phys_to_virt(0x40E);
>    address <<= 4;
>    return address;  /* 0 means none */
> }
> 
> then do
> 
> addr = get_ebda();
> if(addr)
>      spm_scan_config(...)
> 
> Which actually fixes a bug too - the real PC can have no EBDA (EBDA
> value of zero) and we shouldnt scan it if so
Oh, I see. Here is a patch rewrited.

Thanks,
Osamu
--------------2055F5970CCB115ACE3088DE
Content-Type: text/plain; charset=iso-2022-jp;
 name="smp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smp.patch"

diff -urN linux/arch/i386/kernel/mpparse.c linux98/arch/i386/kernel/mpparse.c
--- linux/arch/i386/kernel/mpparse.c	2002-12-10 09:17:48.000000000 +0900
+++ linux98/arch/i386/kernel/mpparse.c	2002-12-18 22:22:24.000000000 +0900
@@ -31,6 +31,7 @@
 #include <asm/pgalloc.h>
 #include <asm/io_apic.h>
 #include "mach_apic.h"
+#include "bios_ebda.h"
 
 /* Have we found an MP table */
 int smp_found_config;
@@ -676,11 +677,14 @@
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
@@ -734,8 +738,25 @@
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
@@ -778,12 +799,14 @@
 	 * MP1.4 SPEC states to only scan first 1K of 4K EBDA.
 	 */
 
-	address = *(unsigned short *)phys_to_virt(0x40E);
-	address <<= 4;
-	smp_scan_config(address, 0x400);
-	/* This has been safe for ages */
-	if (smp_found_config)
-		Dprintk(KERN_WARNING "WARNING: MP table in the EBDA can be UNSAFE, contact linux-smp@vger.kernel.org if you experience SMP problems!\n");
+	address = get_bios_ebda();
+	if (address)
+	{
+		smp_scan_config(address, 0x400);
+		/* This has been safe for ages */
+		if (smp_found_config)
+			Dprintk(KERN_WARNING "WARNING: MP table in the EBDA can be UNSAFE, contact linux-smp@vger.kernel.org if you experience SMP problems!\n");
+	}
 }
 
 
diff -Nru linux-2.5.50-ac1/arch/i386/mach-defaults/bios_ebda.h linux98-2.5.50-ac1/arch/i386/mach-defaults/bios_ebda.h
--- linux-2.5.50-ac1/arch/i386/mach-defaults/bios_ebda.h	1970-01-01 09:00:00.000000000 +0900
+++ linux98-2.5.50-ac1/arch/i386/mach-defaults/bios_ebda.h	2002-12-18 22:40:38.000000000 +0900
@@ -0,0 +1,15 @@
+#ifndef _MACH_BIOS_EBDA_H
+#define _MACH_BIOS_EBDA_H
+
+/*
+ * there is a real-mode segmented pointer pointing to the
+ * 4K EBDA area at 0x40E.
+ */
+static inline unsigned int get_bios_ebda(void)
+{
+	unsigned int address = *(unsigned short *)phys_to_virt(0x40E);
+	address <<= 4;
+	return address;	/* 0 means none */
+}
+
+#endif /* _MACH_BIOS_EBDA_H */
diff -Nru linux-2.5.50-ac1/arch/i386/mach-pc9800/bios_ebda.h linux98-2.5.50-ac1/arch/i386/mach-pc9800/bios_ebda.h
--- linux-2.5.50-ac1/arch/i386/mach-pc9800/bios_ebda.h	1970-01-01 09:00:00.000000000 +0900
+++ linux98-2.5.50-ac1/arch/i386/mach-pc9800/bios_ebda.h	2002-12-18 22:49:59.000000000 +0900
@@ -0,0 +1,14 @@
+#ifndef _MACH_BIOS_EBDA_H
+#define _MACH_BIOS_EBDA_H
+
+/*
+ * PC-9800 has no EBDA.
+ * Its BIOS uses 0x40E for other purpose,
+ * Not pointer to 4K EBDA area.
+ */
+static inline unsigned int get_bios_ebda(void)
+{
+	return 0;	/* 0 means none */
+}
+
+#endif /* _MACH_BIOS_EBDA_H */
diff -urN linux/arch/i386/kernel/smpboot.c linux98/arch/i386/kernel/smpboot.c
--- linux/arch/i386/kernel/smpboot.c	2002-12-10 09:17:49.000000000 +0900
+++ linux98/arch/i386/kernel/smpboot.c	2002-12-10 10:43:32.000000000 +0900
@@ -856,13 +856,27 @@
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
diff -urN linux/include/asm-i386/smpboot.h linux98/include/asm-i386/smpboot.h
--- linux/include/asm-i386/smpboot.h	Sat Oct 12 13:22:19 2002
+++ linux98/include/asm-i386/smpboot.h	Sat Oct 12 19:33:46 2002
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

--------------2055F5970CCB115ACE3088DE--

