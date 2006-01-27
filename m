Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbWA0XOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWA0XOv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 18:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbWA0XOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 18:14:51 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:186 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932154AbWA0XOu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 18:14:50 -0500
Date: Fri, 27 Jan 2006 15:14:20 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Eric Dumazet <dada1@cosmosbay.com>, dipankar@in.ibm.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk,
       nickpiggin@yahoo.com.au, hch@infradead.org
Subject: Re: [patch 2/2] fix file counting
Message-ID: <20060127231420.GA10075@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060126184010.GD4166@in.ibm.com> <20060126184127.GE4166@in.ibm.com> <20060126184233.GF4166@in.ibm.com> <43D92DD6.6090607@cosmosbay.com> <20060127145412.7d23e004.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060127145412.7d23e004.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 02:54:12PM -0800, Andrew Morton wrote:
> Eric Dumazet <dada1@cosmosbay.com> wrote:
> >
> > > This patch changes the file counting by removing the filp_count_lock.
> > > Instead we use a separate atomic_t, nr_files, for now and all
> > > accesses to it are through get_nr_files() api. In the sysctl
> > > handler for nr_files, we populate files_stat.nr_files before returning
> > > to user.
> > > 
> > > Counting files as an when they are created and destroyed (as opposed
> > > to inside slab) allows us to correctly count open files with RCU.
> > > 
> > > Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>
> > > ---
> > 
> > Well...
> > 
> > I am using a patch that seems sligthly better : It removes the filp_count_lock 
> > as yours but introduces a percpu variable, and a lazy nr_files . (Its value 
> > can be off with a delta of +/- 16*num_possible_cpus()
> 
> Yes, I think that is better.

I agree that Eric's approach likely improves performance on large systems
due to decreased cache thrashing.  However, the real problem is getting
both good throughput and good latency in RCU callback processing, given
Lee Revell's latency testing results.  Once we get that in hand, then
we should consider Eric's approach.

It might be that Lee needs to use -rt CONFIG_PREEMPT_RT to get
the latencies he needs, but given that he is seeing several milliseconds
of delay, I hope we can do better.  ;-)

						Thanx, Paul
