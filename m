Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264742AbSJ3Qwk>; Wed, 30 Oct 2002 11:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264740AbSJ3Qwk>; Wed, 30 Oct 2002 11:52:40 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:21131 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264741AbSJ3Qwh>;
	Wed, 30 Oct 2002 11:52:37 -0500
Date: Wed, 30 Oct 2002 08:58:44 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: [PATCH] 2.5 current bk fix setting scsi queue depths
Message-ID: <20021030085844.A11040@eng2.beaverton.ibm.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi -

This patch fixes a problem with the current linus bk tree setting
scsi queue depths to 1. Please apply.

Without the patch:

[patman@elm3a50 patman]$ cat /proc/scsi/sg/device_hdr /proc/scsi/sg/devices
host    chan    id      lun     type    opens   qdepth  busy    online
0       0       0       0       0       2       1       0       1
0       0       1       0       0       1       1       0       1
0       0       15      0       3       0       1       0       1

With the patch:

[patman@elm3a50 patman]$ cat /proc/scsi/sg/device_hdr /proc/scsi/sg/devices
host    chan    id      lun     type    opens   qdepth  busy    online
0       0       0       0       0       2       253     0       1
0       0       1       0       0       1       253     0       1
0       0       15      0       3       0       2       0       1


--- 1.51/drivers/scsi/scsi.c	Tue Oct 29 01:03:27 2002
+++ edited/drivers/scsi/scsi.c	Wed Oct 30 08:36:23 2002
@@ -1511,7 +1511,6 @@
 		kfree((char *) SCpnt);
 	}
 	SDpnt->current_queue_depth = 0;
-	SDpnt->new_queue_depth = 0;
 	spin_unlock_irqrestore(&device_request_lock, flags);
 }
 
-- Patrick Mansfield
