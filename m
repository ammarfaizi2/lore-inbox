Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758938AbWLDRhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758938AbWLDRhU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 12:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758916AbWLDRhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 12:37:20 -0500
Received: from smtp-101-monday.noc.nerim.net ([62.4.17.101]:2977 "EHLO
	mallaury.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758938AbWLDRhS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 12:37:18 -0500
Date: Mon, 4 Dec 2006 18:37:15 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Alan <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: reenable Asus SMBus quirks on resume
Message-Id: <20061204183715.fd710e55.khali@linux-fr.org>
In-Reply-To: <20061204131409.4734fa73@localhost.localdomain>
References: <20061114175510.6e7c7119@localhost.localdomain>
	<20061204135137.f2877516.khali@linux-fr.org>
	<20061204131409.4734fa73@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

On Mon, 4 Dec 2006 13:14:09 +0000, Alan wrote:
> On Mon, 4 Dec 2006 13:51:37 +0100 Jean Delvare wrote:
> > Any progress on this? I'd like to see this patch in -mm so that it gets
> > wider testing. One thing that needs to be fixed is that the Asus SMBus
> > quirks are currently ifdef'd out when suspend support (ACPI sleep
> > states) is enabled, so this part of the patch is not actually doing
> > anything. Alan, could you please fix this and resend the patch to
> > Andrew?
> 
> The patch is already merged with the -mm tree. If you want to improve on
> it and fix the SMBus stuff then send Andrew a patch on top of 2.6.19-mm.

Oops, my bad, you're right. I looked at the wrong file...

So, here is a cumulative patch that applies on top of yours. Andrew, can
you please include it in your tree (right after
pci-fix-multiple-problems-with-via-hardware-warning-fix.patch)? Thanks.

* * * * *

Now that PCI quirks are replayed on software resume, we can safely
re-enable the Asus SMBus unhiding quirk even when software suspend
support is enabled.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
---
 drivers/pci/quirks.c |    7 -------
 1 file changed, 7 deletions(-)

--- linux-2.6.19-git.orig/drivers/pci/quirks.c	2006-12-04 16:27:35.000000000 +0100
+++ linux-2.6.19-git/drivers/pci/quirks.c	2006-12-04 18:30:01.000000000 +0100
@@ -926,7 +926,6 @@
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8237, k8t_sound_hostbridge);
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8237, k8t_sound_hostbridge);
 
-#ifndef CONFIG_ACPI_SLEEP
 /*
  * On ASUS P4B boards, the SMBus PCI Device within the ICH2/4 southbridge
  * is not activated. The myth is that Asus said that they do not want the
@@ -938,10 +937,6 @@
  * bridge. Unfortunately, this device has no subvendor/subdevice ID. So it 
  * becomes necessary to do this tweak in two steps -- I've chosen the Host
  * bridge as trigger.
- *
- * Actually, leaving it unhidden and not redoing the quirk over suspend2ram
- * will cause thermal management to break down, and causing machine to
- * overheat.
  */
 static int __initdata asus_hides_smbus;
 
@@ -1099,8 +1094,6 @@
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1,	asus_hides_smbus_lpc_ich6 );
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1,	asus_hides_smbus_lpc_ich6 );
 
-#endif
-
 /*
  * SiS 96x south bridge: BIOS typically hides SMBus device...
  */


-- 
Jean Delvare
