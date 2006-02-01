Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030217AbWBACwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbWBACwW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 21:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030222AbWBACwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 21:52:22 -0500
Received: from fmr21.intel.com ([143.183.121.13]:41390 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1030217AbWBACwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 21:52:22 -0500
Date: Tue, 31 Jan 2006 18:52:09 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, mingo@elte.hu,
       nickpiggin@yahoo.com.au, ak@suse.de, linux-kernel@vger.kernel.org,
       rohit.seth@intel.com, asit.k.mallick@intel.com
Subject: Re: [Patch] sched: new sched domain for representing multi-core
Message-ID: <20060131185209.B32626@unix-os.sc.intel.com>
References: <20060126015132.A8521@unix-os.sc.intel.com> <20060127000854.GA16332@elte.hu> <20060126195156.E19789@unix-os.sc.intel.com> <20060127160019.64caa6be.akpm@osdl.org> <20060130172809.A4851@unix-os.sc.intel.com> <20060131171216.449b9e06.akpm@osdl.org> <20060131174820.A32626@unix-os.sc.intel.com> <20060131182136.665c8fe3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060131182136.665c8fe3.akpm@osdl.org>; from akpm@osdl.org on Tue, Jan 31, 2006 at 06:21:36PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2006 at 06:21:36PM -0800, Andrew Morton wrote:
> I was assuming that the code really does something like:
> 
> #ifdef CONFIG_SCHED_MC
> 		some_global_thing = <expr>
> #endif
> #ifdef CONFIG_SCHED_SMT
> 		some_global_thing = <expr>
> #endif
> 	}
> 	...
> #ifdef CONFIG_SCHED_SMT
> 	some_other_global_thing = <expr>
> #endif
> #ifdef CONFIG_SCHED_MC
> 	some_other_global_thing = <expr>
> #endif
> 
> Which, looking a bit closer, was wrong (yes?)

yes.

> 
> It is a bit irregular that in one place we do the SMT processing first and
> in another we do the MC processing first, but I guess it'll work OK.

yes. It will work Ok.

> We do need to be super-careful in the reviewing and testing here.  If we
> slip up we won't have a nice crash to tell us.  Instead we'll find that
> some machines with some configs will, under some workloads, take a few
> percent longer than they should.  We could waste people's time for years
> until some developer stumbles across something.

I have done testing with specJBB, kernel-compilation, specrate and we are
doing some testing with database workload.. I will also request our
perf team to take a stab at this.

BTW, can you also apply this experimental only patch to -mm.

--
test patch for -mm.. enable CONFIG_SCHED_MC by default in Kconfig.
on systems with no shared caches between cores, this
should help validate domain setup and degeneration code..

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>

--- linux-2.6.16-rc1/arch/i386/Kconfig	2006-01-31 16:41:38.019406000 -0800
+++ linux-core/arch/i386/Kconfig	2006-01-31 17:35:50.745916408 -0800
@@ -238,6 +238,7 @@ config SCHED_SMT
 config SCHED_MC
 	bool "Multi-core scheduler support"
 	depends on SMP
+	default y
 	help
 	  Multi-core scheduler support improves the CPU scheduler's decision 
 	  making when dealing with multi-core CPU chips at a cost of slightly 
--- linux-2.6.16-rc1/arch/x86_64/Kconfig	2006-01-31 16:41:38.021405696 -0800
+++ linux-core/arch/x86_64/Kconfig	2006-01-31 17:35:20.640493128 -0800
@@ -249,6 +249,7 @@ config SCHED_SMT
 config SCHED_MC
 	bool "Multi-core scheduler support"
 	depends on SMP
+	default y
 	help
 	  Multi-core scheduler support improves the CPU scheduler's decision 
 	  making when dealing with multi-core CPU chips at a cost of slightly 
