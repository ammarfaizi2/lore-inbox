Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265536AbUALRgI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 12:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265579AbUALRgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 12:36:08 -0500
Received: from fed1mtao03.cox.net ([68.6.19.242]:23183 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP id S265536AbUALRgB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 12:36:01 -0500
Date: Mon, 12 Jan 2004 10:35:54 -0700
From: Jesse Allen <the3dfxdude@hotmail.com>
To: ross@datscreative.com.au
Cc: linux-kernel@vger.kernel.org
Subject: NForce2, Ross Dickson's timer patch on 2.6.1
Message-ID: <20040112173554.GA792@tesore.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ross,

I have a version of your timer patch (io_apic.c) for kernel 2.6.1.  It is 
attached.  I have been monitoring a problem with it.  It seems that with the 
patch, I gain 1 seconds time over 10 minutes (roughly).  So I gain about 2-3 
mintues a day.  I haven't taken exact measurements, but I know it ends up about 
20 minutes difference after a week.  This is not good, which would require 
resetting the time often.  

I tried the 2.6.1 kernel without the timer patch.  The timer is now back in PIC 
mode, and interrupt 7 has the old noise.  Synched the time with my watch.  At 
first, I noticed no gain in time over 10 minutes.  However the next day, I found
it gained 1-2 seconds.  Now it is about 7 seconds ahead a few days later now.  
This is much better.

So I'm left to thinking, the patch does two things, maybe one thing right, and 
one possibly very wrong:

1) It does place the timer in APIC mode.
2) But the timer seems to be fed extra interrupts, maybe the same that is found 
on irq 7 without the patch (is this possible?)

I remember someone making a comment which might explain the issue:
http://marc.theaimsgroup.com/?l=linux-kernel&m=107098440019588&w=2

I don't think the patch was much different now than it was then.  So I think 
there is something wrong with setting up the timer this way.  I don't know if 
you worked something out with Maciej.  I don't know much about interrupt 
controller programming so...  if maybe you can explain to me anything I'm
missing.  For now I've dropped the patch.


Jesse


PS:  I have run with disconnect on, and without your ack patch since I got that 
surpise BIOS update.  No lockups have occurred in the past month, since that.  So the disconnect problem is a BIOS bug.  (Shuttle has not responded)

PSS:  CC me, I'm not subscribed right now.

--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="nforce2-timer-rd-2.6.1.patch"

--- linux/arch/i386/kernel/io_apic.c	2003-12-31 10:23:58.000000000 -0700
+++ linux-new/arch/i386/kernel/io_apic.c	2004-01-10 11:46:23.000000000 -0700
@@ -2194,9 +2194,53 @@
 			return;
 		}
 		clear_IO_APIC_pin(0, pin1);
-		printk(KERN_ERR "..MP-BIOS bug: 8254 timer not connected to IO-APIC\n");
+		printk(KERN_ERR "..MP-BIOS bug: 8254 timer not connected to IO-APIC INTIN%d\n",pin1);
 	}
 
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
+	}
+#endif
+
 	printk(KERN_INFO "...trying to set up timer (IRQ0) through the 8259A ... ");
 	if (pin2 != -1) {
 		printk("\n..... (found pin %d) ...", pin2);

--UlVJffcvxoiEqYs2--
