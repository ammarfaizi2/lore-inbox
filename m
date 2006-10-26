Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423572AbWJZPbi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423572AbWJZPbi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 11:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423571AbWJZPbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 11:31:37 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:42966 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1423567AbWJZPbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 11:31:37 -0400
Date: Thu, 26 Oct 2006 17:30:37 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Holden Karau <holden@pigscanfly.ca>
Cc: Josef Sipek <jsipek@fsl.cs.sunysb.edu>, hirofumi@mail.parknet.co.jp,
       linux-kernel@vger.kernel.org, holdenk@xandros.com,
       "akpm@osdl.org" <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       holden.karau@gmail.com
Subject: Re: [PATCH 1/1] fat: improve sync performance by grouping writes in fat_mirror_bhs [really unmangled]
Message-ID: <20061026153037.GB12596@wohnheim.fh-wedel.de>
References: <4540A32E.5050602@pigscanfly.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4540A32E.5050602@pigscanfly.ca>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't pay too much attention, but found some low hanging fruits.

On Thu, 26 October 2006 07:59:42 -0400, Holden Karau wrote:
>  
> -/* FIXME: We can write the blocks as more big chunk. */
>  static int fat_mirror_bhs(struct super_block *sb, struct buffer_head **bhs,
> -			  int nr_bhs)
> +			  int nr_bhs ) {
> +  return fat_mirror_bhs_optw(sb , bhs , nr_bhs, 0);
> +}
> +
> +static int fat_mirror_bhs_optw(struct super_block *sb, struct buffer_head **bhs,
> +			       int nr_bhs , int wait)

Does this compile without warnings?  Looks as if you should reverse
the order of the two functions.

>  {
>  	struct msdos_sb_info *sbi = MSDOS_SB(sb);
> -	struct buffer_head *c_bh;
> +	struct buffer_head *c_bh[nr_bhs];
>  	int err, n, copy;
>  
> +	/* Always wait if mounted -o sync */
> +	if (sb->s_flags & MS_SYNCHRONOUS ) {
> +	  wait = 1;
> +	}

Coding style.  Use a tab for indentation and don't use braces for
single-line conditional statements.

> +
>  	err = 0;
> +	err = fat_sync_bhs_optw( bhs  , nr_bhs , wait);

The err=0; is superfluous now, isn't it?

> +	if (err)
> +	  goto error;

Indentation.

Jörn

-- 
Fantasy is more important than knowledge. Knowledge is limited,
while fantasy embraces the whole world.
-- Albert Einstein
