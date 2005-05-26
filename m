Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbVEZMgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbVEZMgS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 08:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbVEZMgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 08:36:18 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:55462 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261358AbVEZMfw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 08:35:52 -0400
Date: Thu, 26 May 2005 13:35:46 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Joel Schopp <jschopp@austin.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Avoiding external fragmentation with a placement policy Version
 11
In-Reply-To: <4294BE45.3000502@austin.ibm.com>
Message-ID: <Pine.LNX.4.58.0505260809420.695@skynet>
References: <20050522200507.6ED7AECFC@skynet.csn.ul.ie> <4294BE45.3000502@austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 May 2005, Joel Schopp wrote:

> > Changelog since V10
> >
> > o Important - All allocation types now use per-cpu caches like the standard
> >   allocator. Older versions may have trouble with large numbers of
> > processors
>
> Do you have a new set of benchmarks we could see?  The ones you had for v10
> were pretty useful.
>

Only what I've posted as part of the patch. I cannot benchmark the
scalability on large numbers of processors as I lack such a machine. I am
*guessing* that the inability of previous patch versions to use per-cpu
caches for kernel allocations would have hurt, but I do not know for a
fact.

> > o Removed all the additional buddy allocator statistic code
>
> Is there a separate patch for the statistic code or is it no longer being
> maintained?
>

It's still being maintained, I didn't post it because I didn't think
people were interested and I am happy to keep the stats patch as part of
VMRegress. The current version of the statistics patch is attached this
mail. It comes with a noticeable performance penalty when enabled.

> > +/*
> > + * Shared per-cpu lists would cause fragmentation over time
> > + * The pcpu_list is to keep kernel and userrclm allocations
> > + * apart while still allowing all allocation types to have
> > + * per-cpu lists
> > + */
>
> Why are kernel nonreclaimable and kernel reclaimable joined here?  I'm not
> saying you are wrong, I'm just ignorant and need some education.
>

Right now, the KernRclm areas tend to free up in large blocks over time,
but there is no way of forcing it so we rarely get the MAX_ORDER-1 sized
blocks from the kernel areas. The per-cpu caches pollute areas very slowly
but are not very noticable in the kernrclm areas. As I don't expect to get
the interesting large blocks fre ein the kernel areas, and this is a
critical path, I decided to let the per-cpu lists share the kernel lists.

When hotplug comes into play, or we have a mechanism for force-reclaiming
the KernRclm areas, this will need to be revisited.

Does this make sense?

> > +struct pcpu_list {
> > +    int count;
> > +    struct list_head list;
> > +} ____cacheline_aligned_in_smp;
> > +
> >  struct per_cpu_pages {
> > -    int count;      /* number of pages in the list */
> > +    struct pcpu_list pcpu_list[2]; /* 0: kernel 1: user */
> >      int low;/* low watermark, refill needed */
> >      int high;       /* high watermark, emptying needed */
> >      int batch;      /* chunk size for buddy add/remove */
> > -    struct list_head list;  /* the list of pages */
> >  };
> >
>
> Instead of defining 0 and 1 in a comment why not use a #define?
>

We could, and in an unreleased version, it was a #define. I used the 0 and
1 to look similar to how hot/cold page lists are managed and I wanted
things to look familiar.

> > +    pcp->pcpu_list[0].count = 0;
> > +    pcp->pcpu_list[1].count = 0;
>
> The #define would make code like this look more readable.
>

I'll release a verion on Monday against the latest rc5 kernel with a
#define instead. Probably something like PCPU_KERNEL and PCPU_USER

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
