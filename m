Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932413AbWDUQQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbWDUQQm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 12:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbWDUQQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 12:16:41 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:41879 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932405AbWDUQQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 12:16:39 -0400
Date: Fri, 21 Apr 2006 17:16:36 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/16] GFS2: Directory handling
Message-ID: <20060421161636.GA15311@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Steven Whitehouse <swhiteho@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <1145636178.3856.106.camel@quoit.chygwyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145636178.3856.106.camel@quoit.chygwyn.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +/*
> +* Implements Extendible Hashing as described in:
> +*   "Extendible Hashing" by Fagin, et al in
> +*     __ACM Trans. on Database Systems__, Sept 1979.
> +*
> +*

please follow the normal comment style, that is leave a space before the *
for block comments so it lines up nicely with the * in the start tag.

> +#include <linux/sched.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/completion.h>

you don't seem to be using any completion in this file

> +#include <linux/buffer_head.h>
> +#include <linux/sort.h>
> +#include <linux/gfs2_ondisk.h>
> +#include <linux/crc32.h>
> +#include <linux/vmalloc.h>
> +#include <asm/semaphore.h>

you're not using any semaphore in this file

> +int gfs2_dir_get_buffer(struct gfs2_inode *ip, uint64_t block, int new,
> +		         struct buffer_head **bhp)
> +{
> +	struct buffer_head *bh;
> +	int error = 0;
> +
> +	if (new) {
> +		bh = gfs2_meta_new(ip->i_gl, block);
> +		gfs2_trans_add_bh(ip->i_gl, bh, 1);
> +		gfs2_metatype_set(bh, GFS2_METATYPE_JD, GFS2_FORMAT_JD);
> +		gfs2_buffer_clear_tail(bh, sizeof(struct gfs2_meta_header));
> +	} else {
> +		error = gfs2_meta_read(ip->i_gl, block, DIO_START | DIO_WAIT,
> +				       &bh);
> +		if (error)
> +			return error;
> +		if (gfs2_metatype_check(ip->i_sbd, bh, GFS2_METATYPE_JD)) {
> +			brelse(bh);
> +			return -EIO;
> +		}
> +	}
> +
> +	*bhp = bh;
> +	return 0;

the code is completely different for the new vs !new case, so there's no
point in merging it to a single function.

