Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbUCUW1L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 17:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbUCUWYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 17:24:53 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:28568 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S261406AbUCUWXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 17:23:24 -0500
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       William Lee Irwin III <wli@holomorphy.com>, rmk@arm.linux.org.uk,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0403211349340.1106@ppc970.osdl.org>
References: <20040320133025.GH9009@dualathlon.random>
	 <20040320144022.GC2045@holomorphy.com>
	 <20040320150621.GO9009@dualathlon.random>
	 <20040320121345.2a80e6a0.akpm@osdl.org>
	 <20040320205053.GJ2045@holomorphy.com>
	 <20040320222639.K6726@flint.arm.linux.org.uk>
	 <20040320224500.GP2045@holomorphy.com>
	 <1079901914.17681.317.camel@imladris.demon.co.uk>
	 <20040321204931.A11519@infradead.org>
	 <1079902670.17681.324.camel@imladris.demon.co.uk>
	 <Pine.LNX.4.58.0403211349340.1106@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1079907795.17681.418.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.2) 
Date: Sun, 21 Mar 2004 22:23:15 +0000
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-03-21 at 13:53 -0800, Linus Torvalds wrote:
> So I really put my veto on "nopage()" returning a PFN. That's just wrong, 
> wrong, wrong. It returns a "struct page" pointer, and it has lots of 
> reasons for that.

That's fine -- I wasn't suggesting nopage() should return a PFN.

I was suggesting that if someone wants to map something they're given by
dma_alloc_coherent() into memory, they should be given a PFN to deal
with -- _not_ a "struct page". Therefore, you can't use nopage() for
mapping dma_coherent memory into userspace.

Basically, we should consider the stuff returned by dma_alloc_coherent
to be 'non-RAM' in the context of your previous statement:
	'If a driver wants to map non-RAM pages, that's perfectly ok,
	but it MUST NOT happen through "nopage()".'

There are machines where you _cannot_ sensibly use host memory for
dma_coherent() allocations, but on which there _is_ a few megabytes of
SRAM hanging off the PCI bus which was put there specifically for that
purpose. So dma_alloc_coherent() returns something for which there is
not a valid 'struct page'.

-- 
dwmw2


