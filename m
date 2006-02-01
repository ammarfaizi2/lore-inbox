Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964889AbWBACWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbWBACWG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 21:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964890AbWBACWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 21:22:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:52452 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964889AbWBACWE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 21:22:04 -0500
Date: Tue, 31 Jan 2006 18:21:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: suresh.b.siddha@intel.com, mingo@elte.hu, nickpiggin@yahoo.com.au,
       ak@suse.de, linux-kernel@vger.kernel.org, rohit.seth@intel.com,
       asit.k.mallick@intel.com
Subject: Re: [Patch] sched: new sched domain for representing multi-core
Message-Id: <20060131182136.665c8fe3.akpm@osdl.org>
In-Reply-To: <20060131174820.A32626@unix-os.sc.intel.com>
References: <20060126015132.A8521@unix-os.sc.intel.com>
	<20060127000854.GA16332@elte.hu>
	<20060126195156.E19789@unix-os.sc.intel.com>
	<20060127160019.64caa6be.akpm@osdl.org>
	<20060130172809.A4851@unix-os.sc.intel.com>
	<20060131171216.449b9e06.akpm@osdl.org>
	<20060131174820.A32626@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Siddha, Suresh B" <suresh.b.siddha@intel.com> wrote:
>
> On Tue, Jan 31, 2006 at 05:12:16PM -0800, Andrew Morton wrote:
>  > It's still not clear what's supposed to be happening here.
>  > 
>  > In build_sched_domains() we still have code which does:
>  > 
>  > 
>  > 	for_each_cpu_mask(...) {
>  > 		...
>  > #ifdef CONFIG_SCHED_MC
>  > 		...
>  > #endif
>  > #ifdef CONFIG_SCHED_SMT
>  > 		...
>  > #endif
>  > 		...
>  > 	}
>  > 	...
>  > #ifdef CONFIG_SCHED_SMT
>  > 	...
>  > #endif
>  > 	...
>  > #ifdef CONFIG_SCHED_MC
>  > 	...
>  > #endif
>  > 
>  > So in the first case the SCHED_SMT code will win and in the second case the
>  > SCHED_MC code will win.  I think.  
> 
>  I am not sure what you mean here. At all the above pointed places, both 
>  MC and SMT will win if both are configured.

I was assuming that the code really does something like:

#ifdef CONFIG_SCHED_MC
		some_global_thing = <expr>
#endif
#ifdef CONFIG_SCHED_SMT
		some_global_thing = <expr>
#endif
	}
	...
#ifdef CONFIG_SCHED_SMT
	some_other_global_thing = <expr>
#endif
#ifdef CONFIG_SCHED_MC
	some_other_global_thing = <expr>
#endif

Which, looking a bit closer, was wrong (yes?)

It is a bit irregular that in one place we do the SMT processing first and
in another we do the MC processing first, but I guess it'll work OK.

We do need to be super-careful in the reviewing and testing here.  If we
slip up we won't have a nice crash to tell us.  Instead we'll find that
some machines with some configs will, under some workloads, take a few
percent longer than they should.  We could waste people's time for years
until some developer stumbles across something.
