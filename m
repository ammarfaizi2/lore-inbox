Return-Path: <linux-kernel-owner+w=401wt.eu-S1752433AbWLVT70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752433AbWLVT70 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 14:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752451AbWLVT70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 14:59:26 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:41835 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752433AbWLVT7Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 14:59:25 -0500
Date: Sat, 23 Dec 2006 01:31:13 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ego@in.ibm.com, Oleg Nesterov <oleg@tv-sign.ru>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, David Wilder <dwilder@us.ibm.com>,
       Tom Zanussi <zanussi@us.ibm.com>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com, Douglas Niehaus <niehaus@eecs.ku.edu>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Thomas Gleixner <tglx@linutronix.de>, kiran@scalex86.org,
       venkatesh.pallipadi@intel.com, dipankar@in.ibm.com, vatsa@in.ibm.com,
       torvalds@osdl.org, davej@redhat.com
Subject: Re: [PATCH] Relay CPU Hotplug support
Message-ID: <20061222200113.GA32482@in.ibm.com>
Reply-To: ego@in.ibm.com
References: <20061221003101.GA28643@Krystal> <20061220232350.eb4b6a46.akpm@osdl.org> <20061222103724.GA29348@in.ibm.com> <20061222024458.322adffd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061222024458.322adffd.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 22, 2006 at 02:44:58AM -0800, Andrew Morton wrote:
> On Fri, 22 Dec 2006 16:07:24 +0530
> Gautham R Shenoy <ego@in.ibm.com> wrote:
> 
> > While we are at this per-subsystem cpuhotplug "locking", here's a
> > proposal that might put an end to the workqueue deadlock woes.
> 
> Oleg is working on some patches which will permit us to cancel or wait upon
> a particular work_struct, rather than upon all pending work_structs.
>

Oh! I was refering to the other set of workqueue deadlock woes. The
ones caused when subsystems (like cpufreq) try to create/destroy
workqueue from the cpuhotplug callback path. 

Creation/destruction of workqueue requires us to take workqueue_mutex,
which would have already been taken during CPU_LOCK_ACQUIRE.

More often than not, the cpu hotplug protection that we need
is while accessing either cpu_online_map OR one of it's persubsystem
mirrors like policy->cpus. 
So it makes more sense to have all the persubsystem 
mutexes held only during the cpu-hotplug operation (i.e stop_machine_run
and __cpu_up) and release them immediately after sending notifications to
update the persubsystem online_cpu map.

Thanks and Regards
gautham.
-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"
