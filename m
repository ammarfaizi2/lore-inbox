Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261963AbVGKPEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbVGKPEM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 11:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261908AbVGKPCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 11:02:08 -0400
Received: from mailgw.voltaire.com ([212.143.27.70]:20935 "EHLO
	mailgw.voltaire.com") by vger.kernel.org with ESMTP id S261882AbVGKPAd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 11:00:33 -0400
Subject: [PATCH 23/27] User MAD ABI changes to support RMPP
From: Hal Rosenstock <halr@voltaire.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Content-Type: text/plain
Organization: 
Message-Id: <1121089249.4389.4551.camel@hal.voltaire.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Jul 2005 10:52:58 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

User MAD ABI changes to support RMPP

Signed-off-by: Hal Rosenstock <halr@voltaire.com>

This patch depends on patch 22/27.

-- 
 ib_user_mad.h |   28 ++++++++++++++++++++++--
 1 files changed, 22 insertions(+), 6 deletions(-)
 user_mad.txt |   51 +++++++++++++++++++++++++++++++++++++++--
 1 files changed, 39 insertions(+), 12 deletions(-)
diff -uprN linux-2.6.13-rc2-mm1/drivers/infiniband22/include/ib_user_mad.h linux-2.6.13-rc2-mm1/drivers/infiniband23/include/ib_user_mad.h
-- linux-2.6.13-rc2-mm1/drivers/infiniband22/include/ib_user_mad.h	2005-06-29 19:00:53.000000000 -0400
+++ linux-2.6.13-rc2-mm1/drivers/infiniband23/include/ib_user_mad.h	2005-07-10 16:55:43.000000000 -0400
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2004 Topspin Communications.  All rights reserved.
+ * Copyright (c) 2005 Voltaire, Inc. All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -29,7 +30,7 @@
  * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  * SOFTWARE.
  *
- * $Id: ib_user_mad.h 1389 2004-12-27 22:56:47Z roland $
+ * $Id: ib_user_mad.h 2814 2005-07-06 19:14:09Z halr $
  */
 
 #ifndef IB_USER_MAD_H
@@ -42,7 +43,7 @@
  * Increment this value if any changes that break userspace ABI
  * compatibility are made.
  */
-#define IB_USER_MAD_ABI_VERSION	2
+#define IB_USER_MAD_ABI_VERSION	5
 
 /*
  * Make sure that all structs defined in this file remain laid out so
@@ -51,13 +52,13 @@
  */
 
 /**
- * ib_user_mad - MAD packet
- * @data - Contents of MAD
+ * ib_user_mad_hdr - MAD packet header
  * @id - ID of agent MAD received with/to be sent with
  * @status - 0 on successful receive, ETIMEDOUT if no response
  *   received (transaction ID in data[] will be set to TID of original
  *   request) (ignored on send)
  * @timeout_ms - Milliseconds to wait for response (unset on receive)
+ * @retries - Number of automatic retries to attempt
  * @qpn - Remote QP number received from/to be sent to
  * @qkey - Remote Q_Key to be sent with (unset on receive)
  * @lid - Remote lid received from/to be sent to
@@ -72,11 +73,12 @@
  *
  * All multi-byte quantities are stored in network (big endian) byte order.
  */
-struct ib_user_mad {
-	__u8	data[256];
+struct ib_user_mad_hdr {
 	__u32	id;
 	__u32	status;
 	__u32	timeout_ms;
+	__u32	retries;
+	__u32	length;
 	__u32	qpn;
 	__u32   qkey;
 	__u16	lid;
@@ -91,6 +93,17 @@ struct ib_user_mad {
 };
 
 /**
+ * ib_user_mad - MAD packet
+ * @hdr - MAD packet header
+ * @data - Contents of MAD
+ *
+ */
+struct ib_user_mad {
+	struct ib_user_mad_hdr hdr;
+	__u8	data[0];
+};
+
+/**
  * ib_user_mad_reg_req - MAD registration request
  * @id - Set by the kernel; used to identify agent in future requests.
  * @qpn - Queue pair number; must be 0 or 1.
@@ -103,6 +116,8 @@ struct ib_user_mad {
  *   management class to receive.
  * @oui: Indicates IEEE OUI when mgmt_class is a vendor class
  *   in the range from 0x30 to 0x4f. Otherwise not used.
+ * @rmpp_version: If set, indicates the RMPP version used.
+ * 
  */
 struct ib_user_mad_reg_req {
 	__u32	id;
@@ -111,6 +126,7 @@ struct ib_user_mad_reg_req {
 	__u8	mgmt_class;
 	__u8	mgmt_class_version;
 	__u8    oui[3];
+	__u8	rmpp_version;
 };
 
 #define IB_IOCTL_MAGIC		0x1b
diff -uprN linux-2.6.13-rc2-mm1/Documentation/infiniband/user_mad.txt linux-2.6.13-rc2-mm1/Documentation23/infiniband/user_mad.txt
-- linux-2.6.13-rc2-mm1/Documentation/infiniband/user_mad.txt	2005-06-29 19:00:53.000000000 -0400
+++ linux-2.6.13-rc2-mm1/Documentation23/infiniband/user_mad.txt	2005-07-01 14:27:50.000000000 -0400
@@ -28,13 +28,37 @@ Creating MAD agents
 
 Receiving MADs
 
-  MADs are received using read().  The buffer passed to read() must be
-  large enough to hold at least one struct ib_user_mad.  For example:
+  MADs are received using read().  The receive side now supports
+  RMPP. The buffer passed to read() must be at least one 
+  struct ib_user_mad + 256 bytes. For example:
+
+  If the buffer passed is not large enough to hold the received
+  MAD (RMPP), the errno is set to ENOSPC and the length of the
+  buffer needed is set in mad.length.
+
+  Example for normal MAD (non RMPP) reads:
+	struct ib_user_mad *mad;
+	mad = malloc(sizeof *mad + 256);
+	ret = read(fd, mad, sizeof *mad + 256);
+	if (ret != sizeof mad + 256) {
+		perror("read");
+		free(mad);
+	}
 
-	struct ib_user_mad mad;
-	ret = read(fd, &mad, sizeof mad);
-	if (ret != sizeof mad)
+  Example for RMPP reads:
+	struct ib_user_mad *mad;
+	mad = malloc(sizeof *mad + 256);
+	ret = read(fd, mad, sizeof *mad + 256);
+	if (ret == -ENOSPC)) {
+		length = mad.length;
+		free(mad);
+		mad = malloc(sizeof *mad + length);
+		ret = read(fd, mad, sizeof *mad + length);
+	}
+	if (ret < 0) {
 		perror("read");
+		free(mad);
+	}
 
   In addition to the actual MAD contents, the other struct ib_user_mad
   fields will be filled in with information on the received MAD.  For
@@ -50,18 +74,21 @@ Sending MADs
 
   MADs are sent using write().  The agent ID for sending should be
   filled into the id field of the MAD, the destination LID should be
-  filled into the lid field, and so on.  For example:
+  filled into the lid field, and so on.  The send side does support
+  RMPP so arbitrary length MAD can be sent. For example:
+
+	struct ib_user_mad *mad;
 
-	struct ib_user_mad mad;
+	mad = malloc(sizeof *mad + mad_length);
 
-	/* fill in mad.data */
+	/* fill in mad->data */
 
-	mad.id  = my_agent;	/* req.id from agent registration */
-	mad.lid = my_dest;	/* in network byte order... */
+	mad->hdr.id  = my_agent;	/* req.id from agent registration */
+	mad->hdr.lid = my_dest;		/* in network byte order... */
 	/* etc. */
 
-	ret = write(fd, &mad, sizeof mad);
-	if (ret != sizeof mad)
+	ret = write(fd, &mad, sizeof *mad + mad_length);
+	if (ret != sizeof *mad + mad_length)
 		perror("write");
 
 Setting IsSM Capability Bit


