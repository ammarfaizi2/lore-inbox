Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317355AbSGDHna>; Thu, 4 Jul 2002 03:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317361AbSGDHn3>; Thu, 4 Jul 2002 03:43:29 -0400
Received: from cmailg7.svr.pol.co.uk ([195.92.195.177]:29024 "EHLO
	cmailg7.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S317355AbSGDHn2>; Thu, 4 Jul 2002 03:43:28 -0400
Date: Thu, 4 Jul 2002 08:45:34 +0100
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Jens Axboe <axboe@suse.de>, linux-lvm@sistina.com,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@zip.com.au>
Subject: Re: [linux-lvm] LVM2 modifies the buffer_head struct?
Message-ID: <20020704074534.GA884@fib011235813.fsnet.co.uk>
References: <F19741gcljD2E2044cY00004523@hotmail.com> <20020702141702.GA9769@fib011235813.fsnet.co.uk> <20020703100838.GH14097@suse.de> <20020703120124.GB615@fib011235813.fsnet.co.uk> <20020703121024.GC21568@suse.de> <15651.54044.557070.109158@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15651.54044.557070.109158@notabene.cse.unsw.edu.au>
User-Agent: Mutt/1.3.28i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2002 at 02:46:20PM +1000, Neil Brown wrote:
> I think this can work sanely and is something I have considered for
> raid1-read and multipath in md.
> 
> struct privatebit {
>   bio_end_io_t  *oldend;
>   void          *oldprivate;
>   ...other...stuff;
> };
> 
> make_request(struct request_queue_t *q, struct buffer_head *bh, int rw)
> {
> 
>  struct privatebit *pb = kmalloc(...);
> 
>   pb->oldend = bh->b_end_io;
>   pb->oldprivate = bh->b_private;
>   bh->b_private = pb;
>   bh->b_end_io = my_end_handler;
> 
>   ..remap b_rdev, b_rsector ...
> 
>   generic_make_request(bh, rw);
> 
> }
> 
> Then my_end_handler have do some local cleanup,
> re-instate oldend and oldprivate, and pass the bh back up.
> For raid1/multipath it would arrange to resubmit the request if there
> as an error.
> 
> This stacks nicely and allows for the extra bit to be alloced to be
> minimal.

This is exactly what I'm doing in device-mapper :)

> Ofcourse this ceases to be an issue in 2.5 because the filesys uses 
> pages or buffer_heads and the device driver uses bios.

y, 2.5 is fine.

- Joe
