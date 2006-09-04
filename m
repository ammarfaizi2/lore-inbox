Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965022AbWIDXS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965022AbWIDXS2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 19:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965043AbWIDXS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 19:18:28 -0400
Received: from mx1.suse.de ([195.135.220.2]:33485 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932244AbWIDXQE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 19:16:04 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 5 Sep 2006 09:15:59 +1000
Message-Id: <1060904231559.23136@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 007 of 9] knfsd: nfsd4: acls: fix inheritance
References: <20060905090617.21303.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: J.Bruce Fields <bfields@fieldses.org>

We can be a little more flexible about the flags allowed for inheritance
(in particular, we can deal with either the presence or the absence of
INHERIT_ONLY), but we should probably reject other combinations that we
don't understand.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfs4acl.c |   43 ++++++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff .prev/fs/nfsd/nfs4acl.c ./fs/nfsd/nfs4acl.c
--- .prev/fs/nfsd/nfs4acl.c	2006-09-04 17:20:49.000000000 +1000
+++ ./fs/nfsd/nfs4acl.c	2006-09-04 17:26:00.000000000 +1000
@@ -63,6 +63,8 @@
 #define NFS4_INHERITANCE_FLAGS (NFS4_ACE_FILE_INHERIT_ACE \
 		| NFS4_ACE_DIRECTORY_INHERIT_ACE | NFS4_ACE_INHERIT_ONLY_ACE)
 
+#define NFS4_SUPPORTED_FLAGS (NFS4_INHERITANCE_FLAGS | NFS4_ACE_IDENTIFIER_GROUP)
+
 #define MASK_EQUAL(mask1, mask2) \
 	( ((mask1) & NFS4_ACE_MASK_ALL) == ((mask2) & NFS4_ACE_MASK_ALL) )
 
@@ -721,22 +723,37 @@ nfs4_acl_split(struct nfs4_acl *acl, str
 		    ace->type != NFS4_ACE_ACCESS_DENIED_ACE_TYPE)
 			return -EINVAL;
 
-		if ((ace->flag & NFS4_INHERITANCE_FLAGS)
-				!= NFS4_INHERITANCE_FLAGS)
-			continue;
+		if (ace->flag & ~NFS4_SUPPORTED_FLAGS)
+			return -EINVAL;
 
-		error = nfs4_acl_add_ace(dacl, ace->type, ace->flag,
+		switch (ace->flag & NFS4_INHERITANCE_FLAGS) {
+		case 0:
+			/* Leave this ace in the effective acl: */
+			continue;
+		case NFS4_INHERITANCE_FLAGS:
+			/* Add this ace to the default acl and remove it
+			 * from the effective acl: */
+			error = nfs4_acl_add_ace(dacl, ace->type, ace->flag,
 				ace->access_mask, ace->whotype, ace->who);
-		if (error < 0)
-			goto out;
-
-		list_del(h);
-		kfree(ace);
-		acl->naces--;
+			if (error)
+				return error;
+			list_del(h);
+			kfree(ace);
+			acl->naces--;
+			break;
+		case NFS4_INHERITANCE_FLAGS & ~NFS4_ACE_INHERIT_ONLY_ACE:
+			/* Add this ace to the default, but leave it in
+			 * the effective acl as well: */
+			error = nfs4_acl_add_ace(dacl, ace->type, ace->flag,
+				ace->access_mask, ace->whotype, ace->who);
+			if (error)
+				return error;
+			break;
+		default:
+			return -EINVAL;
+		}
 	}
-
-out:
-	return error;
+	return 0;
 }
 
 static short
