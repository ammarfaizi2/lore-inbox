Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266926AbSLKAQV>; Tue, 10 Dec 2002 19:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266927AbSLKAQV>; Tue, 10 Dec 2002 19:16:21 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:17607 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S266926AbSLKAQP>; Tue, 10 Dec 2002 19:16:15 -0500
Subject: [RFC][PATCH] linux-2.4.20-pre1_cyclone-timer_B3
From: john stultz <johnstul@us.ibm.com>
To: marcelo <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1039566102.8007.45.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 10 Dec 2002 16:21:43 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo, All,
	This patch fixes gettimeofday for multi-node Summit based systems (IBM
x440, etc). These systems suffer from TSC skew, and thus require an
alternate high res time source. This patch allows do_gettimeofday to
access a register on the cyclone chip found on these systems, which
functions as a global time source.

Please consider for acceptance.

thanks
-john


diff -Nru a/arch/i386/config.in b/arch/i386/config.in
--- a/arch/i386/config.in	Tue Dec 10 16:11:18 2002
+++ b/arch/i386/config.in	Tue Dec 10 16:11:18 2002
@@ -231,9 +231,11 @@
    fi
 fi
 
-bool 'Unsynced TSC support' CONFIG_X86_TSC_DISABLE
-if [ "$CONFIG_X86_TSC_DISABLE" != "y" -a "$CONFIG_X86_HAS_TSC" = "y" ]; then
-   define_bool CONFIG_X86_TSC y
+if [ "$CONFIG_X86_NUMA" != "y" ]; then
+   bool 'Unsynced TSC support' CONFIG_X86_TSC_DISABLE
+   if [ "$CONFIG_X86_TSC_DISABLE" != "y" -a "$CONFIG_X86_HAS_TSC" = "y" ]; then
+      define_bool CONFIG_X86_TSC y
+   fi
 fi
 
 if [ "$CONFIG_SMP" = "y" -a "$CONFIG_X86_CMPXCHG" = "y" ]; then
diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	Tue Dec 10 16:11:18 2002
+++ b/arch/i386/kernel/time.c	Tue Dec 10 16:11:18 2002
@@ -256,12 +256,177 @@
 
 static unsigned long (*do_gettimeoffset)(void) = do_slow_gettimeoffset;
 
