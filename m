Return-Path: <linux-kernel-owner+w=401wt.eu-S1754211AbWLRQR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754211AbWLRQR0 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 11:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754212AbWLRQR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 11:17:26 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:56227 "EHLO
	turing-police.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754211AbWLRQRZ (ORCPT
	<RFC822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 11:17:25 -0500
X-Greylist: delayed 3613 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Dec 2006 11:17:24 EST
Message-Id: <200612171624.kBHGOEfZ003887@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: linux-kernel@vger.kernel.org
Subject: 2.6.20-rc1-mm1 - TPM Follies on Dell Latitude D820
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1166372654_3376P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 17 Dec 2006 11:24:14 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1166372654_3376P
Content-Type: text/plain; charset=us-ascii

(Yes, I *know* the answer is probably "Get Dell to fix the BIOS settings",
but I'll need some more info on exactly what to tell them so it gets fixed
right.

Scenario - I recently got a Dell Latitude D820 to replace my aging C840.
Am running Fedora Core Rawhide in (mostly) 64-bit mode.

Folly 1:  If you boot with the BIOS TPM setting to 'Disabled', you get this:

[    0.000000] DMI 2.4 present.
[    0.000000] ACPI: RSDP (v000 DELL                                  ) @ 0x00000000000fc0b0
[    0.000000] ACPI: RSDT (v001 DELL    M07     0x27d60a0d ASL  0x00000061) @ 0x000000007fe8198a
[    0.000000] ACPI: FADT (v001 DELL    M07     0x27d60a0d ASL  0x00000061) @ 0x000000007fe82800
[    0.000000] ACPI: HPET (v001 DELL    M07     0x00000001 ASL  0x00000061) @ 0x000000007fe82f00
[    0.000000] ACPI: MADT (v001 DELL    M07     0x27d60a0d ASL  0x00000047) @ 0x000000007fe83000
[    0.000000] ACPI: ASF! (v016 DELL    M07     0x27d60a0d ASL  0x00000061) @ 0x000000007fe82c00
[    0.000000] ACPI: MCFG (v016 DELL    M07     0x27d60a0d ASL  0x00000061) @ 0x000000007fe82fc0
[    0.000000] ACPI: SLIC (v001 DELL    M07     0x27d60a0d ASL  0x00000061) @ 0x000000007fe8309c
[    0.000000] ACPI: TCPA (v001 DELL    M07     0x27d60a0d ASL  0x00000061) @ 0x000000007fe83300
[    0.000000]   >>> ERROR: Invalid checksum
[    0.000000] ACPI: SSDT (v001  PmRef    CpuPm 0x00003000 INTL 0x20050624) @ 0x000000007fe81a11
[    0.000000] ACPI: DSDT (v001 INT430 SYSFexxx 0x00001001 INTL 0x20050624) @ 0x0000000000000000

The 'invalid checksum' message goes away if you enable the TPM.  Note that this
one happens even if you don't have TPM support enabled in the kernel. The code
in drivers/acpi/tables.c isn't incredibly verbose about what the exact problem
is - I'm willing to add instrumentation if somebody can tell me what would be
actually useful to dump out. 

Folly 2: when userspace gets around to doing a 'modprobe tpm_tis', we get the
following complaint:

[   76.318668] tpm_tis 00:0d: 1.2 TPM (device-id 0x1001, rev-id 2)
[   76.378236] IRQ handler type mismatch for IRQ 8
[   76.378239] current handler: rtc
[   76.378240] 
[   76.378241] Call Trace:
[   76.378255]  [<ffffffff80266d56>] dump_trace+0xb9/0x3b3
[   76.378261]  [<ffffffff8026708c>] show_trace+0x3c/0x52
[   76.378265]  [<ffffffff802670b7>] dump_stack+0x15/0x17
[   76.378270]  [<ffffffff802a3839>] setup_irq+0x1c2/0x1e6
[   76.378275]  [<ffffffff802a38fb>] request_irq+0x9e/0xc7
[   76.378282]  [<ffffffff885f58c5>] :tpm_tis:tpm_tis_init+0x205/0x44c
[   76.378290]  [<ffffffff885f5b3a>] :tpm_tis:tpm_tis_pnp_init+0x2e/0x30
[   76.378296]  [<ffffffff80392838>] pnp_device_probe+0x7b/0xa0
[   76.378302]  [<ffffffff803b4813>] driver_probe_device+0xbc/0x138
[   76.378307]  [<ffffffff803b497a>] __driver_attach+0x5b/0x94
[   76.378312]  [<ffffffff803b3cdd>] bus_for_each_dev+0x49/0x7a
[   76.378316]  [<ffffffff803b4666>] driver_attach+0x1c/0x1e
[   76.378320]  [<ffffffff803b4011>] bus_add_driver+0x75/0x199
[   76.378324]  [<ffffffff803b4c8a>] driver_register+0x85/0x89
[   76.378328]  [<ffffffff80392521>] pnp_register_driver+0x1c/0x1e
[   76.378333]  [<ffffffff8800f081>] :tpm_tis:init_tis+0x81/0x89
[   76.378339]  [<ffffffff80295e62>] sys_init_module+0xac/0x17d
[   76.378345]  [<ffffffff8025a11e>] system_call+0x7e/0x83
[   76.378352]  [<00000039d1acd90a>]
[   76.378354] 
[   76.378355] tpm_tis 00:0d: Unable to request irq: 8 for probe

(2.6.19-rc6-mm2 would repeat the complaint on IRQ 14 and then 15 as well)

/proc/interrupts says:
           CPU0       CPU1       
  0:    1577201          0   IO-APIC-edge      timer
  1:       4851          0   IO-APIC-edge      i8042
  8:          0          0   IO-APIC-edge      rtc
  9:          2          0   IO-APIC-fasteoi   acpi
 12:        145          0   IO-APIC-edge      i8042
 14:      13647      40481   IO-APIC-edge      libata
 15:         59       7876   IO-APIC-edge      libata
 16:      64047          0   IO-APIC-fasteoi   nvidia
 17:          0          0   IO-APIC-fasteoi   ipw3945
 19:         10          0   IO-APIC-fasteoi   yenta, ohci1394
 20:         28          0   IO-APIC-fasteoi   ehci_hcd:usb1, uhci_hcd:usb2
 21:       5303          0   IO-APIC-fasteoi   uhci_hcd:usb3, HDA Intel
 22:         29       4701   IO-APIC-fasteoi   uhci_hcd:usb4
 23:          0          0   IO-APIC-fasteoi   uhci_hcd:usb5
NMI:          0          0 
LOC:    1577087    1577049 
ERR:          0

Any ideas/suggestions?

--==_Exmh_1166372654_3376P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFhW8ucC3lWbTT17ARAm9NAKCuUUzoOR2eSpY68RkMLKXngxHPMQCgkhYb
SWiGcJDPyjRRgs3/fanCdws=
=u+Jb
-----END PGP SIGNATURE-----

--==_Exmh_1166372654_3376P--
