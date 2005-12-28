Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbVL1Nqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbVL1Nqn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 08:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964815AbVL1Nqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 08:46:43 -0500
Received: from fmr17.intel.com ([134.134.136.16]:142 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S964812AbVL1Nqm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 08:46:42 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="GB2312"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH v2:3/3]Export cpu topology by sysfs
Date: Wed, 28 Dec 2005 21:46:11 +0800
Message-ID: <8126E4F969BA254AB43EA03C59F44E84045301CF@pdsmsx404>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2:3/3]Export cpu topology by sysfs
Thread-Index: AcYLK0mleQFr8VwyQqOqZyZCp7f3rQAZ3caQ
From: "Zhang, Yanmin" <yanmin.zhang@intel.com>
To: "Nathan Lynch" <ntl@pobox.com>,
       "Yanmin Zhang" <ymzhang@unix-os.sc.intel.com>
Cc: <greg@kroah.com>, <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>,
       <linux-ia64@vger.kernel.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Shah, Rajesh" <rajesh.shah@intel.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
X-OriginalArrivalTime: 28 Dec 2005 13:46:18.0355 (UTC) FILETIME=[1442DC30:01C60BB5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>-----Original Message-----
>>From: Nathan Lynch [mailto:ntl@pobox.com]
>>Sent: 2005Äê12ÔÂ28ÈÕ 5:20
>>To: Yanmin Zhang
>>Cc: greg@kroah.com; linux-kernel@vger.kernel.org; discuss@x86-64.org; linux-ia64@vger.kernel.org; Siddha, Suresh B; Shah, Rajesh;
>>Pallipadi, Venkatesh; Zhang, Yanmin
>>Subject: Re: [PATCH v2:3/3]Export cpu topology by sysfs
>>
>>Yanmin Zhang wrote:
>>>
>>> Items (attributes) are similar to /proc/cpuinfo.
>>>
>>> 1) /sys/devices/system/cpu/cpuX/topology/physical_package_id:
>>> represent the physical package id of  cpu X;
>>> 2) /sys/devices/system/cpu/cpuX/topology/core_id:
>>> represent the cpu core id to cpu X;
>>> 3) /sys/devices/system/cpu/cpuX/topology/thread_id:
>>> represent the cpu thread id  to cpu X;
>>
>>So what is the format of the *_id attributes?  Looks like this is
>>determined by the architecture, which is okay, but it doesn't seem
>>explicit.
The type of *_id is int or u8 (like on x86_64). It's better to convert the value to int.

>>
>>What about sane default values for the *_id attributes?
It depends on the specific architectures. On i386/x86_64, the default vaules of *_id are 0xffu. On ia64, the default value of physical_package_id is -1.

  For example,
>>say I have a uniprocessor PC without HT or multicore -- should all of
>>these attributes have zero values, or some kind of "special" value to
>>mean "not applicable"?
This feature is disabled when CONFIG_SMP=n. I can't make decision that all arch should use the same default values, so let architectures to decide. Is it ok?

>>
>>Hmm, why should thread_id be exported at all?  Is it useful to
>>userspace in a way that the logical cpu id is not?
Just to make it clearer. Of course, physical_package_id /core_id/ logical cpu id could tell enough info like thread id.

>>
>>> 4) /sys/devices/system/cpu/cpuX/topology/thread_siblings:
>>> represent the thread siblings to cpu X in the same core;
>>> 5) /sys/devices/system/cpu/cpuX/topology/core_siblings:
>>> represent the thread siblings to cpu X in the same physical package;
>>>
>>> If one architecture wants to support this feature, it just needs to
>>> implement 5 defines, typically in file include/asm-XXX/topology.h.
>>> The 5 defines are:
>>> #define topology_physical_package_id(cpu)
>>> #define topology_core_id(cpu)
>>> #define topology_thread_id(cpu)
>>> #define topology_thread_siblings(cpu)
>>> #define topology_core_siblings(cpu)
>>>
>>> The type of siblings is cpumask_t.
>>>
>>> If an attribute isn't defined on an architecture, it won't be
>>> exported.
>>
>>Okay, but which combinations of attributes are valid?  E.g. I would
>>think that it's fine for an architecture to define topology_thread_id
>>and topology_thread_siblings without any of the others, correct?
I think topology_physical_package_id/topology_core_id/topology_core_siblings are also needed. For example, admin might want to bind some processes to specific physical cpu, or core.

