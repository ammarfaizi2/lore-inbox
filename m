Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbWGGRQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWGGRQV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 13:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbWGGRQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 13:16:21 -0400
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:22200 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932200AbWGGRQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 13:16:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=mdiLFaiZ/ubnPQa4cfQaVUAHa3Eqv0KFy6VZKhpFNQBiXzcUaZoDIEvf5aWHAVRDDvx4gakOOxb3LVUU9tQFJAmOZOy+Sczi/8WGeXdH1j6PnIYOQHX7HfEEXQQcjH4SXzy1sCnlqLYkYup2hYtrBk/RCdBwFHpWMrRGQ+NOYGw=  ;
Message-ID: <44AE1D89.20608@yahoo.com.au>
Date: Fri, 07 Jul 2006 18:38:33 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: hawkes@sgi.com
CC: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Jack Steiner <steiner@sgi.com>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org, John Hawkes <jrhawkes@yahoo.com>
Subject: Re: [PATCH] build sched domains tracking cpusets
References: <20060706234356.23106.60834.sendpatchset@tomahawk.engr.sgi.com>
In-Reply-To: <20060706234356.23106.60834.sendpatchset@tomahawk.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

cool patch. I have a few comments.

hawkes@sgi.com wrote:

> This patch introduces the notion of dynamic sched domains (and sched
> groups) that track the creation and deletion of cpusets.  Up to eight of
> these dynamic sched domains can exist per CPU, which seems to handle the
> observed use of cpusets by one popular job manager.  Essentially, every
> new cpuset causes the creation of a new sched domain for the CPUs of
> that cpuset, and a deletion of the cpuset causes the destruction of that
> dynamic sched domain.  New sched domains are inserted into each CPU's
> list as appropriate.  The limit of 8/CPU (vs. unlimited) not only caps
> the upperbound of kmalloc memory being assigned to sched domain and
> sched group structs (thereby avoiding a potential denial-of-service
> attack by a runaway user creating cpusets), but it also caps the number
> of sched domains being searched by various algorithms in the scheduler.



> 
> A "feature" of this implementation is that these dynamic sched domains
> build up until that limit of 8/CPU is reached, at which point no
> additional sched domains are created; or until a cpu-exclusive cpuset
> gets declared, at which point all the dynamically created sched domains
> in the affected CPUs get destroyed.  A more sophisticated algorithm in
> kernel/cpuset.c could redeclare the dynamic sched domains after a
> cpu-exclusive cpuset gets declared, but that is outside the scope of
> this simple patch's simple change to kernel/cpuset.c.
> 
> Signed-off-by: John Hawkes <hawkes@sgi.com>
> 
> Index: linux/include/linux/sched.h
> ===================================================================
> --- linux.orig/include/linux/sched.h	2006-06-17 18:49:35.000000000 -0700
> +++ linux/include/linux/sched.h	2006-06-20 13:50:19.092284572 -0700
> @@ -558,6 +558,7 @@ enum idle_type
>  #define SD_WAKE_AFFINE		32	/* Wake task to waking CPU */
>  #define SD_WAKE_BALANCE		64	/* Perform balancing at task wakeup */
>  #define SD_SHARE_CPUPOWER	128	/* Domain members share cpu power */
> +#define SD_TRACKS_CPUSET	4096	/* Spam matches non-exclusive cpuset */

I'd just use the next bit, and we should convert these to hex as
well I guess... I don't know what I was thinking ;)

