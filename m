Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752007AbWAEGDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007AbWAEGDY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 01:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752009AbWAEGDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 01:03:23 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:32012 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1752010AbWAEGDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 01:03:22 -0500
Date: Thu, 5 Jan 2006 07:03:14 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch 2.6.15] i386: Optimize local APIC timer interrupt code
Message-ID: <20060105060314.GB7142@w.ods.org>
References: <200601041352_MC3-1-B550-4606@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601041352_MC3-1-B550-4606@compuserve.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 01:48:09PM -0500, Chuck Ebbert wrote:
> Local APIC timer interrupt happens HZ times per second on each CPU.
> 
> Optimize it for the case where profile multiplier equals one and does
> not change (99+% of cases); this saves about 20 CPU cycles on Pentium II.
> 
> Also update the old multiplier immediately after noticing it changed,
> while values are register-hot, saving eight bytes of stack depth.
> 
> Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
> 
> diff -up 2.6.15a.orig/arch/i386/kernel/apic.c 2.6.15a/arch/i386/kernel/apic.c
> --- 2.6.15a.orig/arch/i386/kernel/apic.c
> +++ 2.6.15a/arch/i386/kernel/apic.c
> @@ -1137,7 +1137,7 @@ inline void smp_local_timer_interrupt(st
>  	int cpu = smp_processor_id();
>  
>  	profile_tick(CPU_PROFILING, regs);
> -	if (--per_cpu(prof_counter, cpu) <= 0) {
> +	if (likely(--per_cpu(prof_counter, cpu)) <= 0) {
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
are you sure about this ? it looks suspicious to me. I would have
expected something like  this instead :

+	if (likely(--per_cpu(prof_counter, cpu) <= 0)) {

Willy

