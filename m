Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277431AbRJ3SaL>; Tue, 30 Oct 2001 13:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277435AbRJ3SaE>; Tue, 30 Oct 2001 13:30:04 -0500
Received: from yktgi01e0-s1.watson.ibm.com ([198.81.209.16]:19848 "HELO
	ssm22.watson.ibm.com") by vger.kernel.org with SMTP
	id <S277431AbRJ3S3q>; Tue, 30 Oct 2001 13:29:46 -0500
Date: Tue, 30 Oct 2001 11:29:37 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: lkml <linux-kernel@vger.kernel.org>, lse-tech@lists.sourceforge.net
Subject: Re: [PATCH][RFC] Proposal For A More Scalable Scheduler ...
Message-ID: <20011030112937.A16154@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
In-Reply-To: <20011030092834.A16050@watson.ibm.com> <Pine.LNX.4.40.0110300914450.1495-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <Pine.LNX.4.40.0110300914450.1495-100000@blue1.dev.mcafeelabs.com>; from Davide Libenzi on Tue, Oct 30, 2001 at 09:19:05AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Davide Libenzi <davidel@xmailserver.org> [20011030 12;19]:"
> On Tue, 30 Oct 2001, Hubertus Franke wrote:
> 
> > Davide, nice analysis.
> > I want to point out that some (not all) of the stuff is already done
> > in our scalable MQ scheduler (http://lse.sourceforge.net/scheduling).
> >
> > What we have:
> > -------------
> > multiple queues, each protected by their own lock to avoid
> > the contention.
> > Automatic Loadbalancing across all queues (yes, that creates overhead)
> > CPU pooling as configurable mean to get from isolated queues to a fully
> > balanced (global scheduling decision) scheduler.
> > Also have some initial placement to the least loaded runqueue in the least
> > loaded pool
> >
> > We look at this as a configurable infrastructure....
> >
> > What we don't have:
> > -------------------
> >
> > The removal of PROC_CHANGE_PENALTY with a time decay cache affinity definition.
> >
> >
> > At ALS: I will be reporting on our experience with what we have
> > for a 8-way system and a 4x4-way NUMA system (OSDL)
> > wrt early placement, choice of best pool size ?
> >
> > Are you can get an early start at:
> > 	http://lse.sourceforge.net/scheduling/als2001/pmqs.ps
> 
> I see the proposed implementation as a decisive cut with the try to have
> processes instantly moved across CPUs and stuff like na_goodness, etc..
> Inside each CPU the scheduler is _exactly_ the same as the UP one.
> 

Well, to that extent that what MQ does as too. We do a local decision 
first and then compare across multiple queues. In the pooling approach
we limit that global check to some cpus within the proximity.
I think your CPU Weight history could fit into this model as well.
We don't care how the local decision was reached.

There is however another problem that you haven't addressed yet, which
is realtime. As far as I can tell, the realtime semantics require a 
strict ordering with respect to each other and their priorities.
General approach can be either to limit all RT processes to a single CPU
or, as we have done, declare a global RT runqueue.


> 
> 
> > Are you going to be a ALS ? Maybe we can chat about what the pros and cons
> > of each approach are and whether we could/should merge things together.
> > I am very intriged by the "CPU History Weight" that I see as a major
> > add-on to our stuff. What I am not so keen about is the fact
> > you seem to only do load-balancing at fork and idle time.
> > In a loaded system that can lead to load inbalances
> >
> > We do a periodic (configurable) call, which has also some drawbacks.
> > Another thing that needs to be thought about is the metric used
> > to determine <load> on a queue. For simplicity, runqueue length is
> > one indication, for fairness, maybe the sum of nice-value would be ok.
> > We experimented with both and didn't see to much of a difference, however
> > measuring fairness is difficult to do.
> 
> Hey, ... that's part of Episode 2 " Balancing the world", where the evil
> Mr. MoveSoon fight with Hysteresis for the universe domination :)
> 
> 

Well, one has to be careful, if the system is loaded and processes are
more long lived rather then come and go, Initial Placement and Idle-Loop 
Load balancing doesn't get you very far with respect to decent load balancing.
In these kind of scenarios, one needs a feedback system. Trick is to come
up with an algorithm that is not too intrusive and that is not overcorrecting.
Take a look at the paper link, where we experimented with some of these
issues. We tolerated a difference tolerance around the runqueue length.  

> 
> 
> - Davide
> 

:-#  Hubertus

