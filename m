Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262660AbTDEVXI (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 16:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262662AbTDEVXI (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 16:23:08 -0500
Received: from imladris.surriel.com ([66.92.77.98]:3036 "EHLO
	imladris.surriel.com") by vger.kernel.org with ESMTP
	id S262660AbTDEVXH (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 5 Apr 2003 16:23:07 -0500
Date: Sat, 5 Apr 2003 16:34:24 -0500 (EST)
From: Rik van Riel <riel@imladris.surriel.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <akpm@digeo.com>, "" <mbligh@aracnet.com>,
       "" <mingo@elte.hu>, "" <hugh@veritas.com>, "" <dmccr@us.ibm.com>,
       "" <linux-kernel@vger.kernel.org>, "" <linux-mm@kvack.org>
Subject: Re: objrmap and vmtruncate
In-Reply-To: <20030405163003.GD1326@dualathlon.random>
Message-ID: <Pine.LNX.4.50L.0304051614330.2553-100000@imladris.surriel.com>
References: <20030404163154.77f19d9e.akpm@digeo.com> <12880000.1049508832@flay>
 <20030405024414.GP16293@dualathlon.random> <20030404192401.03292293.akpm@digeo.com>
 <20030405040614.66511e1e.akpm@digeo.com> <20030405163003.GD1326@dualathlon.random>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Apr 2003, Andrea Arcangeli wrote:

> I'm not questioning during paging rmap is more efficient than objrmap,
> but your argument about rmap having lower complexity of objrmap and that
> rmap is needed is wrong. The fact is that with your 100 mappings per
> each of the 100 tasks case, both algorithms works in O(N) where N is
> the number of the pagetables mapping the page. No difference in
> complexity.  I don't care how many cycles you spend to reach the 100x100
> pagetables, those are fixed cycles, the fact is that there are 100x100
> pagetables,

Umm no.  The fact that a VMA is "mapping" the page doesn't
mean the page is resident in any page tables.   For example,
think about the MAP_PRIVATE mapping of the relocation tables
from libc.so ... every process will have its own, modified,
copy of that data.  The original page might not be mapped by
the page tables of any processes.

> rmap won't change the complexity of the algorithm at all,

It will for some cases (as shown above), but I agree that for
most common situations objrmap and pte rmap should have very
similar algorithmic complexity in the pageout path.

> that's mandated by the hardware and by your application, we can't do
> better than O(N) with N the number of pagetables to unmap a single page.
> Even rmap has the O(N) complexity, it won't be allowed to reach only 100
> pagetables instead of 100000 pagetables.

There is one common situation where objrmap is O(N^2) while
pte rmap is only O(N).  However, this case isn't interesting
because this workload tends to run mlocked anyway.

This is, of course, Oracle on 32 bit systems with gazillions
of windows into the larger-than-virtual-memory shared memory
area.

This aspect of Oracle can be special-cased with remap_file_pages
and the reverse mapping can be skipped alltogether since Oracle's
shared memory area should (IMHO) be mlocked anyway.

In short, I agree with you that we probably want object rmap for
all the common cases.

cheers,

Rik
-- 
Engineers don't grow up, they grow sideways.
http://www.surriel.com/		http://kernelnewbies.org/
