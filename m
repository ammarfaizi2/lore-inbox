Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161195AbWI2AW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161195AbWI2AW0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 20:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161196AbWI2AW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 20:22:26 -0400
Received: from ozlabs.org ([203.10.76.45]:46998 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1161195AbWI2AWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 20:22:25 -0400
Subject: Re: [PATCH 0/6] Per-processor private data areas for i386
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <451ADEE4.4010508@goop.org>
References: <20060925184540.601971833@goop.org>
	 <20060927194600.GA4538@ucw.cz>  <451ADEE4.4010508@goop.org>
Content-Type: text/plain
Date: Fri, 29 Sep 2006 10:22:22 +1000
Message-Id: <1159489343.6241.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-27 at 13:28 -0700, Jeremy Fitzhardinge wrote:
> Pavel Machek wrote:
> > So we have 4% slowdown...
> >   
> 
> Yes, that would be the worst-case slowdown in the hot-cache case.  
> Rearranging the layout of the GDT would remove any theoretical 
> cold-cache slowdown (I haven't measured if there's any impact in practice).
>
> Rusty has also done more comprehensive benchmarks with his variant of 
> this patch series, and found no statistically interesting performance 
> difference.  Which is pretty much what I would expect, since it doesn't 
> increase cache-misses at all.

OK, here are my null-syscall results.  This is on a Intel(R) Pentium(R)
4 CPU 3.00GHz (stepping 9), single processor (SMP kernel).  

I did three sets of tests: before, with saving/restoring %gs, with using
%gs for per-cpu vars and current and smp_processor_id().

Before:
swarm5.0:Simple syscall: 0.3734 microseconds
swarm5.1:Simple syscall: 0.3734 microseconds
swarm5.2:Simple syscall: 0.3734 microseconds
swarm5.3:Simple syscall: 0.3734 microseconds

With saving/restoring %gs: (per-cpu was same)
swarm5.4:Simple syscall: 0.3801 microseconds
swarm5.5:Simple syscall: 0.3801 microseconds
swarm5.6:Simple syscall: 0.3804 microseconds
swarm5.7:Simple syscall: 0.3801 microseconds

That's a 6.5ns cost for saving and restoring gs, and other lmbench
syscall benchmarks reflected similar differences where the noise didn't
overwhelm them.

On kernbench, the differences were in the noise.

Strangely, I see a 4% drop on fork+exec when I used gs for per-cpu vars,
which I am now investigating (71.0831 usec before, 71.1725 usec with
saving, 73.7458 usec with per-cpu!).

Cheers,
Rusty.
-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

