Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261595AbSJYUSc>; Fri, 25 Oct 2002 16:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261596AbSJYUSc>; Fri, 25 Oct 2002 16:18:32 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:21932 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261595AbSJYUS3>;
	Fri, 25 Oct 2002 16:18:29 -0400
Date: Fri, 25 Oct 2002 22:24:00 +0200
From: Jens Axboe <axboe@suse.de>
To: Stephen Cameron <steve.cameron@hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.44-ac3, cciss, more scatter gather elements
Message-ID: <20021025202400.GG12628@suse.de>
References: <20021025135914.A1224@zuul.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021025135914.A1224@zuul.cca.cpqcorp.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25 2002, Stephen Cameron wrote:
> 
> Add blk_rq_map_sg_one_by_one function to ll_rw_blk.c in order to allow a low 
> level driver to map scatter gather elements from the block subsystem one 
> at a time into device specific data structures instead of having to take 
> a copy of all of them all at once and then afterwards copy them into a device 
> specific format. 
> 
> To follow, a patch to the cciss driver using this interface which
> allows up to 256 scatter gather elements (current limit is 31). 

I have to say that I think this patch is ugly, and a complete duplicate
of existing code. This is always bad, especially in the case of
something not really straight forward (like blk_rq_map_sg()). A hack.

I can understand the need for something like this, for drivers that
can't use a struct scatterlist directly. I'd rather do this in a
different way, though.

__blk_rq_map(q, rq, sglist, callback)
{
	...
	/* do the mapping *.
	if (sglist) {
		sglist[nsegs].page = bvec->bv_page;
		...
	} else
		callback(q, bvec, nsegs);
}

blk_rq_map_rq(q, rq, sglist)
{
	return __blk_rq_map(q, rq, sglist, NULL);
}

blk_rq_map_callback(q, rq, callback)
{
	return __blk_rq_map(q, rq, NULL, callback);
}

Or use a cookie like you currently do.

Oh, and do try to follow the style. It's

	if (cond)
		foo();

not

	if (fond) foo();

-- 
Jens Axboe

