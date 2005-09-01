Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965037AbVIABc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965037AbVIABc0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 21:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965054AbVIABcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 21:32:07 -0400
Received: from ozlabs.org ([203.10.76.45]:24720 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965041AbVIAB31 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 21:29:27 -0400
To: <jgarzik@pobox.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <linuxppc64-dev@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 16/18] iseries_veth: Incorporate iseries_veth.h in iseries_veth.c
In-Reply-To: <1125538127.859382.875909607846.qpush@concordia>
Message-Id: <20050901012925.4CAC368247@ozlabs.org>
Date: Thu,  1 Sep 2005 11:29:25 +1000 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

iseries_veth.h is only used by iseries_veth.c, so merge the former into
the latter.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 drivers/net/iseries_veth.h |   46 ---------------------------------------------
 drivers/net/iseries_veth.c |   42 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 40 insertions(+), 48 deletions(-)

Index: veth-dev2/drivers/net/iseries_veth.c
===================================================================
--- veth-dev2.orig/drivers/net/iseries_veth.c
+++ veth-dev2/drivers/net/iseries_veth.c
@@ -81,12 +81,50 @@
 
 #undef DEBUG
 
-#include "iseries_veth.h"
-
 MODULE_AUTHOR("Kyle Lucke <klucke@us.ibm.com>");
 MODULE_DESCRIPTION("iSeries Virtual ethernet driver");
 MODULE_LICENSE("GPL");
 
+#define VethEventTypeCap	(0)
+#define VethEventTypeFrames	(1)
+#define VethEventTypeMonitor	(2)
+#define VethEventTypeFramesAck	(3)
+
+#define VETH_MAX_ACKS_PER_MSG	(20)
+#define VETH_MAX_FRAMES_PER_MSG	(6)
+
+struct VethFramesData {
+	u32 addr[VETH_MAX_FRAMES_PER_MSG];
+	u16 len[VETH_MAX_FRAMES_PER_MSG];
+	u32 eofmask;
+};
+#define VETH_EOF_SHIFT		(32-VETH_MAX_FRAMES_PER_MSG)
+
+struct VethFramesAckData {
+	u16 token[VETH_MAX_ACKS_PER_MSG];
+};
+
+struct VethCapData {
+	u8 caps_version;
+	u8 rsvd1;
+	u16 num_buffers;
+	u16 ack_threshold;
+	u16 rsvd2;
+	u32 ack_timeout;
+	u32 rsvd3;
+	u64 rsvd4[3];
+};
+
+struct VethLpEvent {
+	struct HvLpEvent base_event;
+	union {
+		struct VethCapData caps_data;
+		struct VethFramesData frames_data;
+		struct VethFramesAckData frames_ack_data;
+	} u;
+
+};
+
 #define VETH_NUMBUFFERS		(120)
 #define VETH_ACKTIMEOUT 	(1000000) /* microseconds */
 #define VETH_MAX_MCAST		(12)
Index: veth-dev2/drivers/net/iseries_veth.h
===================================================================
--- veth-dev2.orig/drivers/net/iseries_veth.h
+++ /dev/null
@@ -1,46 +0,0 @@
-/* File veth.h created by Kyle A. Lucke on Mon Aug  7 2000. */
-
-#ifndef _ISERIES_VETH_H
-#define _ISERIES_VETH_H
-
-#define VethEventTypeCap	(0)
-#define VethEventTypeFrames	(1)
-#define VethEventTypeMonitor	(2)
-#define VethEventTypeFramesAck	(3)
-
-#define VETH_MAX_ACKS_PER_MSG	(20)
-#define VETH_MAX_FRAMES_PER_MSG	(6)
-
-struct VethFramesData {
-	u32 addr[VETH_MAX_FRAMES_PER_MSG];
-	u16 len[VETH_MAX_FRAMES_PER_MSG];
-	u32 eofmask;
-};
-#define VETH_EOF_SHIFT		(32-VETH_MAX_FRAMES_PER_MSG)
-
-struct VethFramesAckData {
-	u16 token[VETH_MAX_ACKS_PER_MSG];
-};
-
-struct VethCapData {
-	u8 caps_version;
-	u8 rsvd1;
-	u16 num_buffers;
-	u16 ack_threshold;
-	u16 rsvd2;
-	u32 ack_timeout;
-	u32 rsvd3;
-	u64 rsvd4[3];
-};
-
-struct VethLpEvent {
-	struct HvLpEvent base_event;
-	union {
-		struct VethCapData caps_data;
-		struct VethFramesData frames_data;
-		struct VethFramesAckData frames_ack_data;
-	} u;
-
-};
-
-#endif	/* _ISERIES_VETH_H */
