Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263736AbUDNQX3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 12:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264265AbUDNQX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 12:23:29 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:51654 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263736AbUDNQX0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 12:23:26 -0400
Content-Type: text/plain; charset=US-ASCII
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, Mingming Cao <cmm@us.ibm.com>
Subject: Re: [PATCH 0/4] ext3 block reservation patch set
Date: Wed, 14 Apr 2004 09:11:57 -0700
User-Agent: KMail/1.4.1
Cc: tytso@mit.edu, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
References: <200403190846.56955.pbadari@us.ibm.com> <1081903949.3548.6837.camel@localhost.localdomain> <20040413194734.3a08c80f.akpm@osdl.org>
In-Reply-To: <20040413194734.3a08c80f.akpm@osdl.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200404140911.57772.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 April 2004 07:47 pm, Andrew Morton wrote:
> Mingming Cao <cmm@us.ibm.com> wrote:
> > Here is a set of patches which implement the in-memory ext3 block
> >  reservation (previously called reservation based ext3 preallocation).
>
> Great, thanks.  Let's get these in the pipeline.
>
> A few thoughts, from a five-minute read:
>
>
> - The majority of in-core inodes are not open for reading, and we've
>   added 24 bytes to the inode just for inodes which are open for writing.
>
>   At some stage we should stop aggregating struct reserve_window into the
>   inode and dynamically allocate it.  We can move i_next_alloc_block,
>   i_next_alloc_goal and possibly other fields in there too.
>
>   At which point it has the wrong name ;) Should be `write_state' or
>   something.
>
>   It's not clear when we should free up the write_state.  I guess we
>   could leave it around for the remaining lifetime of the inode - that'd
>   still be a net win.
>
>   Is this something you can look at as a low-priority activity?

Good point !! we will surely look at it.
>
> - You're performing ext3_discard_reservation() in ext3_release_file().
>   Note that the file may still have pending allocations at this stage: say,
>   open a file, map it MAP_SHARED, dirty some pages which lie over file
>   holes then close the file again.
..
> - Why do we discard the file's reservation on every iput()?  iput's are
>   relatively common operations. (see fs/fs-writeback.c)

We just followed old prealloc code. Where ever preallocation is dropped
we dropped reservation.  May be thats overkill. We will look at it.

Whats the best place to drop the reservation ?

> - Have you tested and profiled this with a huge number of open files?  At
>   what stage do we get into search complexity problems?

In our TODO list. But our original thought was, we have to search only the
current block group reservations to get a window. So, if we have lots & lots
of reservations in a single block group - search gets complicated. We were
thinking of adding (dummy) anchors in the list to represent begining of each
block group, so that we can get to the start of a block group quickly. But
so far, we haven't done anything.

We are also looking at RB tree and see how we can make use of it. Our problem
is,  we are interested in finding out a big enough hole in the tree to put our
reservation. We need to look closely.


> - What locking protects rsv_alloc_hit?  i_sem is not held during
>   VM-initiated writeout.  Maybe an atomic_t there, or just say that if we
>   race and the number is a bit inaccurate, we don't care?

We need to atleast change it to atomic_t. 

Mingming, I don't see any check to force maximum. Am I missing something ?

We really appreciate your comments.

Thanks,
Badari



