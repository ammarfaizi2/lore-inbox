Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265946AbTGBXlq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 19:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265947AbTGBXlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 19:41:39 -0400
Received: from holomorphy.com ([66.224.33.161]:48570 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265946AbTGBXlb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 19:41:31 -0400
Date: Wed, 2 Jul 2003 16:55:40 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Mel Gorman <mel@csn.ul.ie>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What to expect with the 2.6 VM
Message-ID: <20030702235540.GK26348@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>,
	"Martin J. Bligh" <mbligh@aracnet.com>, Mel Gorman <mel@csn.ul.ie>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.53.0307021641560.11264@skynet> <20030702171159.GG23578@dualathlon.random> <461030000.1057165809@flay> <20030702174700.GJ23578@dualathlon.random> <20030702214032.GH20413@holomorphy.com> <20030702220246.GS23578@dualathlon.random> <20030702221551.GH26348@holomorphy.com> <20030702222641.GU23578@dualathlon.random> <20030702231122.GI26348@holomorphy.com> <20030702233014.GW23578@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030702233014.GW23578@dualathlon.random>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 03, 2003 at 01:30:14AM +0200, Andrea Arcangeli wrote:
> yes, as said above it's linear with the number of virtual pages mapped
> unless you use the objrmap to rebuild rmap.
> is this munmap right?

I was describing munlock(); munmap() would do the same except not even
bother trying to allocate the pte_chains and always unmap it from the
processes whose mappings are being fiddled with.


On Wed, Jul 02, 2003 at 04:11:22PM -0700, William Lee Irwin III wrote:
>> for each page this mlock()'er (not _all_ mlock()'ers) maps of this thing
>> 	grab some pagewise lock
>> 	if pte_chain allocation succeeded
>> 		add pte_chain

On Thu, Jul 03, 2003 at 01:30:14AM +0200, Andrea Arcangeli wrote:
> allocated sure, but it has no information yet, you dropped the info in
> mlock

We have the information because I'm describing this as part of doing a
pagetable walk over the mlock()'d area we're munlock()'ing.


On Wed, Jul 02, 2003 at 04:11:22PM -0700, William Lee Irwin III wrote:
>> 	else
>> 		/* you'll need to put anon pages in swapcache in mlock() */
>> 		unmap the page

On Thu, Jul 03, 2003 at 01:30:14AM +0200, Andrea Arcangeli wrote:
> how to unmap? there's no rmap. also there may not be swap at all to
> allocate swapcache from

That doesn't matter; it only has to have an entry in swapper_space's
radix tree. But this actually could mean trouble since things currently
assume swap is preallocated for each entry in swapper_space's page_tree.

Which is fine; just revert to the old chaining semantics for mlock()'d
pages with PG_anon high.


On Wed, Jul 02, 2003 at 04:11:22PM -0700, William Lee Irwin III wrote:
>> 	decrement lockcount
>> 	if lockcount vanished
>> 	park it on the LRU
>> 	drop the pagewise lock
>> Individual mappers whose mappings are not mlock()'d add pte_chains when
>> faulting the things in just like before.

On Thu, Jul 03, 2003 at 01:30:14AM +0200, Andrea Arcangeli wrote:
> Tell me how you reach the pagetable from munlock to do the unmap. If you
> can reach the pagetable, the unmap isn't necessary and you only need to
> rebuild the rmap. and if you can reach the pagetable efficiently w/o
> rmap, it means rmap is useless in the first place.

This algorithm occurs during a pagetable walk of the process we'd unmap
it from; we don't unmap it from all processes, just the current one, and
allow it to take minor faults.


-- wli
