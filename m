Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758294AbWLEA5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758294AbWLEA5g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 19:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758366AbWLEA5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 19:57:35 -0500
Received: from mga09.intel.com ([134.134.136.24]:14962 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756325AbWLEA5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 19:57:34 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,495,1157353200"; 
   d="scan'208"; a="23029292:sNHT66661119"
Date: Mon, 4 Dec 2006 16:56:18 -0800
From: Valerie Henson <val_henson@linux.intel.com>
To: Mark Fasheh <mark.fasheh@oracle.com>
Cc: Steven Whitehouse <steve@chygwyn.com>, linux-kernel@vger.kernel.org,
       ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: Relative atime (was Re: What's in ocfs2.git)
Message-ID: <20061205005617.GD8482@goober>
References: <20061203203149.GC19617@ca-server1.us.oracle.com> <1165229693.3752.629.camel@quoit.chygwyn.com> <20061205001007.GF19617@ca-server1.us.oracle.com> <20061205003619.GC8482@goober>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061205003619.GC8482@goober>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2006 at 04:36:20PM -0800, Valerie Henson wrote:
> On Mon, Dec 04, 2006 at 04:10:07PM -0800, Mark Fasheh wrote:
> > Hi Steve,
> > 
> > On Mon, Dec 04, 2006 at 10:54:53AM +0000, Steven Whitehouse wrote:
> > > > In the future, I'd like to see a "relative atime" mode, which functions
> > > > in the manner described by Valerie Henson at:
> > > > 
> > > > http://lkml.org/lkml/2006/8/25/380
> > > > 
> > > I'd like to second that. [adding Val Henson to the "to"] What (if
> > > anything) remains to be done before the relative atime patch is ready to
> > > go upstream? I'm happy to help out here if required,
> > Last time I looked at them, things seemed to be in pretty good shape - it
> > wasn't a very large patch series.

And the userland part.

-VAL

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
