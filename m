Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbWHMTAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWHMTAf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 15:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWHMTAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 15:00:35 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:29077 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751347AbWHMTAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 15:00:35 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, pj@sgi.com,
       linux-kernel@vger.kernel.org, "Albert Cahalan" <acahalan@gmail.com>
Subject: Re: [RFC] ps command race fix
References: <20060714203939.ddbc4918.kamezawa.hiroyu@jp.fujitsu.com>
	<20060724182000.2ab0364a.akpm@osdl.org>
	<20060724184847.3ff6be7d.pj@sgi.com>
	<20060725110835.59c13576.kamezawa.hiroyu@jp.fujitsu.com>
	<20060724193318.d57983c1.akpm@osdl.org>
	<20060725115004.a6c668ca.kamezawa.hiroyu@jp.fujitsu.com>
	<20060725121640.246a3720.kamezawa.hiroyu@jp.fujitsu.com>
	<m1mza8wqdc.fsf@ebiederm.dsl.xmission.com>
	<20060813103434.17804d52.akpm@osdl.org>
Date: Sun, 13 Aug 2006 13:00:14 -0600
In-Reply-To: <20060813103434.17804d52.akpm@osdl.org> (Andrew Morton's message
	of "Sun, 13 Aug 2006 10:34:34 -0700")
Message-ID: <m1zme8v4u9.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> On Sun, 13 Aug 2006 10:29:51 -0600
> ebiederm@xmission.com (Eric W. Biederman) wrote:
>
>> So for systems that are going to be using a larger number of pid
>> values I think we need a better data structure, and containers are
>> likely to push us in that area.  Which means either an extensible
>> hash table or radix tree look like the sane choices.
>
> radix-trees are nice because you can efficiently traverse them in-order
> while the contents are changing (albeit potentially missing newly-added
> things, but that's inevitable).

Actually except when we can't find the process we were just at
the current code doesn't miss any newly added processes.  So there
are implementations that missing new entries isn't inevitable.

> radix-trees are not-nice because they allocate memory at insertion time. 
> If that's a problem then rbtrees could perhaps be used.

It isn't fundamental, as I do memory allocations on that path.  But
it does appear to be a implementation conflict as the current locking
is a spinlock with irqs disabled, and doing a GFP_ATOMIC allocation
to avoid that is fairly silly.

If we were to loose the potential to do rcu traversals when looking
up a single pid that would be make scaling the code much harder.

> idr-trees have similar characteristics to the radix-trees, except a) the
> idr-tree find-next-above feature could perhaps be used for the core pid
> allocation and b) idr-trees don't presently have suitable search functions
> for performing the iteration.

We have to be careful about changing the pid allocation algorithm.
We need to keep the logic where we ensure it will be a long time
before a newly freed pid is reused.  Which basically means the current
implementation that walks through possible pids allocating new ones.
The current implementation doesn't give us any guarantees, but it is
much better than the normal allocator algorithm of allocating the next
available pid.

> At least we have plenty of choices ;)

Yes, and I'm still not quite convinced we have a problem that needs a
new data structure.  But with everything becoming multi-core there are
serious pressures in that direction.

Anyway the important part is to get a traversal by pid.

Eric

