Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965094AbWIECYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965094AbWIECYE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 22:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965087AbWIECYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 22:24:04 -0400
Received: from pat.uio.no ([129.240.10.4]:62865 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S965093AbWIECYB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 22:24:01 -0400
Subject: Re: [PATCH 0/7] Permit filesystem local caching and NFS superblock
	sharing [try #13]
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, steved@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org,
       Ian Kent <raven@themaw.net>
In-Reply-To: <28945.1157370732@warthog.cambridge.redhat.com>
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
Content-Type: multipart/mixed; boundary="=-KPxuLDxdBiwDjLdCSniU"
Date: Mon, 04 Sep 2006 22:23:47 -0400
Message-Id: <1157423027.5510.23.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.273, required 12,
	autolearn=disabled, AWL 1.73, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-KPxuLDxdBiwDjLdCSniU
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2006-09-04 at 12:52 +0100, David Howells wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > sony:/home/akpm> ls -l /net/bix/usr/src
> > total 0
> > 
> > sony:/home/akpm> showmount -e bix
> > Export list for bix:
> > /           *
> > /usr/src    *
> > /mnt/export *
> 
> Yes, but what's your /etc/exports now?  Not all options appear to showmount.
> 
> Can you add "nohide" to the /usr/src and /mnt/export lines and "fsid=0" to the
> / line if you don't currently have them and try again?
> 
> > iirc, we decided this is related to the fs-cache infrastructure work which
> > went into git-nfs.  I think David can reproduce this?
> 
> I'd only reproduced it with SELinux in enforcing mode.
> 
> Under such conditions, unless there's a readdir on the root directory, the
> subdirs under which exports exist will remain as incorrectly negative
> dentries.
> 
> The problem is a conjunction of circumstances:
> 
>  (1) nfs_lookup() has a shortcut in it that skips contact with the server if
>      we're doing a lookup with intent to create.  This leaves an incorrectly
>      negative dentry if there _is_ actually an object on the server.
> 
>  (2) The mkdir procedure is aborted between the lookup() op and the mkdir() op
>      by SELinux (see vfs_mkdir()).  Note that SELinux isn't the _only_ method
>      by which the abort can occur.
> 
>  (3) One of my patches correctly assigns the security label to the automounted
>      root dentry.
> 
>  (4) SELinux then aborts the automounter's mkdir() call because the automounter
>      does _not_ carry the correct security label to write to the NFS directory.
> 
>  (5) The incorrectly set up dentry from (1) remains because the the mkdir() op
>      is not invoked to set it right.
> 
> The only bit I added was (3), but that's not the only circumstance in which
> this can occur.
> 
> 
> If, for example, I do "chmod a-w /" on the NFS server, I can see the same
> effects on the client without the need for SELinux to put its foot in the door.
> Automount does:
> 
> [pid  3838] mkdir("/net", 0555)         = -1 EEXIST (File exists)
> [pid  3838] stat64("/net", {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
> [pid  3838] mkdir("/net/trash", 0555)   = -1 EEXIST (File exists)
> [pid  3838] stat64("/net/trash", {st_mode=S_IFDIR|0555, st_size=1024, ...}) = 0
> [pid  3838] mkdir("/net/trash/mnt", 0555) = -1 EACCES (Permission denied)
> 
> And where I was listing the disputed directory, I see:
> 
> 	[root@andromeda ~]# ls -lad /net/trash/usr/src
> 	drwxr-xr-x 4 root root 1024 Aug 30 10:35 /net/trash/usr/src/
> 	[root@andromeda ~]#
> 
> which isn't what I'd expect.  What I'd expect is:
> 
> 	[root@andromeda ~]# ls -l /net/trash/usr/src
> 	total 15
> 	drwxr-xr-x 3 root root  1024 Aug 30 10:35 debug/
> 	-rw-r--r-- 1 root root     0 Aug 16 10:01 hello
> 	drwx------ 2 root root 12288 Aug 16 10:00 lost+found/
> 	[root@andromeda ~]#

One way to fix this is to simply not hash the dentry when we're doing
the O_EXCL intent optimisation, but rather to only hash it _after_ we've
successfully created the file on the server. Something like the attached
patch ought to do it.

Note, though, that this will not fix the autofs problem: autofs is
trying to perform a totally unnecessary mkdir(), and is giving up when
it is told that SELinux won't authorise that particular operation. This
is clearly an autofs bug...

Cheers,
  Trond

--=-KPxuLDxdBiwDjLdCSniU
Content-Disposition: inline; filename=linux-2.6.18-063-fix_exclusive_create.dif
Content-Type: message/rfc822; name=linux-2.6.18-063-fix_exclusive_create.dif

From: Trond Myklebust <Trond.Myklebust@netapp.com>
Date: 
NFS: nfs_lookup - don't hash dentry when optimising away the lookup
Subject: No Subject
Message-Id: <1157422828.5510.19.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/dir.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 51328ae..e83a2ff 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -904,9 +904,14 @@ static struct dentry *nfs_lookup(struct 
 
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
+		goto out_unlock;
+	}
 
 	error = NFS_PROTO(dir)->lookup(dir, &dentry->d_name, &fhandle, &fattr);
 	if (error == -ENOENT)
@@ -1161,6 +1166,8 @@ int nfs_instantiate(struct dentry *dentr
 	if (IS_ERR(inode))
 		return error;
 	d_instantiate(dentry, inode);
+	if (d_unhashed(dentry))
+		d_rehash(dentry);
 	return 0;
 }
 

--=-KPxuLDxdBiwDjLdCSniU--

