Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932696AbWEZL6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932696AbWEZL6M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 07:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932668AbWEZL6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 07:58:10 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:29419 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S932475AbWEZL5i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 07:57:38 -0400
Date: Fri, 26 May 2006 05:57:38 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: sho@tnes.nec.co.jp
Cc: cmm@us.ibm.com, jitendra@linsyssoft.com, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
       "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: [UPDATE][13/24]ext3 enlarge file size
Message-ID: <20060526115738.GM5964@schatzie.adilger.int>
Mail-Followup-To: sho@tnes.nec.co.jp, cmm@us.ibm.com,
	jitendra@linsyssoft.com, ext2-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	"Stephen C. Tweedie" <sct@redhat.com>
References: <20060525215014sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060525215014sho@rifu.tnes.nec.co.jp>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi-san, thank you for your updated patch.  This looks very good, with
only a couple of minor issues.

Ted, Stephen, which field should be used to extend the i_blocks to 48 bits?
It should be OK to use the l_i_frag and l_i_fsize fields, since they are
otherwise unused.  I believe "linux2.i_pad1" is already used for the
i_file_acl block number extension.

> @@ -1465,7 +1472,7 @@ static int ext3_fill_super (struct super
>  
>  	if (blocksize > PAGE_SIZE) {
>  		printk(KERN_ERR "EXT3-fs: cannot mount filesystem with "
> -		       "blocksize %u larger than PAGE_SIZE %u on %s\n",
> +		       "blocksize %u larger than PAGE_SIZE %lu on %s\n",
>  		       blocksize, PAGE_SIZE, sb->s_id);

Why is it that PAGE_SIZE is suddenly changing from unsigned to unsigned long?

This patch can be included into the patch series that Mingming has posted,
which is including many of the fixes you have posted, but this one is an
important addition, as is the change to allow larger block sizes on
architectures that support it.

On May 25, 2006  21:50 +0900, sho@tnes.nec.co.jp wrote:
> @@ -2630,8 +2630,13 @@ void ext3_read_inode(struct inode * inod
> +	if (ei->i_flags & EXT3_HUGE_FILE_FL) {
> +		inode->i_blocks = (blkcnt_t)le32_to_cpu(raw_inode->i_blocks)
> +			<< (inode->i_blkbits - EXT3_SECTOR_BITS);

Please put operators at the end of the line.

> @@ -2763,9 +2769,30 @@ static int ext3_do_update_inode(handle_t
> +	} else {
> +		err = ext3_journal_get_write_access(handle,
> +				EXT3_SB(sb)->s_sbh);
> +		if (err)
> +			goto out_brelse;
> +		ext3_update_dynamic_rev(sb);
> +		EXT3_SET_RO_COMPAT_FEATURE(sb,
> +				EXT3_FEATURE_RO_COMPAT_HUGE_FILE);
> +		sb->s_dirt = 1;
> +		handle->h_sync = 1;
> +		err = ext3_journal_dirty_metadata(handle,
> +				EXT3_SB(sb)->s_sbh);
> +		printk("ext3_do_update_inode: Now the file size is "
> +		       "more than 2TB on device (%s)!!\n", sb->s_id);

This part should all be conditional upon RO_COMPAT_HUGE_FILE not already
being set in the superblock.  It might make sense to put this into a
helper function and call it from here and also where RO_COMPAT_LARGE_FILE
is checked.  We can probably remove the printk entirely.

> +static loff_t ext3_max_size(int bits, struct super_block *sb)
>  {
>  	/* This constant is calculated to be the largest file size for a
>  	 * dense, 4k-blocksize file such that the total number of
>  	 * sectors in the file, including data and all indirect blocks,
>  	 * does not exceed 2^32. */
> +	if (sizeof(blkcnt_t) < sizeof(u64)) {
> +		upper_limit = 0x1ff7fffd000LL;
> +	}
> +	/* With CONFIG_LSF on, file size is limited to blocksize*(4G-1) */
> +	else { 
> +		upper_limit = (1LL << (bits + 32)) - (1LL << bits);
> +	}

This doesn't take into account that there will be some number of extra
blocks on the file for {dt}indirect blocks.  There was some discussion
among ext3 developers to use another field in the inode to allow the
i_blocks count to grow up to 2^48 bits in conjunction with this patch,
which will remove any worry about additional metadata blocks and also
allow future growth without yet another COMPAT flag.

> @@ -1699,6 +1706,18 @@ static int ext3_fill_super (struct super
> +	if (EXT3_HAS_RO_COMPAT_FEATURE(sb,
> +	    EXT3_FEATURE_RO_COMPAT_HUGE_FILE)) {
> +		if (sizeof(root->i_blocks) < sizeof(u64)) {
> +			if (!(sb->s_flags & MS_RDONLY)) {
> +				printk(KERN_ERR "EXT3-fs: %s: Having huge file with "
> +						"LSF off, you must mount filesystem "
> +						"read-only.\n", sb->s_id);
> +				goto failed_mount;

Instead of indenting so deeply here, this could just be a single condition:

	if (EXT3_HAS_RO_COMPAT_FEATURE(sb, EXT3_FEATURE_RO_COMPAT_HUGE_FILE) &&
	    sizeof(root->i_blocks) < sizeof(u64) && !(sb->s_flags & MS_RDONLY))
		printk(KERN_ERR "EXT3-fs: %s: Filesystem with > 2TB files must "
		       "mount read-only without CONFIG_LSF\n", sb->s_id);

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

