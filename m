Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290015AbSAWUpr>; Wed, 23 Jan 2002 15:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290069AbSAWUpi>; Wed, 23 Jan 2002 15:45:38 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:48262 "HELO atlrel8.hp.com")
	by vger.kernel.org with SMTP id <S290015AbSAWUp3>;
	Wed, 23 Jan 2002 15:45:29 -0500
From: Bjorn Helgaas <bjorn_helgaas@hp.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] 2.4.18-pre6 AGP enable fixes
Date: Wed, 23 Jan 2002 13:46:02 -0700
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net,
        Bjorn Helgaas <bjorn_helgaas@hp.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_QCSEO4BKC9RU5RL7UM58"
Message-Id: <20020123204523.04A764556@ldl.fc.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_QCSEO4BKC9RU5RL7UM58
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

In 2.4.17-pre5, agp_generic_agp_enable() and serverworks_agp_enable()
were changed to look for AGP devices as coprocessors on non-VGA
devices as well as VGA devices.

But those functions contain TWO loops that scan for AGP devices (one
to collect the settings they support, and a second to update the
command registers), and 2.4.17-pre5 only changed the first loop in
each case.  Shouldn't both loops be changed, as in the "agp_dev" patch
attached?

While looking at this code, I noticed a possible further improvement.
Currently it looks like this:

        pci_for_each_dev(device)
        {
                if((((device->class >> 16) & 0xFF) != PCI_BASE_CLASS_DISPLAY) &&
                        (device->class != (PCI_CLASS_PROCESSOR_CO << 8)))
                        continue;

                pci_read_config_dword(device, 0x04, &scratch);
 
                if (!(scratch & 0x00100000))
                        continue;
 
                pci_read_config_byte(device, 0x34, &cap_ptr);
 
                if (cap_ptr != 0x00) {
                        do {
                                pci_read_config_dword(device,
                                                      cap_ptr, &cap_id);
 
                                if ((cap_id & 0xff) != 0x02)
                                        cap_ptr = (cap_id >> 8) & 0xff;
                        }
                        while (((cap_id & 0xff) != 0x02) && (cap_ptr != 0x00));
                }
                if (cap_ptr != 0x00) {
		        ...

The bulk of the above is just a reimplementation of pci_find_capability(),
so what about changing the whole shooting match to the following:

        pci_for_each_dev(device) {
                cap_ptr = pci_find_capability(device, PCI_CAP_ID_AGP);
                if (cap_ptr != 0x00) {
		        ...

Is there anything gained by checking the device class before looking
for the AGP capability?  The "agp_find_cap" patch attached implements
this idea.  I've compiled and booted kernels with both patches, but
they're otherwise untested.

-- 
Bjorn Helgaas - bjorn_helgaas@hp.com
Linux Systems Operation R&D
Hewlett-Packard
--------------Boundary-00=_QCSEO4BKC9RU5RL7UM58
Content-Type: text/plain;
  charset="iso-8859-1";
  name="agp_dev-2.4.18-pre6.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="agp_dev-2.4.18-pre6.patch"

diff -u -X /home/helgaas/exclude -r linux-2.4.18-pre6/drivers/char/agp/agpgart_be.c build/linux-2.4.18-pre6/drivers/char/agp/agpgart_be.c
--- linux-2.4.18-pre6/drivers/char/agp/agpgart_be.c	Wed Jan 23 10:16:39 2002
+++ build/linux-2.4.18-pre6/drivers/char/agp/agpgart_be.c	Wed Jan 23 10:23:23 2002
@@ -506,8 +506,17 @@
 	 *        command registers.
 	 */
 
-	while ((device = pci_find_class(PCI_CLASS_DISPLAY_VGA << 8,
-					device)) != NULL) {
+	pci_for_each_dev(device)
+	{
+		/*
+		 *	Enable AGP devices. Most will be VGA display but
+		 *	some may be coprocessors on non VGA devices too
+		 */
+		 
+		if((((device->class >> 16) & 0xFF) != PCI_BASE_CLASS_DISPLAY) &&
+			(device->class != (PCI_CLASS_PROCESSOR_CO << 8)))
+			continue;
+
 		pci_read_config_dword(device, 0x04, &scratch);
 
 		if (!(scratch & 0x00100000))
@@ -3421,8 +3430,17 @@
 	 *        command registers.
 	 */
 
-	while ((device = pci_find_class(PCI_CLASS_DISPLAY_VGA << 8,
-					device)) != NULL) {
+	pci_for_each_dev(device)
+	{
+		/*
+		 *	Enable AGP devices. Most will be VGA display but
+		 *	some may be coprocessors on non VGA devices too
+		 */
+		 
+		if((((device->class >> 16) & 0xFF) != PCI_BASE_CLASS_DISPLAY) &&
+			(device->class != (PCI_CLASS_PROCESSOR_CO << 8)))
+			continue;
+
 		pci_read_config_dword(device, 0x04, &scratch);
 
 		if (!(scratch & 0x00100000))

--------------Boundary-00=_QCSEO4BKC9RU5RL7UM58
Content-Type: text/plain;
  charset="iso-8859-1";
  name="agp_find_cap-2.4.18-pre6.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="agp_find_cap-2.4.18-pre6.patch"

diff -u -X /home/helgaas/exclude -r linux-2.4.18-pre6/drivers/char/agp/agpgart_be.c build/linux-2.4.18-pre6-find_cap/drivers/char/agp/agpgart_be.c
--- linux-2.4.18-pre6/drivers/char/agp/agpgart_be.c	Wed Jan 23 10:16:39 2002
+++ build/linux-2.4.18-pre6-find_cap/drivers/char/agp/agpgart_be.c	Wed Jan 23 10:32:12 2002
@@ -410,34 +410,8 @@
 	 */
 
 
-	pci_for_each_dev(device)
-	{
-		/*
-		 *	Enable AGP devices. Most will be VGA display but
-		 *	some may be coprocessors on non VGA devices too
-		 */
-		 
-		if((((device->class >> 16) & 0xFF) != PCI_BASE_CLASS_DISPLAY) &&
-			(device->class != (PCI_CLASS_PROCESSOR_CO << 8)))
-			continue;
-
-		pci_read_config_dword(device, 0x04, &scratch);
-
-		if (!(scratch & 0x00100000))
-			continue;
-
-		pci_read_config_byte(device, 0x34, &cap_ptr);
-
-		if (cap_ptr != 0x00) {
-			do {
-				pci_read_config_dword(device,
-						      cap_ptr, &cap_id);
-
-				if ((cap_id & 0xff) != 0x02)
-					cap_ptr = (cap_id >> 8) & 0xff;
-			}
-			while (((cap_id & 0xff) != 0x02) && (cap_ptr != 0x00));
-		}
+	pci_for_each_dev(device) {
+		cap_ptr = pci_find_capability(device, PCI_CAP_ID_AGP);
 		if (cap_ptr != 0x00) {
 			/*
 			 * Ok, here we have a AGP device. Disable impossible 
@@ -506,25 +480,8 @@
 	 *        command registers.
 	 */
 
-	while ((device = pci_find_class(PCI_CLASS_DISPLAY_VGA << 8,
-					device)) != NULL) {
-		pci_read_config_dword(device, 0x04, &scratch);
-
-		if (!(scratch & 0x00100000))
-			continue;
-
-		pci_read_config_byte(device, 0x34, &cap_ptr);
-
-		if (cap_ptr != 0x00) {
-			do {
-				pci_read_config_dword(device,
-						      cap_ptr, &cap_id);
-
-				if ((cap_id & 0xff) != 0x02)
-					cap_ptr = (cap_id >> 8) & 0xff;
-			}
-			while (((cap_id & 0xff) != 0x02) && (cap_ptr != 0x00));
-		}
+	pci_for_each_dev(device) {
+		cap_ptr = pci_find_capability(device, PCI_CAP_ID_AGP);
 		if (cap_ptr != 0x00)
 			pci_write_config_dword(device, cap_ptr + 8, command);
 	}
@@ -3326,24 +3283,8 @@
 	 */
 
 
-	pci_for_each_dev(device)
-	{
-		/*
-		 *	Enable AGP devices. Most will be VGA display but
-		 *	some may be coprocessors on non VGA devices too
-		 */
-		 
-		if((((device->class >> 16) & 0xFF) != PCI_BASE_CLASS_DISPLAY) &&
-			(device->class != (PCI_CLASS_PROCESSOR_CO << 8)))
-			continue;
-
-		pci_read_config_dword(device, 0x04, &scratch);
-
-		if (!(scratch & 0x00100000))
-			continue;
-
-		pci_read_config_byte(device, 0x34, &cap_ptr);
-
+	pci_for_each_dev(device) {
+		cap_ptr = pci_find_capability(device, PCI_CAP_ID_AGP);
 		if (cap_ptr != 0x00) {
 			do {
 				pci_read_config_dword(device,
@@ -3421,25 +3362,8 @@
 	 *        command registers.
 	 */
 
-	while ((device = pci_find_class(PCI_CLASS_DISPLAY_VGA << 8,
-					device)) != NULL) {
-		pci_read_config_dword(device, 0x04, &scratch);
-
-		if (!(scratch & 0x00100000))
-			continue;
-
-		pci_read_config_byte(device, 0x34, &cap_ptr);
-
-		if (cap_ptr != 0x00) {
-			do {
-				pci_read_config_dword(device,
-						      cap_ptr, &cap_id);
-
-				if ((cap_id & 0xff) != 0x02)
-					cap_ptr = (cap_id >> 8) & 0xff;
-			}
-			while (((cap_id & 0xff) != 0x02) && (cap_ptr != 0x00));
-		}
+	pci_for_each_dev(device) {
+		cap_ptr = pci_find_capability(device, PCI_CAP_ID_AGP);
 		if (cap_ptr != 0x00)
 			pci_write_config_dword(device, cap_ptr + 8, command);
 	}
@@ -4037,20 +3961,7 @@
 #endif	/* CONFIG_AGP_SWORKS */
 
 	/* find capndx */
-	pci_read_config_dword(dev, 0x04, &scratch);
-	if (!(scratch & 0x00100000))
-		return -ENODEV;
-
-	pci_read_config_byte(dev, 0x34, &cap_ptr);
-	if (cap_ptr != 0x00) {
-		do {
-			pci_read_config_dword(dev, cap_ptr, &cap_id);
-
-			if ((cap_id & 0xff) != 0x02)
-				cap_ptr = (cap_id >> 8) & 0xff;
-		}
-		while (((cap_id & 0xff) != 0x02) && (cap_ptr != 0x00));
-	}
+	cap_ptr = pci_find_capability(dev, PCI_CAP_ID_AGP);
 	if (cap_ptr == 0x00)
 		return -ENODEV;
 	agp_bridge.capndx = cap_ptr;

--------------Boundary-00=_QCSEO4BKC9RU5RL7UM58--
