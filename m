Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932492AbWAKWsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbWAKWsZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 17:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932490AbWAKWsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 17:48:25 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:65467 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932488AbWAKWsX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 17:48:23 -0500
Subject: Re: [Lse-tech] Re: [ckrm-tech] Re: [PATCH 00/01] Move Exit
	Connectors
From: Matt Helsley <matthltc@us.ibm.com>
To: John Hesterberg <jh@sgi.com>
Cc: Jes Sorensen <jes@trained-monkey.org>,
       Shailabh Nagar <nagar@watson.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Jay Lan <jlan@engr.sgi.com>, LKML <linux-kernel@vger.kernel.org>,
       elsa-devel@lists.sourceforge.net, lse-tech@lists.sourceforge.net,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, Paul Jackson <pj@sgi.com>,
       Erik Jacobson <erikj@sgi.com>, Jack Steiner <steiner@sgi.com>
In-Reply-To: <20060111213910.GA17986@sgi.com>
References: <1136414431.22868.115.camel@stark>
	 <20060104151730.77df5bf6.akpm@osdl.org> <1136486566.22868.127.camel@stark>
	 <1136488842.22868.142.camel@stark> <20060105151016.732612fd.akpm@osdl.org>
	 <1136505973.22868.192.camel@stark> <yq08xttybrx.fsf@jaguar.mkp.net>
	 <43BE9E91.9060302@watson.ibm.com> <yq0wth72gr6.fsf@jaguar.mkp.net>
	 <1137013330.6673.80.camel@stark>  <20060111213910.GA17986@sgi.com>
Content-Type: text/plain
Date: Wed, 11 Jan 2006 14:42:47 -0800
Message-Id: <1137019367.6673.97.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-11 at 15:39 -0600, John Hesterberg wrote:
> On Wed, Jan 11, 2006 at 01:02:10PM -0800, Matt Helsley wrote:
> > On Wed, 2006-01-11 at 05:36 -0500, Jes Sorensen wrote:
> > > >>>>> "Shailabh" == Shailabh Nagar <nagar@watson.ibm.com> writes:
> > > 
> > > Shailabh> Jes Sorensen wrote:
> > > >> I am quite concerned about that lock your patches put into struct
> > > >> task_struct through struct task_delay_info. Have you done any
> > > >> measurements on how this impacts performance on highly threaded
> > > >> apps on larger system?
> > > 
> > > Shailabh> I don't expect the lock contention to be high. The lock is
> > > Shailabh> held for a very short time (across two
> > > Shailabh> additions/increments). Moreover, it gets contended only when
> > > Shailabh> the stats are being read (either through /proc or
> > > Shailabh> connectors).  Since the reading of stats won't be that
> > > Shailabh> frequent (the utility of these numbers is to influence the
> > > Shailabh> I/O priority/rss limit etc. which won't be done at a very
> > > Shailabh> small granularity anyway), I wouldn't expect a problem.
> > > 
> > > Hi Shailabh,
> > > 
> > > When this is read through connectors, it's initiated by the connectors
> > > code which is called from the task's context hence we don't need
> > > locking for that. It's very similar to the task_notify code I am about
> > > to post and I think the connector code could fit into that
> > > framework. The main issue is /proc, but then one could even have a
> > > mechanism with a hook when the task exits that pushes the data to a
> > > storage point which is lock protected.
> > > 
> > > Even if a lock isn't contended, you are still going to see the cache
> > > lines bounce around due to the writes. It may not show up on a 4-way
> > > box but what happens on a 64-way? We have seen some pretty nasty
> > > effects on the bigger SN2 boxes with locks that were taken far too
> > > frequently, to the point where it would prevent the box from booting
> > > (now I don't expect it to that severe here, but I'd still like to
> > > explore an approach of doing it lock free).
> > > 
> > > Shailabh> But its better to take some measurements anyway. Any
> > > Shailabh> suggestions on a benchmark ?
> > > 
> > > >> IMHO it seems to make more sense to use something like Jack's
> > > >> proposed task_notifier code to lock-less collect the data into task
> > > >> local data structures and then take the data from there and ship
> > > >> off to userland through netlink or similar like you are doing?
> > > >> 
> > > >> I am working on modifying Jack's patch to carry task local data and
> > > >> use it for not just accounting but other areas that need optional
> > > >> callbacks (optional in the sense that it's a feature that can be
> > > >> enabled or disabled). Looking at Shailabh's delayacct_blkio()
> > > >> changes it seems that it would be really easy to fit those into
> > > >> that framework.
> > > >> 
> > > >> Guess I should post some of this code .....
> > > 
> > > Shailabh> Please do. If this accounting can fit into some other
> > > Shailabh> framework, thats fine too.
> > > 
> > > Ok, finally, sorry for the delay. My current code snapshot is
> > > available at http://www.trained-monkey.org/~jes/patches/task_notify/ -
> > > it's a modified version of Jack's task_notify code, and three example
> > > users of it (the SysV IPC semundo semaphore, the key infrastructure
> > > and SGI's JOB module). The patch order should be task_notify.diff,
> > > task-notify-keys.diff, task-notify-semundo.diff, and
> > > task_notify-job.diff last.
> > 
> > 	I can already tell you I don't like the "magic" mechanism to identify
> > notifier blocks. The problem is that it's yet another space of id
> > numbers that we have to manage -- either manually, by having a person
> > hand the numbers out to developers, or automatically using the idr code.
> > You could use the notifier block's address and avoid an additional id
> > space.
> > 
> > 	Also, even if this mechanism goes into task_notify it needs a better
> > name than "magic".
> > 
> > > I think task_notify it should be usable for statistics gathering as
> > > well, the only issue is how to attach it to the processes we wish to
> > > gather accounting for. Personally I am not a big fan of the current
> > > concept where statistics are gathered for all tasks at all time but
> > > just not exported until accounting is enabled.
> > 
> > 	Have you looked at Alan Stern's notifier chain fix patch? Could that be
> > used in task_notify?
> > 
> > 	If not, perhaps the patch use the standard kernel list idioms.
> > 
> > 	Another potential user for the task_notify functionality is the process
> > events connector. The problem is it requires the ability to receive
> > notifications about all processes. Also, there's a chance that future
> > CKRM code could use all-task and per-task notification. Combined with
> > John Hesterberg's feedback I think there is strong justification for an
> > all-tasks notification interface.
> 
> I have two concerns about an all-tasks notification interface.
> First, we want this to scale, so don't want more global locks.
> One unique part of the task notify is that it doesn't use locks.

	Are you against global locks in these paths based solely on principle
or have you measured their impact on scalability in those locations?

	Without measurement there are two conflicting principles here: code
complexity vs. scalability.

	If you've made measurements I'm curious to know what kind of locks were
measured, where they were used, what the load was doing -- as a rough
characterization of the pattern of notifications -- and how much it
impacted scalability. This information might help suggest a better
solution.

> Second, in at least some of the cases we're familiar with,
> even when we might need all-tasks notification we still need task-local
> data.  That's been a problem with some of the global mechanisms I've
> seen discussed.

	The per-task notification can allow you to have task-local data. Would
registration of per-task notification from within an all-task
notification be sufficient?

Cheers,
	-Matt Helsley

