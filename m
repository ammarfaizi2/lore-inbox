Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbVFNQWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbVFNQWe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 12:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVFNQWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 12:22:34 -0400
Received: from dgate2.fujitsu-siemens.com ([217.115.66.36]:42371 "EHLO
	dgate2.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S261229AbVFNQWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 12:22:32 -0400
X-SBRSScore: None
X-IronPort-AV: i="3.93,198,1114984800"; 
   d="scan'208"; a="9401021:sNHT40787230"
Message-ID: <42AF0443.6050209@fujitsu-siemens.com>
Date: Tue, 14 Jun 2005 18:22:27 +0200
From: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Organization: Fujitsu Siemens Computers
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC for 2.6: avoid OOM at bounce buffer storm
References: <42A07BAA.4050303@fujitsu-siemens.com>	<20050603160629.2acc4558.akpm@osdl.org>	<42A5AD4A.6080100@fujitsu-siemens.com>	<20050607120811.6527a9ff.akpm@osdl.org>	<42A73ED8.9040505@fujitsu-siemens.com> <20050608144630.6d167813.akpm@osdl.org>
In-Reply-To: <20050608144630.6d167813.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

> Well.  As I said, I think what you're seeing here is recent changes to
> mm/page-writeback.c which reduce the amount of memory which we'll permit to
> be dirtied due to write() calls.  You'll probably find that the bounce
> buffer problem is also fixable by reducing /proc/sys/vm/dirty_ratio in
> 2.6.9, for the same reasons.
> 
> What concerns me is that there are other ways of dirtying lots of memory
> apart from write(): namely mmap(MAP_SHARED).  If someone dirties 90% of all
> memory via mmap() then we might again get into bounce buffer starvation.

I have tried the mmap(MAP_SHARED) method now extensively. I haven't been 
able to come anywhere near the catastrophic situations I saw with the 
2.6.9 kernel, even by dirtying the full 8GB in fractions of a second.

There was another strangeness there though: Even with the high memory 
pressure applied, The ZONE_NORMAL free memory would never go below 
~300MB. When the mem pressure got too high, the kernel would rather free 
almost slabs and start swapping than use those remaining 300M. It seems 
to me that the new logic is a bit too conservative with ZONE_NORMAL 
allocations.

Regards
Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1        mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy
