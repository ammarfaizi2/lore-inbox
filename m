Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267155AbUBSKQE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 05:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267168AbUBSKQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 05:16:04 -0500
Received: from 10fwd.cistron-office.nl ([62.216.29.197]:30169 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id S267155AbUBSKQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 05:16:00 -0500
Date: Thu, 19 Feb 2004 11:15:19 +0100
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Miquel van Smoorenburg <miquels@cistron.nl>, miquels@cistron.nl,
       axboe@suse.de, linux-lvm@sistina.com, linux-kernel@vger.kernel.org,
       thornber@redhat.com
Subject: Re: IO scheduler, queue depth, nr_requests
Message-ID: <20040219101519.GG30621@drinkel.cistron.nl>
References: <20040216131609.GA21974@cistron.nl> <20040216133047.GA9330@suse.de> <20040217145716.GE30438@traveler.cistron.net> <20040218235243.GA30621@drinkel.cistron.nl> <20040218172622.52914567.akpm@osdl.org> <20040219021159.GE30621@drinkel.cistron.nl> <20040218182628.7eb63d57.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20040218182628.7eb63d57.akpm@osdl.org> (from akpm@osdl.org on Thu, Feb 19, 2004 at 03:26:28 +0100)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Feb 2004 03:26:28, Andrew Morton wrote:
> Miquel van Smoorenburg <miquels@cistron.nl> wrote:
> >
> > The thing is, the bio's are submitted perfectly sequentially. It's just that
> >  every so often a request (with just its initial bio) gets stuck for a while.
> >  Because the bio's after it are merged and sent to the device, it's not
> >  possible to merge that stuck request later on when it gets unstuck, because
> >  the other bio's have already left the building so to speak.
> 
> Oh.  So the raid controller's queue depth is larger than the kernel's.  So
> everything gets immediately shovelled into the device and the kernel is
> left with nothing to merge the little request against.

Well, the request queue of the kernel is max'ed out too, otherwise
get_request_wait() wouldn't be called. It's just an unfortunate timing issue.

> Shouldn't the controller itself be performing the insertion?

Well, you would indeed expect the 3ware hardware to be smarter than that,
but in its defence, the driver doesn't set sdev->simple_tags or sdev->ordered_tags
at all. It just has a large queue on the host, in hardware.

Perhaps this info should be exported into the request queue of the device,
so that ll_rw_blk knows about this and can do something similar to the
hack I posted ?

Note that AFAICS nothing in drivers/scsi uses the tagging stuff in ll_rw_blk.c.
blk_queue_init_tags() is only called by scsi_activate_tcq(), and nothing
ever calls that (except the 53c700.c driver). So you can't just check for
QUEUE_FLAG_QUEUED. Hmm, nothing in drivers/block calls it either. It's
not being used at all yet ? Or am I being dense ?

Mike.
