Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130805AbQKRTLn>; Sat, 18 Nov 2000 14:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130871AbQKRTLX>; Sat, 18 Nov 2000 14:11:23 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:8486 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S130805AbQKRTLR>; Sat, 18 Nov 2000 14:11:17 -0500
Date: Sat, 18 Nov 2000 19:40:58 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext2 largefile fixes + [f]truncate() error value fix
Message-ID: <20001118194058.C24555@athlon.random>
In-Reply-To: <Pine.GSO.4.21.0011180503110.19917-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0011180503110.19917-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sat, Nov 18, 2000 at 05:28:46AM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2000 at 05:28:46AM -0500, Alexander Viro wrote:
> +       setattr:        ext2_notify_change,

:)

> +	if (iattr->ia_valid & ATTR_SIZE) {
> +		if (iattr->ia_size > inode->i_sb->u.ext2_sb.s_max_size) {
> +			retval = -EFBIG;
> +			goto out;
> +		}
> +	}

That's not nearly enough, you should also resurrect all the stuff from
2.2.x, I'm wondering how this code disappeared from 2.4.x (actually the size <0
can't happen of course since the caller is trusted and the SIGXFSZ could
probably be moved to the VFS but the largefile is definitely an ext2 business):

	if (iattr->ia_valid & ATTR_SIZE) {
		loff_t size = iattr->ia_size;
		unsigned long limit = current->rlim[RLIMIT_FSIZE].rlim_cur;

		if (size < 0)
			return -EINVAL;
		if (size > ext2_max_sizes[EXT2_BLOCK_SIZE_BITS(inode->i_sb)])
			return -EFBIG;
		if (limit != RLIM_INFINITY && size > limit) {
			send_sig(SIGXFSZ, current, 0);
			return -EFBIG;
		}

		if (size >> 33) {
			struct super_block *sb = inode->i_sb;
			struct ext2_super_block *es = sb->u.ext2_sb.s_es;
			if (!(es->s_feature_ro_compat &
			      cpu_to_le32(EXT2_FEATURE_RO_COMPAT_LARGE_FILE))){
				/* If this is the first large file
				 * created, add a flag to the superblock */
				es->s_feature_ro_compat |=
				cpu_to_le32(EXT2_FEATURE_RO_COMPAT_LARGE_FILE);
				mark_buffer_dirty(sb->u.ext2_sb.s_sbh, 1);
			}
		}
	}

and btw the large file feature setting seems missing also from write(2) ext2
in 2.4.x, confirm?

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
