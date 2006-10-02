Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965242AbWJBSY5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965242AbWJBSY5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 14:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965247AbWJBSY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 14:24:56 -0400
Received: from mail.fieldses.org ([66.93.2.214]:17646 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S965242AbWJBSYx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 14:24:53 -0400
Date: Mon, 2 Oct 2006 14:24:51 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: NeilBrown <neilb@suse.de>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [PATCH 1 of 3] nfsd4: fix fs locations bounds-checking
Message-ID: <20061002182451.GC8084@fieldses.org>
References: <20060929130518.23919.patches@notabene> <1060929030913.24108@suse.de> <20060928234540.fd74f1e1.akpm@osdl.org> <20061002182327.GB8084@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061002182327.GB8084@fieldses.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The comparison here is obviously useless as locations_count is unsigned.

Though fsloc_parse can only be handed data by root, still I'd rather have
some sanity-checking; so set a (generous) maximum number of fslocations to
keep the following kzalloc to a reasonable size.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
---
 fs/nfsd/export.c            |    2 +-
 include/linux/nfsd/export.h |    3 +++
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 7e429ca..71f3655 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -418,7 +418,7 @@ fsloc_parse(char **mesg, char *buf, stru
 	err = get_int(mesg, &fsloc->locations_count);
 	if (err)
 		return err;
-	if (fsloc->locations_count < 0)
+	if (fsloc->locations_count > MAX_FS_LOCATIONS)
 		return -EINVAL;
 	if (fsloc->locations_count == 0)
 		return 0;
diff --git a/include/linux/nfsd/export.h b/include/linux/nfsd/export.h
index 101fb4c..6e78ea9 100644
--- a/include/linux/nfsd/export.h
+++ b/include/linux/nfsd/export.h
@@ -48,6 +48,9 @@ #ifdef __KERNEL__
 /*
  * FS Locations
  */
+
+#define MAX_FS_LOCATIONS	128
+
 struct nfsd4_fs_location {
 	char *hosts; /* colon separated list of hosts */
 	char *path;  /* slash separated list of path components */
-- 
1.4.2.g55c3

