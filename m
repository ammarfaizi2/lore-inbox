Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319852AbSINEJA>; Sat, 14 Sep 2002 00:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319853AbSINEJA>; Sat, 14 Sep 2002 00:09:00 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:11773 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319852AbSINEI4>;
	Sat, 14 Sep 2002 00:08:56 -0400
Subject: [PATCH] linux-2.4.20-pre7_cyclone-timer_B1
From: john stultz <johnstul@us.ibm.com>
To: marcelo <marcelo@conectiva.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, James <jamesclv@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>, msw@redhat.com,
       Hubert Mantel <mantel@suse.de>, Wendy Hung <wendyh@us.ibm.com>,
       Leah Cunningham <leahc@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 13 Sep 2002 21:08:11 -0700
Message-Id: <1031976492.4357.99.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo, All,

	Here is my next rev of the cyclone-timer patch, which applies on top of
James Cleverdon's most recent 2.4 summit patch. Couple of new things in
this patch, which are: 

o Autodetection works. No more "cyclone" boot option!
	- Bummed off of James' autodetection code.
o Cyclone based __udelay (Suggested by Alan, way back)
o Patch does not change userspace access to the rdtsc instruction
	- Works w/ & w/o "notsc" option.
	- I'm straddling the fence on this one.
o A couple of minor cleanups and fixes

Marcelo: Please consider this... well, actually, please first consider
James' patch (Message-ID: <200209121407.35890.jamesclv@us.ibm.com>) for
inclusion, then mine afterward. :)

Matt, Hubert: I'll send the backports Monday after whatever
feedback/flames have hit my inbox.

thanks
-john


diff -Nru a/Documentation/Configure.help b/Documentation/Configure.help
--- a/Documentation/Configure.help	Fri Sep 13 20:33:41 2002
+++ b/Documentation/Configure.help	Fri Sep 13 20:33:41 2002
@@ -259,7 +259,10 @@
 
   In particular, it is needed for the x440 boxen and helps with
   performance on x360s.  (The x440 is a NUMA box, even for the 4-CPU
-  model.  The x360 is a non-NUMA system.)
+  model.  The x360 is a non-NUMA system.) Additionally, this patch
+  uses a performance counter on the cyclone chipset for gettimeofday
+  calculations, which avoids internal time skew between cpus caused
+  by unsynced TSCs. 
 
   If you don't have any of these computers, you may safely say N.
 
diff -Nru a/arch/i386/config.in b/arch/i386/config.in
--- a/arch/i386/config.in	Fri Sep 13 20:33:41 2002
+++ b/arch/i386/config.in	Fri Sep 13 20:33:41 2002
@@ -220,9 +220,11 @@
    dep_bool 'Summit Architecture support' CONFIG_SUMMIT $CONFIG_MULTIQUAD
 fi
 
-bool 'Unsynced TSC support' CONFIG_X86_TSC_DISABLE
-if [ "$CONFIG_X86_TSC_DISABLE" != "y" -a "$CONFIG_X86_HAS_TSC" = "y" ]; then
-   define_bool CONFIG_X86_TSC y
+if [ "$CONFIG_MULTIQUAD" != "y" ]; then
+   bool 'Unsynced TSC support' CONFIG_X86_TSC_DISABLE
+   if [ "$CONFIG_X86_TSC_DISABLE" != "y" -a "$CONFIG_X86_HAS_TSC" = "y" ]; then
+      define_bool CONFIG_X86_TSC y
+   fi
 fi
 
 if [ "$CONFIG_SMP" = "y" -a "$CONFIG_X86_CMPXCHG" = "y" ]; then
diff -Nru a/arch/i386/kernel/mpparse.c b/arch/i386/kernel/mpparse.c
--- a/arch/i386/kernel/mpparse.c	Fri Sep 13 20:33:41 2002
+++ b/arch/i386/kernel/mpparse.c	Fri Sep 13 20:33:41 2002
@@ -404,6 +404,9 @@
        }
 }
 
+
+extern int cyclone_setup(char*);
+
 /*
  * Read/parse the MPC
  */
@@ -451,9 +454,11 @@
 	/*
 	 * Can't recognize Summit xAPICs at present, so use the OEM ID.
 	 */
