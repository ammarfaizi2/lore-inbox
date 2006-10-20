Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030332AbWJTVRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030332AbWJTVRi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 17:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030355AbWJTVRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 17:17:37 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:27152 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030332AbWJTVRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 17:17:36 -0400
Date: Fri, 20 Oct 2006 22:17:23 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Miller <davem@davemloft.net>
Cc: torvalds@osdl.org, nickpiggin@yahoo.com.au, ralf@linux-mips.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org, anemo@mba.ocn.ne.jp,
       linux-arch@vger.kernel.org, schwidefsky@de.ibm.com
Subject: Re: [PATCH 1/3] Fix COW D-cache aliasing on fork
Message-ID: <20061020211723.GF8894@flint.arm.linux.org.uk>
Mail-Followup-To: David Miller <davem@davemloft.net>, torvalds@osdl.org,
	nickpiggin@yahoo.com.au, ralf@linux-mips.org, akpm@osdl.org,
	linux-kernel@vger.kernel.org, anemo@mba.ocn.ne.jp,
	linux-arch@vger.kernel.org, schwidefsky@de.ibm.com
References: <20061020.125851.115909797.davem@davemloft.net> <Pine.LNX.4.64.0610201302090.3962@g5.osdl.org> <20061020205929.GE8894@flint.arm.linux.org.uk> <20061020.140619.11628819.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061020.140619.11628819.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2006 at 02:06:19PM -0700, David Miller wrote:
> From: Russell King <rmk+lkml@arm.linux.org.uk>
> Date: Fri, 20 Oct 2006 21:59:29 +0100
> 
> > However, when I look at this code now, I see _no where_ where we synchronise
> > the cache between the userspace mapping and the kernel space mapping before
> > copying a COW page.
> 
> When the user obtains write access to the page, we'll flush.
> 
> Since there are many locations at which write access can be
> obtained, there are many locations where the synchronization
> is obtained.
> 
> One popular way to obtain the synchronization is to implement
> flush_dcache_page() to flush, and implement clear_page() and
> copy_user_page() to clear and copy pages in kernel space at
> special temporrary mappings whose virtual address will alias
> up properly with userspace's mapping.  That's why we pass a
> virtual address to these two arch functions.

I did say I had a VIVT cache.  With such a cache, the *only* place where
you can read data written via one mapping is via that very same mapping.
There is no other virtual address which will give you coherent access to
the data in another mapping.

The majority of ARMs to date have been VIVT, and the majority of Linux
kernels have worked fine (albiet the "recent" breakage of PIO block IO.)

I'm now in the situation where I come back to look at the MM code and,
to put it quite frankly, I can't see any possible way for ARM to work
with this code.  In practice, however, it does appear to work.  I just
can't see _why_ it's working.

Hence why I'm declaring the "I don't understand" flag and refraining to
endorse the patch - I _can't_ endorse what I don't understand.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