>>
>>Also I'd rather the architectures have the ability to define these as
>>functions instead of macros.
It's easy. The architectures just need the defines to point to functions in their specific header files, typically in file include/asm-XXX/topology.h.

>>
>><snip>
>>
>>> +/* Add/Remove cpu_topology interface for CPU device */
>>> +static int __cpuinit topology_add_dev(struct sys_device * sys_dev)
>>> +{
>>> +	sysfs_create_group(&sys_dev->kobj, &topology_attr_group);
>>> +	return 0;
>>> +}
>>
>>Can't sysfs_create_group fail?
It might fail, but it doesn't matter. Later when topology_remove_dev is called, sysfs_remove_group will do nothing because the subdir is not created.


>>
>>> +
>>> +static int __cpuinit topology_remove_dev(struct sys_device * sys_dev)
>>> +{
>>> +	sysfs_remove_group(&sys_dev->kobj, &topology_attr_group);
>>> +	return 0;
>>> +}
>>> +
>>> +static int __cpuinit topology_cpu_callback(struct notifier_block *nfb,
>>> +		unsigned long action, void *hcpu)
>>> +{
>>> +	unsigned int cpu = (unsigned long)hcpu;
>>> +	struct sys_device *sys_dev;
>>> +
>>> +	sys_dev = get_cpu_sysdev(cpu);
>>> +	switch (action) {
>>> +		case CPU_ONLINE:
>>> +			topology_add_dev(sys_dev);
>>> +			break;
>>> +		case CPU_DEAD:
>>> +			topology_remove_dev(sys_dev);
>>> +			break;
>>> +	}
>>> +	return NOTIFY_OK;
>>> +}
>>
>>I don't think it makes much sense to add and remove the attribute
>>group for cpu online/offline events.  The topology information for an
>>offline cpu is potentially valuable -- it could help the admin decide
>>which processor to online at runtime, for example.
>>
>>I believe the correct time to update the topology information is when
>>the topology actually changes (e.g. physical addition or removal of a
>>processor) -- this is independent of online/offline operations.
Currently, on i386/x86_64/ia64, a cpu gets its own topology by itself and fills into a global array. If the cpu is offline since the machine is booted, we can't get its topology info.
And when a cpu is offline, current kernel deletes it from the thread_siblings and core_siblings of other cpu.

>>
>>In general, I'm still a little uneasy with exporting the cpu topology
>>in this way.  I can see how the information would be useful, and right
>>now, Linux does not do a great job of exposing to userspace these
>>relationships between cpus.  So I see the need.
I also think there are requirements. Many high-reliable applications, such like in telecom, need bind processes on specific cpus. The topology info is important for admin to do so.

  But the things about
>>this approach which I don't like are:
>>
>>- Attributes which are not applicable to the running system will be
>>  exported anyway.  Discovery at runtime would be less confusing, I
>>  think.
>>
>>- This locks us into exporting a three-level topology (thread, core,
>>  package), with hard-coded names, when it seems probable that there
>>  will be systems with more levels than that in the future.
It's easy to add more levels based on my implementations. 
Hard-coded names might be a problem. Is there any special requirement to change the names arch-specifically? If some architectures really need their specific names, I will change the names from hard-coded to arch-defined.

>>
>>Have you considered basing the exported topology on sched domains?
No. Sched domains consist of far more info. Zou Nanhai wrote a patch to export sched domain info by procfs. I think it's better if we could export sched domain by sysfs.

Thanks,
Yanmin
