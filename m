Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262782AbSJJB3R>; Wed, 9 Oct 2002 21:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262799AbSJJB3Q>; Wed, 9 Oct 2002 21:29:16 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:36781 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262782AbSJJB3K>; Wed, 9 Oct 2002 21:29:10 -0400
Subject: [RFC][PATCH] linux-2.5.41_cyclone-timer_B2
From: john stultz <johnstul@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Jones <davej@suse.de>, george anzinger <george@mvista.com>,
       lkml <linux-kernel@vger.kernel.org>, greg kh <greg@kroah.com>,
       Patrick Mochel <mochel@osdl.org>
In-Reply-To: <1034208695.21965.1356.camel@cog>
References: <1034208695.21965.1356.camel@cog>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 09 Oct 2002 18:27:19 -0700
Message-Id: <1034213239.21965.1426.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, All,

        In order to demonstrate how new time-sources are added to my
timer-changes patch. Here is my current version of my cyclone-timer
patch for 2.5.41. This uses the infrastructure set up in the
timer-changes_A4 patch set to add the cyclone counter (found on IBM
Summit Based hardware) as a time-source. 
        
        The current code is non-functional as it also depends on James
Cleverdon's 2.5 summit patch, however it illustrates how cleanly new
time-sources can be added.
        
All comments, flames, etc. welcome.

thanks
-john

diff -Nru a/arch/i386/Config.help b/arch/i386/Config.help
--- a/arch/i386/Config.help	Wed Oct  9 18:23:25 2002
+++ b/arch/i386/Config.help	Wed Oct  9 18:23:25 2002
@@ -65,6 +65,14 @@
   You will need a new lynxer.elf file to flash your firmware with - send
   email to Martin.Bligh@us.ibm.com
 
+CONFIG_X86_CYCLONE
+  This patch used the Cyclone performance counter on IBM x440, x360,
+  and other Summit based systems for calculating gettimeofday. This 
+  fixes problems resulting from TSC skew found in multi-CEC system. 
+
+  If you are suffering from time skew using a multi-CEC system, say YES.
+  Otherwise it is safe to say NO.
+
 CONFIG_X86_UP_IOAPIC
   An IO-APIC (I/O Advanced Programmable Interrupt Controller) is an
   SMP-capable replacement for PC-style interrupt controllers. Most
diff -Nru a/arch/i386/config.in b/arch/i386/config.in
--- a/arch/i386/config.in	Wed Oct  9 18:23:25 2002
+++ b/arch/i386/config.in	Wed Oct  9 18:23:25 2002
@@ -183,6 +183,7 @@
            define_bool CONFIG_HAVE_ARCH_BOOTMEM_NODE y
         fi
      fi
+      bool 'Cyclone Counter Support' CONFIG_X86_CYCLONE
   fi
 fi
 
diff -Nru a/arch/i386/kernel/timers/Makefile b/arch/i386/kernel/timers/Makefile
--- a/arch/i386/kernel/timers/Makefile	Wed Oct  9 18:23:25 2002
+++ b/arch/i386/kernel/timers/Makefile	Wed Oct  9 18:23:25 2002
@@ -6,5 +6,6 @@
 
 obj-y += timer_tsc.o
 obj-y += timer_pit.o
+obj-$(CONFIG_X86_CYCLONE)   += timer_cyclone.o
 
 include $(TOPDIR)/Rules.make
diff -Nru a/arch/i386/kernel/timers/timer_cyclone.c b/arch/i386/kernel/timers/timer_cyclone.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/i386/kernel/timers/timer_cyclone.c	Wed Oct  9 18:23:25 2002
@@ -0,0 +1,172 @@
+/*	Cyclone-timer: 
+ *		This code implements timer_ops for the cyclone counter found
+ *		on IBM x440, x360, and other Summit based systems.
+ *
+ *	Copyright (C) 2002 IBM, John Stultz (johnstul@us.ibm.com)
+ */
+
+
+#include <linux/spinlock.h>
+#include <linux/init.h>
+#include <linux/timex.h>
+
+#include <asm/timer.h>
+#include <asm/io.h>
+#include <asm/pgtable.h>
+#include <asm/fixmap.h>
+
+extern spinlock_t i8253_lock;
+
+/* Number of usecs that the last interrupt was delayed */
+static int delay_at_last_interrupt;
+
+#define CYCLONE_CBAR_ADDR 0xFEB00CD0
+#define CYCLONE_PMCC_OFFSET 0x51A0
+#define CYCLONE_MPMC_OFFSET 0x51D0
+#define CYCLONE_MPCS_OFFSET 0x51A8
+#define CYCLONE_TIMER_FREQ 100000000
+
+int use_cyclone = 0;
+
+static u32* volatile cyclone_timer;	/* Cyclone MPMC0 register */
+static u32 last_cyclone_timer;
+
+static void mark_offset_cyclone(void)
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
+static unsigned long get_offset_cyclone(void)
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
+static int init_cyclone(void)
+{
+	u32* reg;	
+	u32 base;		/* saved cyclone base address */
+	u32 pageaddr;	/* page that contains cyclone_timer register */
+	u32 offset;		/* offset from pageaddr to cyclone_timer register */
+	int i;
+	
+	/*make sure we're on a summit box*/
+	/*XXX need to use proper summit hooks! such as xapic -john*/
+	if(!use_cyclone) return 0; 
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
+		return 0;
+	}
+	base = *reg;	
+	if(!base){
+		printk(KERN_ERR "Summit chipset: Could not find valid CBAR value.\n");
+		return 0;
+	}
+	
+	/* setup PMCC */
+	pageaddr = (base + CYCLONE_PMCC_OFFSET)&PAGE_MASK;
+	offset = (base + CYCLONE_PMCC_OFFSET)&(~PAGE_MASK);
+	set_fixmap_nocache(FIX_CYCLONE_TIMER, pageaddr);
+	reg = (u32*)(fix_to_virt(FIX_CYCLONE_TIMER) + offset);
+	if(!reg){
+		printk(KERN_ERR "Summit chipset: Could not find valid PMCC register.\n");
+		return 0;
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
+		return 0;
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
+		return 0;
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
+			return 0;
+		}
+	}
+
+	/* Everything looks good! */
+	return 1;
+}
+
+
+#if 0 /* XXX future work */
+static void delay_cyclone(unsigned long loops)
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
+#endif
+/************************************************************/
+
+/* cyclone timer_opts struct */
+struct timer_opts timer_cyclone = {
+	init: init_cyclone, 
+	mark_offset: mark_offset_cyclone, 
+	get_offset: get_offset_cyclone
+};
diff -Nru a/include/asm-i386/fixmap.h b/include/asm-i386/fixmap.h
--- a/include/asm-i386/fixmap.h	Wed Oct  9 18:23:25 2002
+++ b/include/asm-i386/fixmap.h	Wed Oct  9 18:23:25 2002
@@ -65,6 +65,9 @@
 #ifdef CONFIG_X86_F00F_BUG
 	FIX_F00F_IDT,	/* Virtual mapping for IDT */
 #endif
+#ifdef CONFIG_X86_CYCLONE
+	FIX_CYCLONE_TIMER, /*cyclone timer register*/
+#endif 
 #ifdef CONFIG_HIGHMEM
 	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
 	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,

