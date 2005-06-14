Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbVFNUjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbVFNUjf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 16:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbVFNUje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 16:39:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43473 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261329AbVFNUjW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 16:39:22 -0400
Date: Tue, 14 Jun 2005 13:38:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC for 2.6: avoid OOM at bounce buffer storm
Message-Id: <20050614133859.0d2a5eab.akpm@osdl.org>
In-Reply-To: <42AF0443.6050209@fujitsu-siemens.com>
References: <42A07BAA.4050303@fujitsu-siemens.com>
	<20050603160629.2acc4558.akpm@osdl.org>
	<42A5AD4A.6080100@fujitsu-siemens.com>
	<20050607120811.6527a9ff.akpm@osdl.org>
	<42A73ED8.9040505@fujitsu-siemens.com>
	<20050608144630.6d167813.akpm@osdl.org>
	<42AF0443.6050209@fujitsu-siemens.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Wilck <martin.wilck@fujitsu-siemens.com> wrote:
>
> Hi Andrew,
> 
> > Well.  As I said, I think what you're seeing here is recent changes to
> > mm/page-writeback.c which reduce the amount of memory which we'll permit to
> > be dirtied due to write() calls.  You'll probably find that the bounce
> > buffer problem is also fixable by reducing /proc/sys/vm/dirty_ratio in
> > 2.6.9, for the same reasons.
> > 
> > What concerns me is that there are other ways of dirtying lots of memory
> > apart from write(): namely mmap(MAP_SHARED).  If someone dirties 90% of all
> > memory via mmap() then we might again get into bounce buffer starvation.
> 
> I have tried the mmap(MAP_SHARED) method now extensively. I haven't been 
> able to come anywhere near the catastrophic situations I saw with the 
> 2.6.9 kernel, even by dirtying the full 8GB in fractions of a second.

OK, thanks.

> There was another strangeness there though: Even with the high memory 
> pressure applied, The ZONE_NORMAL free memory would never go below 
> ~300MB. When the mem pressure got too high, the kernel would rather free 
> almost slabs and start swapping than use those remaining 300M. It seems 
> to me that the new logic is a bit too conservative with ZONE_NORMAL 
> allocations.

Yes, we reserve lots of ZONE_NORMAL memory when performing GFP_HIGHMEM
allocations to avoid a weird corner case in which all of the lowmem memory
is pinned down because some application mlocked a lot of memory.

You can do

	echo 1000 > /proc/sys/vm/lowmem_reserve_ratio 

to get the old behaviour back (I do this all the time).

