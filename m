Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278085AbRKMSpC>; Tue, 13 Nov 2001 13:45:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277341AbRKMSox>; Tue, 13 Nov 2001 13:44:53 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:4315 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S278085AbRKMSol>; Tue, 13 Nov 2001 13:44:41 -0500
Date: Tue, 13 Nov 2001 10:42:10 -0800
From: Jonathan Lahr <lahr@us.ibm.com>
To: Jens Axboe <axboe@suse.de>
Cc: lahr@eng2.beaverton.ibm.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] SCSI io_request_lock patch
Message-ID: <20011113104210.L26302@us.ibm.com>
In-Reply-To: <20011112130902.B26302@us.ibm.com> <20011113092311.L786@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011113092311.L786@suse.de>; from axboe@suse.de on Tue, Nov 13, 2001 at 09:23:11AM +0100
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe [axboe@suse.de] wrote:
> On Mon, Nov 12 2001, Jonathan Lahr wrote:
> > 
> > This is a request for comments on the patch described below which 
> > implements a revised approach to reducing io_request_lock contention 
> > in 2.4.
> > 
> > This new version of the io_request_lock patch (siorl-v0) is available
> > at http://sourceforge.net/projects/lse/.  It employs the same
> > concurrent request queueing scheme as the iorlv0 patch but isolates 
> > code changes to the SCSI subsystem and engages the new locking scheme 
> > only for SCSI drivers which explicitly request it.  I took this more 
> > restricted approach after additional development based on comments from 
> > Jens and others indicated that iorlv0 impacted the IDE subsystem and
> > was unnecessarily broad in general.
> > 
> > The siorl-v0 patch allows drivers to enable concurrent queueing through 
> > the concurrent_queue field in the Scsi_Host_Template which is copied to 
> > the request queue.  It creates SCSI-specific versions of generic block 
> > i/o functions used by the SCSI subsystem and modifies them to conditionally 
> > engage the new locking scheme based on this field.  It allows control over 
> > which drivers use concurrent queueing and preserves original block i/o 
> > behavior by default.
> 
> Sorry Jonathan, but this is even more broken than the last patch. In
> different ways. In no particular order:
> 
> o You are duplicating way too much code and exporting block internals

The duplication is a reasonable starting point for SCSI-specific functions.
The block i/o design provides for exactly this type of tailoring through
function pointers installed in request_queue.

What problem you do see with exporting block internals?

> o You are breaking SCSI merge completely, why on earth are you suddenly
>   using ll_*_merge functions for SCSI?!
> o scsi_make_request need not worry about head active
> o scsi_make_request can safe the q->*_merge indirect
> o scsi_dispatch_cmd() io_request_lock removal looks racy

I will investigate the above comments further.

> At least you are not breaking anything other than SCSI this time...

Do you think the separation of SCSI from generic block i/o code and the
driver-activated control of concurrent queueing provides a path for future 
work to reduce io_request_lock contention in SCSI/FC?

-- 
Jonathan Lahr
IBM Linux Technology Center
Beaverton, Oregon
lahr@us.ibm.com
503-578-3385

