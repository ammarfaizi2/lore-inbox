Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262605AbUEKJD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbUEKJD5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 05:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbUEKJDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 05:03:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:11659 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262605AbUEKJAJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 05:00:09 -0400
Date: Tue, 11 May 2004 02:00:02 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, torvalds@osdl.org, marcelo.tosatti@cyclades.com
Subject: [PATCH 9/11] add mq_attr_ok() helper
Message-ID: <20040511020002.H21045@build.pdx.osdl.net>
References: <20040511014232.Y21045@build.pdx.osdl.net> <20040511014524.Z21045@build.pdx.osdl.net> <20040511014639.A21045@build.pdx.osdl.net> <20040511014833.B21045@build.pdx.osdl.net> <20040511015015.C21045@build.pdx.osdl.net> <20040511015219.D21045@build.pdx.osdl.net> <20040511015357.E21045@build.pdx.osdl.net> <20040511015658.F21045@build.pdx.osdl.net> <20040511015833.G21045@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040511015833.G21045@build.pdx.osdl.net>; from chrisw@osdl.org on Tue, May 11, 2004 at 01:58:33AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add helper function mq_attr_ok() to do mq_attr sanity checking, and do
some extra overlow checking.

--- 2.6-rlimit/ipc/mqueue.c~mqueue_rlimit	2004-05-10 22:28:43.137833864 -0700
+++ 2.6-rlimit/ipc/mqueue.c	2004-05-10 22:30:44.530379392 -0700
@@ -534,6 +534,28 @@
 	info->notify_owner = 0;
 }
 
+static int mq_attr_ok(struct mq_attr *attr)
+{
+	if (attr->mq_maxmsg <= 0 || attr->mq_msgsize <= 0)
+		return 0;
+	if (capable(CAP_SYS_RESOURCE)) {
+		if (attr->mq_maxmsg > HARD_MSGMAX)
+			return 0;
+	} else {
+		if (attr->mq_maxmsg > msg_max ||
+				attr->mq_msgsize > msgsize_max)
+			return 0;
+	}
+	/* check for overflow */
+	if (attr->mq_msgsize > ULONG_MAX/attr->mq_maxmsg)
+		return 0;
+	if ((unsigned long)(attr->mq_maxmsg * attr->mq_msgsize) +
+	    (attr->mq_maxmsg * sizeof (struct msg_msg *)) <
+	    (unsigned long)(attr->mq_maxmsg * attr->mq_msgsize))
+		return 0;
+	return 1;
+}
+
 /*
  * Invoked when creating a new queue via sys_mq_open
  */
@@ -547,17 +569,8 @@
 	if (u_attr != NULL) {
 		if (copy_from_user(&attr, u_attr, sizeof(attr)))
 			return ERR_PTR(-EFAULT);
-
-		if (attr.mq_maxmsg <= 0 || attr.mq_msgsize <= 0)
+		if (!mq_attr_ok(&attr))
 			return ERR_PTR(-EINVAL);
-		if (capable(CAP_SYS_RESOURCE)) {
-			if (attr.mq_maxmsg > HARD_MSGMAX)
-				return ERR_PTR(-EINVAL);
-		} else {
-			if (attr.mq_maxmsg > msg_max ||
-					attr.mq_msgsize > msgsize_max)
-				return ERR_PTR(-EINVAL);
-		}
 		/* store for use during create */
 		dentry->d_fsdata = &attr;
 	}
