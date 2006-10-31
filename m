Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423415AbWJaOnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423415AbWJaOnb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 09:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423441AbWJaOnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 09:43:31 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:5081 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1423415AbWJaOn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 09:43:29 -0500
Date: Tue, 31 Oct 2006 06:43:00 -0800
From: Paul Jackson <pj@sgi.com>
To: dino@in.ibm.com
Cc: nickpiggin@yahoo.com.au, akpm@osdl.org, mbligh@google.com,
       menage@google.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       rohitseth@google.com, holt@sgi.com, dipankar@in.ibm.com,
       suresh.b.siddha@intel.com
Subject: Re: [RFC] cpuset:  Explicit dynamic sched domain cpuset flag
Message-Id: <20061031064300.10a97c13.pj@sgi.com>
In-Reply-To: <20061030212922.GA20369@in.ibm.com>
References: <20061030212615.GA10567@in.ibm.com>
	<20061030212922.GA20369@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for doing this, Dinakar.

A couple of million messages earlier in this discussion, at its
beginning, I submitted a patch on October 18:

  Cpuset: explicit dynamic sched domain control flags
  http://lkml.org/lkml/2006/10/18/48

It too had a 'sched_domain' flag.  Some of my comments will
examine the differences between that patch and yours.

Lets call my old patch P1, and this current patch of yours P2.

Now comments on your patch, P2:

1) P1 also had a sched_domain_enabled flag, per-cpuset, to toggle
   between the old cpu_exclusive and this new sched_domain flags
   for defining sched domains.  Since then I threw out the old
   behaviour, as not worth preserving, and not creating a sufficient
   incompatibility that we needed to preserve the old way.

   So I agree with P2, not providing this sched_domain_enabled flag.

2) P1 had a rule that sibling cpusets marked 'sched_domain' could
   not overlap.  P2 has a rule that cpusets marked 'sched_domain'
   must also be marked 'cpu_exclusive.'

   I suspect I prefer P1 here.  That rule seems easier for users to
   code to.  It doesn't entangle these two flags.  But I am not sure
   I understand this detail correctly.
   
   I think it should be ok to have two overlapping sibling cpusets,
   one of which is marked as a sched domain and one of which is not.
   
   Ah - no - I'm wrong.  The "real" meaning of the 'sched_domain'
   is that cpusets so marked might *not* be sched domains!  This
   'sched_domain' name is bad, it is the reverse of what it should be.
   
   The 'sched_domain' flag name should be some variation of, say:
   
   	sched_ok_not_to_load_balance	# default to off (0)

   It is exactly the cpusets so marked which the user is allowing
   the kernel to carve up into sched domain partitions, disabling
   load balancing between these isolated partitions.

   And then this rule that cpusets marked with this flag must also
   be marked cpu_exclusive ensures that we don't have sibling cpusets
   that do require load balancing partially overlapping with cpusets
   that do not require it.  Such overlap would result in tasks stuck
   in no-man's land, expecting load balancing but stuck on a cpu
   that some other cpuset decreed need not be entirely load balanced.

3) In any case, this flag name must change.  It names the wrong thing,
   it's backwards, and its vague.
   
   (For the record - looks like I introduced the name 'sched_domain'
   in P1.  -pj)
   
    * This flags name must focus on whether load balancing is required.
      That's the publicly exposed affect of this flag.
      
      The construction of dynamic sched domains and partitioning them
      into isolated domains is an internal implementation detail,
      and as I guess Nick has been figuring for a while, should remain
      the private business of the kernel.
      
      The deal the kernel is offering the user is simply:

       	    Let us selectively disable load balancing, and
	    in turn we will give you better performance.
      
    * This flags name must correctly suggest the sense of setting it.
      To suggest in the name that we are setting up a sched domain when
      in fact we are using this flag to allow ripping sched domains
      asunder is backwards.

