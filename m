Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936202AbWK3Lnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936202AbWK3Lnm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 06:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936204AbWK3Lnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 06:43:42 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:58046 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP id S936202AbWK3Lnl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 06:43:41 -0500
Date: Thu, 30 Nov 2006 17:13:46 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Gautham R Shenoy <ego@in.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, davej@redhat.com,
       dipankar@in.ibm.com, vatsa@in.ibm.com
Subject: Re: CPUFREQ-CPUHOTPLUG: Possible circular locking dependency
Message-ID: <20061130114346.GC23354@in.ibm.com>
Reply-To: ego@in.ibm.com
References: <20061129152404.GA7082@in.ibm.com> <20061130083144.GC29609@elte.hu> <20061130102410.GB23354@in.ibm.com> <20061130110315.GA30460@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061130110315.GA30460@elte.hu>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2006 at 12:03:15PM +0100, Ingo Molnar wrote:
> 
> * Gautham R Shenoy <ego@in.ibm.com> wrote:
> 
> > a) cpufreq maintain's it's own cpumask in the variable
> > policy->affected_cpus and says : If a frequency change is issued to
> > any one of the cpu's in the affected_cpus mask, you change frequency
> > on all cpus in the mask. So this needs to be consistent with
> > cpu_online map and hence cpu hotplug aware. Furthermore, we don't want
> > cpus in this mask to go down when we are trying to change frequencies
> > on them. The function which drives the frequency change in
> > cpufreq-core is cpufreq_driver_target and it needs cpu-hotplug
> > protection.
> 
> couldnt this complexity be radically simplified by having new kernel
> infrastructure that does something like:
> 
>   " 'gather' all CPUs mentioned in <mask> via scheduling a separate
>     helper-kthread on every CPU that <mask> specifies, disable all
>    interrupts, and execute function <fn> once all CPUs have been
>    'gathered' - and release all CPUs once <fn> has executed on each of
>    them."
> 
> ?

This is what is currently being done by cpufreq:

a) get_some_cpu_hotplug_protection() [use either some global mechanism 
					or a persubsystem mutex]

b) actual_freq_change_driver_function(mask) 
/* You can check out cpufreq_p4_target() in
 * arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
 */
  
   {
	for_each_cpu_mask(i, mask) {
		cpumask_t this_cpu = cpumask_of_cpu(i);
         	set_cpus_allowed(current, this_cpu);
		function_to_change_frequency();
							
	}
  }

c) release_whatever_cpu_hotplug_protection()

> 
> This would be done totally serialized and while holding the hotplug
> lock, so no CPU could go away or arrive while this operation is going
> on.
> 

Isn't the above same as what you are suggesting? Or have I missed out
anything? 

> 	Ingo

regards
gautham.
-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"
