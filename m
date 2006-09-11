Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964998AbWIKUwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964998AbWIKUwe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 16:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbWIKUwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 16:52:34 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:64220 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S964943AbWIKUwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 16:52:33 -0400
Date: Mon, 11 Sep 2006 22:52:12 +0200
From: Jan Kara <jack@suse.cz>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, sct@redhat.com,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [RFC][PATCH] set_page_buffer_dirty should skip unmapped buffers
Message-ID: <20060911205212.GC23475@atrey.karlin.mff.cuni.cz>
References: <20060906162723.GA14345@atrey.karlin.mff.cuni.cz> <1157563016.23501.39.camel@dyn9047017100.beaverton.ibm.com> <20060906172733.GC14345@atrey.karlin.mff.cuni.cz> <1157641877.7725.13.camel@dyn9047017100.beaverton.ibm.com> <20060907223048.GD22549@atrey.karlin.mff.cuni.cz> <4500F2B2.4010204@us.ibm.com> <20060908082531.GA28397@atrey.karlin.mff.cuni.cz> <45017FAA.1070203@us.ibm.com> <20060911094641.GA3336@atrey.karlin.mff.cuni.cz> <1158007528.30318.12.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158007528.30318.12.camel@dyn9047017100.beaverton.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 2006-09-11 at 11:46 +0200, Jan Kara wrote:
> ...
> > > 
> > > I don't have any performance tests handy. We have some automated tests I 
> > > can schedule to run to verify the stability aspects.
> >   OK. I've run IOZONE rewrite throughput test on my computer with
> > iozone -t 10 -i 0 -s 10M -e
> >   2.6.18-rc6 and the same kernel + my patch seem to give almost the same
> > results. The strange thing was that both in vanilla and patched kernel there
> > were several runs where a write througput (when iozone was creating the file)
> > was suddenly 10% of the usual value (18MB/s vs. 2MB/s). The rewrite numbers
> > were always fine. Maybe that has something to do with block allocation
> > code. Anyway, it is not a regression of my patch so unless your test
> > finds some problem I think the patch should be ready for inclusion into
> > -mm...
> 
> Your patch seems to be working fine. I haven't found any major
> regression yet. 
> 
> I spent lot of time trying to reproduce the problem with buffer-debug
> Andrew sent out - I really wanted to get to bottom of whats really
> happening here (since your patch made it go away).
> 
> Yes. Your theory is correct. journal_dirty_data() is moving the
> buffer-head from commited transaction to current one and
> journal_unmap_buffer() is discarding and cleaning up the buffer-head.
> Later set_page_dirty() dirties the buffer-head there by causing
> BUG() in submit_bh().
> 
> Here is the buffer-trace-debug output to confirm it. I can sleep better
> now :) Now we can figure out, if your fix is the right one or not ..
  OK, good to hear :). My patch should be prone at least to this problem
(I'm not saying it could not have introduced any other ;). It locks the
buffer and if it needed to drop JBD spin locks, it also checks whether
the buffer remained in the BJ_SyncData list. Hence if the
journal_dirty_data() steals the buffer while we are locking it we find
that out and forget about the buffer. Once the buffer is locked,
journal_dirty_data() won't touch it.
  I guess the patch is good enough to send it to Andrew...

								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
