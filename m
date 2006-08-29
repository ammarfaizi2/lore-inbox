Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964920AbWH2APB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964920AbWH2APB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 20:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964928AbWH2APA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 20:15:00 -0400
Received: from mga09.intel.com ([134.134.136.24]:57108 "EHLO
	orsmga102-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S964920AbWH2AO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 20:14:59 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,177,1154934000"; 
   d="scan'208"; a="116498696:sNHT837711924"
Date: Mon, 28 Aug 2006 17:14:37 -0700
From: Valerie Henson <val_henson@linux.intel.com>
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Akkana Peck <akkana@shallowsky.com>,
       Mark Fasheh <mark.fasheh@oracle.com>,
       Jesse Barnes <jesse.barnes@intel.com>,
       Arjan van de Ven <arjan@linux.intel.com>, Chris Wedgewood <cw@f00f.org>,
       jsipek@cs.sunysb.edu, Al Viro <viro@ftp.linux.org.uk>,
       Christoph Hellwig <hch@lst.de>, Adrian Bunk <bunk@stusta.de>
Subject: Re: [patch] Relative atime - userspace
Message-ID: <20060829001437.GI25003@goober>
References: <20060825235215.820563000@linux.intel.com> <20060825235619.GB25003@goober> <20060828214901.GA24374@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060828214901.GA24374@filer.fsl.cs.sunysb.edu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2006 at 05:49:01PM -0400, Josef Sipek wrote:
> On Fri, Aug 25, 2006 at 04:56:19PM -0700, Valerie Henson wrote:
> >  #define MS_VERBOSE	0x8000	/* 32768 */
> ...
> > +#define MS_RELATIME   0x200000	/* 200000: Update access times relative
> 
> Just a small thing... 0x200000 != 200000

Just goes to show what my default base is... :)

Somehow "2097152: blah blah blah" just doesn't seem helpful - I just
removed it.  Fresh patch below.

-VAL

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
+#define MS_RELATIME   0x200000	/* Update access times relative
+				   to mtime/ctime */
+#endif
 /*
  * Magic mount flag number. Had to be or-ed to the flag values.
  */
