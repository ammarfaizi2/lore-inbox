Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbTITLht (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 07:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbTITLht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 07:37:49 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:36279 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261840AbTITLhr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 07:37:47 -0400
Date: Sat, 20 Sep 2003 13:37:37 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Zabolotny <zap@homelink.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: __make_request() bug and a fix variant
Message-ID: <20030920113737.GQ21870@suse.de>
References: <20030919231732.7f7874e6.zap@homelink.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030919231732.7f7874e6.zap@homelink.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 19 2003, Andrew Zabolotny wrote:
> Hello!
> 
> While developing a driver I found something that I think is a bug in
> kernel (I'm using 2.4.20, I just hope it is already fixed in 2.6.x
> series). It manifests itself by bread() randomly crashing (in different
> places) if called for, say, reading 1024 bytes from block 0 of device
> 0300 from a driver's module_init() (at least in my very stripped debug
> environment, this could differ from system to system).
> 
> Here's a somewhat long description of the problem roots:
> 
> bread() in the first place calls getblk(), which first tries to find the
> requested buffer in hash tables, and if it is not there, it calls
> grow_buffers(), the later calls grow_dev_page() and finally that calls
> create_buffers(). The later gets a set of free buffer_head's from the
> pool, and puts them in a chain attached to a page. Many fields are left
> in a indefinite state since they are initialized before usage. The
> b_reqnext field is left in a indefinite state as well, and it happens
> to be filled with garbage in my case (actually it's a leftover from
> previous usage of the buffer_head).
> 
> Now when bread() gets this buffer, it is passed to ll_rw_block() which
> is passing it to generic_make_request(), and, in turn (for many block
> devices including IDE) to __make_request.
> 
> And finally, if elevator returns ELEVATOR_NO_MERGE, the b_reqnext field
> of the buffer_head structure is left uninitialized! So when b_end_io
> (and in turn end_that_request_first) is called, it looks at b_reqnext
> and sees there's another bufhead waiting for processing. What happens
> next is limited just by your imagination :-)
> 
> Also I observed the ELEVATOR_BACK_MERGE case also has the same problem
> (bh->b_reqnext is left in a indefinite state). So maybe __make_request
> always assumes that b_reqnext is initially NULL? In this case the bug is
> in create_buffers which should NULLify this field. In any case, I'm
> leaving the final solution up to kernel wizards.

I dunno if you were the one posting this issue here some months ago?

Show me a regular kernel path that passes invalid b_reqnext to
__make_request? That would be a bug, indeed, but I've never heard of
such a bug. Most likely it's a bug in your driver, not initialising
b_reqnext. You can see the initialisor for buffer_heads is
init_buffer_head, which memsets the entire buffer_head. When a
buffer_head is detached from the request list, b_reqnext is cleared too.

-- 
Jens Axboe

