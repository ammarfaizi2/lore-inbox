Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932405AbVKGEh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbVKGEh2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 23:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbVKGEh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 23:37:28 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:38026 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932405AbVKGEh2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 23:37:28 -0500
Date: Sun, 6 Nov 2005 20:37:17 -0800
From: Paul Jackson <pj@sgi.com>
To: Andi Kleen <ak@suse.de>
Cc: nickpiggin@yahoo.com.au, akpm@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Clean up of __alloc_pages
Message-Id: <20051106203717.58c3eed0.pj@sgi.com>
In-Reply-To: <200511070442.58876.ak@suse.de>
References: <20051028183326.A28611@unix-os.sc.intel.com>
	<20051106124944.0b2ccca1.pj@sgi.com>
	<436EC2AF.4020202@yahoo.com.au>
	<200511070442.58876.ak@suse.de>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick wrote:
> Anyway, I think the first problem is a showstopper. I'd look into
> Hugh's SLAB_DESTROY_BY_RCU for this ...

Andi wrote:
> RCU could be used to avoid that. Just only free it in a RCU callback.


... looking at mm/slab.h and rcupdate.h for the first time ... 

Would this mean that I had to put the cpuset structures on their own
slab cache, marked SLAB_DESTROY_BY_RCU?

And is the pair of operators:
  task_lock(current), task_unlock(current)
really that much worse than the pair of operatots
  rcu_read_lock, rcu_read_unlock
which apparently reduce to:
  preempt_disable, preempt_enable

Would this work something like the following?  Say task A, on processor
AP, is trying to dereference its cpuset pointer, while task B, on
processor BP, is trying hard to destroy that cpuset. Then if task A
wraps its reference in <rcu_read_lock, rcu_read_unlock>, this will keep
the RCU freeing of that memory from completing, until interrupts on AP
are re-enabled.

For that matter, if I just put cpuset structs in their own slab
cache, would that be sufficient.

  Nick - Does use-after-free debugging even catch use of objects
	 returned to their slab cache?

What about the other suggestions, Andi:
 1) subset zonelists (which you asked to reconsider)
 2) a kernel flag "cpusets_have_been_used" flag to short circuit
    cpuset logic on systems not using cpusets.



-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
