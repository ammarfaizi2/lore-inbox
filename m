Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268370AbUHXVpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268370AbUHXVpj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 17:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268400AbUHXVpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 17:45:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:7832 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268378AbUHXVnd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 17:43:33 -0400
Date: Tue, 24 Aug 2004 14:47:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Osterlund <petero2@telia.com>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Speed up the cdrw packet writing driver
Message-Id: <20040824144707.100e0cfd.akpm@osdl.org>
In-Reply-To: <m3hdqsckoo.fsf@telia.com>
References: <m33c2py1m1.fsf@telia.com>
	<20040823114329.GI2301@suse.de>
	<m3llg5dein.fsf@telia.com>
	<20040824202951.GA24280@suse.de>
	<m3hdqsckoo.fsf@telia.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund <petero2@telia.com> wrote:
>
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

We also have a limit on the number of in-flight requests:
/sys/block/sda/queue/nr_requests.  It defaults to 128.

Are you saying that your requests are so huge that each one has 1000 BIOs? 
That would be odd, for an IDE interface.

> The situation happened when I dumped >1GB of data to a DVD+RW disc on
> a 1GB RAM machine. For some reason, the number of pending bio's didn't
> go much larger than 200000 (ie 400MB) even though it could probably
> have gone to 800MB without swapping. The machine didn't feel
> unresponsive during this test.

