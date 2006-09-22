Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbWIVDiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbWIVDiQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 23:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbWIVDiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 23:38:16 -0400
Received: from mx1.cs.washington.edu ([128.208.5.52]:26036 "EHLO
	mx1.cs.washington.edu") by vger.kernel.org with ESMTP
	id S932253AbWIVDiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 23:38:15 -0400
Date: Thu, 21 Sep 2006 20:38:07 -0700 (PDT)
From: David Rientjes <rientjes@cs.washington.edu>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
cc: Andrew Morton <akpm@osdl.org>, kmannth@us.ibm.com,
       linux-kernel@vger.kernel.org, clameter@engr.sgi.com
Subject: Re: [BUG] i386 2.6.18 cpu_up: attempt to bring up CPU 4 failed :
 kernel BUG at mm/slab.c:2698!
In-Reply-To: <20060922123045.d7258e13.kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.64N.0609212033420.9396@attu3.cs.washington.edu>
References: <1158884252.5657.38.camel@keithlap> <20060921174134.4e0d30f2.akpm@osdl.org>
 <1158888843.5657.44.camel@keithlap> <20060922112427.d5f3aef6.kamezawa.hiroyu@jp.fujitsu.com>
 <20060921200806.523ce0b2.akpm@osdl.org> <20060922123045.d7258e13.kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2006, KAMEZAWA Hiroyuki wrote:

> Index: linux-2.6.18/mm/page_alloc.c
> ===================================================================
> --- linux-2.6.18.orig/mm/page_alloc.c	2006-09-20 12:42:06.000000000 +0900
> +++ linux-2.6.18/mm/page_alloc.c	2006-09-22 12:22:03.000000000 +0900
> @@ -1844,9 +1844,11 @@
>  
>  	for_each_zone(zone) {
>  		struct per_cpu_pageset *pset = zone_pcp(zone, cpu);
> -
> -		zone_pcp(zone, cpu) = NULL;
> -		kfree(pset);
> +		/* When canceled, zone_pcp still points to boot_pageset[] */
> +		if (zone_pcp(zone, cpu) != &boot_pageset[cpu]) {
> +			zone_pcp(zone, cpu) = NULL;
> +			kfree(pset);
> +		}
>  	}
>  }
>  

Regardless of whether the zone's per_cpu_pageset was set before the slab 
allocator came up or not, it still needs to be NULL before returning from 
here.  Only when it is allocated through kmalloc_node does it need kfree, 
however.

		David
