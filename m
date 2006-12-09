Return-Path: <linux-kernel-owner+w=401wt.eu-S1758779AbWLIDQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758779AbWLIDQf (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 22:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758359AbWLIDQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 22:16:34 -0500
Received: from mga09.intel.com ([134.134.136.24]:20689 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757216AbWLIDQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 22:16:33 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,516,1157353200"; 
   d="scan'208"; a="24992822:sNHT23987826"
Date: Fri, 8 Dec 2006 19:15:14 -0800
From: Valerie Henson <val_henson@linux.intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: mark.fasheh@oracle.com, steve@chygwyn.com, linux-kernel@vger.kernel.org,
       ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, Karel Zak <kzak@redhat.com>
Subject: Re: Relative atime (was Re: What's in ocfs2.git)
Message-ID: <20061209031513.GB8515@goober>
References: <20061203203149.GC19617@ca-server1.us.oracle.com> <1165229693.3752.629.camel@quoit.chygwyn.com> <20061205001007.GF19617@ca-server1.us.oracle.com> <20061205003619.GC8482@goober> <20061205205802.92b91ce1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061205205802.92b91ce1.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2006 at 08:58:02PM -0800, Andrew Morton wrote:
> That's the easy part.   How are we going to get mount(8) patched?

Karel, interested in taking a look at the following patch?  The kernel
bits are in -mm currently.

-VAL

Add the "relatime" (relative atime) option support to mount.  Relative
atime only updates the atime if the previous atime is older than the
mtime or ctime.  Like noatime, but useful for applications like mutt
that need to know when a file has been read since it was last
modified.

Cc: Adrian Bunk <bunk@stusta.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Karel Zak <kzak@redhat.com>

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
