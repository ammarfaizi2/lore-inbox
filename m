Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751326AbWHRJiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbWHRJiz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 05:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWHRJiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 05:38:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3303 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751326AbWHRJiy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 05:38:54 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <13319.1155744959@warthog.cambridge.redhat.com> 
References: <13319.1155744959@warthog.cambridge.redhat.com>  <1155743399.5683.13.camel@localhost> <20060813133935.b0c728ec.akpm@osdl.org> <20060813012454.f1d52189.akpm@osdl.org> <5910.1155741329@warthog.cambridge.redhat.com> 
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org, aviro@redhat.com,
       Ian Kent <raven@themaw.net>
Subject: [PATCH] NFS: Replace null dentries that appear in readdir's list [try #2]
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Fri, 18 Aug 2006 10:38:44 +0100
Message-ID: <2138.1155893924@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> 
> > Better still, in the case of a negative dentry: just call d_drop().
> 
> How about this then?

Or, rather, this.  Have to remember to discard the old dentry if we don't need
it any more, but since we now have a suitable negative dentry, we can always
instantiate it, and save on an allocation.

I don't think this can race because the parent directory's i_mutex is held by
vfs_readdir() for the duration.

David
---
NFS: Replace null dentries that appear in readdir's list [try #2]

From: David Howells <dhowells@redhat.com>

Have nfs_readdir_lookup() drop and replace any null dentry when it
that gets listed by a READDIR RPC call.

This can be caused by an optimisation in nfs_lookup() that causes a dentry to
be incorrectly left as negative when mkdir() or similar is aborted by SELinux
mid-procedure.

This can be triggered by mounting through autofs4 a server:/ NFS share for
which there are other exports available on that server.  SELinux also has to
be turned on in enforcing mode to abort mid-flow the mkdir operation performed
by autofs4.

The problematic sequence of events is this:

 (1) nfs_lookup() is called by sys_mkdirat() -> lookup_create() ->
     __lookup_hash() with intent to create exclusively set in the nameidata:

	nd->flags == LOOKUP_CREATE
	nd->intent.open.flags == O_EXCL

 (2) nfs_lookup() has an optimisation to avoid going to the server in this
     case, presumably since the nfs_mkdir() op or whatever will deal with the
     conflict.

 (3) nfs_lookup() returns successfully, leaving the dentry in a negative state,
     but attached to the parent directory.

 (4) sys_mkdirat() calls vfs_mkdir() which calls may_create().  may_create()
     checks that the directory has MAY_WRITE and MAY_EXEC permissions.

 (5) may_create() calls nfs_permission(), which grants permission.

 (6) may_create() calls security_inode_permission(), which calls SELinux, which
     then _DENIES_ permission.

 (7) may_create() fails, and vfs_mkdir() then fails and sys_mkdirat() then
     fails (as does sys_mkdir).

     _However_, the new dentry is left in the negative state, with no
     consultation of the server.

 (8) The parent directory is listed, and the name of the new dentry is
     returned.

 (9) stat on the new dentry fails (because it's negative), and "ls -l" returns
     "?---------" as the file type and mode.

This fix makes step (8) replace the dentry looked up in steps (1) - (3).

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/nfs/dir.c |   27 ++++++++++++++++++++-------
 1 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index e746ed1..3c5e2ed 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1105,14 +1105,27 @@ static struct dentry *nfs_readdir_lookup
 	}
 	name.hash = full_name_hash(name.name, name.len);
 	dentry = d_lookup(parent, &name);
-	if (dentry != NULL)
-		return dentry;
-	if (!desc->plus || !(entry->fattr->valid & NFS_ATTR_FATTR))
-		return NULL;
-	/* Note: caller is already holding the dir->i_mutex! */
-	dentry = d_alloc(parent, &name);
-	if (dentry == NULL)
+	if (dentry != NULL) {
+		if (IS_ERR(dentry) || dentry->d_inode)
+			return dentry;
+
+		/* this negative dentry matched a dirent obtained from readdir
+		 * and so needs reconsideration */
+		d_drop(dentry);
+
+		if (!desc->plus || !(entry->fattr->valid & NFS_ATTR_FATTR)) {
+			dput(dentry);
+			return NULL;
+		}
+	} else if (!desc->plus || !(entry->fattr->valid & NFS_ATTR_FATTR)) {
 		return NULL;
+	} else {
+		/* Note: caller is already holding the dir->i_mutex! */
+		dentry = d_alloc(parent, &name);
+		if (dentry == NULL)
+			return NULL;
+	}
+
 	dentry->d_op = NFS_PROTO(dir)->dentry_ops;
 	inode = nfs_fhget(dentry->d_sb, entry->fh, entry->fattr);
 	if (IS_ERR(inode)) {
