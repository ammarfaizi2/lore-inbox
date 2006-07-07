Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbWGGTF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbWGGTF0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 15:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWGGTFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 15:05:25 -0400
Received: from sccrmhc15.comcast.net ([204.127.200.85]:27362 "EHLO
	sccrmhc15.comcast.net") by vger.kernel.org with ESMTP
	id S932259AbWGGTFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 15:05:24 -0400
Message-ID: <01d101c6a1f8$47e8fa90$6500a8c0@johnhaonw7lw1r>
From: "John Hawkes" <johnhawkes3@comcast.net>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>
Cc: "Andrew Morton" <akpm@osdl.org>, "Ingo Molnar" <mingo@elte.hu>,
       "Jack Steiner" <steiner@sgi.com>, "Paul Jackson" <pj@sgi.com>,
       <linux-kernel@vger.kernel.org>, "Christoph Lameter" <clameter@sgi.com>,
       <jrhawkes@yahoo.com>
References: <20060706234356.23106.60834.sendpatchset@tomahawk.engr.sgi.com> <44AE1D89.20608@yahoo.com.au>
Subject: Re: [PATCH] build sched domains tracking cpusets
Date: Fri, 7 Jul 2006 12:05:15 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Nick Piggin" <nickpiggin@yahoo.com.au>
...
>> @@ -558,6 +558,7 @@ enum idle_type
>>  #define SD_WAKE_AFFINE 32 /* Wake task to waking CPU */
>>  #define SD_WAKE_BALANCE 64 /* Perform balancing at task wakeup */
>>  #define SD_SHARE_CPUPOWER 128 /* Domain members share cpu power */
>> +#define SD_TRACKS_CPUSET 4096 /* Spam matches non-exclusive cpuset */
>
> I'd just use the next bit, and we should convert these to hex as
> well I guess... I don't know what I was thinking ;)

Okay.

>>  struct sched_group {
>>  struct sched_group *next; /* Must be a circular list */
>> @@ -630,6 +631,9 @@ struct sched_domain {
>>  extern void partition_sched_domains(cpumask_t *partition1,
>>      cpumask_t *partition2);
>>  +extern void add_sched_domain(const cpumask_t *cpu_map);
>> +extern void destroy_sched_domain(const cpumask_t *cpu_map);
>
> Not a big deal, but I'd probably be happier with a single hook from
> the cpusets code, which does the right thing depending on whether it
> is exclusive or not.
>
> Hard to know which way around the layering should go, but I think that
> it is simply a hint to the balancer code to do something nice, and as
> such we should leave it completely to the scheduler.

Simplicity is preferable, of course.

The "isolation" semantics differs between the two cases.  None of the CPUs 
of a cpu-exclusive cpuset are present in the sched domain spans of the 
remaining non-exclusive CPUs, whereas the CPUs of a newly declared 
non-exclusive cpuset are still present in the sched domain spans of the 
other non-exclusive CPUs.  The idea of this patch is that creating a 
non-exclusive cpuset is more of a hint to the scheduler (by way of the sched 
domains) that the CPUs of a cpuset ought to load-balance internally, but not 
go all the way to having this new non-exclusive cpuset be totally isolated 
from the rest of the herd.

One problem with isolation is that declaring a cpu-exclusive cpuset doesn't 
automatically migrate away all the tasks that currently reside in one of the 
now-isolated CPUs.  If we always carve up CPUs of cpusets into isolated 
sched domains, then I fear we may impede general load-balancing of tasks 
which haven't been strictly constrained to a cpuset and have just gotten 
caught up in the newly imposed hard fencing.

>> +#ifdef CONFIG_CPUSETS
>
> CPUSETS only? Or do we want to try to help sched_setaffinity users as
> well?

Again, I was trying to keep things simple and trigger all this off the 
creation and deletion of cpusets, which I believe tend to be managed in a 
more disciplined way than a casual use of "runon" or "taskset."  It's easy 
to assign a process to a range of CPUs using sched_setaffinity, but when 
does this new dynamic sched domain get destroyed?

>> +struct sched_domain_bundle {
>> + struct sched_domain sd_cpuset;
>> + struct sched_group **sg_cpuset_nodes;
>> + int use_count;
>> +};
>
> Can you get away without using the bundle? Or does it make things easier?
> You could add a new use_count to struct sched_domain if you'd like.... 
> does
> it make the setup/teardown too difficult?

The use_count is a ploy to reduce the demand for SCHED_DOMAIN_CPUSET_MAX 
slots.  I have been told that one popular job manager will create some 
duplicate cpusets.

The bundle is really there to simplify discovering the sched group lists.

>> +#define SCHED_DOMAIN_CPUSET_MAX 8 /* power of 2 */
>> +static DEFINE_PER_CPU(long, sd_cpusets_used) = { 1UL 
>> <<SCHED_DOMAIN_CPUSET_MAX};
>> +static DEFINE_PER_CPU(struct 
>> sched_domain_bundle[SCHED_DOMAIN_CPUSET_MAX],
>> +       sd_cpusets_bundle);
>
> Do we need a limit of 8? If you're worried about memory, I guess there are
> lots of ways to DOS the system... if you're worried about scheduler 
> balancing
> overhead, we could do a seperate traversal of these guys at a reduced
> interval (I guess that still leaves some places needing help, though)

It's more of a concern about runaway memory allocations.  I don't understand 
what you mean by a "separate traversal."  It seems to me that we want these 
new sched domains to be fully merged into the single per-runqueue list of 
sched domains to search.  Are you proposing a second runqueue list for these 
dynamic sched domains?  That gets kind of ugly for all those places in the 
scheduler that want to search the hierarchical sched domain list.

>> +static int find_existing_sched_domain(int cpu, const cpumask_t *cpu_map)
>
> Probably some way to distinguish these guys as operating on your "bundle" 
> stack
> would make it a bit clearer?

Okay.

>> + /* tweak sched_domain params based upon domain size */
>> + *sd = SD_NODE_INIT;
>> + sd->flags |= SD_TRACKS_CPUSET;
>> + sd->max_interval = 8*(min(new_sd_span, 32));
>> + sd->span = *cpu_map;
>> + cpu_set(cpu, new_sd_cpu_map);
>
> Can we just have a new SD_xxx_INIT for these?

Okay.

>> Index: linux/kernel/cpuset.c
>> ===================================================================
>> --- linux.orig/kernel/cpuset.c 2006-07-05 15:51:38.873939805 -0700
>> +++ linux/kernel/cpuset.c 2006-07-05 16:01:14.892039725 -0700
>> @@ -828,8 +828,12 @@ static int update_cpumask(struct cpuset 
>> mutex_lock(&callback_mutex);
>>  cs->cpus_allowed = trialcs.cpus_allowed;
>>  mutex_unlock(&callback_mutex);
>> - if (is_cpu_exclusive(cs) && !cpus_unchanged)
>> - update_cpu_domains(cs);
>> + if (!cpus_unchanged) {
>> + if (is_cpu_exclusive(cs))
>> + update_cpu_domains(cs);
>> + else
>> + add_sched_domain(&cs->cpus_allowed);
>> + }
>>  return 0;
>>  }
>>  @@ -1934,6 +1938,8 @@ static int cpuset_rmdir(struct inode *un
>>  set_bit(CS_REMOVED, &cs->flags);
>>  if (is_cpu_exclusive(cs))
>>  update_cpu_domains(cs);
>> + else
>> + destroy_sched_domain(&cs->cpus_allowed);
>>  list_del(&cs->sibling); /* delete my sibling from parent->children */
>>  spin_lock(&cs->dentry->d_lock);
>>  d = dget(cs->dentry);
>>
>
> So you're just doing the inside. What about the complement? That
> way you'd get a nice symmetric allocation on all cpus for each
> cpuset... but that probably would require making the limit greater
> than 8.

Doing the compliment makes things just like cpu-exclusive cpusets, right? 
And the problem is even more complicated since it's commonly the case that 
cpusets are layered, e.g., first creating a cpuset for cpus 0-31, then 
carving up those 32 CPUs into smaller subsets.  What is then the semantics 
for the sched domains for all the variations of CPUs within some cpuset and 
outside of that cpuset?

Even worse, it's legal to create overlapping cpusets, and what is the 
semantics of isolated sched domains then?

> And it would be probably required for good sched_setaffinity
> balancing too.

True, but I do have concerns (as I noted above).  Besides, I believe that 
most cases of sched_setaffinity() involve a single target CPU.  "Cpusets" 
tends to involve sets of multiple CPUs.  At least that's my intuition.

John Hawkes 

