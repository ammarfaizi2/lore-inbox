Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965102AbVIANoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965102AbVIANoH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 09:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965103AbVIANoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 09:44:06 -0400
Received: from usea-naimss1.unisys.com ([192.61.61.103]:34059 "EHLO
	usea-naimss1.unisys.com") by vger.kernel.org with ESMTP
	id S965102AbVIANoF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 09:44:05 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 1/1] Hot plug CPU to support physical add of new processors (i386)
Date: Thu, 1 Sep 2005 08:43:40 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04D0C@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 1/1] Hot plug CPU to support physical add of new processors (i386)
Thread-Index: AcWu0cQ3t5z8H0rDSjakyAtGKRvlRQAJSQwg
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <shaohua.li@intel.com>, <zwane@arm.linux.org.uk>, <ashok.raj@intel.com>,
       <akpm@osdl.org>, <lhcs-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>, <hotplug_sig@lists.osdl.org>
X-OriginalArrivalTime: 01 Sep 2005 13:43:41.0380 (UTC) FILETIME=[29F3E040:01C5AEFB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hallo Natalie,
> 
> On Wednesday 31 August 2005 14:13, 
> Natalie.Protasevich@unisys.com wrote:
> > Current IA32 CPU hotplug code doesn't allow bringing up processors 
> > that were not present in the boot configuration. To make 
> existing hot 
> > plug facility more practical for physical hot plug, possible 
> > processors should be encountered during boot for potentual hot 
> > add/replace/remove. On ES7000, ACPI marks all the sockets that are 
> > empty or not assigned to the partitionas as "disabled".
> 
> Good idea. In fact I always hated the behaviour of the 
> existing hotplug code that assumes all possible CPUs can be 
> hotplugged.
> It would be much nicer to be told be the firmware what CPUs 
> are hotpluggable. It would be great if all ia32/x86-64 
> hotplug capable BIOS behaved like your.
> 
> 
> >  	struct warm_boot_cpu_info info;
> >  	struct work_struct task;
> >  	int	apicid, ret;
> > +	extern u8 bios_cpu_apicid[NR_CPUS];
> 
> This should be in some header.
> 
> >
> >  	lock_cpu_hotplug();
> > -	apicid = x86_cpu_to_apicid[cpu];
> > +	apicid = bios_cpu_apicid[cpu];
> 
> Why this change? It seems unrelated.

The problem is that x86_cpu_to_apicid[] only gets set for processors
that successfully came online in do_boot_cpu():
        
        ... 
        if (boot_error) {
                /* Try to put things back the way they were before ...
*/
                unmap_cpu_to_logical_apicid(cpu);
                cpu_clear(cpu, cpu_callout_map); /* was set here
(do_boot_cpu()) */
                cpu_clear(cpu, cpu_initialized); /* was set by
cpu_init() */
                cpucount--;
        } else {
                x86_cpu_to_apicid[cpu] = apicid;
                cpu_set(cpu, cpu_present_map);
        }
        ...

And in case of the "new" CPU the "inactive" APIC ID is needed, which was
recorded in bios_cpu_apicid[].

> >  	if (apicid == BAD_APICID) {
> >  		ret = -ENODEV;
> >  		goto exit;
> > diff -puN arch/i386/mach-default/topology.c~hotcpu-i386
> > arch/i386/mach-default/topology.c ---
> > 
> linux-2.6.13-rc6-mm2/arch/i386/mach-default/topology.c~hotc
> pu-i386	2005-08-
> >31 04:17:20.957019600 -0700 +++
> > linux-2.6.13-rc6-mm2-root/arch/i386/mach-default/topology.c	
> 2005-08-31
> > 04:22:13.020619184 -0700 @@ -76,7 +76,7 @@ static int __init
> > topology_init(void)
> >  	for_each_online_node(i)
> >  		arch_register_node(i);
> >
> > -	for_each_present_cpu(i)
> > +	for_each_cpu(i)
> 
> This looks wrong. The CPUs should be in the present mask
> if it's present. Followup code similar.

I changed it from present to possible CPUS to create nodes for both
present and absent CPUs, the latter have online=0. This way we can bring
them up if they become physically available. 
 
> BTW shouldn't there be some attribute in sysfs that says
> "CPU disabled"?

I think that would be great. And maybe __cpu_up() should log a message.

> -Andi
> 
