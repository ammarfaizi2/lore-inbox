Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264096AbTEWQlL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 12:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264097AbTEWQlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 12:41:11 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:29203 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264096AbTEWQlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 12:41:10 -0400
Date: Fri, 23 May 2003 17:54:13 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: Lothar Wassmann <LW@KARO-electronics.de>, linux-kernel@vger.kernel.org
Subject: Re: [patch] cache flush bug in mm/filemap.c (all kernels >= 2.5.30(at least))
Message-ID: <20030523175413.A4584@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@digeo.com>,
	Lothar Wassmann <LW@KARO-electronics.de>,
	linux-kernel@vger.kernel.org
References: <16076.50160.67366.435042@ipc1.karo> <20030522151156.C12171@flint.arm.linux.org.uk> <16077.55787.797668.329213@ipc1.karo> <20030523022454.61a180dd.akpm@digeo.com> <16077.61981.684846.221686@ipc1.karo> <20030523034551.0f80b17f.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030523034551.0f80b17f.akpm@digeo.com>; from akpm@digeo.com on Fri, May 23, 2003 at 03:45:51AM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 23, 2003 at 03:45:51AM -0700, Andrew Morton wrote:
> Given that there was no page at the virtual address before filemap_nopage
> was called I don't think any CPU cache writeback or invalidation need be
> performed.  Perhaps a writeback or invalidate is missing somewhere in the
> unmap paths, or there is a problem in arch/arm somewhere.

No, I think there is a flush missing somewhere in this path.

What I think is happening is that Lothar is using the PXA with the cache
in write allocate write back mode (Xscale is the first ARM-arch cpu to
have allocate on write caches.)

This means that when IDE copies the data into the buffer using insw or
whatever, it ends up in the VIVT cache rather than memory.  Since we
don't seem to be calling flush_dcache_page(), we never write this data
back to memory for user space to access it via their mapping.

If this is the case, its something I can't test, because I don't have
access to such hardware (I'm currently being kept a hardware pauper
as far as new ARM technologies go.)

> We have a no-op flush_icache_page() in do_no_page(), but I don't know what
> that thing ever did, not what it's doing in there.  (What happens if you
> replace it with a flush_cache_page(vma, address)?)

I don't think this'll help - its asking the wrong bit of cache to be
flushed.  I think we want to replace that flush_icache_page() with
a flush_dcache_page(), but shrug, I don't really know this code well
enough.

> Someone who understands these things better than I is going to have
> to work out where the bug really is, I'm afraid.

I suspect that there's very few people who really understand this area -
you need to know what the block drivers are doing, and everything in
between there and user space.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