4) The following wording in P2 (and in earlier versions) is not clear to me:

  * For a given cpuset cur, partition the system as follows
  * a. All cpus in the parent cpuset's cpus_allowed that are not part of any
  *    child cpusets defining sched domain
  * b. All cpus in the current cpuset's cpus_allowed that are not part of any
  *    child cpusets defining sched domain
  * Build these two partitions by calling partition_sched_domains

   The first reference to 'child cpusets' confuses me - child of the
   parent (aka the current cpusets siblings) or child of the current
   cpuset.  And more essentially, the invariates are not clearly
   spelled out.  Granted, I can be dense at times.  But I have
   literally spent hours puzzling over the meaning of these lines,
   and the associated code, and I'm still figuring it out.

   How about this wording, using the flag renaming from (2) above:


  * By default, the kernel scheduler load balances across all CPUs
  * in the system.  This can get expensive on high CPU count systems.
  *
  * The per-cpuset flag 'sched_ok_not_to_load_balance' can be set by
  * the user to reduce this load balancing performance penalty.
  * If set in a cpuset, this tells the kernel it is ok not to load
  * balance tasks in that cpuset.  If such a cpuset overlaps other
  * cpusets that still require load balancing, the kernel may decide
  * to load balance these CPUs anyway - that's the kernel's choice.
  *
  * The kernel implements this by partitioning the CPUs in the system
  * into as many separate, isolated scheduler domains as it can, and
  * still avoid dividing any cpuset that -does- require load balancing
  * across two or more such partitions.
  *
  * A 'partition' P of a set S is a set of subsets of S, such that:
  *  1) the union of the members of P equals S,
  *  2) no two members of P overlap each other, and
  *  3) no member of P is empty.
  *
  * Marking a cpuset 'sched_ok_not_to_load_balance' grants the kernel
  * permission to partition the CPUs in that cpuset across multiple
  * isolated sched domains.  No load balancing is done between such
  * isolated domains.
  *
  * If 'C' is a cpuset marked 'sched_ok_not_to_load_balance',
  * then its set of CPUs are either a member of this partition,
  * or equal to the union of multiple members of this partition,
  * including the members corresponding to the cpuset descendents of
  * 'C' which are marked sched_ok_not_to_load_balance.
  *
  * If 'C' is a cpuset marked 'sched_ok_not_to_load_balance', and if
  * some of its child cpusets are also marked, and if there are any
  * left over CPUs in 'C' that are not in any of those child cpusets
  * so marked, then these left over cpus form a separate member of
  * the sched domain partition.
  *
  * Because we gather up such left over cpus to form another partition
  * member, therefore whenever we change this flag on a cpuset, we
  * have to recompute the partition for the parent of the affected
  * cpuset as well as for the affected cpuset itself.
  *
  * Similarly, if a cpuset that is so marked has child cpusets also
  * marked, and if it has CPUs added or removed, then we have to
  * recompute the partition for its child cpusets, as the left over
  * CPUs will have changed.

5) The above remarks just try to clarify what is with comments and
   name changes.
   
   There is one remaining capability that is missing.
   
   Batch schedulers, for example, can end up with multiple overlapping
   sibling cpusets, for a mix of active and inactive jobs.  At any point
   in time the active cpusets don't overlap, and to improve performance,
   the batch scheduler would like to partition the sched domains along
   the lines of its active jobs.
   
   For this to work, the sched_ok_not_to_load_balance flag has to become
   advisory rather than mandatory.
   
   That is, instead of imposing the rules up front:
     * must be cpu_exclusive, and
     * must have parent set too,
   rather let any cpuset be marked  sched_ok_not_to_load_balance,
   and then discover the finest grained sched domain partitioning
   consistent with those markings.  This discovery could be done in
   an N**2 algorithm, where N is the number of cpusets, by scanning
   over all cpusets, clustering any overlapping cpusets that require
   load balancing (don't have sched_ok_not_to_load_balance set.)
   
   Currently, anytime this flag, or the CPUs in a cpuset so marked,
   change, we immediately drive a new partitioning, along those lines.
   
   Instead, anytime the set of cpusets requiring load balancing
   (the cpusets with sched_ok_not_to_load_balance not set) changes,
   adding or remove such a cpuset or CPUs to or from such a cpuset,
   we should rediscover the partitioning, clustering into the same
   partition member any overlapping cpusets requiring balancing.

6) Now for some nits:

    @@ -1005,6 +1074,11 @@
 	    cs->flags = trialcs.flags;
 	    mutex_unlock(&callback_mutex);

    +	sched_domain_changed =
    +		(is_sched_domain(cs) != is_sched_domain(&trialcs));

   This looks borked.  You are looking for differences in the
   flags of cs and trialcs, just after the assignment making
   them the same.  I predict that "sched_domain_changed" will
   always be False.  You probably have to set sched_domain_changed
   earlier in the code.
   
7) The patch would be slightly easier to read if done with a "diff -p"
   option, displaying the procedure name for each diff chunk.

8) Looks like a cut+paste comment from earlier code did not change
   some mentions of cpu_exclusive to sched_domain:
   
    + * If the cpuset being removed is marked cpu_exclusive, then simulate
    + * turning cpu_exclusive off, which will call update_cpu_domains().

   Also:
   
    + - Also a cpu_exclusive cpuset would be associated with a sched
    +   domain, if the sched_domain flag is turned on.

   And:
   
    +A cpuset that is cpu_exclusive can be used to define a scheduler
    +(sched) domain if the sched_domain flag is turned on. The sched domain
    +consists of all CPUs in the current cpuset that are not part of any
    +exclusive child cpusets that also define sched domains.

9) Finally, we really do need a way, on a production system, for user
   space to ask the kernel where load balancing is limited.
   
   For example one possible interface would have user space pass a
   cpumask to the kernel, and get back a Boolean value, indicating
   whether or not there are any limitations on load balancing between
   any two CPUs specified in that cpumask.  Internally, the kernel
   would answer this by seeing if the provided mask was a subset of
   one of the partition members, or not.
   
   A performance aware batch scheduler, for instance, could use this
   API to verify that load balancing really was limited on its top
   level and other large, inactive, cpusets.
   
-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
