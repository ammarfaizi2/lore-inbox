Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268258AbUIKRa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268258AbUIKRa7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 13:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268250AbUIKRa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 13:30:58 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:34539 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S268240AbUIKR3h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 13:29:37 -0400
Subject: Re: [Patch 4/4] cpusets top mask just online, not all possible
From: Dave Hansen <haveblue@us.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: Anton Blanchard <anton@samba.org>, Andrew Morton <akpm@osdl.org>,
       Simon.Derr@bull.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, IWAMOTO Toshihiro <iwamoto@valinux.co.jp>
In-Reply-To: <20040911100731.2f400271.pj@sgi.com>
References: <20040911082810.10372.86008.84920@sam.engr.sgi.com>
	 <20040911082834.10372.51697.75658@sam.engr.sgi.com>
	 <20040911141001.GD32755@krispykreme>  <20040911100731.2f400271.pj@sgi.com>
Content-Type: text/plain
Message-Id: <1094923728.3997.10.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 11 Sep 2004 10:28:49 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-09-11 at 10:07, Paul Jackson wrote:
> I'm adding Andi Kleen, Iwamoto-san and Dave Hansen to the cc list, since
> the numa code and other hotplug work might have similar considerations.
> 
> Anton asks:
> > How does this change interact with CPU hotplug?
> 
> You beat my estimate ;).  I figured it would be a day before someone
> asked this question.  It only took you six hours.  Good.
> 
> Cpusets and hotplug (CPU or Memory) aren't friends, yet.

Heh.  I assumed that cpusets didn't deal with memory, and I ignored the
code when I saw it.  Oh well... :)

> It wouldn't surprise me if Andi Kleen's numa code, especially the
> MPOL_BIND which builds up special restricted zonelists holding only the
> bound Memory Nodes, has the same sorts of interactions with Memory
> hotplug.  However, I have not given this suspicion any careful thought,
> so could easily be wrong.

It shouldn't interact yet because we don't add any NUMA nodes yet, we
only grow existing ones.  The only case that would be a problem is if an
entire node's memory was removed, but that would probably be similar to
trying to bind to an empty node now, or what happens during CPU hotplug
with cpus_allowed set to a now-unplugged CPU.

>  2) Someday soon, the cpuset (and numa?) placement code needs to add an
>     internal kernel call that the hotplug code can call to inform the
>     placement code that a CPU or Memory resource has gone on or offline,
>     so that the placement code can "deal with it", somehow.

See kernel/cpu.c:25
/* Need to know about CPUs going up/down? */
int register_cpu_notifier(struct notifier_block *nb)

We'll do the same for memory, I promise.

>  3) The way that I anticipate the cpuset code will "deal with it"
>     will be:

Other than providing the notifiers, I don't think there's a whole lot
else the hotplug code can do.  That's left for the poor souls working on
the binding APIs.  Memory will probably need some slightly more
informative things that the CPU notifiers because we might have some
more properties that the handlers might care about, but it shouldn't be
fundamentally different. 

-- Dave

