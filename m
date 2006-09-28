Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbWI1QGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbWI1QGZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 12:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbWI1QCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 12:02:31 -0400
Received: from mx.pathscale.com ([64.160.42.68]:5046 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751929AbWI1QBY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 12:01:24 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 25 of 28] IB/ipath - Set CPU affinity early
X-Mercurial-Node: 4269068599c270538c2eb5a83b6757ce227b8de2
Message-Id: <4269068599c270538c2e.1159459221@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1159459196@eng-12.pathscale.com>
Date: Thu, 28 Sep 2006 09:00:21 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This change moves around port assignment so that it happens before any
memory is allocated.  This allows memory to be allocated on an appropriate
CPU, which improves performance for users of /dev/ipath.

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r 9fa624c592af -r 4269068599c2 drivers/infiniband/hw/ipath/ipath_common.h
--- a/drivers/infiniband/hw/ipath/ipath_common.h	Thu Sep 28 08:57:13 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_common.h	Thu Sep 28 08:57:13 2006 -0700
@@ -412,15 +412,17 @@ struct ipath_user_info {
 
 #define IPATH_CMD_MIN		16
 
-#define IPATH_CMD_USER_INIT	16	/* set up userspace */
+#define __IPATH_CMD_USER_INIT	16	/* old set up userspace (for old user code) */
 #define IPATH_CMD_PORT_INFO	17	/* find out what resources we got */
 #define IPATH_CMD_RECV_CTRL	18	/* control receipt of packets */
 #define IPATH_CMD_TID_UPDATE	19	/* update expected TID entries */
 #define IPATH_CMD_TID_FREE	20	/* free expected TID entries */
 #define IPATH_CMD_SET_PART_KEY	21	/* add partition key */
 #define IPATH_CMD_SLAVE_INFO	22	/* return info on slave processes */
-
-#define IPATH_CMD_MAX		22
+#define IPATH_CMD_ASSIGN_PORT	23	/* allocate HCA and port */
+#define IPATH_CMD_USER_INIT 	24	/* set up userspace */
+
+#define IPATH_CMD_MAX		24
 
 struct ipath_port_info {
 	__u32 num_active;	/* number of active units */
diff -r 9fa624c592af -r 4269068599c2 drivers/infiniband/hw/ipath/ipath_file_ops.c
--- a/drivers/infiniband/hw/ipath/ipath_file_ops.c	Thu Sep 28 08:57:13 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_file_ops.c	Thu Sep 28 08:57:13 2006 -0700
@@ -1701,18 +1701,17 @@ done:
 
 static int ipath_open(struct inode *in, struct file *fp)
 {
-	/* The real work is performed later in ipath_do_user_init() */
+	/* The real work is performed later in ipath_assign_port() */
 	fp->private_data = kzalloc(sizeof(struct ipath_filedata), GFP_KERNEL);
 	return fp->private_data ? 0 : -ENOMEM;
 }
 
-static int ipath_do_user_init(struct file *fp,
+
+// Get port early, so can set affinity prior to memory allocation
+static int ipath_assign_port(struct file *fp,
 			      const struct ipath_user_info *uinfo)
 {
 	int ret;
-	struct ipath_portdata *pd;
-	struct ipath_devdata *dd;
-	u32 head32;
 	int i_minor;
 	unsigned swminor;
 
@@ -1757,8 +1756,18 @@ static int ipath_do_user_init(struct fil
 
 	mutex_unlock(&ipath_mutex);
 
-	if (ret)
-		goto done;
+done:
+	return ret;
+}
+
+
+static int ipath_do_user_init(struct file *fp,
+			      const struct ipath_user_info *uinfo)
+{
+	int ret;
+	struct ipath_portdata *pd;
+	struct ipath_devdata *dd;
+	u32 head32;
 
 	pd = port_fp(fp);
 	dd = pd->port_dd;
@@ -2035,6 +2044,8 @@ static ssize_t ipath_write(struct file *
 	consumed = sizeof(cmd.type);
 
 	switch (cmd.type) {
+	case IPATH_CMD_ASSIGN_PORT:
+	case __IPATH_CMD_USER_INIT:
 	case IPATH_CMD_USER_INIT:
 		copy = sizeof(cmd.cmd.user_info);
 		dest = &cmd.cmd.user_info;
@@ -2083,12 +2094,24 @@ static ssize_t ipath_write(struct file *
 
 	consumed += copy;
 	pd = port_fp(fp);
-	if (!pd && cmd.type != IPATH_CMD_USER_INIT) {
+	if (!pd && cmd.type != __IPATH_CMD_USER_INIT &&
+		cmd.type != IPATH_CMD_ASSIGN_PORT) {
 		ret = -EINVAL;
 		goto bail;
 	}
 
 	switch (cmd.type) {
+	case IPATH_CMD_ASSIGN_PORT:
+		ret = ipath_assign_port(fp, &cmd.cmd.user_info);
+		if (ret)
+			goto bail;
+		break;
+	case __IPATH_CMD_USER_INIT:
+		// backwards compatibility, get port first
+		ret = ipath_assign_port(fp, &cmd.cmd.user_info);
+		if (ret)
+			goto bail;
+		// and fall through to current version.
 	case IPATH_CMD_USER_INIT:
 		ret = ipath_do_user_init(fp, &cmd.cmd.user_info);
 		if (ret)
