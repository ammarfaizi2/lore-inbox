Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751741AbWAKVGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751741AbWAKVGk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 16:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751739AbWAKVGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 16:06:40 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:2438 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751738AbWAKVGj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 16:06:39 -0500
Subject: Re: [Lse-tech] Re: [ckrm-tech] Re: [PATCH 00/01] Move Exit
	Connectors
From: Matt Helsley <matthltc@us.ibm.com>
To: Jes Sorensen <jes@trained-monkey.org>
Cc: Shailabh Nagar <nagar@watson.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Jay Lan <jlan@engr.sgi.com>, LKML <linux-kernel@vger.kernel.org>,
       elsa-devel@lists.sourceforge.net, lse-tech@lists.sourceforge.net,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, Paul Jackson <pj@sgi.com>,
       Erik Jacobson <erikj@sgi.com>, Jack Steiner <steiner@sgi.com>,
       John Hesterberg <jh@sgi.com>
In-Reply-To: <yq0wth72gr6.fsf@jaguar.mkp.net>
References: <43BB05D8.6070101@watson.ibm.com>
	 <43BB09D4.2060209@watson.ibm.com> <43BC1C43.9020101@engr.sgi.com>
	 <1136414431.22868.115.camel@stark> <20060104151730.77df5bf6.akpm@osdl.org>
	 <1136486566.22868.127.camel@stark> <1136488842.22868.142.camel@stark>
	 <20060105151016.732612fd.akpm@osdl.org> <1136505973.22868.192.camel@stark>
	 <yq08xttybrx.fsf@jaguar.mkp.net> <43BE9E91.9060302@watson.ibm.com>
	 <yq0wth72gr6.fsf@jaguar.mkp.net>
Content-Type: text/plain
Date: Wed, 11 Jan 2006 13:02:10 -0800
Message-Id: <1137013330.6673.80.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-11 at 05:36 -0500, Jes Sorensen wrote:
> >>>>> "Shailabh" == Shailabh Nagar <nagar@watson.ibm.com> writes:
> 
> Shailabh> Jes Sorensen wrote:
> >> I am quite concerned about that lock your patches put into struct
> >> task_struct through struct task_delay_info. Have you done any
> >> measurements on how this impacts performance on highly threaded
> >> apps on larger system?
> 
> Shailabh> I don't expect the lock contention to be high. The lock is
> Shailabh> held for a very short time (across two
> Shailabh> additions/increments). Moreover, it gets contended only when
> Shailabh> the stats are being read (either through /proc or
> Shailabh> connectors).  Since the reading of stats won't be that
> Shailabh> frequent (the utility of these numbers is to influence the
> Shailabh> I/O priority/rss limit etc. which won't be done at a very
> Shailabh> small granularity anyway), I wouldn't expect a problem.
> 
> Hi Shailabh,
> 
> When this is read through connectors, it's initiated by the connectors
> code which is called from the task's context hence we don't need
> locking for that. It's very similar to the task_notify code I am about
> to post and I think the connector code could fit into that
> framework. The main issue is /proc, but then one could even have a
> mechanism with a hook when the task exits that pushes the data to a
> storage point which is lock protected.
> 
> Even if a lock isn't contended, you are still going to see the cache
> lines bounce around due to the writes. It may not show up on a 4-way
> box but what happens on a 64-way? We have seen some pretty nasty
> effects on the bigger SN2 boxes with locks that were taken far too
> frequently, to the point where it would prevent the box from booting
> (now I don't expect it to that severe here, but I'd still like to
> explore an approach of doing it lock free).
> 
> Shailabh> But its better to take some measurements anyway. Any
> Shailabh> suggestions on a benchmark ?
> 
> >> IMHO it seems to make more sense to use something like Jack's
> >> proposed task_notifier code to lock-less collect the data into task
> >> local data structures and then take the data from there and ship
> >> off to userland through netlink or similar like you are doing?
> >> 
> >> I am working on modifying Jack's patch to carry task local data and
> >> use it for not just accounting but other areas that need optional
> >> callbacks (optional in the sense that it's a feature that can be
> >> enabled or disabled). Looking at Shailabh's delayacct_blkio()
> >> changes it seems that it would be really easy to fit those into
> >> that framework.
> >> 
> >> Guess I should post some of this code .....
> 
> Shailabh> Please do. If this accounting can fit into some other
> Shailabh> framework, thats fine too.
> 
> Ok, finally, sorry for the delay. My current code snapshot is
> available at http://www.trained-monkey.org/~jes/patches/task_notify/ -
> it's a modified version of Jack's task_notify code, and three example
> users of it (the SysV IPC semundo semaphore, the key infrastructure
> and SGI's JOB module). The patch order should be task_notify.diff,
> task-notify-keys.diff, task-notify-semundo.diff, and
> task_notify-job.diff last.

	I can already tell you I don't like the "magic" mechanism to identify
notifier blocks. The problem is that it's yet another space of id
numbers that we have to manage -- either manually, by having a person
hand the numbers out to developers, or automatically using the idr code.
You could use the notifier block's address and avoid an additional id
space.

	Also, even if this mechanism goes into task_notify it needs a better
name than "magic".

> I think task_notify it should be usable for statistics gathering as
> well, the only issue is how to attach it to the processes we wish to
> gather accounting for. Personally I am not a big fan of the current
> concept where statistics are gathered for all tasks at all time but
> just not exported until accounting is enabled.

	Have you looked at Alan Stern's notifier chain fix patch? Could that be
used in task_notify?

	If not, perhaps the patch use the standard kernel list idioms.

	Another potential user for the task_notify functionality is the process
events connector. The problem is it requires the ability to receive
notifications about all processes. Also, there's a chance that future
CKRM code could use all-task and per-task notification. Combined with
John Hesterberg's feedback I think there is strong justification for an
all-tasks notification interface.

	If there was some way to quickly check for registration on an all-tasks
list you could do both all-task and per-task notification in the same
code. I took a shot at this a while back but the locking was incomplete.
Perhaps a per-cpu all-task notification list would satisfy your
performance-impact concerns.

<snip>

> The API for the task_notify code is not set in stone and we can add
> more notifier hooks where needed. If someone has strong reasoning for
> making changes to the API, then I'll be very open to that.

	I'd like to see the all-task notification I mentioned above.
Notifications where uid/gids change could be useful for auditing and
process events connector.

<snip>

Cheers,
	-Matt Helsley

