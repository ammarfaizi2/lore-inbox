Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261799AbSJ2Ozt>; Tue, 29 Oct 2002 09:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261847AbSJ2Ozt>; Tue, 29 Oct 2002 09:55:49 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:37389 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261799AbSJ2Ozr>; Tue, 29 Oct 2002 09:55:47 -0500
Date: Tue, 29 Oct 2002 10:01:13 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Andreas Dilger <adilger@clusterfs.com>
cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: New nanosecond stat patch for 2.5.44
In-Reply-To: <20021027214913.GA17533@clusterfs.com>
Message-ID: <Pine.LNX.3.96.1021029094310.6686C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Oct 2002, Andreas Dilger wrote:

> Two notes I might make about this:
> 1) It would be good if it were possible to select this with a config
>    option (I don't care which way the default goes), so that people who
>    don't need/care about the increased resolution don't need the extra
>    space in their inodes and minor extra overhead.  To make this a lot
>    easier to code, having something akin to the inode_update_time()
>    which does all of the i_[acm]time updates as appropriate.

Am I missing something? That would make it two file types, no? I bet
there's more overhead in handling that problem than just writing the time.

> 2) Updating i_atime based on comparing the nsec timestamp is going to be
>    a killer.  I think AKPM saw dramatic performance improvements when he
>    changed the code to only do the update once/second, and even though
>    you are "only" updating the atime if the times are different, in
>    practise this will be always.  Even without the "per superblock interval"
>    you suggest we should probably only update the atime once a second (I
>    don't think anything is keyed off such high resolution atimes, unlike
>    make and mtime/ctime).

find -anewer seems to use as much resolution as it has. More to the point,
what is the overhead of updating the time when an i/o is done? It would
seem pretty trivial.

If you are willing to give up a flag bit you could store the time in some
native unit (machine type dependent) when an i/o is done, then do the
convert to ns when it's used, such as compare, close, etc. You could have
an inode walker thread do the convert in background if that seems needed.
There are probably other ways to reduce overhead, those just came to mind.
I think it's a pretty low impact problem with some effort on making it so.

> 3) The fields you are usurping in struct stat are actually there for the
>    Y2038 problem (when time_t wraps).  At least that's what Ted said when
>    we were looking into nsec times for ext2/3.  Granted, we may all be
>    using 64-bit systems by 2038...  I've always thought 64 bits is much
>    to large for time_t, so we could always use 20 or 30 bits for sub-second
>    times, and the remaining bits for extending time_t at the high end,
>    and mask those off for now, but that is a separate issue...

As you say, but good that you brought it up!

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

