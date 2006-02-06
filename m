Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964861AbWBFXNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbWBFXNl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 18:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbWBFXNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 18:13:41 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:37559 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S964861AbWBFXNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 18:13:40 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [Patch] Generic AGP PM support.
Date: Tue, 7 Feb 2006 09:10:14 +1000
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2119294.JKaYdSJtGa";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602070910.18808.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2119294.JKaYdSJtGa
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

This patch implements generic AGP power management support, and uses it for
the Ati and NVidia drivers. It is an update on the patch that Matthew
Garrett broke out of Suspend2 a while ago and sent to the list.

Regards,

Nigel

 agp_suspend.h |   43 +++++++++++++++++++++++++++++++++++++++++++
 ati-agp.c     |   14 ++++++++++++++
 nvidia-agp.c  |   14 ++++++++++++++
 3 files changed, 71 insertions(+)
diff -ruNp 3030-agp-resume-support.patch-old/drivers/char/agp/agp_suspend.h=
 3030-agp-resume-support.patch-new/drivers/char/agp/agp_suspend.h
=2D-- 3030-agp-resume-support.patch-old/drivers/char/agp/agp_suspend.h	1970=
=2D01-01 10:00:00.000000000 +1000
+++ 3030-agp-resume-support.patch-new/drivers/char/agp/agp_suspend.h	2005-1=
2-05 21:26:57.000000000 +1100
@@ -0,0 +1,43 @@
+/*
+ * Generic routines for suspending and resuming an agp bridge.
+ *
+ * Include "agp.h" first.
+ */
+
+#ifdef CONFIG_PM
+static int agp_common_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+	pci_save_state(pdev);
+	pci_set_power_state(pdev, 3);
+
+	return 0;
+}
+
+static int agp_common_resume(struct pci_dev *pdev,
+			     struct agp_bridge_driver * generic_bridge,
+			     int reconfigure(void))
+{
+	struct agp_bridge_data *bridge =3D pci_get_drvdata(pdev);
+
+	/* set power state 0 and restore PCI space */
+	pci_set_power_state(pdev, 0);
+	pci_restore_state(pdev);
+
+	/* reconfigure AGP hardware again */
+	if (bridge->driver =3D=3D generic_bridge)
+		return reconfigure();
+
+	return 0;
+}
+#else
+static int agp_common_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+	return 0;
+}
+
+static int agp_common_resume(struct pci_dev *pdev, _something_ * bridge,
+			     void *reconfigure)
+{
+	return 0;
+}
+#endif
diff -ruNp 3030-agp-resume-support.patch-old/drivers/char/agp/ati-agp.c 303=
0-agp-resume-support.patch-new/drivers/char/agp/ati-agp.c
=2D-- 3030-agp-resume-support.patch-old/drivers/char/agp/ati-agp.c	2005-11-=
11 14:12:17.000000000 +1100
+++ 3030-agp-resume-support.patch-new/drivers/char/agp/ati-agp.c	2005-12-05=
 21:26:57.000000000 +1100
@@ -9,6 +9,7 @@
 #include <linux/agp_backend.h>
 #include <asm/agp.h>
 #include "agp.h"
+#include "agp_suspend.h"
=20
 #define ATI_GART_MMBASE_ADDR	0x14
 #define ATI_RS100_APSIZE	0xac
@@ -507,6 +508,17 @@ static void __devexit agp_ati_remove(str
 	agp_put_bridge(bridge);
 }
=20
+static int agp_ati_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+	return (agp_common_suspend(pdev, state));
+}
+
+static int agp_ati_resume(struct pci_dev *pdev)
+{
+	return agp_common_resume(pdev, &ati_generic_bridge,
+				 ati_configure);
+}
+
 static struct pci_device_id agp_ati_pci_table[] =3D {
 	{
 	.class		=3D (PCI_CLASS_BRIDGE_HOST << 8),
@@ -526,6 +538,8 @@ static struct pci_driver agp_ati_pci_dri
 	.id_table	=3D agp_ati_pci_table,
 	.probe		=3D agp_ati_probe,
 	.remove		=3D agp_ati_remove,
+	.suspend	=3D agp_ati_suspend,
+	.resume		=3D agp_ati_resume,
 };
=20
 static int __init agp_ati_init(void)
diff -ruNp 3030-agp-resume-support.patch-old/drivers/char/agp/nvidia-agp.c =
3030-agp-resume-support.patch-new/drivers/char/agp/nvidia-agp.c
=2D-- 3030-agp-resume-support.patch-old/drivers/char/agp/nvidia-agp.c	2005-=
11-11 14:12:17.000000000 +1100
+++ 3030-agp-resume-support.patch-new/drivers/char/agp/nvidia-agp.c	2005-12=
=2D05 21:26:59.000000000 +1100
@@ -12,6 +12,7 @@
 #include <linux/page-flags.h>
 #include <linux/mm.h>
 #include "agp.h"
+#include "agp_suspend.h"
=20
 /* NVIDIA registers */
 #define NVIDIA_0_APSIZE		0x80
@@ -397,11 +398,24 @@ static struct pci_device_id agp_nvidia_p
=20
 MODULE_DEVICE_TABLE(pci, agp_nvidia_pci_table);
=20
+static int agp_nvidia_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+	return (agp_common_suspend(pdev, state));
+}
+
+static int agp_nvidia_resume(struct pci_dev *pdev)
+{
+	return agp_common_resume(pdev, &agp_bridge,
+				 nvidia_configure);
+}
+
 static struct pci_driver agp_nvidia_pci_driver =3D {
 	.name		=3D "agpgart-nvidia",
 	.id_table	=3D agp_nvidia_pci_table,
 	.probe		=3D agp_nvidia_probe,
 	.remove		=3D agp_nvidia_remove,
+	.suspend	=3D agp_nvidia_suspend,
+	.resume		=3D agp_nvidia_resume,
 };
=20
 static int __init agp_nvidia_init(void)

--nextPart2119294.JKaYdSJtGa
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD59daN0y+n1M3mo0RAulMAKDN6AcY9qVHy74LN+doM6msLkLoHACbBG0S
uUcKI587l1z4HWERhyZ+USA=
=asO7
-----END PGP SIGNATURE-----

--nextPart2119294.JKaYdSJtGa--
