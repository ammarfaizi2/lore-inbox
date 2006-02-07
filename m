Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030237AbWBGXLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030237AbWBGXLm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 18:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030239AbWBGXLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 18:11:42 -0500
Received: from mail01.syd.optusnet.com.au ([211.29.132.182]:29320 "EHLO
	mail01.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1030237AbWBGXLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 18:11:41 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [rfc][patch] sched: remove smpnice
Date: Wed, 8 Feb 2006 10:11:09 +1100
User-Agent: KMail/1.8.3
Cc: npiggin@suse.de, mingo@elte.hu, rostedt@goodmis.org,
       pwil3058@bigpond.net.au, suresh.b.siddha@intel.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <20060207142828.GA20930@wotan.suse.de> <200602080157.07823.kernel@kolivas.org> <20060207141525.19d2b1be.akpm@osdl.org>
In-Reply-To: <20060207141525.19d2b1be.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602081011.09749.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Feb 2006 09:15 am, Andrew Morton wrote:
> Con Kolivas <kernel@kolivas.org> wrote:
> > On Wednesday 08 February 2006 01:28, Nick Piggin wrote:
> > > I'd like to get some comments on removing smpnice for 2.6.16. I don't
> > > think the code is quite ready, which is why I asked for Peter's
> > > additions to also be merged before I acked it (although it turned out
> > > that it still isn't quite ready with his additions either).
> > >
> > > Basically I have had similar observations to Suresh in that it does not
> > > play nicely with the rest of the balancing infrastructure (and raised
> > > similar concerns in my review).
> > >
> > > The samples (group of 4) I got for "maximum recorded imbalance" on a
> > > 2x2
> > >
> > > SMP+HT Xeon are as follows:
> > >            | Following boot | hackbench 20        | hackbench 40
> > >
> > > -----------+----------------+---------------------+--------------------
> > >- 2.6.16-rc2 | 30,37,100,112  | 5600,5530,6020,6090 |
> > > 6390,7090,8760,8470 +nosmpnice |  3, 2,  4,  2  |   28, 150, 294, 132 |
> > >  348, 348, 294, 347
> > >
> > > Hackbench raw performance is down around 15% with smpnice (but that in
> > > itself isn't a huge deal because it is just a benchmark). However, the
> > > samples show that the imbalance passed into move_tasks is increased by
> > > about a factor of 10-30. I think this would also go some way to
> > > explaining latency blips turning up in the balancing code (though I
> > > haven't actually measured that).
> > >
> > > We'll probably have to revert this in the SUSE kernel.
> > >
> > > The other option for 2.6.16 would be to fast track Peter's stuff, which
> > > I could put some time into... but that seems a bit risky at this stage
> > > of the game.
> > >
> > > I'd like to hear any other suggestions though. Patch included to aid
> > > discussion at this stage, rather than to encourage any rash decisions.
> >
> > I see the demonstrable imbalance but I was wondering if there is there a
> > real world benchmark that is currently affected?
>
> Well was any real-world workload (or benchmark) improved by the smpnice
> change?

No benchmark improved but 'nice' handling moved from completely not working on 
SMP to having quite effective cpu resource modification according to nice. 
nice 19 vs nice 0 has 5% of the cpu on UP. On SMP machines without smp nice 
if you have more tasks than cpus (the 5 tasks on 4 cpu example) you often get 
nice 19 tasks getting more cpu resources than nice 0 tasks; a nice 19 task 
would get 100% of one cpu and two nice 0 tasks would get 50% of a cpu. With 
smp nice the nice 19 task received between 5-30% of one cpu depending on 
their sleep/wake pattern.

> Because if we have one workload which slowed and and none which sped up,
> it's a pretty easy decision..

The resource allocation fairness was improved with smp nice but no benchmark 
directly sped up per se.

Cheers,
Con
