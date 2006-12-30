Return-Path: <linux-kernel-owner+w=401wt.eu-S1030198AbWL3BR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030198AbWL3BR6 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 20:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030199AbWL3BR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 20:17:58 -0500
Received: from smtp.osdl.org ([65.172.181.25]:38172 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030198AbWL3BR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 20:17:57 -0500
Date: Fri, 29 Dec 2006 17:16:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Segher Boessenkool <segher@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, nickpiggin@yahoo.com.au,
       kenneth.w.chen@intel.com, guichaz@yahoo.fr, hugh@veritas.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ranma@tdiedrich.de, gordonfarquharson@gmail.com, a.p.zijlstra@chello.nl,
       tbm@cyrius.com, arjan@infradead.org, andrei.popa@i-neo.ro
Subject: Re: Ok, explained.. (was Re: [PATCH] mm: fix page_mkclean_one)
Message-Id: <20061229171654.e6e1b1c7.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612291651350.4473@woody.osdl.org>
References: <Pine.LNX.4.64.0612281125100.4473@woody.osdl.org>
	<20061228114517.3315aee7.akpm@osdl.org>
	<Pine.LNX.4.64.0612281156150.4473@woody.osdl.org>
	<20061228.143815.41633302.davem@davemloft.net>
	<3d6d8711f7b892a11801d43c5996ebdf@kernel.crashing.org>
	<Pine.LNX.4.64.0612282155400.4473@woody.osdl.org>
	<Pine.LNX.4.64.0612290017050.4473@woody.osdl.org>
	<Pine.LNX.4.64.0612290202350.4473@woody.osdl.org>
	<20061229141632.51c8c080.akpm@osdl.org>
	<Pine.LNX.4.64.0612291431200.4473@woody.osdl.org>
	<20061229155118.3feb0c17.akpm@osdl.org>
	<Pine.LNX.4.64.0612291559540.4473@woody.osdl.org>
	<20061229163316.020fcda1.akpm@osdl.org>
	<Pine.LNX.4.64.0612291651350.4473@woody.osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Dec 2006 16:58:41 -0800 (PST)
Linus Torvalds <torvalds@osdl.org> wrote:

> 
> 
> On Fri, 29 Dec 2006, Andrew Morton wrote:
> >
> > > > Somewhat nastily, but as ext3 directories are metadata it is appropriate
> > > > that modifications to them be done in terms of buffer_heads (ie: blocks).
> > > 
> > > No. There is nothing "appropriate" about using buffer_heads for metadata. 
> > 
> > I said "modification".
> 
> You said "metadata".
> 
> Why do you think directories are any different from files? Yes, they are 
> metadata. So what? What does that have to do with anything?

We journal the contents of directories.  Fully.  So we handle their dirty
data at the block (ie: buffer_head) level.  When someone tries to dirty
part of a directory we need to cheat and not mark that part of the page as
dirty and we need to then write the block to the journal and then mark the
block as really dirty for checkpointing (but still attached to the journal)
and all that goop.

The regular page-based writeback doesn't apply until the block has been
written to the journal.  At that stage the block is considered dirty
against its real position on disk.  It will then be written back by pdflush
via the blockdev inode -> blkdev_writepage().  Unless kjournald needs to do
an early flush to reclaim the journal space, in which case kjournald will
write the block itself.

> 
> So I really don't understand why you make excuses for ext3 and talk about 
> "modifications" and "metadata". It was a fine design ten years ago. It's 
> not really very good any longer.
> 

As I said in another apparently-neglected email:

: We could possibly move ext3/4 directories out of the blockdev pagecache and
: into per-directory pagecache, but that wouldn't change anything - the
: journalling would still be block-based.

We already have all the code in place to journal blocks which are cached in
an address_space other than the blockdev inode's: ext3_journalled_aops.
