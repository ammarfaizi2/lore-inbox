Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263715AbTDXPgS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 11:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263723AbTDXPgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 11:36:18 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:8586 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263715AbTDXPgQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 11:36:16 -0400
Date: Thu, 24 Apr 2003 17:47:58 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jens Axboe <axboe@suse.de>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.68 fix mismatched access_ok() checks in sg_io()
In-Reply-To: <20030424082331.GE8775@suse.de>
Message-ID: <Pine.SOL.4.30.0304241742060.19564-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've found this while doing bio_map_user() changes,
please forward to Linus.

--
Bartlomiej

--- linux-2.5.68/drivers/block/scsi_ioctl.c	Sun Apr 20 04:51:16 2003
+++ linux/drivers/block/scsi_ioctl.c	Thu Apr 24 17:36:15 2003
@@ -183,9 +183,11 @@
 		}

 		uaddr = (unsigned long) hdr.dxferp;
-		if (writing && !access_ok(VERIFY_WRITE, uaddr, bytes))
+		/* writing to device -> reading from vm */
+		if (writing && !access_ok(VERIFY_READ, uaddr, bytes))
 			return -EFAULT;
-		else if (reading && !access_ok(VERIFY_READ, uaddr, bytes))
+		/* reading from device -> writing to vm */
+		else if (reading && !access_ok(VERIFY_WRITE, uaddr, bytes))
 			return -EFAULT;

 		/*

