Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWFKSaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWFKSaw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 14:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbWFKSaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 14:30:52 -0400
Received: from ns3.mountaincable.net ([24.215.0.13]:64918 "EHLO
	ns3.mountaincable.net") by vger.kernel.org with ESMTP
	id S1750704AbWFKSav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 14:30:51 -0400
Subject: [patch] ICH7 SCI_EN quirk required for Macbook
From: Ryan Lortie <desrt@desrt.ca>
To: linux-kernel@vger.kernel.org
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Ben Collins <bcollins@ubuntu.com>,
       Frederic Riss <frederic.riss@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ZDcrTDvKr617AtmiFm1w"
Date: Sun, 11 Jun 2006 14:30:33 -0400
Message-Id: <1150050633.12416.2.camel@moonpix.desrt.ca>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZDcrTDvKr617AtmiFm1w
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello

((apologies to everyone receiving this for a second time -- I messed up
the original posting quite badly by mailing to the wrong place))

I've been working on getting my Macbook to sleep and wake up properly
lately.  This email directly follows my earlier posting to the
linux-acpi list on the same subject ::

http://marc.theaimsgroup.com/?l=3Dlinux-acpi&m=3D114957637501557&w=3D2

The problem is that on resume the SCI_EN bit of the hardware power
management control register is not set.  This causes an endless stream
of unacknowledged IRQ9s.  This causes the kernel to ignore IRQ9 and
prevents ACPI from working.

Fixing the problem is as simple as re-enabling the SCI_EN bit early in
the resume process (before IRQs are enabled).

To this end,  I've written a patch that enables the SCI_EN bit soon
after resume on machines that need it (I do it for all ICH7-based Intel
Apple machines since an email from Frederic Riss tells me that he has
similar problems with his Mac Mini and my hack fixed it for him too).

Cheers

-------

This patch enables the SCI_EN bit on return from sleep on Intel-based
Apple machines with the ICH7 chipset (where for some reason this bit
gets disabled by sleep).  This is required to prevent an endless stream
of unacknowledged IRQ9s.

Signed-off-by: Ryan Lortie <desrt@desrt.ca>
---
 drivers/acpi/sleep/main.c |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)
diff -urp linux-2.6.17-rc6/drivers/acpi/sleep/main.c linux-2.6.17-rc6+/driv=
ers/acpi/sleep/main.c
--- linux-2.6.17-rc6/drivers/acpi/sleep/main.c	2006-06-11 13:41:53.00000000=
0 -0400
+++ linux-2.6.17-rc6+/drivers/acpi/sleep/main.c	2006-06-11 13:42:11.0000000=
00 -0400
@@ -17,6 +17,7 @@
 #include <linux/suspend.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
+#include <linux/pci.h>
 #include "sleep.h"
=20
 u8 sleep_states[ACPI_S_STATE_COUNT];
@@ -34,6 +35,7 @@ static u32 acpi_suspend_states[] =3D {
 };
=20
 static int init_8259A_after_S1;
+static int ich7_sci_en_quirk_enabled;
=20
 /**
  *	acpi_pm_prepare - Do preliminary suspend work.
@@ -92,6 +94,10 @@ static int acpi_pm_enter(suspend_state_t
=20
 	case PM_SUSPEND_MEM:
 		do_suspend_lowlevel();
+
+		if (ich7_sci_en_quirk_enabled)
+			acpi_set_register(ACPI_BITREG_SCI_ENABLE, 1,
+					  ACPI_MTX_DO_NOT_LOCK);
 		break;
=20
 	case PM_SUSPEND_DISK:
@@ -183,12 +189,37 @@ static int __init init_ints_after_s1(str
 	return 0;
 }
=20
+/*
+ * Apple Macbook comes back from sleep with the SCI_EN bit disabled
+ * causing a flood of unacknowledged IRQ9s.  We need to set SCI_EN
+ * as soon as we come back.
+ */
+static int __init init_ich7_sci_en_quirk(struct dmi_system_id *d)
+{
+	/* Ensure that we have an ICH7 (this is subdevice :1f.0) */
+	if (NULL =3D=3D pci_find_device(PCI_VENDOR_ID_INTEL,
+				    PCI_DEVICE_ID_INTEL_ICH7_1, NULL))
+		return 0;
+
+	/* Intel-based Apple with ICH7 chipset.  Enable the quirk. */
+	printk(KERN_WARNING "%s detected (ICH7 SCI_EN quirk enabled)\n",
+	       d->ident);
+	ich7_sci_en_quirk_enabled =3D 1;
+
+	return 0;
+}
+
 static struct dmi_system_id __initdata acpisleep_dmi_table[] =3D {
 	{
 	 .callback =3D init_ints_after_s1,
 	 .ident =3D "Toshiba Satellite 4030cdt",
 	 .matches =3D {DMI_MATCH(DMI_PRODUCT_NAME, "S4030CDT/4.3"),},
 	 },
+	{
+	 .callback =3D init_ich7_sci_en_quirk,
+	 .ident =3D "Intel Apple",
+	 .matches =3D {DMI_MATCH(DMI_SYS_VENDOR, "Apple Computer"),},
+	 },
 	{},
 };
=20


--=-ZDcrTDvKr617AtmiFm1w
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iQG5AwUARIxhSZ96IjKvqm/2AQKuzA0eKtbtYXxoWDcf4JzomzChrRD84zof9Y7T
PCGBmgJZnCz+nDsyl4VCl89z8k+zK1wguiCFfu7w0H9d4ChRu4kFcBuzICg3zVPE
lucoJureOO2gyTkfka+Q7M6XrE2s+c9ILCIrY+KQ80jn0ktTlyhbAMX0GkakWBBJ
a1r5jLxIkSk8HECszVSID8wYBQo9SHU0+Vjk81q+0q5IIH1saqThMwVqvJKYS91h
arNfwJuwSUsUCyxGuvIif4XUbtIZTlMOHJXOTNYyiULxOXFylOFFmKbXaS12BRVe
QeTOoLXry4vtI1QMEOxofEk/51PSpRs1q4LmT29ATXb/Ng1Y7wA4m3vmhGPF56He
6zjMgxg6Wca1W3bvrZcVHMLMQVm8omW/9ipj+fwQcJkucgsQC+aNc+S6OqQeuM5L
sMTTu6dYEtdOuhE+xmPjR17gTbw+DUvb5Agkkqa19jRkSX9pfKBdBnf4otzgLZ5H
T4yvoEqPP9rKHuYVtosIxb2bM1EPLVjId64k6sVFh1Cg4zTlWsrZnZlh424pDeAS
jIe8T5P3Qh3KKXbD
=sgDh
-----END PGP SIGNATURE-----

--=-ZDcrTDvKr617AtmiFm1w--

