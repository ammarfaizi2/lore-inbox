Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261843AbVECWDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbVECWDh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 18:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbVECWDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 18:03:37 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:507 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261843AbVECWD2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 18:03:28 -0400
Message-ID: <4277F52B.8040908@us.ibm.com>
Date: Tue, 03 May 2005 15:03:23 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dino@in.ibm.com
CC: Paul Jackson <pj@sgi.com>, Simon Derr <Simon.Derr@bull.net>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       lkml <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Dipankar Sarma <dipankar@in.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC PATCH] Dynamic sched domains (v0.5)
References: <20050501190947.GA5204@in.ibm.com>
In-Reply-To: <20050501190947.GA5204@in.ibm.com>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dinakar Guniguntala wrote:
> Ok, Here is the minimal patchset that I had promised after the
> last discussion.
> 
> What it does have
> o  The current patch enhances the meaning of exclusive cpusets by
>    attaching them (exclusive cpusets) to sched domains
> o  It does _not_ require any additional cpumask_t variable. It
>    just parses the cpus_allowed of the parent/sibling/children
>    cpusets for manipulating sched domains
> o  All existing operations on non-/exclusive cpusets are preserved as-is.
> o  The sched code has been modified to bring it upto 2.6.12-rc2-mm3
> 
> Usage
> o  On setting the cpu_exclusive flag of a cpuset X, it creates two
>    sched domains
>    a. One, All cpus from X's parent cpuset that dont belong to any
>       exclusive sibling cpuset of X
>    b. Two, All cpus in X's cpus_allowed
> o  On adding/deleting cpus to/from a exclusive cpuset X that has exclusive
>    children, it creates two sched domains
>    a. One, All cpus from X's parent cpuset that dont belong to any
>       exclusive sibling cpuset of X
>    b. Two, All cpus in X's cpus_allowed, after taking away any cpus that
>       belong to exclusive child cpusets of X
> o  On unsetting the cpu_exclusive flag of cpuset X or rmdir X, it creates a
>    single sched domain, containing all cpus from X' parent cpuset that
>    dont belong to any exclusive sibling of X and the cpus of X
> o  It does _not_ modify the cpus_allowed variable of the parent as in the
>    previous version. It relies on user space to move tasks to proper
>    cpusets for complete isolation/exclusion
> o  See function update_cpu_domains for more details
> 
> What it does not have
> o  It is still short on documentation
> o  Does not have hotplug support as yet
> o  Supports only x86 as of now
> o  No thoughts on "memory domains" (Though I am not sure, who
>    would use such a thing and what exactly are the requirements)

An interesting feature.  I tried a while ago to get cpusets and
sched_domains to play nice (nicer?) and didn't have much luck.  It seems
you're taking a better approach, with smaller patches.  Good luck!


> diff -Naurp linux-2.6.12-rc2.orig/include/linux/init.h linux-2.6.12-rc2/include/linux/init.h
> --- linux-2.6.12-rc2.orig/include/linux/init.h	2005-04-04 22:07:52.000000000 +0530
> +++ linux-2.6.12-rc2/include/linux/init.h	2005-05-01 22:07:56.000000000 +0530
> @@ -217,7 +217,7 @@ void __init parse_early_param(void);
>  #define __initdata_or_module __initdata
>  #endif /*CONFIG_MODULES*/
>  
> -#ifdef CONFIG_HOTPLUG
> +#if defined(CONFIG_HOTPLUG) || defined(CONFIG_CPUSETS)
>  #define __devinit
>  #define __devinitdata
>  #define __devexit

This looks just plain wrong.  Why do you need this?  It doesn't seem that
arch_init_sched_domains() and/or update_sched_domains() are called from
anywhere that is cpuset related, so why the #ifdef CONFIG_CPUSETS?


> diff -Naurp linux-2.6.12-rc2.orig/kernel/sched.c linux-2.6.12-rc2/kernel/sched.c
> --- linux-2.6.12-rc2.orig/kernel/sched.c	2005-04-28 18:24:11.000000000 +0530
> +++ linux-2.6.12-rc2/kernel/sched.c	2005-05-01 22:06:55.000000000 +0530
> @@ -4526,7 +4526,7 @@ int __init migration_init(void)
>  #endif
>  
>  #ifdef CONFIG_SMP
> -#define SCHED_DOMAIN_DEBUG
> +#undef SCHED_DOMAIN_DEBUG
>  #ifdef SCHED_DOMAIN_DEBUG
>  static void sched_domain_debug(struct sched_domain *sd, int cpu)
>  {

Is this just to quiet boot for your testing?  Is there are better reason
you're turning this off?  It seems unrelated to the rest of your patch.


> ------------------------------------------------------------------------
> 
> diff -Naurp linux-2.6.12-rc2.orig/kernel/cpuset.c linux-2.6.12-rc2/kernel/cpuset.c
> --- linux-2.6.12-rc2.orig/kernel/cpuset.c	2005-04-28 18:24:11.000000000 +0530
> +++ linux-2.6.12-rc2/kernel/cpuset.c	2005-05-01 22:15:06.000000000 +0530
> @@ -602,12 +602,48 @@ static int validate_change(const struct 
>  	return 0;
>  }
>  
> +static void update_cpu_domains(struct cpuset *cur)
> +{
> +	struct cpuset *c, *par = cur->parent;
> +	cpumask_t span1, span2;
> +
> +	if (par == NULL || cpus_empty(cur->cpus_allowed))
> +		return;
> +
> +	/* Get all non-exclusive cpus from parent domain */
> +	span1 = par->cpus_allowed;
> +	list_for_each_entry(c, &par->children, sibling) {
> +		if (is_cpu_exclusive(c))
> +			cpus_andnot(span1, span1, c->cpus_allowed);
> +	}
> +	if (is_removed(cur) || !is_cpu_exclusive(cur)) {
> +		cpus_or(span1, span1, cur->cpus_allowed);
> +		if (cpus_equal(span1, cur->cpus_allowed))
> +			return;
> +		span2 = CPU_MASK_NONE;
> +	}
> +	else {
> +		if (cpus_empty(span1))
> +			return;
> +		span2 = cur->cpus_allowed;
> +		/* If current cpuset has exclusive children, exclude from domain */
> +		list_for_each_entry(c, &cur->children, sibling) {
> +			if (is_cpu_exclusive(c))
> +				cpus_andnot(span2, span2, c->cpus_allowed);
> +		}
> +	}
> +
> +	lock_cpu_hotplug();
> +	rebuild_sched_domains(span1, span2);
> +	unlock_cpu_hotplug();
> +}

Nitpicky, but span1 and span2 could do with better names.

Otherwise, the patch looks good to me.

-Matt
