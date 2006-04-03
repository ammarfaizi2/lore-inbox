Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751480AbWDCFUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbWDCFUP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 01:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbWDCFUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 01:20:15 -0400
Received: from mail.suse.de ([195.135.220.2]:39605 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751476AbWDCFUL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 01:20:11 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 3 Apr 2006 15:18:23 +1000
Message-Id: <1060403051823.1771@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 004 of 16] knfsd: nfsd4: fix acl xattr length return
References: <20060403151452.1567.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We should be using the length from the second vfs_getxattr, in case it
changed.  (Note: there's still a small race here; we could end up returning
-ENOMEM if the length increased between the first and second call.  I don't
know whether it's worth spending a lot of effort to fix that.)

This makes XFS ACLs usable on NFS exports, which they currently aren't,
since XFS appears to be returning a too-large value for vfs_getxattr() when
it's passed a NULL buffer.  So there's probably an XFS bug here too, though
since getxattr with a NULL buffer is usually used to decide how much memory
to allocate, it may be a fairly harmless bug in most cases.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/vfs.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff ./fs/nfsd/vfs.c~current~ ./fs/nfsd/vfs.c
--- ./fs/nfsd/vfs.c~current~	2006-04-03 15:12:07.000000000 +1000
+++ ./fs/nfsd/vfs.c	2006-04-03 15:12:07.000000000 +1000
@@ -371,7 +371,6 @@ out_nfserr:
 static ssize_t nfsd_getxattr(struct dentry *dentry, char *key, void **buf)
 {
 	ssize_t buflen;
-	int error;
 
 	buflen = vfs_getxattr(dentry, key, NULL, 0);
 	if (buflen <= 0)
@@ -381,10 +380,7 @@ static ssize_t nfsd_getxattr(struct dent
 	if (!*buf)
 		return -ENOMEM;
 
-	error = vfs_getxattr(dentry, key, *buf, buflen);
-	if (error < 0)
-		return error;
-	return buflen;
+	return vfs_getxattr(dentry, key, *buf, buflen);
 }
 #endif
 
