Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263584AbTLPGHJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 01:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263766AbTLPGHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 01:07:09 -0500
Received: from k-kdom.nishanet.com ([65.125.12.2]:3595 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S263584AbTLPGG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 01:06:58 -0500
Message-ID: <3FDEA10E.4030503@nishanet.com>
Date: Tue, 16 Dec 2003 01:07:10 -0500
From: Bob <recbo@nishanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Working nforce2, was Re: Fixes for nforce2 hard lockup, apic,
 io-apic, udma133 covered
References: <200312160030.30511.ross@datscreative.com.au> <1071500545.6680.15.camel@athlonxp.bradney.info> <200312160254.45150.ross@datscreative.com.au>
In-Reply-To: <200312160254.45150.ross@datscreative.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ross,

my_make_script nf2-800UL 2>&1 | tee /tmp/make.err

#/tmp/make.err
<snip>

  CC      arch/i386/kernel/apic.o
arch/i386/kernel/apic.c: In function `smp_apic_timer_interrupt':
arch/i386/kernel/apic.c:1105: warning: unsigned int format, long unsigned int arg (arg 2)


...which is around the printk line here--

                       printk("..APIC TIMER ack delay, reload:%u, safe:%u\n",

+                if(!passno) { /* calculate timing */
+                        safecnt = apic_read(APIC_TMICT) -
+                                ( (800UL * apic_read(APIC_TMICT) ) /
+                                (1000000000UL/HZ) );
+                        printk("..APIC TIMER ack delay, reload:%u, safe:%u\n",
+                                apic_read(APIC_TMICT), safecnt);
+                        passno++;


Here are the two patches with "#ifdef N" to "#if defined(N)" change
but not the unsigned int change --


diff -urN linux-2.6.0-test11/arch/i386/kernel/apic.c linux-2.6.0-test11-nf2/arch/i386/kernel/apic.c
--- linux-2.6.0-test11/arch/i386/kernel/apic.c	2003-11-26 15:46:07.000000000 -0500
+++ linux-2.6.0-test11-nf2/arch/i386/kernel/apic.c	2003-12-13 23:48:30.000000000 -0500
@@ -1089,6 +1089,37 @@
 	 */
 	irq_stat[cpu].apic_timer_irqs++;
 
+#if defined(CONFIG_MK7) && defined(CONFIG_BLK_DEV_AMD74XX)
+        /*
+         * on 2200XP & nforce2 chipset we need 600ns? 800? 1000? 1100?
+         * from timer irq start to apic irq ack to prevent
+         * hard lockups, use apic timer itself.
+         * C1 disconnect bit related.  Ross Dickson.
+         */
+        {
+                static unsigned int passno, safecnt;
+                if(!passno) { /* calculate timing */
+                        safecnt = apic_read(APIC_TMICT) -
+                                ( (800UL * apic_read(APIC_TMICT) ) /
+                                (1000000000UL/HZ) );
+                        printk("..APIC TIMER ack delay, reload:%u, safe:%u\n",
+                                apic_read(APIC_TMICT), safecnt);
+                        passno++;
+                }
+#if APIC_DEBUG
+                if(passno<12) {
+                        unsigned int at1 = apic_read(APIC_TMCCT);
+                        if( passno > 1 )
+                                Dprintk("..APIC TIMER ack delay, predelay count:%u \n", at1 );
+                        passno++;
+                }
+#endif
+                /* delay only if required */
+                while( apic_read(APIC_TMCCT) > safecnt )
+                        ndelay(100);
+        }
+#endif
+
 	/*
 	 * NOTE! We'd better ACK the irq immediately,
 	 * because timer handling can be slow.*/


diff -urN linux-2.6.0-test11/arch/i386/kernel/io_apic.c linux-2.6.0-test11-nf2/arch/i386/kernel/io_apic.c
--- linux-2.6.0-test11/arch/i386/kernel/io_apic.c	2003-11-26 15:43:32.000000000 -0500
+++ linux-2.6.0-test11-nf2/arch/i386/kernel/io_apic.c	2003-12-13 15:14:25.000000000 -0500
@@ -2128,6 +2128,54 @@
 		printk(KERN_ERR "..MP-BIOS bug: 8254 timer not connected to IO-APIC\n");
 	}
 
+#if defined (CONFIG_ACPI_BOOT) && (CONFIG_X86_UP_IOAPIC)
+        /* for nforce2 try vector 0 on pin0
+         * Note 8259a is already masked, also by default
+         * the io_apic_set_pci_routing call disables the 8259 irq 0
+         * so we must be connected directly to the 8254 timer if this works
+         * Note2: this violates the above comment re Subtle but works!
+         */
+        printk(KERN_INFO "..TIMER: Is timer irq0 connected to IOAPIC Pin0? ...\n");
+        if (pin1 != -1) {
+                extern spinlock_t i8259A_lock;
+                unsigned long flags;
+                int tok, saved_timer_ack = timer_ack;
+                /*
+                 * Ok, does IRQ0 through the IOAPIC work?
+                 */
+                io_apic_set_pci_routing ( 0, 0, 0, 0, 0); /* connect pin */
+                unmask_IO_APIC_irq(0);
+                timer_ack = 0;
+
+                /*
+
+
+
+                 * Ok, does IRQ0 through the IOAPIC work?
+                 */
+                spin_lock_irqsave(&i8259A_lock, flags);
+                Dprintk("..TIMER check 8259 ints disabled, imr1:%02x, imr2:%02x\n", inb(0x21), inb(0xA1));
+                tok = timer_irq_works();
+                spin_unlock_irqrestore(&i8259A_lock, flags);
+                if (tok) {
+                        if (nmi_watchdog == NMI_IO_APIC) {
+                                disable_8259A_irq(0);
+                                setup_nmi();
+                                enable_8259A_irq(0);
+                                check_nmi_watchdog();
+                        }
+                        printk(KERN_INFO "..TIMER: works OK on apic pin0 irq0\n" );
+                        return;
+                }
+                /* failed */
+                timer_ack = saved_timer_ack;
+                clear_IO_APIC_pin(0, 0);
+                io_apic_set_pci_routing ( 0, pin1, 0, 0, 0);
+                printk(KERN_ERR "..MP-BIOS bug: 8254 timer not connected to IO-APIC Pin 0\n");
+        }
+/* end new stuff for nforce2 */
+#endif
+
 	printk(KERN_INFO "...trying to set up timer (IRQ0) through the 8259A ... ");
 	if (pin2 != -1) {
 		printk("\n..... (found pin %d) ...", pin2);


