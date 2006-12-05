Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935588AbWLEWUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935588AbWLEWUp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 17:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935370AbWLEWUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 17:20:45 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:33881 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935588AbWLEWUn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 17:20:43 -0500
Date: Tue, 5 Dec 2006 14:20:27 -0800
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Valerie Henson <val_henson@linux.intel.com>
Cc: Steven Whitehouse <steve@chygwyn.com>, linux-kernel@vger.kernel.org,
       ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: Relative atime (was Re: What's in ocfs2.git)
Message-ID: <20061205222027.GA4497@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20061203203149.GC19617@ca-server1.us.oracle.com> <1165229693.3752.629.camel@quoit.chygwyn.com> <20061205001007.GF19617@ca-server1.us.oracle.com> <20061205003619.GC8482@goober>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061205003619.GC8482@goober>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2006 at 04:36:20PM -0800, Valerie Henson wrote:
> > Last time I looked at them, things seemed to be in pretty good shape - it
> > wasn't a very large patch series.
> 
> Yep, the relative atime patch is tiny and pretty much done - just
> needs some soak time in -mm and a little more review (cc'd Viro and
> fsdevel).  Kernel patch against 2.6.18-rc4 appended, patch to mount
> following. (Note that my web server suffered a RAID failure and my
> patches page is unavailable till the restore finishes.)

Well, here's what the ocfs2 patch would look like. If we care to push this
forward, some time in -mm would be nice...
	--Mark

From: Mark Fasheh <mark.fasheh@oracle.com>
Date: Tue, 5 Dec 2006 14:13:41 -0800
Subject: [PATCH] ocfs2: relative atime support

Update ocfs2_should_update_atime() to understand the MNT_RELATIME flag and
to test against mtime / ctime accordingly.

Signed-off-by: Mark Fasheh <mark.fasheh@oracle.com>
---
 fs/ocfs2/file.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 8786b3c..16a9b5e 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -154,6 +154,15 @@ int ocfs2_should_update_atime(struct ino
 		return 0;
 
 	now = CURRENT_TIME;
+
+	if (vfsmnt->mnt_flags & MNT_RELATIME) {
+		if ((timespec_compare(&inode->i_atime, &inode->i_mtime) < 0) ||
+		    (timespec_compare(&inode->i_atime, &inode->i_ctime) < 0))
+			return 1;
+
+		return 0;
+	}
+
 	if ((now.tv_sec - inode->i_atime.tv_sec <= osb->s_atime_quantum))
 		return 0;
 	else
-- 
1.4.2.4

