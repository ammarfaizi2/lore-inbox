Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132506AbRA2Po4>; Mon, 29 Jan 2001 10:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132549AbRA2Pop>; Mon, 29 Jan 2001 10:44:45 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:18953 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S132506AbRA2Poc>;
	Mon, 29 Jan 2001 10:44:32 -0500
Date: Mon, 29 Jan 2001 08:44:10 -0700
From: yodaiken@fsmlabs.com
To: Joe deBlaquiere <jadb@redhat.com>
Cc: Andrew Morton <andrewm@uow.edu.au>, yodaiken@fsmlabs.com,
        Nigel Gamble <nigel@nrg.org>, linux-kernel@vger.kernel.org,
        linux-audio-dev@ginette.musique.umontreal.ca
Subject: Re: [linux-audio-dev] low-latency scheduling patch for 2.4.0
Message-ID: <20010129084410.B32652@hq.fsmlabs.com>
In-Reply-To: <200101220150.UAA29623@renoir.op.net> <Pine.LNX.4.05.10101211754550.741-100000@cosmic.nrg.org>, <Pine.LNX.4.05.10101211754550.741-100000@cosmic.nrg.org>; <20010128061428.A21416@hq.fsmlabs.com> <3A742A79.6AF39EEE@uow.edu.au> <3A74462A.80804@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <3A74462A.80804@redhat.com>; from Joe deBlaquiere on Sun, Jan 28, 2001 at 10:17:46AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 28, 2001 at 10:17:46AM -0600, Joe deBlaquiere wrote:
> A recent example I came across is in the MTD code which invokes the 
> erase algorithm for CFI memory. This algorithm spews a command sequence 
> to the flash chips followed by a list of sectors to erase. Following 
> each sector adress, the chip will wait for 50usec for another address, 
> after which timeout it begins the erase cycle. With a RTLinux-style 
> approach the driver is eventually going to fail to issue the command in 
> time. There isn't any logic to detect and correct the preemption case, 
> so it just gets confused and thinks the erase failed. Ergo, RTLinux and 
> MTD are mutually exclusive. (I should probably note that I do not intend 
> this as an indictment of RTLinux or MTD, but just an example of why 
> preemption breaks the Linux driver model).

Only if your RTLinux application is running. In other words, you cannot
commit more than 100% of cpu cycle time and expect to deliver.
I think one of the common difficulties with realtime is that time-shared
systems with virtual memory make people used to elastic resource
limits and real-time has unforgiving time limits.



> 
> So what is the solution in the preemption case? Should we re-write every 
> driver to handle the preemption? Do we need a cli_yes_i_mean_it() for 
> the cases where disabling interrupts is _absolutely_ required? Do we 
> push drivers like MTD down into preemptable-Linux? Do we push all 
> drivers down?
> In the meantime, fixing the few places where the kernel spends an 
> extended period of time performing a task makes sense to me. If you're 
> going to be busy for a while it is 'courteous' to allow the scheduler a 
> chance to give some time to other threads. Of course it's hard to know 
> when to draw the line.

Or what is the tradeoff or whether  a deadlock will follow. 
step 1: memory manager thread frees a few pages and is courteous
step 2: bunch of thrashing and eventually all processes stall
step 3: go to step 1

alternative
step 1: memory manager thread frees enough pages for some processes to
        advance to termination
step 2: all is well

and make up 100 similar scenarios. And this is why "preemptive"
OS's tend to add such abominations as "priority inheritance" which 
make failure cases rarer and harder to diagnose or complex schedulers
that spend a significant fraction of cpu time trying to figure out
what process should advance or ...


> 
> So now I am starting to wonder about what needs to be profiled. Is there 
> a mechanism in place now to measure the time spent with interrupts off, 
> for instance? I know this has to have been quantified to some extent, right?
> 
> -- 
> Joe deBlaquiere
> Red Hat, Inc.
> 307 Wynn Drive
> Huntsville AL, 35805
> voice : (256)-704-9200
> fax   : (256)-837-3839

-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
