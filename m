Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130389AbQKBHTd>; Thu, 2 Nov 2000 02:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130704AbQKBHTW>; Thu, 2 Nov 2000 02:19:22 -0500
Received: from www.wen-online.de ([212.223.88.39]:36615 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S130389AbQKBHTM>;
	Thu, 2 Nov 2000 02:19:12 -0500
Date: Thu, 2 Nov 2000 08:19:06 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Rik van Riel <riel@conectiva.com.br>
cc: David Mansfield <lkml@dm.ultramaster.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] /proc/<pid>/stat access stalls badly for swapping process,
  2.4.0-test10
In-Reply-To: <Pine.LNX.4.21.0011011643050.6740-100000@duckman.distro.conectiva>
Message-ID: <Pine.Linu.4.10.10011020800010.1299-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2000, Rik van Riel wrote:

> On Wed, 1 Nov 2000, David Mansfield wrote:
> 
> > I'd like to report what seems like a performance problem in the latest
> > kernels.  Actually, all recent kernels have exhibited this problem, but
> > I was waiting for the new VM stuff to stabilize before reporting it. 
> > 
> > My test is: run 7 processes that each allocate and randomly
> > access 32mb of ram (on a 256mb machine).  Even though 7*32MB =
> > 224MB, this still sends the machine lightly into swap.  The
> > machine continues to function fairly smoothly for the most part.  
> > I can do filesystem operations, run new programs, move desktops
> > in X etc.
> > 
> > Except: programs which access /proc/<pid>/stat stall for an
> > inderminate amount of time.  For example, 'ps' and 'vmstat'
> > stall BADLY in these scenarios.  I have had the stalls last over
> > a minute in higher VM pressure situations.
> 
> I have one possible reason for this ....
> 
> 1) the procfs process does (in fs/proc/array.c::proc_pid_stat)
> 	down(&mm->mmap_sem);
> 
> 2) but, in order to do that, it has to wait until the process
>    it is trying to stat has /finished/ its page fault, and is
>    not into its next one ...
> 
> 3) combine this with the elevator starvation stuff (ask Jens
>    Axboe for blk-7 to alleviate this issue) and you have a
>    scenario where processes using /proc/<pid>/stat have the
>    possibility to block on multiple processes that are in the
>    process of handling a page fault (but are being starved)

I'm experimenting with blk.[67] in test10 right now.  The stalls
are not helped at all.  It doesn't seem to become request bound
(haven't instrumented that yet to be sure) but the stalls persist.

	-Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
