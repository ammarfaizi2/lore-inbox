Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264080AbTEaAFe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 20:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264081AbTEaAFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 20:05:34 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:49400 "EHLO
	orion.mvista.com") by vger.kernel.org with ESMTP id S264080AbTEaAFd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 20:05:33 -0400
Date: Fri, 30 May 2003 17:18:53 -0700
From: Jun Sun <jsun@mvista.com>
To: linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>
Cc: jsun@mvista.com
Subject: Re: Properly implement flush_dcache_page in 2.4?  (Or is it possible?)
Message-ID: <20030530171853.G1669@mvista.com>
References: <20030530103254.B1669@mvista.com> <20030530190929.E9419@flint.arm.linux.org.uk> <20030530160002.D1669@mvista.com> <20030531001458.H9419@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030531001458.H9419@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sat, May 31, 2003 at 12:14:58AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 31, 2003 at 12:14:58AM +0100, Russell King wrote:
> > In addition, I am not sure if the vma struct will show up in the
> > "shared" list _if_ the page is only mapped in one user process and
> > in kernel (for example, those pages you obtain through get_user_pages()
> > call).
> 
> If a mapping is using MAP_SHARED, my understanding is that the pages should
> appear on the i_mmap_shared list.
>

That is my understanding too.
 
> I don't see a reason to worry about privately mapped pages on the i_mmap
> list since they are private, and therefore shouldn't be updated with
> modifications to other mappings, 

Actually there is, at least in 2.4.  Whenever kernel calls get_user_pages()
it maps a user page into kernel virtual address space.  If kernel modifies
that page, flush_dcache_page() needs to make sure any stale cache data
at user virtual address is flush in order user to see kernel changes.

I have a test case at 

	http://linux.junsun.net/test-programs

(Note, sometimes even if you pass the test, you _may_ still have a wrong
flush_dcache_page() implementation, because stale cache could be flushed 
due to other execution sequences)

I took a brief look of 2.5 code.  It seems this problem should still
exist (of course, assuming the CPU has cache aliasing problem and the
flush_dcache_page() is not properly implemented).  

Actually in 2.5 you may fail the test even if you have a properly implemented
flush_dcache_page().  It appears it lacks another flush_dcache_page()
after the direct_IO is done.  I don't have a working 2.5 on MIPS.  Can't 
verify that. 

Jun
