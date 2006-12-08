Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424751AbWLHGQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424751AbWLHGQr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 01:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424755AbWLHGQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 01:16:46 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:46454 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424750AbWLHGQp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 01:16:45 -0500
Date: Fri, 8 Dec 2006 01:16:41 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Jeff Layton <jlayton@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] ensure unique i_ino in filesystems without permanent inode numbers (libfs superblock cleanup)
Message-ID: <20061208061641.GA24255@filer.fsl.cs.sunysb.edu>
References: <457891F4.8030501@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <457891F4.8030501@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2006 at 05:13:08PM -0500, Jeff Layton wrote:
> This patch ensures that the inodes allocated by the functions get_sb_pseudo
> and simple_fill_super are unique, provided of course, that the filesystems
> calling them play by the rules. Currently that isn't the case, but will be
> as I get to each of the filesystems.
> 
> The patch itself is pretty simple, but I also had to fix up the callers of
> simple_fill_super to make sure they passed in the seq flag. For this first
> pass, I set it on any filesystem with an empty "files" struct to 0. That may
> need to be revised as I review each filesystem, but should be OK for now.
> 
> Signed-off-by: Jeff Layton <jlayton@redhat.com>
> 
> diff --git a/drivers/infiniband/hw/ipath/ipath_fs.c 
> b/drivers/infiniband/hw/ipath/ipath_fs.c
> index d9ff283..c127995 100644
> --- a/drivers/infiniband/hw/ipath/ipath_fs.c
> +++ b/drivers/infiniband/hw/ipath/ipath_fs.c
> @@ -514,7 +514,7 @@ static int ipathfs_fill_super(struct sup
>  		{""},
>  	};
> 
> -	ret = simple_fill_super(sb, IPATHFS_MAGIC, files);
> +	ret = simple_fill_super(sb, IPATHFS_MAGIC, files, 1);

I don't know...the magic looking 1 and 0 (later in the patch) seem a bit
arbitrary. Maybe a #define is in order?

> -int simple_fill_super(struct super_block *s, int magic, struct tree_descr 
> *files)
> +/*
> + * Some filesystems require that particular entries have particular i_ino 
> values. Those
> + * callers need to set the "seq" flag to make sure that i_ino is assigned 
> sequentially
> + * to the files starting with 0.
> + */
> +int simple_fill_super(struct super_block *s, int magic, struct tree_descr 
> *files, int seq)

Line wraped.

> @@ -399,7 +407,10 @@ int simple_fill_super(struct super_block
>  		inode->i_blocks = 0;
>  		inode->i_atime = inode->i_mtime = inode->i_ctime = 
>  		CURRENT_TIME;

I'd indent CURRENT_TIME a bit.

Josef "Jeff" Sipek.

-- 
If I have trouble installing Linux, something is wrong. Very wrong.
		- Linus Torvalds
