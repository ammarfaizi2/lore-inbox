Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbWDSWvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbWDSWvF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 18:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWDSWvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 18:51:05 -0400
Received: from silver.veritas.com ([143.127.12.111]:12892 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751308AbWDSWvD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 18:51:03 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.04,137,1144047600"; 
   d="scan'208"; a="37371667:sNHT25093524"
Date: Wed, 19 Apr 2006 23:50:55 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Matt Mackall <mpm@selenic.com>
cc: Jeff Chua <jeffchua@silk.corp.fedex.com>, Jeff Garzik <jeff@garzik.org>,
       Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: sata suspend resume ...
In-Reply-To: <20060419214959.GR15445@waste.org>
Message-ID: <Pine.LNX.4.64.0604192332050.28312@blonde.wat.veritas.com>
References: <Pine.LNX.4.64.0604192324040.29606@indiana.corp.fedex.com>
 <Pine.LNX.4.64.0604191659230.7660@blonde.wat.veritas.com>
 <20060419214959.GR15445@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 19 Apr 2006 22:51:03.0472 (UTC) FILETIME=[BC5FEB00:01C66403]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Apr 2006, Matt Mackall wrote:
> On Wed, Apr 19, 2006 at 05:13:27PM +0100, Hugh Dickins wrote:
> > On Wed, 19 Apr 2006, Jeff Chua wrote:
> > > 
> > > System suspends ok. Resume ok. but no disk access after that.
> > 
> > Not the same disk model, but I've been having similar trouble on a T43p.

I should have mentioned before, it's suspend to RAM I'm using, by the way.

> > I was delighted to see the MSI suspend/resume fix go into 2.6.17-rc2,
> > but then disappointed.  A bisection found that Matt Mackall's sensible
> > rc1 patch, to speed up get_cmos_time, has removed what often used to be
> > a 2 second delay in resuming: things work well when I reinstate that
> > delay (1 second has proved not enough).  Below is the patch I'm using -
> > where I've failed to resist mucking around to avoid those double calls
> > to get_cmos_time, sorry: really it's just mdelay(2000) needed somewhere
> > (until someone who knows puts in something more scientific).
> 
> That's interesting.
> 
> Just to be clear, with my changes we should never fire timers early.

Yes, the only reservation I have about your patch, entirely unrelated to
this resume issue, is that those systems which "hwclock -w" on shutdown
(do they on suspend too? haven't looked) will slowly tend to lose time.

> Is the problem that we have a timer that didn't get deleted at suspend
> time?

I don't think so, but I don't really know.  On resume, the disk
goes into ata_exec_internal's 30 second timeout which ends with
"ata1: qc timeout (cmd 0xef)": nothing wrong with that timeout, anyway.

I tend to assume that it's not anything subtle, just that something
there needs a delay which it accidentally happened to get (most of
the time) from the CMOS reading, and with that gone now falls over.

I'd be able to test patches from anyone who knows what they're
doing SATA-wise, but probably not until Friday.

Hugh
