Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265400AbSK1KOQ>; Thu, 28 Nov 2002 05:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265409AbSK1KOQ>; Thu, 28 Nov 2002 05:14:16 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:32393 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265400AbSK1KOO>;
	Thu, 28 Nov 2002 05:14:14 -0500
Date: Thu, 28 Nov 2002 11:21:26 +0100
From: Jens Axboe <axboe@suse.de>
To: Alex Ryan <alexryan1@rediffmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: optimal value for blksize_size
Message-ID: <20021128102126.GB999@suse.de>
References: <20021127232431.7188.qmail@webmail36.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021127232431.7188.qmail@webmail36.rediffmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27 2002, Alex  Ryan wrote:
> Hello,
> 
> I am writing a Linux block driver for our RAID firmware, and I am 
> very confused about blksize_size.
> 
> The documentation simply says that blksize_size should be the size 
> of the block used by the device in bytes.
> Now, for my device(hard disk), the only restriction is that calls 
> must be a multiple of 512 bytes(1 sector).
> 
> I thought the natural choice for blksize_size would be 512, but I 
> saw that if I make it as 512 then the upper layer breaks up all 
> calls into buffer heads , each of size 512.
> I think that is bad for sequential performance, even though my 
> device has scatter gather capability.
> 
> And if I make blksize_size of a higher value(e.g 4K), then the 
> upper layer gives calls of 4k size even for 512 byte reads.
> 
> Making blksize_size greater than PAGE_SIZE results in kernel 
> panic.
> 
> I am really very confused about what  blksize_size really means, 
> and what should be an optimum value to put in there.

You should not put anything there, just leave room for someone else to
fill it in. It's the soft block size, and file systems typically set it
at mount time.

If 512b is the minimum request size you can do, you need to set
hardsect_size to that and trust that you wont get requests below that
size.

That's all you need to worry about.

> One more question about clustering:
> All IO requests for consecutive sectors are clustered in the same 
> request structure, this much I understand.  My question is, does 
> the b_data field of the corresponding bufferheads are also 
> sequential in the physical memory? In other words, can I satisfy a 
> request if I simply transfer req->nr_sectors amount of data to 
> req->buffer?

No this is very wrong. First of all, if you are setting up sg tables for
a request you never ever want to look at rq->buffer. Ever. You need to
loop through all the buffer heads attached to the request and setup an
sg entry for each of them.

A clustered request just means that it is contig on disk, not in memory.
Of course it can happen that some buffer_heads are also contig in memory
and you can coalesc these segments into one sg entry, but that all
depends on your hardware capabilities and you need to detect this
yourself.

BTW, I'm assuming a 2.4 kernel. In 2.5 this is all automated for you.

-- 
Jens Axboe

