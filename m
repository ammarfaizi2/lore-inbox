Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267086AbUBRXxe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 18:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267107AbUBRXxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 18:53:34 -0500
Received: from 10fwd.cistron-office.nl ([62.216.29.197]:23245 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id S267086AbUBRXx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 18:53:28 -0500
Date: Thu, 19 Feb 2004 00:52:43 +0100
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: Jens Axboe <axboe@suse.de>
Cc: Miquel van Smoorenburg <miquels@cistron.nl>, linux-lvm@sistina.com,
       linux-kernel@vger.kernel.org, Joe Thornber <thornber@redhat.com>
Subject: Re: IO scheduler, queue depth, nr_requests
Message-ID: <20040218235243.GA30621@drinkel.cistron.nl>
References: <20040216131609.GA21974@cistron.nl> <20040216133047.GA9330@suse.de> <20040217145716.GE30438@traveler.cistron.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20040217145716.GE30438@traveler.cistron.net> (from miquels@cistron.nl on Tue, Feb 17, 2004 at 15:57:16 +0100)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Feb 2004 15:57:16, Miquel van Smoorenburg wrote:
> For some reason, when using LVM, write requests get queued out
> of order to the 3ware controller, which results in quite a bit
> of seeking and thus performance loss.
[..]
> Okay I repeated some earlier tests, and I added some debug code in
> several places.
> 
> I added logging to tw_scsi_queue() in the 3ware driver to log the
> start sector and length of each request. It logs something like:
> 3wdbg: id 119, lba = 0x2330bc33, num_sectors = 256
> 
> With a perl script, I can check if the requests are sent to the
> host in order. That outputs something like this:
> 
> Consecutive: start 1180906348, length 7936 sec (3968 KB), requests: 31
> Consecutive: start 1180906340, length 8 sec (4 KB), requests: 1
> Consecutive: start 1180914292, length 7936 sec (3968 KB), requests: 31
> Consecutive: start 1180914284, length 8 sec (4 KB), requests: 1
> Consecutive: start 1180922236, length 7936 sec (3968 KB), requests: 31
> Consecutive: start 1180922228, length 8 sec (4 KB), requests: 1
> Consecutive: start 1180930180, length 7936 sec (3968 KB), requests: 31
> 
> See, 31 requests in order, then one request "backwards", then 31 in order, etc.

I found out what causes this. It's get_request_wait().

When the request queue is full, and a new request needs to be created,
__make_request() blocks in get_request_wait().

Another process wakes up first (pdflush / process submitting I/O itself /
xfsdatad / etc) and sends the next bio's to __make_request().
In the mean time some free requests have become available, and the bios
are merged into a new request. Those requests are submitted to the device.

Then, get_request_wait() returns but the bio is not mergeable anymore -
and that results in a backwards seek, severely limiting the I/O rate.

Wouldn't it be better to allow the request allocation and queue the
request, and /then/ put the process to sleep ? The queue will grow larger
than nr_requests, but it does that anyway.

Mike.
