Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281553AbRKMIXy>; Tue, 13 Nov 2001 03:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281551AbRKMIXn>; Tue, 13 Nov 2001 03:23:43 -0500
Received: from 75.ppp1-8.hob.worldonline.dk ([213.237.85.75]:31618 "EHLO
	milhouse.home.kernel.dk") by vger.kernel.org with ESMTP
	id <S281550AbRKMIX3>; Tue, 13 Nov 2001 03:23:29 -0500
Date: Tue, 13 Nov 2001 09:23:11 +0100
From: Jens Axboe <axboe@suse.de>
To: Jonathan Lahr <lahr@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] SCSI io_request_lock patch
Message-ID: <20011113092311.L786@suse.de>
In-Reply-To: <20011112130902.B26302@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011112130902.B26302@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12 2001, Jonathan Lahr wrote:
> 
> This is a request for comments on the patch described below which 
> implements a revised approach to reducing io_request_lock contention 
> in 2.4.
> 
> This new version of the io_request_lock patch (siorl-v0) is available
> at http://sourceforge.net/projects/lse/.  It employs the same
> concurrent request queueing scheme as the iorlv0 patch but isolates 
> code changes to the SCSI subsystem and engages the new locking scheme 
> only for SCSI drivers which explicitly request it.  I took this more 
> restricted approach after additional development based on comments from 
> Jens and others indicated that iorlv0 impacted the IDE subsystem and
> was unnecessarily broad in general.
> 
> The siorl-v0 patch allows drivers to enable concurrent queueing through 
> the concurrent_queue field in the Scsi_Host_Template which is copied to 
> the request queue.  It creates SCSI-specific versions of generic block 
> i/o functions used by the SCSI subsystem and modifies them to conditionally 
> engage the new locking scheme based on this field.  It allows control over 
> which drivers use concurrent queueing and preserves original block i/o 
> behavior by default.

Sorry Jonathan, but this is even more broken than the last patch. In
different ways. In no particular order:

o You are duplicating way too much code and exporting block internals
o You are breaking SCSI merge completely, why on earth are you suddenly
  using ll_*_merge functions for SCSI?!
o scsi_make_request need not worry about head active
o scsi_make_request can safe the q->*_merge indirect
o scsi_dispatch_cmd() io_request_lock removal looks racy

At least you are not breaking anything other than SCSI this time...

-- 
Jens Axboe

