Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262753AbUCWSL7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 13:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262770AbUCWSL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 13:11:59 -0500
Received: from holomorphy.com ([207.189.100.168]:18048 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262753AbUCWSL5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 13:11:57 -0500
Date: Tue, 23 Mar 2004 10:11:26 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andy Whitcroft <apw@shadowen.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040323181126.GA791@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andy Whitcroft <apw@shadowen.org>,
	Russell King <rmk+lkml@arm.linux.org.uk>,
	Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
	linux-kernel@vger.kernel.org
References: <1079902670.17681.324.camel@imladris.demon.co.uk> <Pine.LNX.4.58.0403211349340.1106@ppc970.osdl.org> <20040321222327.D26708@flint.arm.linux.org.uk> <405E1859.5030906@pobox.com> <20040321225117.F26708@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403211504550.1106@ppc970.osdl.org> <405E23A5.7080903@pobox.com> <Pine.LNX.4.58.0403211542051.1106@ppc970.osdl.org> <20040321235854.H26708@flint.arm.linux.org.uk> <28313883.1080064760@42.150.104.212.access.eclipse.net.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28313883.1080064760@42.150.104.212.access.eclipse.net.uk>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 March 2004 23:58 +0000 Russell King <rmk+lkml@arm.linux.org.uk>
>> Unfortunately this doesn't make dwmw2 happy - he claims to have machines
>> which implement dma_alloc_coherent using RAM which doesn't have any
>> struct page associated with it.

On Tue, Mar 23, 2004 at 05:59:20PM +0000, Andy Whitcroft wrote:
> Would it not be possible to allocate struct page's for these special areas
> of memory?  Worst, worst, worst case could they not represent pages in a
> memory only node in the NUMA sense?  I am sure there is some way they could
> be 'tacked' onto the end of the cmap in reality?

This has already been beaten to death and resolved. dma_mmap_coherent()
is the preferred solution and will have no reliance on the coremap apart
from requiring it when faults are handled (to feed the core API), and
requiring prefaulting when coremap elements are absent for the mapped
areas. More importantly, it allows sane fallback to read()/write() and
understands the results of dma_alloc_coherent(), which virt_to_page(),
whose current use on dma_alloc_coherent()'s results causes driver bugs,
does not.


-- wli
