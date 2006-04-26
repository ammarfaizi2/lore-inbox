Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964847AbWDZT1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbWDZT1J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 15:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbWDZT1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 15:27:09 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:24765 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S964847AbWDZT1I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 15:27:08 -0400
Date: Wed, 26 Apr 2006 13:27:01 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: sho@tnes.nec.co.jp
Cc: "Theodore Ts'o" <tytso@mit.edu>, "Stephen C. Tweedie" <sct@redhat.com>,
       Ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC][10/21]ext3 enlarge blocksize
Message-ID: <20060426192701.GB10889@schatzie.adilger.int>
Mail-Followup-To: sho@tnes.nec.co.jp, Theodore Ts'o <tytso@mit.edu>,
	"Stephen C. Tweedie" <sct@redhat.com>,
	Ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20060413160831sho@rifu.tnes.nec.co.jp> <20060413160739sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060413160831sho@rifu.tnes.nec.co.jp> <20060413160739sho@rifu.tnes.nec.co.jp>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 13, 2006  16:07 +0900, sho@tnes.nec.co.jp wrote:
>           - Add an incompat flag "EXT3_FEATURE_INCOMPAT_LARGE_BLOCK"
>             which indicates that the filesystem is extended.
>           - Allow block size till pagesize in ext3.
> 
> -	if (blocksize < EXT3_MIN_BLOCK_SIZE ||
> -	    blocksize > EXT3_MAX_BLOCK_SIZE) {
> -		printk(KERN_ERR 
> -		       "EXT3-fs: Unsupported filesystem blocksize %d on %s.\n",
> -		       blocksize, sb->s_id);
> -		goto failed_mount;
> +	if (EXT3_HAS_INCOMPAT_FEATURE(sb,
> +	    EXT3_FEATURE_INCOMPAT_LARGE_BLOCK)) {
> +		if (blocksize < EXT3_MIN_BLOCK_SIZE ||
> +		    blocksize > PAGE_SIZE ||
> +		    blocksize > EXT3_EXTENDED_MAX_BLOCK_SIZE) {

This in itself doesn't need an incompatible flag, since old kernels will
prevent the mount for filesystems with blocksize > EXT3_MAX_BLOCK_SIZE
anyways.  It is already incompatible with older kernels, and isn't really
related to the other use of this flag - changing the i_blocks field to
handle files > 2TB.

> +			printk(KERN_ERR "EXT3-fs: Unsupported extended filesystem blocksize %d on %s.\n",
> +				blocksize, sb->s_id);

May be better to have:

+			printk(KERN_ERR "EXT3-fs: cannot mount filesystem with "
+			       "blocksize %u larger than PAGE_SIZE %u on %s\n",
+			       blocksize, PAGE_SIZE, sb->s_id);

On Apr 13, 2006  16:08 +0900, sho@tnes.nec.co.jp wrote:
>   [11/21] enlarge file size(ext3)
>           - If the flag is set to super block, i_blocks of disk inode
>             (ext3_inode) is filesystem-block unit, and i_blocks of VFS
>             inode is sector unit.
> 
>           - If the flag is set to super block, max file size is set to
>             (FS blocksize) * (2^32 -1).

I like this patch, but prefer if we maintain as much compatibility as
possible.  There is not really a reason to make a filesystem incompatible
unless there are actually files > 2TB stored in it (just like we didn't
make filesystems incompatible for large_file unless there were files over
2GB in the filesystem).

> @@ -2627,7 +2628,13 @@ void ext3_read_inode(struct inode * inod
> +	if (EXT3_HAS_INCOMPAT_FEATURE(sb,
> +	    EXT3_FEATURE_INCOMPAT_LARGE_BLOCK)) {
> +		inode->i_blocks = (blkcnt_t)le32_to_cpu(raw_inode->i_blocks)
> +			<< (inode->i_blkbits - EXT3_SECTOR_BITS);
> +	} else {
> +		inode->i_blocks = le32_to_cpu(raw_inode->i_blocks);
> +	} 

In particular, if INCOMPAT_LARGE_BLOCK is set on the filesystem, we could
check a flag (a new EXT3_LARGE_BLOCK_FL = 0x40000, or whatever Ted would
want there) in the inode to determine if the i_blocks is in fs blocksize
units, or the default sector units.

> @@ -2760,7 +2768,13 @@ static int ext3_do_update_inode(handle_t
> +	if (EXT3_HAS_INCOMPAT_FEATURE(sb,
> +	    EXT3_FEATURE_INCOMPAT_LARGE_BLOCK)) {
> +		raw_inode->i_blocks = cpu_to_le32((inode->i_blocks)
> +			>> (inode->i_blkbits - EXT3_SECTOR_BITS));
> +	} else {
> +		raw_inode->i_blocks = cpu_to_le32(inode->i_blocks);
> +	}

In this case, we would only set EXT3_LARGE_BLOCK_FL if the i_blocks count
was over 2^32 sectors, and set the EXT3_FEATURE_INCOMPAT_LARGE_BLOCK flag
in the superblock.  It would probably be best if this was implemented in
a small helper function like ext3_set_feature(sb, compat, rocompat, incompat)
that takes the code to check/set EXT3_FEATURE_RO_COMPAT_LARGE_FILE and
update dynamic_rev.

That way you get maximum compatibility, and only break compatibility for
the very few cases where such large files are acutally needed.  It would
also allow ext3 to handle > 2TB sparse files without being incompatible,
since we don't need to know a-priori whether the file will have a lot of
blocks allocated to it.

I guess the only other question is whether this should be an INCOMPAT flag,
or an ROCOMPAT one, since there is very little harm in getting the i_blocks
count wrong on a read-only filesystem, and having it ROCOMPAT at least
allows some form of system recovery if this flag is set by error.

The flag for large files was also ROCOMPAT, and one could argue that
the file size is 1000x more important than the number of blocks, since
the size affects actually reading the file, while the blocks count is
used by almost nothing.

> +static loff_t ext3_max_size(int bits, struct super_block *sb)
>  {
> +	loff_t upper_limit;
> +	if(EXT3_HAS_INCOMPAT_FEATURE(sb, 
> +	   EXT3_FEATURE_INCOMPAT_LARGE_BLOCK)) {
> +		upper_limit = (1LL << (bits + 32)) - 1;

With the above changes, the upper limit could always be the higher value.

> @@ -1703,6 +1709,15 @@ static int ext3_fill_super (struct super
>  	 */
>  
>  	root = iget(sb, EXT3_ROOT_INO);
> +	/* To appoint -O large block option, LSF needs to be enabled */
> +	if (EXT3_HAS_INCOMPAT_FEATURE(sb,
> +	    EXT3_FEATURE_INCOMPAT_LARGE_BLOCK)) {
> +		if (sizeof(root->i_blocks) < sizeof(u64)) {
> +			printk(KERN_ERR "EXT3-fs: %s: Unsupported large block option"\
> +				"with LSF disabled.\n", sb->s_id);
> +			goto failed_mount;
> +		}

This could be considered a failure only for write mounts, and not readonly.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

