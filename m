Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132720AbRC2MGE>; Thu, 29 Mar 2001 07:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132722AbRC2MFy>; Thu, 29 Mar 2001 07:05:54 -0500
Received: from tango.SoftHome.net ([204.144.231.49]:3813 "HELO
	tango.SoftHome.net") by vger.kernel.org with SMTP
	id <S132720AbRC2MFo>; Thu, 29 Mar 2001 07:05:44 -0500
Message-ID: <3AC324FA.7E7F6919@softhome.net>
Date: Thu, 29 Mar 2001 07:05:14 -0500
From: "Todd M. Roy" <toddroy@softhome.net>
Reply-To: toddroy@softhome.net
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Wayne Whitney <whitney@math.berkeley.edu>, linux-kernel@vger.kernel.org
Subject: re: 2.4.3-p8 pci_fixup_vt8363 + ASUS A7V "Optimal" = IDE disk corruption
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wayne,
  I have also been seeing disk corruption with my ASUS A7V with both
2.4.3-pre7 and pre8.

-- todd --

Hi,

I'm running kernel 2.4.3-pre8 on an ASUS A7V (BIOS 1007) motherboard and
recently noticed that it sometimes corrupts my hard disk, an IBM 75GXP
on
the onboard PDC20265 IDE controller.  The corruption is detectable with
a
simple 'dd if=/dev/urandom of=test bs=16384 count=32768; cp test test2 ;
diff test test2'.

I traced the problem to a combination of choosing "Optimal" for the
System
Permorfance Setting in the BIOS and the the new pci_fixup_vt8363 added
to
arch/i386/kernel/pci-pc.c in kernel 2.4.3-pre3.  So I did a bunch of
tests
using no pci_fixup function, the pci_fixup_vt8363 function, and the
following subset of pci_fixup_vt8363:

        pci_read_config_byte(d, 0x54, &tmp);
        if(tmp & (1<<2)) {
                printk("PCI: Bus master Pipeline request disabled\n");
                pci_write_config_byte(d, 0x54, tmp & ~(1<<2));
        }
        pci_read_config_byte(d, 0x70, &tmp);
        if(tmp & (1<<2)) {
                printk("PCI: Disabled Master Read Caching\n");
                pci_write_config_byte(d, 0x70, tmp & ~(1<<2));
        }

The results for me:
				Normal		Optimal
				------		-------
no pci_fixup			no corruption	no corruption
pci_fixup_vt8363 subset		corruption	corruption
pci_fixup_vt8363		no corruption	corruption

At this point my skills and perseverance gave out, but if someone would
like me to do a few more specific tests, I could.

Below is the output of 'lspci -xxx -s 0:0' on this hardware, with no
pci_fixup, for both the Normal and Optimal BIOS settings, in the form of
a
unified diff.  Hopefully this will shed some light on what the BIOS is
doing, as we don't see to have pci_fixup_vt8363 quite right yet.

Cheers,
Wayne


-- 
  .~.  Todd Roy, Senior Database Administrator  .~.
  /V\     Holstein Association, U.S.A. Inc.     /V\         
 // \\           troy@holstein.com             // \\  
/(   )\         1-802-254-4551x4230           /(   )\
 ^^-^^                                         ^^-^^
