Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264920AbSLQLbE>; Tue, 17 Dec 2002 06:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264925AbSLQLbE>; Tue, 17 Dec 2002 06:31:04 -0500
Received: from gateway.cinet.co.jp ([210.166.75.129]:15686 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S264920AbSLQLbB>; Tue, 17 Dec 2002 06:31:01 -0500
Message-ID: <3DFDE4FE.755F6651@cinet.co.jp>
Date: Mon, 16 Dec 2002 23:36:46 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.50-ac1-pc98smp i686)
X-Accept-Language: ja
MIME-Version: 1.0
To: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
CC: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCHSET] PC-9800 addtional for 2.5.50-ac1 (21/21)
References: <3DFC50E9.656B96D0@cinet.co.jp>
		<3DFC818F.80E3DC00@cinet.co.jp> <20021215.225942.24871004.yoshfuji@linux-ipv6.org>
Content-Type: multipart/mixed;
 boundary="------------7C5D0E388895A6E22EA2E53C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------7C5D0E388895A6E22EA2E53C
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit

YOSHIFUJI Hideaki / 吉藤英明 wrote:
> 
> In article <3DFC818F.80E3DC00@cinet.co.jp> (at Sun, 15 Dec 2002 22:20:15 +0900), Osamu Tomita <tomita@cinet.co.jp> says:
> 
> > +#ifndef CONFIG_PC9800
> >                       if (mpf->mpf_physptr)
> >                               reserve_bootmem(mpf->mpf_physptr, PAGE_SIZE);
> > +#else
> > +                     /*
> > +                      * PC-9800's MPC table places on the very last of
> > +                      * physical memory; so that simply reserving PAGE_SIZE
> > +                      * from mpg->mpf_physptr yields BUG() in
> > +                      * reserve_bootmem.
> > +                      */
> > +                     if (mpf->mpf_physptr) {
> > +                             /*
> > +                              * We cannot access to MPC table to compute
> > +                              * table size yet, as only few megabytes from
> > +                              * the bottom is mapped now.
> > +                              */
> > +                             unsigned long size = PAGE_SIZE;
> > +                             unsigned long end = max_low_pfn * PAGE_SIZE;
> > +                             if (mpf->mpf_physptr + size > end)
> > +                                     size = end - mpf->mpf_physptr;
> > +                             reserve_bootmem(mpf->mpf_physptr, size);
> > +                     }
> > +#endif
> > +
> 
> I'm not sure if we need this #ifdef;
> it doesn't seem that this #ifdef CONFIG_PC9800 part is harmful
> for others at all.
> 
> Well, if it is required, I prefer putting #ifdef..#endif inside the
> if-clause like this:
> 
>                         if (mpf->mpf_physptr) {
>                                 unsigned long size = PAGE_SIZE;
> #ifdef CONFIG_PC9800
>                                 /*
>                                  * PC-9800's MPC table places on the very last of
>                                  * physical memory; so that simply reserving PAGE_SIZE
>                                  * from mpg->mpf_physptr yields BUG() in
>                                  * reserve_bootmem.
>                                  *
>                                  * We cannot access to MPC table to compute
>                                  * table size yet, as only few megabytes from
>                                  * the bottom is mapped now.
>                                  */
>                                 unsigned long end = max_low_pfn * PAGE_SIZE;
> 
>                                 if (mpf->mpf_physptr + size > end)
>                                         size = end - mpf->mpf_physptr;
> #endif
>                                 reserve_bootmem(mpf->mpf_physptr, size);
>                         }
> 
Thanks for your advice!
Indeed, No need "#ifdef" here.
Because there is a check by "if (mpf->mpf_physptr + size > end)".
I rewrite patch. Please comment.

-- 
Osamu Tomita
--------------7C5D0E388895A6E22EA2E53C
Content-Type: text/plain; charset=iso-2022-jp;
 name="smp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smp.patch"

diff -Nru linux/arch/i386/kernel/mpparse.c linux98/arch/i386/kernel/mpparse.c
--- linux/arch/i386/kernel/mpparse.c	2002-12-16 09:15:54.000000000 +0900
+++ linux98/arch/i386/kernel/mpparse.c	2002-12-16 17:15:15.000000000 +0900
@@ -73,6 +73,8 @@
 int summit_x86 = 0;
 u8 raw_phys_apicid[NR_CPUS] = { [0 ... NR_CPUS-1] = BAD_APICID };
 
+extern int pc98;	/* NEC PC-9800 subarchitecture or not */
+
 /*
  * Intel MP BIOS table parsing routines:
  */
@@ -683,7 +685,8 @@
 		 * Read the physical hardware table.  Anything here will
 		 * override the defaults.
 		 */
-		if (!smp_read_mpc((void *)mpf->mpf_physptr)) {
+		if (!smp_read_mpc(pc98 ? phys_to_virt(mpf->mpf_physptr)
+					: (void *)mpf->mpf_physptr)) {
 			smp_found_config = 0;
 			printk(KERN_ERR "BIOS bug, MP table errors detected!...\n");
 			printk(KERN_ERR "... disabling SMP support. (tell your hw vendor)\n");
@@ -737,8 +740,25 @@
 			printk("found SMP MP-table at %08lx\n",
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
@@ -750,8 +770,6 @@
 
 void __init find_smp_config (void)
 {
-	unsigned int address;
-
 	/*
 	 * FIXME: Linux assumes you have 640K of base ram..
 	 * this continues the error...
@@ -781,11 +799,13 @@
 	 * MP1.4 SPEC states to only scan first 1K of 4K EBDA.
 	 */
 
-	address = *(unsigned short *)phys_to_virt(0x40E);
-	address <<= 4;
-	smp_scan_config(address, 0x400);
-	if (smp_found_config)
-		printk(KERN_WARNING "WARNING: MP table in the EBDA can be UNSAFE, contact linux-smp@vger.kernel.org if you experience SMP problems!\n");
+	if (!pc98) {	/* PC-9800 has no EBDA area? */
+		unsigned int address = *(unsigned short *)phys_to_virt(0x40E);
+		address <<= 4;
+		smp_scan_config(address, 0x400);
+		if (smp_found_config)
+			printk(KERN_WARNING "WARNING: MP table in the EBDA can be UNSAFE, contact linux-smp@vger.kernel.org if you experience SMP problems!\n");
+	}
 }
 
 
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

--------------7C5D0E388895A6E22EA2E53C--

