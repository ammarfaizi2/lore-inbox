Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263998AbTEWJvh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 05:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264002AbTEWJvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 05:51:36 -0400
Received: from [62.112.80.35] ([62.112.80.35]:44160 "EHLO ipc1.karo")
	by vger.kernel.org with ESMTP id S263998AbTEWJvf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 05:51:35 -0400
Message-ID: <16077.61981.684846.221686@ipc1.karo>
Date: Fri, 23 May 2003 12:04:13 +0200
From: "Lothar Wassmann" <LW@KARO-electronics.de>
To: Andrew Morton <akpm@digeo.com>
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [patch] cache flush bug in mm/filemap.c (all kernels >=
 2.5.30(at least))
In-Reply-To: <20030523022454.61a180dd.akpm@digeo.com>
References: <16076.50160.67366.435042@ipc1.karo>
	<20030522151156.C12171@flint.arm.linux.org.uk>
	<16077.55787.797668.329213@ipc1.karo>
	<20030523022454.61a180dd.akpm@digeo.com>
X-Mailer: VM 7.07 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
> "Lothar Wassmann" <LW@KARO-electronics.de> wrote:
> >
> > And maybe because *every* other call to flush_page_to_ram() has been
> >  replaced by one of the new interface macros except that one in
> >  filemap_nopage() in 'mm/filemap.c'.
> > 
> 
> flush_page_to_ram() has been deleted from the kernel.
> 
Yes, I know. But did you even read, what I have written?

The macro has still been there in 2.5.30, but was already defined as a
NOP. In every source file where it had been used (except filemap.c), it
was already accompanied by a call to one of 'flush_dcache_page',
'flush_icache_page', 'copy_user_page' or 'clear_user_page' which
obviously took over the function that flush_page_to_ram previously
had. Somewhere around 2.5.46 the obsolete macro was removed and the
piece of code in filemap.c is the only location where it has not been
replaced by one of the new macros. This looks very suspicious to me. 

Unfortunately in the i386 Architecture (which I presume is the most
widely spread Linux arch) this macro has always been a NOP, so that
noone could notice it missing somewhere.

> filemap_nopage() is a pagecache function and shouldn't be fiddling with
> cache and/or TLB operations.  Unless it touches the page by hand, which it
> does not.
> 
Ok, but then some function which is called from filemap_nopage()
should have done the job beforehand.

> Please, test a current kernel.
>
Is 2.5.68 current enough? The problem was even better reproducible
with this kernel than with the old one. So I made all my tests with
2.5.68.


Lothar
