Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265208AbUEUXq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265208AbUEUXq1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 19:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265086AbUEUXpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 19:45:32 -0400
Received: from zeus.kernel.org ([204.152.189.113]:33973 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264562AbUEUXTy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 19:19:54 -0400
Date: Wed, 19 May 2004 15:52:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mingming Cao <cmm@us.ibm.com>
Cc: tytso@mit.edu, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: question about ext3_find_goal with reservation
Message-Id: <20040519155249.76626220.akpm@osdl.org>
In-Reply-To: <1085004276.15374.1318.camel@w-ming2.beaverton.ibm.com>
References: <E1BOQmf-0005cP-4Q@thunk.org>
	<20040513195310.5725fa43.akpm@osdl.org>
	<1085004276.15374.1318.camel@w-ming2.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mingming Cao <cmm@us.ibm.com> wrote:
>
> I just wondering, how the goal block being determined in ext3?
> 
> If we are doing sequential write, (the new logical block is next to the
> last logical block), it's easy. Just increase the last physical block
> recorded in i_next_alloc_goal and take that as the goal block for
> ext3_new_block() to try to do allocation there.
> 
> If the pattern is random write, in the current implementation(with the
> goal fix), the ext3_find_near() will find a goal with good locality.( I
> have a hard time understand the ext3_find_near(), need some help
> here...)

The comments in ext3_find_near() pretty well cover things.

The "colouring" implementation in there is to address some problems which
were exacerbated by the Orlov inode allocator.  When we're determining the
initial block for a new file the allocator was essentially doing first-fit
within the blockgroup.  So multiple files kept on having their blocks
jumbled up.

So the colouring essentially tries to start a new file at a random position
in its blockgroup.  But it ensures that if one task is creating a lot of
files (say, an untar), these are all nicely contiguous within the
blockgroup.  That's why the pid was used as the colour.  A reasonable
heuristic.  It improves the many-processes-creating-fiels problem, but
doesn't do much for the one-process-creates-lots-of-slowly-growing-files
problem.


> Well I am thinking, with the ext3 reservation changes, would it make
> sense that to find the goal in the reservation window, if we are doing
> random write on a inode, and we have a reservation window for that
> inode? In another words, when we try to find a goal for block allocation
> and the write pattern is non-sequential, if the the filesystem has
> reservation turned on, before we try to find a goal somewhere else,
> shouldn't we try to locate the goal inside the reservation window first?

I think that'll probabyl work OK.  If the application is seekily growing
the file the layout is awful already.

> This will avoid the problem that a reservation window for an inode being
> throwed away frequently when a single process open an file doing lseek
> and write frequently? (We have discussed this before.)

Yes, we definitely want to avoid that CPU-intensive search on every write.

> With reservation, we probably don't need ext3_find_near() to guide us to
> find a goal block. But we still need that in the case the filesystem is
> mounted without reservation on.

You might need it for the very first block allocation.  For example, if the
app opens an existing file and starts appending to it, does the current
code correctly commence allocation immediately beyond the file's final
block?

> If all above make sense, then the goal should be the start block of the
> reservation window.

Well.  It'll be some block within the reservation window - the code should
be recording how far across the reservation window we currently are.  We
don't want to do a linear search across the entire reservation window for
each block allocation attempt.

> So when ext3_new_block() try to satisfy the goal
> block, it will try to do allocation inside the reservation window
> directly. This makes the goal outside of reservation almost impossible
> in ext3_try_to_allocate_with_rsv(), unless it is doing sequential writes
> and the goal is just next to the end of the reservation.
> 
> Any thoughts?

It would be nice to separate the old allocation things (i_alloc_block,
i_alloc_goal, etc) from the new code completely.  Making one somehow
dependent upon or aware fo the other is confusing, and ultimately we'd like
to remove those fields from the inode altogether.

So maybe it's best to avoid calling ext3_find_near() and ext3_find_goal()
at all if reservations are enabled.
