Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265105AbTFWInM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 04:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265177AbTFWInM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 04:43:12 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:48907 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S265105AbTFWInE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 04:43:04 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: linux-kernel@vger.kernel.org
Subject: RFC, PATCH: Move HZ timer init infront of sti()
Date: Mon, 23 Jun 2003 16:54:30 +0800
User-Agent: KMail/1.5.2
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200306231646.24288.mflt1@micrologica.com.hk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have done 1000s of reboots for testing of swsusp and 
encountered spurious interrupt 15 every few 100 boots.

On a particular buggy/faulty SIS P4, board this leads to
a hang during calibrating delay loop - see end of msg.

The fundamental cause of these spurious interrupts is that the 
timer is started well ahead of the interrupt enable by sti(), 
leading it to wrap around and causing the spurious IRQ. 
This applies in both 2.4 and 2.5.

This problem is more obvious recently with HZ of 1000
as the CPU has only 500us now to serve the timer IRQ. 

Current code follows.

asmlinkage void __init start_kernel(void)
{

[snip]


	init_IRQ();         <-------------- start timer
	sched_init();
	softirq_init();
	time_init();

	/*
	 * HACK ALERT! This is early. We're enabling the console before
	 * we've done PCI setups etc, and console_init() must be aware of
	 * this. But we do want output early, in case something goes wrong.
	 */
	console_init();
#ifdef CONFIG_MODULES
	init_modules();
#endif
	if (prof_shift) {
		unsigned int size;
		/* only text is profiled */
		prof_len = (unsigned long) &_etext - (unsigned long) &_stext;
		prof_len >>= prof_shift;
		
		size = prof_len * sizeof(unsigned int) + PAGE_SIZE-1;
		prof_buffer = (unsigned int *) alloc_bootmem(size);
	}

	kmem_cache_init();
	sti();		    <-------------- sti
	calibrate_delay();  


The patch below against 2.4.21 cleans this up by starting the timer
just ahaead of the sti.

--- arch/i386/kernel/i8259.c.orig       2003-06-23 16:08:49.000000000 +0800
+++ arch/i386/kernel/i8259.c    2003-06-23 16:12:55.000000000 +0800
@@ -489,14 +489,6 @@
        set_intr_gate(ERROR_APIC_VECTOR, error_interrupt);
 #endif

-       /*
-        * Set the clock to HZ Hz, we already have a valid
-        * vector now:
-        */
-       outb_p(0x34,0x43);              /* binary, mode 2, LSB/MSB, ch 0 */
-       outb_p(LATCH & 0xff , 0x40);    /* LSB */
-       outb(LATCH >> 8 , 0x40);        /* MSB */
-
 #ifndef CONFIG_VISWS
        setup_irq(2, &irq2);
 #endif
@@ -508,3 +500,14 @@
        if (boot_cpu_data.hard_math && !cpu_has_fpu)
                setup_irq(13, &irq13);
 }
+
+void __init init_hertz(void)
+{
+       /*
+        * Set the clock to HZ Hz, we already have a valid
+        * vector now:
+        */
+       outb_p(0x34,0x43);              /* binary, mode 2, LSB/MSB, ch 0 */
+       outb_p(LATCH & 0xff , 0x40);    /* LSB */
+       outb(LATCH >> 8 , 0x40);        /* MSB */
+}

--- init/main.c.orig    2003-06-23 16:07:55.000000000 +0800
+++ init/main.c 2003-06-23 16:20:39.000000000 +0800
@@ -89,6 +89,7 @@

 static int init(void *);

+extern void init_hertz(void);
 extern void init_IRQ(void);
 extern void init_modules(void);
 extern void sock_init(void);
@@ -389,6 +390,7 @@
        }

        kmem_cache_init();
+       init_hertz();
        sti();
        calibrate_delay();
 #ifdef CONFIG_BLK_DEV_INITRD


----------------------------------
On this mainboard, the chipset seems to set the 8259A timer 
IRQ ISR albeit not sending a timer vector, leading to timer 
IRQs being blocked. 

00:00.0 Host bridge: Silicon Integrated Systems [SiS] SiS651 Host (rev 02)
00:01.0 PCI bridge: Silicon Integrated Systems [SiS] SiS 530 Virtual PCI-to-PCI bridge (AGP)
00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev 25)
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE]
00:03.0 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB Controller (rev 0f)
00:03.1 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB Controller (rev 0f)
00:03.3 USB Controller: Silicon Integrated Systems [SiS] SiS7002 USB 2.0
00:0f.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] SiS650/651/M650/740 PCI/AGP VGA Display Adapter

Regards
Michael

-- 
Powered by linux-2.5.72-mm2, compiled with gcc-2.95-3 because it's rock solid

My current linux related activities in rough order of priority:
- Testing of Swsusp for 2.4
- Learning 2.5 kernel debugging with kgdb - it's in the -mm tree
- Studying 2.5 serial and ide drivers, ACPI, S3

The 2.5 kernel could use your usage. More info on setting it up at
http://www.codemonkey.org.uk/post-halloween-2.5.txt

