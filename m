Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264091AbTGBQ6H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 12:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264082AbTGBQ6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 12:58:07 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:49378
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264091AbTGBQ6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 12:58:02 -0400
Date: Wed, 2 Jul 2003 19:11:59 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Mel Gorman <mel@csn.ul.ie>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What to expect with the 2.6 VM
Message-ID: <20030702171159.GG23578@dualathlon.random>
References: <Pine.LNX.4.53.0307010238210.22576@skynet> <20030701022516.GL3040@dualathlon.random> <Pine.LNX.4.53.0307021641560.11264@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0307021641560.11264@skynet>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 02, 2003 at 04:57:27PM +0100, Mel Gorman wrote:
>    The second reason is avoiding the poor linear search algorithm used by
>    get_unmapped_area() when looking for a large free virtual area. With a
>    large number of mappings, this search is very expensive. It has been

this is true too. however get_unmapped_area never need to find a new
place for the granular usages since mmap is always called with MAP_FIXED for
those.

>    proposed to alter the function to perform a tree based search. This could
>    be a tree of free areas ordered by size for example but none has yet been

it can't be trivially a tree of free areas or (if naturally indexed with
the size of the hole) it would return the smallest-fitting hole, not the
leftmost-smallest-fitting-hole ;). A better solution is possible. Then
everybody will benefit w/o need of userspace changes. It's still pretty
orthogonal with remap_file_pages though.

>    implemented. In the meantime, non-linear mappings are being used to bypass
>    the VM.
> 
>    The third reason is related to frequent page faults associated with linear
>    mappings. A non-linear mapping is able to prefault in all pages that are
>    required by the mapping as it is presumed they will be needed very soon.
>    To some extent, this can be addressed by specifying the MAP_POPULATE when
>    calling mmap() for a normal mapping.

mlock already does it too.

>    This feature has a very serious drawback. The system calls truncate() and
>    mincore() are broken with respect to non-linear mappings. Both calls
>    depend on vm_area_struct>vm_pgoff, which is the offset within
>    the mapped file, but the field is meaningless within a non-linear mapping.
>    This means that truncated files will still have mapped pages that no
>    longer have a physical backing. A number of possible solutions, such as
>    allowing the pages to exist but be anonymous and private to the process,
>    have been suggested but none implemented.

the major reason you didn't mention for remap_file_pages is the rmap
avoidance. There's no rmap backing the remap_file_pages regions, so the
overhead per task is reduced greatly and the box stops running oom
(actually deadlocking for mainline thanks to the oom killer and NOFAIL
default behaviour). since there's no rmap, this in turn means either
this nonlinear vma will swap badly, or it means rmap is totally useless
to swap well. Which in short means either rmap has to go in its current
form (and the usefulness of remap_file_pages would be greatly reduced),
or nonlinear mappings would better stay pinned in ram since they'd
better not be used for the emaulator with 63G of highmem into swap on a
1G host anyways (the sysctl would fix the security detail in pinning
into ram like we're doing today with the largepages in 2.4).

Andrea
