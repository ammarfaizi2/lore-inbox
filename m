Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263400AbTLJDVp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 22:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263439AbTLJDVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 22:21:45 -0500
Received: from k-kdom.nishanet.com ([65.125.12.2]:39433 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S263400AbTLJDVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 22:21:40 -0500
Message-ID: <3FD695AA.7050508@nishanet.com>
Date: Tue, 09 Dec 2003 22:40:26 -0500
From: Bob <recbo@nishanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: NForce2: 2.6.0-test11-bk6 UP high interrupt error count  with
 lapic noapic
References: <OF4915FCD8.D666BBDD-ON80256DF7.0042F69B-80256DF7.004BFBE8@uk.neceur.com>
In-Reply-To: <OF4915FCD8.D666BBDD-ON80256DF7.0042F69B-80256DF7.004BFBE8@uk.neceur.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are typical nforce2 errors, along with lock-ups--

hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hdc: drive_cmd: error=0x04Aborted Command
hdd: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hdd: drive_cmd: error=0x04Aborted Command

spurious 8259A interrupt: IRQ7

The following in your log do NOT mean apic edge timer is on!---

Using local APIC timer interrupts.
calibrating APIC timer ...

...you can see apic edge timer is NOT on--PIC timer is on--

/proc/interrupts ****

           CPU0 
  0:    5846081          XT-PIC  timer

it can't be on because--

# CONFIG_ACPI is not set

turn on acpi and

turn on ioapic edge timer by patches--(from Jesse Allen, see
two patches appended below, he observes that he can now
use cpu disconnect and nmi_watchdog=1 instead of =2,
with these and not the first round, and I have to use =2
with the first round of patch, so I am going to these two)

-Bob D

ross.alexander@uk.neceur.com wrote:

>To all long suffering users,
>
>I have just compiled linux-2.6.0-test11-bk6 (this has the SMI correction). 
> This "seams" to
>fix the the locking problem but only time will tell for sure.  I have not 
>applied any of the
>APIC patches and I'm getting very high error counts (presumably because 
>the interval timers
>are playing up).  For example the IRQ0/LOC count is ~ 6M the ERR is ~ 1M. 
>Below is a dump
>of various details.  I can provide more if necessary.  I do have a couple 
>of questions about
>interval timers.
>
>1. It is necessary to have both the APIC timer and the 8254 timer running 
>simuntanously.
>2. Can the 8254 timer be disabled if the APIC timer is running.
>3. What stops each timer interrupting each other.
>
>Cheers,
>
>Ross
>

Hi Ross,

I have rediffed your two patches for vanilla 2.6.0-test11.  Briefly, I tried the apic patch first, and found that there are no lockups so far; well it passed my grep tests and even a kernel compile =).  Then I tried your io_apic patch + apic patch.  With nmi_watchdog=1 "NMI:" in /proc/interrupts increments alot compared to nmi_watchdog=2 before (as much as the timer).  So I believe your two patches are more correct than the other two.  Especially the fact I can run with CPU Disconnect and not lock up just like windows ... for people that have windows (I dont have windows =) plus a probably working nmi_watchdog.

And for comparison, my setup:
Shuttle AN35N Ultra v 1.1  (Nforce2 400 ultra), bios updated
Athlon Barton 2600+ (1.9 Ghz)
256 MB PC3200, single stick.

The patches are included in this mail.  I suppose the next thing to do is get out of nvidia the corresponding information.  And then clean up the patch for inclusion.

Jesse


--- linux/arch/i386/kernel/apic.c	2003-10-25 11:44:59.000000000 -0700
+++ linux-jla/arch/i386/kernel/apic.c	2003-12-09 19:07:19.000000000 -0700
@@ -1089,6 +1089,16 @@
 	 */
 	irq_stat[cpu].apic_timer_irqs++;
 
+#ifdef CONFIG_MK7 && CONFIG_BLK_DEV_AMD74XX
+
+	/*
+	 * on 2200XP & nforce2 chipset we need at least 500ns delay here
+	 * to stop lockups with udma100 drive. try to scale delay time
+	 * with cpu speed. Ross Dickson.
+	 */
+	ndelay((cpu_khz >> 12)+200 ); /* don't ack too soon or hard lockup */
+#endif
+
 	/*
 	 * NOTE! We'd better ACK the irq immediately,
 	 * because timer handling can be slow.

--- linux/arch/i386/kernel/io_apic.c	2003-10-25 11:43:20.000000000 -0700
+++ linux-jla/arch/i386/kernel/io_apic.c	2003-12-09 19:56:07.000000000 -0700
@@ -2128,6 +2128,41 @@
 		printk(KERN_ERR "..MP-BIOS bug: 8254 timer not connected to IO-APIC\n");
 	}
 
+#ifdef CONFIG_ACPI_BOOT && CONFIG_X86_UP_IOAPIC
+	/* for nforce2 try vector 0 on pin0
+	 * Note the io_apic_set_pci_routing call disables the 8259 irq 0
+	 * so we must be connected directly to the 8254 timer if this works
+	 * Note2: this violates the above comment re Subtle but works!
+	 */
+	printk(KERN_INFO "..TIMER: Is timer irq0 connected to IOAPIC Pin0? ...\n");
+	if ( pin1 != -1 && nr_ioapics ) {
+		int saved_timer_ack = timer_ack;
+		/* next call also disables 8259 irq0 */
+		int result = io_apic_set_pci_routing ( 0, 0, 0, 0, 0);
+		/*
+		 * Ok, does IRQ0 through the IOAPIC work?
+		 */
+		unmask_IO_APIC_irq(0);
+		timer_ack = 0 ;
+		if (timer_irq_works()) {
+			if (nmi_watchdog == NMI_IO_APIC) {
+				disable_8259A_irq(0);
+				setup_nmi();
+				enable_8259A_irq(0);
+				check_nmi_watchdog();
+			}
+			printk(KERN_INFO "..TIMER: works OK on apic pin0 irq0\n" );
+			return;
+		}
+		/* failed */
+		timer_ack = saved_timer_ack;
+		clear_IO_APIC_pin(0, 0);
+		result = io_apic_set_pci_routing ( 0, pin1, 0, 0, 0);
+		printk(KERN_ERR "..MP-BIOS bug: 8254 timer not connected to IO-APIC Pin 0\n");
+	}
+#endif
+/* end new stuff for nforce2 */
+
 	printk(KERN_INFO "...trying to set up timer (IRQ0) through the 8259A ... ");
 	if (pin2 != -1) {
 		printk("\n..... (found pin %d) ...", pin2);

