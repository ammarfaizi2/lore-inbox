Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132157AbRADS7M>; Thu, 4 Jan 2001 13:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132150AbRADS7C>; Thu, 4 Jan 2001 13:59:02 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:37352 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131086AbRADS6s>;
	Thu, 4 Jan 2001 13:58:48 -0500
Date: Thu, 4 Jan 2001 13:58:47 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Mason <mason@suse.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fsync on unmounting root
In-Reply-To: <99660000.978634079@tiny>
Message-ID: <Pine.GSO.4.21.0101041354530.20875-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Jan 2001, Chris Mason wrote:

> Hi guys,
> 
> Looks like the prerelease, and at least test13 don't fsync the device when
> someone does an unmount on /
> 
> mount -o remount works, just unmounting the root misses the fsync.
> 
> This patch works for me:
> 
> -chris
> 
> --- linux/fs/super.c.1	Thu Jan  4 13:38:55 2001
> +++ linux/fs/super.c	Thu Jan  4 13:38:39 2001
> @@ -1031,8 +1031,12 @@
>  		 * we just try to remount it readonly.
>  		 */
>  		mntput(mnt);
> -		if (!(sb->s_flags & MS_RDONLY)) 
> +		if (!(sb->s_flags & MS_RDONLY)) {
> +			shrink_dcache_sb(sb);
> +			fsync_dev(sb->s_dev);
> +			acct_auto_close(sb->s_dev);
>  			retval = do_remount_sb(sb, MS_RDONLY, 0);
> +		}

I have a better suggestion: 

        if (mnt == current->fs->rootmnt && !umount_root) {
                mntput(mnt);
		return do_remount("/", 0, NULL);
	}

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
