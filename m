Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbTD3Ekr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 00:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbTD3Ekr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 00:40:47 -0400
Received: from holomorphy.com ([66.224.33.161]:28880 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262060AbTD3Ekn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 00:40:43 -0400
Date: Tue, 29 Apr 2003 21:52:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: must-fix list for 2.6.0
Message-ID: <20030430045259.GD8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <20030429155731.07811707.akpm@digeo.com> <20030430031914.GC8978@holomorphy.com> <20030429214537.7c6a6aaf.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030429214537.7c6a6aaf.akpm@digeo.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> I didn't notice anything specific here about sys_remap_file_pages() vs.
>> truncate() (sans objrmap); did a fix fly by that I didn't notice,
>> or was it less of an issue than I thought it was?

On Tue, Apr 29, 2003 at 09:45:37PM -0700, Andrew Morton wrote:
> That's just a bug.  We can either go through and unmap all the pages via
> their rmap chains, or mark the vma as nonlinear and just anonymise the pages
> and to heck with the SIGBUS.  I'm not particularly fussed either way
> really...

Okay, I'll just fill in if no one else appears to do the busywork.


William Lee Irwin III <wli@holomorphy.com> wrote:
>> Also, the OOM killer fails to check lowmem; basically it just needs
>> -       if (nr_swap_pages > 0)
>> +       if (nr_swap_pages > 0 && nr_free_buffer_pages() > 0)
>> With that in addition to the OOM killer locking patch I posted and
>> another to completely eliminate mm-less processes from consideration
>> 64GB ia32 (with, of course, my oversized out-of-tree patch) recovers
>> from OOM instead of deadlocking after a mass-killing with swap online.

On Tue, Apr 29, 2003 at 09:45:37PM -0700, Andrew Morton wrote:
> Wanna send patch?

Absolutely; I'll arrange a more organized presentation around Thursday
(yes, I'm among the last-minute OLS people -- it couldn't be helped).


William Lee Irwin III <wli@holomorphy.com> wrote:
>> I'd be interested in more detailed descriptions of the user-level no
>> overcommit, dcacheicache, and truncated ext3 page issues after Thursday.

On Tue, Apr 29, 2003 at 09:45:37PM -0700, Andrew Morton wrote:
> The arithmetic in vm_enough_memory() is woefully inaccurate.  If you have no
> swap and then build up a lot of icache/dcache, vm_enough_memory()
> underestimates the amount of reclaimable memory by a lot and big mallocs
> fail.  If the i/dcache has internal fragmentation it gets even worse.
> I had a brief poke at that a while ago and decided it was basically hopeless.
> I suspect that assuming "all slab pages are reclaimable" would be the best
> fix here.

It sounds like some thought may be necessary if the above approach is
to be improved upon.


On Tue, Apr 29, 2003 at 09:45:37PM -0700, Andrew Morton wrote:
> The ext3 truncate pages are those pages which are on the LRU and have
> buffers, but that's _all_ they have.  They are instantly reclaimable and are
> basically free memory.  Only nobody knows that yet, so vm_enough_memory()
> gets it wrong.  The fix would be to nail these pages more aggressively in
> journal_unmap_buffer(), or to account for them and include that accounting in
> vm_emough_memory().  I'd prefer to just free the dang pages in
> journal_unmap_buffer().

Noted.


William Lee Irwin III <wli@holomorphy.com> wrote:
>> The latter sounds easy to address. It actually sounds like a 2.4.x
>> compatibility fix.

On Tue, Apr 29, 2003 at 09:45:37PM -0700, Andrew Morton wrote:
> davem thinks we shouldn't need it, and I've seen no bug reports that indicate
> that we _do_ need it, but Andi says we do.
> Certainly something needs to be done in that area - a ppc64 box with 16G of
> memory (all ZONE_DMA) cruises along with just 1M of memory free.

Okay, I'll classify that as a back-burner issue.

Thanks.


-- wli
