Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262160AbTIHI6g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 04:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbTIHI6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 04:58:35 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:41861 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262122AbTIHI54 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 04:57:56 -0400
Date: Mon, 8 Sep 2003 10:58:02 +0200
From: Jens Axboe <axboe@suse.de>
To: Sven =?iso-8859-1?Q?K=F6hler?= <skoehler@upb.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [blockdevices/NBD] huge read/write-operations are splitted by the kernel
Message-ID: <20030908085802.GH840@suse.de>
References: <bjgh6a$82o$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bjgh6a$82o$1@sea.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 08 2003, Sven Köhler wrote:
> Hi,
> 
> i discussed a problem of the NBD-protocl with Pavel Machek. The problem 
> i saw is that there is no maximum for the length field in the requests 
> that the NBD kernel module sends to the NBD server. Well, this length 
> field is the length field from the read/write-operation that the kernel 
> delegates to the blockdevice-implementation.
> I did some tests tests like
>   dd if=dev/nbd/0 of=/dev/null bs=10M
> and our NBD-server implementation printed out the length field of each 
> reqeust. There was a very regular pattern like
>   0x1fc00 (127KB)
>   0x00400 (1KB)
>   0x1fc00
>   0x00400
>   ...
> Well, can anybody explain that to me?
> (why so "little" 1KB requests? but that's not important)
> 
> Well, i also tested
>   dd if=dev/nbd/0 of=/dev/null bs=1
> which means that the device will be read in chunks of 1byte.
> The result was the same: 127KB, 1KB, 127KB, 1KB...
> 
> I guess the caching layer is inbetween, and will devide the huge 10MB 
> requests into smaller 127KB ones, as well as joining the small 1byte 
> requests by using read-ahead i guess.
> Perhaps you could tell me how i can turn off caching. Than i will test 
> again without the cache.
> 
> The thing i want to know is, if there is any part of the kernel that 
> gaarantees that a read/write requests will not be bigger that a certain 
> value. If there is no such upper limit, the NBD itself would need to 
> split things up which might become a complicated task. This task need to 
> be done, because it can become very difficult for the NBD server to 
> handle huge values, and one huge requests will block all other pending 
> small ones due to limitations of the NBD protocol.

You'll probably find that if you bump the max_sectors count if your
drive to 256 from 255 (that is the default if you haven't set it), then
you'll see 128kb chunks all the time.

See max_sectors[] array.

-- 
Jens Axboe

