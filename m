Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932754AbWANHeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932754AbWANHeu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 02:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932763AbWANHeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 02:34:50 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:59584 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932754AbWANHet (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 02:34:49 -0500
Subject: Re: [Lse-tech] Re: [ckrm-tech] Re: [PATCH 00/01] Move Exit
	Connectors
From: Matt Helsley <matthltc@us.ibm.com>
To: Jes Sorensen <jes@trained-monkey.org>
Cc: John Hesterberg <jh@sgi.com>, Shailabh Nagar <nagar@watson.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Jay Lan <jlan@engr.sgi.com>,
       LKML <linux-kernel@vger.kernel.org>, elsa-devel@lists.sourceforge.net,
       lse-tech@lists.sourceforge.net,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, Paul Jackson <pj@sgi.com>,
       Erik Jacobson <erikj@sgi.com>, Jack Steiner <steiner@sgi.com>
In-Reply-To: <yq0bqyg31yv.fsf@jaguar.mkp.net>
References: <1136414431.22868.115.camel@stark>
	 <20060104151730.77df5bf6.akpm@osdl.org> <1136486566.22868.127.camel@stark>
	 <1136488842.22868.142.camel@stark> <20060105151016.732612fd.akpm@osdl.org>
	 <1136505973.22868.192.camel@stark> <yq08xttybrx.fsf@jaguar.mkp.net>
	 <43BE9E91.9060302@watson.ibm.com> <yq0wth72gr6.fsf@jaguar.mkp.net>
	 <1137013330.6673.80.camel@stark> <20060111213910.GA17986@sgi.com>
	 <1137019367.6673.97.camel@stark> <yq0fynt3gv6.fsf@jaguar.mkp.net>
	 <1137108030.6673.255.camel@stark>  <yq0bqyg31yv.fsf@jaguar.mkp.net>
Content-Type: text/plain
Date: Fri, 13 Jan 2006 23:23:09 -0800
Message-Id: <1137223389.6673.601.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-13 at 04:35 -0500, Jes Sorensen wrote:
> >>>>> "Matt" == Matt Helsley <matthltc@us.ibm.com> writes:
> 
> Matt> On Thu, 2006-01-12 at 05:01 -0500, Jes Sorensen wrote:
> >> It all depends on the specific location of the locks and how often
> >> they are taken. As long as something is taken by the same CPU all
> >> the time is not going to be a major issue, but if we end up with
> >> anything resembling a global lock, even if it is only held for a
> >> very short time, it is going to bite badly. On a 4-way you probably
> >> won't notice, but go to a 64-way and it bites, on a 512-way it eats
> >> you alive (we had a problem in the timer code quite a while back
> >> that prevented the machine from booting - it wasn't a lock that was
> >> held for a long time, just the fact that every CPU would take it
> >> every HZ was enough).
> 
> Matt> 	OK, so you've established that global locks in timer paths are
> Matt> Bad.  However you haven't established that timer paths are
> Matt> almost the same as the task paths we're talking about. I suspect
> Matt> timer paths are used much more frequently than fork, exec, or
> Matt> exit.
> 
> Hi Matt,
> 
> I wasn't trying to make it sound like this was an apples to apples
> comparison, what I am saying is simply that locks aren't free.

OK. I'm not sure what gave you the impression I thought they were.

> You are totally right that fork/exec should be called a lot less
> frequently, but the delay account data collection points will be in far
> more places than that and they will all go for the lock.

	All of these places are highly likely to also be in the context of the
task that has the lock in it's task->delays struct. This could be a
strongly recommended practice for taking the lock -- we can add a
comment next to the lock suggesting as much.

> Matt> 	I've appended a small patch that adds a global lock to the
> Matt> task_notify paths for testing purposes. I'm curious to know what
> Matt> kind of a performance difference you would see on your 64 or
> Matt> 512-way if you were to run with it.
> 
> I don't have a 512-way to play with at the moment, but again I don't
> think it makes sense to benchmark things which aren't matching what we
> are looking at. If we can avoid the locks in the first place then
> there's really no reason for not doing that.

	It could be good for establishing a lower bound on contention resulting
from locking implementations of task_notify. I think in that respect
it's comparing two species of apples.

	We need to clarify what locking we're talking about -- locking in
task_notify to protect the notification list vs. locking in delayacct to
protect the accounting data consistency. I think that a simple lockless
approach may only be possible for task_notify.

Cheers,
	-Matt Helsley

