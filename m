Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937084AbWLFSiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937084AbWLFSiA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 13:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937085AbWLFSiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 13:38:00 -0500
Received: from mga03.intel.com ([143.182.124.21]:8522 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937084AbWLFSh7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 13:37:59 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,505,1157353200"; 
   d="scan'208"; a="154705675:sNHT176158675"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: CPUFREQ-CPUHOTPLUG: Possible circular locking dependency
Date: Wed, 6 Dec 2006 10:27:01 -0800
Message-ID: <EB12A50964762B4D8111D55B764A8454FA8858@scsmsx413.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: CPUFREQ-CPUHOTPLUG: Possible circular locking dependency
Thread-Index: AccUdOrmnY9uSAmESEWwPBLUA1I2RQE7aNhw
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: <ego@in.ibm.com>, "Ingo Molnar" <mingo@elte.hu>
Cc: <akpm@osdl.org>, <linux-kernel@vger.kernel.org>, <torvalds@osdl.org>,
       <davej@redhat.com>, <dipankar@in.ibm.com>, <vatsa@in.ibm.com>
X-OriginalArrivalTime: 06 Dec 2006 18:27:02.0993 (UTC) FILETIME=[2022E410:01C71964]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
>Gautham R Shenoy
>Sent: Thursday, November 30, 2006 3:44 AM
>To: Ingo Molnar
>Cc: Gautham R Shenoy; akpm@osdl.org; 
>linux-kernel@vger.kernel.org; torvalds@osdl.org; 
>davej@redhat.com; dipankar@in.ibm.com; vatsa@in.ibm.com
>Subject: Re: CPUFREQ-CPUHOTPLUG: Possible circular locking dependency
>
>On Thu, Nov 30, 2006 at 12:03:15PM +0100, Ingo Molnar wrote:
>> 
>> * Gautham R Shenoy <ego@in.ibm.com> wrote:
>> 
>> > a) cpufreq maintain's it's own cpumask in the variable
>> > policy->affected_cpus and says : If a frequency change is issued to
>> > any one of the cpu's in the affected_cpus mask, you change 
>frequency
>> > on all cpus in the mask. So this needs to be consistent with
>> > cpu_online map and hence cpu hotplug aware. Furthermore, 
>we don't want
>> > cpus in this mask to go down when we are trying to change 
>frequencies
>> > on them. The function which drives the frequency change in
>> > cpufreq-core is cpufreq_driver_target and it needs cpu-hotplug
>> > protection.
>> 
>> couldnt this complexity be radically simplified by having new kernel
>> infrastructure that does something like:
>> 
>>   " 'gather' all CPUs mentioned in <mask> via scheduling a separate
>>     helper-kthread on every CPU that <mask> specifies, disable all
>>    interrupts, and execute function <fn> once all CPUs have been
>>    'gathered' - and release all CPUs once <fn> has executed 
>on each of
>>    them."
>> 
>> ?
>
>This is what is currently being done by cpufreq:
>
>a) get_some_cpu_hotplug_protection() [use either some global mechanism 
>					or a persubsystem mutex]
>
>b) actual_freq_change_driver_function(mask) 
>/* You can check out cpufreq_p4_target() in
> * arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
> */
>  
>   {
>	for_each_cpu_mask(i, mask) {
>		cpumask_t this_cpu = cpumask_of_cpu(i);
>         	set_cpus_allowed(current, this_cpu);
>		function_to_change_frequency();
>							
>	}
>  }
>

As there are many options being discussed here, let me propose one 
more option that can eliminate the need for hotplug lock in 
cpufreq_driver_target() path.

As Gautham clearly explained before, today we have cpufreq calling
cpufreq_driver_target() in each driver to change the CPU frequency
And the driver internally uses set_cpus_allowed to reschedule onto
different affected_cpus and change the frequency. That is the main
reason why we need to disable hotplug in this path.

But, if we make cpufreq more affected_cpus aware and have a per_cpu
target()
call by moving set_cpus_allowed() from driver into cpufreq core and
define
the target function to be atomic/non-sleeping type, then we really don't
need a hotplug lock for the driver any more. Driver can have
get_cpu/put_cpu
pair to disable preemption and then change the frequency.

This means a lot of changes as we need new interface changes to cpufreq
and
rewrite of bunch of drivers. But, this looks to me as the least
complicated solution.

Thanks,
Venki 