+
+/* IBM Summit (EXA) Cyclone Timer code*/
+#ifdef CONFIG_X86_SUMMIT
+
+#define CYCLONE_CBAR_ADDR 0xFEB00CD0
+#define CYCLONE_PMCC_OFFSET 0x51A0
+#define CYCLONE_MPMC_OFFSET 0x51D0
+#define CYCLONE_MPCS_OFFSET 0x51A8
+#define CYCLONE_TIMER_FREQ 100000000
+
+int use_cyclone = 0;
+int __init cyclone_setup(char *str) 
+{
+	use_cyclone = 1;
+	return 1;
+}
+
+static u32* volatile cyclone_timer;	/* Cyclone MPMC0 register */
+static u32 last_cyclone_timer;
+
+static inline void mark_timeoffset_cyclone(void)
+{
+	int count;
+	spin_lock(&i8253_lock);
+	/* quickly read the cyclone timer */
+	if(cyclone_timer)
+		last_cyclone_timer = cyclone_timer[0];
+
+	/* calculate delay_at_last_interrupt */
+	outb_p(0x00, 0x43);     /* latch the count ASAP */
+
+	count = inb_p(0x40);    /* read the latched count */
+	count |= inb(0x40) << 8;
+	spin_unlock(&i8253_lock);
+
+	count = ((LATCH-1) - count) * TICK_SIZE;
+	delay_at_last_interrupt = (count + LATCH/2) / LATCH;
+}
+
+static unsigned long do_gettimeoffset_cyclone(void)
+{
+	u32 offset;
+
+	if(!cyclone_timer)
+		return delay_at_last_interrupt;
+
+	/* Read the cyclone timer */
+	offset = cyclone_timer[0];
+
+	/* .. relative to previous jiffy */
+	offset = offset - last_cyclone_timer;
+
+	/* convert cyclone ticks to microseconds */	
+	/* XXX slow, can we speed this up? */
+	offset = offset/(CYCLONE_TIMER_FREQ/1000000);
+
+	/* our adjusted time offset in microseconds */
+	return delay_at_last_interrupt + offset;
+}
+
+static void __init init_cyclone_clock(void)
+{
+	u32* reg;	
+	u32 base;		/* saved cyclone base address */
+	u32 pageaddr;	/* page that contains cyclone_timer register */
+	u32 offset;		/* offset from pageaddr to cyclone_timer register */
+	int i;
+	
+	printk(KERN_INFO "Summit chipset: Starting Cyclone Counter.\n");
+
+	/* find base address */
+	pageaddr = (CYCLONE_CBAR_ADDR)&PAGE_MASK;
+	offset = (CYCLONE_CBAR_ADDR)&(~PAGE_MASK);
+	set_fixmap_nocache(FIX_CYCLONE_TIMER, pageaddr);
+	reg = (u32*)(fix_to_virt(FIX_CYCLONE_TIMER) + offset);
+	if(!reg){
+		printk(KERN_ERR "Summit chipset: Could not find valid CBAR register.\n");
+		use_cyclone = 0;
+		return;
+	}
+	base = *reg;	
+	if(!base){
+		printk(KERN_ERR "Summit chipset: Could not find valid CBAR value.\n");
+		use_cyclone = 0;
+		return;
+	}
+	
+	/* setup PMCC */
+	pageaddr = (base + CYCLONE_PMCC_OFFSET)&PAGE_MASK;
+	offset = (base + CYCLONE_PMCC_OFFSET)&(~PAGE_MASK);
+	set_fixmap_nocache(FIX_CYCLONE_TIMER, pageaddr);
+	reg = (u32*)(fix_to_virt(FIX_CYCLONE_TIMER) + offset);
+	if(!reg){
+		printk(KERN_ERR "Summit chipset: Could not find valid PMCC register.\n");
+		use_cyclone = 0;
+		return;
+	}
+	reg[0] = 0x00000001;
+
+	/* setup MPCS */
+	pageaddr = (base + CYCLONE_MPCS_OFFSET)&PAGE_MASK;
+	offset = (base + CYCLONE_MPCS_OFFSET)&(~PAGE_MASK);
+	set_fixmap_nocache(FIX_CYCLONE_TIMER, pageaddr);
+	reg = (u32*)(fix_to_virt(FIX_CYCLONE_TIMER) + offset);
+	if(!reg){
+		printk(KERN_ERR "Summit chipset: Could not find valid MPCS register.\n");
+		use_cyclone = 0;
+		return;
+	}
+	reg[0] = 0x00000001;
+
+	/* map in cyclone_timer */
+	pageaddr = (base + CYCLONE_MPMC_OFFSET)&PAGE_MASK;
+	offset = (base + CYCLONE_MPMC_OFFSET)&(~PAGE_MASK);
+	set_fixmap_nocache(FIX_CYCLONE_TIMER, pageaddr);
+	cyclone_timer = (u32*)(fix_to_virt(FIX_CYCLONE_TIMER) + offset);
+	if(!cyclone_timer){
+		printk(KERN_ERR "Summit chipset: Could not find valid MPMC register.\n");
+		use_cyclone = 0;
+		return;
+	}
+
+	/*quick test to make sure its ticking*/
+	for(i=0; i<3; i++){
+		u32 old = cyclone_timer[0];
+		int stall = 100;
+		while(stall--) barrier();
+		if(cyclone_timer[0] == old){
+			printk(KERN_ERR "Summit chipset: Counter not counting! DISABLED\n");
+			cyclone_timer = 0;
+			use_cyclone = 0;
+			return;
+		}
+	}
+	/* Everything looks good, so set do_gettimeoffset */
+	do_gettimeoffset = do_gettimeoffset_cyclone;	
+}
+void __cyclone_delay(unsigned long loops)
+{
+	unsigned long bclock, now;
+	if(!cyclone_timer)
+		return;
+	bclock = cyclone_timer[0];
+	do {
+		rep_nop();
+		now = cyclone_timer[0];
+	} while ((now-bclock) < loops);
+}
+#endif /* CONFIG_X86_SUMMIT */
+
 #else
 
 #define do_gettimeoffset()	do_fast_gettimeoffset()
 
 #endif
 
+/* No-cyclone stubs */
+#ifndef CONFIG_X86_SUMMIT
+int __init cyclone_setup(char *str) 
+{
+	printk(KERN_ERR "cyclone: Kernel not compiled with CONFIG_X86_SUMMIT, cannot use the cyclone-timer.\n");
+	return 1;
+}
+
+const int use_cyclone = 0;
+static void mark_timeoffset_cyclone(void) {}
+static unsigned long do_gettimeoffset_cyclone(void) {return 0;}
+static void init_cyclone_clock(void) {}
+void __cyclone_delay(unsigned long loops) {}
+#endif /* CONFIG_X86_SUMMIT */
+
 /*
  * This version of gettimeofday has microsecond resolution
  * and better than microsecond precision on fast x86 machines with TSC.
@@ -481,8 +646,9 @@
 	 */
 	write_lock(&xtime_lock);
 
