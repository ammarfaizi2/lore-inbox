Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262419AbVAPEEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262419AbVAPEEL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 23:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbVAPEEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 23:04:11 -0500
Received: from fujitsu0.fna.fujitsu.com ([192.240.0.5]:44437 "EHLO
	fujitsu0.fujitsu.com") by vger.kernel.org with ESMTP
	id S262419AbVAPEDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 23:03:52 -0500
Date: Sat, 15 Jan 2005 20:03:21 -0800
From: Yasunori Goto <ygoto@us.fujitsu.com>
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [RFC] Avoiding fragmentation through different allocator
Cc: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0501122247390.18142@skynet>
References: <D36CE1FCEFD3524B81CA12C6FE5BCAB008C77C45@fmsmsx406.amr.corp.intel.com> <Pine.LNX.4.58.0501122247390.18142@skynet>
Message-Id: <20050115172317.3C0F.YGOTO@us.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.11.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I'm also very interested in your patches, because I'm working for
memory hotplug too.

> On possibility is that we could say that the UserRclm and KernRclm pool
> are always eligible for hotplug and have hotplug banks only satisy those
> allocations pushing KernNonRclm allocations to fixed banks. How is it
> currently known if a bank of memory is hotplug? Is there a node for each
> hotplug bank? If yes, we could flag those nodes to only satisify UserRclm
> and KernRclm allocations and force fallback to other nodes. 

There are 2 types of memory hotplug.

a)SMP machine case
  A some part of memory will be added and removed.

b)NUMA machine case.
  Whole of a node will be able to remove and add.
  However, if a block of memory like DIMM is broken and disabled,
  Its close from a).

How to know where is hotpluggable bank is platform/archtecture
dependent issue. 
 ex) Asking to ACPI.
     Just node0 become unremovable, and other nodes are removable.
     etc...

In current your patch, first attribute of all pages are NoRclm.
But if your patches has interface to decide where will be Rclm for
each arch/platform, it might be good.


> The danger is
> that allocations would fail because non-hotplug banks were already full
> and pageout would not happen because the watermarks were satisified.

In this case, if user can change attribute Rclm area to 
NoRclm, it is better than nothing. 
In hotplug patches, there will be new zone as ZONE_REMOVABLE.
But in this patch, this change attribute is a little bit difficult.
(At first remove the pages from free_area of removable zone, 
 then add them to free_area of Un-removable zone.)
Probably its change is easier in your patch.


> (Bear in mind I can't test hotplug-related issues due to lack of suitable
> hardware)

I also don't have real hotplug machine now. ;-)
I just use software emulation.

> > It looks like you left the per_cpu_pages as-is.  Did you
> > consider separating those as well to reflect kernel vs. user
> > pools?
> >
> 
> I kept the per-cpu caches for UserRclm-style allocations only because
> otherwise a Kernel-nonreclaimable allocation could easily be taken from a
> UserRclm pool.

I agree that dividing per-cpu caches is not good way.
But if Kernel-nonreclaimable allocation use its UserRclm pool, 
its removable memory bank will be harder to remove suddenly.
Is it correct? If so, it is not good for memory hotplug.
Hmmmm.

Anyway, thank you for your patch. It is very interesting.

Bye.

-- 
Yasunori Goto <ygoto at us.fujitsu.com>


