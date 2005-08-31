Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932420AbVHaNqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbVHaNqL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 09:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbVHaNqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 09:46:11 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:29330 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932420AbVHaNqK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 09:46:10 -0400
Date: Wed, 31 Aug 2005 15:43:02 +0200
From: Jens Axboe <axboe@suse.de>
To: Brian King <brking@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] block: CFQ refcounting fix
Message-ID: <20050831134259.GW4018@suse.de>
References: <200508302241.j7UMf8ag018433@d01av03.pok.ibm.com> <20050831072830.GG4018@suse.de> <4315B366.5040906@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4315B366.5040906@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31 2005, Brian King wrote:
> Jens Axboe wrote:
> > On Tue, Aug 30 2005, brking@us.ibm.com wrote:
> > 
> >>I ran across a memory leak related to the cfq scheduler. The cfq
> >>init function increments the refcnt of the associated request_queue.
> >>This refcount gets decremented in cfq's exit function. Since blk_cleanup_queue
> >>only calls the elevator exit function when its refcnt goes to zero, the
> >>request_q never gets cleaned up. It didn't look like other io schedulers were
> >>incrementing this refcnt, so I removed the refcnt increment and it fixed the
> >>memory leak for me.
> >>
> >>To reproduce the problem, simply use cfq and use the scsi_host scan sysfs
> >>attribute to scan "- - -" repeatedly on a scsi host and watch the memory
> >>vanish.
> > 
> > 
> > Yeah, that actually looks like a dangling reference. I assume you tested
> > this properly?
> 
> Yes. I applied the patch, booted my system (which was crashing on
> bootup before due to out of memory errors due to the leak) ran the
> scan a few times and verified /proc/meminfo didn't continually
> decrease like without it, and rebooted again.  If there is anything
> else you would like me to do, I would be happy to do so.

I think you need to remove the blk_put_queue() in cfq_put_cfqd() as
well, otherwise I don't see how this can work without looking at freed
memory. I'll audit the other paths as well.

-- 
Jens Axboe

