Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262702AbRFTKfY>; Wed, 20 Jun 2001 06:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262934AbRFTKfN>; Wed, 20 Jun 2001 06:35:13 -0400
Received: from yellow.jscc.ru ([195.208.40.129]:52751 "EHLO yellow.jscc.ru")
	by vger.kernel.org with ESMTP id <S262702AbRFTKey>;
	Wed, 20 Jun 2001 06:34:54 -0400
Message-ID: <009901c0f975$acf26330$4d28d0c3@jscc.ru>
From: "Oleg I. Vdovikin" <vdovikin@jscc.ru>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.2.19: Alpha PCI code: pcibios_fixup_bus
Date: Wed, 20 Jun 2001 14:42:16 +0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0096_01C0F997.3378DA30"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0096_01C0F997.3378DA30
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit

Hi!

    We've number of UP2000+ boards (they just like DP264 in common). These
boards has 2 PCI hoses, both has 3 PCI slots - one 32bits (IdSel=9) & two
64bits (IdSel=7,8) (6 slots in total).
    Recently we've tried to install 3c985b 64-bit card and observe the
following: this card works just fine being inserted into 32bit slot -
detected by Linux PCI code, gots real IRQ level.
    But we've tried to insert it onto the 64 bit slot we got problems. When
inserted onto the slot with IdSel = 8 it's detected twice (!!!) - with
IdSels 8 & 13! So, when pci code assign irqs & memory region it's do this
twice - firstly for card with IdSel = 8 (which is "real" card and it gots
"real" IRQ) and secondly for "phantom" with IdSel = 13 (and assigns IRQ 0
for it because DP264 knows nothing about IdSel 13). As the result 3c985
driver - acenic module sees 2 cards - the real card with valid IRQ (acenic
read IRQ from kernel, not from card), but with invalid memory region
(because this card was remaped for IdSel 13), and the second card with valid
memory region, but with invalid IRQ == 0. Acenic when initialize "phantom",
but works very slow... More fun comes when this card inserted onto the slot
with IdSel = 7 - it's gets detected 32 times - with IdSel = 0..31 - i.e.
entire pci bus!
    SRM detects this card only 6 times when IdSel = 7 and only once for
IdSel = 8, 9 (but SRM knows which IdSels are valid on DP264)..

    So as seems 64bit 3c985b hardware is not fully comaptible with DP264.
We've observe sismilar problems with Intel's EtherExpress PRO/1000 - it's
also detected twice with IdSel = 7,12 when inserted onto the slot with IdSel
= 7.

-- lspci -- for Intel - Note device 01:0c.0 has no IRQ (i.e. IRQ == 0)
01:07.0 Ethernet controller: Intel Corporation: Unknown device 1001 (rev 02)
        Subsystem: Intel Corporation: Unknown device 1003
        Flags: bus master, 66Mhz, medium devsel, latency 252, IRQ 47
        Memory at 0000000109000000 (32-bit, non-prefetchable)
        Memory at 0000000109020000 (32-bit, non-prefetchable)
        Expansion ROM at 0000000001030000 [disabled]
        Capabilities: [dc] Power Management version 2

01:0c.0 Ethernet controller: Intel Corporation: Unknown device 1001 (rev 02)
        Subsystem: Intel Corporation: Unknown device 1003
        Flags: bus master, 66Mhz, medium devsel, latency 252
        Memory at 0000000109040000 (32-bit, non-prefetchable)
        Memory at 0000000109060000 (32-bit, non-prefetchable)
        Expansion ROM at 0000000001030000 [disabled]
--

    Sorry, for my bad english and explanations.

    Attached please find a patch against 2.2.16 - 2.2.19 kernels. This patch
alters 3 files:
include/asm-alpha/machvec.h - added new function to mv - pci_fixup_bus -
just like X86 has,
arch/alpha/kernel/bios32.c - added a in the pcibios_fixup_bus - to call a
function from mv if any,
arch/alpha/kernel/sys_dp264.c - dp264_pci_fixup_bus to disable phantoms.

    With this patch everything works just fine for me and we got really fast
net. ;-))

-- lspci -vv
01:08.0 Ethernet controller: 3Com Corporation 3c985 1000BaseSX (rev 01)
        Subsystem: Unknown device 9850:0001
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 min, 248 set, cache line size 08
        Interrupt: pin A routed to IRQ 43
        Region 0: Memory at 0000000109000000 (32-bit, non-prefetchable)
--

    As seems pci_fixup_bus needed for Alphas too... And possibly it's need
to be done for 2.4 also.

Regards,
    Oleg.

------=_NextPart_000_0096_01C0F997.3378DA30
Content-Type: application/octet-stream;
	name="linux-2.2.19.dp264.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="linux-2.2.19.dp264.patch"

diff -ur linux-2.2.19/arch/alpha/kernel/bios32.c =
linux-2.2.19.dp264/arch/alpha/kernel/bios32.c=0A=
--- linux-2.2.19/arch/alpha/kernel/bios32.c	Sun Mar 25 20:31:46 2001=0A=
+++ linux-2.2.19.dp264/arch/alpha/kernel/bios32.c	Wed Jun  6 15:35:09 =
2001=0A=
@@ -125,6 +125,9 @@=0A=
 void __init=0A=
 pcibios_fixup_bus(struct pci_bus *bus)=0A=
 {=0A=
+	if (alpha_mv.pci_fixup_bus) {=0A=
+		alpha_mv.pci_fixup_bus(bus);=0A=
+	}=0A=
 }=0A=
 =0A=
 int=0A=
