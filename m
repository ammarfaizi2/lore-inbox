Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbWERVAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbWERVAF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 17:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWERVAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 17:00:05 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:18329 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751038AbWERVAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 17:00:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=BFosHXZrVRnlqQhrilGa9zyB+AIoFx2344KMFKkEXONlPfmEXd9uHiscn+7ase9k9Jkc8JcfMGnK5wCBpoflDq2DQ6oUeEO2LiAuTSu4ni22S1mUrbUo3ejprRKyi+BnFdiTSTvcUDYII1hpkanpfUokI0/PKnJTRhFTsbOhaFc=
Date: Fri, 19 May 2006 00:58:16 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: "Stephen C. Tweedie" <sct@redhat.com>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sector_t overflow in block layer
Message-ID: <20060518205816.GD30163@mipter.zuzino.mipt.ru>
References: <1147849273.16827.27.camel@localhost.localdomain> <m3odxxukcp.fsf@bzzz.home.net> <1147884610.16827.44.camel@localhost.localdomain> <m34pzo36d4.fsf@bzzz.home.net> <1147888715.12067.38.camel@dyn9047017100.beaverton.ibm.com> <m364k4zfor.fsf@bzzz.home.net> <20060517235804.GA5731@schatzie.adilger.int> <1147947803.5464.19.camel@sisko.sctweedie.blueyonder.co.uk> <20060518185955.GK5964@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060518185955.GK5964@schatzie.adilger.int>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2006 at 12:59:56PM -0600, Andreas Dilger wrote:
> At least the submit_bh() code should return an error in this case
> regardless of who the caller is.  If ext[23] and other filesystems
> check this themselves at mount time that is of course also prudent.
>
> Patch has not been more than compile tested but it is a pretty serious
> problem dating back a long time so I'm posting it for review anyways.
>
> There are several ways to check for the 64-bit overflow, the efficiency
> of which depends on the architecture.  We could alternately shift b_blocknr
> by >> 41 or change the mask, for example.  The primary concern is really
> the 32-bit overflow and resulting silent and massive data corruption
> when CONFIG_LBD isn't enabled.
>
> It is coincidental that mke2fs will clobber the primary group's metadata
> (bitmaps, inode table) when formatting such a filesystem, but since this
> data is identical at format time (group 0 offsets and group 16384 offsets
> modulo 2TB are the same) it is very hard to detect before corruption hits.
>
> ==================== buffer_overflow.diff ===============================
> --- ./fs/buffer.c.orig	2006-05-18 12:15:45.000000000 -0600
> +++ ./fs/buffer.c	2006-05-18 12:09:20.000000000 -0600
> @@ -2758,12 +2784,32 @@ static int end_bio_bh_io_sync(struct bio
>  int submit_bh(int rw, struct buffer_head * bh)
>  {
>  	struct bio *bio;
> +	unsigned long long sector;
>  	int ret = 0;
>  
>  	BUG_ON(!buffer_locked(bh));
>  	BUG_ON(!buffer_mapped(bh));
>  	BUG_ON(!bh->b_end_io);
>  
> +	/* Check if we overflow sector_t when computing the sector offset.  */
> +	sector = (unsigned long long)bh->b_blocknr * (bh->b_size >> 9);
> +#if !defined(CONFIG_LBD) && BITS_PER_LONG == 32
> +	if (unlikely(sector != (sector_t)sector))
> +#else
> +	if (unlikely(((bh->b_blocknr >> 32) * (bh->b_size >> 9)) >=
> +		     0xffffffff00000000ULL))
> +#endif
> +	{
> +		printk(KERN_ERR "IO past maximum addressable sector"
> +#if !defined(CONFIG_LBD) && BITS_PER_LONG == 32
> +		       "- CONFIG_LBD not enabled"
> +#endif
> +		       "\n");

You may disagree, but this is ugly and you're touching generic code.
Why not hide it inside static inline function? And don't cut it into
pieces while you're at it.

	#if !defined(CONFIG_LBD) && BITS_PER_LONG == 32
	static inline
	{
	}
	#else
	static inline
	{
	}
	#endif

> +		buffer_io_error(bh);
> +
> +		return -EOVERFLOW;
> +	}
> +
>  	if (buffer_ordered(bh) && (rw == WRITE))
>  		rw = WRITE_BARRIER;
>  

