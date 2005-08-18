Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbVHRS3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbVHRS3D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 14:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbVHRS3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 14:29:03 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:36567 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932382AbVHRS3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 14:29:01 -0400
Date: Thu, 18 Aug 2005 13:27:19 -0500
From: Robin Holt <holt@sgi.com>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
       linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Cc: Jack Steiner <steiner@sgi.com>
Subject: Re: idle task's task_t allocation on NUMA machines
Message-ID: <20050818182718.GA21490@lnx-holt.americas.sgi.com>
References: <20050818140829.GB8123@implementation.labri.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050818140829.GB8123@implementation.labri.fr>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2005 at 04:08:29PM +0200, Samuel Thibault wrote:
> A solution would be to add to copy_process(), dup_task_struct(),
> alloc_task_struct() and kmem_cache_alloc() the node number on which
> allocation should be performed. This might also be useful if performing
> node load balancing at fork(): one could then allocate task_t directly
> on the new node. It might also be useful when allocating data for
> another node.

Can this be abstracted some?

Let me start with some background.  SGI has a kernel addition we made
on our previous kernel release something we called dplace.  It has a
userland piece and a library which gets configuration information passed
into a kernel driver.

Inside the kernel, we used Process Aggregates (pagg as found on
oss.sgi.com) to track children of a starting process and migrate them
to a desired cpu.

The problem we have with this method is the callout to pagg happens
far too late after the fork to help with some of the more important
user structures like page tables.  We find that most processes have
their pgd and many parts of the pmd allocated remotely.  Although it
is not a significant source of NUMA traffic, it does cause variability
in process run times which becomes exaggerated on larger MPI jobs which
rendezvous at a barrier.

It would be nice to be able to, early in fork, decide on a destination
numa node and cpu list for the task.  If this were done, then changing
allocation of structures like the task_t and page tables could be handled
on a case-by-case basis as we see benefit.  Additionally, it would be
nice if we could make the placement decision logic provide a callback
so we could add tailored placement.

I realize this is a very vague sketch of what I think needs to be done,
but I am sort of in a rush right now and wanted to at least start the
discussion.

Thanks,
Robin
