Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964947AbVKGVNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964947AbVKGVNh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 16:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964948AbVKGVNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 16:13:37 -0500
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:11996 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S964947AbVKGVNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 16:13:36 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17263.50063.982995.482530@gargle.gargle.HOWL>
Date: Tue, 8 Nov 2005 00:13:51 +0300
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] vm: writeout watermarks
In-Reply-To: <20051107153337.GB17246@logos.cnet>
References: <4366FA9A.20402@yahoo.com.au>
	<4366FAF5.8020908@yahoo.com.au>
	<4366FB24.5010507@yahoo.com.au>
	<4366FB4B.9000103@yahoo.com.au>
	<20051107153337.GB17246@logos.cnet>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti writes:
 > 
 > Nikita has a customer using large percentage of RAM for 
 > a kernel module, which results in get_dirty_limits() misbehaviour
 > since
 > 
 >         unsigned long available_memory = total_pages;
 > 
 > It should work on the amount of cacheable pages instead.
 > 
 > He's got a patch but I dont remember the URL. Nikita?

http://linuxhacker.ru/~nikita/patches/2.6.14-rc5/09-throttle-against-free-memory.patch

It changes balance_dirty_pages() to calculate threshold not from total
amount of physical pages, but from the maximal amount of pages that can
be consumed by the file system cache. This amount is approximated by
total size of LRU list plus free memory (across all zones).

This has a downside of starting write-out earlier, so patch should
probably be accompanied by some tuning of default thresholds.

Nikita.

 > 
 > On Tue, Nov 01, 2005 at 04:21:15PM +1100, Nick Piggin wrote:
 > > 3/3
 > > 
 > > -- 
 > > SUSE Labs, Novell Inc.
 > > 
 > 
 > > Slightly change the writeout watermark calculations so we keep background
 > > and synchronous writeout watermarks in the same ratios after adjusting them.
 > > This ensures we should always attempt to start background writeout before
 > > synchronous writeout.
 > > 
 > > Signed-off-by: Nick Piggin <npiggin@suse.de>
 > > 
 > > 
 > > Index: linux-2.6/mm/page-writeback.c
 > > ===================================================================
 > > --- linux-2.6.orig/mm/page-writeback.c	2005-11-01 13:41:39.000000000 +1100
 > > +++ linux-2.6/mm/page-writeback.c	2005-11-01 14:29:27.000000000 +1100
 > > @@ -165,9 +165,11 @@ get_dirty_limits(struct writeback_state 
 > >  	if (dirty_ratio < 5)
 > >  		dirty_ratio = 5;
 > >  
 > > -	background_ratio = dirty_background_ratio;
 > > -	if (background_ratio >= dirty_ratio)
 > > -		background_ratio = dirty_ratio / 2;
 > > +	/*
 > > +	 * Keep the ratio between dirty_ratio and background_ratio roughly
 > > +	 * what the sysctls are after dirty_ratio has been scaled (above).
 > > +	 */
 > > +	background_ratio = dirty_background_ratio * dirty_ratio/vm_dirty_ratio;
 > >  
 > >  	background = (background_ratio * available_memory) / 100;
 > >  	dirty = (dirty_ratio * available_memory) / 100;
