Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161167AbWI2DJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161167AbWI2DJT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 23:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161141AbWI2DJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 23:09:12 -0400
Received: from ns.suse.de ([195.135.220.2]:46225 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161167AbWI2DJF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 23:09:05 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 29 Sep 2006 13:08:58 +1000
Message-Id: <1060929030858.24062@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 004 of 8] knfsd: Close a race-opportunity in d_splice_alias
References: <20060929130518.23919.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There is a possible race in d_splice_alias.
Though __d_find_alias(inode, 1) will only return a dentry
with DCACHE_DISCONNECTED set, it is possible for it to get cleared
before the BUG_ON, and it is is not possible to lock against that.

There are a couple of problems here.
Firstly, the code doesn't match the comment.  The comment describes
a 'disconnected' dentry as being IS_ROOT as well as DCACHE_DISCONNECTED,
however there is not testing of IS_ROOT anythere.

A dentry is marked DCACHE_DISCONNECTED when allocated with
d_alloc_anon, and remains DCACHE_DISCONNECTED while a path is built up
towards the root.  So a dentry can have a valid name and a valid
parent and even grandparent, but will still be DCACHE_DISCONNECTED
until a path to the root is created.  Once the path to the root is
complete, everything in the path gets DCACHE_DISCONNECTED cleared.  So
the fact that DCACHE_DISCONNECTED isn't enough to say that a dentry is
free to be spliced in with a given name.  This can only be allowed if
the dentry does not yet have a name, so the IS_ROOT test is needed too.

However even adding that test to __d_find_alias isn't enough.  As
d_splice_alias drops dcache_lock before calling d_move to perform the
splice, it could race with another thread calling d_splice_alias to
splice the inode in with a different name in a different part of the
tree (in the case where a file has hard links).  So that splicing code
is only really safe for directories (as we know that directories only
have one link).  For directories, the caller of d_splice_alias will be
holding i_mutex on the (unique) parent so there is no room for a race.

A consequence of this is that a non-directory will never benefit from
being spliced into a pre-exisiting dentry, but that isn't a problem.
It is perfectly OK for a non-directory to have multiple dentries, some
anonymous, some not.  And the comment for d_splice_alias says that it
only happens for directories anyway.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/dcache.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff .prev/fs/dcache.c ./fs/dcache.c
--- .prev/fs/dcache.c	2006-09-29 12:57:26.000000000 +1000
+++ ./fs/dcache.c	2006-09-29 12:57:34.000000000 +1000
@@ -291,9 +291,9 @@ struct dentry * dget_locked(struct dentr
  * it can be unhashed only if it has no children, or if it is the root
  * of a filesystem.
  *
- * If the inode has a DCACHE_DISCONNECTED alias, then prefer
+ * If the inode has an IS_ROOT, DCACHE_DISCONNECTED alias, then prefer
  * any other hashed alias over that one unless @want_discon is set,
- * in which case only return a DCACHE_DISCONNECTED alias.
+ * in which case only return an IS_ROOT, DCACHE_DISCONNECTED alias.
  */
 
 static struct dentry * __d_find_alias(struct inode *inode, int want_discon)
@@ -309,7 +309,8 @@ static struct dentry * __d_find_alias(st
 		prefetch(next);
 		alias = list_entry(tmp, struct dentry, d_alias);
  		if (S_ISDIR(inode->i_mode) || !d_unhashed(alias)) {
-			if (alias->d_flags & DCACHE_DISCONNECTED)
+			if (IS_ROOT(alias) &&
+			    (alias->d_flags & DCACHE_DISCONNECTED))
 				discon_alias = alias;
 			else if (!want_discon) {
 				__dget_locked(alias);
@@ -1134,7 +1135,7 @@ struct dentry *d_splice_alias(struct ino
 {
 	struct dentry *new = NULL;
 
-	if (inode) {
+	if (inode && S_ISDIR(inode->i_mode)) {
 		spin_lock(&dcache_lock);
 		new = __d_find_alias(inode, 1);
 		if (new) {
