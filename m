Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131156AbRCGSsS>; Wed, 7 Mar 2001 13:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131153AbRCGSsI>; Wed, 7 Mar 2001 13:48:08 -0500
Received: from zeus.kernel.org ([209.10.41.242]:32987 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131149AbRCGSr6>;
	Wed, 7 Mar 2001 13:47:58 -0500
Date: Wed, 7 Mar 2001 15:05:56 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Jens Axboe <axboe@suse.de>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        David Balazic <david.balazic@uni-mb.si>, torvalds@transmeta.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: scsi vs ide performance on fsync's
Message-ID: <20010307150556.L7453@redhat.com>
In-Reply-To: <3AA53DC0.C6E2F308@uni-mb.si> <20010306213720.U2803@suse.de> <20010307135135.B3715@redhat.com> <20010307151241.E526@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010307151241.E526@suse.de>; from axboe@suse.de on Wed, Mar 07, 2001 at 03:12:41PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 07, 2001 at 03:12:41PM +0100, Jens Axboe wrote:
> 
> Yep, it's much harder than it seems. Especially because for the barrier
> to be really useful, having inter-request dependencies becomes a
> requirement. So you can say something like 'flush X and Y, but don't
> flush Y before X is done'.

Yes.  Fortunately, the simplest possible barrier is just a matter of
marking a request as non-reorderable, and then making sure that you
both flush the elevator queue before servicing that request, and defer
any subsequent requests until the barrier request has been satisfied.
One it has gone through, you can let through the deferred requests (in
order, up to the point at which you encounter another barrier).

Only if the queue is empty can you give a barrier request directly to
the driver.  The special optimisation you can do in this case with
SCSI is to continue to allow new requests through even before the
barrier has completed if the disk supports ordered queue tags.  

--Stephen
