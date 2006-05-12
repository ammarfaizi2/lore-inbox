Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbWELJy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWELJy3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 05:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbWELJy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 05:54:29 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:61072 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751100AbWELJy2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 05:54:28 -0400
Date: Fri, 12 May 2006 11:53:45 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>,
       trenn@suse.de, thoenig@suse.de, c-d.hailfinger.devel.2006@gmx.net
Subject: [patch] smbus unhiding kills thermal management
Message-ID: <20060512095343.GA28375@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do not enable the SMBus device on Asus boards if suspend
is used. We do not reenable the device on resume, leading to all sorts
of undesirable effects, the worst being a total fan failure after
resume on Samsung P35 laptop.

Signed-off-by: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit f14c852a8cb7483ce0e1e0e05ef49fed2f67103b
tree ab0cbe41b344a62bc81dd5cb093e3b6062c12556
parent 392dbe84f1e484b1e48036ca266cb826fd34f8da
author <pavel@amd.ucw.cz> Fri, 12 May 2006 11:50:00 +0200
committer <pavel@amd.ucw.cz> Fri, 12 May 2006 11:50:00 +0200

 drivers/pci/quirks.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 19e2b17..9c5509f 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -895,6 +895,7 @@ static void __init k8t_sound_hostbridge(
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8237, k8t_sound_hostbridge);
 
+#ifndef CONFIG_ACPI_SLEEP
 /*
  * On ASUS P4B boards, the SMBus PCI Device within the ICH2/4 southbridge
  * is not activated. The myth is that Asus said that they do not want the
@@ -906,8 +907,12 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_V
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
@@ -1050,6 +1055,8 @@ static void __init asus_hides_smbus_lpc_
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1,	asus_hides_smbus_lpc_ich6 );
 
+#endif
+
 /*
  * SiS 96x south bridge: BIOS typically hides SMBus device...
  */

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