-	if (!strncmp(oem, "IBM ENSW", 8) && (!strncmp(prod, "NF 6000R", 8) || !strncmp(prod, "VIGIL SMP", 9)))
+	if (!strncmp(oem, "IBM ENSW", 8) && (!strncmp(prod, "NF 6000R", 8) || !strncmp(prod, "VIGIL SMP", 9))){
 		xapic = 1;
-	else if (!strncmp(oem, "IBM NUMA", 8))
+		/*enable cyclone timer*/
+		cyclone_setup((char*)0);
+	}else if (!strncmp(oem, "IBM NUMA", 8))
 		numaq = 2;
 
 	printk("APIC at: 0x%lX\n",mpc->mpc_lapic);
diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	Fri Sep 13 20:33:41 2002
+++ b/arch/i386/kernel/time.c	Fri Sep 13 20:33:41 2002
@@ -256,12 +256,160 @@
 
 static unsigned long (*do_gettimeoffset)(void) = do_slow_gettimeoffset;
 
+
+/* IBM Summit (EXA) Cyclone Timer code*/
+#ifdef CONFIG_SUMMIT
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
+
+	printk(KERN_INFO "Summit chipset: Starting Cyclone Clock.\n");
+
+	/* find base address */
+	pageaddr = (CYCLONE_CBAR_ADDR)&PAGE_MASK;
+	offset = (CYCLONE_CBAR_ADDR)&(~PAGE_MASK);
+	set_fixmap_nocache(FIX_CYCLONE_TIMER, pageaddr);
+	reg = (u32*)(fix_to_virt(FIX_CYCLONE_TIMER) + offset);
+	if(!reg){
+		printk(KERN_ERR "Summit chipset: Could not find valid CBAR register.\n");
+		return;
+	}
+	base = *reg;	
+	if(!base){
+		printk(KERN_ERR "Summit chipset: Could not find valid CBAR value.\n");
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
+		return;
+	}
+
+	/* Everything looks good, so set do_gettimeoffset */
+	do_gettimeoffset = do_gettimeoffset_cyclone;	
+}
+
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
+#endif /* CONFIG_SUMMIT */
+
 #else
 
 #define do_gettimeoffset()	do_fast_gettimeoffset()
 
 #endif
 
+/* No-cyclone stubs */
+#ifndef CONFIG_SUMMIT
+int __init cyclone_setup(char *str) 
+{
+	printk(KERN_ERR "cyclone: Kernel not compiled with CONFIG_SUMMIT, cannot use the cyclone-timer.\n");
+	return 1;
+}
+
+const int use_cyclone = 0;
+static void mark_timeoffset_cyclone(void) {}
+static unsigned long do_gettimeoffset_cyclone(void) {return 0;}
+static void init_cyclone_clock(void) {}
+void __cyclone_delay(unsigned long loops) {}
+#endif /* CONFIG_SUMMIT */
+
 /*
  * This version of gettimeofday has microsecond resolution
  * and better than microsecond precision on fast x86 machines with TSC.
@@ -481,8 +629,9 @@
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
@@ -509,7 +658,7 @@
 		count = ((LATCH-1) - count) * TICK_SIZE;
 		delay_at_last_interrupt = (count + LATCH/2) / LATCH;
 	}
- 
+
 	do_timer_interrupt(irq, NULL, regs);
 
 	write_unlock(&xtime_lock);
@@ -670,21 +819,30 @@
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
@@ -698,6 +856,7 @@
 			}
 		}
 	}
+
 
 #ifdef CONFIG_VISWS
 	printk("Starting Cobalt Timer system clock\n");
diff -Nru a/arch/i386/lib/delay.c b/arch/i386/lib/delay.c
--- a/arch/i386/lib/delay.c	Fri Sep 13 20:33:41 2002
+++ b/arch/i386/lib/delay.c	Fri Sep 13 20:33:41 2002
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
--- a/include/asm-i386/fixmap.h	Fri Sep 13 20:33:41 2002
+++ b/include/asm-i386/fixmap.h	Fri Sep 13 20:33:41 2002
@@ -64,6 +64,9 @@
 #ifndef CONFIG_X86_F00F_WORKS_OK
 	FIX_F00F,
 #endif
+#ifdef CONFIG_SUMMIT
+	FIX_CYCLONE_TIMER, /*cyclone timer register*/
+#endif 
 #ifdef CONFIG_HIGHMEM
 	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
 	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,

