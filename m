Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264290AbTIISfh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 14:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264286AbTIISfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 14:35:37 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:28392 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264290AbTIISfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 14:35:31 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Message-Id: <1063132494.642.9.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 09 Sep 2003 20:34:54 +0200
X-SA-Exim-Mail-From: benh@kernel.crashing.org
Subject: [PATCH] IDE: Fix request handling with ide-default & ATAPI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart & Linus !

This patch fixes a bug that happens when a request gets to the
IDE layer for a drive using ide-default (that is with no
subdriver attached), like a Power Management request. In this
case, the core will wait for the device status to match
drive->read_stat, but that field contains by default a value
that is not suitable for ATAPI devices. This patch fixes it.

Linus, please apply (already validated with Bart)

diff -urN linux-2.5/drivers/ide/ide-default.c linuxppc-2.5-benh/drivers/ide/ide-default.c
--- linux-2.5/drivers/ide/ide-default.c	2003-09-09 20:15:34.000000000 +0200
+++ linuxppc-2.5-benh/drivers/ide/ide-default.c	2003-09-09 20:05:50.000000000 +0200
@@ -57,6 +57,14 @@
 			"driver with ide.c\n", drive->name);
 		return 1;
 	}
+	
+	/* For the sake of the request layer, we must make sure we have a
+	 * correct ready_stat value, that is 0 for ATAPI devices or we will
+	 * fail any request like Power Management
+	 */
+	if (drive->media != ide_disk)
+		drive->ready_stat = 0;
+
 	return 0;
 }
 


