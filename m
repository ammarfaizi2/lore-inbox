Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbWHQD7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbWHQD7r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 23:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbWHQD7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 23:59:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:4322 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932228AbWHQD7q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 23:59:46 -0400
From: Neil Brown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 17 Aug 2006 13:59:41 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17635.59821.21444.287979@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC - how to balance Dirty+Writeback in the face of slow
 writeback.
In-Reply-To: message from Andrew Morton on Tuesday August 15
References: <17633.2524.95912.960672@cse.unsw.edu.au>
	<20060815010611.7dc08fb1.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday August 15, akpm@osdl.org wrote:
> > When Dirty hits 0 (and Writeback is theoretically 80% of RAM)
> > balance_dirty_pages will no longer be able to flush the full
> > 'write_chunk' (1.5 times number of recent dirtied pages) and so will
> > spin in a loop calling blk_congestion_wait(WRITE, HZ/10), so it isn't
> > a busy loop, but it won't progress.
> 
> This assumes that the queues are unbounded.  They're not - they're limited
> to 128 requests, which is 60MB or so.

Ahhh... so the limit on the requests-per-queue is an important part of
write-throttling behaviour.  I didn't know that, thanks.

fs/nfs doesn't seem to impose a limit.  It will just allocate as many
as you ask for until you start running out of memory.  I've seen 60%
of memory (10 out of 16Gig) in writeback for NFS.

Maybe I should look there to address my current issue, though imposing
a system-wide writeback limit seems safer.

> 
> Per queue.  The scenario you identify can happen if it's spread across
> multiple disks simultaneously.
> 
> CFQ used to have 1024 requests and we did have problems with excessive
> numbers of writeback pages.  I fixed that in 2.6.early, but that seems to
> have got lost as well.
> 

What would you say constitutes "excessive"?  Is there any sense in
which some absolute number is excessive (as it takes too long to scan
some list) or is it just a percent-of-memory thing?

> 
> Something like that - it'll be relatively simple.

Unfortunately I think it is also relatively simple to get it badly
wrong:-)  Make one workload fast, and another slower.

But thanks, you've been very helpful (as usual).  I'll ponder it a bit
longer and see what turns up.

NeilBrown
