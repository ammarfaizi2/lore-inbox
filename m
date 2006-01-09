Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751528AbWAIGr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbWAIGr5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 01:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751530AbWAIGr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 01:47:57 -0500
Received: from fmr17.intel.com ([134.134.136.16]:38824 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751527AbWAIGr4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 01:47:56 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="GB2312"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH v3]Export cpu topology by sysfs
Date: Mon, 9 Jan 2006 14:47:48 +0800
Message-ID: <8126E4F969BA254AB43EA03C59F44E8404693250@pdsmsx404>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v3]Export cpu topology by sysfs
Thread-Index: AcYU2z03iaIZr9pgQu6PNbqA33QnmgAC61Jg
From: "Zhang, Yanmin" <yanmin.zhang@intel.com>
To: "Nathan Lynch" <ntl@pobox.com>,
       "Yanmin Zhang" <ymzhang@unix-os.sc.intel.com>
Cc: <linux-kernel@vger.kernel.org>, <greg@kroah.com>, <discuss@x86-64.org>,
       <linux-ia64@vger.kernel.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Shah, Rajesh" <rajesh.shah@intel.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
X-OriginalArrivalTime: 09 Jan 2006 06:47:49.0542 (UTC) FILETIME=[9B330C60:01C614E8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>-----Original Message-----
>>From: linux-ia64-owner@vger.kernel.org [mailto:linux-ia64-owner@vger.kernel.org] On Behalf Of Nathan Lynch
>>Sent: 2006Äê1ÔÂ9ÈÕ 13:10
>>To: Yanmin Zhang
>>Cc: linux-kernel@vger.kernel.org; greg@kroah.com; discuss@x86-64.org; linux-ia64@vger.kernel.org; Siddha, Suresh B; Shah, Rajesh;
>>Pallipadi, Venkatesh
>>Subject: Re: [PATCH v3]Export cpu topology by sysfs
>>> 2) Set consistent default values for the 4 attributes.
>>>
>>
>><snip>
>>
>>> If one architecture wants to support this feature, it just needs to
>>> implement 4 defines, typically in file include/asm-XXX/topology.h.
>>> The 4 defines are:
>>> #define topology_physical_package_id(cpu)
>>> #define topology_core_id(cpu)
>>> #define topology_thread_siblings(cpu)
>>> #define topology_core_siblings(cpu)
>>>
>>> The type of **_id is int.
>>> The type of siblings is cpumask_t.
>>>
>>> To be consistent on all architectures, the 4 attributes should have
>>> deafult values if their values are unavailable. Below is the rule.
>>> 1) physical_package_id: If cpu has no physical package id, -1 is the
>>> default value.
>>> 2) core_id: If cpu doesn't support multi-core, its core id is 0.
>>
>>Why not -1 as with the physical package id?  0 could be a valid core
>>id.
If the cpu has only 1 core, we could call it single-core, so it's reasonable to use 0 as its core id.


>>
>>> 3) thread_siblings: Just include itself, if the cpu doesn't support
>>> HT/multi-thread.
>>> 4) core_siblings: Just include itself, if the cpu doesn't support
>>> multi-core and HT/Multi-thread.
>>
>>Really, I think the least confusing interface would not export those
>>attributes which are not relevant for the system.  E.g. if the system
>>isn't multi-core, you don't see core_id and core_siblings attributes.
>>
>>Failing that, let's at least have consistent, unambiguous values for
>>the ids which are not applicable.
Current kernel will output core id by /proc/cpuinfo if a physical cpu has 2 threads, no matter if it's a multi-core, or just a multi-thread. To be consistent with /proc/cpuinfo, I think we need export core id and its default value is 0.

>>
>><snip>
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
>>I still oppose this bit.  I want the attributes there for powerpc even
>>for offline cpus -- the topology information (if obtainable, which it
>>is on powerpc) is useful regardless of the cpu's online state.  The
>>attributes should appear when a cpu is made present, and go away when
>>a cpu is removed.
As my previous email says, there are concerns/issues to do so. A compromise is that the patch could register a sysdev driver. When the cpu becomes offline from online, we don't delete the topology kobj. The compromise has a defect. If the cpu is never online since machine boots, the topology info of the cpu is incorrect. 

>>
>>This week I'll try to do an implementation for powerpc.
