Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319055AbSH2BrT>; Wed, 28 Aug 2002 21:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319063AbSH2BrT>; Wed, 28 Aug 2002 21:47:19 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:47297 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319055AbSH2BrQ>;
	Wed, 28 Aug 2002 21:47:16 -0400
Subject: [RFC][PATCH] linux-2.4.20-pre5_cyclone-timer_B0
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Leah Cunningham <leahc@us.ibm.com>,
       Wendy Hung <wendyh@us.ibm.com>, marcelo <marcelo@conectiva.com.br>,
       James <jamesclv@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 28 Aug 2002 18:49:19 -0700
Message-Id: <1030585759.3056.76.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just another resync w/ pre5. This patch allows users to pass "cyclone"
as a boot to force all CPUs to use a global on-chipset performance
counter for their gettimeofday calculations. This greatly improves
performance over using the PIT for gettimeofday. You'll also probably
want James Cleverdon's summit patch for this to be very useful. 

Still on the TODO list:
o Borrow James' auto-detection code
o Cyclone based udelay

Let me know if you have any comments. 

thanks
-john

diff -Nru a/Documentation/Configure.help b/Documentation/Configure.help
--- a/Documentation/Configure.help	Wed Aug 28 17:05:06 2002
+++ b/Documentation/Configure.help	Wed Aug 28 17:05:06 2002
@@ -252,6 +252,14 @@
   You will need a new lynxer.elf file to flash your firmware with - send
   email to Martin.Bligh@us.ibm.com
 
+IBM x440 Summit support
+CONFIG_X86_SUMMIT_NUMA
+  This option enables support for the IBM x440 and related multi-CEC 
+  systems based on the Summit chipset. This options allows you to pass
+  "cyclone" as a boot option to make use of a performance counter on 
+  the Cyclone chipset for calculating do_gettimeofday, greatly 
+  improving performance when compared to the PIT based method. 
+
 IO-APIC support on uniprocessors
 CONFIG_X86_UP_IOAPIC
   An IO-APIC (I/O Advanced Programmable Interrupt Controller) is an
diff -Nru a/arch/i386/config.in b/arch/i386/config.in
--- a/arch/i386/config.in	Wed Aug 28 17:05:06 2002
+++ b/arch/i386/config.in	Wed Aug 28 17:05:06 2002
@@ -216,12 +216,18 @@
       define_bool CONFIG_X86_IO_APIC y
    fi
 else
-   bool 'Multiquad NUMA system' CONFIG_MULTIQUAD
+   bool 'Multi-node NUMA system support' CONFIG_X86_NUMA
+   if [ "$CONFIG_X86_NUMA" = "y" ]; then
+      bool '  Multiquad (IBM/Sequent) NUMAQ support' CONFIG_MULTIQUAD
+      bool '  IBM x440 Summit support' CONFIG_X86_SUMMIT_NUMA
+   fi
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
diff -Nru a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
--- a/arch/i386/kernel/setup.c	Wed Aug 28 17:05:06 2002
+++ b/arch/i386/kernel/setup.c	Wed Aug 28 17:05:06 2002
@@ -1174,7 +1174,7 @@
 

 #ifndef CONFIG_X86_TSC
