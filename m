Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266368AbTAJWI6>; Fri, 10 Jan 2003 17:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266377AbTAJWI6>; Fri, 10 Jan 2003 17:08:58 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:45953 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S266368AbTAJWIw>; Fri, 10 Jan 2003 17:08:52 -0500
Message-Id: <200301102217.h0AMHPLK015074@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Jochen Hein <jochen@jochen.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.55, PCI, PCMCIA, XIRCOM] 
In-Reply-To: Your message of "Fri, 10 Jan 2003 20:00:31 +0100."
             <87y95sakz4.fsf@jupiter.jochen.org> 
From: Valdis.Kletnieks@vt.edu
References: <87znq9ynz4.fsf@jupiter.jochen.org> <200301101713.h0AHDYLK010367@turing-police.cc.vt.edu>
            <87y95sakz4.fsf@jupiter.jochen.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1613235860P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 10 Jan 2003 17:17:25 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1613235860P
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-1749969480"

This is a multipart MIME message.

--==_Exmh_-1749969480
Content-Type: text/plain; charset=us-ascii

On Fri, 10 Jan 2003 20:00:31 +0100, Jochen Hein said:

> > - and I've seen a report it causes an OOPS
> > on 2.5.53.  I've not tried it on post-52, but I had a -54 kernel OOPS
> > right around that point in bootup (right after IDE and somewhere in PCI
> > init).  Haven't chased that one at all...

if it OOPSes without my patch, then it's somebody else's problem.  If it
does so with my patch, but just gives the infamous "resource collisions"
message without it, then it's my fault ;)

> cs: cb_alloc(bus 1): vendor 0x115d, device 0x0003

OK.. we obviously made it *into* cb_alloc()..

> PCI: Enabling device 01:00.0 (0000 -> 0003)

This is coming out of pcibios_enable_resources() - the same function that
without my patch would have given the 'resource collisions' error and
returned.  

> PCI: Setting latency timer of device 01:00.0 to 64

xircom_probe to pci_set_master to pcibios_set_master, and we've returned
from pci_enable_device. and thus we've gotten past where my patch is. Only
possibility is that my code has re-arraigned some pointers in an evil way.

Now, it's pretty obvious that *some* call to pci_assign_resource has to
happen before pci_enable_device() for these Xircom cards for things to work
at all (and note that they work just fine in 2.4 and pre-2.5.47).  

I wonder if the *current* problem with the OOPs is due to this change in the
.53 patches to pci/setup_{bus,res}.c - as per the changelog:

<ink@jurassic.park.msu.ru>
	[PATCH] PCI: setup-xx fixes
	
	Don't disable PCI devices before changing the BARs, as discussed
	recently.  Disabling PCI_COMMAND_MASTER bit is an obvious bug.
	
	Further, pdev_enable_device() is a leftover from very old (2.0, I guess)
	alpha PCI code.  It's used in pci_assign_unassigned_resources() to
	enable *every* PCI device in the system.  So, if we have two graphic
	cards on the same bus, both with legacy VGA IO...  oops.
	
	Actually, only alpha relied on that due to the lack of
	pcibios_enable_device (which has been already fixed).

After this patch, we no longer go into pdev_enable_device, which may have
been doing something that was in fact still needed by the Xircom code,
although I'm mostly guessing that it's the 'disable the ROM'. The other
possibility is that ink's patch exposes a problem with the way my patch
calls pci_alloc_resource() before pci_enable_device().

In any case, I've attached a new *UNTESTED* patch, that only tries to gratuitously
assign resources of MEM class, and disables the ROM once it does so.

No, I don't claim to fully understand this code.  And if you're not brave
enough or can't test it yourself, I'll be taking the 2.5.56 plunge sometime
this weekend. ;)  And all you other kernel hackers are welcome to jump right
in and tell me what I'm doing wrong.. ;)

/Valdis

--==_Exmh_-1749969480
Content-Type: text/plain ; name="pcmcia.temp"; charset=us-ascii
Content-Description: pcmcia.temp
Content-Disposition: attachment; filename="pcmcia.temp"

--- drivers/pcmcia/cardbus.c.old	2003-01-10 16:49:11.000000000 -0500
+++ drivers/pcmcia/cardbus.c.new	2003-01-10 16:48:24.000000000 -0500
@@ -283,18 +283,26 @@
 		dev->hdr_type = hdr & 0x7f;
 
 		pci_setup_device(dev);
-		if (pci_enable_device(dev))
-			continue;
 
 		strcpy(dev->dev.bus_id, dev->slot_name);
 
 		/* FIXME: Do we need to enable the expansion ROM? */
 		for (r = 0; r < 7; r++) {
 			struct resource *res = dev->resource + r;
-			if (res->flags)
+			if (res->flags & IORESOURCE_MEM) {
 				pci_assign_resource(dev, r);
+				if (dev->rom_base_reg) {
+					pci_read_config_dword(dev, dev->rom_base_reg, &reg);
+					reg &= ~PCI_ROM_ADDRESS_ENABLE;
+					pci_write_config_dword(dev, dev->rom_base_reg, reg);
+					dev->resource[PCI_ROM_RESOURCE].flags &= ~PCI_ROM_ADDRESS_ENABLE;
+				}
+			}
 		}
 
+		if (pci_enable_device(dev))
+			continue;
+
 		/* Does this function have an interrupt at all? */
 		pci_readb(dev, PCI_INTERRUPT_PIN, &irq_pin);
 		if (irq_pin) {


--==_Exmh_-1749969480--



--==_Exmh_-1613235860P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+H0Z0cC3lWbTT17ARAv1QAJwMnzOa3vEJSMOf5I9QAbVz38XyIQCg3ZOl
jDbC72wCSFDfBGassGUQovg=
=ed87
-----END PGP SIGNATURE-----

--==_Exmh_-1613235860P--
