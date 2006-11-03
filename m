Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752755AbWKCAAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755AbWKCAAh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 19:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752756AbWKCAAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 19:00:37 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:2018
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1752755AbWKCAAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 19:00:36 -0500
Date: Thu, 02 Nov 2006 16:00:35 -0800 (PST)
Message-Id: <20061102.160035.85409500.davem@davemloft.net>
To: akpm@osdl.org
Cc: maxextreme@gmail.com, vagabon.xyz@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH update6] drivers: add LCD support
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061102120412.bc25e2d0.akpm@osdl.org>
References: <20061102111311.1b2648c3.akpm@osdl.org>
	<653402b90611021133i35683ac4i5f4da4098373603c@mail.gmail.com>
	<20061102120412.bc25e2d0.akpm@osdl.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Thu, 2 Nov 2006 12:04:12 -0800

> On Thu, 2 Nov 2006 19:33:48 +0000
> "Miguel Ojeda" <maxextreme@gmail.com> wrote:
> 
> > May 2.6.18-new vmalloc
> > related functions help correlating userspace & kernel addresses? I
> > will try them and come with an answer tomorrow.
> > 
> > Quoting http://lwn.net/Articles/2.6-kernel-api/
> > 
> > "Some functions have been added to make it easy for kernel code to
> > allocate a buffer with vmalloc() and map it into user space. They are:
> > 
> >      void *vmalloc_user(unsigned long size);
> >      void *vmalloc_32_user(unsigned long size);
> >      int remap_vmalloc_range(struct vm_area_struct *vma, void *addr,
> >                              unsigned long pgoff);
> > 
> > The first two functions are a form of vmalloc() which obtain memory
> > intended to be mapped into user space; among other things, they zero
> > the entire range to avoid leaking data. vmalloc_32_user() allocates
> > low memory only. A call to remap_vmalloc_range() will complete the
> > job; it will refuse, however, to remap memory which has not been
> > allocated with one of the two functions above."
> 
> No, it doesn't look like those helper functions are designed to handle this.
> 
> I'm really not the person to be asking about this.  I can poke around in
> arch/sparc64/kernel/sys_sparc.c:arch_get_unmapped_area() as well as the
> next guy, and it seems to be doing the right thing for MAP_FIXED, but
> how/whether it handles !MAP_FIXED I do not know.  Ask davem ;)

Unfortunately that code never gets called for MAP_FIXED :-)

I'll comment on these issues and explain what needs to occur,
we have several things that want to do this kind of user/kernel
sharing of ring buffers and similar, so best to get the
infrastructure going to get it right.

As a first approximation, getting remap_vmalloc_range() to do the
right thing is the best way to start this stuff off.
