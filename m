Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261960AbULGXnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbULGXnf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 18:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbULGXnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 18:43:35 -0500
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:6278 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S261960AbULGXnP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 18:43:15 -0500
From: David Brownell <david-b@pacbell.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [path 2.6] reduce ext3 log spamming (blank lines)
Date: Tue, 7 Dec 2004 15:01:15 -0800
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_7YjtBrPaIGyALTx"
Message-Id: <200412071501.15815.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_7YjtBrPaIGyALTx
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

When drives go offline, e.g. usb-storage disconnect, the
upper layers don't behave very intelligently yet:  ext3
over scsi keeps retrying reads, logging three lines for
each error:

10:58:31  scsi0 (0:0): rejecting I/O to dead device
10:58:31  EXT3-fs error (device sda1): ext3_find_entry: reading directory #18089296 offset 0
10:58:31  
10:58:55  scsi0 (0:0): rejecting I/O to dead device
10:58:55  EXT3-fs error (device sda1): ext3_find_entry: reading directory #18089296 offset 0
10:58:55  
10:59:30  scsi0 (0:0): rejecting I/O to dead device
10:59:30  EXT3-fs error (device sda1): ext3_find_entry: reading directory #18089296 offset 0
10:59:30  
10:59:30  scsi0 (0:0): rejecting I/O to dead device
10:59:30  EXT3-fs error (device sda1): ext3_find_entry: reading directory #18089296 offset 0
10:59:30  
10:59:30  scsi0 (0:0): rejecting I/O to dead device
10:59:30  EXT3-fs error (device sda1): ext3_find_entry: reading directory #18089296 offset 0
10:59:30  
10:59:32  scsi0 (0:0): rejecting I/O to dead device
10:59:32  EXT3-fs error (device sda1): ext3_find_entry: reading directory #18089296 offset 0
10:59:32  
10:59:32  scsi0 (0:0): rejecting I/O to dead device
10:59:32  EXT3-fs error (device sda1): ext3_find_entry: reading directory #18089296 offset 0
10:59:32  
10:59:33  scsi0 (0:0): rejecting I/O to dead device
10:59:33  EXT3-fs error (device sda1): ext3_find_entry: reading directory #18089296 offset 0
10:59:33  
10:59:47  scsi0 (0:0): rejecting I/O to dead device
10:59:47  EXT3-fs error (device sda1): ext3_find_entry: reading directory #18089296 offset 0
10:59:47  
10:59:48  scsi0 (0:0): rejecting I/O to dead device
10:59:48  EXT3-fs error (device sda1): ext3_find_entry: reading directory #18089296 offset 0
10:59:48  
10:59:49  scsi0 (0:0): rejecting I/O to dead device
10:59:49  EXT3-fs error (device sda1): ext3_find_entry: reading directory #18089296 offset 0
10:59:49  
11:00:07  scsi0 (0:0): rejecting I/O to dead device
11:00:07  EXT3-fs error (device sda1): ext3_find_entry: reading directory #18089296 offset 0
11:00:07  

This patch shrinks that log spam by the trivial third, getting
rid of those needless blank lines.  It's not clear to me why
the "no such device" errors don't immediately make ext3
(or is it the block layer?) give up ... maybe someone else
can make Linux not retry after those errors.

- Dave


--Boundary-00=_7YjtBrPaIGyALTx
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ext3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ext3.patch"

Prevent one ext3 error report from spamming dmesg/syslog with blank lines;
ext3_error() already includes the necessary newline.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- 1.59/fs/ext3/namei.c	Tue Oct 19 02:40:30 2004
+++ edited/fs/ext3/namei.c	Tue Dec  7 14:28:10 2004
@@ -872,7 +872,7 @@
 		if (!buffer_uptodate(bh)) {
 			/* read error, skip block & hope for the best */
 			ext3_error(sb, __FUNCTION__, "reading directory #%lu "
-				   "offset %lu\n", dir->i_ino, block);
+				   "offset %lu", dir->i_ino, block);
 			brelse(bh);
 			goto next;
 		}

--Boundary-00=_7YjtBrPaIGyALTx--