-	if (use_tsc)
-	{
+	if(use_cyclone)
+		mark_timeoffset_cyclone();
+	else if (use_tsc) {
 		/*
 		 * It is important that these two operations happen almost at
 		 * the same time. We do the RDTSC stuff first, since it's
@@ -531,7 +697,7 @@
 		count = ((LATCH-1) - count) * TICK_SIZE;
 		delay_at_last_interrupt = (count + LATCH/2) / LATCH;
 	}
- 
+
 	do_timer_interrupt(irq, NULL, regs);
 
 	write_unlock(&xtime_lock);
@@ -692,21 +858,30 @@
  	 */
  
  	dodgy_tsc();
- 	
+
+ 	if(use_cyclone)
+		init_cyclone_clock();
+		
 	if (cpu_has_tsc) {
 		unsigned long tsc_quotient = calibrate_tsc();
 		if (tsc_quotient) {
 			fast_gettimeoffset_quotient = tsc_quotient;
-			use_tsc = 1;
-			/*
-			 *	We could be more selective here I suspect
-			 *	and just enable this for the next intel chips ?
+			/* XXX: This is messy
+			 * However, we want to allow for the cyclone timer 
+			 * to work w/ or w/o the TSCs being avaliable
+			 *      -johnstul@us.ibm.com
 			 */
-			x86_udelay_tsc = 1;
+			if(!use_cyclone){
+				/*
+				 *	We could be more selective here I suspect
+				 *	and just enable this for the next intel chips ?
+			 	 */
+				use_tsc = 1;
+				x86_udelay_tsc = 1;
 #ifndef do_gettimeoffset
-			do_gettimeoffset = do_fast_gettimeoffset;
+				do_gettimeoffset = do_fast_gettimeoffset;
 #endif
-
+			}
 			/* report CPU clock rate in Hz.
 			 * The formula is (10^6 * 2^32) / (2^32 * 1 / (clocks/us)) =
 			 * clock/second. Our precision is about 100 ppm.
@@ -720,6 +895,7 @@
 			}
 		}
 	}
+
 
 #ifdef CONFIG_VISWS
 	printk("Starting Cobalt Timer system clock\n");
diff -Nru a/arch/i386/lib/delay.c b/arch/i386/lib/delay.c
--- a/arch/i386/lib/delay.c	Tue Dec 10 16:11:18 2002
+++ b/arch/i386/lib/delay.c	Tue Dec 10 16:11:18 2002
@@ -56,10 +56,13 @@
 		:"=&a" (d0)
 		:"0" (loops));
 }
-
+extern __cyclone_delay(unsigned long loops);
+extern int use_cyclone;
 void __delay(unsigned long loops)
 {
-	if (x86_udelay_tsc)
+	if (use_cyclone)
+		__cyclone_delay(loops);
+	else if (x86_udelay_tsc)
 		__rdtsc_delay(loops);
 	else
 		__loop_delay(loops);
diff -Nru a/include/asm-i386/fixmap.h b/include/asm-i386/fixmap.h
--- a/include/asm-i386/fixmap.h	Tue Dec 10 16:11:18 2002
+++ b/include/asm-i386/fixmap.h	Tue Dec 10 16:11:18 2002
@@ -64,6 +64,9 @@
 #ifndef CONFIG_X86_F00F_WORKS_OK
 	FIX_F00F,
 #endif
+#ifdef CONFIG_X86_SUMMIT
+	FIX_CYCLONE_TIMER, /*cyclone timer register*/
+#endif 
 #ifdef CONFIG_HIGHMEM
 	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
 	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,
diff -Nru a/include/asm-i386/smpboot.h b/include/asm-i386/smpboot.h
--- a/include/asm-i386/smpboot.h	Tue Dec 10 16:11:18 2002
+++ b/include/asm-i386/smpboot.h	Tue Dec 10 16:11:18 2002
@@ -14,6 +14,8 @@
 extern unsigned char esr_disable;
 extern unsigned char int_delivery_mode;
 extern unsigned int int_dest_addr_mode;
+extern int cyclone_setup(char*);
+
 static inline void detect_clustered_apic(char* oem, char* prod)
 {
 	/*
@@ -25,6 +27,8 @@
 		int_dest_addr_mode = APIC_DEST_PHYSICAL;
 		int_delivery_mode = dest_Fixed;
 		esr_disable = 1;
+		/*Start cyclone clock*/
+		cyclone_setup(0);
 	}
 	else if (!strncmp(oem, "IBM NUMA", 8)){
 		clustered_apic_mode = CLUSTERED_APIC_NUMAQ;



