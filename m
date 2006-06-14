Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964875AbWFNFSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbWFNFSy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 01:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964876AbWFNFSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 01:18:54 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:4193 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964875AbWFNFSs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 01:18:48 -0400
Date: Wed, 14 Jun 2006 07:19:17 +0200
From: Jens Axboe <axboe@suse.de>
To: Thomas Petazzoni <thomas.petazzoni@enix.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Use of spinlock after free with CFQ scheduler
Message-ID: <20060614051917.GF4420@suse.de>
References: <20060613173733.618192bf@thomas.toulouse>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060613173733.618192bf@thomas.toulouse>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13 2006, Thomas Petazzoni wrote:
> Hi,
> 
> While developing a block device driver, we stumbled upon the kernel
> panic reported at
> http://www.ussg.iu.edu/hypermail/linux/kernel/0512.3/0297.html.
> According to the mail and your answer, it seems that the CFQ scheduler
> uses the queue lock after blk_cleanup_queue(). At this time, the
> spinlock might have been freed. I can confirm that the bug doesn't
> appear with other I/O schedulers.
> 
> However, the proposed fix for "ub" looks quite strange to me. It uses
> a static array of spinlocks, so that they remain in memory after
> blk_cleanup_queue(). However, "ub" can be compiled as a module, so I
> don't see what prevent the use of the queue spinlocks by the CFQ
> scheduler once the module has been unloaded. I do not understand how the
> provided patch correctly fixes the bug.

You must not be able to remove the module, while CFQ still has
references to the locks around. The problem observed initially with ub
is that it doesn't honor queue reference counting - it embeds a queue
lock inside some structure, that it will free eg on device removal. The
lock associated with the queue obviously needs to follow the same life
cycle as the queue.

> The bug was reported on a pre-2.6.15 kernel, but we're still seeing
> this bug with a 2.6.16 FedoraCore-hacked kernel.
> 
> To me, the bug seems to be in the CFQ scheduler itself, isn't it ?
> Maybe we should use the internal queue lock (by passing NULL as the
> lock parameter to the blk_init_queue() call), and then modify the CFQ
> scheduler so that it correctly increments/decrements the queue->refcnt ?

Where do you see a bug in the CFQ inc/dec of the queue reference count?

You can give 2.6.17-rcX (X == latest) a spin and see if that changes
anything for you.

-- 
Jens Axboe

