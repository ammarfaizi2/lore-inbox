Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261788AbVGaHzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbVGaHzo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 03:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbVGaHzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 03:55:43 -0400
Received: from gatekeeper.ncic.ac.cn ([159.226.41.188]:2948 "HELO ncic.ac.cn")
	by vger.kernel.org with SMTP id S261788AbVGaHzj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 03:55:39 -0400
Subject: [PATCH] Fix PIPE_LEN definition in 2.6.12
From: =?UTF-8?Q?=E9=9C=8D=E5=BF=97?= =?UTF-8?Q?=E5=88=9A?= 
	<zghuo@ncic.ac.cn>
Reply-To: zghuo@ncic.ac.cn
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Content-Type: text/plain
Organization: NCIC
Date: Sun, 31 Jul 2005 15:55:13 +0800
Message-Id: <1122796514.8909.17.camel@mypad>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the introduction of the new "struct pipe_inode_info"in 2.6.11,
the definition of PIPE_LEN, PIPE_BASE, PIPE_START all become
obsolete. The new definition of PIPE_LEN is attached.

Signed-off-by: Zhigang Huo <zghuo@ncic.ac.cn>

================================================
--- pipe_fs_i.h~        2005-07-31 13:45:38.000000000 +0800
+++ pipe_fs_i.h 2005-07-31 14:41:53.000000000 +0800
@@ -33,6 +33,25 @@
        struct fasync_struct *fasync_writers;
 };

+static inline unsigned int pipe_len(struct inode inode)
+{
+  struct pipe_inode_info *info = inode.i_pipe;
+  int bufs = info->nrbufs;
+  int curbuf = info->curbuf;
+  unsigned int ret;
+
+  ret = 0;
+  while(bufs--) {
+    struct pipe_buffer *buf = info->bufs + curbuf;
+    size_t chars = buf->len;
+
+    ret += chars;
+    bufs--;
+    curbuf = (curbuf + 1) & (PIPE_BUFFERS-1);
+  }
+  return ret;
+}
+
 /* Differs from PIPE_BUF in that PIPE_SIZE is the length of the actual
    memory allocation, whereas PIPE_BUF makes atomicity guarantees.  */
 #define PIPE_SIZE              PAGE_SIZE
@@ -41,7 +60,7 @@
 #define PIPE_WAIT(inode)       (&(inode).i_pipe->wait)
 #define PIPE_BASE(inode)       ((inode).i_pipe->base)
 #define PIPE_START(inode)      ((inode).i_pipe->start)
-#define PIPE_LEN(inode)                ((inode).i_pipe->len)
+#define PIPE_LEN(inode)                pipe_len(inode)
 #define PIPE_READERS(inode)    ((inode).i_pipe->readers)
 #define PIPE_WRITERS(inode)    ((inode).i_pipe->writers)
 #define PIPE_WAITING_WRITERS(inode)
((inode).i_pipe->waiting_writers)



