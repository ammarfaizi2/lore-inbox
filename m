Return-Path: <linux-kernel-owner+w=401wt.eu-S1755087AbWL2Xce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755087AbWL2Xce (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 18:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755089AbWL2Xcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 18:32:33 -0500
Received: from THUNK.ORG ([69.25.196.29]:58460 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755083AbWL2Xcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 18:32:32 -0500
Date: Fri, 29 Dec 2006 18:32:07 -0500
From: Theodore Tso <tytso@mit.edu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, nickpiggin@yahoo.com.au,
       kenneth.w.chen@intel.com, guichaz@yahoo.fr, hugh@veritas.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ranma@tdiedrich.de, gordonfarquharson@gmail.com, a.p.zijlstra@chello.nl,
       tbm@cyrius.com, arjan@infradead.org, andrei.popa@i-neo.ro,
       linux-ext4@vger.kernel.org
Subject: Re: Ok, explained.. (was Re: [PATCH] mm: fix page_mkclean_one)
Message-ID: <20061229233207.GA21461@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Segher Boessenkool <segher@kernel.crashing.org>,
	David Miller <davem@davemloft.net>, nickpiggin@yahoo.com.au,
	kenneth.w.chen@intel.com, guichaz@yahoo.fr, hugh@veritas.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ranma@tdiedrich.de, gordonfarquharson@gmail.com,
	a.p.zijlstra@chello.nl, tbm@cyrius.com, arjan@infradead.org,
	andrei.popa@i-neo.ro, linux-ext4@vger.kernel.org
References: <Pine.LNX.4.64.0612281125100.4473@woody.osdl.org> <20061228114517.3315aee7.akpm@osdl.org> <Pine.LNX.4.64.0612281156150.4473@woody.osdl.org> <20061228.143815.41633302.davem@davemloft.net> <3d6d8711f7b892a11801d43c5996ebdf@kernel.crashing.org> <Pine.LNX.4.64.0612282155400.4473@woody.osdl.org> <Pine.LNX.4.64.0612290017050.4473@woody.osdl.org> <Pine.LNX.4.64.0612290202350.4473@woody.osdl.org> <20061229141632.51c8c080.akpm@osdl.org> <Pine.LNX.4.64.0612291431200.4473@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612291431200.4473@woody.osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 29, 2006 at 02:42:51PM -0800, Linus Torvalds wrote:
> I think ext3 is terminally crap by now. It still uses buffer heads in 
> places where it really really shouldn't, and as a result, things like 
> directory accesses are simply slower than they should be. Sadly, I don't 
> think ext4 is going to fix any of this, either.

Not just ext3; ocfs2 is using the jbd layer as well.  I think we're
going to have to put this (a rework of jbd2 to use the page cache) on
the ext4 todo list, and work with the ocfs2 folks to try to come up
with something that suits their needs as well.  Fortunately we have
this filesystem/storage summit thing coming up in the next few months,
and we can try to get some discussion going on the linux-ext4 mailing
list in the meantime.  Unfortunately, I don't think this is going to
be trivial.

If we do get this fixed for ext4, one interesting question is whether
people would accept a patch to backport the fixes to ext3, given the
the grief this is causing the page I/O and VM routines.  OTOH, reiser3
probably has the same problems, and I suspect the changes to ext3 to
cause it to avoid buffer heads, especially in order to support for
filesystem blocksizes < pagesize, are going to be sufficiently risky
in terms of introducing regressions to ext3 that they would probably
be rejected on those grounds.  So unfortunately, we probably are going
to have to support flushes via buffer heads for the foreseeable
future.

						- Ted
