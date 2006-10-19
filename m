Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946068AbWJSHWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946068AbWJSHWj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 03:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946069AbWJSHWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 03:22:39 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:46258
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1946068AbWJSHWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 03:22:38 -0400
Date: Thu, 19 Oct 2006 00:22:37 -0700 (PDT)
Message-Id: <20061019.002237.130236131.davem@davemloft.net>
To: akpm@osdl.org
Cc: dmonakhov@openvz.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm:D-cache aliasing issue in cow_user_page
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061019001747.7da58920.akpm@osdl.org>
References: <20061018233302.a067d1e7.akpm@osdl.org>
	<20061019.000027.41635681.davem@davemloft.net>
	<20061019001747.7da58920.akpm@osdl.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Thu, 19 Oct 2006 00:17:47 -0700

> On Thu, 19 Oct 2006 00:00:27 -0700 (PDT)
> David Miller <davem@davemloft.net> wrote:
> 
> > Unfortunately, the kernel has just touched the page and thus there are
> > active cache lines for the kernel side mapping.  When we map this into
> > user space, userspace might see stale cachelines instead of the
> > memset() stores.
> 
> hm.  Has it always been that way or did something change?

Always.

> > Architectures typically take care of this in copy_user_page() and
> > clear_user_page().  The absolutely depend upon those two routines
> > being used for anonymous pages, and handle the D-cache issues there.
> 
> Only anonymous pages?  There are zillions of places where we modify
> pagecache without a flush, especially against the blockdev mapping (fs
> metadata).

It's cpu stores that matter, not device DMA and the like, and we have
flush_dcache_page() calls in the correct spots.  You can see that
we take care of this even in places such as the loop driver :-)
