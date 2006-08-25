Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422836AbWHYEg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422836AbWHYEg1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 00:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422837AbWHYEg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 00:36:27 -0400
Received: from mail.suse.de ([195.135.220.2]:22213 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422836AbWHYEg0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 00:36:26 -0400
From: Neil Brown <neilb@suse.de>
To: Jens Axboe <axboe@suse.de>
Date: Fri, 25 Aug 2006 14:36:28 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17646.32332.572865.919526@cse.unsw.edu.au>
Cc: David Chinner <dgc@sgi.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: RFC - how to balance Dirty+Writeback in the face of slow  writeback.
In-Reply-To: message from Jens Axboe on Monday August 21
References: <20060815230050.GB51703024@melbourne.sgi.com>
	<17635.60378.733953.956807@cse.unsw.edu.au>
	<20060816231448.cc71fde7.akpm@osdl.org>
	<20060818001102.GW51703024@melbourne.sgi.com>
	<20060817232942.c35b1371.akpm@osdl.org>
	<20060818070314.GE798@suse.de>
	<p73hd0998is.fsf@verdi.suse.de>
	<17640.65491.458305.525471@cse.unsw.edu.au>
	<20060821031505.GQ51703024@melbourne.sgi.com>
	<17641.24478.496091.79901@cse.unsw.edu.au>
	<20060821135132.GG4290@suse.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday August 21, axboe@suse.de wrote:
> 
> But these numbers are in no way tied to the hardware. It may be totally
> reasonable to have 3GiB of dirty data on one system, and it may be
> totally unreasonable to have 96MiB of dirty data on another. I've always
> thought that assuming any kind of reliable throttling at the queue level
> is broken and that the vm should handle this completely.

I keep changing my mind about this.  Sometimes I see it that way,
sometimes it seems very sensible for throttling to happen at the
device queue.

Can I ask a question:  Why do we have a 'nr_requests' maximum?  Why
not just allocate request structures whenever a request is made?
If there some reason relating to making the block layer work more
efficiently? or is it just because the VM requires it.


I'm beginning to think that the current scheme really works very well
- except for a few 'bugs'(*).
The one change that might make sense would be for the VM to be able to
tune the queue size of each backing dev.  Exactly how that would work
I'm not sure, but the goal would be to get the sum of the active queue
sizes to about 1 half of dirty_threshold.

The 'bugs' I am currently aware of are:
 - nfs doesn't put a limit on the request queue
 - the ext3 journal often writes out dirty data without clearing
   the Dirty flag on the page - so the nr_dirty count ends up wrong.
   ext3 writes the buffers out and marks them clean.  So when
   the VM tried to flush a page, it finds all the buffers are clean
   and so marks the page clean, so the nr_dirty count eventually
   gets correct again, but I think this can cause write throttling to
   be very unfair at times.

I think we need a queue limit on NFS requests.....

NeilBrown
