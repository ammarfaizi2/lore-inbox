Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261793AbUKJNZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbUKJNZQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 08:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbUKJNZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 08:25:16 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:20690 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261793AbUKJNZC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 08:25:02 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16786.5789.465433.655127@thebsh.namesys.com>
Date: Wed, 10 Nov 2004 16:24:45 +0300
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Andrew Morton <akpm@osdl.org>, 76306.1226@compuserve.com,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
Subject: Re: balance_pgdat(): where is total_scanned ever updated?
In-Reply-To: <20041109185221.GA8414@logos.cnet>
References: <200411061418_MC3-1-8E17-8B6C@compuserve.com>
	<20041106161114.1cbb512b.akpm@osdl.org>
	<20041109104220.GB6326@logos.cnet>
	<20041109113620.16b47e28.akpm@osdl.org>
	<20041109180223.GG7632@logos.cnet>
	<20041109134032.124b55fa.akpm@osdl.org>
	<20041109185221.GA8414@logos.cnet>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti writes:

[...]

 > 
 > Another related thing I noted this afternoon is that right now kswapd will
 > always block on full queues:
 > 
 > static int may_write_to_queue(struct backing_dev_info *bdi)
 > {
 >         if (current_is_kswapd())
 >                 return 1;
 >         if (current_is_pdflush())       /* This is unlikely, but why not... */
 >                 return 1;
 >         if (!bdi_write_congested(bdi))
 >                 return 1;
 >         if (bdi == current->backing_dev_info)
 >                 return 1;
 >         return 0;
 > }
 > 
 > We should make kswapd use the "bdi_write_congested" information and avoid
 > blocking on full queues. It should improve performance on multi-device 
 > systems with intense VM loads.

This will have following undesirable side effect: if
may_write_to_queue() returns false, page is not paged out, instead it is
thrown to the head of the inactive queue, thus destroying "LRU
ordering", shrink_list() will dive deeper into inactive list, reclaiming
hotter pages.

It's OK to accidentially skip pageout in direct reclaim path, because

 - we hope most pageout is done by kswapd, and

 - we don't want __alloc_pages() to stall

but _something_ in the kernel should take a pain of actually writing
pages out in LRU order.

 > 
 > Maybe something along the lines 
 > 
 > "if the reclaim ratio is high, do not writepage"
 > "if the reclaim ratio is below high, writepage but not block"
 > "if the reclaim ratio is low, writepage and block"

If kswapd blocking is a concern, inactive list scanning should be
decoupled from actual page-out (a la Solaris): kswapd queues pages to
the yet another kernel thread that calls pageout().

I played with this idea (see
http://nikita.w3.to/code/patches/2-6-10-rc1/async-writepage.txt note
that async_writepage() has to be adjusted to work for kswapd), but while
in some cases (large concurrent builds) it does provide a benefit, in
other cases (heavy write through mmap) it makes throughput slightly
worse.

Besides, this doesn't completely avoid the problem of destroying LRU
ordering, as kswapd still proceeds further through inactive list while
pages are sent out asynchronously.

Nikita.

