Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946949AbWKAQsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946949AbWKAQsE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 11:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992667AbWKAQsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 11:48:04 -0500
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:33921 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1946948AbWKAQsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 11:48:01 -0500
Date: Wed, 1 Nov 2006 17:47:15 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Holden Karau <holden@pigscanfly.ca>
Cc: Josef Sipek <jsipek@fsl.cs.sunysb.edu>, hirofumi@mail.parknet.co.jp,
       linux-kernel@vger.kernel.org, Holden Karau <holdenk@xandros.com>,
       "akpm@osdl.org" <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       holden.karau@gmail.com, Nick Piggin <nickpiggin@yahoo.com.au>,
       Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH 1/1] fat: improve sync performance by grouping writes revised again
Message-ID: <20061101164715.GC16154@wohnheim.fh-wedel.de>
References: <4548C8AE.2090603@pigscanfly.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4548C8AE.2090603@pigscanfly.ca>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 November 2006 11:17:50 -0500, Holden Karau wrote:
> +	c_bh = kmalloc(nr_bhs*(sbi->fats) , GFP_KERNEL);
> +	if (NULL == c_bh) {
> +		printk(KERN_CRIT "not enough memory to store pointers to FAT blocks, will not sync. Possible data loss\n");
> +		err = -ENOMEM;
> +		goto error;
> +	}

o I personally hate Yoda code ("Null the pointer is not, young Jedi").
o Old code simply returned -ENOMEM without printk.  Assuming this was
  sufficient before, the printk can be dropped.
o Some people prefer assigning err outside the condition.  It is
  supposed to give slightly better code on i386, iirc.

Result would be something like:
	c_bh = kmalloc(...
	err = -ENOMEM;
	if (!c_bh)
		goto error;

> +		for (n = 0 ; n < nr_bhs ;  n++ ) {
> +			c_bh[(copy-1)*nr_bhs+n] = sb_getblk(sb, backup_fat + bhs[n]->b_blocknr);
> +			/* If there is not enough memory, fall back to the old system */
> +			if (!c_bh[(copy-1)*nr_bhs+n]) {
> +				printk("fat: not enough memory for all blocks , syncing at %d\n" ,(copy-1)*nr_bhs+n);

Whether this printk makes sense, I cannot tell.

> +				fat_sync_bhs_optw( c_bh+i  , (copy-1)*nr_bhs+n-i-1 , wait );
> +				/* Free the now sync'd blocks */
> +				for (; i < (copy-1)*nr_bhs+n ; i++)
> +					brelse(c_bh[i]);
> +				/* We try the same block again */
> +				c_bh[(copy-1)*nr_bhs+n] = sb_getblk(sb, backup_fat + bhs[n]->b_blocknr);
> +				if (!c_bh[(copy-1)*nr_bhs+n]) {
> +					printk(KERN_CRIT "fat:not enough memory for block after existing blocks released. Possible data loss.\n");
> +					err = -ENOMEM;
> +					goto error;
> +				}

As above.

>  error:
> +	if (NULL != c_bh) {
> +		kfree(c_bh);
> +	}

kfree(NULL) works just fine.  You can remove the condition.

> +int fat_sync_bhs_optw(struct buffer_head **bhs, int nr_bhs ,int wait)
>  {
>  	int i, err = 0;
>  
>  	ll_rw_block(SWRITE, nr_bhs, bhs);
> -	for (i = 0; i < nr_bhs; i++) {
> -		wait_on_buffer(bhs[i]);
> -		if (buffer_eopnotsupp(bhs[i])) {
> -			clear_buffer_eopnotsupp(bhs[i]);
> -			err = -EOPNOTSUPP;
> -		} else if (!err && !buffer_uptodate(bhs[i]))
> -			err = -EIO;
> +	if (wait) {
> +		for (i = 0; i < nr_bhs; i++) {
> +			wait_on_buffer(bhs[i]);
> +			if (buffer_eopnotsupp(bhs[i])) {
> +				clear_buffer_eopnotsupp(bhs[i]);
> +				err = -EOPNOTSUPP;
> +			} else if (!err && !buffer_uptodate(bhs[i]))
> +				err = -EIO;
> +		}
>  	}
> +
>  	return err;
>  }

You could keep the old indentation if your condition was changed to

	if (!wait)
		return 0;

Jörn

-- 
You can take my soul, but not my lack of enthusiasm.
-- Wally
