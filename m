Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317258AbSHHC0h>; Wed, 7 Aug 2002 22:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317263AbSHHC0h>; Wed, 7 Aug 2002 22:26:37 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:34970 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317258AbSHHC0f>; Wed, 7 Aug 2002 22:26:35 -0400
Subject: [PATCH] cyclone-timer_A9
From: john stultz <johnstul@us.ibm.com>
To: marcelo <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>, Leah Cunningham <leahc@us.ibm.com>,
       wilhelm.nuesser@sap.com, paramjit@us.ibm.com, msw@redhat.com,
       James <jamesclv@us.ibm.com>
In-Reply-To: <1028771615.22918.188.camel@cog>
References: <1028771615.22918.188.camel@cog>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 07 Aug 2002 19:15:56 -0700
Message-Id: <1028772956.22920.207.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,
	This patch (which applies on top of my tsc-disable_B9 patch as well as
James Cleverdon's summit patch), is a performance improvement for
multi-CEC IBM x440 systems which suffer from drifting TSCs. Rather then
forcing do_gettimeofday to call do_slow_gettimeoffset and access the PIT
(as my tsc-disable patch does), passing "cyclone" as a boot option will
make do_gettimeofday use a 100Mhz performance counter found in the
Summit chipset.

This patch does not effect/correct userspace access to the unsynced TSC
registers via the rdtsc call.

Comments, flames, etc welcome.

thanks
-john

diff -Nru a/Documentation/Configure.help b/Documentation/Configure.help
--- a/Documentation/Configure.help	Wed Aug  7 19:00:21 2002
+++ b/Documentation/Configure.help	Wed Aug  7 19:00:21 2002
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
--- a/arch/i386/config.in	Wed Aug  7 19:00:20 2002
+++ b/arch/i386/config.in	Wed Aug  7 19:00:20 2002
@@ -205,6 +205,7 @@
    bool 'Multi-node NUMA system support' CONFIG_X86_NUMA
    if [ "$CONFIG_X86_NUMA" = "y" ]; then
       bool '  Multiquad (IBM/Sequent) NUMAQ support' CONFIG_MULTIQUAD
+      bool '  IBM x440 Summit support' CONFIG_X86_SUMMIT_NUMA
    fi
 fi
 
diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	Wed Aug  7 19:00:20 2002
+++ b/arch/i386/kernel/time.c	Wed Aug  7 19:00:21 2002
@@ -256,6 +256,138 @@
 
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
+static int __init cyclone_setup(char *str)
+{
+	bad_tsc = 1;
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
+	printk("Summit chipset: Starting Cyclone Clock.\n");
+
+	/*find base address*/
+	pageaddr = (CYCLONE_CBAR_ADDR)&PAGE_MASK;
+	offset = (CYCLONE_CBAR_ADDR)&(~PAGE_MASK);
+	set_fixmap_nocache(FIX_CYCLONE_TIMER, pageaddr);
+	reg = (u32*)(fix_to_virt(FIX_CYCLONE_TIMER) + offset);
+	if(!reg){
+		printk("Summit chipset: Could not find valid CBAR register.\n");
+		return;
+	}
+	base = *reg;	
+	if(!base){
+		printk("Summit chipset: Could not find valid CBAR value.\n");
+		return;
+	}
+	
+	/*setup PMCC*/
+	pageaddr = (base + CYCLONE_PMCC_OFFSET)&PAGE_MASK;
+	offset = (base + CYCLONE_PMCC_OFFSET)&(~PAGE_MASK);
+	set_fixmap_nocache(FIX_CYCLONE_TIMER, pageaddr);
+	reg = (u32*)(fix_to_virt(FIX_CYCLONE_TIMER) + offset);
+	if(!reg){
+		printk("Summit chipset: Could not find valid PMCC register.\n");
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
+		printk("Summit chipset: Could not find valid MPCS register.\n");
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
+		printk("Summit chipset: Could not find valid MPMC register.\n");
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
@@ -481,8 +613,7 @@
 	 */
 	write_lock(&xtime_lock);
 
-	if (use_tsc)
-	{
+	if (use_tsc) {
 		/*
 		 * It is important that these two operations happen almost at
 		 * the same time. We do the RDTSC stuff first, since it's
@@ -508,8 +639,11 @@
 
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
@@ -709,6 +843,9 @@
 			}
 		}
 	}
+
+ 	if((!use_tsc) && use_cyclone)
+		init_cyclone_clock();
 
 #ifdef CONFIG_VISWS
 	printk("Starting Cobalt Timer system clock\n");
diff -Nru a/include/asm-i386/fixmap.h b/include/asm-i386/fixmap.h
--- a/include/asm-i386/fixmap.h	Wed Aug  7 19:00:20 2002
+++ b/include/asm-i386/fixmap.h	Wed Aug  7 19:00:20 2002
@@ -61,6 +61,9 @@
 	FIX_LI_PCIA,	/* Lithium PCI Bridge A */
 	FIX_LI_PCIB,	/* Lithium PCI Bridge B */
 #endif
+#ifdef CONFIG_X86_SUMMIT_NUMA
+	FIX_CYCLONE_TIMER, /*cyclone timer register*/
+#endif 
 #ifdef CONFIG_HIGHMEM
 	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
 	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,


