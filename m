Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278177AbRKKQsk>; Sun, 11 Nov 2001 11:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278239AbRKKQsa>; Sun, 11 Nov 2001 11:48:30 -0500
Received: from adsl-209-76-109-63.dsl.snfc21.pacbell.net ([209.76.109.63]:14464
	"EHLO adsl-209-76-109-63.dsl.snfc21.pacbell.net") by vger.kernel.org
	with ESMTP id <S278177AbRKKQsN>; Sun, 11 Nov 2001 11:48:13 -0500
Date: Sun, 11 Nov 2001 08:47:48 -0800
From: Wayne Whitney <whitney@math.berkeley.edu>
Message-Id: <200111111647.fABGlml08049@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
To: "Calin A. Culianu" <calin@ajvar.org>
Cc: linux-kernel@vger.kernel.org, whitney@math.berkeley.edu
Subject: Re: Any lingering Athlon bugs in Kernel 2.4.14?
In-Reply-To: <Pine.LNX.4.30.0111110002590.22386-100000@rtlab.med.cornell.edu>
In-Reply-To: <E162YXo-0006P8-00@the-village.bc.nu> <Pine.LNX.4.30.0111110002590.22386-100000@rtlab.med.cornell.edu>
Reply-To: whitney@math.berkeley.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In mailing-lists.linux-kernel, you wrote:

> I suppose this question is stuff I can find elsewhere but: where do I find
> just that patch alone (so that I cen see about adapting it to my redhat
> kernel) 

The relevant function is from arch/i386/kernel/pci-pc.c:

static void __init pci_fixup_via_athlon_bug(struct pci_dev *d)
{
        u8 v;
        pci_read_config_byte(d, 0x55, &v);
        if (v & 0x80) {
                printk("Trying to stomp on Athlon bug...\n");
                v &= 0x7f; /* clear bit 55.7 */
                pci_write_config_byte(d, 0x55, v);
        }
}

Note also this line from struct pci_fixup pcibios_fixups[] in the same
file:

        { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_VIA,      PCI_DEVICE_ID_VIA_8363_0,       pci_fixup_via_athlon_bug },

I believe that all you have to do is add the above line to
pcibios_fixups[] and add the above function to pci-pc.c.

> and/or how do I do it from userspace ;) (i assume i just have to
> write to some registers or something using some user-space mechanism
> that i am unaware of???).

You can see what pci_fixup_via_athlon_bug does: it clears bit 7 of
register 0x55 of the PCI device VIA 8363.  On a machine that has a VIA
8363 (the northbridge), I believe it will be PCI ID 0:0.0 (0th bus,
0th device, 0th subdevice).  You can check this with 'lspci -n -s
0:0.0', it should say '00:00.0 Class 0600: 1106:0305' followed by a
revision (2 for the KT133, 3 for the KT133A)

Then as root, you do 'setpci -s 0:0.0 55' to query the register, do
the computation of clearing bit 7 of the result to get a value YY, and
do 'setpci -s 0:0.0 55=YY' to set the register.  Note that both 55 and
YY are in hexadecimal.

Cheers, Wayne

