Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946557AbWKAFqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946557AbWKAFqo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946556AbWKAFqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:46:15 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:54236 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946551AbWKAFpZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:45:25 -0500
Message-Id: <20061101054456.413503000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:34:33 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Trond Myklebust <Trond.Myklebust@netapp.com>
Subject: [PATCH 53/61] NFS: nfs_lookup - dont hash dentry when optimising away the lookup
Content-Disposition: inline; filename=nfs-nfs_lookup-don-t-hash-dentry-when-optimising-away-the-lookup.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Trond Myklebust <Trond.Myklebust@netapp.com>

If the open intents tell us that a given lookup is going to result in a,
exclusive create, we currently optimize away the lookup call itself. The
reason is that the lookup would not be atomic with the create RPC call, so
why do it in the first place?

A problem occurs, however, if the VFS aborts the exclusive create operation
after the lookup, but before the call to create the file/directory: in this
case we will end up with a hashed negative dentry in the dcache that has
never been looked up.
Fix this by only actually hashing the dentry once the create operation has
been successfully completed.

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 fs/nfs/dir.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--- linux-2.6.18.1.orig/fs/nfs/dir.c
+++ linux-2.6.18.1/fs/nfs/dir.c
@@ -902,9 +902,15 @@ static struct dentry *nfs_lookup(struct 
 
 	lock_kernel();
 
-	/* If we're doing an exclusive create, optimize away the lookup */
-	if (nfs_is_exclusive_create(dir, nd))
-		goto no_entry;
+	/*
+	 * If we're doing an exclusive create, optimize away the lookup
+	 * but don't hash the dentry.
+	 */
+	if (nfs_is_exclusive_create(dir, nd)) {
+		d_instantiate(dentry, NULL);
+		res = NULL;
+		goto out_unlock;
+	}
 
 	error = NFS_PROTO(dir)->lookup(dir, &dentry->d_name, &fhandle, &fattr);
 	if (error == -ENOENT)
@@ -1156,6 +1162,8 @@ int nfs_instantiate(struct dentry *dentr
 	if (IS_ERR(inode))
 		goto out_err;
 	d_instantiate(dentry, inode);
+	if (d_unhashed(dentry))
+		d_rehash(dentry);
 	return 0;
 out_err:
 	d_drop(dentry);

--
