Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbVA1ISh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVA1ISh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 03:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVA1ISh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 03:18:37 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:44482 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261171AbVA1IS2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 03:18:28 -0500
Date: Fri, 28 Jan 2005 09:18:14 +0100
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Doug Maxey <dwm@maxeymade.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi/sata write barrier support
Message-ID: <20050128081814.GH4800@suse.de>
References: <200501272242.j0RMgoP5016154@falcon30.maxeymade.com> <41F97299.2070909@pobox.com> <20050128065358.GA4800@suse.de> <41F9F386.7070501@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F9F386.7070501@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28 2005, Jeff Garzik wrote:
> Jens Axboe wrote:
> >On Thu, Jan 27 2005, Jeff Garzik wrote:
> >
> >>Doug Maxey wrote:
> >>
> >>>On Thu, 27 Jan 2005 13:02:48 +0100, Jens Axboe wrote:
> >>>
> >>>
> >>>>Hi,
> >>>>
> >>>>For the longest time, only the old PATA drivers supported barrier writes
> >>>>with journalled file systems. This patch adds support for the same type
> >>>>of cache flushing barriers that PATA uses for SCSI, to be utilized with
> >>>>libata. 
> >>>
> >>>
> >>>What, if any mechanism supports changing the underlying write cache?  
> >>>
> >>>That is, assuming this is common across PATA and SCSI drives, and it is 
> >>>possible to turn the cache off on the IDE drives, would switching the 
> >>>cache underneath require completing the inflight IO?
> >>
> >>[ignoring your question, but it made me think...]
> >>
> >>
> >>I am thinking the barrier support should know if the write cache is 
> >>disabled (some datacenters do this), and avoid flushing if so?
> >
> >
> >Ehm it does, read the code :)
> 
> 
> I did.  I see nowhere that handles the case where the user uses a util 
> (hdparm or blktool) to switch off write cache after sd.c has probed the 
> disk.  sd only sets its WCE bit at probe time, and doesn't appear to 
> notice state changes.

WCE bit should change then, like ->wcache does for ide. It's handled
inside sd, there's nothing more it can do. sd_shutdown() and
sd_issue_flush() have the same issue, they all rely on ->WCE being
correct.

Can't say I'm too fond of command snooping, but I guess it's the only
solution.

> Since nobody snoops the MODE SELECT on the caching page, nobody knows 
> past probe the state of write caching.
> 
> Thus my comment...   I think barrier support should know about that sort 
> of thing :)

So this would mainly be a problem if you boot with write caching
disabled, but later turn it on. The other way around will still work
safely, at the cost of two noop commands on each write barrier (which I
doubt you would notice).

-- 
Jens Axboe

