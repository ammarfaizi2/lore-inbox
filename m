Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263244AbTKWDjW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 22:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263258AbTKWDjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 22:39:21 -0500
Received: from zero.aec.at ([193.170.194.10]:37646 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263244AbTKWDjU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 22:39:20 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: md@Linux.IT, linux-kernel@vger.kernel.org
Subject: Re: irq 15: nobody cared! with KT600 chipset and 2.6.0-test9
From: Andi Kleen <ak@muc.de>
Date: Sun, 23 Nov 2003 04:39:08 +0100
In-Reply-To: <UReK.uF.5@gated-at.bofh.it> (Linus Torvalds's message of "Sun,
 23 Nov 2003 02:30:14 +0100")
Message-ID: <m3vfpbiwir.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <UPPL.70W.11@gated-at.bofh.it> <UReK.uF.5@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Sun, 23 Nov 2003, Marco d'Itri wrote:
>>
>> This is an ASUS A7V600 motherboard, and the second IDE channel does not
>> work at all. I verified that it works fine with a 2.4.x kernel.
>
> Can you enable DEBUG in "arch/i386/pci/pci.h" and ACPI debugging and then
> report what the system says at bootup both with ACPI enabled, and with 
> "pci=noacpi".
>
> For some reason the system decides that your IDE controller is on irq3,
> which is clearly wrong. It's on irq15, but somebody told the PCI layer
> otherwise.

It's a long standing bug in how we handle VIA on board devices in ACPI.
It was a big problem on x86-64 too until I cheated and used only
PIC mode when there is a VIA southbridge.

Basically VIA has very specific rules on what interrupts can be assigned
to the onboard devices and they use an unusual ACPI construct for that

See http://bugme.osdl.org/show_bug.cgi?id=1530 for some more details.
(the same problem applies to 2.6 afaik) 

Here's also some older description from VIA about the issues I saved:

>>
   1) The _SRS method can only cope with IRQs <= 15 if SB is before VT8233.
            After VT8235, _SRS method need not report IRQ for internal devices due to they are
+hardwired to fixed IRQ in APIC mode.

[AK: that is one problem with the ACPI code - it doesn't handle that the 
_SRS report doesn't report it. Even ignoring the problems with
older SBs which would need some special handling code]


           The BIOS returns fixed IRQs in the _PRS method when system is in APIC mode if SB is after
+VT8235.
           (IDE-IRQ20, USB-IRQ21, Audio and Modem-IRQ22, LAN-IRQ23)

        2) The _CRS method is hardcoded to return 0 ALWAYS for link devices in APIC mode.
            We feel strange for this situation. This control method will check internal device's
+interrupt line (Rx3C of PCI configuration) to return current IRQ setting.
            Will it be possible in Linux kernel driver which will reset the Rx3C to zero ?
<<

Forcing PIC mode will at least make it work. Of course it would be 
better to fix the ACPI code to handle all this properly.

-Andi
