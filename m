Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966798AbWKVAuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966798AbWKVAuH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 19:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966920AbWKVAuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 19:50:07 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:34509 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S966798AbWKVAuF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 19:50:05 -0500
Date: Tue, 21 Nov 2006 16:51:22 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
       Alan Stern <stern@rowland.harvard.edu>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061122005122.GL2013@us.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20061119214315.GI4427@us.ibm.com> <Pine.LNX.4.44L0.0611211244200.6140-100000@iolanthe.rowland.org> <20061121191338.GB2013@us.ibm.com> <20061121210105.GA381@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061121210105.GA381@oleg>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2006 at 12:01:05AM +0300, Oleg Nesterov wrote:
> On 11/21, Paul E. McKenney wrote:
> >
> > On Tue, Nov 21, 2006 at 12:56:21PM -0500, Alan Stern wrote:
> > > Here's another potential problem with the fast path approach.  It's not
> > > very serious, but you might want to keep it in mind.
> > >
> > > The idea is that a reader can start up on one CPU and finish on another,
> > > and a writer might see the finish event but not the start event.  For
> > > example:
> >
> > One approach to get around this would be for the the "idx" returned from
> > srcu_read_lock() to keep track of the CPU as well as the index within
> > the CPU.  This would require atomic_inc()/atomic_dec() on the fast path,
> > but would not add much to the overhead on x86 because the smp_mb() imposes
> > an atomic operation anyway.  There would be little cache thrashing in the
> > case where there is no preemption -- but if the readers almost always sleep,
> > and where it is common for the srcu_read_unlock() to run on a different CPU
> > than the srcu_read_lock(), then the additional cache thrashing could add
> > significant overhead.
> 
> If you are going to do this, it seems better to just forget about ->per_cpu_ref,
> and use only ->hardluckref[]. This also allows to avoid the polling in
> synchronize_srcu().

If the readers are reasonably rare, that could work.  If readers are
common, you get memory contention (as well as cache thrashing) on the
->hardluckref[] elements.  But putting this degree of cache thrashing
into SRCU certainly does not feel right.

						Thanx, Paul
