Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129312AbQJ3KPB>; Mon, 30 Oct 2000 05:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129288AbQJ3KOv>; Mon, 30 Oct 2000 05:14:51 -0500
Received: from [209.249.10.20] ([209.249.10.20]:15049 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S129138AbQJ3KOm>; Mon, 30 Oct 2000 05:14:42 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 30 Oct 2000 02:14:32 -0800
Message-Id: <200010301014.CAA05591@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Questions on lack of piix4 usb interrupts
Cc: mj@suse.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I am trying to determine how I should try to fix the
problem of my notebook computer not receiving USB interrupts.
I seem to have gotten it to sort of work by kludging to the USB UHCI
driver's millisecond timer routine to also invoke the interrupt
handler, but I hope I do not have to resort to this as a final
patch.

	Searching the net, I get the impression that most notebook
computers do not have this problem, but that I am not alone in it.  For
example, blaknite@datawest.net seems to have described the same
problem at http://www.mobilx.org/usb_linux.html for his ProStar 1200
notebok computer.  I think the problem may be a fairly deep IRQ assignment
problem which may effect other functionality.  So, resolving this problem
may help Linux run better on more than just my Kapok 1100M notebook
computer.

	Anyhow, if nobody wants to take a crack at the questions,
at least this message will archive them on deja.com so anyone who comes
across the same problem will be able to contact me for status.

	My questions are as follows:

	1. [Mostly to linux-usb-devel:] The Intel PIIX3 and PIIX4
specifications, in the section that talks about the LEGSUP
("legacy support"?) PCI configuration register for the uhci usb
controller built into the piix3 and piix4 chips, seem to suggest that
there are some UHCI controllers that do not generate interrupts
(I guess that's why the LEGSUP register provides a bit for masking
disabling the USB interrupts).  Therefore, do we need to have support
in the uhci drivers for not receiving interrupts anyhow?

	2. [Mostly to mj and linux-kernel:] In
linux-2.4.0-test9/drivers/pci/quirks.c, the comments in routine
quirk_piix3usb seem to describe a scenario very similar to the one
I am experiencing with piix4:

 * PIIX3 USB: We have to disable USB interrupts that are
 * hardwired to PIRQD# and may be shared with an
 * external device.

	The piix4 documentation says that the USB interrupt connects
only to PCI interrupt pin D of the piix4 device.  On my computer, I
examined the PCI interrupt routing table (this is built into the
computer, not a native kernel data structure), and discovered that 
the piix4's pin D is only connectable to IRQ 10, which is shared
with the i82365 PCMCIA controller, and sometimes the computer's
ethernet CardBus card.  This sounds just like the scenario described
for quirk_piix3usb.

	Causing the piix3 fixup to execute on my piix4 system
(the effected bits are in the same location on the piix3 and piix4)
had no visible effect, and I also verified that USB interrupts are
turned on in the LEGSUP register.

	My question is: could I get a slightly more detailed
explanation of what exactly the quirk_piix3usb routine was
trying to fix so I can better understand if I am bumping into
the same problem?  Do I understand correctly that the piix3 fixup
makes the current uhci drivers unusable on the effected hardware?

	3. [Mostly to linux-kernel]: I think the code in
arch/i386/pci-irq.c will sometimes not check the PCI Interrupt Routing
Table to see if it can assign a particular PCI interrupt pin to a
particular IRQ.  Although assigning my notebook's USB interrupts to
IRQ 10 is allowed by my computer's PCI interrupt routing table
(in fact, it's the only legal assignment according to it), a number
of other PCI interrupt pins appear not to have IRQ 10 available in the
PCI Interrupt Routing Table, and yet seem also to have been assigned to
IRQ 10 by the kernel.  Am I barking up the wrong tree to think
that the bug probably is here, somewhere in the IRQ configuration
and that my hardware probably really is cabable of generating USB
interrupts?

	Note that I am sending this to both linux-kernel and usb-devel.
Unless your response is about both USB and IRQ routing, you probably
want to trim your response list.

	Any help in answering these questions will make it a lot
more likely that I will be able to generate a higher quality a patch
sooner to fix this problem.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
