Return-Path: <linux-kernel-owner+w=401wt.eu-S1754588AbXAAXB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754588AbXAAXB6 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 18:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753623AbXAAXB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 18:01:58 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:40404
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753280AbXAAXB5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 18:01:57 -0500
Date: Mon, 01 Jan 2007 15:01:52 -0800 (PST)
Message-Id: <20070101.150152.15266001.davem@davemloft.net>
To: James.Bottomley@SteelEye.com
Cc: arjan@infradead.org, rmk+lkml@arm.linux.org.uk, torvalds@osdl.org,
       miklos@szeredi.hu, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, akpm@osdl.org
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all
 that again
From: David Miller <davem@davemloft.net>
In-Reply-To: <1167669252.5302.57.camel@mulgrave.il.steeleye.com>
References: <1167557242.20929.647.camel@laptopd505.fenrus.org>
	<20061231.014756.112264804.davem@davemloft.net>
	<1167669252.5302.57.camel@mulgrave.il.steeleye.com>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Bottomley <James.Bottomley@SteelEye.com>
Date: Mon, 01 Jan 2007 10:34:12 -0600

> Erm, well the whole reason for the flush_anon_pages() was that you told
> me not to do it in flush_dcache_page() ...
> 
> Although this is perhaps part of the confusion over what
> flush_dcache_page() is actually supposed to do.

I completely agree, it's confusing.  I've tried to make it
"just a hook" where architectures do whatever is necessary
at that point to synchronize things.  It's a poor definition
and gives the implementor not much more than a rope with which
to hang themselves :-)

That's why I'm thinking strongly about perhaps encouraging
people to go the kmap() route.  It would avoid all the flushing
in exchange for some specialized TLB accesses.  If the flushes
are really expensive, and the TLB operations to setup/teardown
the kmap()'s can be relatively cheap, it might be the thing to
do on PARISC.

More and more I like Ralf's kmap() approach because you only
do things exactly where the kernel actually touches the page.
And if it would really help in some way, we can even tag the
kmap() calls with "KMAP_READ" or "KMAP_WRITE" type attributes
as appropriate.  Because let's say you don't want to do the
TLB mapping thing, and still want to actually cache flush,
then this hint about the access could guide what kind of flush
you do.
