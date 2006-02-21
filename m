Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161406AbWBUGdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161406AbWBUGdf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 01:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161415AbWBUGdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 01:33:35 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:41191 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1161406AbWBUGde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 01:33:34 -0500
Message-ID: <43FAB3B2.1040108@jp.fujitsu.com>
Date: Tue, 21 Feb 2006 15:31:14 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       akpm@osdl.org, greg@kroah.com
CC: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, ak@suse.de,
       rmk+lkml@arm.linux.org.uk
Subject: [PATCH 4/6] PCI legacy I/O port free driver (take2) - Update Documentation/pci.txt
References: <43FAB283.8090206@jp.fujitsu.com>
In-Reply-To: <43FAB283.8090206@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the description about legacy I/O port free driver into
Documentation/pci.txt.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

 Documentation/pci.txt |   50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 50 insertions(+)

Index: linux-2.6.16-rc4/Documentation/pci.txt
===================================================================
--- linux-2.6.16-rc4.orig/Documentation/pci.txt	2006-02-21 14:40:46.000000000 +0900
+++ linux-2.6.16-rc4/Documentation/pci.txt	2006-02-21 14:40:56.000000000 +0900
@@ -81,6 +81,8 @@
 	class,		Device class to match. The class_mask tells which bits
 	class_mask	of the class are honored during the comparison.
 	driver_data	Data private to the driver.
+	device_flags	Per device id flags. See mod_devicetable.h for
+			specific.
 
 Most drivers don't need to use the driver_data field.  Best practice
 for use of driver_data is to use it as an index into a static list of
@@ -269,3 +271,51 @@
 pci_find_device()		Superseded by pci_get_device()
 pci_find_subsys()		Superseded by pci_get_subsys()
 pci_find_slot()			Superseded by pci_get_slot()
+
+
+9. Legacy I/O port free driver
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+On the large servers, I/O port resources could not be assigned to all
+PCI devices because it is limited (64KB on Intel Architecture[1]) and
+it would be fragmented (I/O base register of PCI-to-PCI bridge will
+usually be aligned to a 4KB boundary[2]). On such systems,
+pci_enable_device() and pci_request_regions() for those devices will
+fail because those functions try to enable all the regions. However,
+it is a problem for some PCI devices which provide both I/O port and
+MMIO interface because some of them can be handled without using I/O
+port interface. The reason why such devices provide I/O port interface
+is for compatibility to legacy OSs. So this kind of devices should
+work even if enough I/O port resources are not assigned. The "PCI
+Local Bus Specification Revision 3.0" also mentions about this topic
+(Please see p.44, "IMPLEMENTATION NOTE").
+
+This problem is solved by telling the kernel if your driver needs to
+use I/O port to handle the device. If your driver doesn't need any I/O
+port regions to handle the device, you can tell it to the kernel by
+setting PCI_DEVICE_ID_FLAG_NOIOPORT flag in the ID table like below:
+
+	struct pci_device_id your_id_table {
+		...,
+		{
+			...,
+			.device_flags = PCI_DEVICE_ID_FLAG_NOIOPORT,
+			...,
+		},
+		...,
+	}
+
+If the PCI_DEVICE_ID_FLAG_NOIOPORT flag is set, kernel will never
+touch the I/O port regions for the corresponding devices.
+
+By using ID table, you can tell the kernel whether to use I/O port by
+per device ID basis. However, some drivers might need to check other
+information than in table ID (e.g. revision ID) to see if they need to
+use I/O port. In this case, you can use the no_ioport flag in struct
+pci_dev. If the no_ioport flag is set, kernel will never touch I/O
+port regions for the device. You would check some information to see
+if your device needs I/O port, and you would set the no_ioport flag as
+necessary. Please note that you need to set the no_ioport flag before
+calling pci_enable_device() and pci_request_regions().
+
+[1] Some systems support 64KB I/O port space per PCI segment.
+[2] Some PCI-to-PCI bridges support optional 1KB aligned I/O base.


