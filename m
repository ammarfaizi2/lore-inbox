Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbWDCRWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbWDCRWl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 13:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbWDCRWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 13:22:40 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:35998 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S964784AbWDCRWj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 13:22:39 -0400
Date: Mon, 3 Apr 2006 19:22:38 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, peter.oberparleiter@de.ibm.com,
       linux-kernel@vger.kernel.org
Subject: [patch 5/9] s390: increase cio_trace debug event size.
Message-ID: <20060403172238.GE11049@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

[patch 5/9] s390: increase cio_trace debug event size.

Debugging events in cio_trace/hex_ascii are truncated for some trace
entries. Increase trace event size to 16 bytes to cover longer text
events, make CIO_HEX_EVENT an inline function that loops to cover bigger
hex events.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/cio.c       |    2 +-
 drivers/s390/cio/cio_debug.h |   22 ++++++++++++++--------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/cio.c linux-2.6-patched/drivers/s390/cio/cio.c
--- linux-2.6/drivers/s390/cio/cio.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/cio.c	2006-04-03 18:46:38.000000000 +0200
@@ -67,7 +67,7 @@ cio_debug_init (void)
 		goto out_unregister;
 	debug_register_view (cio_debug_msg_id, &debug_sprintf_view);
 	debug_set_level (cio_debug_msg_id, 2);
-	cio_debug_trace_id = debug_register ("cio_trace", 16, 4, 8);
+	cio_debug_trace_id = debug_register ("cio_trace", 16, 4, 16);
 	if (!cio_debug_trace_id)
 		goto out_unregister;
 	debug_register_view (cio_debug_trace_id, &debug_hex_ascii_view);
diff -urpN linux-2.6/drivers/s390/cio/cio_debug.h linux-2.6-patched/drivers/s390/cio/cio_debug.h
--- linux-2.6/drivers/s390/cio/cio_debug.h	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/cio_debug.h	2006-04-03 18:46:38.000000000 +0200
@@ -3,6 +3,11 @@
 
 #include <asm/debug.h>
 
+/* for use of debug feature */
+extern debug_info_t *cio_debug_msg_id;
+extern debug_info_t *cio_debug_trace_id;
+extern debug_info_t *cio_debug_crw_id;
+
 #define CIO_TRACE_EVENT(imp, txt) do { \
 		debug_text_event(cio_debug_trace_id, imp, txt); \
 	} while (0)
@@ -15,18 +20,19 @@
 		debug_sprintf_event(cio_debug_crw_id, imp , ##args); \
 	} while (0)
 
-#define CIO_HEX_EVENT(imp, args...) do { \
-                debug_event(cio_debug_trace_id, imp, ##args); \
-        } while (0)
+static inline void
+CIO_HEX_EVENT(int level, void *data, int length)
+{
+	while (length > 0) {
+		debug_event(cio_debug_trace_id, level, data, length);
+		length -= cio_debug_trace_id->buf_size;
+		data += cio_debug_trace_id->buf_size;
+	}
+}
 
 #define CIO_DEBUG(printk_level,event_level,msg...) ({ \
 	if (cio_show_msg) printk(printk_level msg); \
 	CIO_MSG_EVENT (event_level, msg); \
 })
 
-/* for use of debug feature */
-extern debug_info_t *cio_debug_msg_id;
-extern debug_info_t *cio_debug_trace_id;
-extern debug_info_t *cio_debug_crw_id;
-
 #endif
