Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbUEQPVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbUEQPVe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 11:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbUEQPVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 11:21:34 -0400
Received: from cantor.suse.de ([195.135.220.2]:46490 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261611AbUEQPV2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 11:21:28 -0400
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s &&
	s->tree' failed: The saga continues.)
From: Chris Mason <mason@suse.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Larry McVoy <lm@bitmover.com>, Steven Cole <elenstev@mesatop.com>,
       Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>, hugh@veritas.com,
       adi@bitmover.com, scole@lanl.gov, support@bitmover.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405170758260.25502@ppc970.osdl.org>
References: <200405132232.01484.elenstev@mesatop.com>
	 <20040517022816.GA14939@work.bitmover.com>
	 <Pine.LNX.4.58.0405161936490.25502@ppc970.osdl.org>
	 <200405162136.24441.elenstev@mesatop.com>
	 <Pine.LNX.4.58.0405162152290.25502@ppc970.osdl.org>
	 <20040517141427.GD29054@work.bitmover.com>
	 <Pine.LNX.4.58.0405170717080.25502@ppc970.osdl.org>
	 <20040517145217.GA30695@work.bitmover.com>
	 <Pine.LNX.4.58.0405170758260.25502@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1084807424.20437.60.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 17 May 2004 11:23:44 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-05-17 at 11:02, Linus Torvalds wrote:
> On Mon, 17 May 2004, Larry McVoy wrote:
> > 
> > > And at some point earlier in the process you did an fflush(), or somebody
> > > else had written a header of n*PAGE_SIZE + 0x4ff bytes, or something like
> > > that. Since this was the ChangeSet file, I suspect that the "header" is 
> > > the checkin-comment section at the beginning, and the "second phase" is 
> > > the actual key list thing. You know how you write the ChangeSet file 
> > > better than I do.
> > 
> > I don't think we flush along the way but let me look.  Whoops, you're right,
> > we do.  Right where you thought too.  But that doesn't explain there being
> > 3 blocks of nulls (there should NEVER be a null in the s.ChangeSet file, we
> > don't compress that, it's always ascii).
> 
> No, no, I'm not claiming that _you_ are writing the NUL bytes. I'm
> claiming the kernel has a bug that triggers with non-page-aligned starting
> offsets of writes (because we clear the bytes after "i_size", and we don't
> synchronize those clears sufficiently), and concurrent flushes. There's
> probably some other trigger needed too (CONFIG_PREEMPT being just the
> thing that uncovers the race).
> 
> > But the bigger problem is that you are missing the point that I mentioned
> > elsewhere, we are writing to a tmp file, the tmp file is NOT mmapped.
> 
> No, the mmap thing was Andrew's theory. My theory is that regular
> "write()" calls can trigger it through the "commit_write()" function.
> 
> Of course, my theory also depended on a page unlock happening in a place
> where it didn't actually happen, so the exact details of my theory are
> crap. I'll need to re-think that part.

You've described it correctly for reiserfs though, we unlock the page
too soon.  I'll fix the page locking for reiserfs_file_write.  Steven,
we need to figure out why you're seeing this on ext3.  

The two filesystems don't share much code for the normal write path, and
I don't see how you can trigger this on ext3 without truncate jumping
into the fun.

-chris


