Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751946AbWFWTPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751946AbWFWTPo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 15:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751948AbWFWTPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 15:15:44 -0400
Received: from mga07.intel.com ([143.182.124.22]:9738 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751946AbWFWTPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 15:15:43 -0400
X-IronPort-AV: i="4.06,169,1149490800"; 
   d="scan'208"; a="56611212:sNHT57982953"
Date: Fri, 23 Jun 2006 12:09:50 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, pavel@suse.cz,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, clameter@sgi.com, ntl@pobox.com,
       akpm@osdl.org, ashok.raj@intel.com, ak@suse.de, nickpiggin@yahoo.com.au,
       mingo@elte.hu
Subject: Re: [RFC][PATCH] avoid cpu hot removal if busy take3
Message-ID: <20060623120950.A31038@unix-os.sc.intel.com>
References: <20060623164042.3a828e8e.kamezawa.hiroyu@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060623164042.3a828e8e.kamezawa.hiroyu@jp.fujitsu.com>; from kamezawa.hiroyu@jp.fujitsu.com on Fri, Jun 23, 2006 at 04:40:42PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2006 at 04:40:42PM +0900, KAMEZAWA Hiroyuki wrote:
> 
> In this case,
> 1. ignore bad configuration in user-land just do warnings.
> 2. cancel cpu hot removal and warn users to fix the problem and retry.
> seems to be a realisitc workaround. Killing the problematic process may
> cause some trouble in user-land (dead-lock etc..)
> 
> This patch adds sysctl cpu_removal_migration.
> If cpu_removal_migration == 1, all tasks are migrated by force.
> If cpu_removal_migration == 0, cpu_hotremoval can fail because of not-migratable
> tasks.

Having this dual behaviour is a concern. Probably we should have the tasks
decide if they want to terminate themselves if its not *OK* to run on a 
different CPU, and not have a policy in kernel decide which way the 
behaviour should be. The kernel policy should be to always force
the cpu removal to happen. Admin should decide what processes should terminate
ahead of time before the removal force migrates them.

Once the kernel/admin chooses to perform cpu offline, it should not be possible
for some process to veto the removal and fail the removal. Removal was probably
choosen since we would like to offline a failing cpu, and dont want some
thing in the way to make that happen.

> + */
> +static int test_cpu_busy(int cpu)
> +{
> +	cpumask_t mask;
> +	int ret = 0;

 Deleted....

> +
> +	read_lock(&tasklist_lock);
> +	for_each_process(p) {
> +		if (p == current)
> +			continue;
> +		if (p->mm && cpus_equal(mask, p->cpus_allowed)) {
> +			ret = 1;
> +			pid = p->pid;
> +			break;
> +		}

Do you want to scan and print all possible id's? otherwise printk will
have just 1, and next attempt will show another pid now... in case the
admin wants to do something useful with this list, probably better to 
give it all out?


-- 
Cheers,
Ashok Raj
- Open Source Technology Center
