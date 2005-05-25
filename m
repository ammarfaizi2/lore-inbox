Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261388AbVEYWRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbVEYWRb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 18:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261574AbVEYWRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 18:17:31 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:43257 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261388AbVEYWRY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 18:17:24 -0400
Message-ID: <4294F948.20004@us.ibm.com>
Date: Wed, 25 May 2005 15:16:40 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shaohua Li <shaohua.li@intel.com>
CC: Ashok Raj <ashok.raj@intel.com>, ak@muc.de, akpm <akpm@osdl.org>,
       zwane <zwane@arm.linux.org.uk>, rusty@rustycorp.com.au,
       vatsa@in.ibm.com, lkml <linux-kernel@vger.kernel.org>,
       discuss@x86-64.org
Subject: Re: [patch 0/4] CPU Hotplug support for X86_64
References: <20050524081113.409604000@csdlinux-2.jf.intel.com> <1116927099.3827.2.camel@linux-hp.sh.intel.com>
In-Reply-To: <1116927099.3827.2.camel@linux-hp.sh.intel.com>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shaohua Li wrote:
> On Tue, 2005-05-24 at 01:11 -0700, Ashok Raj wrote:
> 
>>TBD: 
>>
>>1. Track down CONFIG_SCHED_SMT Oops with both cpu up/down.
>>2. Test on real NUMA hw. 
>>
> 
> With below patch, cpu hotplug works with SCHED_SMT enabled in my test.
> set_cpu_sibling_map is invoked before cpu is set to online.
> 
> Thanks,
> Shaohua

I'm not sure, but you probably want "for_each_cpu(i)" instead of "for (i =
0; i < NR_CPUS; i++)" below.

It should be rare that you really want to explicitly itterate over
[0..NR_CPUS] cpus.  for_each_cpu() will itterate over all "possible" cpus,
which may well be [0..NR_CPUS], but it at least is cleaner and more
readable.  If your arch actually sets up cpu_possible_map correctly, then
it will likely be quite a bit faster and more efficient to use for_each_cpu().

Again, I haven't looked at the surrounding code, but it's very likely that
for_each_cpu() will do what you want.

-Matt


> --- a/arch/x86_64/kernel/smpboot.c.orig	2005-05-24 16:47:57.000000000 +0800
> +++ b/arch/x86_64/kernel/smpboot.c	2005-05-24 16:48:31.000000000 +0800
> @@ -443,7 +443,7 @@ set_cpu_sibling_map(int cpu)
>  	int i;
>  
>  	if (smp_num_siblings > 1) {
> -		for_each_online_cpu(i) {
> +		for (i = 0; i < NR_CPUS; i++) {
>  			if (cpu_core_id[cpu] == cpu_core_id[i]) {
>  				cpu_set(i, cpu_sibling_map[cpu]);
>  				cpu_set(cpu, cpu_sibling_map[i]);
> @@ -454,7 +454,7 @@ set_cpu_sibling_map(int cpu)
>  	}
>  
>  	if (current_cpu_data.x86_num_cores > 1) {
> -		for_each_online_cpu(i) {
> +		for (i = 0; i < NR_CPUS; i++) {
>  			if (phys_proc_id[cpu] == phys_proc_id[i]) {
>  				cpu_set(i, cpu_core_map[cpu]);
>  				cpu_set(cpu, cpu_core_map[i]);
