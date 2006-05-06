Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750865AbWEFQaM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbWEFQaM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 12:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbWEFQaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 12:30:12 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:2435 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750865AbWEFQaK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 12:30:10 -0400
Date: Sat, 6 May 2006 17:29:56 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Daniel Aragon?s <danarag@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Pekka Enberg <penberg@cs.helsinki.fi>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH/RFC] minix filesystem update to V3 diffed to 2.6.17-rc3
Message-ID: <20060506162956.GO27946@ftp.linux.org.uk>
References: <44560796.8010700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44560796.8010700@gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2006 at 03:05:26PM +0200, Daniel Aragon?s wrote:
> diff -ur orig.Linux-2.6.17-rc3/fs/minix/bitmap.c updated.Linux-2.6.17-rc3/fs/minix/bitmap.c
> --- orig.Linux-2.6.17-rc3/fs/minix/bitmap.c	2006-04-27 04:19:25.000000000 +0200
> +++ updated.Linux-2.6.17-rc3/fs/minix/bitmap.c	2006-05-01 14:13:08.000000000 +0200
> +int minix3_block_size_shift(struct super_block *sb)
> +{
> +	int k = 0;
> +	if (sb->s_blocksize != 1024)
> +		k = sb->s_blocksize >> 11;
> +	if (sb->s_blocksize >= 8192)
> +		k = 2 + (sb->s_blocksize >> 13);

Ouch...  So you want
	1024 => 0
	2048 => 1
	4096 => 2
	8192 => 3
	16384 => 4
	anything else => junk?

IOW, you are creating cascade of ifs and shifts instead of
	ffs(sb->s_blocksize) - 11
(ffs(1<<n) == n + 1).  ffs() is far more efficient and readable...

> +void minix_free_block(struct inode * inode, unsigned long block)
>  {
>  	struct super_block * sb = inode->i_sb;
>  	struct minix_sb_info * sbi = minix_sb(sb);
>  	struct buffer_head * bh;
> -	unsigned int bit,zone;
> +	int k = minix3_block_size_shift(sb);
> +	int mask = 15;
> +	unsigned long bit,zone;
>  
>  	if (block < sbi->s_firstdatazone || block >= sbi->s_nzones) {
>  		printk("Trying to free block not in datazone\n");
> @@ -62,16 +74,21 @@
>  	zone = block - sbi->s_firstdatazone + 1;
>  	bit = zone & 8191;
>  	zone >>= 13;
> -	if (zone >= sbi->s_zmap_blocks) {
> +	if ((zone >> k) >= sbi->s_zmap_blocks) {
>  		printk("minix_free_block: nonexistent bitmap buffer\n");
>  		return;
>  	}
> -	bh = sbi->s_zmap[zone];
> +	char *offset = kmalloc(sizeof(char *), GFP_NOFS);
> +	bh = sbi->s_zmap[zone >> k];
> +	mask >>= (4-k);
> +	offset = (char *)bh->b_data;
> +	offset += (zone & mask)*1024;

WTF?  This is bogus for a lot of reasons.
	a) you allocate only to lose the pointer to allocated object
immediately.
	b) while we are at it, the size of allocated object is... odd, to
say the least
	c) why the hell is it so convoluted???
You end up with
	bh = sbi->s_zmap[zone / (8 * blocksize)]
and accessing bit # zone % (8 * blocksize) in its ->b_data.  Which is
fine, and yes, it does make sense to use the fact that 8 * blocksize is
1 << (13 + k).  Fine.  But why do you mess with mask, multiple shifts,
etc.?

> +	offset = NULL;

and the point of that would be...?

>  	mark_buffer_dirty(bh);
>  	return;

> @@ -79,24 +96,35 @@
>  int minix_new_block(struct inode * inode)
>  {
>  	struct minix_sb_info *sbi = minix_sb(inode->i_sb);
> -	int i;
> +	char *offset = kmalloc(sizeof(char *), GFP_NOFS);

Again, huh?

> +	int num_1K_blocks = (inode->i_sb->s_blocksize)/1024;
> +	int bits_per_zone = 8 * (inode->i_sb->s_blocksize);
> +	int i, k;
>  
>  	for (i = 0; i < sbi->s_zmap_blocks; i++) {
>  		struct buffer_head *bh = sbi->s_zmap[i];
> -		int j;
> +		for (k = 0; k < num_1K_blocks; k++) {
> +			int j;
>  
> -		lock_kernel();
> -		if ((j = minix_find_first_zero_bit(bh->b_data, 8192)) < 8192) {
> -			minix_set_bit(j,bh->b_data);
> -			unlock_kernel();
> -			mark_buffer_dirty(bh);
> -			j += i*8192 + sbi->s_firstdatazone-1;
> -			if (j < sbi->s_firstdatazone || j >= sbi->s_nzones)
> -				break;
> -			return j;
> +			offset = (char *)bh->b_data;
> +			offset += k*1024;
> +			lock_kernel();
> +			if ((j = minix_find_first_zero_bit(offset, 8192))
> +				< 8192) {
> +				minix_set_bit(j, offset);
> +				unlock_kernel();
> +				offset = NULL;
> +				mark_buffer_dirty(bh);
> +				j += k*8192 + i*bits_per_zone + sbi->s_firstdatazone-1;
> +				if (j < sbi->s_firstdatazone || j >= sbi->s_nzones)
> +					goto break_both;
> +				return j;
> +			}
>  		}
>  		unlock_kernel();

And just what, pray tell, would be wrong with simply replacing 8192 with
bits_per_zone in the original loop?

> +	int k = minix3_block_size_shift(inode->i_sb);
> +	int mask = 15;
> +	unsigned long ino, bit;
>  
>  	ino = inode->i_ino;
>  	if (ino < 1 || ino > sbi->s_ninodes) {
>  		printk("minix_free_inode: inode 0 or nonexistent inode\n");
>  		goto out;
>  	}
> -	if ((ino >> 13) >= sbi->s_imap_blocks) {
> +	bit = ino & 8191;
> +	ino >>= 13;
> +	mask >>= (4-k);
> +	if ((ino >> k) >= sbi->s_imap_blocks) {
>  		printk("minix_free_inode: nonexistent imap in superblock\n");
>  		goto out;
>  	}
>  
>  	minix_clear_inode(inode);	/* clear on-disk copy */
>  
> -	bh = sbi->s_imap[ino >> 13];
> +	char *offset = kmalloc(sizeof(char *), GFP_NOFS);
> +	bh = sbi->s_imap[ino >> k];
> +	offset = (char *)bh->b_data;
> +	offset += (ino & mask)*1024;

Same BS as in block freeing..
>  	struct buffer_head * bh;
> -	int i,j;
> +	unsigned long j;
> +	int num_1K_blocks = (inode->i_sb->s_blocksize)/1024;
> +	int bits_per_zone = 8 * sb->s_blocksize;
> +	int i, k;

Same BS as in block allocation.

> diff -ur orig.Linux-2.6.17-rc3/fs/minix/dir.c updated.Linux-2.6.17-rc3/fs/minix/dir.c
> @@ -90,6 +93,8 @@
>  	unsigned long npages = dir_pages(inode);
>  	struct minix_sb_info *sbi = minix_sb(sb);
>  	unsigned chunk_size = sbi->s_dirsize;
> +	char *namx;
> +	__u32 inodx;

Ouch.  Could you please make those "name" and "inumber" resp.?

> @@ -157,9 +170,12 @@
> +	char *namx;
> +	__u32 inodx;

Ditto.  Rename the argument.

>  	for (n = 0; n < npages; n++) {
>  		char *kaddr;
> @@ -168,12 +184,22 @@
>  			continue;
>  
>  		kaddr = (char*)page_address(page);
> +		de3 = (struct minix3_dir_entry *) kaddr;
>  		de = (struct minix_dir_entry *) kaddr;
>  		kaddr += minix_last_byte(dir, n) - sbi->s_dirsize;
> -		for ( ; (char *) de <= kaddr ; de = minix_next_entry(de,sbi)) {
> -			if (!de->inode)
> +		for ( ; (char *) de <= kaddr ;
> +					de3 = minix_next_entry(de3,sbi),
> +					de = minix_next_entry(de,sbi)) {

Huh?  You advance _both_ in parallel?  Why not use one pointer to union?
Same for similar loops later in the file; incidentally, it might make
sense to take if (sbi->s_version == MINIX_V3) out of the loop.

>  		while ((char *)de <= kaddr) {
> -			if (de->inode != 0) {
> +			if (inodx != 0) {
>  				/* check for . and .. */
> -				if (de->name[0] != '.')
> +				if (namx[0] != '.')
>  					goto not_empty;
> -				if (!de->name[1]) {
> -					if (de->inode != inode->i_ino)
> +				if (!namx[1]) {
> +					if (inodx != inode->i_ino)
>  						goto not_empty;
> -				} else if (de->name[1] != '.')
> +				} else if (namx[1] != '.')
>  					goto not_empty;
> -				else if (de->name[2])
> +				else if (namx[2])
>  					goto not_empty;
>  			}
>  			de = minix_next_entry(de, sbi);

Broken.  You do not update your 'inodx'.

> +	} else if ( *(__u16 *)(bh->b_data + 24) == MINIX3_SUPER_MAGIC) {
> +		m3s = (struct minix3_super_block *) bh->b_data;
> +		s->s_magic = m3s->s_magic;
> +		sbi->s_imap_blocks = m3s->s_imap_blocks;
> +		sbi->s_zmap_blocks = m3s->s_zmap_blocks;
> +		sbi->s_firstdatazone = m3s->s_firstdatazone;
> +		sbi->s_log_zone_size = m3s->s_log_zone_size;
> +		sbi->s_max_size = m3s->s_max_size;
> +		sbi->s_ninodes = m3s->s_ninodes;
> +		sbi->s_nzones = m3s->s_zones;
> +		sbi->s_dirsize = 64;
> +		sbi->s_namelen = 60;
> +		sbi->s_version = MINIX_V3;
> +		sbi->s_link_max = MINIX2_LINK_MAX;
> +		sbi->s_mount_state = MINIX_VALID_FS;
> +		sb_set_blocksize(s, m3s->s_blocksize);

Check the result.

> diff -ur orig.Linux-2.6.17-rc3/fs/minix/itree_common.c updated.Linux-2.6.17-rc3/fs/minix/itree_common.c
> @@ -301,7 +303,7 @@
>  	int first_whole;
>  	long iblock;
>  
> -	iblock = (inode->i_size + BLOCK_SIZE-1) >> 10;
> +	iblock = (inode->i_size + sb->s_blocksize -1) >> (10+k);

or just >> (ffs(sb->s_blocksize) - 1)...  Would be more readable.

> @@ -346,15 +348,18 @@
>  	mark_inode_dirty(inode);
>  }
>  
> -static inline unsigned nblocks(loff_t size)
> +static inline unsigned nblocks(loff_t size, struct dentry *dentry)
>  {
> +	struct inode * dir = dentry->d_parent->d_inode;
> +	struct super_block * sb = dir->i_sb;

... and the reason for passing dentry instead of (already used by caller)
sb would be?
