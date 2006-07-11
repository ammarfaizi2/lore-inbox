Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965236AbWGKHSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965236AbWGKHSb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 03:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965250AbWGKHSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 03:18:30 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:17386 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S965236AbWGKHS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 03:18:29 -0400
Date: Tue, 11 Jul 2006 15:55:38 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-ia64@vger.kernel.org, tony.luck@intel.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] remove empty node at boot time
Message-Id: <20060711155538.e15a7a29.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <200607101103.03849.bjorn.helgaas@hp.com>
References: <20060601200436.6bf7c4e5.kamezawa.hiroyu@jp.fujitsu.com>
	<200607092038.41053.bjorn.helgaas@hp.com>
	<20060710141903.424ba3db.kamezawa.hiroyu@jp.fujitsu.com>
	<200607101103.03849.bjorn.helgaas@hp.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2006 11:03:03 -0600
Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

> On Sunday 09 July 2006 23:19, KAMEZAWA Hiroyuki wrote:
> > Could you try this patch ? (against 2.6.18-rc1)
> 
> Your patch does fix it.  But I'm worried about removing
> empty nodes at boot-time.  I want to support the following
> scenario:
> 
>   node 0: 1 enabled CPU, 3 disabled CPUs, no local memory
>   node 1: 4 disabled CPUs, no local memory
>   node 2: no CPUs, big interleaved memory across nodes 0 & 1
> 
> At run-time, I'd like to be able to enable any or all of the
> 7 disabled CPUs.  If you remove the "empty" node 1 at boot-time,
> it sounds like I won't be able to enable its CPUs later.
> 

Hmm.. in my understanding, all structures for *possible* cpus are allocated
at boot time. Then, only problem seems that a cpu is tied to 
not-exisiting-node at boot time.
(see arch/ia64/kernel/numa.c, build_cpu_to_node_map())

====
void __init build_cpu_to_node_map(void)
{
        int cpu, i, node;

        for(node=0; node < MAX_NUMNODES; node++)
                cpus_clear(node_to_cpu_mask[node]);

        for(cpu = 0; cpu < NR_CPUS; ++cpu) {
                node = -1;
                for (i = 0; i < NR_CPUS; ++i)
                        if (cpu_physical_id(cpu) == node_cpuid[i].phys_id) {
                                node = node_cpuid[i].nid;
                                break;
                        }
                cpu_to_node_map[cpu] = (node >= 0) ? node : 0; 
                if (node >= 0)
                        cpu_set(cpu, node_to_cpu_mask[node]);
        }
}
=====

Then what we have to do here are
1. remap cpu to the first existing node at hot-add event
or
2. implement node-hot-add triggered by cpu-hot-add.
   Because we already have implemented node-hot-add triggered by memory-hotadd
   we can do it by small effort.

I think above will work for your environment.
do you have any idea other than "don't remove empty node at boot time" ?
or reserve empty node is the best way ?

- Kame

