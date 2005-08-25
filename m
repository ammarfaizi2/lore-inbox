Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbVHYFXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbVHYFXm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 01:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbVHYFXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 01:23:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12492 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S964821AbVHYFW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 01:22:26 -0400
To: geert@linux-m68k.org, torvalds@osdl.org
Subject: [PATCH] (22/22) ADBREQ_RAW missing declaration
Cc: linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Message-Id: <E1E8AF1-0005fA-Sq@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Thu, 25 Aug 2005 06:25:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pulled from m68k CVS; ADBREQ_RAW is used in arch/m68k/mac/misc.c, but its
declaration had not been propagated to Linus' tree yet.  Related chunk in
drivers/macintosh/adb.c also pulled in; even though the file is shared with
ppc, behaviour is changed only for m68k.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc7-m68k-flags/drivers/macintosh/adb.c RC13-rc7-m68k-adb.patch/drivers/macintosh/adb.c
--- RC13-rc7-m68k-flags/drivers/macintosh/adb.c	2005-08-10 10:37:49.000000000 -0400
+++ RC13-rc7-m68k-adb.patch/drivers/macintosh/adb.c	2005-08-25 00:54:21.000000000 -0400
@@ -476,13 +476,15 @@
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
diff -urN RC13-rc7-m68k-flags/include/linux/adb.h RC13-rc7-m68k-adb.patch/include/linux/adb.h
--- RC13-rc7-m68k-flags/include/linux/adb.h	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc7-m68k-adb.patch/include/linux/adb.h	2005-08-25 00:54:21.000000000 -0400
@@ -76,6 +76,7 @@
 #define ADBREQ_REPLY	1	/* expect reply */
 #define ADBREQ_SYNC	2	/* poll until done */
 #define ADBREQ_NOSEND	4	/* build the request, but don't send it */
+#define ADBREQ_RAW	8	/* send raw packet (don't prepend ADB_PACKET) */
 
 /* Messages sent thru the client_list notifier. You should NOT stop
    the operation, at least not with this version */
