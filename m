Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750913AbWJQNYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbWJQNYp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 09:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbWJQNYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 09:24:45 -0400
Received: from brick.kernel.dk ([62.242.22.158]:15712 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1750913AbWJQNYo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 09:24:44 -0400
Date: Tue, 17 Oct 2006 15:25:19 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Ronen Shitrit <rshitrit@marvell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DIrectIO using kernel buffers
Message-ID: <20061017132519.GE7854@kernel.dk>
References: <B9FFC3F97441D04093A504CEA31B7C41E915E1@msilexch01.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B9FFC3F97441D04093A504CEA31B7C41E915E1@msilexch01.marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16 2006, Ronen Shitrit wrote:
> Hi
> 
> I'm using kernel 2.6.12.
> I'm trying to improve the usb gadget file storage implementation by
> making it accessing the file storage with O_DIRECT,
> In general what I'm trying to do is use DirectIO with buffer which was
> allocated by kmalloc.
> 
> When trying to do so I get kernel panic, after some debug, I found that
> I can't call get_user_pages on pages allocated by the kernel (kmalloc),
> Is it correct??
> Any way, I implemented some basic function get_kernel_pages to fill the
> page array with the pages pointer of the kernel buffer,
> Then I got lots of errors on illegal buffer freeing, I did some more
> debug and I found that the direct-io is using the get_page and put_page
> in order to increment the counter of the page and to make sure no one
> will release them while the direct-io is using them, after the direct-io
> is doing put_page it check if the page_count is 0, if so it release it
> (see page_cache_release in direct-io.c), by doing this the direct-io is
> trying to release the pages which I allocated by kmalloc and I get
> errors.
> So what I get is that the direct-io increments the count and then
> decrements it and the count get to zero,
> So I checked the count of the pages which I got from kmalloc and I found
> that only the first page count is 0 (i.e. one process is using it) and
> the rest were initialized by -1 (i.e. no process is using this buffer),
> Is this a bug??
> Any suggestion on how to use DirectIO with kernel buffers??

get_user_pages(), as the name infers, deals with user memory not memory
allocated with kmalloc(). Rewrite your code to generate the page vec
manually allocating individual pages at the time, it's silly to allocate
contigious memory and then split that up afterwards.

-- 
Jens Axboe

