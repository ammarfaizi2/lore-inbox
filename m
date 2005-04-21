Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbVDUXqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbVDUXqk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 19:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbVDUXqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 19:46:40 -0400
Received: from peabody.ximian.com ([130.57.169.10]:42218 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261439AbVDUXqh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 19:46:37 -0400
Subject: [patch] oneshot for inotify.
From: Robert Love <rml@novell.com>
To: John McCutchan <ttb@tentacle.dhs.org>, linux-kernel@vger.kernel.org
Cc: Jeremy Allison <jra@samba.org>, Tridge <tridge@samba.org>,
       Keynote Morton <akpm@osdl.org>
In-Reply-To: <1114060434.6913.26.camel@jenny.boston.ximian.com>
References: <1114060434.6913.26.camel@jenny.boston.ximian.com>
Content-Type: text/plain
Date: Thu, 21 Apr 2005 19:47:21 -0400
Message-Id: <1114127241.6973.30.camel@jenny.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Samba guys want dnotify-like oneshot/multishot support.

That is not hard to add, so the following patch adds "oneshot" support
to inotify.  If IN_ONESHOT is set on a watch, the watch is automatically
removed after the first event.  Default behavior remains "multishot."

Best,

	Robert Love


Signed-off-by: Robert Love <rml@novell.com>

 fs/inotify.c            |    2 ++
 include/linux/inotify.h |    7 ++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff -urN linux-2.6.12-rc3-inotify/fs/inotify.c linux/fs/inotify.c
--- linux-2.6.12-rc3-inotify/fs/inotify.c	2005-04-21 19:40:44.000000000 -0400
+++ linux/fs/inotify.c	2005-04-21 19:37:24.000000000 -0400
@@ -509,6 +509,8 @@
 			struct inotify_device *dev = watch->dev;
 			down(&dev->sem);
 			inotify_dev_queue_event(dev, watch, mask, cookie, name);
+			if (watch->mask & IN_ONESHOT)
+				remove_watch_no_event(watch, dev);
 			up(&dev->sem);
 		}
 	}
diff -urN linux-2.6.12-rc3-inotify/include/linux/inotify.h linux/include/linux/inotify.h
--- linux-2.6.12-rc3-inotify/include/linux/inotify.h	2005-04-21 19:40:44.000000000 -0400
+++ linux/include/linux/inotify.h	2005-04-21 19:37:25.000000000 -0400
@@ -49,11 +49,12 @@
 #define IN_DELETE_SELF		0x00001000	/* Self was deleted */
 #define IN_UNMOUNT		0x00002000	/* Backing fs was unmounted */
 #define IN_Q_OVERFLOW		0x00004000	/* Event queued overflowed */
-#define IN_IGNORED		0x00008000	/* File was ignored */
 
 /* special flags */
-#define IN_ALL_EVENTS		0xffffffff	/* All the events */
-#define IN_CLOSE		(IN_CLOSE_WRITE | IN_CLOSE_NOWRITE)
+#define IN_IGNORED		0x00008000	/* File was ignored */
+#define IN_ONESHOT		0x80000000	/* only send event once */
+#define IN_ALL_EVENTS		(0xffffffff & ~IN_ONESHOT) /* All the events */
+#define IN_CLOSE		(IN_CLOSE_WRITE | IN_CLOSE_NOWRITE) /* close */
 
 #define INOTIFY_IOCTL_MAGIC	'Q'
 #define INOTIFY_IOCTL_MAXNR	2


