Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964895AbWBGAjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964895AbWBGAjO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 19:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbWBGAjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 19:39:14 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:28086 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964895AbWBGAjN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 19:39:13 -0500
Date: Mon, 6 Feb 2006 16:39:07 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Paul Jackson <pj@sgi.com>
cc: ak@suse.de, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: OOM behavior in constrained memory situations
In-Reply-To: <20060206145922.3eb3c404.pj@sgi.com>
Message-ID: <Pine.LNX.4.62.0602061627010.19350@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0602061253020.18594@schroedinger.engr.sgi.com>
 <20060206145922.3eb3c404.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Feb 2006, Paul Jackson wrote:

> If it is the case that some code path leads to the OOM killer, then
> I don't agree that memory restrictions such as cpuset constraints
> should mean we avoid the OOM killer.
> 
> I've already changed the OOM killer to only go after tasks in or
> overlapping with the same cpuset.

That is not enough. Memory access may also be restricted by policies
and then the OOM killer will still go postal. If a process has restricted
its memory allocation by either setting up a policy or a cpuset constrain
then the OOM killer should not be called. Instead either the application 
needs to be terminated (if it set the stupid policy) or the cpuset can 
perform something OOM-killer-like on the processes it controls.

In its simplest form this could look like the following patch (missing 
support for vma policies, and its not certain that a process has just 
attempted an allocation constrained by policy if mempolicy is set).

Maybe we need to set a gfp flag for constrained allocations that will
terminate the app?

Index: linux-2.6.16-rc2/mm/page_alloc.c
===================================================================
--- linux-2.6.16-rc2.orig/mm/page_alloc.c	2006-02-02 22:03:08.000000000 -0800
+++ linux-2.6.16-rc2/mm/page_alloc.c	2006-02-06 16:36:20.000000000 -0800
@@ -1011,6 +1011,15 @@ rebalance:
 		if (page)
 			goto got_pg;
 
+		if (current->mempolicy && current->mempolicy->policy == MPOL_BIND)
+			/*
+			 * Process has set up a memory policy which may
+			 * constrain allocations. This is not a case
+			 * for the OOM killer. Terminate the application
+			 * instead.
+			 */
+			return NULL;
+
 		out_of_memory(gfp_mask, order);
 		goto restart;
 	}
