Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266528AbSLONOx>; Sun, 15 Dec 2002 08:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266535AbSLONOx>; Sun, 15 Dec 2002 08:14:53 -0500
Received: from gateway.cinet.co.jp ([210.166.75.129]:51265 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S266528AbSLONOv>; Sun, 15 Dec 2002 08:14:51 -0500
Message-ID: <3DFC818F.80E3DC00@cinet.co.jp>
Date: Sun, 15 Dec 2002 22:20:15 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.50-ac1-pc98smp i686)
X-Accept-Language: ja
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCHSET] PC-9800 addtional for 2.5.50-ac1 (21/21)
References: <3DFC50E9.656B96D0@cinet.co.jp>
Content-Type: multipart/mixed;
 boundary="------------195AE28A56002F4373EE847A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------195AE28A56002F4373EE847A
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit

NEC PC-9800 subarchitecture support patch for 2.5.50-ac1 (21/21)
This patch contains SMP support for PC98 (remained).

 arch/i386/kernel/mpparse.c |   45 ++++++++++++++++++++++++++++++++++++---------
 arch/i386/kernel/smpboot.c |   14 ++++++++++++++
 include/asm-i386/smpboot.h |    9 +++++++++
 3 files changed, 59 insertions(+), 9 deletions(-)

Regards,
Osamu Tomita
--------------195AE28A56002F4373EE847A
Content-Type: text/plain; charset=iso-2022-jp;
 name="smp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smp.patch"

diff -urN linux/arch/i386/kernel/mpparse.c linux98/arch/i386/kernel/mpparse.c
--- linux/arch/i386/kernel/mpparse.c	2002-12-10 09:17:48.000000000 +0900
+++ linux98/arch/i386/kernel/mpparse.c	2002-12-10 10:54:09.000000000 +0900
@@ -676,11 +676,14 @@
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
@@ -734,8 +737,30 @@
 			Dprintk("found SMP MP-table at %08lx\n",
 						virt_to_phys(mpf));
 			reserve_bootmem(virt_to_phys(mpf), PAGE_SIZE);
+#ifndef CONFIG_PC9800
 			if (mpf->mpf_physptr)
 				reserve_bootmem(mpf->mpf_physptr, PAGE_SIZE);
+#else
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
+#endif
+
 			mpf_found = mpf;
 			return 1;
 		}
@@ -747,8 +772,6 @@
 
 void __init find_smp_config (void)
 {
-	unsigned int address;
-
 	/*
 	 * FIXME: Linux assumes you have 640K of base ram..
 	 * this continues the error...
@@ -778,12 +801,16 @@
 	 * MP1.4 SPEC states to only scan first 1K of 4K EBDA.
 	 */
 
-	address = *(unsigned short *)phys_to_virt(0x40E);
-	address <<= 4;
-	smp_scan_config(address, 0x400);
-	/* This has been safe for ages */
-	if (smp_found_config)
-		Dprintk(KERN_WARNING "WARNING: MP table in the EBDA can be UNSAFE, contact linux-smp@vger.kernel.org if you experience SMP problems!\n");
+#ifndef CONFIG_PC9800	/* PC-9800 has no EBDA area? */
+	{
+		unsigned int address = *(unsigned short *)phys_to_virt(0x40E);
+		address <<= 4;
+		smp_scan_config(address, 0x400);
+		/* This has been safe for ages */
+		if (smp_found_config)
+			Dprintk(KERN_WARNING "WARNING: MP table in the EBDA can be UNSAFE, contact linux-smp@vger.kernel.org if you experience SMP problems!\n");
+	}
+#endif
 }
 
 
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

--------------195AE28A56002F4373EE847A--

