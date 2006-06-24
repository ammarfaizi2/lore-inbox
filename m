Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbWFXWTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbWFXWTI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 18:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbWFXWTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 18:19:07 -0400
Received: from xenotime.net ([66.160.160.81]:30444 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751128AbWFXWTG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 18:19:06 -0400
Date: Sat, 24 Jun 2006 15:21:52 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Ashok Raj <ashok.raj@intel.com>
Cc: kamezawa.hiroyu@jp.fujitsu.com, linux-kernel@vger.kernel.org,
       pavel@suse.cz, jeremy@goop.org, clameter@sgi.com, ntl@pobox.com,
       akpm@osdl.org, ashok.raj@intel.com, ak@suse.de, nickpiggin@yahoo.com.au,
       mingo@elte.hu
Subject: Re: [RFC][PATCH] avoid cpu hot removal if busy take3
Message-Id: <20060624152152.bf3a68cd.rdunlap@xenotime.net>
In-Reply-To: <20060623120950.A31038@unix-os.sc.intel.com>
References: <20060623164042.3a828e8e.kamezawa.hiroyu@jp.fujitsu.com>
	<20060623120950.A31038@unix-os.sc.intel.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2006 12:09:50 -0700 Ashok Raj wrote:

> On Fri, Jun 23, 2006 at 04:40:42PM +0900, KAMEZAWA Hiroyuki wrote:
> > 
> > In this case,
> > 1. ignore bad configuration in user-land just do warnings.
> > 2. cancel cpu hot removal and warn users to fix the problem and retry.
> > seems to be a realisitc workaround. Killing the problematic process may
> > cause some trouble in user-land (dead-lock etc..)
> > 
> > This patch adds sysctl cpu_removal_migration.
> > If cpu_removal_migration == 1, all tasks are migrated by force.
> > If cpu_removal_migration == 0, cpu_hotremoval can fail because of not-migratable
> > tasks.
> 
> Having this dual behaviour is a concern. Probably we should have the tasks
> decide if they want to terminate themselves if its not *OK* to run on a 
> different CPU, and not have a policy in kernel decide which way the 
> behaviour should be. The kernel policy should be to always force
> the cpu removal to happen. Admin should decide what processes should terminate
> ahead of time before the removal force migrates them.

You are making a value call as you see it.  Others have
disagreed.

> Once the kernel/admin chooses to perform cpu offline, it should not be possible
> for some process to veto the removal and fail the removal. Removal was probably
> choosen since we would like to offline a failing cpu, and dont want some
> thing in the way to make that happen.

Just how slowly or quickly to CPUs fail?  Does an admin have time
to look up the list of processes that are bound to which CPUs,
move them or kill them, etc., before giving the offline-that-CPU
command?  or would she/he rather tell the system how to handle
CPU-offlining conflicts and then just issue the one command?


> > + */
> > +static int test_cpu_busy(int cpu)
> > +{
> > +	cpumask_t mask;
> > +	int ret = 0;
> 
>  Deleted....
> 
> > +
> > +	read_lock(&tasklist_lock);
> > +	for_each_process(p) {
> > +		if (p == current)
> > +			continue;
> > +		if (p->mm && cpus_equal(mask, p->cpus_allowed)) {
> > +			ret = 1;
> > +			pid = p->pid;
> > +			break;
> > +		}
> 
> Do you want to scan and print all possible id's? otherwise printk will
> have just 1, and next attempt will show another pid now... in case the
> admin wants to do something useful with this list, probably better to 
> give it all out?

Yep, I noticed that too, but didn't comment on it.

---
~Randy
