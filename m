Return-Path: <linux-kernel-owner+w=401wt.eu-S1946026AbWLVKfw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946026AbWLVKfw (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 05:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946029AbWLVKfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 05:35:51 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:49798 "EHLO e6.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946026AbWLVKfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 05:35:50 -0500
Date: Fri, 22 Dec 2006 16:07:24 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
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
Message-ID: <20061222103724.GA29348@in.ibm.com>
Reply-To: ego@in.ibm.com
References: <20061221003101.GA28643@Krystal> <20061220232350.eb4b6a46.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061220232350.eb4b6a46.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

While we are at this per-subsystem cpuhotplug "locking", here's a
proposal that might put an end to the workqueue deadlock woes.

I'm yet to cook up a patch for this, but here's the idea in brief.

On Wed, Dec 20, 2006 at 11:23:50PM -0800, Andrew Morton wrote:
> to the relay driver.  Why do that - you don't own cpu_online_map (but you
> do get some notifications when it wants to change, that's all).

How about: Let each hot-cpu-aware subsystem maintain it's own 
online_cpus mask. Thus we can eliminate the global online_cpus mask 
and also have a clear picture of what data the per-subsystem mutexes
are protecting :)

In kenel/cpu.c

_cpu_down()
{
	send_all_pre_cpu_down_notifications();
	.
	.
	.
	send_notifications_to_lock_per_subsystem_mutexes();
	__stop_machine_run();
	send_notifications_to_update_per_subsystem_online_cpus_mask();
	send_notifications_to_release_per_subsystem_mutexes();
	.
	.
	.
	send_all_post_cpu_down_notifications();
	
}

Ditto for _cpu_up().

This will not only reduce the lock-contention , but will also 
allow the pre/post hotplug notifications handlers to make calls to 
function which are cpu-hotplug-aware (like create_workqueue,
destroy_workqueues etc) without ending up in a recursive deadlock
as the persubsystem mutexes would have been released by then. 

And since we are sending notifications to update 
per_subsystem_cpus_mask before sending the
post_cpu_hotplug_notifications, the post_notification handlers
will be executing with the consistent value of the online_cpus mask.

Does anybody see a problem with this "update_now-cleanup_later" 
approach ?

Thanks and Regards
gautham.
-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"