>  
>  struct sched_group {
>  	struct sched_group *next;	/* Must be a circular list */
> @@ -630,6 +631,9 @@ struct sched_domain {
>  extern void partition_sched_domains(cpumask_t *partition1,
>  				    cpumask_t *partition2);
>  
> +extern void add_sched_domain(const cpumask_t *cpu_map);
> +extern void destroy_sched_domain(const cpumask_t *cpu_map);

Not a big deal, but I'd probably be happier with a single hook from
the cpusets code, which does the right thing depending on whether it
is exclusive or not.

Hard to know which way around the layering should go, but I think that
it is simply a hint to the balancer code to do something nice, and as
such we should leave it completely to the scheduler.

> +#ifdef CONFIG_CPUSETS

CPUSETS only? Or do we want to try to help sched_setaffinity users as
well?

> +
> +struct sched_domain_bundle {
> +	struct sched_domain sd_cpuset;
> +	struct sched_group **sg_cpuset_nodes;
> +	int use_count;
> +};

Can you get away without using the bundle? Or does it make things easier?
You could add a new use_count to struct sched_domain if you'd like.... does
it make the setup/teardown too difficult?

> +#define SCHED_DOMAIN_CPUSET_MAX	8	/* power of 2 */
> +static DEFINE_PER_CPU(long, sd_cpusets_used) = { 1UL <<SCHED_DOMAIN_CPUSET_MAX};
> +static DEFINE_PER_CPU(struct sched_domain_bundle[SCHED_DOMAIN_CPUSET_MAX],
> +		      sd_cpusets_bundle);

Do we need a limit of 8? If you're worried about memory, I guess there are
lots of ways to DOS the system... if you're worried about scheduler balancing
overhead, we could do a seperate traversal of these guys at a reduced
interval (I guess that still leaves some places needing help, though)

> +static int find_existing_sched_domain(int cpu, const cpumask_t *cpu_map)

Probably some way to distinguish these guys as operating on your "bundle" stack
would make it a bit clearer?

> +{
> +	int sd_idx;
> +
> +	for (sd_idx = 0; sd_idx < SCHED_DOMAIN_CPUSET_MAX; sd_idx++) {
> +		struct sched_domain_bundle *sd_cpuset_bundle;
> +		struct sched_domain *sd;
> +
> +		if (!test_bit(sd_idx, &per_cpu(sd_cpusets_used, cpu)))
> +			continue;
> +		sd_cpuset_bundle = &per_cpu(sd_cpusets_bundle[sd_idx], cpu);
> +		sd = &sd_cpuset_bundle->sd_cpuset;
> +		if (cpus_equal(*cpu_map, sd->span))
> +			return sd_idx;
> +	}
> +
> +	return SCHED_DOMAIN_CPUSET_MAX;
> +}
> +
> +void add_sched_domain(const cpumask_t *cpu_map)
> +{

[...]

> +		/* tweak sched_domain params based upon domain size */
> +		*sd = SD_NODE_INIT;
> +		sd->flags |= SD_TRACKS_CPUSET;
> +		sd->max_interval = 8*(min(new_sd_span, 32));
> +		sd->span = *cpu_map;
> +		cpu_set(cpu, new_sd_cpu_map);

Can we just have a new SD_xxx_INIT for these?


> Index: linux/kernel/cpuset.c
> ===================================================================
> --- linux.orig/kernel/cpuset.c	2006-07-05 15:51:38.873939805 -0700
> +++ linux/kernel/cpuset.c	2006-07-05 16:01:14.892039725 -0700
> @@ -828,8 +828,12 @@ static int update_cpumask(struct cpuset 
>  	mutex_lock(&callback_mutex);
>  	cs->cpus_allowed = trialcs.cpus_allowed;
>  	mutex_unlock(&callback_mutex);
> -	if (is_cpu_exclusive(cs) && !cpus_unchanged)
> -		update_cpu_domains(cs);
> +	if (!cpus_unchanged) {
> +		if (is_cpu_exclusive(cs))
> +			update_cpu_domains(cs);
> +		else
> +			add_sched_domain(&cs->cpus_allowed);
> +	}
>  	return 0;
>  }
>  
> @@ -1934,6 +1938,8 @@ static int cpuset_rmdir(struct inode *un
>  	set_bit(CS_REMOVED, &cs->flags);
>  	if (is_cpu_exclusive(cs))
>  		update_cpu_domains(cs);
> +	else
> +		destroy_sched_domain(&cs->cpus_allowed);
>  	list_del(&cs->sibling);	/* delete my sibling from parent->children */
>  	spin_lock(&cs->dentry->d_lock);
>  	d = dget(cs->dentry);
> 

So you're just doing the inside. What about the complement? That
way you'd get a nice symmetric allocation on all cpus for each
cpuset... but that probably would require making the limit greater
than 8.

And it would be probably required for good sched_setaffinity
balancing too.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
