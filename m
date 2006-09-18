Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965252AbWIROKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965252AbWIROKs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 10:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965254AbWIROKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 10:10:48 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:29876 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S965252AbWIROKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 10:10:47 -0400
Date: Mon, 18 Sep 2006 10:10:31 -0400
From: Chris Mason <chris.mason@oracle.com>
To: Nick Piggin <npiggin@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@kernel.dk>
Subject: Re: [rfc][patch 2.6.18-rc7] block: explicit plugging
Message-ID: <20060918141031.GB2884@opti.oraclecorp.com>
References: <20060916115607.GA16971@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060916115607.GA16971@wotan.suse.de>
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 16, 2006 at 01:56:07PM +0200, Nick Piggin wrote:
> Hi,
> 
> I've been tinkering with this idea for a while, and I'd be interested
> in seeing what people think about it. The patch isn't in a great state
> of commenting or splitting ;) but I'd be interested feelings about the
> general approach, and whether I'm going to hit any bad problems (eg.
> with SCSI or IDE).
> 
> Nick
> 
> 
> This is a patch to perform block device plugging explicitly in the submitting
> process context rather than implicitly by the block device.
> 
> There are several advantages to plugging in process context over plugging
> by the block device:
> 
[ ... ]

> On a parallel tiobench benchmark, of the 800 000 calls to __make_request
> performed, this patch avoids 490 000 (62%) of queue_lock aquisitions by
> early merging on the private plugged list.

That is certainly interesting.  Intuitively, I would guess that having
the unplug per-process is going to slow down the case where multiple
procs are banging on the dirty list for multiple files (ie for heavy
memory pressure).  It feels like we're not going to merge as
effectively, but your tiobench test should have hit that.  Did you look
at elevator stats from the test?

> 
> Testing and development is in early stages yet. In particular, the lack of
> a timer based unplug kick probably breaks some block device drivers in
> funny ways (though works here for me with SCSI and UML so far). Also needs
> much wider testing.

Missed unplugs were a nasty problem.  We had a bunch of strange io
stalls and deadlocks without the implicit unplugging, and we also
managed to keep creating new ones as patches rolled into the block
subsystem.  I would really like to keep some kind of catchall implicit
unplug in there.

-chris
