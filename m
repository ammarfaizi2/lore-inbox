Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751004AbVLBUCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbVLBUCl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 15:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbVLBUCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 15:02:41 -0500
Received: from serv01.siteground.net ([70.85.91.68]:26342 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751001AbVLBUCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 15:02:40 -0500
Date: Fri, 2 Dec 2005 12:02:34 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, shai@scalex86.org
Subject: Re: [patch 3/3] x86_64: Node local PDA -- allocate node local memory for pda
Message-ID: <20051202200234.GB3727@localhost.localdomain>
References: <20051202081028.GA5312@localhost.localdomain> <20051202082309.GC5312@localhost.localdomain> <20051202114708.GM997@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051202114708.GM997@wotan.suse.de>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2005 at 12:47:09PM +0100, Andi Kleen wrote:
> On Fri, Dec 02, 2005 at 12:23:09AM -0800, Ravikiran G Thirumalai wrote:
> > Patch uses a static PDA array early at boot and reallocates processor PDA
> > with node local memory when kmalloc is ready, just before pda_init.
> > The boot_cpu_pda is needed sice the cpu_pda is used even before pda_init for
> > that cpu is called (to set the static per-cpu areas offset table etc)
> 
> Where is it needed?  Perhaps it should be just allocated in the 
> CPU triggering the other CPU start instead. Then you could avoid that
> or rather only define a __initdata boot_pda for the BP.
>

setup_per_cpu_areas() is invoked quite early in the boot process and it
writes into the cpu_pda.data_offset field for all the cpus. I'd even tried
storing the offset table for cpus in a temporary table (which can be marked
__initdata and discarded later),  but there were references
to the static per cpu areas through per_cpu macros (which need to use the
cpu_pda) even before the BP boots up and starts the secondary cpus,
resulting in early exceptions.

> > 
> > Index: linux-2.6.15-rc3/arch/x86_64/kernel/head64.c
> > ===================================================================
> > --- linux-2.6.15-rc3.orig/arch/x86_64/kernel/head64.c	2005-11-30 17:01:18.000000000 -0800
> > +++ linux-2.6.15-rc3/arch/x86_64/kernel/head64.c	2005-11-30 17:07:14.000000000 -0800
> > @@ -80,6 +80,7 @@
> >  {
> >  	char *s;
> >  	int i;
> > +	extern struct x8664_pda boot_cpu_pda[];
> 
> externs only belong in include files.

Yes, I will change this and resubmit

Thanks,
Kiran
