Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312601AbSF2XCc>; Sat, 29 Jun 2002 19:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313867AbSF2XCb>; Sat, 29 Jun 2002 19:02:31 -0400
Received: from maile.telia.com ([194.22.190.16]:43740 "EHLO maile.telia.com")
	by vger.kernel.org with ESMTP id <S312601AbSF2XCa>;
	Sat, 29 Jun 2002 19:02:30 -0400
Message-Id: <200206292304.g5TN4mH21698@d1o849.telia.com>
Content-Type: text/plain; charset=US-ASCII
From: Jakob Kemi <jakob.kemi@telia.com>
To: marcelo@conectiva.com.br
Subject: [PATCH] w9966 egcs compile fix
Date: Sun, 30 Jun 2002 01:03:07 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo!

This patch fixes a compile error in w9966.c with egcs (spotted by Rolf Fokkens)
I also corrected the behavior in w9966_v4l_read() when too much data is
requested data size. It does now return bytes actually read instead of an error
code.
Please apply before 2.4.19 final.

Cheers,
	Jakob

--- w9966.c.2.4.19-rc1	Sat Jun 29 14:23:41 2002
+++ w9966.c	Sat Jun 29 14:50:01 2002
@@ -50,23 +50,23 @@
 #include <linux/types.h>
 #include <linux/slab.h>
 
-//#define DEBUG				// Uncomment for debug output.
+//#define DEBUG				// Define for debug output.
 
 #ifdef DEBUG
 #   define DPRINTF(f, a...)						\
-	do {								\
-		printk ("%s%s, %d (DEBUG) %s(): ",			\
-			KERN_DEBUG, __FILE__, __LINE__, __func__);	\
-		printk (f, ##a);					\
-	} while (0)
+        do {								\
+            printk ("%s%s, %d (DEBUG) %s(): ",				\
+                KERN_DEBUG, __FILE__, __LINE__, __func__);		\
+            printk (f, ##a);						\
+        } while (0)
 #   define DASSERT(x)							\
-	do {								\
-		if (!x)							\
-			DPRINTF("Assertion failed at line %d.\n", __LINE__);\
-	} while (0)
+        do {								\
+            if (!x)							\
+                DPRINTF("Assertion failed at line %d.\n", __LINE__);	\
+        } while (0)
 #else
-#   define DPRINTF(...) do {} while(0)
-#   define DASSERT(...) do {} while(0)
+#   define DPRINTF(f, a...) do {} while(0)
+#   define DASSERT(f, a...) do {} while(0)
 #endif
 
 /*
@@ -1058,7 +1058,7 @@
 
 	// Why would anyone want more than this??
 	if (count > cam->width * cam->height * 2)
-		return -EINVAL;
+		count = cam->width * cam->height * 2;
 
 	w9966_wreg(cam, 0x00, 0x02);	// Reset ECP-FIFO buffer
 	w9966_wreg(cam, 0x00, 0x00);	// Return to normal operation
