Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750856AbVLLGug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbVLLGug (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 01:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbVLLGug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 01:50:36 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:13191 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750762AbVLLGuf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 01:50:35 -0500
Date: Sun, 11 Dec 2005 22:50:27 -0800
From: Paul Jackson <pj@sgi.com>
To: Andi Kleen <ak@suse.de>
Cc: ak@suse.de, akpm@osdl.org, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au, Simon.Derr@bull.net, clameter@sgi.com
Subject: Re: [PATCH] Cpuset: rcu optimization of page alloc hook
Message-Id: <20051211225027.dc0483b8.pj@sgi.com>
In-Reply-To: <20051212062141.GB11190@wotan.suse.de>
References: <20051211233130.18000.2748.sendpatchset@jackhammer.engr.sgi.com>
	<20051212032902.GW11190@wotan.suse.de>
	<20051211221110.f94ec92a.pj@sgi.com>
	<20051212062141.GB11190@wotan.suse.de>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi wrote:
> No - i mean a quick check if the cpuset allows all nodes
> for memory allocation.

Good - I think I've already done what you're suggesting, then.

You comment would pertain to the cpuset_zone_allowed() call in
mm/page_alloc.c __alloc_pages(), not to the routine we are
discussing here - cpuset_update_task_memory_state().

There are two key cpuset hooks in the page allocation code path:
 1) cpuset_update_task_memory_state() - which transfers
	changes in the tasks cpuset (where we need locking
	to read) into the task->mems_allowed nodemask (where
	the task can look w/o locks).
 2) cpuset_zone_allowed() - which checks each zone examined
	in the page_alloc() loops to see if it is on an allowed
	node.

The first of these was the primary victim of my patches today,
reducing the cost using RCU, and just now removing the NULL
cpuset check that was only needed during init.

The first of these is called once each page allocation, from
a couple of spots in mm/mempolicy.c.  The second of these is
called from within (now beneath) __alloc_pages(), once each
zone that is considered for providing the requested pages.

==

The second of these was already short circuited, using inline
code as you recommend, in a patch a couple of days ago (I forgot
to cc you directly on the patch, so sent you a separate message
pointing to those patches).

For that one, see the number_of_cpusets global kernel counter, in the
*-mm patch:

  cpuset_number_of_cpusets_optimization

It enables short circuiting with inline code this other key routine
on the memory allocation path: cpuset_zone_allowed().

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
