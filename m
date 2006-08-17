Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965148AbWHQPap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965148AbWHQPap (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 11:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965151AbWHQPap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 11:30:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2777 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965148AbWHQPao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 11:30:44 -0400
Date: Thu, 17 Aug 2006 08:30:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Neil Brown <neilb@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: RFC - how to balance Dirty+Writeback in the face of slow
 writeback.
Message-Id: <20060817083035.8b775b12.akpm@osdl.org>
In-Reply-To: <1155820912.5662.39.camel@localhost>
References: <17633.2524.95912.960672@cse.unsw.edu.au>
	<20060815010611.7dc08fb1.akpm@osdl.org>
	<17635.59821.21444.287979@cse.unsw.edu.au>
	<1155820912.5662.39.camel@localhost>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2006 09:21:51 -0400
Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> On Thu, 2006-08-17 at 13:59 +1000, Neil Brown wrote:
> > On Tuesday August 15, akpm@osdl.org wrote:
> > > > When Dirty hits 0 (and Writeback is theoretically 80% of RAM)
> > > > balance_dirty_pages will no longer be able to flush the full
> > > > 'write_chunk' (1.5 times number of recent dirtied pages) and so will
> > > > spin in a loop calling blk_congestion_wait(WRITE, HZ/10), so it isn't
> > > > a busy loop, but it won't progress.
> > > 
> > > This assumes that the queues are unbounded.  They're not - they're limited
> > > to 128 requests, which is 60MB or so.
> > 
> > Ahhh... so the limit on the requests-per-queue is an important part of
> > write-throttling behaviour.  I didn't know that, thanks.
> > 
> > fs/nfs doesn't seem to impose a limit.  It will just allocate as many
> > as you ask for until you start running out of memory.  I've seen 60%
> > of memory (10 out of 16Gig) in writeback for NFS.
> > 
> > Maybe I should look there to address my current issue, though imposing
> > a system-wide writeback limit seems safer.
> 
> Exactly how would a request limit help? All that boils down to is having
> the VM monitor global_page_state(NR_FILE_DIRTY) versus monitoring
> global_page_state(NR_FILE_DIRTY)+global_page_state(NR_WRITEBACK).
> 

I assume that if NFS is not limiting its NR_WRITEBACK consumption and block
devices are doing so, we could get in a situation where NFS hogs all of the
fixed-size NR_DIRTY+NR_WRITEBACK resource at the expense of concurrent
block-device-based writeback.

Perhaps.  The top-level poll-the-superblocks writeback loop might tend to
prevent that from happening.  But if applications were doing a lot of
superblock-specific writeback (fdatasync,
sync_file_range(SYNC_FILE_RANGE_WRITE), etc) then unfairness might occur.
