Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262269AbVDFR7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbVDFR7E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 13:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262270AbVDFR7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 13:59:03 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:3743 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262269AbVDFR65 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 13:58:57 -0400
Date: Wed, 6 Apr 2005 19:58:39 +0200
From: Jens Axboe <axboe@suse.de>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Chris Rankin <rankincj@yahoo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [OOPS] 2.6.11 - NMI lockup with CFQ scheduler
Message-ID: <20050406175838.GC15165@suse.de>
References: <20050329115405.97559.qmail@web52909.mail.yahoo.com> <20050329120311.GO16636@suse.de> <1112804840.5476.16.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112804840.5476.16.camel@mulgrave>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06 2005, James Bottomley wrote:
> On Tue, 2005-03-29 at 14:03 +0200, Jens Axboe wrote:
> > It is quite a serious problem, not just for CFQ. SCSI referencing is
> > badly broken there.
> 
> OK ... I accept that with regard to the queue lock.

It is much deeper than that. The recent hack to kill requests is yet
another example of that. At least this work-around makes it a little
better, but the mid layer assumption that sdev going to zero implies the
queue going away at the same time is inherently broken.

> However, rather than trying to work out a way to tie all the refcounted
> objects together, what about the simpler solution of making the lock
> bound to the lifetime of the queue?

That's essentially what the work-around does.

> As far as SCSI is concerned, we could simply move the lock into the
> request_queue structure and everything would work since the device holds
> a reference to the queue.  The way it would work is that we'd simply
> have a lock in the request_queue structure, but it would be up to the
> device to pass it in in blk_init_queue.  Then we'd alter the scsi_device
> sdev_lock to be a pointer to the queue lock?  This scheme would also
> work for the current users who have a global lock (they simply wouldn't
> use the lock int the request_queue).
> 
> The only could on the horizon with this scheme is that there may
> genuinely be places where we want multiple queues to share a non-global
> lock:  situations where we have shared issue queues (like IDE), or
> shared tag resources are a possibility.  To cope with those, we'd
> probably have to have a separately allocated, reference counted lock.
> 
> However, I'm happy to implement the simpler solution (lock in
> requuest_queue) if you agree.

I rather like the queue lock being a pointer, so you can share at
whatever level you want. Lets not grow the request_queue a full lock
just to work around a bug elsewhere.

-- 
Jens Axboe

