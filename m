Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262070AbULPXcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbULPXcL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 18:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbULPXcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 18:32:10 -0500
Received: from gold.muskoka.com ([216.123.107.5]:9421 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id S262070AbULPXb5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 18:31:57 -0500
Message-ID: <41C21086.7030703@muskoka.com>
Date: Thu, 16 Dec 2004 17:47:34 -0500
From: Paul Gortmaker <penguin@muskoka.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030425
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.9 ide-probe and indentical old disks.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It seems that some old disks don't have a serial number, but ide-probe
now compares serial numbers to determine if a slave disk is just a
ghost image of the primary.  This breaks old hardware that has two
identical model disks which don't report serial numbers.  The fix seems
as simple as checking for zero length serial numbers before comparing.

Signed-off-by: Paul Gortmaker <p_gortmaker@yahoo.com>



--- linux-386/drivers/ide/ide-probe.c~	Mon Oct 18 17:56:33 2004
+++ linux-386/drivers/ide/ide-probe.c	Thu Dec  9 14:15:56 2004
@@ -740,6 +740,8 @@ static void probe_hwif(ide_hwif_t *hwif)
 			if (strcmp(hwif->drives[0].id->model, drive->id->model) == 0 &&
 			    /* Don't do this for noprobe or non ATA */
 			    strcmp(drive->id->model, "UNKNOWN") &&
+			    /* Or for old drives without a serial # */
+			    strlen(drive->id->serial_no) &&
 			    /* And beware of confused Maxtor drives that go "M0000000000"
 			      "The SN# is garbage in the ID block..." [Eric] */
 			    strncmp(drive->id->serial_no, "M0000000000000000000", 20) &&



