Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422925AbWHYX43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422925AbWHYX43 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 19:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422927AbWHYX42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 19:56:28 -0400
Received: from mga07.intel.com ([143.182.124.22]:27729 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1422925AbWHYX41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 19:56:27 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,170,1154934000"; 
   d="scan'208"; a="107788887:sNHT52182641"
Date: Fri, 25 Aug 2006 16:56:19 -0700
From: Valerie Henson <val_henson@linux.intel.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Akkana Peck <akkana@shallowsky.com>, Mark Fasheh <mark.fasheh@oracle.com>,
       Jesse Barnes <jesse.barnes@intel.com>,
       Arjan van de Ven <arjan@linux.intel.com>, Chris Wedgewood <cw@f00f.org>,
       jsipek@cs.sunysb.edu, Al Viro <viro@ftp.linux.org.uk>,
       Christoph Hellwig <hch@lst.de>, Adrian Bunk <bunk@stusta.de>
Subject: [patch] Relative atime - userspace
Message-ID: <20060825235619.GB25003@goober>
References: <20060825235215.820563000@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060825235215.820563000@linux.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the "relatime" (relative atime) option support to mount.  Relative
atime only updates the atime if the previous atime is older than the
mtime or ctime.  Like noatime, but useful for applications like mutt
that need to know when a file has been read since it was last
modified.

Signed-off-by: Valerie Henson <val_henson@linux.intel.com>

---
 mount/mount.8           |    7 +++++++
 mount/mount.c           |    6 ++++++
 mount/mount_constants.h |    4 ++++
 3 files changed, 17 insertions(+)

--- util-linux-2.13-pre7.orig/mount/mount.8
+++ util-linux-2.13-pre7/mount/mount.8
@@ -586,6 +586,13 @@ access on the news spool to speed up new
 .B nodiratime
 Do not update directory inode access times on this filesystem.
 .TP
+.B relatime
+Update inode access times relative to modify or change time.  Access
+time is only updated if the previous access time was earlier than the
+current modify or change time. (Similar to noatime, but doesn't break
+mutt or other applications that need to know if a file has been read
+since the last time it was modified.)
+.TP
 .B noauto
 Can only be mounted explicitly (i.e., the
 .B \-a
--- util-linux-2.13-pre7.orig/mount/mount.c
+++ util-linux-2.13-pre7/mount/mount.c
@@ -164,6 +164,12 @@ static const struct opt_map opt_map[] = 
   { "diratime",	0, 1, MS_NODIRATIME },	/* Update dir access times */
   { "nodiratime", 0, 0, MS_NODIRATIME },/* Do not update dir access times */
 #endif
+#ifdef MS_RELATIME
+  { "relatime", 0, 0, MS_RELATIME },	/* Update access times relative to
+					   mtime/ctime */
+  { "norelatime", 0, 1, MS_RELATIME },	/* Update access time without regard
+					   to mtime/ctime */
+#endif
   { NULL,	0, 0, 0		}
 };
 
--- util-linux-2.13-pre7.orig/mount/mount_constants.h
+++ util-linux-2.13-pre7/mount/mount_constants.h
@@ -57,6 +57,10 @@ if we have a stack or plain mount - moun
 #ifndef MS_VERBOSE
 #define MS_VERBOSE	0x8000	/* 32768 */
 #endif
+#ifndef MS_RELATIME
+#define MS_RELATIME   0x200000	/* 200000: Update access times relative
+				   to mtime/ctime */
+#endif
 /*
  * Magic mount flag number. Had to be or-ed to the flag values.
  */