-static int tsc_disable __initdata = 0;
+int tsc_disable __initdata = 0;
 
 static int __init notsc_setup(char *str)
 {
diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	Wed Aug 28 17:05:06 2002
+++ b/arch/i386/kernel/time.c	Wed Aug 28 17:05:06 2002
@@ -256,6 +256,140 @@
 
 static unsigned long (*do_gettimeoffset)(void) = do_slow_gettimeoffset;
 
+
+
+#ifdef CONFIG_X86_SUMMIT_NUMA
+
+#define CYCLONE_CBAR_ADDR 0xFEB00CD0
+#define CYCLONE_PMCC_OFFSET 0x51A0
+#define CYCLONE_MPMC_OFFSET 0x51D0
+#define CYCLONE_MPCS_OFFSET 0x51A8
+#define CYCLONE_TIMER_FREQ 100000000
+
+static int use_cyclone __initdata = 0;
+extern int tsc_disable;
+/*XXX - should autodetect*/
+static int __init cyclone_setup(char *str) 
+{
+	tsc_disable = 1;
+	use_cyclone = 1;
+	return 1;
+}
+__setup("cyclone", cyclone_setup);
+
+
+static u32* cyclone_timer;	/*Cyclone MPMC0 register*/
+static u32 last_cyclone_timer;
+
+static inline void mark_timeoffset_cyclone(void)
+{
+	int count;
+
+	/*quickly read the cyclone timer*/
+	if(cyclone_timer)
+		last_cyclone_timer = cyclone_timer[0];
+
+	/*calculate delay_at_last_interrupt*/
+	spin_lock(&i8253_lock);
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
+	/* .. relative to previous jiffy*/
+	offset = offset - last_cyclone_timer;
+
+	/*convert cyclone ticks to microseconds*/	
+	offset = offset/100;	/*XXX slow, can we speed this up?*/
+
+	/* our adjusted time offset in microseconds */
+	return delay_at_last_interrupt + offset;
+}
+
+static void init_cyclone_clock(void)
+{
+	u32* reg;	
+	u32 base;	/*saved cyclone base address*/
+	u32 pageaddr; /*page that contains cyclone_timer register*/
+	u32 offset;	/*offset from pageaddr to cyclone_timer register*/
+
+	printk(KERN_INFO "Summit chipset: Starting Cyclone Clock.\n");
+
+	/*find base address*/
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
+	/*setup PMCC*/
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
+	/*setup MPCS*/
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
+	/*map in cyclone_timer*/
+	pageaddr = (base + CYCLONE_MPMC_OFFSET)&PAGE_MASK;
+	offset = (base + CYCLONE_MPMC_OFFSET)&(~PAGE_MASK);
+	set_fixmap_nocache(FIX_CYCLONE_TIMER, pageaddr);
+	cyclone_timer = (u32*)(fix_to_virt(FIX_CYCLONE_TIMER) + offset);
+	if(!cyclone_timer){
+		printk(KERN_ERR "Summit chipset: Could not find valid MPMC register.\n");
+		return;
+	}
+
+	/* Everything looks good, so set do_gettimeoffset*/
+	do_gettimeoffset = do_gettimeoffset_cyclone;	
+}
+
+#else /*CONFIG_X86_SUMMIT_NUMA*/
+
+#define use_cyclone 0
+static void mark_timeoffset_cyclone(void) {}
+static unsigned long do_gettimeoffset_cyclone(void) {return 0;}
+static void init_cyclone_clock(void) {}
+
+#endif /*CONFIG_X86_SUMMIT_NUMA*/
+
 #else
 
 #define do_gettimeoffset()	do_fast_gettimeoffset()
@@ -481,8 +615,7 @@
 	 */
 	write_lock(&xtime_lock);
 
-	if (use_tsc)
-	{
+	if (use_tsc) {
 		/*
 		 * It is important that these two operations happen almost at
 		 * the same time. We do the RDTSC stuff first, since it's
@@ -508,8 +641,11 @@
 
 		count = ((LATCH-1) - count) * TICK_SIZE;
 		delay_at_last_interrupt = (count + LATCH/2) / LATCH;
-	}
- 
+	} else {
+		if(use_cyclone)
+			mark_timeoffset_cyclone();
+ 	}
+	
 	do_timer_interrupt(irq, NULL, regs);
 
 	write_unlock(&xtime_lock);
@@ -698,6 +834,9 @@
 			}
 		}
 	}
+
+ 	if((!use_tsc) && use_cyclone)
+		init_cyclone_clock();
 
 #ifdef CONFIG_VISWS
 	printk("Starting Cobalt Timer system clock\n");
diff -Nru a/include/asm-i386/fixmap.h b/include/asm-i386/fixmap.h
--- a/include/asm-i386/fixmap.h	Wed Aug 28 17:05:06 2002
+++ b/include/asm-i386/fixmap.h	Wed Aug 28 17:05:06 2002
@@ -64,6 +64,9 @@
 #ifndef CONFIG_X86_F00F_WORKS_OK
 	FIX_F00F,
 #endif
+#ifdef CONFIG_X86_SUMMIT_NUMA
+	FIX_CYCLONE_TIMER, /*cyclone timer register*/
+#endif 
 #ifdef CONFIG_HIGHMEM
 	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
 	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,

