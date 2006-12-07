Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937951AbWLGHaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937951AbWLGHaR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 02:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937956AbWLGHaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 02:30:17 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:52277 "EHLO
	ausmtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937951AbWLGHaO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 02:30:14 -0500
Date: Thu, 7 Dec 2006 12:36:41 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: <ego@in.ibm.com>, "Ingo Molnar" <mingo@elte.hu>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <torvalds@osdl.org>, <davej@redhat.com>,
       <dipankar@in.ibm.com>, <vatsa@in.ibm.com>
Subject: Re: CPUFREQ-CPUHOTPLUG: Possible circular locking dependency
Message-ID: <20061207070630.GA30710@in.ibm.com>
Reply-To: ego@in.ibm.com
References: <EB12A50964762B4D8111D55B764A8454FA8858@scsmsx413.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EB12A50964762B4D8111D55B764A8454FA8858@scsmsx413.amr.corp.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Venki,
On Wed, Dec 06, 2006 at 10:27:01AM -0800, Pallipadi, Venkatesh wrote:

> But, if we make cpufreq more affected_cpus aware and have a per_cpu
> target()
> call by moving set_cpus_allowed() from driver into cpufreq core and
> define
> the target function to be atomic/non-sleeping type, then we really don't
> need a hotplug lock for the driver any more. Driver can have
> get_cpu/put_cpu
> pair to disable preemption and then change the frequency.

Well, we would still need to keep the affected_cpus map in sync with the
cpu_online map. That would still require hotplug protection, right?

Besides, I would love to see a way of implementing target function to be
atomic/non-sleeping type. But as of now, the target functions call
cpufreq_notify_transition which might sleep.

That's not the last of my worries. The ondemand-workqueue interaction
in the cpu_hotplug callback path can cause a deadlock if we go for
per-subsystem hotcpu mutexes. Can you think of a way by which we can 
avoid destroying the kondemand workqueue from the cpu-hotplug callback
path ? Please see http://lkml.org/lkml/2006/11/30/9 for the
culprit-callpath.

Thanks and Regards
gautham.
-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"
