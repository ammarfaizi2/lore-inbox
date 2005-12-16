Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbVLPDzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbVLPDzx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 22:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbVLPDzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 22:55:53 -0500
Received: from serv01.siteground.net ([70.85.91.68]:12508 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S932112AbVLPDzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 22:55:52 -0500
Date: Thu, 15 Dec 2005 19:55:39 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>, dada1@cosmobay.com,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>
Subject: Re: [discuss] [patch 3/3] x86_64: Node local pda take 2 -- node local pda allocation
Message-ID: <20051216035539.GA3736@localhost.localdomain>
References: <20051215023345.GB3787@localhost.localdomain> <20051215023748.GD3787@localhost.localdomain> <20051215094232.GX23384@wotan.suse.de> <20051215184704.GA3882@localhost.localdomain> <20051216001934.GN23384@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051216001934.GN23384@wotan.suse.de>
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

On Fri, Dec 16, 2005 at 01:19:34AM +0100, Andi Kleen wrote:
> 
> And for the APs you allocate the PDA in smpboot.c before actually sending
> the startup IPI to the AP. 

You mean wakeup_secondary_via_INIT, called by do_boot_cpu?
That is too late. sched_init happens much earlier, and the per-cpu offset
table for all AP cpus not present is referenced, and I hit an early exception.
sched_init is executed on the BP very early and sched_init does this:

        for (i = 0; i < NR_CPUS; i++) {
                prio_array_t *array;

                rq = cpu_rq(i); 

The cpu_rq macro ends up needing per-cpu offset table stored in cpu_pda of
the AP cpus, even before we hit the code to send startup IPIs.
(#define __per_cpu_offset(cpu) (cpu_pda[cpu].data_offset))
This is way before slab is ready.  So I either use alloc_bootmem before
sched_init in setup_arch, or keep the static boot_cpu_pda.

Am I missing something?

Thanks,
Kiran
