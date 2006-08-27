Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbWH0HhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbWH0HhY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 03:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbWH0HhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 03:37:24 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:8172 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750768AbWH0HhY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 03:37:24 -0400
Date: Sun, 27 Aug 2006 13:07:30 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       ego@in.ibm.com, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
       arjan@linux.intel.com, mingo@elte.hu, vatsa@in.ibm.com,
       ashok.raj@intel.com
Subject: Re: [RFC][PATCH 0/4] Redesign cpu_hotplug locking.
Message-ID: <20060827073730.GE22565@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060824102618.GA2395@in.ibm.com> <20060824091704.cae2933c.akpm@osdl.org> <20060825095008.GC22293@redhat.com> <Pine.LNX.4.64.0608261404350.11811@g5.osdl.org> <20060826150422.a1d492a7.akpm@osdl.org> <20060827061155.GC22565@in.ibm.com> <20060826234618.b9b2535a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060826234618.b9b2535a.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2006 at 11:46:18PM -0700, Andrew Morton wrote:
> On Sun, 27 Aug 2006 11:41:55 +0530
> 
> > The right thing to do would be to
> > do an audit and clean up the bad lock_cpu_hotplug() calls.
> 
> No, that won't fix it.  For example, take a look at all the *callers* of
> cpufreq_update_policy().  AFAICT they're all buggy.  Fiddling with the
> existing lock_cpu_hotplug() sites won't fix that.  (Possibly this
> particular problem can be fixed by checking that the relevant CPU is still
> online after the appropriate locking has been taken - dunno).
> 

This is a different issue from the ones that relates to lock_cpu_hotplug().
This one seems like a cpufreq internal locking problem.

On a quick look at this, it seems to me that cpufreq_cpu_get() should
do exactly what you said - use a spinlock in each cpufreq_cpu_data[] to
protect the per-cpu flag and in cpufreq_cpu_get() check if
!data and data->online == 0. They may have to do - 

static struct cpufreq_data {
	spinlock_t lock;
	int flag;
	struct cpufreq_policy *policy;
} cpufreq_cpu_data[NR_CPUS];


Thanks
Dipankar
