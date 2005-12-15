Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965178AbVLOIzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965178AbVLOIzT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 03:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965181AbVLOIzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 03:55:19 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:13242 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965178AbVLOIzR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 03:55:17 -0500
Date: Thu, 15 Dec 2005 08:55:16 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org
Subject: [PATCH 2/3] m68k: compile fix - ADBREQ_RAW missing declaration
Message-ID: <20051215085516.GU27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

another compile fix, pulled straight from m68k CVS

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 drivers/macintosh/adb.c |    8 +++++---
 include/linux/adb.h     |    1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

d39fe026c456804272741a7c62ae380257e9a879
diff --git a/drivers/macintosh/adb.c b/drivers/macintosh/adb.c
index d2ead17..6b7591e 100644
--- a/drivers/macintosh/adb.c
+++ b/drivers/macintosh/adb.c
@@ -476,13 +476,15 @@ adb_request(struct adb_request *req, voi
 		use_sreq = 1;
 	} else
 		use_sreq = 0;
-	req->nbytes = nbytes+1;
+	i = (flags & ADBREQ_RAW) ? 0 : 1;
+	req->nbytes = nbytes+i;
 	req->done = done;
 	req->reply_expected = flags & ADBREQ_REPLY;
 	req->data[0] = ADB_PACKET;
 	va_start(list, nbytes);
-	for (i = 0; i < nbytes; ++i)
-		req->data[i+1] = va_arg(list, int);
+	while (i < req->nbytes) {
+		req->data[i++] = va_arg(list, int);
+	}
 	va_end(list);
 
 	if (flags & ADBREQ_NOSEND)
diff --git a/include/linux/adb.h b/include/linux/adb.h
index e9fdc63..aad7b1c 100644
--- a/include/linux/adb.h
+++ b/include/linux/adb.h
@@ -76,6 +76,7 @@ struct adb_driver {
 #define ADBREQ_REPLY	1	/* expect reply */
 #define ADBREQ_SYNC	2	/* poll until done */
 #define ADBREQ_NOSEND	4	/* build the request, but don't send it */
+#define ADBREQ_RAW	8	/* send raw packet (don't prepend ADB_PACKET) */
 
 /* Messages sent thru the client_list notifier. You should NOT stop
    the operation, at least not with this version */
-- 
0.99.9.GIT

