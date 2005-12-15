Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbVLOSrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbVLOSrZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 13:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbVLOSrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 13:47:25 -0500
Received: from serv01.siteground.net ([70.85.91.68]:24246 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1750852AbVLOSrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 13:47:25 -0500
Date: Thu, 15 Dec 2005 10:47:04 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>, dada1@cosmobay.com,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>
Subject: Re: [discuss] [patch 3/3] x86_64: Node local pda take 2 -- node local pda allocation
Message-ID: <20051215184704.GA3882@localhost.localdomain>
References: <20051215023345.GB3787@localhost.localdomain> <20051215023748.GD3787@localhost.localdomain> <20051215094232.GX23384@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051215094232.GX23384@wotan.suse.de>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 10:42:32AM +0100, Andi Kleen wrote:
> On Wed, Dec 14, 2005 at 06:37:48PM -0800, Ravikiran G Thirumalai wrote:
> > Patch uses a static PDA array early at boot and reallocates processor PDA
> > with node local memory when kmalloc is ready, just before pda_init.
> > The boot_cpu_pda is needed since the cpu_pda is used even before pda_init for
> > that cpu is called.   
> > (pda_init is called when APs are brought on at rest_init().  But
> > setup_per_cpu_areas is called early in start_kernel and 
> > sched_init uses the per-cpu offset table early)
> > 
> 
> That is why I suggested to allocate it in smpboot.c in advance before
> starting the AP.  Can you please do that change? 

Maybe I am missing something, or not getting what you are suggesting;
As I see it,

asmlinkage void __init start_kernel(void)
{
	...
	...
	...
	setup_arch(&command_line);  --> (1)
	setup_per_cpu_areas();	    --> (2)
	...
	sched_init();		    --> (3)
	...
        vfs_caches_init_early();
        mem_init();
        kmem_cache_init();	    --> (4)
	...
	rest_init()		    --> (5)
}
	

I could allocate memory for pda somewhere in setup_arch after cpu_to_node is
initialized, but I would have to use alloc_bootmem_node and allocate for 
NR_CPUS, which could be wasteful.  I cannot use kmalloc_node until after (4) 
above, and sched_init refers to the per-cpu offset table before that.

So are you suggesting I use alloc_bootmem_node and allocate PDA for
NR_CPUS?

