Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267508AbUILCXB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267508AbUILCXB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 22:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268406AbUILCXB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 22:23:01 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:56463 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S267508AbUILCW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 22:22:58 -0400
Date: Sat, 11 Sep 2004 19:21:56 -0700
From: Paul Jackson <pj@sgi.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: anton@samba.org, akpm@osdl.org, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, ak@suse.de, iwamoto@valinux.co.jp
Subject: Re: [Patch 4/4] cpusets top mask just online, not all possible
Message-Id: <20040911192156.1da7c636.pj@sgi.com>
In-Reply-To: <1094923728.3997.10.camel@localhost>
References: <20040911082810.10372.86008.84920@sam.engr.sgi.com>
	<20040911082834.10372.51697.75658@sam.engr.sgi.com>
	<20040911141001.GD32755@krispykreme>
	<20040911100731.2f400271.pj@sgi.com>
	<1094923728.3997.10.camel@localhost>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

  Discard this 4/4 patch for "online" - I've got a better one
  coming in a few hours.  (If you want to keep this 4/4 patch
  and have me send the next one relative to it, that works too -
  just ask.)

The problem is that what's online, and what cpusets decrees, might
conflict.

  The solution is simple: online wins.

This is for the simple reason that it is better to run something in the
wrong place, than to refuse to run it.  The kernel, the apps and the
users all cope better with misplacement than with starvation.

There are only a handful of places that cpusets hooks into the kernel,
none of them on critical code paths.  My upcoming patch will guarantee
to always provide 'online' CPUs and Memory Nodes in these places, using
the current cpu_online_map and node_online_map.

If what the user configured in their cpuset is still online, then no
problem - they get what they asked for.

If they setup a cpuset, then unplug the CPUs or Memory Nodes that cpuset
uses, but don't update their cpuset config, then tough - I'll give them
some CPUs and Memory Nodes that are online instead.  If they don't like
my online choices, then they should fix their cpuset config to be valid
again.

Fix should require a couple lines of cpumask and nodemask logic in a
handful of cpuset routines, and a few other related cpuset code tweaks
... right up my alley.

Dave,

  Just as code in kernel/sched.c:move_task_off_dead_cpu()
  updates the affected tasks cpus_allowed to move off a dead
  CPU, calling cpuset_cpus_allowed() to get a new list of
  candidate CPUs to be set in task->cpus_allowed, similarly I
  expect that disabling a Memory Node should result in some
  "move_task_off_dead_memory()" routine, that called a cpuset
  routine to be called "cpuset_mems_allowed()", to get a new
  list of Memory Nodes, to be set in task->mems_allowed.

  Does this expectation fit for you?  If so, let me know when
  you want the"cpuset_mems_allowed()" routine - or take a stab
  at it yourself if you find that easier.

  There are other ways to skin this cat - feel free to offer
  such up if that fits your work better.

  But, for now, I leave the issue of how to update the tasks
  mems_allowed field, when a Memory Node goes offline, in your
  hands, for the next step.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
