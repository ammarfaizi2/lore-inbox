Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264313AbTLVEiG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 23:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264318AbTLVEh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 23:37:58 -0500
Received: from xavier.comcen.com.au ([203.23.236.73]:57864 "EHLO
	xavier.etalk.net.au") by vger.kernel.org with ESMTP id S264313AbTLVEhp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 23:37:45 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: linux-kernel@vger.kernel.org
Subject: Updated Lockup Patches, 2.4.22 - 23 Nforce2, apic timer ack delay, ioapic edge for NMI debug
Date: Mon, 22 Dec 2003 14:37:11 +1000
User-Agent: KMail/1.5.1
Cc: Ian Kumlien <pomac@vapor.com>, kernel@kolivas.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_3Tn5/AeiQ/p0q5f"
Message-Id: <200312221437.11514.ross@datscreative.com.au>
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_3Tn5/AeiQ/p0q5f
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Here are my patches reworked for 2.4.22.
They should patch on 2.4.23 but differ in line numbers.

I use them on my patched 2.4.23 kern.

Details are in following lkml thread, please refer to it prior to usage.

Updated Lockup Patches, 2.6.0 Nforce2, apic timer ack delay, ioapic edge for NMI debug

If not subscribed it can be found in many archives
such as
http://linux.derkeiler.com/Mailing-Lists/Kernel/2003-12/4525.html
or here
http://lkml.org/lkml/2003/12/21/7

Regards,
Ross Dickson

local apic timer ack delay:
--- CUT HERE ---
--- linux-2.4.22/arch/i386/kernel/apic.c	2003-06-14 00:51:29.000000000 +1000
+++ linux-2.4.22-rd/arch/i386/kernel/apic.c	2003-12-22 13:18:08.000000000 +1000
@@ -1058,10 +1058,17 @@ inline void smp_local_timer_interrupt(st
 	 * we can take more than 100K local irqs per second on a 100 MHz P5.
 	 */
 }
 
 /*
+ * Athlon nforce2 R.D.
+ * preset timer ack mode if desired
+ * e.g. static int apic_timerack = 2;
+*/
+static int apic_timerack;
+
+/*
  * Local APIC timer interrupt. This is the most natural way for doing
  * local interrupts, but local timer interrupts can be emulated by
  * broadcast interrupts too. [in case the hw doesn't support APIC timers]
  *
  * [ if a single-CPU system runs an SMP kernel then we call the local
@@ -1077,10 +1084,54 @@ void smp_apic_timer_interrupt(struct pt_
 	 * the NMI deadlock-detector uses this.
 	 */
 	apic_timer_irqs[cpu]++;
 
 	/*
+	* Athlon nforce2 timer ack delay.  Ross Dickson.
+	* works around issue of hard lockups in code location
+	* where linux exposes underlying system timing fault?
+	* hopefully manufacturers will fix it soon.
+	* We leave C1 disconnect bit alone as bios/SMM wants?
+	*/
+	if(apic_timerack) {
+		if(apic_timerack==1) {
+			/* v1 timer ack delay, inline delay version
+	 		* on AMDXP & nforce2 chipset we use at least 500ns
+			* try to scale delay time with cpu speed.
+			* safe all cpu cores?
+	 		*/
+			ndelay((cpu_khz >> 12)+200); /* don't ack too soon or hard lockup */
+		} else {
+			static unsigned int passno, safecnt;
+			/* v2 timer ack delay, timeout version, more efficient
+	 		* on AMDXP & nforce2 chipset we need 800ns?
+	 		* from timer irq start to apic irq ack, read apic timer,
+			* may be unsafe for thoroughbred cores?
+	 		*/
+			if(!passno) { /* calculate timing */
+				safecnt = apic_read(APIC_TMICT) -
+					( (800UL * apic_read(APIC_TMICT) ) /
+					(1000000000UL/HZ) );
+				printk("..APIC TIMER ack delay, reload:%lu, safe:%u\n",
+					apic_read(APIC_TMICT), safecnt);
+				passno++;
+			}
+#if APIC_DEBUG
+			if(passno<12) {
+				unsigned int at1 = apic_read(APIC_TMCCT);
+				if( passno > 1 )
+					Dprintk("..APIC TIMER ack delay, predelay count:%u \n", at1 );
+				passno++;
+			}
+# endif
+			/* delay only if required */
+			while( apic_read(APIC_TMCCT) > safecnt )
+				ndelay(100);
+		}
+	}
+
+	/*
 	 * NOTE! We'd better ACK the irq immediately,
 	 * because timer handling can be slow.
 	 */
 	ack_APIC_irq();
 	/*
@@ -1145,10 +1196,28 @@ asmlinkage void smp_error_interrupt(void
 	printk (KERN_ERR "APIC error on CPU%d: %02lx(%02lx)\n",
 	        smp_processor_id(), v , v1);
 }
 
 /*
+* Athlon nforce2 timer ack delay. R.D.
+* kernel arg apic_tack=[012]
+* 0 off, 1 always delay, 2 timeout
+*/
+static int __init setup_apic_timerack(char *str)
+{
+	int tack;
+
+	get_option(&str, &tack);
+
+	if ( tack < 0 || tack > 2 )
+		return 0;
+	apic_timerack = tack;
+	return 1;
+}
+__setup("apic_tack=", setup_apic_timerack);
+
+/*
  * This initializes the IO-APIC and APIC hardware if this is
  * a UP kernel.
  */
 int __init APIC_init_uniprocessor (void)
 {
--- CUT HERE ---

io-apic edge:
--- CUT HERE ---
--- linux-2.4.22/arch/i386/kernel/io_apic.c	2003-08-25 21:44:39.000000000 +1000
+++ linux-2.4.22-rd/arch/i386/kernel/io_apic.c	2003-12-22 13:31:32.000000000 +1000
@@ -1612,12 +1612,56 @@ static inline void check_timer(void)
 				check_nmi_watchdog();
 			}
 			return;
 		}
 		clear_IO_APIC_pin(0, pin1);
