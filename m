Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265994AbRGHBEo>; Sat, 7 Jul 2001 21:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266606AbRGHBEf>; Sat, 7 Jul 2001 21:04:35 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:46558 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S265994AbRGHBEW>; Sat, 7 Jul 2001 21:04:22 -0400
Date: Sat, 7 Jul 2001 18:04:14 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
To: stelian.pop@fr.alcove.com, m.ashley@unsw.edu.au, jun1m@mars.dti.ne.jp,
        t-kinjo@tc4.so-net.ne.jp, tridge@valinux.com
Cc: linux-kernel@vger.kernel.org
Subject: PATCH: linux-2.4.7-pre3/drivers/char/sonypi.c would hang some non-Sony notebooks
Message-ID: <20010707180414.A3456@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	The pci_device_id tables in linux-2.4.7-pre3/drivers/char/sonypi.c
claims that the driver wants to be loaded on all computers that have
an that have a PCI device with vendor id PCI_VENDOR_ID_INTEL and
a device ID of either PCI_DEVICE_ID_INTEL_82371AB_3 (0x7110) or
PCI_DEVICE_ID_INTEL_82801BA_10 (0x244c).  My Kapok 1100m notebook
computer has an Intel 82371ab, so the sonypi module automatically
loads at boot time and hangs the computer.

	sonypi_init_module needs to do some kind of test to figure out
if it is on a Sony Vaio and abort otherwise.  Looking at the result of
"lspci -v" on my Sony Vaio Picturebook, I see that, while none of the
PCI devices have Sony's vendor ID, a number of them have Sony's
vendor ID as their subsystem vendor ID's.  So, I have implemented the
following test to cause sonypi only to be loadable on machines that
have at least one PCI device that has a subsystem vendor ID of
PCI_VENDOR_ID_SONY.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sony.patch"

--- linux-2.4.7-pre3/drivers/char/sonypi.c	Sat Jul  7 18:00:12 2001
+++ linux/drivers/char/sonypi.c	Sat Jul  7 18:00:28 2001
@@ -690,7 +690,11 @@
 };
 
 static int __init sonypi_init_module(void) {
-	return pci_module_init(&sonypi_driver);
+	if (pci_find_subsys(PCI_ANY_ID, PCI_ANY_ID,
+			    PCI_VENDOR_ID_SONY, PCI_ANY_ID, NULL) != NULL)
+		return pci_module_init(&sonypi_driver);
+	else
+		return -ENODEV;
 }
 
 static void __exit sonypi_cleanup_module(void) {

--BXVAT5kNtrzKuDFl--
