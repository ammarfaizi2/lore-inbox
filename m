Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275364AbTHGOx4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 10:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275381AbTHGOxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 10:53:34 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:43423 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S275364AbTHGOub (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 10:50:31 -0400
Date: Thu, 7 Aug 2003 16:50:27 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Proper block queue reference counting
Message-ID: <20030807145027.GI2886@suse.de>
References: <200308070909.h7799QHg022029@hera.kernel.org> <3F3263FC.5030100@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F3263FC.5030100@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 07 2003, Jeff Garzik wrote:
> I like the patch, but see two problems:
> 
> 1) You convert drivers to dynamically allocated queues... who is freeing 
> the queues?  unregister_blkdev?  It's a bit non-obvious to say the 
> least, since you patches (for example, the first one, to stram.c) 
> obviously switch blk_init_queue to dynamically allocate a queue...  but 
> you do not add code to remove the final reference in modprobe.  The 
> standard driver-facing API dictates that the driver calls foo_put 
> itself, in the driver, rather than have it done implicitly.

blk_cleanup_queue() still does that, as does blk_put_queue() (same deal,
each drop a reference, last reference frees the queue).

This first patch is just the frame work, the only thing that's
referenced counted right now is that the returned object has one
reference and when the driver cleans the queue it drops the reference
causing it to be freed. Next step is making sure others that hold a
reference to the queue also grab a reference to it, using
blk_get_queue(). That's stuff like bdev_get_queue(), for instance.

> 2) the blk_init_queue really should change names, IMO.  The other 
> subsystems in the kernel tend to use a "foo_alloc" or "alloc_foo" 
> pattern when creating new objects.  blk_alloc_queue, or simply blk_alloc?

blk_alloc_queue() would be fine. However, it's hard to screw the usage
up since it returns a queue, so... And people with out-of-tree drivers
that need to be converted need only look at the blk_init_queue()
changes, easy to grep for.

-- 
Jens Axboe

