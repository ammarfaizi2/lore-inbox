Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315790AbSEDIM4>; Sat, 4 May 2002 04:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315788AbSEDIMz>; Sat, 4 May 2002 04:12:55 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:40546 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315790AbSEDIMy>; Sat, 4 May 2002 04:12:54 -0400
Date: Sat, 4 May 2002 10:13:45 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: rwhron@earthlink.net, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
Subject: Re: O(1) scheduler gives big boost to tbench 192
Message-ID: <20020504101345.N1396@dualathlon.random>
In-Reply-To: <20020503093856.A27263@rushmore> <E173jfz-0001OJ-00@w-gerrit2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2002 at 01:29:11PM -0700, Gerrit Huizenga wrote:
> In message <20020503093856.A27263@rushmore>, > : rwhron@earthlink.net writes:
> > > > > Rumor is that on some workloads MQ it outperforms O(1), but it
> > > > > may be that the latest (post K3?) O(1) is catching up?
> > 
> > Is MQ based on the Davide Libenzi scheduler? 
> > (a version of Davide's scheduler is in the -aa tree).
>  
> No - Davide's is another variant.  All three had similar goals

Davide's patch reduces the complexity of the scheduler from O(N) where N
is the number of tasks in the system, to O(N) where N is the number of
simultaneous running tasks in the system. It's also a simple
optimization and it can make responsiveness even better than the mainline
scheduler.  I know many people is using 2.4 with some thousand tasks
with only a few of them (let's say a dozen of them) running
simultaneously, so while the O(1) scheduler would be even better, the
dyn-sched patch from Davide looked the most attractive for production
usage given its simplicty. I also refined it a little while merging it
with Davide's overview.

Soon I will also get into merging the O(1) scheduler, but first I want
to inspect the interactivity and pipe bandwith effect, at least to
understand why they are getting affected (one first variable could be
the removal of the sync-wakeup, O(1) scheduler needs to get the wakeup
anyways in order to run the task but still we can teach the O(1)
scheduler that it must not try to reschedule the current task after
queueing the new one). In theory dyn-sched would be almost optimal for
well written applications with only 1 task per-cpu using async-io, but
of course in many benchmark (and in some real life environemtn) there
are an huge number of tasks running simultaneously and so dyn-sched
doesn't help much there compared to mainline.

BTW, Randy, I seen my tree runs slower with tiobench, that's probably
because I made the elevator anti-starvation logic more aggressive than
mainline and the other kernel trees (to help interactive usage), could
you try to run tiobench on -aa after elvtune -r 8192 -w 16384
/dev/hd[abcd] to verify? Thanks for the great benchmarking effort.

And for the reason fork is faster in -aa that's partly thanks to the
reschedule-child-first logic, that can be easily merged in mainline,
it's just in 2.5.

> and similar changes.  MQ was the "first" public one written by
> Mike Kravetz and Hubertus Franke with help from a number of others.
> 
> > tbench 192 is an anomaly test too.  AIM looks like a nice
> > "mixed" bench.  Do you have any scripts for it?  I'd like 
> > to use AIM too.
>  
> The SGI folks may be using more custom scripts.  I think there
> is a reasonable set of options in the released package.  OSDL
> might also be playing with it (Wookie, are you out here?).  Sequent
> used to have a large set of scripts but I don't know where those
> are at the moment.  I may check around.
> 
> > A side effect of O(1) in ac2 and jam6 on the 4 way box is a decrease 
> > in pipe bandwidth and an increase in pipe latency measured by lmbench:
> 
> Not surprised.  That seems to be one of our problems with
> volanomark testing at the moment and we have some hacks to help,
> one in TCP which allows the receiver to be scheduled on a "close"
> CPU which seems to help latency.  Others are tweaks of the
> scheduler itself, with nothing conclusively better yet.
> 
> gerrit
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


Andrea
