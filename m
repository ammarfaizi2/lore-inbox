Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265996AbUIVRtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265996AbUIVRtY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 13:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266137AbUIVRtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 13:49:24 -0400
Received: from peabody.ximian.com ([130.57.169.10]:26249 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S265996AbUIVRtU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 13:49:20 -0400
Subject: [patch] inotify: don't opencode the size of filename
From: Robert Love <rml@novell.com>
To: ttb@tentacle.dhs.org
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-dE1SfwC7bfnTn0H3Zxpm"
Date: Wed, 22 Sep 2004 13:48:07 -0400
Message-Id: <1095875287.5090.35.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-dE1SfwC7bfnTn0H3Zxpm
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The size of "filename" in "struct inotify_event" is currently open coded
at 256.

Change that to INOTIFY_FILENAME_MAX and replace uses of the size with
this define.

Best,

	Robert Love


--=-dE1SfwC7bfnTn0H3Zxpm
Content-Disposition: attachment; filename=inotify-filename-define-1.patch
Content-Type: text/x-patch; name=inotify-filename-define-1.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Don't opencode the size of filename. Make it a define

Signed-Off-By: Robert Love <rml@novell.com>

 drivers/char/inotify.c  |   11 +++++++----
 include/linux/inotify.h |    5 ++++-
 2 files changed, 11 insertions(+), 5 deletions(-)

diff -urN linux-inotify/drivers/char/inotify.c linux/drivers/char/inotify.c
--- linux-inotify/drivers/char/inotify.c	2004-09-22 13:45:26.697470176 -0400
+++ linux/drivers/char/inotify.c	2004-09-22 13:44:41.236381312 -0400
@@ -143,10 +143,13 @@
 	INIT_LIST_HEAD(&kevent->list);
 
 	if (filename) {
-		iprintk(INOTIFY_DEBUG_FILEN, "filename for event was %p %s\n", filename, filename);
-		strncpy (kevent->event.filename, filename, 256);
-		kevent->event.filename[255] = '\0';
-		iprintk(INOTIFY_DEBUG_FILEN, "filename after copying %s\n", kevent->event.filename);
+		iprintk(INOTIFY_DEBUG_FILEN,
+			"filename for event was %p %s\n", filename, filename);
+		strncpy (kevent->event.filename, filename,
+			 INOTIFY_FILENAME_MAX);
+		kevent->event.filename[INOTIFY_FILENAME_MAX-1] = '\0';
+		iprintk(INOTIFY_DEBUG_FILEN,
+			"filename after copying %s\n", kevent->event.filename);
 	} else {
 		iprintk(INOTIFY_DEBUG_FILEN, "no filename for event\n");
 		kevent->event.filename[0] = '\0';
diff -urN linux-inotify/include/linux/inotify.h linux/include/linux/inotify.h
--- linux-inotify/include/linux/inotify.h	2004-09-22 13:30:09.763865272 -0400
+++ linux/include/linux/inotify.h	2004-09-22 13:42:48.853466112 -0400
@@ -11,6 +11,9 @@
 
 #include <linux/limits.h>
 
+/* this size could limit things, since technically we could need PATH_MAX */
+#define INOTIFY_FILENAME_MAX	256
+
 /*
  * struct inotify_event - structure read from the inotify device for each event
  *
@@ -23,7 +26,7 @@
 struct inotify_event {
 	int wd;
 	int mask;
-	char filename[256];	/* XXX: This size may be a problem */
+	char filename[INOTIFY_FILENAME_MAX];
 };
 
 /* the following are legal, implemented events */

--=-dE1SfwC7bfnTn0H3Zxpm--

