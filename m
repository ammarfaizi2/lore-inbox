Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751461AbWE3MZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbWE3MZq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 08:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbWE3MZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 08:25:46 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:9415 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1751461AbWE3MZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 08:25:45 -0400
To: adilger@clusterfs.com
Cc: sct@redhat.com, tytso@mit.edu, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, jitendra@linsyssoft.com,
       cmm@us.ibm.com
Subject: Re: [UPDATE][13/24]ext3 enlarge file size
Message-Id: <20060530212540sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Tue, 30 May 2006 21:25:40 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On May 26, 2006, Andreas wrote:
> > @@ -1465,7 +1472,7 @@ static int ext3_fill_super (struct super
> >  
> >  	if (blocksize > PAGE_SIZE) {
> >  		printk(KERN_ERR "EXT3-fs: cannot mount filesystem with "
> > -		       "blocksize %u larger than PAGE_SIZE %u on %s\n",
> > +		       "blocksize %u larger than PAGE_SIZE %lu on %s\n",
> >  		       blocksize, PAGE_SIZE, sb->s_id);
> 
> Why is it that PAGE_SIZE is suddenly changing from unsigned 
> to unsigned long?

Oops, you are right.

> On May 25, 2006  21:50 +0900, sho@tnes.nec.co.jp wrote:
> > @@ -2630,8 +2630,13 @@ void ext3_read_inode(struct inode * inod
> > +	if (ei->i_flags & EXT3_HUGE_FILE_FL) {
> > +		inode->i_blocks = 
> (blkcnt_t)le32_to_cpu(raw_inode->i_blocks)
> > +			<< (inode->i_blkbits - EXT3_SECTOR_BITS);
> 
> Please put operators at the end of the line.

Sure.

> > @@ -2763,9 +2769,30 @@ static int ext3_do_update_inode(handle_t
> > +	} else {
> > +		err = ext3_journal_get_write_access(handle,
> > +				EXT3_SB(sb)->s_sbh);
> > +		if (err)
> > +			goto out_brelse;
> > +		ext3_update_dynamic_rev(sb);
> > +		EXT3_SET_RO_COMPAT_FEATURE(sb,
> > +				EXT3_FEATURE_RO_COMPAT_HUGE_FILE);
> > +		sb->s_dirt = 1;
> > +		handle->h_sync = 1;
> > +		err = ext3_journal_dirty_metadata(handle,
> > +				EXT3_SB(sb)->s_sbh);
> > +		printk("ext3_do_update_inode: Now the file size is "
> > +		       "more than 2TB on device (%s)!!\n", sb->s_id);
> 
> This part should all be conditional upon RO_COMPAT_HUGE_FILE 
> not already
> being set in the superblock.  It might make sense to put this into a
> helper function and call it from here and also where 
> RO_COMPAT_LARGE_FILE
> is checked.  We can probably remove the printk entirely.

Agree.

> > +static loff_t ext3_max_size(int bits, struct super_block *sb)
> >  {
> >  	/* This constant is calculated to be the largest file size for a
> >  	 * dense, 4k-blocksize file such that the total number of
> >  	 * sectors in the file, including data and all indirect blocks,
> >  	 * does not exceed 2^32. */
> > +	if (sizeof(blkcnt_t) < sizeof(u64)) {
> > +		upper_limit = 0x1ff7fffd000LL;
> > +	}
> > +	/* With CONFIG_LSF on, file size is limited to 
> blocksize*(4G-1) */
> > +	else { 
> > +		upper_limit = (1LL << (bits + 32)) - (1LL << bits);
> > +	}
> 
> This doesn't take into account that there will be some number of extra
> blocks on the file for {dt}indirect blocks.  There was some discussion
> among ext3 developers to use another field in the inode to allow the
> i_blocks count to grow up to 2^48 bits in conjunction with this
> patch, which will remove any worry about additional metadata blocks
> and alsoallow future growth without yet another COMPAT flag.

I'm considering using l_i_frag and l_i_fsize as the high bits of
i_blocks for 48-bits, besides i_blocks in fs blocksize.  Is there any
comment?

> > @@ -1699,6 +1706,18 @@ static int ext3_fill_super (struct super
> > +	if (EXT3_HAS_RO_COMPAT_FEATURE(sb,
> > +	    EXT3_FEATURE_RO_COMPAT_HUGE_FILE)) {
> > +		if (sizeof(root->i_blocks) < sizeof(u64)) {
> > +			if (!(sb->s_flags & MS_RDONLY)) {
> > +				printk(KERN_ERR "EXT3-fs: %s: 
> Having huge file with "
> > +						"LSF off, you 
> must mount filesystem "
> > +						"read-only.\n", 
> sb->s_id);
> > +				goto failed_mount;
> 
> Instead of indenting so deeply here, this could just be a 
> single condition:

Agree.

Thanks a lot, Andreas!


Cheers, sho


