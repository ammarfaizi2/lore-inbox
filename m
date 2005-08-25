Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751042AbVHYOlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbVHYOlr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 10:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbVHYOlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 10:41:47 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:7874 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750739AbVHYOlq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 10:41:46 -0400
Date: Thu, 25 Aug 2005 20:11:56 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, paulus@samba.org, akpm@osdl.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, mingo@elte.hu, hawkes@sgi.com
Subject: Re: [PATCH 2.6.13-rc6] cpu_exclusive sched domains build fix
Message-ID: <20050825144156.GA5194@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20050824111510.11478.49764.sendpatchset@jackhammer.engr.sgi.com> <20050824112640.GB5197@in.ibm.com> <20050824044648.66f7e25a.pj@sgi.com> <430C617E.8080002@yahoo.com.au> <20050824133107.2ca733c3.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050824133107.2ca733c3.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2005 at 01:31:07PM -0700, Paul Jackson wrote:
> ==========
> 
> The safest, mind numbingly simple thing to do that would avoid the oops
> that Hawkes reported is to simply not have the cpuset code call the
> code to setup a dynamic sched domain.  This is choice (2) above, and
> could be done at the last hour with relative safety.
> 
> Here is an untested patch that does (2):
> 
> =====
> 
> Index: linux-2.6.13-cpuset-mempolicy-migrate/kernel/cpuset.c
> ===================================================================
> --- linux-2.6.13-cpuset-mempolicy-migrate.orig/kernel/cpuset.c
> +++ linux-2.6.13-cpuset-mempolicy-migrate/kernel/cpuset.c
> @@ -627,6 +627,15 @@ static int validate_change(const struct 
>   * Call with cpuset_sem held.  May nest a call to the
>   * lock_cpu_hotplug()/unlock_cpu_hotplug() pair.
>   */
> +
> +/*
> + * Hack to avoid 2.6.13 partial node dynamic sched domain bug.
> + * Disable letting 'cpu_exclusive' cpusets define dynamic sched
> + * domains, until the sched domain can handle partial nodes.
> + * Remove this ifdef hackery when sched domains fixed.
> + */
> +#define DISABLE_EXCLUSIVE_CPU_DOMAINS 1
> +#ifdef DISABLE_EXCLUSIVE_CPU_DOMAINS
>  static void update_cpu_domains(struct cpuset *cur)
>  {
>  	struct cpuset *c, *par = cur->parent;
> @@ -667,6 +676,11 @@ static void update_cpu_domains(struct cp
>  	partition_sched_domains(&pspan, &cspan);
>  	unlock_cpu_hotplug();
>  }
> +#else
> +static void update_cpu_domains(struct cpuset *cur)
> +{
> +}
> +#endif
>  
>  static int update_cpumask(struct cpuset *cs, char *buf)
>  {
> 
> 
> =====
> 

I'll ack this for now until I fix the problems that I am seeing
on ppc64


	Acked-by: Dinakar Guniguntala <dino@in.ibm.com>


