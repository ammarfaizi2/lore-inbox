Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751002AbWD3Ur2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbWD3Ur2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 16:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbWD3Ur1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 16:47:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48578 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751002AbWD3Ur1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 16:47:27 -0400
Date: Sun, 30 Apr 2006 13:45:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Daniel =?ISO-8859-1?B?QXJhZ29u6XM=?= <danarag@gmail.com>
Cc: penberg@cs.helsinki.fi, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] minix filesystem update to V3 for 2.6 kernels
Message-Id: <20060430134527.5175661a.akpm@osdl.org>
In-Reply-To: <4454C131.8070309@gmail.com>
References: <4454C131.8070309@gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Aragonés <danarag@gmail.com> wrote:
>
> Hi Andrew,
> 
> As a continuation of my former communication of January 25, and after having posted the attached patch in my personal page http://www.terra.es/personal2/danarag for about 3 months, feedback has come 
> to me, and some bugs have been detected and corrected.

People use minixfs?  I'm a bit surprised.

> I believe that now (not before) the patch is really ready for merging into the main line if you consider it appropriate.

We'd need a detailed changelog please.

> Signed-off-by: Daniel Aragones <danarag@gmail.com>

The patch gets lots of rejects.  More than I'm prepared to fix up so I can
take a look at it in tkdiff, unfortunately.

I suspect the patch was against some prehistoric kernel like 2.6.16 ;)


> @@ -79,24 +96,35 @@
>  int minix_new_block(struct inode * inode)
>  {
>  	struct minix_sb_info *sbi = minix_sb(inode->i_sb);
> -	int i;
> +	char *offset = kmalloc(sizeof(char *), GFP_KERNEL);

That's a peculiar thing to do.

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

And here I think we've just leaked that memory.

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
> +	char *offset = kmalloc(sizeof(char *), GFP_KERNEL);
> +	bh = sbi->s_imap[ino >> k];
> +	offset = (char *)bh->b_data;

And again.  Here we've definitely leaked it.

> @@ -226,26 +268,36 @@
>  	j = 8192;
>  	bh = NULL;
>  	*error = -ENOSPC;
> +	char *offset = kmalloc(sizeof(char *), GFP_KERNEL);
>  	lock_kernel();
>  	for (i = 0; i < sbi->s_imap_blocks; i++) {
>  		bh = sbi->s_imap[i];
> -		if ((j = minix_find_first_zero_bit(bh->b_data, 8192)) < 8192)
> -			break;
> +		for (k = 0; k < num_1K_blocks; k++) {
> +			offset = (char *)bh->b_data;

again


