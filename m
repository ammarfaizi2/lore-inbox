Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129676AbQKBWAV>; Thu, 2 Nov 2000 17:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129780AbQKBWAO>; Thu, 2 Nov 2000 17:00:14 -0500
Received: from valbert.esscom.com ([199.89.135.168]:62468 "EHLO esscom.com")
	by vger.kernel.org with ESMTP id <S129676AbQKBV74>;
	Thu, 2 Nov 2000 16:59:56 -0500
Date: Thu, 2 Nov 2000 14:59:12 -0700
From: Val Henson <vhenson@esscom.com>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] /proc/<pid>/stat access stalls badly for swapping process, 2.4.0-test10
Message-ID: <20001102145912.B8472@esscom.com>
In-Reply-To: <Pine.LNX.4.21.0011011643050.6740-100000@duckman.distro.conectiva> <Pine.Linu.4.10.10011020800010.1299-100000@mikeg.weiden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.1.11i
In-Reply-To: <Pine.Linu.4.10.10011020800010.1299-100000@mikeg.weiden.de>; from mikeg@wen-online.de on Thu, Nov 02, 2000 at 08:19:06AM +0100
Favorite-Color: Polka dot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2000 at 08:19:06AM +0100, Mike Galbraith wrote:
> On Wed, 1 Nov 2000, Rik van Riel wrote:
> 
> > I have one possible reason for this ....
> > 
> > 1) the procfs process does (in fs/proc/array.c::proc_pid_stat)
> > 	down(&mm->mmap_sem);
> > 
> > 2) but, in order to do that, it has to wait until the process
> >    it is trying to stat has /finished/ its page fault, and is
> >    not into its next one ...
> > 
> > 3) combine this with the elevator starvation stuff (ask Jens
> >    Axboe for blk-7 to alleviate this issue) and you have a
> >    scenario where processes using /proc/<pid>/stat have the
> >    possibility to block on multiple processes that are in the
> >    process of handling a page fault (but are being starved)
> 
> I'm experimenting with blk.[67] in test10 right now.  The stalls
> are not helped at all.  It doesn't seem to become request bound
> (haven't instrumented that yet to be sure) but the stalls persist.
> 
> 	-Mike

This is not an elevator starvation problem.

I also experienced these stalls with my IDE-only system.  Unless I'm
badly mistaken, the elevator is only used on SCSI disks, therefore
elevator starvation cannot be blamed for this problem.  These stalls
are particularly annoying since I want to find the pid of the process
hogging memory in order to kill it, but the read from /proc stalls for
45 seconds or more.

-VAL
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
