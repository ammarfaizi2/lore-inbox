Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbULHSB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbULHSB0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 13:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbULHR7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 12:59:40 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:38083 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261287AbULHR4H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 12:56:07 -0500
Date: Wed, 8 Dec 2004 09:56:00 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Jesse Barnes <jbarnes@engr.sgi.com>
cc: nickpiggin@yahoo.com.au, Jeff Garzik <jgarzik@pobox.com>,
       torvalds@osdl.org, hugh@veritas.com, benh@kernel.crashing.org,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Anticipatory prefaulting in the page fault handler V1
In-Reply-To: <200412080933.13396.jbarnes@engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0412080952100.27324@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>
 <20041202101029.7fe8b303.cliffw@osdl.org> <Pine.LNX.4.58.0412080920240.27156@schroedinger.engr.sgi.com>
 <200412080933.13396.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Dec 2004, Jesse Barnes wrote:

> Nice results!  Any idea how many applications benefit from this sort of
> anticipatory faulting?  It has implications for NUMA allocation.  Imagine an
> app that allocates a large virtual address space and then tries to fault in
> pages near each CPU in turn.  With this patch applied, CPU 2 would be
> referencing pages near CPU 1, and CPU 3 would then fault in 4 pages, which
> would then be used by CPUs 4-6.  Unless I'm missing something...

Faults are predicted for each thread executing on a different processor.
So each processor does its own predictions which will not generate
preallocations on a different processor (unless the thread is moved to
another processor but that is a very special situation).

> And again, I'm not sure how important that is, maybe this approach will work
> well in the majority of cases (obviously it's a big win in faults/sec for
> your benchmark, but I wonder about subsequent references from other CPUs to
> those pages).  You can look at /sys/devices/platform/nodeN/meminfo to see
> where the pages are coming from.

The origin of the pages has not changed and the existing locality
constraints are observed.

A patch like this is important for applications that allocate and preset
large amounts of memory on startup. It will drastically reduce the startup
times.
