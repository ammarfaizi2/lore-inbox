Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265294AbTLMUZr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 15:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265292AbTLMUZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 15:25:47 -0500
Received: from mxsf23.cluster1.charter.net ([209.225.28.223]:15878 "EHLO
	mxsf23.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S265294AbTLMUZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 15:25:09 -0500
Date: Sat, 13 Dec 2003 15:22:29 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
Message-ID: <20031213202229.GA11299@forming>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200312140407.28580.ross@datscreative.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <200312140407.28580.ross@datscreative.com.au>
X-Editor: GNU Emacs 21.1
X-Operating-System: Debian GNU/Linux 2.6.0-test11-nf2v4 i686
X-Uptime: 14:06:02 up 2 days,  2:39,  5 users,  load average: 125.33, 31.45, 10.58
User-Agent: Mutt/1.5.4i
From: Josh McKinney <forming@charter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On approximately Sun, Dec 14, 2003 at 04:07:28AM +1000, Ross Dickson wrote:
> Greetings,
> I have updated the apic timer ack delay patch and the io-apic edge patch
> although I do not think anyone had any problems with the first release.
> 
<snip>
> 
> Thanks Jesse for rediffing the original patches for 2.6 would you like to repeat
> the favour with these please?
> 
> Again they are still experimental.... so I am hoping Ian, Jesse and others will
> put them to the test.
> 
> Thanks
> Ross Dickson.
> 

I am not Jesse but I thought I would diff them for 2.6 myself.  Thanks
Ross and others for putting so much time and effort into this.  I
haven't had time to test them, but I soon will.  Uptime is:  
 15:19:45 up 2 days,  3:53,  7 users,  load average: 0.05, 0.28, 0.37
with the original v1 patches.

Patches attached.

-- 
Josh McKinney		     |	Webmaster: http://joshandangie.org
--------------------------------------------------------------------------
                             | They that can give up essential liberty
Linux, the choice       -o)  | to obtain a little temporary safety deserve 
of the GNU generation    /\  | neither liberty or safety. 
                        _\_v |                          -Benjamin Franklin

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.6.0-test11-apic_delay_v2.patch"

diff -urN linux-2.6.0-test11/arch/i386/kernel/apic.c linux-2.6.0-test11-nf2/arch/i386/kernel/apic.c
--- linux-2.6.0-test11/arch/i386/kernel/apic.c	2003-11-26 15:46:07.000000000 -0500
+++ linux-2.6.0-test11-nf2/arch/i386/kernel/apic.c	2003-12-13 15:04:38.000000000 -0500
@@ -1089,6 +1089,32 @@
 	 */
 	irq_stat[cpu].apic_timer_irqs++;
 
+#ifdef CONFIG_MK7 && CONFIG_BLK_DEV_AMD74XX
+	/*
+	 * on 2200XP & nforce2 chipset we need 600ns?
+	 * from timer irq start to apic irq ack to prevent
+	 * hard lockups, use apic timer itself.
+	 * C1 disconnect bit related.  Ross Dickson.
+	 */
+	{
+	  static unsigned int passno, safecnt;
+	  if(!passno {/*calculate timing*/
+	    safecnt = apic_read(APIC_TMICT) -
+	      ( (600UL * apic_read(APIC_TMICT) ) /
+		(1000000000UL/HZ) );
+	    printk("..APIC TIMER ack delay, reload:%u, safe:%u\n",
+		   apic_read(APIC_TMICT), safecnt);
+	    passno++;
+	  }
+#if APIC_DEBUG
+	     if(passno<12) {
+	       unsigned int at1 = apic_read(APIC_TMCCT);
+	       if(passno>1)
+		 Dprintk("..APIC TIMER ack delay, predelay count: %u \n", at1 );
+	       passno++;
+	     }
+#endif
+
 	/*
 	 * NOTE! We'd better ACK the irq immediately,
 	 * because timer handling can be slow.

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.6.0-test11-ioapic_v2.patch"

diff -urN linux-2.6.0-test11/arch/i386/kernel/io_apic.c linux-2.6.0-test11-nf2/arch/i386/kernel/io_apic.c
--- linux-2.6.0-test11/arch/i386/kernel/io_apic.c	2003-11-26 15:43:32.000000000 -0500
+++ linux-2.6.0-test11-nf2/arch/i386/kernel/io_apic.c	2003-12-13 15:14:25.000000000 -0500
@@ -2128,6 +2128,54 @@
 		printk(KERN_ERR "..MP-BIOS bug: 8254 timer not connected to IO-APIC\n");
 	}
 
+#ifdef CONFIG_ACPI_BOOT && CONFIG_X86_UP_IOAPIC
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

--AhhlLboLdkugWU4S--
