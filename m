Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130879AbQK2MYs>; Wed, 29 Nov 2000 07:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131092AbQK2MYi>; Wed, 29 Nov 2000 07:24:38 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:42728 "EHLO
        delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
        id <S130879AbQK2MYW>; Wed, 29 Nov 2000 07:24:22 -0500
Date: Wed, 29 Nov 2000 12:51:10 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Mr. Big" <mrbig@sneaker.sch.bme.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: crashing kernels
In-Reply-To: <Pine.LNX.3.96.1001128192620.1786A-100000@sneaker.sch.bme.hu>
Message-ID: <Pine.GSO.3.96.1001129121317.13815A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2000, Mr. Big wrote:

> Yes You are right. This Ether Express is integrated on the motherboard, so
> we couldn't get it out totally :( But there isn't any cable connected to
> it, we also doesn't have the driver in the kernel. This is the same with
> the USB too. Do You mind, that they could have some kind of conflict just
> on they own, without being really used?

 An unhandled device may keep it's IRQ line asserted.  It shouldn't but
experience shows that PIIX* USB host adapters tend to do so.  If the line
is shared with another device and the device's driver enables the IRQ in
the interrupt controller, the line will stay asserted all the time due to
the other device.  For APIC systems it will result in a heavy load of the
inter-APIC bus -- interrupt and end of interrupt (EOI) messages will be
sent over and over again.  The former ones are long (i.e. last for many
cycles) and incur a priority arbitration which involves all APICs in the
system.  Such a load leads to weird behaviour.

> Currently after changing the processors to Katmais, and disabling the
> apic, and some of the other unused peripheries, it seems, that the system
> is more stable. If the errors come again, I'll try to compile the USB
> driver also.

 You need not to -- the patch I gave you disables the USB interrupt within
the host adapter -- it is no longer asserted and thus it does not affect
the rest of the system.

 It is possible there are APIC errata we hit.  It would be interesting to
see a dump of APIC registers when the lockup conditions appear.  I suppose
you cannot debug your system as it's used in production, right?  Otherwise
I have a debugging patch that may be used to dump all APIC registers --
that would let me know if the interrupt is stuck in a local APIC or if
there is a sychronization problem, i.e. the local APIC considers the
interrupt finished while the origination I/O APIC does not (it must
receive an EOI message for the interrupt to be completely processed).

> Nope, specially we didn't get errors from the APIC himself. But both

 Good -- it means your inter-APIC bus is clean, so there is a little
chance for an undetected error to slip.  All APIC messages are checksummed
and simple errors get detected.  A severe corruption might not and it
happens for noisy buses. 

> network cards (except the EtherExpress) were saying errors considering to
> interrupts.
> 3Com:
> kernel: eth0: Interrupt posted but not delivered -- IRQ blocked by another
> device?
> kernel:   Flags; bus-master 1, full 0; dirty 112(0) current 112(0).
> kernel:   Transmit list 00000000 vs. f20ac200.
> kernel:   0: @f20ac200  length 80000036 status
> ...
> kernel:   15: @f20ac2f0  length 80000042 status
> kernel: eth0: Resetting the Tx ring pointer.

 I would need a dump of APIC registers.  Following is a patch (credit goes
to Andrew Morton for the idea and the original implementation) that adds a
SysRq feature, which allows you to dump APIC and PIC registers upon
hitting SysRq+A.  The patch requires a recent 2.4.0-test* (it should work
from about -test2 up -- you don't have to use -test11 exactly) kernel to
work.  If you were able to grab such a dump under the above conditions it
might help tracking the problem down. Please use `dmesg -s 32768' to grab
the log as most of messages go under the debug priority level and are
likely not to appear in the syslog). 

> Thanx for the USB patch, I'll try it also.

 If you do not use the Intel card (i.e. you do not share an unhandled IRQ
with an active device) you should not be affected by the problem it
addresses.  But you should check whether you really have no other device
with it's IRQ enabled but unhandled. 

 You appear to have the PIIX4 ISA bridge -- it contains an embedded ACPI
controller.  It has it's IRQ hardwired to 11.  Try to move device IRQs
away from it (by setting IRQ 11 to "ISA/Legacy" in BIOS).  While I've not
heard of ACPI IRQ problems so far, it does not mean they never happen.

 You might be able to check /proc/stat, possibly with the `procinfo'
program if there are no IRQs counters incrementing that are unhandled --
/proc/stat, as opposed to /proc/interrupts shows all IRQs -- the latter
displays only the ones with a driver. 

 Good luck,

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

diff -up --recursive --new-file linux-2.4.0-test11.macro/arch/i386/kernel/io_apic.c linux-2.4.0-test11/arch/i386/kernel/io_apic.c
--- linux-2.4.0-test11.macro/arch/i386/kernel/io_apic.c	Thu Oct  5 21:08:17 2000
+++ linux-2.4.0-test11/arch/i386/kernel/io_apic.c	Sun Nov 26 12:39:01 2000
@@ -692,7 +692,7 @@ void __init UNEXPECTED_IO_APIC(void)
 	printk(KERN_WARNING "          to linux-smp@vger.kernel.org\n");
 }
 
-void __init print_IO_APIC(void)
+void /*__init*/ print_IO_APIC(void)
 {
 	int apic, i;
 	struct IO_APIC_reg_00 reg_00;
diff -up --recursive --new-file linux-2.4.0-test11.macro/drivers/char/sysrq.c linux-2.4.0-test11/drivers/char/sysrq.c
--- linux-2.4.0-test11.macro/drivers/char/sysrq.c	Tue Nov 14 10:24:52 2000
+++ linux-2.4.0-test11/drivers/char/sysrq.c	Sun Nov 26 12:42:11 2000
@@ -72,6 +72,15 @@ void handle_sysrq(int key, struct pt_reg
 	console_loglevel = 7;
 	printk(KERN_INFO "SysRq: ");
 	switch (key) {
+	case 'a':
+		printk("\n");
+		printk("print_PIC()\n");
+		print_PIC();
+		printk("print_IO_APIC()\n");
+		print_IO_APIC();
+		printk("print_all_local_APICs()\n");
+		print_all_local_APICs();
+		break;
 	case 'r':					    /* R -- Reset raw mode */
 		if (kbd) {
 			kbd->kbdmode = VC_XLATE;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
