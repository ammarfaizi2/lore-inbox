Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267442AbUBSBxF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 20:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267443AbUBSBxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 20:53:05 -0500
Received: from 10fwd.cistron-office.nl ([62.216.29.197]:14799 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id S267442AbUBSBxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 20:53:00 -0500
Date: Thu, 19 Feb 2004 02:52:07 +0100
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Miquel van Smoorenburg <miquels@cistron.nl>, Jens Axboe <axboe@suse.de>,
       linux-lvm@sistina.com, linux-kernel@vger.kernel.org,
       Joe Thornber <thornber@redhat.com>
Subject: Re: IO scheduler, queue depth, nr_requests
Message-ID: <20040219015207.GC30621@drinkel.cistron.nl>
References: <20040216131609.GA21974@cistron.nl> <20040216133047.GA9330@suse.de> <20040217145716.GE30438@traveler.cistron.net> <20040218235243.GA30621@drinkel.cistron.nl> <4034104F.5040002@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <4034104F.5040002@cyberone.com.au> (from piggin@cyberone.com.au on Thu, Feb 19, 2004 at 02:24:31 +0100)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Feb 2004 02:24:31, Nick Piggin wrote:
> Miquel van Smoorenburg wrote:
>
> >I found out what causes this. It's get_request_wait().
> >
> >When the request queue is full, and a new request needs to be created,
> >__make_request() blocks in get_request_wait().
> >
> >Another process wakes up first (pdflush / process submitting I/O itself /
> >xfsdatad / etc) and sends the next bio's to __make_request().
> >In the mean time some free requests have become available, and the bios
> >are merged into a new request. Those requests are submitted to the device.
> >
> >Then, get_request_wait() returns but the bio is not mergeable anymore -
> >and that results in a backwards seek, severely limiting the I/O rate.
> >
> 
> The "batching" logic there should allow a process to submit
> a number of requests even above the nr_requests limit to
> prevent this interleave and context switching.
> 
> Are you using tagged command queueing? What depth?

No, I'm not using tagged command queueing. The 3ware controller is not a
real scsi controller, the driver just emulates one. It's a raid5 controller
that drives SATA disks. It has an internal request queue ("can_queu")
of 254 outstanding commands. Because that is way bigger than nr_requests
this happens - if I set nr_requests to 512, the problem goes away. But
that shouldn't happen ;)

I'm preparing a proof-of-concept patch now, if it works and I don't wedge
the remote machine I'm testing this on I'll post it in a few minutes.

Mike.
> 
> 
> 
