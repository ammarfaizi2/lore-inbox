Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261466AbVEJC0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbVEJC0e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 22:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbVEJC0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 22:26:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26791 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261466AbVEJC00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 22:26:26 -0400
Date: Tue, 10 May 2005 03:26:31 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Jeff Dike <jdike@addtoit.com>
Cc: Alexander Nyberg <alexn@telia.com>, Antoine Martin <antoine@nagafix.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.11.8 + UML/x86_64 (2.6.12-rc3+) = oops
Message-ID: <20050510022631.GB1150@parcelfarce.linux.theplanet.co.uk>
References: <20050504191828.620C812EE7@sc8-sf-spam2.sourceforge.net> <1115248927.12088.52.camel@cobra> <1115392141.12197.3.camel@cobra> <1115483506.12131.33.camel@cobra> <1115481468.925.9.camel@localhost.localdomain> <20050507180356.GA10793@ccure.user-mode-linux.org> <20050508001832.GA32143@parcelfarce.linux.theplanet.co.uk> <20050508061044.GB32143@parcelfarce.linux.theplanet.co.uk> <20050509210753.GA1150@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050509210753.GA1150@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2005 at 10:07:53PM +0100, Al Viro wrote:
> 	u) amd64 TT is _still_ buggered due to unmap_fin.o attempts at
> magic.  errno sits in TLS for amd64, so unmap_fin.o gets very interesting
> stuff leaking from libc and messing the link.  IMO that should be dealt
> with by brute force; namely, unmap-$(SUBARCH).S instead of trying to
> play games with pulling stuff from libc.a.  For fsck sake, we are just
> making 3 syscalls there and switcheroo() is as low-level as it gets...
> Will post once that's done...
	OK, actually - C with use of _syscall(); still, per-architecture
due to different calling conventions (mmap() has enough arguments to
trigger irregularities).  That deals with errno / __libc_errno getting
screwed, but there's more...

	v) phys_mappings rbtree gets screwed in fixrange_init() - no
surprise, seeing what it does in
        for ( ; (i < PTRS_PER_PGD) && (vaddr < end); pgd++, i++) {
                pmd = (pmd_t *)pgd;
                for (; (j < PTRS_PER_PMD) && (vaddr != end); pmd++, j++) {
Note that here PTR_PER_PGD and PTRS_PER_PMD are both 512.  Fun...  Liberal
stealing from arch/i386/mm/init.c deals with that one, AFAICS.  Now we have
the following:
	uml/i386 - all variants work
	uml/amd64 TT-only - panics in execve() on /sbin/init (hey, a progress)
	uml/amd64 other variants - work
Now to figure out WTF is happening in that execve()...
