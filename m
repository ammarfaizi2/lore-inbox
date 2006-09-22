Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbWIVCVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbWIVCVu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 22:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbWIVCVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 22:21:50 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:46031 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932209AbWIVCVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 22:21:48 -0400
Date: Fri, 22 Sep 2006 11:24:27 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: kmannth@us.ibm.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, clameter@engr.sgi.com
Subject: Re: [BUG] i386 2.6.18 cpu_up: attempt to bring up CPU 4 failed :
 kernel BUG at mm/slab.c:2698!
Message-Id: <20060922112427.d5f3aef6.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <1158888843.5657.44.camel@keithlap>
References: <1158884252.5657.38.camel@keithlap>
	<20060921174134.4e0d30f2.akpm@osdl.org>
	<1158888843.5657.44.camel@keithlap>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2006 18:34:03 -0700
keith mannthey <kmannth@us.ibm.com> wrote:

> That unhappy caller in the chain is cpuup_callback in mm/slab.c.  I am
> still working out as to why, there is a lot going on if this function. 
> 
> > b) pageset_cpuup_callback()'s CPU_UP_CANCELED path possibly hasn't been
> >    tested before.  I'd be guessing that we're not zeroing out the
> >    zone.pageset[] array when the `struct zone' is first allocated, but I
> >    don't immediately recall where that code lives.
> 

How about here ?
== at boot time in mm/page_alloc.c ==
free_area_init_core()
	->zone_pcp_init(zone);
        for (cpu = 0; cpu < NR_CPUS; cpu++) {
#ifdef CONFIG_NUMA
                /* Early boot. Slab allocator not functional yet */
                zone_pcp(zone, cpu) = &boot_pageset[cpu];
                setup_pageset(&boot_pageset[cpu],0);
#else
                setup_pageset(zone_pcp(zone,cpu), batch);
#endif
        }
==================

Not zero-cleared.

-Kame

