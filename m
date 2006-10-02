Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWJBIOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWJBIOt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 04:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWJBIOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 04:14:49 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:42082 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S1750794AbWJBIOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 04:14:48 -0400
Subject: Re: [RFC][PATCH 0/2] Swap token re-tuned
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: ashwin.chaugule@celunite.com, linux-kernel@vger.kernel.org,
       Rik van Riel <riel@redhat.com>
In-Reply-To: <20061002005905.a97a7b90.akpm@osdl.org>
References: <1159555312.2141.13.camel@localhost.localdomain>
	 <20061001155608.0a464d4c.akpm@osdl.org> <1159774552.13651.80.camel@lappy>
	 <20061002005905.a97a7b90.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 02 Oct 2006 10:14:33 +0200
Message-Id: <1159776873.13651.89.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-02 at 00:59 -0700, Andrew Morton wrote:
> On Mon, 02 Oct 2006 09:35:52 +0200
> Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> 
> > On Sun, 2006-10-01 at 15:56 -0700, Andrew Morton wrote:
> > > On Sat, 30 Sep 2006 00:11:51 +0530
> > > Ashwin Chaugule <ashwin.chaugule@celunite.com> wrote:
> > 
> > > > PATCH 2: 
> > > > 
> > > > Instead of using TIMEOUT as a parameter to transfer the token, I think a
> > > > better solution is to hand it over to a process that proves its
> > > > eligibilty. 
> > > > 
> > > > What my scheme does, is to find out how frequently a process is calling
> > > > these functions. The processes that call these more frequently get a
> > > > higher priority. 
> > > > The idea is to guarantee that a high priority process gets the token.
> > > > The priority of a process is determined by the number of consecutive
> > > > calls to swap-in and no-page. I mean "consecutive" not from the
> > > > scheduler point of view, but from the process point of view. In other
> > > > words, if the task called these functions every time it was scheduled,
> > > > it means it is not getting any further with its execution. 
> > > > 
> > > > This way, its a matter of simple comparison of task priorities, to
> > > > decide whether to transfer the token or not. 
> > > 
> > > Does this introduce the possibility of starvation?  Where the
> > > fast-allocating process hogs the system and everything else makes no
> > > progress?
> > 
> > I tinkered with this a bit yesterday, and didn't get good results for:
> > mem=64M ; make -j5
> > 
> > -vanilla: 2h32:55

        Command being timed: "make -j5"
        User time (seconds): 2726.81
        System time (seconds): 2266.85
        Percent of CPU this job got: 54%
        Elapsed (wall clock) time (h:mm:ss or m:ss): 2:32:55
        Average shared text size (kbytes): 0
        Average unshared data size (kbytes): 0
        Average stack size (kbytes): 0
        Average total size (kbytes): 0
        Maximum resident set size (kbytes): 0
        Average resident set size (kbytes): 0
        Major (requiring I/O) page faults: 269956
        Minor (reclaiming a frame) page faults: 8699298
        Voluntary context switches: 414020
        Involuntary context switches: 242365
        Swaps: 0
        File system inputs: 0
        File system outputs: 0
        Socket messages sent: 0
        Socket messages received: 0
        Signals delivered: 0
        Page size (bytes): 4096
        Exit status: 0

> > -swap-token: 2h41:48

        Command being timed: "make -j5"
        User time (seconds): 2720.54
        System time (seconds): 2428.60
        Percent of CPU this job got: 53%
        Elapsed (wall clock) time (h:mm:ss or m:ss): 2:41:48
        Average shared text size (kbytes): 0
        Average unshared data size (kbytes): 0
        Average stack size (kbytes): 0
        Average total size (kbytes): 0
        Maximum resident set size (kbytes): 0
        Average resident set size (kbytes): 0
        Major (requiring I/O) page faults: 281943
        Minor (reclaiming a frame) page faults: 8692417
        Voluntary context switches: 421770
        Involuntary context switches: 241323
        Swaps: 0
        File system inputs: 0
        File system outputs: 0
        Socket messages sent: 0
        Socket messages received: 0
        Signals delivered: 0
        Page size (bytes): 4096
        Exit status: 0

> > various other attempts at tweaking the code only made it worse. (will
> > have to rerun these test, but a ~3h test is well, a 3h test ;-)
> 
> I don't think that's a region of operation where we care a great deal. 
> What was the average CPU utlisation?  Only a few percent.

~50%, its a slow box this, a p3-550.

> It's just thrashing too much to bother optimising for.  Obviously we want
> it to terminate in a sane period of time and we'd _like_ to improve it. 
> But I think we'd accept a 10% slowdown in this region of operation if it
> gave us a 10% speedup in the 25%-utilisation region.
> 
> IOW: does the patch help mem=96M;make -j5??

Will kick off some test later today.

> > Being frustrated with these results - I mean the idea made sense, so
> > what is going on - I came up with this answer:
> > 
> > Tasks owning the swap token will retain their pages and will hence swap
> > less, other (contending) tasks will get less pages and will fault more
> > frequent. This prio mechanism will favour exactly those tasks not
> > holding the token. Which makes for token bouncing.
> 
> OK.
> 
> (We need to do something with
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18/2.6.18-mm2/broken-out/mm-thrash-detect-process-thrashing-against-itself.patch,
> btw.  Has been in -mm since March and I'm still waiting for some benchmarks
> which would justify its inclusion..)

Hmm, benchmarks, I need VM benchmarks for my page replacment work
too ;-)

Perhaps I can create a multi-threaded progamm that knows a few patterns.

> > The current mechanism seemingly assigns the token randomly (whomever
> > asks while not held gets it - and the hold time is fixed), however this
> > change in paging behaviour (holder less, contenders more) shifts the
> > odds in favour of one of the contenders. Also the fixed holding time
> > will make sure the token doesn't get released too soon and can make some
> > progress.
> > 
> > So while I agree it would be nice to get rid of all magic variables
> > (holding time in the current impl) this proposed solution hasn't
> > convinced me (for one it introduces another).
> > 
> > (for the interrested, the various attempts I tried are available here:
> >   http://programming.kicks-ass.net/kernel-patches/swap_token/ )
> 
> OK, thanks or looking into it.  I do think this is rich ground for
> optimisation.

Given the amazing reduction in speed I accomplished yesterday (worst was
3h09:02), I'd say we're not doing bad, but yeah, I too think there is
room for improvement.

