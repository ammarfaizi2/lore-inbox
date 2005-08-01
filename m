Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262316AbVHAFY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbVHAFY2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 01:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262298AbVHAFXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 01:23:22 -0400
Received: from orb.pobox.com ([207.8.226.5]:26046 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262316AbVHAFWw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 01:22:52 -0400
Date: Mon, 1 Aug 2005 00:22:44 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Anton Blanchard <anton@samba.org>
Cc: lkml <linux-kernel@vger.kernel.org>, colpatch@us.ibm.com, akpm@osdl.org,
       paulus@samba.org
Subject: Re: topology api confusion
Message-ID: <20050801052244.GA3985@otto>
References: <20050722213316.GE17865@otto> <20050801050748.GB31199@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050801050748.GB31199@krispykreme>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard wrote:
> 
> Hi,
> 
> > We need some clarity on how asm-generic/topology.h is intended to be
> > used.  I suspect that it's supposed to be unconditionally included at
> > the end of the architecture's topology.h so that any elements which
> > are undefined by the arch have sensible default definitions.  Looking
> > at 2.6.13-rc3, this is what ppc64, ia64, and x86_64 currently do,
> > however i386 does not (i386 pulls in the generic version only when
> > !CONFIG_NUMA).
> > 
> > The #ifndef guards around each element of the topology api
> > cannot serve their apparent intended purpose when the architecture
> > implements a given bit as a function instead of a macro
> > (e.g. cpu_to_node in ppc64):
> 
> Since it doesnt look like this will be resolved by 2.6.13 and NUMA is
> currently completely broken on ppc64, how does this patch look?

Yes, this change is the least risk for now, thanks.

> 
> --
> 
> Dont include asm-generic/topology.h unconditionally, we end up
> overriding all the ppc64 specific functions when NUMA is on.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> 
> Index: linux-2.6.git-work/include/asm-ppc64/topology.h
> ===================================================================
> --- linux-2.6.git-work.orig/include/asm-ppc64/topology.h	2005-07-30 23:49:56.000000000 +1000
> +++ linux-2.6.git-work/include/asm-ppc64/topology.h	2005-08-01 14:43:49.000000000 +1000
> @@ -33,6 +33,7 @@
>  	return first_cpu(tmp);
>  }
>  
> +#define pcibus_to_node(node)    (-1)
>  #define pcibus_to_cpumask(bus)	(cpu_online_map)
>  
>  #define nr_cpus_node(node)	(nr_cpus_in_node[node])
> @@ -59,8 +60,10 @@
>  	.nr_balance_failed	= 0,			\
>  }
>  
> -#endif /* CONFIG_NUMA */
> +#else
>  
>  #include <asm-generic/topology.h>
>  
> +#endif /* CONFIG_NUMA */
> +
>  #endif /* _ASM_PPC64_TOPOLOGY_H */
