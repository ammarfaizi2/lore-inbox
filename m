Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265257AbTGCSjg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 14:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265261AbTGCSjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 14:39:36 -0400
Received: from holomorphy.com ([66.224.33.161]:62913 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265257AbTGCSjf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 14:39:35 -0400
Date: Thu, 3 Jul 2003 11:53:41 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Rik van Riel <riel@redhat.com>
Cc: Andrea Arcangeli <andrea@suse.de>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Mel Gorman <mel@csn.ul.ie>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What to expect with the 2.6 VM
Message-ID: <20030703185341.GJ20413@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rik van Riel <riel@redhat.com>, Andrea Arcangeli <andrea@suse.de>,
	"Martin J. Bligh" <mbligh@aracnet.com>, Mel Gorman <mel@csn.ul.ie>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030703125839.GZ23578@dualathlon.random> <Pine.LNX.4.44.0307030904260.16582-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307030904260.16582-100000@chimarrao.boston.redhat.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jul 2003, Andrea Arcangeli wrote:
>> even if you don't use largepages as you should, the ram cost of the pte
>> is nothing on 64bit archs, all you care about is to use all the mhz and
>> tlb entries of the cpu.

On Thu, Jul 03, 2003 at 09:06:32AM -0400, Rik van Riel wrote:
> That depends on the number of Oracle processes you have.
> Say that page tables need 0.1% of the space of the virtual
> space they map.  With 1000 Oracle users you'd end up needing
> as much memory in page tables as your shm segment is large.
> Of course, in this situation either the application should
> use large pages or the kernel should simply reclaim the
> page tables (possible while holding the mmap_sem for write).

No, it is not true that pagetable space can be wantonly wasted
on 64-bit.

Try mmap()'ing something sufficiently huge and accessing on average
every PAGE_SIZE'th virtual page, in a single-threaded single process.
e.g. various indexing schemes might do this. This is 1 pagetable page
per page of data (worse if shared), which blows major goats.

There's a reason why those things use inverted pagetables... at any
rate, compacting virtualspace with remap_file_pages() solves it too.

Large pages won't help, since the data isn't contiguous.


-- wli
