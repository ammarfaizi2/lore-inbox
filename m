Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317298AbSGICmz>; Mon, 8 Jul 2002 22:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317299AbSGICmy>; Mon, 8 Jul 2002 22:42:54 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:39643 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317298AbSGICmw>;
	Mon, 8 Jul 2002 22:42:52 -0400
Subject: [RFC] bt_ioremap question / cyclone-timer_A1 patch
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 08 Jul 2002 19:36:23 -0700
Message-Id: <1026182183.28341.68.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all, 
	I've been working on improving performance of do_gettimeofday on
certain NUMA hardware (see my earlier tsc-disable posts for why the TSCs
cannot be used), and I wanted to run this by the list to make sure I'm
not doing anything too daft. 

Mainly I'm concerned about my usage of bt_ioremap. Early in the boot
processes, I need to map in a couple of chipset registers and poke
values into them. However one of the registers needs to be kept mapped
for the life of the system (look for "cyclone_timer" below). I couldn't
find any documentation on whether memory mapped with bt_ioremap can be
held across mem_init(). It seems to "just work" but I wanted to find out
if I really should be re-mapping the register w/ ioremap once it becomes
available. 

If you see any other issues with the patch, please let me know (I do
realize its a bit #ifdef happy, so go easy on that point). 

Comments, suggestions and flames welcome

thanks
-john

PS: If you are so inclined/loony to actually try this patch, please note
that it depends on my tsc-disable_B2 patch to apply cleanly. 


diff -Nru a/Documentation/Configure.help b/Documentation/Configure.help
--- a/Documentation/Configure.help	Mon Jul  8 10:53:02 2002
+++ b/Documentation/Configure.help	Mon Jul  8 10:53:02 2002
@@ -257,6 +257,11 @@
   You will need a new lynxer.elf file to flash your firmware with - send
   email to Martin.Bligh@us.ibm.com
 
+IBM Enterprise X-Architecture support
+CONFIG_X86_IBMEXA
+  This option makes use of a performance counter on the Cyclone chipset 
+  for calculating do_gettimeofday, greatly improving its performance. 
+
 IO-APIC support on uniprocessors
 CONFIG_X86_UP_IOAPIC
   An IO-APIC (I/O Advanced Programmable Interrupt Controller) is an
diff -Nru a/arch/i386/config.in b/arch/i386/config.in
--- a/arch/i386/config.in	Mon Jul  8 10:53:02 2002
+++ b/arch/i386/config.in	Mon Jul  8 10:53:02 2002
@@ -201,6 +201,7 @@
 	bool 'Multi-node NUMA system support (Caution: Read help first)' CONFIG_X86_NUMA
 	if [ "$CONFIG_X86_NUMA" = "y" ]; then
 		bool 'Multiquad (IBM/Sequent) NUMAQ support' CONFIG_MULTIQUAD
+		bool 'IBM Enterprise X-Architecture support' CONFIG_X86_IBMEXA
 	fi
 fi
 
diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	Mon Jul  8 10:53:02 2002
+++ b/arch/i386/kernel/time.c	Mon Jul  8 10:53:02 2002
@@ -253,6 +253,87 @@
 
 static unsigned long (*do_gettimeoffset)(void) = do_slow_gettimeoffset;
 
+
+
+#ifdef CONFIG_X86_IBMEXA
+#define CYCLONE_CBAR_ADDR 0xFEB00CD0
+#define CYCLONE_PMCC_OFFSET 0x51A0
+#define CYCLONE_MPMC_OFFSET 0x51D0
+#define CYCLONE_MPCS_OFFSET 0x51A8
+#define CYCLONE_TIMER_FREQ 100000000
+static u32* cyclone_timer;	/*Cyclone MPMC0 register*/
+static void init_cyclone_clock(void)
+{
+	u32* cyclone_cbar;	/*Cyclone BaseAddr register*/
+	u32* cyclone_pmcc;	/*Cyclone PMCC register*/
+	u32* cyclone_mpcs;	/*Cyclone MPCS register*/
+	u32 base;
+
+	/*find base address*/
+	cyclone_cbar = bt_ioremap(CYCLONE_CBAR_ADDR, 4);
+	if(!cyclone_cbar) return;
+	base = *cyclone_cbar;	
+	bt_iounmap(cyclone_cbar, 4);
+
+	/*setup PMCC*/
+	cyclone_pmcc = bt_ioremap(base + CYCLONE_PMCC_OFFSET, 8);
+	if(!cyclone_pmcc) return;
+	cyclone_pmcc[0] = 0x00000001;
+	bt_iounmap(cyclone_pmcc, 8);
+
+	/*setup MPCS*/
+	cyclone_mpcs = bt_ioremap(base + CYCLONE_MPCS_OFFSET, 8);
+	if(!cyclone_mpcs) return;
+	cyclone_mpcs[0] = 0x00000001;
+	bt_iounmap(cyclone_mpcs, 8);
+
+	/*map in cyclone_timer*/	
+	cyclone_timer = bt_ioremap(base + CYCLONE_MPMC_OFFSET, 8);
+}
+
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
+	offset = offset*(1000000/CYCLONE_TIMER_FREQ); 
+
+	/* our adjusted time offset in microseconds */
+	return delay_at_last_interrupt + offset;
+}
+#endif /*CONFIG_X86_IBMEXA*/
+
 #else
 
 #define do_gettimeoffset()	do_fast_gettimeoffset()
@@ -459,6 +540,7 @@
 }
 
 static int use_tsc;
+static int use_cyclone =1; /*XXX should be autodetected*/
 
 /*
  * This is the same as the above, except we _also_ save the current
@@ -506,6 +588,10 @@
 		count = ((LATCH-1) - count) * TICK_SIZE;
 		delay_at_last_interrupt = (count + LATCH/2) / LATCH;
 	}
+#ifdef CONFIG_X86_IBMEXA
+ 	if(use_cyclone)
+		mark_timeoffset_cyclone();
+#endif /*CONFIG_X86_IBMEXA*/
  
 	do_timer_interrupt(irq, NULL, regs);
 
@@ -695,6 +781,14 @@
 			}
 		}
 	}
+
+#ifdef CONFIG_X86_IBMEXA
+ 	if((!use_tsc) && use_cyclone){
+		printk("IBM EXA: Starting Cyclone Clock.\n");
+		do_gettimeoffset = do_gettimeoffset_cyclone;
+		init_cyclone_clock();
+	}
+#endif /*CONFIG_X86_IBMEXA*/
 
 #ifdef CONFIG_VISWS
 	printk("Starting Cobalt Timer system clock\n");


