Return-Path: <linux-kernel-owner+willy=40w.ods.org-S771148AbUKBFA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S771148AbUKBFA5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 00:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S321588AbUKAWmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 17:42:03 -0500
Received: from peabody.ximian.com ([130.57.169.10]:18334 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S279930AbUKAUbI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 15:31:08 -0500
Subject: [patch] inotify: idr stuff
From: Robert Love <rml@novell.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1099330316.12182.2.camel@vertex>
References: <1099330316.12182.2.camel@vertex>
Content-Type: text/plain
Date: Mon, 01 Nov 2004 15:28:48 -0500
Message-Id: <1099340928.31022.46.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John.

MAX_ID_MASK is already set to the maximum IDR value, so we don't need to
add IDR_MAX_ID.  I know this was my idea--I was, uh, being
metaphoric. :)

Plus, MAX_ID_MASK is computed based on IDR_BITS, so it is "always
right."

Also add an IWATCHES_HARD_LIMIT, set to MAX_ID_MASK, instead of using
MAX_ID_MASK directly.

Finally, this uncovers that idr.h is not protected against double
inclusion, so wrap it in ifndef's.

Best,

	Robert Love


idr stuff

Signed-Off-By: Robert Love <rml@novell.com>

 include/asm-i386/resource.h |    4 ++--
 include/linux/idr.h         |    5 ++++-
 include/linux/inotify.h     |    4 +++-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff -urN linux-2.6.10-rc1-inotify/include/asm-i386/resource.h linux/include/asm-i386/resource.h
--- linux-2.6.10-rc1-inotify/include/asm-i386/resource.h	2004-11-01 15:04:29.307122792 -0500
+++ linux/include/asm-i386/resource.h	2004-11-01 15:21:33.374440896 -0500
@@ -18,7 +18,7 @@
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
 #define RLIMIT_SIGPENDING 11		/* max number of pending signals */
 #define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
-#define RLIMIT_IWATCHES 13 /* maximum number of inotify watches */
+#define RLIMIT_IWATCHES 13		/* maximum number of inotify watches */
 
 #define RLIM_NLIMITS	14
 
@@ -46,7 +46,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
 	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
-	{ IWATCHES_SOFT_LIMIT, IDR_MAX_ID },		\
+	{ IWATCHES_SOFT_LIMIT, IWATCHES_HARD_LIMIT },	\
 }
 
 #endif /* __KERNEL__ */
diff -urN linux-2.6.10-rc1-inotify/include/linux/idr.h linux/include/linux/idr.h
--- linux-2.6.10-rc1-inotify/include/linux/idr.h	2004-11-01 15:04:28.453252600 -0500
+++ linux/include/linux/idr.h	2004-11-01 15:24:01.538916472 -0500
@@ -1,3 +1,5 @@
+#ifndef _LINUX_IDR_H
+#define _LINUX_IDR_H
 /*
  * include/linux/idr.h
  * 
@@ -29,7 +31,6 @@
 # error "BITS_PER_LONG is not 32 or 64"
 #endif
 
-#define IDR_MAX_ID 0x7fffffff
 #define IDR_SIZE (1 << IDR_BITS)
 #define IDR_MASK ((1 << IDR_BITS)-1)
 
@@ -77,3 +78,5 @@
 int idr_get_new_above(struct idr *idp, void *ptr, int starting_id, int *id);
 void idr_remove(struct idr *idp, int id);
 void idr_init(struct idr *idp);
+
+#endif	/* _LINUX_IDR_H */
diff -urN linux-2.6.10-rc1-inotify/include/linux/inotify.h linux/include/linux/inotify.h
--- linux-2.6.10-rc1-inotify/include/linux/inotify.h	2004-11-01 15:04:28.684217488 -0500
+++ linux/include/linux/inotify.h	2004-11-01 15:21:48.714108912 -0500
@@ -72,8 +72,10 @@
 #include <linux/dcache.h>
 #include <linux/fs.h>
 #include <linux/config.h>
+#include <linux/idr.h>
 
-#define IWATCHES_SOFT_LIMIT 16384
+#define IWATCHES_SOFT_LIMIT	16384
+#define IWATCHES_HARD_LIMIT	MAX_ID_MASK
 
 struct inotify_inode_data {
 	struct list_head watches;



