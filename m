Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317458AbSHHLyY>; Thu, 8 Aug 2002 07:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317472AbSHHLyY>; Thu, 8 Aug 2002 07:54:24 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:55790 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317458AbSHHLyW>; Thu, 8 Aug 2002 07:54:22 -0400
Subject: Re: [PATCH] tsc-disable_B9
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: john stultz <johnstul@us.ibm.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, Leah Cunningham <leahc@us.ibm.com>,
       wilhelm.nuesser@sap.com, paramjit@us.ibm.com, msw@redhat.com
In-Reply-To: <1028771615.22918.188.camel@cog>
References: <1028771615.22918.188.camel@cog>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 08 Aug 2002 14:17:43 +0100
Message-Id: <1028812663.28883.32.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-08 at 02:53, john stultz wrote:
> already seen on another cpu. This patch allows people compiling w/
> 'Multi-node NUMA support' to pass "notsc" or "bad-tsc" as boot
> parameters. "notsc" disables rdtsc calls, and forces the kernel to use
> the PIT for gettimeofday calucluations (as normally expected w/ i386
> compiled kernels). While "bad-tsc" forces the kernel to use the PIT for
> gettimeofday, but does not disable TSC access. 

I've done a version of this for -ac which uses the NUMA autodetect, and
also provides the hook so I can disable tsc on split on x86 smp with
variable multipliers some time. The only comment I really have is please
use "badtsc" not "bad-tsc" - to match "notsc"

This is how I did it - barring the code that is -ac specific to automatically flip
the mode when NUMA hw is detected


diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.20pre1/include/asm-i386/processor.h linux.20pre1-ac2/include/asm-i386/processor.h
--- linux.20pre1/include/asm-i386/processor.h	2002-08-06 15:40:34.000000000 +0100
+++ linux.20pre1-ac2/include/asm-i386/processor.h	2002-08-07 15:23:39.000000000 +0100
@@ -96,7 +96,7 @@
 
 extern void identify_cpu(struct cpuinfo_x86 *);
 extern void print_cpu_info(struct cpuinfo_x86 *);
-extern void dodgy_tsc(void);
+extern int dodgy_tsc(void);
 
 /*
  * EFLAGS bits
--- linux.vanilla/arch/i386/kernel/time.c	2002-02-25 19:37:53.000000000 +0000
+++ linux.20pre1-ac2/arch/i386/kernel/time.c	2002-08-08 12:56:48.000000000 +0100
@@ -666,9 +666,7 @@
  	 *	moaned if you have the only one in the world - you fix it!
  	 */
  
- 	dodgy_tsc();
- 	
-	if (cpu_has_tsc) {
+	if (!dodgy_tsc()) {
 		unsigned long tsc_quotient = calibrate_tsc();
 		if (tsc_quotient) {
 			fast_gettimeoffset_quotient = tsc_quotient;
diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.20pre1/arch/i386/kernel/setup.c linux.20pre1-ac2/arch/i386/kernel/setup.c
--- linux.20pre1/arch/i386/kernel/setup.c	2002-08-06 15:41:42.000000000 +0100
+++ linux.20pre1-ac2/arch/i386/kernel/setup.c	2002-08-07 15:23:29.000000000 +0100
@@ -1193,19 +1126,51 @@
 }
 __setup("cachesize=", cachesize_setup);
 
-
 #ifndef CONFIG_X86_TSC
+
 static int tsc_disable __initdata = 0;
 
-static int __init tsc_setup(char *str)
+void disable_tsc(void)
+{
+	if(tsc_disable == 0)
+	{
+		printk(KERN_INFO "Disabling use of TSC for time counting.\n");
+		tsc_disable = 1;
+	}
+}
+
+/* Disable TSC on processor and also for get time of day */
+
+static int __init notsc_setup(char *str)
+{
+	tsc_disable = 2;
+	return 1;
+}
+
+__setup("notsc", notsc_setup);
+
+/* Allow TSC use but don't use it for gettimeofday  */
+
+static int __init badtsc_setup(char *str)
 {
 	tsc_disable = 1;
 	return 1;
 }
 
-__setup("notsc", tsc_setup);
+__setup("badtsc", badtsc_setup);
+
+#else
+
+#define tsc_disable	0
+
+void disable_tsc(void)
+{
+	panic("Time stamp counter required by this kernel, but not supported by the hardware.\n");
+}
+
 #endif
 
+
 static int __init get_model_name(struct cpuinfo_x86 *c)
 {
 	unsigned int *v;
@@ -2843,10 +2762,8 @@
 	 */
 
 	/* TSC disabled? */
-#ifndef CONFIG_X86_TSC
-	if ( tsc_disable )
+	if ( tsc_disable > 1 )
 		clear_bit(X86_FEATURE_TSC, &c->x86_capability);
-#endif
 
 	/* HT disabled? */
 	if (disable_x86_ht)
@@ -2906,13 +2823,23 @@
  *	Perform early boot up checks for a valid TSC. See arch/i386/kernel/time.c
  */
  
-void __init dodgy_tsc(void)
+int __init dodgy_tsc(void)
 {
 	get_cpu_vendor(&boot_cpu_data);
 
 	if ( boot_cpu_data.x86_vendor == X86_VENDOR_CYRIX ||
 	     boot_cpu_data.x86_vendor == X86_VENDOR_NSC )
 		init_cyrix(&boot_cpu_data);
+		
+	/* Is it disabled ? */
+	if(tsc_disable)
+		return 1;
+		
+	/* Does it exist ? */
+	if(!cpu_has_tsc)
+		return 1;
+		
+	return 0;
 }
 

@@ -3088,14 +3021,12 @@
 
 	if (cpu_has_vme || cpu_has_tsc || cpu_has_de)
 		clear_in_cr4(X86_CR4_VME|X86_CR4_PVI|X86_CR4_TSD|X86_CR4_DE);
-#ifndef CONFIG_X86_TSC
-	if (tsc_disable && cpu_has_tsc) {
+	if (tsc_disable > 1 && cpu_has_tsc) {
 		printk(KERN_NOTICE "Disabling TSC...\n");
 		/**** FIX-HPA: DOES THIS REALLY BELONG HERE? ****/
 		clear_bit(X86_FEATURE_TSC, boot_cpu_data.x86_capability);
 		set_in_cr4(X86_CR4_TSD);
 	}
-#endif
 
 	__asm__ __volatile__("lgdt %0": "=m" (gdt_descr));
 	__asm__ __volatile__("lidt %0": "=m" (idt_descr));
