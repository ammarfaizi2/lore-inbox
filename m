Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932266AbWIVEJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbWIVEJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 00:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbWIVEJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 00:09:56 -0400
Received: from mx4.cs.washington.edu ([128.208.4.190]:58018 "EHLO
	mx4.cs.washington.edu") by vger.kernel.org with ESMTP
	id S932266AbWIVEJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 00:09:55 -0400
Date: Thu, 21 Sep 2006 21:09:48 -0700 (PDT)
From: David Rientjes <rientjes@cs.washington.edu>
To: Andrew Morton <akpm@osdl.org>
cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, kmannth@us.ibm.com,
       linux-kernel@vger.kernel.org, clameter@engr.sgi.com
Subject: Re: [BUG] i386 2.6.18 cpu_up: attempt to bring up CPU 4 failed :
 kernel BUG at mm/slab.c:2698!
In-Reply-To: <20060921204629.49caa95f.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64N.0609212108360.30543@attu1.cs.washington.edu>
References: <1158884252.5657.38.camel@keithlap> <20060921174134.4e0d30f2.akpm@osdl.org>
 <1158888843.5657.44.camel@keithlap> <20060922112427.d5f3aef6.kamezawa.hiroyu@jp.fujitsu.com>
 <20060921200806.523ce0b2.akpm@osdl.org> <20060922123045.d7258e13.kamezawa.hiroyu@jp.fujitsu.com>
 <20060921204629.49caa95f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2006, Andrew Morton wrote:

> On Fri, 22 Sep 2006 12:30:45 +0900
> KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
> 
> > Before kfree(), we should check zone_pcp() is not boot_pageset[].
> > 
> > Signed-Off-By KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
> > 
> > Index: linux-2.6.18/mm/page_alloc.c
> > ===================================================================
> > --- linux-2.6.18.orig/mm/page_alloc.c	2006-09-20 12:42:06.000000000 +0900
> > +++ linux-2.6.18/mm/page_alloc.c	2006-09-22 12:22:03.000000000 +0900
> > @@ -1844,9 +1844,11 @@
> >  
> >  	for_each_zone(zone) {
> >  		struct per_cpu_pageset *pset = zone_pcp(zone, cpu);
> > -
> > -		zone_pcp(zone, cpu) = NULL;
> > -		kfree(pset);
> > +		/* When canceled, zone_pcp still points to boot_pageset[] */
> > +		if (zone_pcp(zone, cpu) != &boot_pageset[cpu]) {
> > +			zone_pcp(zone, cpu) = NULL;
> > +			kfree(pset);
> > +		}
> >  	}
> >  }
> 
> Oh, I see what you mean.
> 
> Oh well, zeroing them all out in process_zones() will work.

The _only_ time zone_pcp is slab allocated is through process_zones().  So 
if we have an error on kmalloc_node for that zone_pcp, all previous 
allocations are freed and process_zones() fails for that cpu.

We are guaranteed that the process_zones() for cpu 0 succeeds, otherwise 
the pageset notifier isn't registered.  On CPU_UP_PREPARE for cpu 4 in 
this case, process_zones() fails because we couldn't kmalloc the 
per_cpu_pageset and we return NOTIFY_BAD.  This prints the failed message 
in the report and then CPU_UP_CANCELED is sent back to the notifier which 
attempts to kfree the zone that was never kmalloc'd.

The fix will work except for the case that zone_pcp is never set to NULL 
as it should be.

		David
