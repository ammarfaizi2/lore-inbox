Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261280AbULHRd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbULHRd2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 12:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbULHRd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 12:33:28 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:15804 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261276AbULHRdX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 12:33:23 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: Anticipatory prefaulting in the page fault handler V1
Date: Wed, 8 Dec 2004 09:33:13 -0800
User-Agent: KMail/1.7
Cc: nickpiggin@yahoo.com.au, Jeff Garzik <jgarzik@pobox.com>,
       torvalds@osdl.org, hugh@veritas.com, benh@kernel.crashing.org,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain> <20041202101029.7fe8b303.cliffw@osdl.org> <Pine.LNX.4.58.0412080920240.27156@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.58.0412080920240.27156@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412080933.13396.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, December 8, 2004 9:24 am, Christoph Lameter wrote:
> Page fault scalability patch and prefaulting. Max prefault order
> increased to 5 (max preallocation of 32 pages):
>
>  Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
> 256  10    8   33.571s   4516.293s 863.021s 36874.099 194356.930
> 256  10   16   33.103s   3737.688s 461.028s 44492.553 363704.484
> 256  10   32   35.094s   3436.561s 321.080s 48326.262 521352.840
> 256  10   64   46.675s   2899.997s 245.020s 56936.124 684214.256
> 256  10  128   85.493s   2890.198s 203.008s 56380.890 826122.524
> 256  10  256   74.299s   1374.973s  99.088s115762.963 1679630.272
> 256  10  512   62.760s    706.559s  53.027s218078.311 3149273.714
>
> We are getting into an almost linear scalability in the high end with
> both patches and end up with a fault rate > 3 mio faults per second.

Nice results!  Any idea how many applications benefit from this sort of 
anticipatory faulting?  It has implications for NUMA allocation.  Imagine an 
app that allocates a large virtual address space and then tries to fault in 
pages near each CPU in turn.  With this patch applied, CPU 2 would be 
referencing pages near CPU 1, and CPU 3 would then fault in 4 pages, which 
would then be used by CPUs 4-6.  Unless I'm missing something...

And again, I'm not sure how important that is, maybe this approach will work 
well in the majority of cases (obviously it's a big win in faults/sec for 
your benchmark, but I wonder about subsequent references from other CPUs to 
those pages).  You can look at /sys/devices/platform/nodeN/meminfo to see 
where the pages are coming from.

Jesse
