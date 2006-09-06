Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWIFMrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWIFMrP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 08:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWIFMrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 08:47:15 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:52637 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1750825AbWIFMrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 08:47:14 -0400
Date: Wed, 6 Sep 2006 14:47:19 +0200
From: Jan Kara <jack@suse.cz>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Anton Altaparmakov <aia21@cam.ac.uk>,
       sct@redhat.com, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, ext4 <linux-ext4@vger.kernel.org>,
       jack@suse.cz
Subject: Re: [RFC][PATCH] set_page_buffer_dirty should skip unmapped buffers
Message-ID: <20060906124719.GA11868@atrey.karlin.mff.cuni.cz>
References: <1157125829.30578.6.camel@dyn9047017100.beaverton.ibm.com> <Pine.LNX.4.64.0609011652420.24650@hermes-2.csi.cam.ac.uk> <1157128342.30578.14.camel@dyn9047017100.beaverton.ibm.com> <20060901101801.7845bca2.akpm@osdl.org> <1157472702.23501.12.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157472702.23501.12.camel@dyn9047017100.beaverton.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> On Fri, 2006-09-01 at 10:18 -0700, Andrew Morton wrote:
> > > > > Kernel BUG at fs/buffer.c:2791
> > > > > invalid opcode: 0000 [1] SMP
> > > > > 
> > > > > Its complaining about BUG_ON(!buffer_mapped(bh)).
> 
> Here is the change that seems to cause the problem. Jana Kara
> introduced a new mode "SWRITE" for ll_rw_block() - where it
> waits for buffer to be unlocked (WRITE will skip locked
> buffers) + jbd journal_commit_transaction() has been changed
> to make use of SWRITE.
> 
> http://marc.theaimsgroup.com/?l=linux-fsdevel&m=112109788702895&w=2
> 
> Theoritically same race (between journal_commit_transaction() and
> journal_unmap_buffer()+set_page_dirty()) could exist before his changes
> - which should trigger bug in submit_bh(). But I can't seem to hit
> it without his changes. My guess is ll_rw_block() is always skipping
> those cleaned up buffers, before page gets dirtied again ..
  I think that the change to ll_rw_block() just widens the window much
more...

> Andrew, what should we do ? Do you suggest handling this in jbd
> itself (like this patch) ?
  Actually that part of commit code needs rewrite anyway (and after that
rewrite you get rid of ll_rw_block()) because of other problems - the
code assumes that whenever buffer is locked, it is being written to disk
which is not true... I have some preliminary patches for that but they
are not very nice and so far I didn't have enough time to find a nice
solution.

								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
