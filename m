Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135958AbRASRGj>; Fri, 19 Jan 2001 12:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135501AbRASRGa>; Fri, 19 Jan 2001 12:06:30 -0500
Received: from monza.monza.org ([209.102.105.34]:16906 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S135958AbRASRGU>;
	Fri, 19 Jan 2001 12:06:20 -0500
Date: Fri, 19 Jan 2001 09:06:03 -0800
From: Tim Wright <timw@splhi.com>
To: nick@snowman.net
Cc: Hubertus Franke <frankeh@us.ibm.com>, David Lang <dlang@diginsite.com>,
        Mike Kravetz <mkravetz@sequent.com>, Andrea Arcangeli <andrea@suse.de>,
        lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: multi-queue scheduler update
Message-ID: <20010119090603.A1347@scutter.internal.splhi.com>
Reply-To: timw@splhi.com
Mail-Followup-To: nick@snowman.net, Hubertus Franke <frankeh@us.ibm.com>,
	David Lang <dlang@diginsite.com>,
	Mike Kravetz <mkravetz@sequent.com>,
	Andrea Arcangeli <andrea@suse.de>, lse-tech@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
In-Reply-To: <OFCCD29238.A3FCD613-ON852569D9.0059F149@pok.ibm.com> <Pine.LNX.4.21.0101191132390.646-100000@ns>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0101191132390.646-100000@ns>; from nick@snowman.net on Fri, Jan 19, 2001 at 11:33:34AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,
you can't run with <512K L2 for >2-way on Intel. The 256K L2 cache cumine
procs only support 2-way SMP. For 4-way and greater, you have to use Xeon
procs, and they come in three flavours - 512K, 1M, and 2M. The machine that
Mike is using has 1M parts (which are fairly common at the 4/8-way level).
Hubertus has the 2M parts which are more expensive. By the time you have 8
procs, the 2M part can give a substantial performance boost on some workloads.

Tim

On Fri, Jan 19, 2001 at 11:33:34AM -0500, nick@snowman.net wrote:
> You might want to rerun the tests with less cache heavy procs.  The 2meg
> xeons you are using could distort things from what the average linux user
> would see (running with 256-512k cache).
> 	Nick
> 
> On Fri, 19 Jan 2001, Hubertus Franke wrote:
> 
> > 
> > Sure, we are measuring that as well.
> > We are running all these benchmarks and configurations that I mentioned in
> > my previous message on
> > 1-2-4-6- and 8 way configurations.
> > We have posted some preliminary results on older kernels on the website:
> > 
> > http://lse.sourceforge.net/scheduling/prelim.html
> > 
> > MQ scheduler is meaningless for a UP kernel that is only build under the
> > SMP flag.
> > The priority==tablebased scheduler does make sense to run on a UP (i.e. not
> > SMP compiled) kernel.
> > Some more fine-tuning of the current code base might improve that case,
> > because affinity is not a concern
> > I can simply go to my top table hash, retrieve the first P entry with
> > !P->has_cpu and I am ready to go.
> > 
> > Hubertus Franke
> > Enterprise Linux Group (Mgr),  Linux Technology Center (Member Scalability)
> > , OS-PIC (Chair)
> > email: frankeh@us.ibm.com
> > (w) 914-945-2003    (fax) 914-945-4425   TL: 862-2003
> > 
> > 
> > 
> > David Lang <dlang@diginsite.com>@lists.sourceforge.net on 01/19/2001
> > 11:06:37 AM
> > 
> > Sent by:  lse-tech-admin@lists.sourceforge.net
> > 
> > 
> > To:   Mike Kravetz <mkravetz@sequent.com>
> > cc:   Andrea Arcangeli <andrea@suse.de>, <lse-tech@lists.sourceforge.net>,
> >       <linux-kernel@vger.kernel.org>
> > Subject:  Re: [Lse-tech] Re: multi-queue scheduler update
> > 
> > 
> > 
> > another thing that would be interesting is what is the overhead on UP or
> > small (2-4 way) SMP machines
> > 
> > David Lang
> > 
> > On Thu, 18 Jan 2001, Mike Kravetz wrote:
> > 
> > > Date: Thu, 18 Jan 2001 16:52:25 -0800
> > > From: Mike Kravetz <mkravetz@sequent.com>
> > > To: Andrea Arcangeli <andrea@suse.de>
> > > Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
> > > Subject: Re: [Lse-tech] Re: multi-queue scheduler update
> > >
> > > On Fri, Jan 19, 2001 at 01:26:16AM +0100, Andrea Arcangeli wrote:
> > > > On Thu, Jan 18, 2001 at 03:53:11PM -0800, Mike Kravetz wrote:
> > > > > Here are some very preliminary numbers from sched_test_yield
> > > > > (which was previously posted to this (lse-tech) list by Bill
> > > > > Hartner).  Tests were run on a system with 8 700 MHz Pentium
> > > > > III processors.
> > > > >
> > > > >                            microseconds/yield
> > > > > # threads      2.2.16-22           2.4        2.4-multi-queue
> > > > > ------------   ---------         --------     ---------------
> > > > > 16               18.740            4.603         1.455
> > > >
> > > > I remeber the O(1) scheduler from Davide Libenzi was beating the
> > mainline O(N)
> > > > scheduler with over 7 tasks in the runqueue (actually I'm not sure if
> > the
> > > > number was 7 but certainly it was under 10). So if you also use a O(1)
> > > > scheduler too as I guess (since you have a chance to run fast on the
> > lots of
> > > > tasks running case) the most interesting thing is how you score with
> > 2/4/8
> > > > tasks in the runqueue (I think the tests on the O(1) scheduler patch
> > was done
> > > > at max on a 2-way SMP btw). (the argument for which Davide's patch
> > wasn't
> > > > included is that most machines have less than 4/5 tasks in the runqueue
> > at the
> > > > same time)
> > > >
> > > > Andrea
> > >
> > > Thanks for the suggestion.  The only reason I hesitated to test with
> > > a small number of threads is because I was under the assumption that
> > > this particular benchmark may have problems if the number of threads
> > > was less than the number of processors.  I'll give the tests a try
> > > with a smaller number of threads.  I'm also open to suggestions for
> > > what benchmarks/test methods I could use for scheduler testing.  If
> > > you remember what people have used in the past, please let me know.
> > >
> > > --
> > > Mike Kravetz                                 mkravetz@sequent.com
> > > IBM Linux Technology Center
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > in
> > > the body of a message to majordomo@vger.kernel.org
> > > Please read the FAQ at http://www.tux.org/lkml/
> > >
> > 
> > _______________________________________________
> > Lse-tech mailing list
> > Lse-tech@lists.sourceforge.net
> > http://lists.sourceforge.net/lists/listinfo/lse-tech
> > 
> > 
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > Please read the FAQ at http://www.tux.org/lkml/
> > 
> 
> 
> _______________________________________________
> Lse-tech mailing list
> Lse-tech@lists.sourceforge.net
> http://lists.sourceforge.net/lists/listinfo/lse-tech

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
Interested in Linux scalability ? Look at http://lse.sourceforge.net/
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
