Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131153AbRCGSwi>; Wed, 7 Mar 2001 13:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131159AbRCGSw2>; Wed, 7 Mar 2001 13:52:28 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:61452 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S131153AbRCGSwW>;
	Wed, 7 Mar 2001 13:52:22 -0500
Date: Wed, 7 Mar 2001 19:51:52 +0100
From: Jens Axboe <axboe@suse.de>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: David Balazic <david.balazic@uni-mb.si>, torvalds@transmeta.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: scsi vs ide performance on fsync's
Message-ID: <20010307195152.C4653@suse.de>
In-Reply-To: <3AA53DC0.C6E2F308@uni-mb.si> <20010306213720.U2803@suse.de> <20010307135135.B3715@redhat.com> <20010307151241.E526@suse.de> <20010307150556.L7453@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010307150556.L7453@redhat.com>; from sct@redhat.com on Wed, Mar 07, 2001 at 03:05:56PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07 2001, Stephen C. Tweedie wrote:
> > Yep, it's much harder than it seems. Especially because for the barrier
> > to be really useful, having inter-request dependencies becomes a
> > requirement. So you can say something like 'flush X and Y, but don't
> > flush Y before X is done'.
> 
> Yes.  Fortunately, the simplest possible barrier is just a matter of
> marking a request as non-reorderable, and then making sure that you
> both flush the elevator queue before servicing that request, and defer
> any subsequent requests until the barrier request has been satisfied.
> One it has gone through, you can let through the deferred requests (in
> order, up to the point at which you encounter another barrier).

The above should have been inter-queue dependencies. For one queue
it's not a big issue, you basically described the whole sequence
above. Either sequence it as zero for a non-empty queue and make
sure the low level driver orders or flushes, or just hand it directly
to the device.

My bigger concern is when the journalled fs has a log on a different
queue.

> Only if the queue is empty can you give a barrier request directly to
> the driver.  The special optimisation you can do in this case with
> SCSI is to continue to allow new requests through even before the
> barrier has completed if the disk supports ordered queue tags.  

Yep, IDE will have to pay the price of a flush.

-- 
Jens Axboe