diff -ur linux-2.2.19/arch/alpha/kernel/sys_dp264.c =
linux-2.2.19.dp264/arch/alpha/kernel/sys_dp264.c=0A=
--- linux-2.2.19/arch/alpha/kernel/sys_dp264.c	Sun Mar 25 20:31:46 2001=0A=
+++ linux-2.2.19.dp264/arch/alpha/kernel/sys_dp264.c	Wed Jun  6 15:35:27 =
2001=0A=
@@ -14,6 +14,7 @@=0A=
 #include <linux/sched.h>=0A=
 #include <linux/pci.h>=0A=
 #include <linux/init.h>=0A=
+#include <linux/malloc.h>=0A=
 =0A=
 #include <asm/ptrace.h>=0A=
 #include <asm/system.h>=0A=
@@ -388,6 +389,60 @@=0A=
 }=0A=
 =0A=
 static void __init=0A=
+dp264_pci_fixup_bus(struct pci_bus *bus)=0A=
+{=0A=
+	struct pci_dev *dev, *next;=0A=
+=0A=
+	unsigned int mask =3D 0;=0A=
+	for (dev =3D bus->devices; dev; dev =3D dev->sibling) {=0A=
+		mask |=3D 1 << (dev->devfn >> 3);=0A=
+	}=0A=
+=0A=
+	/* analyze the mask */=0A=
+	if (mask =3D=3D 0xffffffff) { /* Oops!!! */=0A=
+		/* disable everything with except of IdSel 7 */=0A=
+		/* which is known to be a problematic slot */=0A=
+		/* with a 64 bit cards such as 3COM 3c985 */=0A=
+		/* !!! NEVER use bus 0 idsel 7 with such cards!!! */=0A=
+		printk("dp264_pci_fixup_bus: WARNING: Phantom device occupies entire =
bus %d - only IdSel 7 enabled.\n", bus->number);=0A=
+		mask &=3D 0xffffff7f; =0A=
+	} else {=0A=
+		/* disable everyting with except of valid */=0A=
+		/* IdSels 5 - 10 - some 64bit cards */=0A=
+		/* detects twice - once with valid IdSel */=0A=
+		/* and secondly with invalid IdSel */=0A=
+		mask &=3D 0xfffff81f;=0A=
+	}=0A=
+		=0A=
+	for (dev =3D bus->devices; dev; dev =3D next) {=0A=
+		next =3D dev->sibling;=0A=
+		if (mask & (1 << (dev->devfn >> 3))) {=0A=
+			unsigned short cmd;=0A=
+			struct pci_dev *fixup;=0A=
+			=0A=
+			printk("dp264_pci_fixup_bus: Disabling \"phantom\" device at =
%02x:%02x.%02x [%04x/%04x]\n",=0A=
+			    dev->bus->number, dev->devfn >> 3, dev->devfn & 7, dev->vendor, =
dev->device);=0A=
+				    =0A=
+			/* disable this device to avoid problems */=0A=
+			pcibios_read_config_word(dev->bus->number, =0A=
+				dev->devfn, PCI_COMMAND, &cmd);=0A=
+			cmd &=3D (~PCI_COMMAND_IO & ~PCI_COMMAND_MEMORY & =
~PCI_COMMAND_MASTER);=0A=
+			pcibios_write_config_word(dev->bus->number,=0A=
+				dev->devfn, PCI_COMMAND, cmd);=0A=
+					=0A=
+			/* delete from the list of devices */=0A=
+			/* fixup devices */=0A=
+			for (fixup =3D pci_devices; fixup; fixup =3D fixup->next) {=0A=
+			        if (fixup->next =3D=3D dev) fixup->next =3D dev->next;=0A=
+				if (fixup->sibling =3D=3D dev) fixup->sibling =3D dev->sibling;=0A=
+			}=0A=
+			/* free memory */=0A=
+			kfree(dev);=0A=
+		}=0A=
+	}=0A=
+}=0A=
+=0A=
+static void __init=0A=
 monet_pci_fixup(void)=0A=
 {=0A=
 	layout_all_busses(DEFAULT_IO_BASE, DEFAULT_MEM_BASE);=0A=
@@ -438,6 +493,7 @@=0A=
 	init_irq:		dp264_init_irq,=0A=
 	init_pit:		generic_init_pit,=0A=
 	pci_fixup:		dp264_pci_fixup,=0A=
+	pci_fixup_bus:		dp264_pci_fixup_bus,=0A=
 	kill_arch:		generic_kill_arch,=0A=
 };=0A=
 ALIAS_MV(dp264)=0A=
diff -ur linux-2.2.19/include/asm-alpha/machvec.h =
linux-2.2.19.dp264/include/asm-alpha/machvec.h=0A=
--- linux-2.2.19/include/asm-alpha/machvec.h	Sun Mar 25 20:31:06 2001=0A=
+++ linux-2.2.19.dp264/include/asm-alpha/machvec.h	Wed Jun  6 15:34:11 =
2001=0A=
@@ -88,6 +88,7 @@=0A=
 	void (*init_irq)(void);=0A=
 	void (*init_pit)(void);=0A=
 	void (*pci_fixup)(void);=0A=
+	void (*pci_fixup_bus)(void *);=0A=
 	void (*kill_arch)(int, char *);=0A=
 =0A=
 	const char *vector_name;=0A=

------=_NextPart_000_0096_01C0F997.3378DA30--

