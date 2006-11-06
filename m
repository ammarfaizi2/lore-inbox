Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753881AbWKFW17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753881AbWKFW17 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 17:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753879AbWKFW17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 17:27:59 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:64961 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1753878AbWKFW16 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 17:27:58 -0500
Subject: Re: [RFC/PATCH] - revert generic_fillattr stat->blksize to
	PAGE_CACHE_SIZE
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Eric Sandeen <sandeen@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       Theodore Tso <tytso@mit.edu>, Steve French <smfltc@us.ibm.com>
In-Reply-To: <454FAE0A.3070409@redhat.com>
References: <454FAE0A.3070409@redhat.com>
Content-Type: text/plain
Date: Mon, 06 Nov 2006 16:27:48 -0600
Message-Id: <1162852069.11030.70.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-06 at 15:50 -0600, Eric Sandeen wrote:
> The inode diet patches first did this to generic_fillattr():
> 
> -	stat->blksize = inode->i_blksize;
> +	stat->blksize = PAGE_CACHE_SIZE;
> 
> but by 2.6.19-rc3 this was changed again:
> 
> -	stat->blksize = PAGE_CACHE_SIZE;
> +	stat->blksize = (1 << inode->i_blkbits);
> 
> I can't find for sure why this was done; perhaps because it exposed a bug
> in cifs[1]

Steve has fixed the bug in cifs_readdir().

> However, if we are going to pick a default for generic_fillattr, it should probably
> be what most filesystems were using before, and let filesystems which need something
> else re-set it to according to their needs.  As it stands today, doing readdirs and
> the like in block-sized chunks rather than page sized will probably not be the
> best thing for performance.

I agree.

> 
> so I would propose the following patch to make PAGE_CACHE_SIZE the default (again), 
> and let filesystems which need something -else- do that on their own.
> 
> [1] http://lists.samba.org/archive/linux-cifs-client/2006-September/001481.html
> 
> Thanks,
> -Eric
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> 
> --- linux.orig/fs/stat.c	2006-11-05 23:27:04.962482569 -0600
> +++ linux/fs/stat.c	2006-11-05 23:27:29.394396050 -0600
> @@ -33,7 +33,7 @@
>   	stat->ctime = inode->i_ctime;
>   	stat->size = i_size_read(inode);
>   	stat->blocks = inode->i_blocks;
> -	stat->blksize = (1 << inode->i_blkbits);
> +	stat->blksize = PAGE_CACHE_SIZE;
>   }
> 
>   EXPORT_SYMBOL(generic_fillattr);

Looks good.  Since cifs is affected by this patch, I propose that cifs
explicitly set stat->blksize:

CIFS: Explicitly set stat->blksize

CIFS may perform I/O over the network in larger chunks than the page size,
so it should explicitly set stat->blksize to ensure optimal I/O bandwidth

Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>

diff -Nurp linux.orig/fs/cifs/inode.c linux/fs/cifs/inode.c
--- linux.orig/fs/cifs/inode.c	2006-11-03 13:44:04.000000000 -0600
+++ linux/fs/cifs/inode.c	2006-11-06 16:11:21.000000000 -0600
@@ -1089,8 +1089,10 @@ int cifs_getattr(struct vfsmount *mnt, s
 	struct kstat *stat)
 {
 	int err = cifs_revalidate(dentry);
-	if (!err)
+	if (!err) {
 		generic_fillattr(dentry->d_inode, stat);
+		stat->blksize = CIFS_MAX_MSGSIZE;
+	}
 	return err;
 }
 

-- 
David Kleikamp
IBM Linux Technology Center

