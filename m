Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262924AbVF3KMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262924AbVF3KMo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 06:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbVF3KMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 06:12:43 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:10941 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262924AbVF3KMT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 06:12:19 -0400
Date: Thu, 30 Jun 2005 12:13:37 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Mahoney <jeffm@suse.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] reiserfs: enable attrs by default if saf
Message-ID: <20050630101334.GJ2243@suse.de>
References: <20050629225306.GA7287@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050629225306.GA7287@locomotive.unixthugs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29 2005, Jeff Mahoney wrote:
> 
>  The following patch enables attrs by default if the reiserfs_attrs_cleared
>  bit is set in the superblock. This allows chattr-type attrs to be used
>  without any further action by the user.
> 
>  Please apply.
> 
> Signed-off-by: Jeff Mahoney <jeffm@suse.com>
>  
> diff -ruNpX dontdiff linux-2.6.12-rc6/fs/reiserfs/super.c linux-2.6.12-rc6.devel/fs/reiserfs/super.c
> --- linux-2.6.12-rc6/fs/reiserfs/super.c	2005-06-13 14:34:58.000000000 -0400
> +++ linux-2.6.12-rc6.devel/fs/reiserfs/super.c	2005-06-22 17:34:55.000000000 -0400
> @@ -884,6 +884,8 @@ static void handle_attrs( struct super_b
>  				reiserfs_warning(s, "reiserfs: cannot support attributes until flag is set in super-block" );
>  				REISERFS_SB(s) -> s_mount_opt &= ~ ( 1 << REISERFS_ATTRS );
>  		}
> +	} else if (le32_to_cpu( rs -> s_flags ) & reiserfs_attrs_cleared) {
> +		REISERFS_SB(s)->s_mount_opt |= REISERFS_ATTRS;
>  	}
>  }

Except rs isn't initialized there, causing a compile warning and a crash
booting the resulting kernel when reiser mounts...

Signed-off-by: Jens Axboe <axboe@suse.de>

diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -1053,10 +1053,9 @@ static void handle_barrier_mode(struct s
 
 static void handle_attrs( struct super_block *s )
 {
-	struct reiserfs_super_block * rs;
+	struct reiserfs_super_block * rs = SB_DISK_SUPER_BLOCK (s);
 
 	if( reiserfs_attrs( s ) ) {
-		rs = SB_DISK_SUPER_BLOCK (s);
 		if( old_format_only(s) ) {
 			reiserfs_warning(s, "reiserfs: cannot support attributes on 3.5.x disk format" );
 			REISERFS_SB(s) -> s_mount_opt &= ~ ( 1 << REISERFS_ATTRS );

-- 
Jens Axboe

