Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbUCVAUv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 19:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbUCVAUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 19:20:51 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54546 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261532AbUCVAUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 19:20:48 -0500
Date: Mon, 22 Mar 2004 00:20:41 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>,
       Christoph Hellwig <hch@infradead.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040322002041.I26708@flint.arm.linux.org.uk>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Linus Torvalds <torvalds@osdl.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
	linux-kernel@vger.kernel.org
References: <20040321204931.A11519@infradead.org> <1079902670.17681.324.camel@imladris.demon.co.uk> <Pine.LNX.4.58.0403211349340.1106@ppc970.osdl.org> <20040321222327.D26708@flint.arm.linux.org.uk> <405E1859.5030906@pobox.com> <20040321225117.F26708@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403211504550.1106@ppc970.osdl.org> <405E23A5.7080903@pobox.com> <Pine.LNX.4.58.0403211542051.1106@ppc970.osdl.org> <405E2F0D.3050001@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <405E2F0D.3050001@pobox.com>; from jgarzik@pobox.com on Sun, Mar 21, 2004 at 07:10:53PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2004 at 07:10:53PM -0500, Jeff Garzik wrote:
> For the first kind, please read fb_mmap in drivers/video/fbmem.c.  Look 
> at the _horror_ of ifdefs in exporting the framebuffer.  And that horror 
> is what's often needed when letting userspace mmap(2) PCI memory IO regions.

Most of this:

#if defined(__mc68000__)
...
#elif defined(__mips__)
        pgprot_val(vma->vm_page_prot) &= ~_CACHE_MASK;
        pgprot_val(vma->vm_page_prot) |= _CACHE_UNCACHED;
#elif defined(__sh__)
        pgprot_val(vma->vm_page_prot) &= ~_PAGE_CACHABLE;
#elif defined(__hppa__)
        pgprot_val(vma->vm_page_prot) |= _PAGE_NO_CACHE;
#elif defined(__ia64__) || defined(__arm__)
        vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
#else
#warning What do we have to do here??
#endif

exists because architectures haven't defined their private
pgprot_writecombine() implementations, preferring instead to add
to the preprocessor junk instead.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
