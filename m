Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbWEQWTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbWEQWTI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 18:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWEQWSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 18:18:05 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:1920 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751248AbWEQWMJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 18:12:09 -0400
Message-Id: <20060517221358.617565000@sous-sol.org>
References: <20060517221312.227391000@sous-sol.org>
Date: Wed, 17 May 2006 00:00:07 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, pavel@suse.cz,
       c-d.hailfinger.devel.2006@gmx.net, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 07/22] [PATCH] smbus unhiding kills thermal management
Content-Disposition: inline; filename=smbus-unhiding-kills-thermal-management.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Do not enable the SMBus device on Asus boards if suspend is used.  We do
not reenable the device on resume, leading to all sorts of undesirable
effects, the worst being a total fan failure after resume on Samsung P35
laptop.

Signed-off-by: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
Signed-off-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 drivers/pci/quirks.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- linux-2.6.16.16.orig/drivers/pci/quirks.c
+++ linux-2.6.16.16/drivers/pci/quirks.c
@@ -861,6 +861,7 @@ static void __init quirk_eisa_bridge(str
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82375,	quirk_eisa_bridge );
 
+#ifndef CONFIG_ACPI_SLEEP
 /*
  * On ASUS P4B boards, the SMBus PCI Device within the ICH2/4 southbridge
  * is not activated. The myth is that Asus said that they do not want the
@@ -872,8 +873,12 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_I
  * bridge. Unfortunately, this device has no subvendor/subdevice ID. So it 
  * becomes necessary to do this tweak in two steps -- I've chosen the Host
  * bridge as trigger.
+ *
+ * Actually, leaving it unhidden and not redoing the quirk over suspend2ram
+ * will cause thermal management to break down, and causing machine to
+ * overheat.
  */
-static int __initdata asus_hides_smbus = 0;
+static int __initdata asus_hides_smbus;
 
 static void __init asus_hides_smbus_hostbridge(struct pci_dev *dev)
 {
@@ -1008,6 +1013,8 @@ static void __init asus_hides_smbus_lpc_
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1,	asus_hides_smbus_lpc_ich6 );
 
+#endif
+
 /*
  * SiS 96x south bridge: BIOS typically hides SMBus device...
  */

--
