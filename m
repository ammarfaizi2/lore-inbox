Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964911AbWDDA1C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964911AbWDDA1C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 20:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964913AbWDDA1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 20:27:01 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:55253 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964911AbWDDA1A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 20:27:00 -0400
Date: Mon, 3 Apr 2006 17:25:33 -0700
From: Paul Jackson <pj@sgi.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: ntl@pobox.com, akpm@osdl.org, linuxppc-dev@ozlabs.org, ak@suse.com,
       linux-kernel@vger.kernel.org
Subject: Re: Fw: 2.6.16 crashes when running numastat on p575
Message-Id: <20060403172533.f03f1ba2.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.64.0604031104110.20903@schroedinger.engr.sgi.com>
References: <20060402213216.2e61b74e.akpm@osdl.org>
	<Pine.LNX.4.64.0604022149450.15895@schroedinger.engr.sgi.com>
	<20060402221513.96f05bdc.pj@sgi.com>
	<Pine.LNX.4.64.0604022224001.18401@schroedinger.engr.sgi.com>
	<20060403141027.GB25663@localdomain>
	<Pine.LNX.4.64.0604031039560.20648@schroedinger.engr.sgi.com>
	<20060403180131.GD25663@localdomain>
	<Pine.LNX.4.64.0604031104110.20903@schroedinger.engr.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph wrote:
> There may be some complicated interactions with cpusets.

Hopefully not, but it's possible.  I did my best not to assume that
cpus or memory nodes stayed online, and to build in fallbacks if one
of them disappeared out from under me.

But the code has never been tested to these assumptions, nor even
carefully reviewed to them.

So something will likely break somewhere, though quite possibly not
in the cpuset code itself, but in the scheduler or allocator code
that depends on selecting an online cpu or memory for some purpose.

Someone from the hotplug side will have to look at this, with an
understanding of how the coming and going of cpus and memory nodes
can affect the scheduler and allocators.

Look at the callers of cpuset_cpus_allowed(), cpuset_mems_allowed(),
cpuset_update_task_memory_state(), and cpuset_zone_allowed() to see
the likely hot spots for interaction between cpusets and hotplug.

The callers of these routines are important hooks into the scheduler
and allocator, and the question needs to be asked what happens if
a cpu or memory node goes offline after one of these cpuset_*()
routines is called before the scheduler or allocator finishes doing
what it is doing with what it thought was a usable cpu or node.

Also, there is currently no hotplug aware code that I know of in
the kernel/cpuset.c code, so each of the references to the globals
cpu_online_map and node_online_map therein are suspect.  Presumably as
anywhere else in the kernel these appear, or the for_each_online_*()
macros appear, the code needs to be examined for perhaps needing some
sort of guard.

So, in sum, the kernel needs to be inspected at the location of at
least each of the following calls or references, for possible problems
if the cpus or nodes online change unexpectedly:

 any_online_node()
 cpu_online_map
 cpu_present()
 cpu_present_map
 cpuset_cpus_allowed()
 cpuset_mems_allowed()
 cpuset_update_task_memory_state()
 cpuset_zone_allowed()
 for_each_online_cpu()
 for_each_online_node()
 for_each_present_cpu()
 node_online_map
 num_online_cpus()
 num_online_nodes()
 num_present_cpus()

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
