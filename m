Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265514AbUABMTM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 07:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265525AbUABMTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 07:19:11 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:24278 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265514AbUABMTK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 07:19:10 -0500
Date: Fri, 2 Jan 2004 13:19:04 +0100
From: Jens Axboe <axboe@suse.de>
To: Peter Osterlund <petero2@telia.com>
Cc: arjanv@redhat.com, Andrew Morton <akpm@osdl.org>, packet-writing@suse.com,
       linux-kernel@vger.kernel.org
Subject: Re: ext2 on a CD-RW
Message-ID: <20040102121904.GQ5523@suse.de>
References: <Pine.LNX.4.44.0401020022060.2407-100000@telia.com> <20040101162427.4c6c020b.akpm@osdl.org> <m2llorkuhn.fsf@telia.com> <1073034412.4429.1.camel@laptop.fenrus.com> <m2k74a8vyr.fsf@telia.com> <20040102105915.GO5523@suse.de> <m2brpm8sc2.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2brpm8sc2.fsf@telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 02 2004, Peter Osterlund wrote:
> > Does UDF use mpage? The fact that it doesn't trigger on UDF doesn't mean
> > that packet writing isn't breaking the API :)
> 
> Agreed, this was not meant to excuse the packet writing code, just
> some additional trivia.
> 
> Btw, is this API documented somewhere, or does it have to be reverse
> engineered by means of understanding implementation details in
> mpage_writepage() and similar functions? ;) May I suggest this patch?
> 
> --- linux/drivers/block/ll_rw_blk.c.old	2004-01-02 12:56:55.000000000 +0100
> +++ linux/drivers/block/ll_rw_blk.c	2004-01-02 13:07:25.000000000 +0100
> @@ -173,9 +173,11 @@
>   * are dynamic, and thus we have to query the queue whether it is ok to
>   * add a new bio_vec to a bio at a given offset or not. If the block device
>   * has such limitations, it needs to register a merge_bvec_fn to control
> - * the size of bio's sent to it. Per default now merge_bvec_fn is defined for
> - * a queue, and only the fixed limits are honored.
> - *
> + * the size of bio's sent to it. Note that a block device *must* allow a
> + * single page to be added to an empty bio. The block device driver may want
> + * to use the bio_split() function to deal with these bio's. Per default
> + * no merge_bvec_fn is defined for a queue, and only the fixed limits are
> + * honored.
>   */
>  void blk_queue_merge_bvec(request_queue_t *q, merge_bvec_fn *mbfn)
>  {

I just looked but could not find anything about it, there's been some
talk on this list. But it doesn't look like it ever got documented in
text writing. That needs to be fixed for sure, thanks for the patch. It
probably wants documenting in fs/bio.c:bio_add_page() too.

-- 
Jens Axboe

