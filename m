Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280254AbRJaOta>; Wed, 31 Oct 2001 09:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280253AbRJaOtV>; Wed, 31 Oct 2001 09:49:21 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:1805 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S280254AbRJaOtI>; Wed, 31 Oct 2001 09:49:08 -0500
Date: Wed, 31 Oct 2001 08:49:40 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IO APIC (smp) / crashes ?
Message-ID: <20011031084940.C31431@asooo.flowerfire.com>
In-Reply-To: <20011030124037.A26140@grobbebol.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20011030124037.A26140@grobbebol.xs4all.nl>; from roel@grobbebol.xs4all.nl on Tue, Oct 30, 2001 at 12:40:37PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ah yes, I've seen this behavior since 2.4.0-test1 (didn't play with
2.3).  Assuming this is the problem I think it is...

The quick and conservative fix would be to reboot with "noapic" on the
kernel command line.  I would set this and see if the problem repeats
itself.

If not, then I would suggest applying the attached informal patch to
regain some performance over "noapic".  Specify "no8259A" instead of
"noapic".  It isolates the timer on the local APIC but allows the I/O
APIC to handle the rest.  And no, I'm not terribly familiar with the
APIC code.  Danger Will Robinson!  YMMV!  The patch might apply to most
2.4.x kernels, though I've only formalized the patch in my build system
since 2.4.13.

I've been using this patch in production for a bit, and it seems to
avoid the problem inobtrusively... without actually solving the problem
correctly. :(  The APIC code is daunting, not to mention that it
requires 12 hours or so of a particular type and weight of load to
trigger the issue, so debugging it with my lack of APIC-fu is a
frightening concept.

BTW, if anyone with more APIC-fu than I would perhaps know _why_ this
patch works around the issue that I think Roeland is explaining and the
issue I've mentioned here in the past, please holler.

Let me know how it goes,
-- 
Ken.
brownfld@irridia.com


--- linux/arch/i386/kernel/io_apic.c-DIST	Thu Oct  4 18:42:54 2001
+++ linux/arch/i386/kernel/io_apic.c	Mon Oct 29 13:52:00 2001
@@ -172,6 +172,7 @@
 int pirq_entries [MAX_PIRQS];
 int pirqs_enabled;
 int skip_ioapic_setup;
+int skip_8259A_setup;
 
 static int __init ioapic_setup(char *str)
 {
@@ -179,7 +180,14 @@
 	return 1;
 }
 
+static int __init i8259A_setup(char *str)
+{
+	skip_8259A_setup = 1;
+	return 1;
+}
+
 __setup("noapic", ioapic_setup);
+__setup("no8259A", i8259A_setup);
 
 static int __init ioapic_pirq_setup(char *str)
 {
@@ -1520,27 +1528,29 @@
 		printk(KERN_ERR "..MP-BIOS bug: 8254 timer not connected to IO-APIC\n");
 	}
 
-	printk(KERN_INFO "...trying to set up timer (IRQ0) through the 8259A ... ");
-	if (pin2 != -1) {
-		printk("\n..... (found pin %d) ...", pin2);
-		/*
-		 * legacy devices should be connected to IO APIC #0
-		 */
-		setup_ExtINT_IRQ0_pin(pin2, vector);
-		if (timer_irq_works()) {
-			printk("works.\n");
-			if (nmi_watchdog == NMI_IO_APIC) {
-				setup_nmi();
-				check_nmi_watchdog();
+	if ( !skip_8259A_setup ) {
+		printk(KERN_INFO "...trying to set up timer (IRQ0) through the 8259A ... ");
+		if (pin2 != -1) {
+			printk("\n..... (found pin %d) ...", pin2);
+			/*
+			 * legacy devices should be connected to IO APIC #0
+			 */
+			setup_ExtINT_IRQ0_pin(pin2, vector);
+			if (timer_irq_works()) {
+				printk("works.\n");
+				if (nmi_watchdog == NMI_IO_APIC) {
+					setup_nmi();
+					check_nmi_watchdog();
+				}
+				return;
 			}
-			return;
+			/*
+			 * Cleanup, just in case ...
+			 */
+			clear_IO_APIC_pin(0, pin2);
 		}
-		/*
-		 * Cleanup, just in case ...
-		 */
-		clear_IO_APIC_pin(0, pin2);
+		printk(" failed.\n");
 	}
-	printk(" failed.\n");
 
 	if (nmi_watchdog) {
 		printk(KERN_WARNING "timer doesnt work through the IO-APIC - disabling NMI Watchdog!\n");


On Tue, Oct 30, 2001 at 12:40:37PM +0000, Roeland Th. Jansen wrote:
| using 2.4.13 I still experience crashes when a very specific set of
| programs are used.
| 
| as I have a Abit BP6 and it's known to be not the best SMP board, I was
| wondering if it could be possible that a high rate of interrupts
| (specific IRQ's) could cause the 'crashes' I experience.
| 
| The setup is really weird. I use freeamp to play streams; I have an
| ethernet card connected to a 512kbits adsl router; I use an SB16 under
| opensound.com and use X with an AGP card.
| 
| if the stuff 'crashes, it in fact doesn't crash but starts to become
| _very_ slow. if you look at /proc/interrupts you would see timer ticks
| increase one by one but it woud take ages. like one tich in hald an hour
| or so. this basically means -- system unuseable. it does respond to
| pings though.
| 
| my wild guess is that the combination and rate of interrupts cause the
| well known 
| 
| Oct 30 07:29:37 grobbebol kernel: APIC error on CPU1: 02(08)
| Oct 30 07:29:37 grobbebol kernel: APIC error on CPU0: 02(04)
| Oct 30 08:30:43 grobbebol kernel: APIC error on CPU0: 04(04)
| Oct 30 08:30:43 grobbebol kernel: APIC error on CPU1: 08(08)
| [....]
| 
| entries that finally after some time hit a combination that causes the
| system to become very slow. would that be a possibility or am I just (as
| usual :-) wrong ?
| 
| 
|            CPU0       CPU1
|   0:   13213246   13178957    IO-APIC-edge  timer
|   1:      60279      59829    IO-APIC-edge  keyboard
|   2:          0          0          XT-PIC  cascade
|   3:      44383      44113    IO-APIC-edge  serial
|   4:          3          5    IO-APIC-edge  serial
|   5:      75105      73827    IO-APIC-edge  soundblaster
|   8:          0          1    IO-APIC-edge  rtc
|  14:     218635     212466    IO-APIC-edge  ide0
|  15:       6903       6858    IO-APIC-edge  ide1
|  18:      30878      30618   IO-APIC-level  BusLogic BT-930
|  19:    5695922    5718641   IO-APIC-level  eth0
| NMI:          0          0
| LOC:   26392880   26392845
| ERR:         82
| MIS:         70
| 
| 
| anyways, it basically only happens when I use X, when I use sound, when
| I use xmms _and_ it comes from eth0. it happens not directly but
| sometimes, after, say an hour, sometimes after 4 hours.
| 
| (fwiw -- it also happens under the opensound drivers in the kernel but
| less frequent)
| 
| -- 
| Grobbebol's Home                      |  Don't give in to spammers.   -o)
| http://www.xs4all.nl/~bengel          | Use your real e-mail address   /\
| Linux 2.4.13 (apic) SMP 466MHz/768 MB |        on Usenet.             _\_v  
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
