Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263580AbTEDKDg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 06:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263584AbTEDKDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 06:03:36 -0400
Received: from AMarseille-201-1-1-131.abo.wanadoo.fr ([193.252.38.131]:10279
	"EHLO gaston") by vger.kernel.org with ESMTP id S263580AbTEDKDe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 06:03:34 -0400
Subject: [PATCH] Workaround bogus CF cards
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052043277.4107.76.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 04 May 2003 12:14:37 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I had a problem with an "APACER" Compact Flash card. It seems that
beast is allergic to WIN_READ_NATIVE_MAX.

I hacked this workaround that appear to work fine

--- a/drivers/ide/ide-disk.c	Sun May  4 12:11:52 2003
+++ b/drivers/ide/ide-disk.c	Sun May  4 12:11:52 2003
@@ -1160,12 +1160,16 @@
 {
 	struct hd_driveid *id = drive->id;
 	unsigned long capacity = drive->cyl * drive->head * drive->sect;
-	unsigned long set_max = idedisk_read_native_max_address(drive);
+	unsigned long set_max = 0;
 	unsigned long long capacity_2 = capacity;
 	unsigned long long set_max_ext;
 
 	drive->capacity48 = 0;
 	drive->select.b.lba = 0;
+
+	/* That stupid compact flash doesn't like the command */
+	if (strncmp(drive->id->model, "APACER_CF_", 10) != 0)
+		set_max = idedisk_read_native_max_address(drive);
 
 	(void) idedisk_supports_host_protected_area(drive);
 

