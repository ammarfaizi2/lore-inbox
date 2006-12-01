Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967699AbWLAR5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967699AbWLAR5l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 12:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759308AbWLAR5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 12:57:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:12746 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1759307AbWLAR5k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 12:57:40 -0500
Subject: Re: [GFS2] Fix incorrect fs sync behaviour [2/5]
From: Russell Cattelan <cattelan@redhat.com>
To: Steven Whitehouse <steve@chygwyn.com>
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <1162811279.18219.32.camel@quoit.chygwyn.com>
References: <1162811279.18219.32.camel@quoit.chygwyn.com>
Content-Type: text/plain
Date: Fri, 01 Dec 2006 11:57:32 -0600
Message-Id: <1164995853.1194.42.camel@xenon.msp.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1-1mdv2007.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-06 at 11:07 +0000, Steven Whitehouse wrote:
> >From 4a221953ed121692aa25998451a57c7f4be8b4f6 Mon Sep 17 00:00:00 2001
> From: Steven Whitehouse <swhiteho@redhat.com>
> Date: Wed, 1 Nov 2006 09:57:57 -0500
> Subject: [PATCH] [GFS2] Fix incorrect fs sync behaviour.
> 
> This adds a sync_fs superblock operation for GFS2 and removes
> the journal flush from write_super in favour of sync_fs where it
> ought to be. This is more or less identical to the way in which ext3
> does this.
> 
> This bug was pointed out by Russell Cattelan <cattelan@redhat.com>
> 
> Cc: Russell Cattelan <cattelan@redhat.com>
> Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
> ---
>  fs/gfs2/ops_super.c |   44 ++++++++++++++++++++++++++++----------------
>  1 files changed, 28 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/gfs2/ops_super.c b/fs/gfs2/ops_super.c
> index 06f06f7..b47d959 100644
> --- a/fs/gfs2/ops_super.c
> +++ b/fs/gfs2/ops_super.c
> @@ -138,16 +138,27 @@ static void gfs2_put_super(struct super_
>  }
>  
>  /**
> - * gfs2_write_super - disk commit all incore transactions
> - * @sb: the filesystem
> + * gfs2_write_super
> + * @sb: the superblock
>   *
> - * This function is called every time sync(2) is called.
> - * After this exits, all dirty buffers are synced.
>   */
>  
>  static void gfs2_write_super(struct super_block *sb)
>  {
> +	sb->s_dirt = 0;
This is a bit different than my original patch? 
Are you sure we don't need the s_lock here?


> +}
> +
> +/**
> + * gfs2_sync_fs - sync the filesystem
> + * @sb: the superblock
> + *
> + * Flushes the log to disk.
> + */
> +static int gfs2_sync_fs(struct super_block *sb, int wait)
> +{
> +	sb->s_dirt = 0;
>  	gfs2_log_flush(sb->s_fs_info, NULL);
> +	return 0;
>  }
>  
>  /**
> @@ -452,17 +463,18 @@ static void gfs2_destroy_inode(struct in
>  }
>  
>  struct super_operations gfs2_super_ops = {
> -	.alloc_inode = gfs2_alloc_inode,
> -	.destroy_inode = gfs2_destroy_inode,
> -	.write_inode = gfs2_write_inode,
> -	.delete_inode = gfs2_delete_inode,
> -	.put_super = gfs2_put_super,
> -	.write_super = gfs2_write_super,
> -	.write_super_lockfs = gfs2_write_super_lockfs,
> -	.unlockfs = gfs2_unlockfs,
> -	.statfs = gfs2_statfs,
> -	.remount_fs = gfs2_remount_fs,
> -	.clear_inode = gfs2_clear_inode,
> -	.show_options = gfs2_show_options,
> +	.alloc_inode		= gfs2_alloc_inode,
> +	.destroy_inode		= gfs2_destroy_inode,
> +	.write_inode		= gfs2_write_inode,
> +	.delete_inode		= gfs2_delete_inode,
> +	.put_super		= gfs2_put_super,
> +	.write_super		= gfs2_write_super,
> +	.sync_fs		= gfs2_sync_fs,
> +	.write_super_lockfs 	= gfs2_write_super_lockfs,
> +	.unlockfs		= gfs2_unlockfs,
> +	.statfs			= gfs2_statfs,
> +	.remount_fs		= gfs2_remount_fs,
> +	.clear_inode		= gfs2_clear_inode,
> +	.show_options		= gfs2_show_options,
>  };
>  
-- 
Russell Cattelan <cattelan@redhat.com>

