Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292780AbSCSVNC>; Tue, 19 Mar 2002 16:13:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292817AbSCSVMy>; Tue, 19 Mar 2002 16:12:54 -0500
Received: from jagor.srce.hr ([161.53.2.130]:24037 "EHLO jagor.srce.hr")
	by vger.kernel.org with ESMTP id <S292780AbSCSVMj>;
	Tue, 19 Mar 2002 16:12:39 -0500
Message-Id: <200203192112.WAA09721@jagor.srce.hr>
Content-Type: text/plain; charset=US-ASCII
From: Danijel Schiavuzzi <dschiavu@public.srce.hr>
Organization: Dead Poets Society
To: linux-kernel@vger.kernel.org
Subject: Screen corruption in 2.4.18
Date: Tue, 19 Mar 2002 22:12:18 +0100
X-Mailer: KMail [version 1.3.1]
X-UIN: 39223454
X-Operating-System: GNU/Linux 2.4.17
X-Troll: no
X-URL: <http://danijels.cjb.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Some two weeks ago I posted here a kernel bug report regarding
a screen corruption issue. You can find it here:
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0203.0/1577.html

As I didn't know if it's my hardware that is the cause of corruption,
searched over the Internet and found that Thomas Brehm is also
having the same problem, and he has the same motherboard as me
(MSI MS-6340M, VIA KM133 chipset - VT8365 north + VIA686B south bridge).

Short problem description: 2.4.17 kernel works fine, but any kernel
higher than this makes the screen corrupted in any text or VESA fb
mode. In standard text mode, the screen gets filled with vertical
lines. In vesafb mode, random horizontal lines appear on the screen.

However, I made up the 2.4.18 kernel to boot up properly by 
replacing the file

	./linux/arch/i386/pci-pc.c

with that from the 2.4.17 kernel. The kernel runs fine now.

So, what seems to make the screen corruption?

						-- Danijel

P.S.  Here is a diff between the two pci-pc.c files:

------------------------- begin -------------------------

1112c1112,1113
<  * Nobody seems to know what this does. Damn.
---
>  * Addresses issues with problems in the memory write queue timer in
>  * certain VIA Northbridges.  This bugfix is per VIA's specifications.
1114,1118c1115,1118
<  * But it does seem to fix some unspecified problem
<  * with 'movntq' copies on Athlons.
<  *
<  * VIA 8363 chipset:
<  *  - bit 7 at offset 0x55: Debug (RW)
---
>  * VIA 8363,8622,8361 Northbridges:
>  *  - bits  5, 6, 7 at offset 0x55 need to be turned off
>  * VIA 8367 (KT266x) Northbridges:
>  *  - bits  5, 6, 7 at offset 0x95 need to be turned off
1120c1120
< static void __init pci_fixup_via_athlon_bug(struct pci_dev *d)
---
> static void __init pci_fixup_via_northbridge_bug(struct pci_dev *d)
1123,1127c1123,1134
< 	pci_read_config_byte(d, 0x55, &v);
< 	if (v & 0x80) {
< 		printk("Trying to stomp on Athlon bug...\n");
< 		v &= 0x7f; /* clear bit 55.7 */
< 		pci_write_config_byte(d, 0x55, v);
---
> 	int where = 0x55;
> 
> 	if (d->device == PCI_DEVICE_ID_VIA_8367_0) {
> 		where = 0x95; /* the memory write queue timer register is 
> 				 different for the kt266x's: 0x95 not 0x55 */
> 	}
> 
> 	pci_read_config_byte(d, where, &v);
> 	if (v & 0xe0) {
> 		printk("Disabling VIA memory write queue: [%02x] %02x->%02x\n", where, v, 
v & 0x1f);
> 		v &= 0x1f; /* clear bits 5, 6, 7 */
> 		pci_write_config_byte(d, where, v);
1140c1147,1150
< 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8363_0,	
pci_fixup_via_athlon_bug },
---
> 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8363_0,	
pci_fixup_via_northbridge_bug },
> 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8622,	        
pci_fixup_via_northbridge_bug },
> 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8361,	        
pci_fixup_via_northbridge_bug },
> 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8367_0,	
pci_fixup_via_northbridge_bug },

------------------------------ end ------------------------------
