Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132803AbRC2SKo>; Thu, 29 Mar 2001 13:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132806AbRC2SKe>; Thu, 29 Mar 2001 13:10:34 -0500
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:27525 "EHLO
	shimura.math.berkeley.edu") by vger.kernel.org with ESMTP
	id <S132803AbRC2SKW>; Thu, 29 Mar 2001 13:10:22 -0500
Date: Thu, 29 Mar 2001 10:09:32 -0800 (PST)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: <whitney@math.berkeley.edu>
To: LKML <linux-kernel@vger.kernel.org>
cc: <toddroy@softhome.net>, Juan Quintela <quintela@mandrakesoft.com>
Subject: Re: 2.4.3-p8 pci_fixup_vt8363 + ASUS A7V "Optimal" = IDE disk
 corruption
In-Reply-To: <m2puf0hft9.fsf@trasno.mitica>
Message-ID: <Pine.LNX.4.30.0103290931330.12531-100000@mf1.private>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Mar 2001, Juan Quintela wrote:

> Hi I have the same motherboard and BIOS version.  I was having
> filesystem corruption.  There is a bugfix (from Arjan van der Ven) in
> the ac tree (around ac20 I think), could you test the last ac patch
> and test if the filesystem corruption persist??

I took a look at 2.4.2-ac28; rather than test the kernel itself, I used
setpci to duplicate what the fixup function does.  The upshot is that
2.4.2-ac28 does not cause any corruption with the ASUS A7V 1007 "Optimal".
Its pci_fixup_vt8363 function has a subset of the tests from 2.4.3-pre8,
namely it omits:

	pci_read_config_byte(d, 0x54, &tmp);
	if(tmp & (1)) {
		printk("PCI: Fast Write to Read turnaround disabled\n");
		pci_write_config_byte(d, 0x54, tmp & ~(1));
	}
	pci_read_config_byte(d, 0x70, &tmp);
	if(tmp & (1<<2)) {
		printk("PCI: Disabled Master Read Caching\n");
		pci_write_config_byte(d, 0x70, tmp & ~(1<<2));
	}

This second test was part of the 2.4.3-pre8 pci_fixup_vt8363 subset from
my previous email which causes corruption on the ASUS A7V 1007 for both
Optimal and Normal settings.  I verified that if I add it back in, I do
get corruption with ASUS A7V 1007 "Optimal".  By omitting it, I guess
2.4.2-ac28 avoids the corruption of 2.4.3-pre8.

Perhaps 2.4.3-pre9 should adopt the pci_fixup_vt8363 from 2.4.2-ac28?
Below is a patch.

Cheers,
Wayne

--- linux-2.4.3-pre8/arch/i386/kernel/pci-pc.c	Wed Mar 28 22:56:04 2001
+++ linux-2.4.2-ac28/arch/i386/kernel/pci-pc.c	Wed Mar 28 22:51:00 2001
@@ -968,23 +971,13 @@
 		printk("PCI: Bus master Pipeline request disabled\n");
 		pci_write_config_byte(d, 0x54, tmp & ~(1<<2));
 	}
-	pci_read_config_byte(d, 0x54, &tmp);
-	if(tmp & (1)) {
-		printk("PCI: Fast Write to Read turnaround disabled\n");
-		pci_write_config_byte(d, 0x54, tmp & ~(1));
-	}
 	pci_read_config_byte(d, 0x70, &tmp);
 	if(tmp & (1<<3)) {
 		printk("PCI: Disabled enhanced CPU to PCI writes\n");
 		pci_write_config_byte(d, 0x70, tmp & ~(1<<3));
 	}
-	pci_read_config_byte(d, 0x70, &tmp);
-	if(tmp & (1<<2)) {
-		printk("PCI: Disabled Master Read Caching\n");
-		pci_write_config_byte(d, 0x70, tmp & ~(1<<2));
-	}
 	pci_read_config_byte(d, 0x71, &tmp);
-	if ((tmp & (1<<3))==0) {
+	if((tmp & (1<<3)) == 0) {
 		printk("PCI: Bursting cornercase bug worked around\n");
 		pci_write_config_byte(d, 0x71, tmp | (1<<3));
 	}

