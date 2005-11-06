Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbVKFRgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbVKFRgH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 12:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbVKFRgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 12:36:07 -0500
Received: from outbound01.telus.net ([199.185.220.220]:46273 "EHLO
	priv-edtnes57.telusplanet.net") by vger.kernel.org with ESMTP
	id S932214AbVKFRgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 12:36:06 -0500
From: Andi Kleen <ak@suse.de>
To: Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH]: Clean up of __alloc_pages
Date: Sun, 6 Nov 2005 18:35:53 +0100
User-Agent: KMail/1.8
Cc: akpm@osdl.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20051028183326.A28611@unix-os.sc.intel.com> <p73oe4z2f9h.fsf@verdi.suse.de> <20051105201841.2591bacc.pj@sgi.com>
In-Reply-To: <20051105201841.2591bacc.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511061835.53575.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 06 November 2005 05:18, Paul Jackson wrote:

> The current code in the kernel does the following:
>   1) The cpuset_update_current_mems_allowed() calls in the
>      various alloc_page*() paths in mm/mempolicy.c:
> 	* take the task_lock spinlock on the current task

That needs to go imho. At least for the common "cpusets compiled in, but not 
used" case. We already have too many locks. Even with cpusets - why
can't you test that generation lockless?

> 	* compare the tasks mems_generation to that in its cpuset

>   2) The first cpuset_zone_allowed() call or two, near the top
>      of mm/page_alloc.c:__alloc_pages():
> 	* check in_interrupt()
> 	* check if the zone's node is set in task->mems_allowed

It's also too slow for the common "compiled in but not used" case.

I did a simple patch for that - at least skip all the loops when there
is no cpuset - but it got lost in a disk crash.

> This task_lock spinlock, or some performance equivalent, is, I think,
> unavoidable.

why?

>
> An essential difference between mempolicy and cpusets is that cpusets
> supports outside manipulation of a tasks memory placement.  

Yes, that is their big problem (there is a reason I'm always complaining
about attempts to change mempolicy externally) 

But actually some mempolicy can be already changed outside the task - 
using VMA policy.

> Sooner or 
> later, the task has to synchronize with these outside changes, and a
> task_lock(current) in the path to __alloc_pages() is the lowest cost
> way I could find to do this.

Why can't it just test that generation number lockless after testing
if there is a cpuset at all?

-Andi
