Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264569AbUFJJsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264569AbUFJJsj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 05:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264551AbUFJJqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 05:46:30 -0400
Received: from aun.it.uu.se ([130.238.12.36]:38629 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S264569AbUFJJRq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 05:17:46 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16584.9947.222378.506457@alkaid.it.uu.se>
Date: Thu, 10 Jun 2004 11:16:11 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6.7-rc3-mm1] perfctr cpumask cleanup
In-Reply-To: <20040609154750.241df741.pj@sgi.com>
References: <200406092050.i59KoWoa000621@alkaid.it.uu.se>
	<20040609154750.241df741.pj@sgi.com>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson writes:
 > > Clean up perfctr/virtual by using the new cpus_andnot() operation
 > 
 > Neat.
 > 
 > Do you still need "tmp" ?  Perhaps you could further add the
 > following patch (untested, unbuilt, ...).
 > 
 > This saves copies and stack space for one cpumask (that's
 > 512 bits on my SN2 systems).
 > 
 > Signed-off-by: Paul Jackson <pj@sgi.com>
 > 
 > Index: 2.6.7-rc3-mm1/drivers/perfctr/virtual.c
 > ===================================================================
 > --- 2.6.7-rc3-mm1.orig/drivers/perfctr/virtual.c	2004-06-09 15:34:34.000000000 -0700
 > +++ 2.6.7-rc3-mm1/drivers/perfctr/virtual.c	2004-06-09 15:38:32.000000000 -0700
 > @@ -403,11 +403,10 @@
 >  		return -EFAULT;
 >  
 >  	if (control.cpu_control.nractrs || control.cpu_control.nrictrs) {
 > -		cpumask_t tmp, old_mask, new_mask;
 > +		cpumask_t old_mask, new_mask;
 >  
 > -		tmp = perfctr_cpus_forbidden_mask;
 >  		old_mask = tsk->cpus_allowed;
 > -		cpus_andnot(new_mask, old_mask, tmp);
 > +		cpus_andnot(new_mask, old_mask, perfctr_cpus_forbidden_mask);

Doesn't work because cpus_andnot() requires all three parameters
to be lvalues. In UP and PowerPC builds, perfctr_cpus_forbidden_mask
is #define:d to CPU_MASK_NONE to allow client-side optimisations.

Making it always be a variable will slow down UP and PowerPC with
unoptimisable cpumask tests; alternatively I'll have to wrap my
cpumask uses with optimisation macros and/or #ifdefs.

/Mikael
