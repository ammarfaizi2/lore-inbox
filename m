Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965155AbWIEE5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965155AbWIEE5S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 00:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965153AbWIEE5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 00:57:18 -0400
Received: from pat.uio.no ([129.240.10.4]:12711 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S965149AbWIEE5Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 00:57:16 -0400
Subject: Re: [PATCH 0/7] Permit filesystem local caching and NFS superblock
	sharing [try #13]
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Ian Kent <raven@themaw.net>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, steved@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1157429219.3915.11.camel@raven.themaw.net>
References: <20060901195009.187af603.akpm@osdl.org>
	 <20060831102127.8fb9a24b.akpm@osdl.org>
	 <20060830135503.98f57ff3.akpm@osdl.org>
	 <20060830125239.6504d71a.akpm@osdl.org>
	 <20060830193153.12446.24095.stgit@warthog.cambridge.redhat.com>
	 <27414.1156970238@warthog.cambridge.redhat.com>
	 <9849.1157018310@warthog.cambridge.redhat.com>
	 <9534.1157116114@warthog.cambridge.redhat.com>
	 <20060901093451.87aa486d.akpm@osdl.org>
	 <1157130044.5632.87.camel@localhost>
	 <28945.1157370732@warthog.cambridge.redhat.com>
	 <1157423027.5510.23.camel@localhost>
	 <1157429219.3915.11.camel@raven.themaw.net>
Content-Type: multipart/mixed; boundary="=-EYvKbG5nnZ2BULxojOOW"
Date: Tue, 05 Sep 2006 00:57:01 -0400
Message-Id: <1157432221.32412.41.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.183, required 12,
	autolearn=disabled, AWL 1.82, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-EYvKbG5nnZ2BULxojOOW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2006-09-05 at 12:06 +0800, Ian Kent wrote:

> > One way to fix this is to simply not hash the dentry when we're doing
> > the O_EXCL intent optimisation, but rather to only hash it _after_ we've
> > successfully created the file on the server. Something like the attached
> > patch ought to do it.
> 
> No.
> 
> This patch simply marks the dentry negative and returns ENOMEM from the
> lookup which, as would be expected, results in this error being returned
> to userspace.

Oops. You are right. I forgot to set res=NULL...



--=-EYvKbG5nnZ2BULxojOOW
Content-Disposition: inline; filename=linux-2.6.18-063-fix_exclusive_create.dif
Content-Type: message/rfc822; name=linux-2.6.18-063-fix_exclusive_create.dif

From: Trond Myklebust <Trond.Myklebust@netapp.com>
Date: 
NFS: nfs_lookup - don't hash dentry when optimising away the lookup
Subject: No Subject
Message-Id: <1157432220.32412.40.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/dir.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 51328ae..3419c2d 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -904,9 +904,15 @@ static struct dentry *nfs_lookup(struct 
 
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
@@ -1161,6 +1167,8 @@ int nfs_instantiate(struct dentry *dentr
 	if (IS_ERR(inode))
 		return error;
 	d_instantiate(dentry, inode);
+	if (d_unhashed(dentry))
+		d_rehash(dentry);
 	return 0;
 }
 

--=-EYvKbG5nnZ2BULxojOOW--

