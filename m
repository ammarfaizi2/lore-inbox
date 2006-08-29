Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbWH2IH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWH2IH4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 04:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWH2IH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 04:07:56 -0400
Received: from natlemon.rzone.de ([81.169.145.170]:11973 "EHLO
	natlemon.rzone.de") by vger.kernel.org with ESMTP id S1751227AbWH2IHz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 04:07:55 -0400
Date: Tue, 29 Aug 2006 10:07:38 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] exit early in floppy_init when no floppy exists
Message-ID: <20060829080738.GA22708@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


modprobe -v floppy on a Apple G5 writes incorrect stuff to dmesg:

Floppy drive(s): fd0 is 2.88M

The reason is that the legacy io check happens very late,
when part of the floppy stuff is already initialized.
check_legacy_ioport() returns either -ENODEV right away, or it walks
the device-tree looking for a floppy node.


Signed-off-by: Olaf Hering <olaf@aepfle.de>

---

Can this go into 2.6.18 please? Our installer parses dmesg to find
floppy devices. Dont ask....




 drivers/block/floppy.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

Index: linux-2.6.18-rc4/drivers/block/floppy.c
===================================================================
--- linux-2.6.18-rc4.orig/drivers/block/floppy.c
+++ linux-2.6.18-rc4/drivers/block/floppy.c
@@ -4177,6 +4177,11 @@ static int __init floppy_init(void)
 	int i, unit, drive;
 	int err, dr;
 
+#if defined(CONFIG_PPC_MERGE)
+	if (check_legacy_ioport(FDC1))
+		return -ENODEV;
+#endif
+
 	raw_cmd = NULL;
 
 	for (dr = 0; dr < N_DRIVE; dr++) {
@@ -4234,13 +4239,6 @@ static int __init floppy_init(void)
 	}
 
 	use_virtual_dma = can_use_virtual_dma & 1;
-#if defined(CONFIG_PPC_MERGE)
-	if (check_legacy_ioport(FDC1)) {
-		del_timer(&fd_timeout);
-		err = -ENODEV;
-		goto out_unreg_region;
-	}
-#endif
 	fdc_state[0].address = FDC1;
 	if (fdc_state[0].address == -1) {
 		del_timer(&fd_timeout);
