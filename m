Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268577AbUHYGw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268577AbUHYGw0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 02:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268580AbUHYGw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 02:52:26 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:23747 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S268577AbUHYGwX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 02:52:23 -0400
Date: Wed, 25 Aug 2004 08:50:55 +0200
From: Jens Axboe <axboe@suse.de>
To: Peter Osterlund <petero2@telia.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Speed up the cdrw packet writing driver
Message-ID: <20040825065055.GA2321@suse.de>
References: <m33c2py1m1.fsf@telia.com> <20040823114329.GI2301@suse.de> <m3llg5dein.fsf@telia.com> <20040824202951.GA24280@suse.de> <m3hdqsckoo.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3hdqsckoo.fsf@telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24 2004, Peter Osterlund wrote:
> Jens Axboe <axboe@suse.de> writes:
> 
> > On Mon, Aug 23 2004, Peter Osterlund wrote:
> > > Jens Axboe <axboe@suse.de> writes:
> > > 
> > > > On Sat, Aug 14 2004, Peter Osterlund wrote:
> > > > > 
> > > > > This patch replaces the pd->bio_queue linked list with an rbtree.  The
> > > > > list can get very long (>200000 entries on a 1GB machine), so keeping
> > > > > it sorted with a naive algorithm is far too expensive.
> > > > 
> > > > It looks like you are assuming that bio->bi_sector is unique which isn't
> > > > necessarily true. In that respect, list -> rbtree conversion isn't
> > > > trivial (or, at least it requires extra code to handle this).
> > > 
> > > I don't think that is assumed anywhere.
> > > 
> > > [...]
> > 
> > You are right, the code looks fine indeed. The bigger problem is
> > probably that a faster data structure is needed at all, having hundreds
> > of thousands bio's pending for a packet writing device is not nice at
> > all.
> 
> Why is it not nice? If the VM has decided to create 400MB of dirty
> data on a DVD+RW packet device, I don't see a problem with submitting
> all bio's at the same time to the packet device.

It's not nice because flushing 400MB of dirty data to the packet device
will take _ages_. That the vm will dirty that much data for you
non-blocking is a problem in itself. It would still be a really good
idea for the packet writing driver to "congest" itself, like it happens
for struct request devices, to prevent build up of these huge queues.

> The situation happened when I dumped >1GB of data to a DVD+RW disc on
> a 1GB RAM machine. For some reason, the number of pending bio's didn't
> go much larger than 200000 (ie 400MB) even though it could probably
> have gone to 800MB without swapping. The machine didn't feel
> unresponsive during this test.

But it very well could have. If you dive into the bio mempool (or the
biovec pool) and end up having most of those reserved entries built up
for execution half an hour from now, you'll stall (or at least hinder)
other processes from getting real work done.

Latencies are horrible, I don't think it makes sense to allow more than
a few handful of pending zone writes in the packet writing driver.

-- 
Jens Axboe

