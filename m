Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285747AbSAHHPp>; Tue, 8 Jan 2002 02:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287048AbSAHHPg>; Tue, 8 Jan 2002 02:15:36 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:42002 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S285747AbSAHHPU>;
	Tue, 8 Jan 2002 02:15:20 -0500
Date: Tue, 8 Jan 2002 08:15:15 +0100
From: Jens Axboe <axboe@suse.de>
To: Michael Zhu <mylinuxk@yahoo.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: About the request queue of block device
Message-ID: <20020108081515.A19380@suse.de>
In-Reply-To: <20020107213749.18573.qmail@web14911.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020107213749.18573.qmail@web14911.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07 2002, Michael Zhu wrote:
> Hello, everyone, I have a question about the request
> queue of block device.
> 
> I intercept the request function of floppy disk device
> by changing the pointer, 
>  "blk_dev[2].request_queue.request_fn", in my kernel
> module. The following is the source code.
> 
> original_request_fn_proc =
> blk_dev[2].request_queue.request_fn;
> blk_dev[2].request_queue.request_fn =
> my_request_fn_proc;

I'm sure you are protecting access to the queues appropriately?

> In my own my_request_fn_proc() I use the "req =
> blkdev_entry_next_request(&rq->queue_head)" function
> to get the pointer of the request structure. When
> req->cmd is WRITE I encrypt all the b_data buffer of
> the buffer header. Then I call the
> original_request_fn_proc(). And it works. The data on
> the floppy disk is some kind of cipher data. The

Irk... You are effectively killing plugging of the floppy driver with
this approach. You do realise that when your replacement request_fn is
called, there are probably more than one request on the queue?

> trouble is when the req->cmd is READ. I don't know
> whether the b_data buffer contains the data read from
> the floppy disk after I call the
> original_request_fn_proc() function. When read a block
> from the block device, where is the data is placed?

If it's quick, then it's _probably_ there. The problem is, you'll
basically have to iterate all buffers in the request and do get_bh on
them prior to submitting to the original floppy request_fn, then
afterwards wait on completion (out of your own request_fn context). You
should probably off load that to a dedicated thread. And then do
processing on a make_request_fn basis instead so you only have to deal
with single buffer_heads at the time, ie replace floppy blk_dev
make_request_fn with your own that does the encryption on write and
stacks a new buffer head on top of the other for READ, defining your own
b_end_io function for that to decrypt on READ end I/O.

Any particular reason your not using the loop device and just writing
your own crypt plugin??

> In my module I use the blkdev_next_request() function
> to get the next request. When I want to do the same
> thing to this next request, the Linux kernel
> deadlocked. I must reboot the OS. What is wrong?

You are probably walking right into the queue head and using that as a
request, boom.

-- 
Jens Axboe

