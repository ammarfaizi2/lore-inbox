Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269656AbUJGCOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269656AbUJGCOr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 22:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269657AbUJGCOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 22:14:47 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:33726 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269656AbUJGCOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 22:14:05 -0400
Message-ID: <4164A664.9040005@yahoo.com.au>
Date: Thu, 07 Oct 2004 12:13:56 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: colpatch@us.ibm.com
CC: Paul Jackson <pj@sgi.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Morton <akpm@osdl.org>, ckrm-tech@lists.sourceforge.net,
       LSE Tech <lse-tech@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>, simon.derr@bull.net,
       frankeh@watson.ibm.com
Subject: Re: [RFC PATCH] scheduler: Dynamic sched_domains
References: <1097110266.4907.187.camel@arrakis>
In-Reply-To: <1097110266.4907.187.camel@arrakis>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dobson wrote:
> This code is in no way complete.  But since I brought it up in the
> "cpusets - big numa cpu and memory placement" thread, I figure the code
> needs to be posted.
> 
> The basic idea is as follows:
> 
> 1) Rip out sched_groups and move them into the sched_domains.
> 2) Add some reference counting, and eventually locking, to
> sched_domains.
> 3) Rewrite & simplify the way sched_domains are built and linked into a
> cohesive tree.
> 

OK. I'm not sure that I like the direction, but... (I haven't looked
too closely at it).

> This should allow us to support hotplug more easily, simply removing the
> domain belonging to the going-away CPU, rather than throwing away the
> whole domain tree and rebuilding from scratch.

Although what we have in -mm now should support CPU hotplug just fine.
The hotplug guys really seem not to care how disruptive a hotplug
operation is.

>  This should also allow
> us to support multiple, independent (ie: no shared root) domain trees
> which will facilitate isolated CPU groups and exclusive domains.  I also

Hmm, what was my word for them... yeah, disjoint. We can do that now,
see isolcpus= for a subset of the functionality you want (doing larger
exclusive sets would probably just require we run the setup code once
for each exclusive set we want to build).

> hope this will allow us to leverage the existing topology infrastructure
> to build domains that closely resemble the physical structure of the
> machine automagically, thus making supporting interesting NUMA machines
> and SMT machines easier.
> 
> This patch is just a snapshot in the middle of development, so there are
> certainly some uglies & bugs that will get fixed.  That said, any
> comments about the general design are strongly encouraged.  Heck, any
> feedback at all is welcome! :) 
> 
> Patch against 2.6.9-rc3-mm2.

This is what I did in my first (that nobody ever saw) implementation of
sched domains. Ie. no sched_groups, just use sched_domains as the balancing
object... I'm not sure this works too well.

For example, your bottom level domain is going to basically be a redundant,
single CPU on most topologies, isn't it?

Also, how will you do overlapping domains that SGI want to do (see
arch/ia64/kernel/domain.c in -mm kernels)?

node2 wants to balance between node0, node1, itself, node3, node4.
node4 wants to balance between node2, node3, itself, node5, node6.
etc.

I think your lists will get tangled, no?
