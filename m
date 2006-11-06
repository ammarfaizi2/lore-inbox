Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753892AbWKFWhd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753892AbWKFWhd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 17:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753891AbWKFWhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 17:37:32 -0500
Received: from mx1.redhat.com ([66.187.233.31]:61346 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1753888AbWKFWhb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 17:37:31 -0500
Message-ID: <454FB918.9090007@redhat.com>
Date: Mon, 06 Nov 2006 16:37:12 -0600
From: Eric Sandeen <sandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
CC: Eric Sandeen <sandeen@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       Theodore Tso <tytso@mit.edu>, Steve French <smfltc@us.ibm.com>
Subject: Re: [RFC/PATCH] - revert generic_fillattr stat->blksize to	PAGE_CACHE_SIZE
References: <454FAE0A.3070409@redhat.com> <1162852069.11030.70.camel@kleikamp.austin.ibm.com>
In-Reply-To: <1162852069.11030.70.camel@kleikamp.austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Kleikamp wrote:
ooks good.  Since cifs is affected by this patch, I propose that cifs
> explicitly set stat->blksize:
> 
> CIFS: Explicitly set stat->blksize
> 
> CIFS may perform I/O over the network in larger chunks than the page size,
> so it should explicitly set stat->blksize to ensure optimal I/O bandwidth
> 
> Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
> 
> diff -Nurp linux.orig/fs/cifs/inode.c linux/fs/cifs/inode.c
> --- linux.orig/fs/cifs/inode.c	2006-11-03 13:44:04.000000000 -0600
> +++ linux/fs/cifs/inode.c	2006-11-06 16:11:21.000000000 -0600
> @@ -1089,8 +1089,10 @@ int cifs_getattr(struct vfsmount *mnt, s
>  	struct kstat *stat)
>  {
>  	int err = cifs_revalidate(dentry);
> -	if (!err)
> +	if (!err) {
>  		generic_fillattr(dentry->d_inode, stat);
> +		stat->blksize = CIFS_MAX_MSGSIZE;
> +	}
>  	return err;
>  }

Yep, I agree that this should go in too.  Other filesystems probably
need to recover from the crash diet as well :)

Thanks,
-Eric
