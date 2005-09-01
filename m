Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751005AbVIAIp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbVIAIp2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 04:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbVIAIp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 04:45:28 -0400
Received: from mx1.suse.de ([195.135.220.2]:30345 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751005AbVIAIp2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 04:45:28 -0400
From: Andi Kleen <ak@suse.de>
To: Natalie.Protasevich@unisys.com
Subject: Re: [patch 1/1] Hot plug CPU to support physical add of new processors (i386)
Date: Thu, 1 Sep 2005 10:45:10 +0200
User-Agent: KMail/1.8
Cc: shaohua.li@intel.com, zwane@arm.linux.org.uk, ashok.raj@intel.com,
       akpm@osdl.org, lhcs-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, hotplug_sig@lists.osdl.org
References: <20050831121311.5FC7C57D99@linux.site>
In-Reply-To: <20050831121311.5FC7C57D99@linux.site>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509011045.11142.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo Natalie,

On Wednesday 31 August 2005 14:13, Natalie.Protasevich@unisys.com wrote:
> Current IA32 CPU hotplug code doesn't allow bringing up processors that
> were not present in the boot configuration. To make existing hot plug
> facility more practical for physical hot plug, possible processors should
> be encountered during boot for potentual hot add/replace/remove. On ES7000,
> ACPI marks all the sockets that are empty or not assigned to the
> partitionas as "disabled". 

Good idea. In fact I always hated the behaviour of the existing
hotplug code that assumes all possible CPUs can be hotplugged.
It would be much nicer to be told be the firmware what CPUs
are hotpluggable. It would be great if all ia32/x86-64 hotplug capable 
BIOS behaved like your.


>  	struct warm_boot_cpu_info info;
>  	struct work_struct task;
>  	int	apicid, ret;
> +	extern u8 bios_cpu_apicid[NR_CPUS];

This should be in some header.

>
>  	lock_cpu_hotplug();
> -	apicid = x86_cpu_to_apicid[cpu];
> +	apicid = bios_cpu_apicid[cpu];

Why this change? It seems unrelated.

>  	if (apicid == BAD_APICID) {
>  		ret = -ENODEV;
>  		goto exit;
> diff -puN arch/i386/mach-default/topology.c~hotcpu-i386
> arch/i386/mach-default/topology.c ---
> linux-2.6.13-rc6-mm2/arch/i386/mach-default/topology.c~hotcpu-i386	2005-08-
>31 04:17:20.957019600 -0700 +++
> linux-2.6.13-rc6-mm2-root/arch/i386/mach-default/topology.c	2005-08-31
> 04:22:13.020619184 -0700 @@ -76,7 +76,7 @@ static int __init
> topology_init(void)
>  	for_each_online_node(i)
>  		arch_register_node(i);
>
> -	for_each_present_cpu(i)
> +	for_each_cpu(i)

This looks wrong. The CPUs should be in the present mask
if it's present. Followup code similar.

BTW shouldn't there be some attribute in sysfs that says
"CPU disabled"?

-Andi
