Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754424AbWK1W4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754424AbWK1W4o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 17:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755786AbWK1W4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 17:56:44 -0500
Received: from mga05.intel.com ([192.55.52.89]:34217 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1754424AbWK1W4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 17:56:43 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,471,1157353200"; 
   d="scan'208"; a="170214044:sNHT26405806"
Date: Tue, 28 Nov 2006 14:31:46 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, mm-commits@vger.kernel.org,
       ak@suse.de, ashok.raj@intel.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] genapic: default to physical mode on hotplug CPU kernels
Message-ID: <20061128143145.B16460@unix-os.sc.intel.com>
References: <200611140109.kAE19f5e014490@shell0.pdx.osdl.net> <20061127141849.A9978@unix-os.sc.intel.com> <20061128063345.GA19523@elte.hu> <20061128111414.A16460@unix-os.sc.intel.com> <20061128202322.GA29334@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20061128202322.GA29334@elte.hu>; from mingo@elte.hu on Tue, Nov 28, 2006 at 09:23:22PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2006 at 09:23:22PM +0100, Ingo Molnar wrote:
> 
> * Siddha, Suresh B <suresh.b.siddha@intel.com> wrote:
> 
> > On Tue, Nov 28, 2006 at 07:33:46AM +0100, Ingo Molnar wrote:
> > > -	if (clusters <= 1 && max_cluster <= 8 && cluster_cnt[0] == max_cluster)
> > > +	if (max_apic < 8)
> > 
> > Patch mostly looks good.  Instead of checking for max_apic, can we use
> > 	cpus_weight(cpu_possible_map) <= 8
> 
> ok - but i think it's still possible the BIOS tells us APIC IDs that are 
> larger than 7, even if there are fewer CPUs. So i think the patch below 
> should cover it. Agreed?
> 

I think it is ok to use flat mode even when APIC IDs are larger than 7, as
we rely on LDR's which are programmed using smp_processor_id().

IMO, cpus_weight check should be fine.

thanks,
suresh

> 	Ingo
> 
> -------------------->
> From: Ingo Molnar <mingo@elte.hu>
> Subject: [patch] genapic: default to physical mode on hotplug CPU kernels
> 
> default to physical mode on hotplug CPU kernels.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> 
> Index: linux/arch/x86_64/kernel/genapic.c
> ===================================================================
> --- linux.orig/arch/x86_64/kernel/genapic.c
> +++ linux/arch/x86_64/kernel/genapic.c
> @@ -51,7 +51,7 @@ void __init clustered_apic_check(void)
>  			max_apic = id;
>  	}
>  
> -	if (max_apic < 8)
> +	if (max_apic < 8 && cpus_weight(cpu_possible_map) <= 8)
>  		genapic = &apic_flat;
>  	else
>  		genapic = &apic_physflat;
