Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbTD3DHA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 23:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261995AbTD3DHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 23:07:00 -0400
Received: from holomorphy.com ([66.224.33.161]:16592 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261973AbTD3DG7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 23:06:59 -0400
Date: Tue, 29 Apr 2003 20:19:14 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: must-fix list for 2.6.0
Message-ID: <20030430031914.GC8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <20030429155731.07811707.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030429155731.07811707.akpm@digeo.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 29, 2003 at 03:57:31PM -0700, Andrew Morton wrote:
> mm/
> ---
> - Overcommit accounting gets wrong answers
>   - underestimates reclaimable slab, gives bogus failures when
>     dcache&icache are large.
>   - gets confused by reclaimable-but-not-freed truncated ext3 pages. 
>     Lame fix exists in -mm.
> - Proper user level no overcommit also requires a root margin adding

I didn't notice anything specific here about sys_remap_file_pages() vs.
truncate() (sans objrmap); did a fix fly by that I didn't notice,
or was it less of an issue than I thought it was?

Also, the OOM killer fails to check lowmem; basically it just needs
-       if (nr_swap_pages > 0)
+       if (nr_swap_pages > 0 && nr_free_buffer_pages() > 0)

With that in addition to the OOM killer locking patch I posted and
another to completely eliminate mm-less processes from consideration
64GB ia32 (with, of course, my oversized out-of-tree patch) recovers
from OOM instead of deadlocking after a mass-killing with swap online.
Not that I'd consider 64GB ia32 a supported platform for 2.5/2.6 (it's
a design limitation IMHO); it merely "stresses the OOM killer harder"
for the purposes of this discussion. Some kind of investigation is
probably needed to determine why eliminating mm-less processes from
consideration is necessary to obtain the desired behavior.

I'd be interested in more detailed descriptions of the user-level no
overcommit, dcacheicache, and truncated ext3 page issues after Thursday.


On Tue, Apr 29, 2003 at 03:57:31PM -0700, Andrew Morton wrote:
> mm/
> ---
> - objrmap: concerns over page reclaim performance at high sharing levels,
>   and interoperation with nonlinear mappings is hairy.
> - Readd and make /proc/sys/vm/freepages writable again so that boxes can be
>   tuned for heavy interrupt load.

The latter sounds easy to address. It actually sounds like a 2.4.x
compatibility fix.


-- wli
