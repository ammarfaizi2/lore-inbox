Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261766AbVAHAKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbVAHAKv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 19:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbVAHAHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 19:07:47 -0500
Received: from smtp07.auna.com ([62.81.186.17]:15861 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id S261719AbVAHACZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 19:02:25 -0500
Date: Sat, 08 Jan 2005 00:02:20 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: i2c: lost sensors with 2.6.10(-mm1)
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Jean Delvare <khali@linux-fr.org>
References: <1105058791l.5580l.0l@werewolf.able.es>
	<41DE5B99.1040602@linux-fr.org>
In-Reply-To: <41DE5B99.1040602@linux-fr.org> (from khali@linux-fr.org on Fri
	Jan  7 10:51:21 2005)
X-Mailer: Balsa 2.2.6
Message-Id: <1105142540l.5669l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="=-aQUo68P7kx/GUHBTfx5s"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-aQUo68P7kx/GUHBTfx5s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On 2005.01.07, Jean Delvare wrote:
> J.A. Magallon wrote:
>=20
> > I have lost my sensors info with 2.6.10, in particular -mm1.
> > They work fine with 2.6.9-mm1 (current state of the box, booted on
> > 2.6.9 or 10, no other difference).
>  > (...)
> > I have noticed different contents in /sys:
> > under 2.6.9:
> > /sys/devices/platform/i2c-1:
> > /sys/devices/platform/i2c-1/1-0290:
> > /sys/devices/platform/i2c-1/1-0290/power:
> > /sys/devices/platform/i2c-1/power:
> >=20
> > under 2.6.10:
> > /sys/devices/platform/i2c-1:
> > /sys/devices/platform/i2c-1/power:
> >=20
> > So some /sys nodes are missing !!!
> > (the isa bus)
>=20
> This basically means that the i2c client was not registered.
>=20
> > Debug output from 2.6.10-mm1:
> > (...)
> > Jan  7 01:33:11 werewolf kernel: i2c-core: driver w83627hf registered.
> > Jan  7 01:33:11 werewolf kernel: i2c_adapter i2c-1: found normal isa en=
try for adapter 9191, addr 0290
>=20
> However, this suggests that the driver loaded properly and the base=20
> address was correctly read from Super-I/O space. This would mean that=20
> the problem happened later, in w83627hf_detect(). The most likely reason=20
> for this would be if the region request failed (unfortunately we have no=20
> message, not even debug, if this happens).
>=20
> > Some ideas ?
>=20
> Three things to try, in order:
>=20
> 1* Compare /proc/ioports in 2.6.9-mm1 and 2.6.10-mm1. I suspect that the=20
> 0x290-0x297 range is held by some device in 2.6.10-mm1.
>=20

Good start. 2.6.10-mm1 shows this:

@@ -45,6 +44,7 @@
 00f0-00ff : fpu
 0170-0177 : ide1
 01f0-01f7 : ide0
+0295-0296 : pnp 00:0d
 02f8-02ff : serial
 0376-0376 : ide1
 03c0-03df : vga+

Differences in dmesg show this (apart from others):

@@ -120,6 +120,7 @@
   Normal zone: 257760 pages, LIFO batch:16
   HighMem zone: 0 pages, LIFO batch:1
 DMI 2.3 present.
+__iounmap: bad address b00f0000
 ACPI: RSDP (v000 IntelR                                ) @ 0x000f71f0
 ACPI: RSDT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fee3000
 ACPI: FADT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fee3040
@@ -149,25 +150,27 @@
 Enabling APIC mode:  Flat.  Using 1 I/O APICs
 Using ACPI (MADT) for SMP configuration information
 Built 1 zonelists
+mapped APIC to ffffd000 (fee00000)
+mapped IOAPIC to ffffc000 (fec00000)
 Initializing CPU#0
@@ -236,7 +239,9 @@
 PCI: PCI BIOS revision 2.10 entry at 0xfb7c0, last bus=3D3
 PCI: Using configuration type 1
 mtrr: v2.0 (20020519)
-ACPI: Subsystem revision 20040816
+ACPI: Subsystem revision 20041210
+    ACPI-1138: *** Error: Method execution failed [\STRC] (Node efedc380),=
 AE_AML_BUFFER_LIMIT
+    ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0._INI] (Node =
efedd620), AE_AML_BUFFER_LIMIT
 ACPI: Interpreter enabled
 ACPI: Using IOAPIC for interrupt routing
 ACPI: PCI Root Bridge [PCI0] (00:00)
@@ -254,6 +259,8 @@
 ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 7 9 10 *11 12 14 15)
 ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 7 *9 10 11 12 14 15)
 Linux Plug and Play Support v0.97 (c) Adam Belay
+pnp: PnP ACPI init
+pnp: PnP ACPI: found 16 devices
 SCSI subsystem initialized
 PCI: Using ACPI for IRQ routing
@@ -263,6 +270,8 @@
 ** behavior.  If this argument makes the device work again,
 ** please email the output of "lspci" to bjorn.helgaas@hp.com
 ** so I can fix the driver.
+pnp: 00:0d: ioport range 0x400-0x4bf could not be reserved
+pnp: 00:0d: ioport range 0x295-0x296 has been reserved
 IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
 isapnp: Scanning for PnP cards...
 isapnp: No Plug & Play device found

So I guess it is "Plug and Play ACPI support", I'm just going to disable it
and try. If it is the case, there is an IO port conflict...

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.10-jam1 (gcc 3.4.3 (Mandrakelinux 10.2 3.4.3-2mdk)) #2


--=-aQUo68P7kx/GUHBTfx5s
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBB3yMMRlIHNEGnKMMRAr+ZAKCda6RyUj9HDfBQgUCkYB4DKPkbMQCfWNDg
asyp1UjfJO7u7gEPn5yO5xs=
=r2BR
-----END PGP SIGNATURE-----

--=-aQUo68P7kx/GUHBTfx5s--

