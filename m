Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbVDSJQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbVDSJQj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 05:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbVDSJQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 05:16:39 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:3319 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261404AbVDSJQU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 05:16:20 -0400
Date: Tue, 19 Apr 2005 15:04:38 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: Simon.Derr@bull.net, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, akpm@osdl.org, dipankar@in.ibm.com,
       colpatch@us.ibm.com
Subject: Re: [Lse-tech] Re: [RFC PATCH] Dynamic sched domains aka Isolated cpusets
Message-ID: <20050419093438.GB3963@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <1097110266.4907.187.camel@arrakis> <20050418202644.GA5772@in.ibm.com> <20050418225427.429accd5.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050418225427.429accd5.pj@sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2005 at 10:54:27PM -0700, Paul Jackson wrote:
> Hmmm ... interesting patch.  My reaction to the changes in
> kernel/cpuset.c are complicated:

Thanks Paul for taking time off your vaction to reply to this.
I was expecting to see one of your huge mails but this has
exceeded all my expectations :)

>  * I'd probably ditch the all_cpus() macro, on the
>    concern that it obfuscates more than it helps.
>  * The need for _both_ a per-cpuset flag 'CS_CPU_ISOLATED'
>    and another per-cpuset mask 'isolated_map' concerns me.
>    I guess that the isolated_map is just a cache of the
>    set of CPUs isolated in child cpusets, not an independently
>    settable mask, but it needs to be clearly marked as such
>    if so.

Currently the isolated_map is read-only as you have guessed.
I did think of the user adding cpus to this map from the 
cpus_allowed mask but thought the current approach made more sense

>  * Some code lines go past column 80.
I need to set my vi to wrap past 80...

>  * The name 'isolated'  probably won't work.  There is already
>    a boottime option "isolcpus=..." for 'isolated' cpus which
>    is (I think ?) rather different.  Perhaps a better name will
>    fall out of the conceptual discussion, below.

I was hoping that by the time we are done with this, we would
be able to completely get rid of the isolcpus= option. For that
ofcourse we need to be able build domains that dont run
load balance

>  * The change to the output format of the special cpuset file
>    'cpus', to look like '0-3[4-7]' bothers me in a couple of
>    ways.  It complicates the format from being a simple list.
>    And it means that the output format is not the same as the
>    input format (you can't just write back what you read from
>    such a file anymore).

As i had said in my earlier mail, this was just one way of
representing what I call isolated cpus. The other was to expose
isolated_map to userspace and move cpus between cpus_allowed
and isolated_map

>  * Several comments start with the word 'Set', as in:
>  	Set isolated ON on a non exclusive cpuset
>    Such wording suggests to me that something is being set,
>    some bit or value changed or turned on.  But in each case,
>    you are just testing for some condition that will return
>    or error out.  Some phrasing such as "If ..." or other
>    conditional would be clearer.

The wording was from the users point of view for what
action was being done, guess I'll change that

>  * The update_sched_domains() routine is complicated, and
>    hence a primary clue that the conceptual model is not
>    clean yet.

It is complicated because it has to handle all of the different
possible actions that the user can initiate. It can be simplified
if we have stricter rules of what the user can/cannot do
w.r.t to isolated cpusets

>  * None of this was explained in Documentation/cpusets.txt.

Yes I plan to add the documentation shortly

>  * Too bad that cpuset_common_file_write() has to have special
>    logic for this isolated case.  The other flag settings just
>    turn on and off the associated bit, and don't trigger any
>    kernel code to adapt to new cpu or memory settings.  We
>    should make an exception to that behaviour only if we must,
>    and then we must be explicit about the exception.

See my notes on isolated_map above

> First, let me verify one thing.  I understand that the _key_
> purpose of your patch is not so much to isolate cpus, as it
> is to allow for structuring scheduling domains to align with
> cpuset boundaries.  I understand real isolated cpus to be ones
> that don't have a scheduling domain (have only the dummy one),
> as requested by the "isolcpus=..." boot flag.

Not really. Isolated cpusets allows you to do a soft-partition
of the system, and it would make sense to continue to have load
balancing within these partitions. I would think not having
load balancing should be one of the options available

> 
> Second, let me describe how this same issue shows up on the
> memory side.
> 

...snip...

> 
> 
> In the case of cpus, we really do prefer the partitions to be
> disjoint, because it would be better not to confuse the domain
> scheduler with overlapping domains.

Absolutely one of the problem I had was to map the flat disjoint
heirarchy of sched domains to the tree like heirarchy of cpusets

> 
> In the case of memory, we technically probably don't _have_ to
> keep the partitions disjoint.  I doubt that the page allocator
> (mm/page_alloc.c:__alloc_pages()) really cares.  It will strive
> valiantly to satisfy the memory request from any of the zones
> (each node specific) in the list passed into it.
> 
I must confess that I havent looked at the memory side all that much,
having more interest in trying to build soft-partitioning of the cpu's

> But for the purposes of providing a clear conceptual model to
> our users, I think it is best that we impose this constraint on
> the memory side as well as on the cpu side.  And I don't think
> it will deprive users of any useful configuration alternatives
> that they will really miss.  Indeed, the typical user will be
> striving to use this mechanism to separate different demands
> for memory - to isolate them on to different nodes in your
> sense of the word isolate.
> 

[...Big snip of new model...]

ok I need to spend more time on you model Paul, but my first
guess is that it doesn't seem to be very intuitive and seems
to make it very complex from the users perspective. However as
I said I need to understand your model a bit more before I
comment on it

> 
> However, if we thought we could avoid, or at least delay
> consideration of nested partitions, that would be nice.
> This thing is already abstract enough to puzzle many users,
> without adding that elaboration.

Nested sched domains are going to be nasty and I am not 
at all for it. Moreover I think it makes more sense to
to have a flat heirarchy for sched domains

	-Dinakar
