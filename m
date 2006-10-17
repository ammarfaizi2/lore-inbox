Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWJQUjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWJQUjT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 16:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWJQUjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 16:39:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12953 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750751AbWJQUjT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 16:39:19 -0400
Date: Tue, 17 Oct 2006 13:39:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: balagi@justmail.de
Cc: linux-kernel@vger.kernel.org, petero2@telia.com,
       "Jens Axboe" <jens.axboe@oracle.com>
Subject: Re: [PATCH 1/2] 2.6.19-rc2-mm1 ll_rw_blk.c: export
 clear_queue_congested and set_queue_congested
Message-Id: <20061017133907.7155b2ac.akpm@osdl.org>
In-Reply-To: <op.thkzomdriudtyh@master>
References: <op.thkzomdriudtyh@master>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2006 21:42:12 +0200
"Thomas Maier" <balagi@justmail.de> wrote:

> Hello,
> 
> this patch exports the clear_queue_congested()
> and set_queue_congested() functions located in ll_rw_blk.c
> 
> The functions are renamed to blk_clear_queue_congested()
> and blk_set_queue_congested().

OK.

Aside:

The congestion info really has nothing to do with "queues".  It is actually
an attribute of the backing_dev_info.  NFS should/will be using them, and
NFS doesn't have queues.

What we should have is set_bdi_read_congested(),
clear_bdi_read_congested(), bdi_read_congested(), bdi_write_congested(),
etc.  Some of these are already in backing-dev.h.

Sometime we should add [set|clear]_bdi_[read|write]_congested() to
backing-dev.h and make the block code call them.  And move the waitqueue
stuff in clear_queue_congested() out of the block layer and into, umm, mm/
I guess.  And rename blk_congestion_wait() to congestion_wait() and move it
into mm/ too.

If all of this is done, the kernel would actually link with CONFIG_BLOCK=n.

But none of this has anything to do with your patch, except that we need to
get your patch in fast because we'd like CONFIG_BLOCK=n to work.

> (needed in the pktcdvd driver's bio write congestion control)
> 
> (have the bits set with set_queue_congested() any use?
> seems they are never used by anyone....)

bdi_write_congested() is tested in several places.  bdi_read_congested() is
tested in the readahead code too, although I doubt if queues get
read-congested very often.


> Signed-off-by: Thomas Maier <balagi@justmail.de>
> 
> 
