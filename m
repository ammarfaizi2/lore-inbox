Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030390AbWBARjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030390AbWBARjg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 12:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030391AbWBARjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 12:39:36 -0500
Received: from mx2.netapp.com ([216.240.18.37]:31913 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S1030390AbWBARjf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 12:39:35 -0500
X-IronPort-AV: i="4.01,245,1136188800"; 
   d="scan'208"; a="355818007:sNHT18143536"
Subject: [PATCH] VFS: Ensure LOOKUP_CONTINUE flag is preserved by
	link_path_walk()
From: Trond Myklebust <Trond.Myklebust@netapp.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Network Appliance, Inc
Date: Wed, 01 Feb 2006 12:39:27 -0500
Message-Id: <1138815567.14230.1.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
X-OriginalArrivalTime: 01 Feb 2006 17:39:34.0503 (UTC) FILETIME=[7712CF70:01C62756]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 When walking a path, the LOOKUP_CONTINUE flag is used by some filesystems
 (for instance NFS) in order to determine whether or not it is looking up
 the last component of the path. It this is the case, it may have to look
 at the intent information in order to perform various tasks such as atomic
 open.

 A problem currently occurs when link_path_walk() hits a symlink. In this
 case LOOKUP_CONTINUE may be cleared prematurely when we hit the end of the
 path passed by __vfs_follow_link() (i.e. the end of the symlink path)
 rather than when we hit the end of the path passed by the user.

 The solution is to have link_path_walk() clear LOOKUP_CONTINUE if and only
 if that flag was unset when we entered the function.

 Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/namei.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 4acdac0..e1195f4 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -790,7 +790,7 @@ static fastcall int __link_path_walk(con
 
 	inode = nd->dentry->d_inode;
 	if (nd->depth)
-		lookup_flags = LOOKUP_FOLLOW;
+		lookup_flags = LOOKUP_FOLLOW | (nd->flags & LOOKUP_CONTINUE);
 
 	/* At this point we know we have a real path component. */
 	for(;;) {
@@ -885,7 +885,8 @@ static fastcall int __link_path_walk(con
 last_with_slashes:
 		lookup_flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
 last_component:
-		nd->flags &= ~LOOKUP_CONTINUE;
+		/* Clear LOOKUP_CONTINUE iff it was previously unset */
+		nd->flags &= lookup_flags | ~LOOKUP_CONTINUE;
 		if (lookup_flags & LOOKUP_PARENT)
 			goto lookup_parent;
 		if (this.name[0] == '.') switch (this.len) {
