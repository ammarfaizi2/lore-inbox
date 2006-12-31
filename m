Return-Path: <linux-kernel-owner+w=401wt.eu-S1030366AbWLaRiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030366AbWLaRiA (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 12:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030369AbWLaRiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 12:38:00 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:3166 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030373AbWLaRh7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 12:37:59 -0500
Date: Sun, 31 Dec 2006 17:37:43 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: davem@davemloft.net, arjan@infradead.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@osdl.org
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all that again
Message-ID: <20061231173743.GD1702@flint.arm.linux.org.uk>
Mail-Followup-To: Miklos Szeredi <miklos@szeredi.hu>, davem@davemloft.net,
	arjan@infradead.org, torvalds@osdl.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	akpm@osdl.org
References: <20061230.212338.92583434.davem@davemloft.net> <20061231092318.GA1702@flint.arm.linux.org.uk> <1167557242.20929.647.camel@laptopd505.fenrus.org> <20061231.014756.112264804.davem@davemloft.net> <20061231100007.GC1702@flint.arm.linux.org.uk> <E1H0zkD-0003uw-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1H0zkD-0003uw-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 31, 2006 at 01:24:53PM +0100, Miklos Szeredi wrote:
> > I'm willing to do that - and I guess this means we can probably do this
> > instead of walking the list of VMAs for the shared mapping, thereby
> > hitting both anonymous and shared mappings with the same code?
> 
> But for the get_user_pages() case there's no point, is there?  The VMA
> and the virtual address is already available, so trying to find it
> again through RMAP doesn't much make sense.
> 
> Users of get_user_pages() don't care about any other mappings (maybe
> ptrace does, I don't know) only about one single user mapping and one
> kernel mapping.
> 
> So using flush_dcache_page() there is an overkill, trying to teach it
> about anonymous pages is not the real solution, flush_dcache_page()
> was never meant to be used on anything but file mapped pages.

It's not actually.  For flush_anon_page() we currently have to flush the
user mapping and the kernel mapping.  For flush_dcache_page(), it's
exactly the same - we have to flush the kernel mapping and the user
mapping.

So having both calls in get_user_pages() actually means we end up flushing
the kernel mapping _twice_ for every page.  _That_ is overkill.

As Dave points out, flush_dcache_page() _should_ take care of anonymous
pages as well (which if you remember was my argument to James, who
absolutely refused to accept it.)

So, since Dave is in agreement with me, I'll be handling this issue as
per the interface designer's (Dave's) suggestions which tie up directly
with my understanding of what should be done in the first place.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
