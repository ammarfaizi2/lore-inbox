Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268229AbUJORSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268229AbUJORSV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 13:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268199AbUJORQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 13:16:18 -0400
Received: from holomorphy.com ([207.189.100.168]:50059 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268169AbUJORLw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 13:11:52 -0400
Date: Fri, 15 Oct 2004 10:10:47 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Albert Cahalan <albert@users.sf.net>
Cc: Andrea Arcangeli <andrea@novell.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton OSDL <akpm@osdl.org>,
       Albert Cahalan <albert@users.sourceforge.net>
Subject: Re: per-process shared information
Message-ID: <20041015171047.GM5607@holomorphy.com>
References: <Pine.LNX.4.44.0410151207140.5682-100000@localhost.localdomain> <1097846353.2674.13298.camel@cube> <20041015162000.GB17849@dualathlon.random> <1097857912.2669.13548.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097857912.2669.13548.camel@cube>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2004 at 12:31:52PM -0400, Albert Cahalan wrote:
> Currently, ps uses /proc/*/stat for that. The /proc/*/statm
> file is read to determine TRS and DRS, which are broken now.
> That it, unless you count "ps -o OL_m" format.
> The top program uses /proc/*/statm for many more fields:

And here I refute every last field with a description of what 2.4.x
actually implemented and how its implementation renders the field
gibberish.


On Fri, Oct 15, 2004 at 12:31:52PM -0400, Albert Cahalan wrote:
> %MEM  Memory usage (RES)
> RES   Resident size (kb)

These would be the valid pages installed into pagetable entries,
which differs from RSS by racing with pagetable updates while counting
up pages one-by-one, where it could otherwise just use the RSS count in
the mm.


On Fri, Oct 15, 2004 at 12:31:52PM -0400, Albert Cahalan wrote:
> VIRT  Virtual Image (kb)

This one isn't even close to VSZ in 2.4. This is the number of
allocated non-pte_none() ptes under vmas, which has no bearing on
any meaningful statistics, as not even pagetable space consumption
may be inferred from it due to alignment issues.


On Fri, Oct 15, 2004 at 12:31:52PM -0400, Albert Cahalan wrote:
> SWAP  Swapped size (kb)

This isn't actually calculated by 2.4, and can't be inferred from it
either, as swapped pages are indistinguishable from reserved pages
according to /proc/, most prominently the zero page.


On Fri, Oct 15, 2004 at 12:31:52PM -0400, Albert Cahalan wrote:
> CODE  Code size (kb)

This is the subset of the miscalculated RSS under VM_EXECUTABLE vmas,
hence it's a miscalculated subset of the RSS.


On Fri, Oct 15, 2004 at 12:31:52PM -0400, Albert Cahalan wrote:
> DATA  Data+Stack size (kb)

This is the subset of the miscalculated RSS under VM_GROWSDOWN
vmas, which is incorrect for stack-grows-upward architectures,
or are entirely below 0x60000000, which is pure gibberish.


On Fri, Oct 15, 2004 at 12:31:52PM -0400, Albert Cahalan wrote:
> SHR   Shared Mem size (kb)

page_count(pte_page(pte)) > 1; this is gibberish on numerous levels,
which Hugh pointed out, that is, owing to the references held by
pagecache, swapcache, and the like.


On Fri, Oct 15, 2004 at 12:31:52PM -0400, Albert Cahalan wrote:
> nDRT  Dirty Pages count

A count of dirty ptes, not dirty pages. This is meaningless for
most purposes except perhaps mmap() IO, and it's rather dubious
even then. These are not the dirty physical pages, or anything else
remotely meaningful to common scenarios. For instance, when userspace
uses a single buffer page for numerous write(2) calls, it actually
dirties large amounts of pagecache, but only dirties 1 page according
to this metric. When read/write sharing occurs, there is no trace of
other processes' having dirtied the page. Furthermore, ptes are dirtied
in numerous cases when the page has not been modified. For instance,
when the region has been mapped read/write but only a read fault was
taken. So our last field is meaningless.

Thus we are left with exactly zero fields which are not gibberish in 2.4,
and 2.4.x semantics have no leg left to stand upon.


-- wli
