Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030404AbVLWEDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030404AbVLWEDc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 23:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030403AbVLWEDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 23:03:31 -0500
Received: from fmr18.intel.com ([134.134.136.17]:15532 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030400AbVLWEDa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 23:03:30 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="GB2312"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH v2:3/3]Export cpu topology by sysfs
Date: Fri, 23 Dec 2005 12:03:27 +0800
Message-ID: <8126E4F969BA254AB43EA03C59F44E840447C54F@pdsmsx404>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2:3/3]Export cpu topology by sysfs
Thread-Index: AcYHVlwV75DmDpy8SpmKgeg/tsd2PwAHepFQ
From: "Zhang, Yanmin" <yanmin.zhang@intel.com>
To: "Greg KH" <greg@kroah.com>, "Yanmin Zhang" <ymzhang@unix-os.sc.intel.com>
Cc: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>,
       <linux-ia64@vger.kernel.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Shah, Rajesh" <rajesh.shah@intel.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
X-OriginalArrivalTime: 23 Dec 2005 04:03:27.0689 (UTC) FILETIME=[D40DF390:01C60775]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>-----Original Message-----
>>From: Greg KH [mailto:greg@kroah.com]
>>Sent: 2005Äê12ÔÂ23ÈÕ 8:17
>>To: Yanmin Zhang
>>Cc: linux-kernel@vger.kernel.org; discuss@x86-64.org; linux-ia64@vger.kernel.org; Zhang, Yanmin; Siddha, Suresh B; Shah, Rajesh;
>>Pallipadi, Venkatesh
>>Subject: Re: [PATCH v2:3/3]Export cpu topology by sysfs
>>
>>On Tue, Dec 20, 2005 at 06:09:29PM -0800, Yanmin Zhang wrote:
>>> --- linux-2.6.15-rc5/drivers/base/topology.c	1970-01-01 08:00:00.000000000 +0800
>>> +++ linux-2.6.15-rc5_topology/drivers/base/topology.c	2005-12-20 00:33:49.000000000 +0800
>>> @@ -0,0 +1,201 @@
>>> +/*
>>> + * driver/base/topology.c - Populate driverfs with cpu topology information
>>
>>driverfs?  Where did you cut/paste this code from?
>>
>>And why does it have to be in driver/base?
I copied it from driver/base/node.c which implements node exportation by sysfs. I will change it. 
I couldn't find a better place than driver/base.


>>
>>> +struct _topology_attr {
>>> +	struct attribute attr;
>>> +	ssize_t (*show)(int cpu, char *);
>>> +	ssize_t (*store)(const char *, size_t count);
>>> +};
>>
>>Don't put a '_' at the beginning of a structure please.
I will change it.

>>
>>> +static ssize_t topology_show(struct kobject * kobj, struct attribute * attr, char * buf)
>>> +{
>>> +	unsigned int cpu;
>>> +        struct _topology_attr *fattr = to_attr(attr);
>>> +        ssize_t ret;
>>> +
>>> +	cpu = container_of(kobj->parent, struct sys_device, kobj)->id;
>>> +        ret = fattr->show ? fattr->show(cpu, buf): 0;
>>> +        return ret;
>>> +}
>>
>>Mix of spaces and tabs :(
It's a stupid problem. I will fix it.


>>
>>> +static ssize_t topology_store(struct kobject * kobj, struct attribute * attr,
>>> +		     const char * buf, size_t count)
>>> +{
>>> +	return 0;
>>> +}
>>
>>Why is this function even needed?
It's not needed and will be deleted.


>>
>>> +static struct sysfs_ops topology_sysfs_ops = {
>>> +	.show   = topology_show,
>>> +	.store  = topology_store,
>>> +};
>>> +
>>> +static struct kobj_type topology_ktype = {
>>> +	.sysfs_ops	= &topology_sysfs_ops,
>>> +	.default_attrs	= topology_default_attrs,
>>> +};
>>> +
>>> +/* Add/Remove cpu_topology interface for CPU device */
>>> +static int __cpuinit topology_add_dev(struct sys_device * sys_dev)
>>> +{
>>> +	unsigned int cpu = sys_dev->id;
>>> +
>>> +	memset(&cpu_topology_kobject[cpu], 0, sizeof(struct kobject));
>>> +
>>> +	cpu_topology_kobject[cpu].parent = &sys_dev->kobj;
>>> +	kobject_set_name(&cpu_topology_kobject[cpu], "%s", "topology");
>>> +	cpu_topology_kobject[cpu].ktype = &topology_ktype;
>>> +
>>> +	return  kobject_register(&cpu_topology_kobject[cpu]);
>>> +}
>>
>>Can't you just use an attribute group and attach it to the cpu kobject?
>>That would save an array of kobjects I think.
As you know, current i386/x86_64 arch also export cache info under /sys/device/system/cpu/cpuX/cache. Is it clearer to export topology under a new directory than under cpu directly?


>>
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
>>> +#ifdef	CONFIG_HOTPLUG_CPU
>>> +		case CPU_DEAD:
>>> +			topology_remove_dev(sys_dev);
>>> +			break;
>>> +#endif
>>
>>Why ifdef?  Isn't it safe to just always have this in?
If no ifdef here, gcc reported a compiling warning when I compiled it on IA64 with CONFIG_HOTPLUG_CPU=n.


>>
>>thanks,
>>
>>greg k-h
Thank you for the good comments. I will work out a new patch.

