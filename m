Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbWBRGj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbWBRGj7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 01:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbWBRGj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 01:39:59 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:63623 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750865AbWBRGj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 01:39:58 -0500
Date: Sat, 18 Feb 2006 15:38:47 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH: 003/012] Memory hotplug for new nodes v.2. (Wait table and zonelists initalization)
Cc: Andrew Morton <akpm@osdl.org>, "Luck, Tony" <tony.luck@intel.com>,
       Andi Kleen <ak@suse.de>,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       Joel Schopp <jschopp@austin.ibm.com>, linux-ia64@vger.kernel.org,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       x86-64 Discuss <discuss@x86-64.org>
In-Reply-To: <1140191398.21383.75.camel@localhost.localdomain>
References: <20060217211336.406E.Y-GOTO@jp.fujitsu.com> <1140191398.21383.75.camel@localhost.localdomain>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060218134351.105B.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
> 
> I have _not_ signed off on these patches.  I understand you based the
> initial code from one of my patches, but please remove my signed-off-by,
> as I think they code has diverged sufficiently from mine.

I see.

> > Index: pgdat3/mm/page_alloc.c
> > ===================================================================
> > --- pgdat3.orig/mm/page_alloc.c	2006-02-17 16:52:50.000000000 +0900
> > +++ pgdat3/mm/page_alloc.c	2006-02-17 18:41:52.000000000 +0900
> > @@ -37,6 +37,7 @@
> >  #include <linux/nodemask.h>
> >  #include <linux/vmalloc.h>
> >  #include <linux/mempolicy.h>
> > +#include <linux/stop_machine.h>
> >  
> >  #include <asm/tlbflush.h>
> >  #include "internal.h"
> > @@ -2077,18 +2078,35 @@ void __init setup_per_cpu_pageset(void)
> >  static __meminit
> >  void zone_wait_table_init(struct zone *zone, unsigned long zone_size_pages)
> >  {
> > -	int i;
> > +	int i, hotadd = (system_state == SYSTEM_RUNNING);
> >  	struct pglist_data *pgdat = zone->zone_pgdat;
> >  
> >  	/*
> >  	 * The per-page waitqueue mechanism uses hashed waitqueues
> >  	 * per zone.
> >  	 */
> > -	zone->wait_table_size = wait_table_size(zone_size_pages);
> > -	zone->wait_table_bits =	wait_table_bits(zone->wait_table_size);
> > -	zone->wait_table = (wait_queue_head_t *)
> > -		alloc_bootmem_node(pgdat, zone->wait_table_size
> > -					* sizeof(wait_queue_head_t));
> > +	if (hotadd){
> > +		unsigned long size = 4096UL; /* Max size */
> 
> Where does this come from?

This comes from in wait_table_size().

1656         /*
1657          * Once we have dozens or even hundreds of threads sleeping
1658          * on IO we've got bigger problems than wait queue collision.
1659          * Limit the size of the wait table to a reasonable size.
1660          */
1661         size = min(size, 4096UL);
1662 

> > +		wait_queue_head_t *p;
> > +
> > +		while (size){
> > +			p = kmalloc(size * sizeof(wait_queue_head_t),
> > +				    GFP_ATOMIC);
> > +			if (p)
> > +				break;
> > +			size >>= 1;
> > +		}
> 
> Huh?  Trying to allocate the largest wait queue that kmalloc will let
> you?
> 
> Don't we want to base the wait queue size on something devised at
> runtime?  If we make a bad guess here, how is it fixed later?

At least, could you mention how bad is biggest size?
I don't think I understand how you mind it... :-(.
Is it performance? 

The comment of wait_table_size() says that 4096 is enough size.
And I think even if one section size is 16MB, user would like to add
more memory like over 4GB. Because memory hotplug is feature for 
mission critical system. In other words, DB will require much memory.

Even if wait_table_size become variable dynamically, it doen't have
much value I think......

-- 
Yasunori Goto 


