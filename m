Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129571AbQKHR4A>; Wed, 8 Nov 2000 12:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129569AbQKHRzl>; Wed, 8 Nov 2000 12:55:41 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:17404 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S129386AbQKHRze>; Wed, 8 Nov 2000 12:55:34 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200011081755.eA8HtP202048@webber.adilger.net>
Subject: Re: [PATCH] ext2 cpu<->le32 thinkos? (-test10)
In-Reply-To: <20001108190201.A4637@l-t.ee> "from Marko Kreen at Nov 8, 2000 07:02:02
 pm"
To: Marko Kreen <marko@l-t.ee>
Date: Wed, 8 Nov 2000 10:55:25 -0700 (MST)
CC: "Theodore Y. Ts'o" <tytso@mit.edu>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marko writes:
> Reading ext2 code I found some inconsistencies
> in endianess handling, could anyone comment
> on this?

Your fixes look OK to me.  For all architectures the two operations the
two operations are interchangeable, so it hasn't given us any problems.
However, it is good to fix these sort of things to prevent headaches.

> Also there is a unnecessary RDONLY check.

Yes, you are correct.  This is inside ext2_new_inode() which should never
be called for a read-only filesystem in the first place.  If it is, this
check won't help us anyways since it is only inside an error path, and
the code is much more broken than this.

Cheers, Andreas

> diff -urNX /home/marko/misc/diff-exclude fs/ext2.orig/ialloc.c fs/ext2/ialloc.c
> --- fs/ext2.orig/ialloc.c	Fri Oct  6 22:49:00 2000
> +++ fs/ext2/ialloc.c	Wed Nov  8 10:09:23 2000
> @@ -399,11 +399,6 @@
>  			ext2_error (sb, "ext2_new_inode",
>  				    "Free inodes count corrupted in group %d",
>  				    i);
> -			if (sb->s_flags & MS_RDONLY) {
> -				unlock_super (sb);
> -				iput (inode);
> -				return NULL;
> -			}
>  			gdp->bg_free_inodes_count = 0;
>  			mark_buffer_dirty(bh2);
>  		}
> diff -urNX /home/marko/misc/diff-exclude fs/ext2.orig/namei.c fs/ext2/namei.c
> --- fs/ext2.orig/namei.c	Wed Nov  1 20:31:30 2000
> +++ fs/ext2/namei.c	Wed Nov  8 13:46:20 2000
> @@ -242,7 +242,7 @@
>  
>  				de = (struct ext2_dir_entry_2 *) bh->b_data;
>  				de->inode = 0;
> -				de->rec_len = le16_to_cpu(sb->s_blocksize);
> +				de->rec_len = cpu_to_le16(sb->s_blocksize);
>  				dir->i_size = offset + sb->s_blocksize;
>  				dir->u.ext2_i.i_flags &= ~EXT2_BTREE_FL;
>  				mark_inode_dirty(dir);
> @@ -750,7 +750,7 @@
>  		if (retval)
>  			goto end_rename;
>  	} else {
> -		new_de->inode = le32_to_cpu(old_inode->i_ino);
> +		new_de->inode = cpu_to_le32(old_inode->i_ino);
>  		if (EXT2_HAS_INCOMPAT_FEATURE(new_dir->i_sb,
>  					      EXT2_FEATURE_INCOMPAT_FILETYPE))
>  			new_de->file_type = old_de->file_type;
> @@ -785,7 +785,7 @@
>  	old_dir->u.ext2_i.i_flags &= ~EXT2_BTREE_FL;
>  	mark_inode_dirty(old_dir);
>  	if (dir_bh) {
> -		PARENT_INO(dir_bh->b_data) = le32_to_cpu(new_dir->i_ino);
> +		PARENT_INO(dir_bh->b_data) = cpu_to_le32(new_dir->i_ino);
>  		mark_buffer_dirty(dir_bh);
>  		old_dir->i_nlink--;
>  		mark_inode_dirty(old_dir);
> diff -urNX /home/marko/misc/diff-exclude fs/ext2.orig/super.c fs/ext2/super.c
> --- fs/ext2.orig/super.c	Fri Oct  6 22:49:00 2000
> +++ fs/ext2/super.c	Wed Nov  8 10:08:22 2000
> @@ -101,7 +101,7 @@
>  	int i;
>  
>  	if (!(sb->s_flags & MS_RDONLY)) {
> -		sb->u.ext2_sb.s_es->s_state = le16_to_cpu(sb->u.ext2_sb.s_mount_state);
> +		sb->u.ext2_sb.s_es->s_state = cpu_to_le16(sb->u.ext2_sb.s_mount_state);
>  		mark_buffer_dirty(sb->u.ext2_sb.s_sbh);
>  	}
>  	db_count = sb->u.ext2_sb.s_db_per_group;
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 


-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
