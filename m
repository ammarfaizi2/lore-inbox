Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318333AbSH1Aii>; Tue, 27 Aug 2002 20:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318334AbSH1Aii>; Tue, 27 Aug 2002 20:38:38 -0400
Received: from holomorphy.com ([66.224.33.161]:56487 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318333AbSH1Aih>;
	Tue, 27 Aug 2002 20:38:37 -0400
Date: Tue, 27 Aug 2002 17:40:40 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: kbd_bh() is entered during kbd_init()
Message-ID: <20020828004040.GA2516@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kbd_bh() is entered during kbd_init().

#0  kbd_bh (dummy=0) at /mnt/b/2.5.32/linux-2.5.32/include/asm/processor.h:477
#1  0xc011f609 in tasklet_action (a=0xc032fd80) at softirq.c:197
#2  0xc011f3b2 in do_softirq () at softirq.c:89
#3  0xc0111c43 in smp_apic_timer_interrupt (regs=
      {ebx = -1070383808, ecx = -1070479088, edx = -870318228, esi = -1070859956
, edi = 582, ebp = -870318188, eax = 1, xds = -870383512, xes = -1072627608, ori
g_eax = -17, eip = -1072564974, xcs = 96, eflags = 582, esp = -1070511136, xss =
 -1070144220}) at apic.c:1091
#4  0xc01082a6 in apic_timer_interrupt () at process.c:982
#5  0xc02dce32 in kbd_init ()
    at /mnt/b/2.5.32/linux-2.5.32/include/linux/interrupt.h:162
#6  0xc02dd185 in vty_init () at console.c:2527
#7  0xc02dc4a6 in tty_init () at tty_io.c:2315
#8  0xc02dc259 in chr_dev_init () at mem.c:671
#9  0xc02ce8e5 in do_initcalls () at main.c:491
#10 0xc02ce921 in do_basic_setup () at main.c:542
#11 0xc01050df in init (unused=0x0) at main.c:569

kbd_init() needs to disable interrupts.


Cheers,
Bill


--- linux-2.5.32-virgin/drivers/char/keyboard.c	2002-08-27 12:26:41.000000000 -0700
+++ linux-2.5.32/drivers/char/keyboard.c	2002-08-27 16:45:32.000000000 -0700
@@ -1169,6 +1169,9 @@
 int __init kbd_init(void)
 {
 	int i;
+	unsigned long flags;
+
+	local_irq_save(flags);
 
         kbd0.ledflagstate = kbd0.default_ledflagstate = KBD_DEFLEDS;
         kbd0.ledmode = LED_SHOW_FLAGS;
@@ -1183,5 +1186,7 @@
 	tasklet_enable(&keyboard_tasklet);
 	tasklet_schedule(&keyboard_tasklet);
 	input_register_handler(&kbd_handler);
+
+	local_irq_restore(flags);
 	return 0;
 }
