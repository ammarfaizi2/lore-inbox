Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262325AbUC1SQm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 13:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbUC1SQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 13:16:42 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:50382 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262130AbUC1SQa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 13:16:30 -0500
Date: Sun, 28 Mar 2004 20:15:03 +0200
From: Jens Axboe <axboe@suse.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
Message-ID: <20040328181502.GO24370@suse.de>
References: <40661049.1050004@yahoo.com.au> <406611CA.3050804@pobox.com> <406612AA.1090406@yahoo.com.au> <4066156F.1000805@pobox.com> <20040328141014.GE24370@suse.de> <40670BD9.9020707@pobox.com> <20040328173508.GI24370@suse.de> <40670FDB.6080409@pobox.com> <20040328175436.GL24370@suse.de> <20040328180809.GB1087@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040328180809.GB1087@mail.shareable.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28 2004, Jamie Lokier wrote:
> Jens Axboe wrote:
> > Sorry, but I cannot disagree more. You think an artificial limit at
> > the block layer is better than one imposed at the driver end, which
> > actually has a lot more of an understanding of what hardware it is
> > driving?  This makes zero sense to me. Take floppy.c for instance, I
> > really don't want 1MB requests there, since that would take a minute
> > to complete. And I might not want 1MB requests on my Super-ZXY
> > storage, because that beast completes io easily at an iorate of
> > 200MB/sec.
> 
> The driver doesn't know how fast the drive is either.
> 
> Without timing the drive, interface, and for different request sizes,
> neither the block layer _nor_ the driver know a suitable size.

The driver may not know exactly, but it does know a ball park figure.
You know if you are driving floppy (sucky transfer and latency), hard
drive, cdrom (decent transfer, sucky seeks), etc.

> > I absolutely refuse to put a global block layer 'optimal io
> > size' restriction in, since that is the ugliest of policies and
> > without having _any_ knowledge of what the hardware can do.
> 
> But the driver doesn't have _any_ knowledge of what the I/O scheduler
> wants.  1MB requests may be a cut-off above which there is negligable

It's not what the io scheduler wants, it's what you can provide at a
reasonable latency. You cannot preempt that unit of io.

> throughput gain for SATA, but those requests may be _far_ too large
> for a low-latency I/O scheduling requirement.
> 
> If we have a high-level latency scheduling constraint that userspace
> should be able to issue a read and get the result within 50ms, or that
> the average latency for reads should be <500ms, how does the SATA
> driver limiting requests to 1MB help?  It depends on the attached drive.

Yep it sure does, but try and find a drive attached to a SATA controller
that cannot do 40MiB/sec (or something like that). Storage doesn't move
_that_ fast, you can keep up.

> The fundamental problem here is that neither the driver nor the block
> layer have all the information needed to select optimal or maximum
> request sizes.  That can only be found by timing the device, perhaps
> every time a request is made, and adjusting the I/O scheduling and
> request splitting parameters according to that timing and high-level
> latency requirements.

I agree with that, completely. And I still maintain that putting the
restriction blindly into the hands of the block layer is not a good
idea. The driver may not know completely what storage is attached to it,
but it can peek and poke and get a general idea. As it stands right now,
the block layer has _zero_ knowledge. Unless you start adding timing and
imposing max request size based on the latencies. If you do that, then I
would be quite happy with changing ->max_sectors to be the hardware
limit.

> >From that point of view, the generic block layer is exactly the right
> place to determine those parameters, because the calculation is not
> device-specific.

If you start adding that type of code. That's a different discussion
than this one, though, and it would raise a new set of problems (AS io
scheduler already does some of this privately).

-- 
Jens Axboe

