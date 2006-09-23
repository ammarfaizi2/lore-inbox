Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751032AbWIWFTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbWIWFTd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 01:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbWIWFTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 01:19:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56039 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751031AbWIWFTc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 01:19:32 -0400
Date: Fri, 22 Sep 2006 22:19:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: kmannth@us.ibm.com
Cc: David Rientjes <rientjes@cs.washington.edu>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       lkml <linux-kernel@vger.kernel.org>, clameter@engr.sgi.com
Subject: Re: [BUG] i386 2.6.18 cpu_up: attempt to bring up CPU 4 failed :
 kernel BUG at mm/slab.c:2698!
Message-Id: <20060922221923.1a7979f1.akpm@osdl.org>
In-Reply-To: <1158954258.7292.6.camel@keithlap>
References: <1158884252.5657.38.camel@keithlap>
	<20060921174134.4e0d30f2.akpm@osdl.org>
	<1158888843.5657.44.camel@keithlap>
	<20060922112427.d5f3aef6.kamezawa.hiroyu@jp.fujitsu.com>
	<20060921200806.523ce0b2.akpm@osdl.org>
	<20060922123045.d7258e13.kamezawa.hiroyu@jp.fujitsu.com>
	<20060921204629.49caa95f.akpm@osdl.org>
	<Pine.LNX.4.64N.0609212108360.30543@attu1.cs.washington.edu>
	<1158954258.7292.6.camel@keithlap>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2006 12:44:18 -0700
keith mannthey <kmannth@us.ibm.com> wrote:

> 3. Flat mode i386 numa on a real numa system is broken.  If there is
> only 1 node in the system cpus should think they are apart of some other
> node.     Patch below.  
> 
> 
> 
>   If cases where a real numa system boots the Flat numa option make sure
> the cpus don't claim to be apart on a non-existent node.
> 
> 
> Signed-off-by: Keith Mannthey <kmannth@us.ibm.com>
> 
> --- linux-2.6.18/arch/i386/kernel/smpboot.c	2006-09-19
> 20:42:06.000000000 -0700
> +++ linux-2.6.18-workes/arch/i386/kernel/smpboot.c	2006-09-21
> 21:57:55.000000000 -0700
> @@ -642,9 +642,13 @@
>  {
>  	int cpu = smp_processor_id();
>  	int apicid = logical_smp_processor_id();
> -
> +	int node = apicid_to_node(apicid);
> +	
> +	if (!node_online(node))
> +		node = first_online_node;
> +	
>  	cpu_2_logical_apicid[cpu] = apicid;
> -	map_cpu_to_node(cpu, apicid_to_node(apicid));
> +	map_cpu_to_node(cpu, node);
>  }
>  
>  static void unmap_cpu_to_logical_apicid(int cpu)

This clashes with your
convert-i386-summit-subarch-to-use-srat-info-for-apicid_to_node-calls.patch.

I fixed it thusly:

static void map_cpu_to_logical_apicid(void)
{
	int cpu = smp_processor_id();
	int apicid = logical_smp_processor_id();
	int node = apicid_to_node(hard_smp_processor_id());

	if (!node_online(node))
		node = first_online_node;

	cpu_2_logical_apicid[cpu] = apicid;
	map_cpu_to_node(cpu, node);
}


