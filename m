Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268216AbUIBS5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268216AbUIBS5v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 14:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268234AbUIBS5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 14:57:51 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:37092 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S268216AbUIBS5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 14:57:33 -0400
Subject: Re: [RFC&PATCH] Alternative RCU implementation
From: Jim Houston <jim.houston@comcast.net>
Reply-To: jim.houston@comcast.net
To: paulmck@us.ibm.com
Cc: linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jack Steiner <steiner@sgi.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       rusty@rustcorp.com.au
In-Reply-To: <20040902163854.GC1258@us.ibm.com>
References: <m3brgwgi30.fsf@new.localdomain>
	 <20040830004322.GA2060@us.ibm.com>
	 <1093886020.984.238.camel@new.localdomain>
	 <20040830185223.GF1243@us.ibm.com>
	 <1093922569.1003.159.camel@new.localdomain>
	 <20040901035350.GH1241@us.ibm.com>
	 <1094043719.986.51.camel@new.localdomain>
	 <20040902163854.GC1258@us.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1094151272.985.103.camel@new.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 02 Sep 2004 14:54:33 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-02 at 12:38, Paul E. McKenney wrote:
> On Wed, Sep 01, 2004 at 09:02:00AM -0400, Jim Houston wrote:
> > On Tue, 2004-08-31 at 23:53, Paul E. McKenney wrote:
> > > On Mon, Aug 30, 2004 at 11:22:49PM -0400, Jim Houston wrote:
> > > > On Mon, 2004-08-30 at 14:52, Paul E. McKenney wrote: 
> > > > > How does the rest of the kernel work with all interrupts to
> > > > > a particular CPU shut off?  For example, how do you timeslice?
> > > > 
> > > > It's a balancing act.  In some cases we just document the
> > > > missing functionality.  If the local timer is disabled on a cpu,
> > > > all processes are SCHED_FIFO.  In the case of Posix timers, we
> > > > move timers to honor the procesor shielding an the process affinity.
> > > 
> > > I have to ask...  When you say that you move the timers, you mean that
> > > non-realtime CPU 1 managers timers for realtime CPU 0, so that CPU 1
> > > is (effectively) taking CPU 0's timer interrupts?
> > 
> > Hi Paul,
> > 
> > That is part of the idea.  There are lots of timers which we don't
> > expect to have realtime behavior.
> > 
> > There are also services like Posix timers and nanosleep() where we want
> > very predictable behavior.  If a process does a nanosleep(), we queue
> > that timer on the local cpu.  If process affinity is changed, we will
> > move the timer to a cpu where the process is allowed to run.
> > 
> > We have separate queues for high resolution timers.  If the local queue
> > is empty, we shutdown the timer.
> 
> Hello, Jim,
> 
> How do you mark a given CPU as being in realtime mode?  Or is the
> timer-shutdown decision based on the presence of a realtime process
> runnable on the given CPU or some such?
> 
> Still trying to figure out a way to make this work without adding
> overhead to rcu_read_unlock()...

Hi Paul

We add the following /proc files:

/proc/shield/irqs
	Setting a bit limits the corresponding cpu to only handle
	interrupts which are explicitly directed to that cpu.

/proc/shield/ltmrs
	Setting a bit limits the use of local timers on the 
	corresponding cpu.

/proc/shield/procs
	Setting a bit limits the cpu to only run processes which
	have set affinity to that cpu.

When the user changes something we adjust irq routing and migrate
processes and timers appropriately.

Jim Houston - Concurrent Computer Corp.

