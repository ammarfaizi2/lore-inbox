Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262122AbVDLLYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262122AbVDLLYO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 07:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262240AbVDLLWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 07:22:45 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:42262 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262122AbVDLKh4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:37:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=c/jBPgxZHNCx6yGc32ds2IAYcKRRPnsu1Lvaru5ao5Qxo/H1m62i2L8T+FX2eMX5t9w6ZVpa7Aeqps7q7ArBl3OKFq0tSic338zUy2tIkmDoXRKD/2iwDWWtajRqLKmAJDZFKvd0i/N8hG+JXziZc4na8jBI+ENPGHshyHiQG7w=
Date: Tue, 12 Apr 2005 19:37:50 +0900
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com, axboe@suse.de,
       Christoph Hellwig <hch@infradead.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH scsi-misc-2.6 03/04] scsi: reimplement scsi_request_fn()
Message-ID: <20050412103750.GA23571@htj.dyndns.org>
References: <20050412103128.69172FEB@htj.dyndns.org> <20050412103128.5C5F0B72@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050412103128.5C5F0B72@htj.dyndns.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Oops, I forgot to mention that reqfn is reformatted mostly as
suggested by Chritoph Hellwig.  Sorry.

On Tue, Apr 12, 2005 at 07:33:03PM +0900, Tejun Heo wrote:
> 03_scsi_reqfn_reimplementation.patch
> 
> 	This patch rewrites scsi_request_fn().	scsi_dispatch_cmd() is
> 	merged into scsi_request_fn().	Goals are
> 
> 	* Remove unnecessary operations (host_lock unlocking/locking,
> 	  recursing into scsi_run_queue(), ...)
> 	* Consolidate defer/kill paths.
> 	* Be concise.
> 
> 	The following bugs are fixed.
> 
> 	* All killed requests now get fully prep'ed and pass through
> 	  __scsi_done().  This is the only kill path.
> 		- scsi_cmnd leak in offline-kill path removed
> 		- unfinished request bug in
> 		  scsi_dispatch_cmd():SDEV_DEL-kill path removed.
> 		- commands are never terminated directly from blk
> 		  layer unless they are invalid, so no need to supply
> 		  req->end_io callback for special requests.
> 	* Timer is added while holding host_lock, after all conditions
> 	  are checked and serial number is assigned.  This guarantees
> 	  that until host_lock is released, the scsi_cmnd pointed to
> 	  by cmd isn't released.  That didn't hold in the original
> 	  code and, theoretically, the original code could access
> 	  already released cmd.
> 	* For the same reason, if shost->hostt->queuecommand() fails,
> 	  we try to delete the timer before releasing host_lock.
> 
> 	Other changes/notes
> 
> 	* host_lock is acquired and released only once.
> 	  enter (qlocked) -> enter loop -> dev-prep -> switch to hlock -\
> 			  ^---- switch to qlock <- issue <- host-prep <-/
> 	* unnecessary if () on get_device() removed.
> 	* loop on elv_next_request() instead of blk_queue_plugged().
> 	  We now explicitly break out of loop when we plug and check if
> 	  the queue has been plugged underneath us at the end of loop.
> 	* All device/host state checks are done in this function and
> 	  done only once while holding qlock/host_lock respectively.
> 	* Requests which get deferred during dev-prep are never
> 	  removed from request queue, so deferring is achieved by
> 	  simply breaking out of the loop and returning.
> 	* Failure of blk_queue_start_tag() on tagged queue is a BUG
> 	  now.	This condition should have been catched by
> 	  scsi_dev_queue_ready().
> 	* req->special == NULL test removed.  This just can't happen,
> 	  and even if it ever happens, scsi_request_fn() will
> 	  deterministically oops.
> 	* Requests which gets deferred during host-prep are requeued
> 	  using blk_requeue_request().	This is the only requeue path.
> 
> 	Note that scsi_kill_requests() still terminates requests using
> 	blk layer.  The path is circular-ref workaround and soon to be
> 	replaced, so ignore it for now.

-- 
tejun

