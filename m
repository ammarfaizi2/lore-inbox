Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751666AbWFWX33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666AbWFWX33 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 19:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751669AbWFWX33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 19:29:29 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:14727 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751647AbWFWX32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 19:29:28 -0400
Date: Sat, 24 Jun 2006 08:27:43 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Ashok Raj <ashok.raj@intel.com>
Cc: linux-kernel@vger.kernel.org, pavel@suse.cz, jeremy@goop.org,
       rdunlap@xenotime.net, clameter@sgi.com, ntl@pobox.com, akpm@osdl.org,
       ashok.raj@intel.com, ak@suse.de, nickpiggin@yahoo.com.au, mingo@elte.hu
Subject: Re: [RFC][PATCH] avoid cpu hot removal if busy take3
Message-Id: <20060624082743.8e57755a.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060623120950.A31038@unix-os.sc.intel.com>
References: <20060623164042.3a828e8e.kamezawa.hiroyu@jp.fujitsu.com>
	<20060623120950.A31038@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2006 12:09:50 -0700
Ashok Raj <ashok.raj@intel.com> wrote:

> On Fri, Jun 23, 2006 at 04:40:42PM +0900, KAMEZAWA Hiroyuki wrote:
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
> 
Hmm..I wish this forcced migration will not break resource isolation sub system
in future.

> Once the kernel/admin chooses to perform cpu offline, it should not be possible
> for some process to veto the removal and fail the removal. Removal was probably
> choosen since we would like to offline a failing cpu, and dont want some
> thing in the way to make that happen.

But in dynamic reconfiguration case (ex. VM resiging for load balancing)
the demand is not so heavy. And if we want to remove cpu by force, just adding
one line to script, echo 1 > /proc/sys/kernel/cpu_removal_migration is enough.
This is not so big obstacle.


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
> 
Hmm, maybe useful. I'll consider again this if I can go ahead. 

Thanks,
-Kame