-		printk(KERN_ERR "..MP-BIOS bug: 8254 timer not connected to IO-APIC\n");
+		printk(KERN_ERR "..MP-BIOS bug: 8254 timer not connected to IO-APIC INTIN%d\n",pin1);
+	}
+
+#if defined(CONFIG_ACPI_BOOT) && defined(CONFIG_X86_UP_IOAPIC)
+	/* for nforce2 try vector 0 on pin0
+	 * Note 8259a is already masked, also by default
+	 * the io_apic_set_pci_routing call disables the 8259 irq 0
+	 * so we must be connected directly to the 8254 timer if this works
+	 * Note2: this violates the above comment re Subtle but works!
+	 */
+	printk(KERN_INFO "..TIMER: Is timer irq0 connected to IO-APIC INTIN0? ...\n");
+	if (pin1 != -1) {
+		extern spinlock_t i8259A_lock;
+		unsigned long flags;
+		int tok, saved_timer_ack = timer_ack;
+		/*
+		 * Ok, does IRQ0 through the IOAPIC work?
+		 */
+		io_apic_set_pci_routing ( 0, 0, 0, 0, 0); /* connect pin */
+		unmask_IO_APIC_irq(0);
+		timer_ack = 0;
+
+		/*
+		 * Ok, does IRQ0 through the IOAPIC work?
+		 */
+		spin_lock_irqsave(&i8259A_lock, flags);
+		Dprintk("..TIMER 8259A ints disabled?, imr1:%02x, imr2:%02x\n", inb(0x21), inb(0xA1));
+		tok = timer_irq_works();
+		spin_unlock_irqrestore(&i8259A_lock, flags);
+		if (tok) {
+			if (nmi_watchdog == NMI_IO_APIC) {
+				disable_8259A_irq(0);
+				setup_nmi();
+				enable_8259A_irq(0);
+				check_nmi_watchdog();
+			}
+			printk(KERN_INFO "..TIMER: works OK on IO-APIC INTIN0 irq0\n" );
+			return;
+		}
+		/* failed */
+		timer_ack = saved_timer_ack;
+		clear_IO_APIC_pin(0, 0);
+		io_apic_set_pci_routing ( 0, pin1, 0, 0, 0);
+		printk(KERN_ERR "..MP-BIOS: 8254 timer not connected to IO-APIC INTIN0\n");
 	}
+#endif
 
 	printk(KERN_INFO "...trying to set up timer (IRQ0) through the 8259A ... ");
 	if (pin2 != -1) {
 		printk("\n..... (found pin %d) ...", pin2);
 		/*
--- CUT HERE ---

--Boundary-00=_3Tn5/AeiQ/p0q5f
Content-Type: application/x-tbz;
  name="nforce2-rd-v3-2.4.22-patches.tar.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="nforce2-rd-v3-2.4.22-patches.tar.bz2"

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
55vlgct97uCIGHhED/xdyRThQkAiLzwA

--Boundary-00=_3Tn5/AeiQ/p0q5f--

