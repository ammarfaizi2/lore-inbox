Return-Path: <linux-kernel-owner+w=401wt.eu-S932800AbWLSMGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932800AbWLSMGH (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 07:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932795AbWLSMGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 07:06:07 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:35314 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932800AbWLSMGE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 07:06:04 -0500
Subject: Re: Task watchers v2
From: Matt Helsley <matthltc@us.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: yanmin_zhang@linux.intel.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       jes@sgi.com, hch@lst.de, viro@zeniv.linux.org.uk, sgrubb@redhat.com,
       linux-audit@redhat.com, systemtap@sources.redhat.com
In-Reply-To: <20061218214159.2d571bf5.pj@sgi.com>
References: <20061215000754.764718000@us.ibm.com>
	 <20061215000817.771088000@us.ibm.com> <1166420641.15989.117.camel@ymzhang>
	 <1166447901.995.110.camel@localhost.localdomain>
	 <20061218214159.2d571bf5.pj@sgi.com>
Content-Type: text/plain
Organization: IBM Linux Technology Center
Date: Tue, 19 Dec 2006 04:05:55 -0800
Message-Id: <1166529955.995.177.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-18 at 21:41 -0800, Paul Jackson wrote:
> Matt wrote:
> > - Task watchers can actually improve kernel performance slightly (up to
> > 2% in extremely fork-heavy workloads for instance).
> 
> Nice.
> 
> Could you explain why?

After the last round of patches I set out to improve instruction and
data cache hits.

Previous iterations of task watchers would prevent the code in these
paths from being inlined. Furthermore, the code certainly wouldn't be
placed near the table of function pointers (which was in an entirely
different ELF section). By placing them adjacent to each other in the
same ELF section we can improve the likelihood of cache hits in
fork-heavy workloads (which were the ones that showed a performance
decrease in the previous iteration of these patches).

Suppose we have two functions to invoke during fork -- A and B. Here's
what the memory layout looked like in the previous iteration of task
watchers:

+--------------+<----+
|  insns of B  |     |
       .             |
       .             |
       .             |
|              |     |
+--------------+     |
       .             |
       .             |
       .             |
+--------------+<-+  |
|  insns of A  |  |  |
       .          |  |
       .          |  |
       .          |  |
|              |  |  |
+--------------+  |  |
       .          |  |
       .          |  |
       .          |  |  .text
==================|==|========= ELF Section Boundary
+--------------+  |  |  .task
| pointer to A----+  |
+--------------+     |
| pointer to B-------+
+--------------+

The notify_task_watchers() function would first load the pointer to A from the .task
section. Then it would immediately jump into the .text section and force the
instructions from A to be loaded. When A was finished, it would return to
notify_task_watchers() only to jump into B by the same steps.

As you can see things can be rather spread out. Unless the compiler inlined the
functions called from copy_process() things are very similar in a mainline
kernel -- copy_process() could be jumping to rather distant portions of the kernel
text and the pointer table would be rather distant from the instructions to be loaded.

Here's what the new patches look like:

===============================
+--------------+        .task
| pointer to A----+
+--------------+  |
| pointer to B-------+
+--------------+  |  |
       .          |  |
       .          |  |
+--------------+<-+  |
|  insns of A  |     |
       .             |
       .             |
       .             |
|              |     |
+--------------+<----+
|  insns of B  |
       .
       .
       .
|              |
+--------------+
===============================

Which is clearly more compact and also follows the order of calls (A
then B). The instructions are all in the same section. When A finishes
executing we soon jump into B which could be in the same instruction
cache line as the function we just left. Furthermore, since the sequence
always goes from A to B I expect some anticipatory loads could be done.

For fork-heavy workloads I'd expect this to explain the performance
difference. For workloads that aren't fork-heavy I suspect we're just as
likely to experience instruction cache misses -- whether the functions
are inlined, adjacent, or not -- since the fork happens relatively
infrequently and other instructions are likely to push fork-related
instructions out.

Cheers,
	-Matt Helsley

