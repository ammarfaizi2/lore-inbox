Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261674AbVCGIKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbVCGIKP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 03:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbVCGIKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 03:10:15 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:6510 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261674AbVCGIKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 03:10:09 -0500
Message-ID: <422C0C5D.3060404@yahoo.com.au>
Date: Mon, 07 Mar 2005 19:10:05 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: akpm@osdl.org
CC: greg@kroah.com, linux-kernel@vger.kernel.org,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: [patch 2/5] setup_per_zone_lowmem_reserve() oops fix
References: <200503042117.j24LHGrx017967@shell0.pdx.osdl.net>
In-Reply-To: <200503042117.j24LHGrx017967@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

akpm@osdl.org wrote:
> If you do 'echo 0 0 > /proc/sys/vm/lowmem_reserve_ratio' the kernel gets a
> divide-by-zero.
> 
> Prevent that, and fiddle with some whitespace too.
> 
> Signed-off-by: Andrew Morton <akpm@osdl.org>

Can we instead have a patch that makes the value zero turn off the
lowmem reserve entirely if it is set to zero?

Just now I was just testing, and found no easy way to do this other
than to make the value large enough that the reserve is insignificant.

So the loop would be something like:

  			for (idx = j-1; idx >= 0; idx--) {
				struct zone *lower_zone;
				lower_zone = pgdat->node_zones + idx;

				lower_zone->lowmem_reserve[j] = 0;
				if (sysctl_lowmem_reserve_ratio[idx] > 0)
					lower_zone->lowmem_reserve[j] = present_pages /
						sysctl_lowmem_reserve_ratio[idx];

				present_pages += lower_zone->present_pages;
			}


