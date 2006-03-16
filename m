Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964877AbWCPWjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877AbWCPWjy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 17:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbWCPWjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 17:39:54 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:59619
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S964877AbWCPWjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 17:39:53 -0500
Date: Thu, 16 Mar 2006 14:39:37 -0800 (PST)
Message-Id: <20060316.143937.06336406.davem@davemloft.net>
To: chris@zankel.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cache Aliasing
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <4419CCCD.8070208@zankel.net>
References: <4419CCCD.8070208@zankel.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Zankel <chris@zankel.net>
Date: Thu, 16 Mar 2006 12:38:37 -0800

> I am stuck trying to figure out why the sparc64 implementation for cache 
> aliasing actually works:
> 
>  From my understanding, any kernel (or driver) function can 
> allocate/free pages with __page_alloc() / free_page(). I couldn't find 
> any place, however, where the cache is flushed in either case, so there 
> might be some residue in the cache.
> 
> During allocation of user pages, the sparc64 implementation might 
> temporarily map that page to a cache-coherent location (TLBTEMP_BASE+x) 
> for {clear|copy}_user_page. At that time, however, couldn't there  still 
> be dirty lines in the other 'half' of the cache from the previous kernel 
> allocation?

It doesn't matter, the user and the kernel never access the other
alias, since the are accessing the page using only that particular
color.

> I'd appreciate any direction where I could find more information about 
> this scenario or where I should look in the kernel code.

When you initially allocate a page, you make stores to initialize
it's contents, so aliasing doesn't matter from the perspective.
The stores will show up in the correct mappings in the D-cache.

The UltraSPARC programmer's reference manual even states this
explicitly: "A change in virtual color when allocating a free
page does not require a D-cache flush because the D-cache is
write-through."
