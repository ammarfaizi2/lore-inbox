Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbVJBUKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbVJBUKH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 16:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932067AbVJBUKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 16:10:07 -0400
Received: from hera.kernel.org ([140.211.167.34]:11679 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932066AbVJBUKG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 16:10:06 -0400
Date: Sun, 2 Oct 2005 17:06:40 -0300
From: Marcelo <marcelo.tosatti@cyclades.com>
To: Bharata B Rao <bharata@in.ibm.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       "Theodore Ts'o" <tytso@mit.edu>, Dipankar Sarma <dipankar@in.ibm.com>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: VM balancing issues on 2.6.13: dentry cache not getting shrunk enough
Message-ID: <20051002200640.GB9865@xeon.cnet>
References: <20050911105709.GA16369@thunk.org> <20050911120045.GA4477@in.ibm.com> <20050912031636.GB16758@thunk.org> <20050913084752.GC4474@in.ibm.com> <20050914230843.GA11748@dmt.cnet> <20050915093945.GD3869@in.ibm.com> <20050915132910.GA6806@dmt.cnet> <20051002163229.GB5190@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051002163229.GB5190@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bharata,

On Sun, Oct 02, 2005 at 10:02:29PM +0530, Bharata B Rao wrote:
> 
> Marcelo,
> 
> The attached patch is an attempt to break the "slabs_scanned" into
> meaningful pieces as you suggested.
> 
> But I coudn't do this cleanly because kmem_cache_t isn't defined
> in a .h file and I didn't want to touch too many files in the first
> attempt.
> 
> What I am doing here is making the "requested to free" and
> "actual freed" counters as part of struct shrinker. With this I can
> update these statistics seamlessly from shrink_slab().
> 
> I don't have this as per cpu counters because I wasn't sure if shrink_slab()
> would have many concurrent executions warranting a lockless percpu
> counters for these.

Per-CPU counters are interesting because they avoid the atomic
operation _and_ potential cacheline bouncing. Given the fact that less
commonly used counters in the reclaim path are already per-CPU,
I think that it might be worth to do it here too.

> I am displaying this information as part of /proc/slabinfo and I have
> verified that it atleast isn't breaking slabtop.
> 
> I thought about having this as part of /proc/vmstat and using
> mod_page_state infrastructure as u suggested, but having the
> "requested to free" and "actual freed" counters in struct page_state
> for only those caches which set the shrinker function didn't look
> good.

OK... You could change the atomic counters to per-CPU variables
in "struct shrinker".

> If you think that all this can be done in a better way, please
> let me know. 

