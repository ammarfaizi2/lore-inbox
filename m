Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263880AbTLOUA1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 15:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263914AbTLOUA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 15:00:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:64491 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263880AbTLOUAZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 15:00:25 -0500
Date: Mon, 15 Dec 2003 12:00:08 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
cc: arjanv@redhat.com, Gabriel Paubert <paubert@iram.es>,
       linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       Alan Cox <alan@redhat.com>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Martin Mares <mj@ucw.cz>, zaitcev@redhat.com, hch@infradead.org
Subject: Re: PCI Express support for 2.4 kernel
In-Reply-To: <3FDDBDFE.5020707@intel.com>
Message-ID: <Pine.LNX.4.58.0312151154480.1631@home.osdl.org>
References: <3FDCC171.9070902@intel.com> <3FDCCC12.20808@pobox.com> 
 <3FDD8691.80206@intel.com> <20031215103142.GA8735@iram.es>  <3FDDACA9.1050600@intel.com>
 <1071494155.5223.3.camel@laptop.fenrus.com> <3FDDBDFE.5020707@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Dec 2003, Vladimir Kondratiev wrote:
>
> Should I understand it this way: for system with >=1Gb RAM, I will be
> unable to ioremap 256Mb region?

Yes.

> It looks confusing. On my test system (don't ask details, I am not
> alowed to share this info), I see
> video controller with 256Mb BAR. Does it mean this controller will not
> work as well?

It works, but that's because the kernel doesn't even _try_ to map it into
the kernel virtual address space.

XFree86 maps it into its user address space (which is 3GB, and doesn't
have to try to map much else into it).

> There is alternative solution, for each transaction to ioremap/unmap
> corresponded page.

Nope, you can't do that. It's not really supported from interrupts and
early boot - both of which will want to access PCI config space.

> I don't like it, it involves huge overhead.

Indeed it would. But using fixmaps does _not_.

But a fixmap will be easy to use, and reasonable efficient: it will
allocate just one virtual page, and then it will force a TLB flush when it
switches over the mapping.

You can improve the efficiency by caching the "last fixmap entry" and only
doing "set_fixmap()" when changing devices.

You could also do a per-cpu fixmap, which would help further, but that
ends up being more work too. Probably not worth it, especially as it is
entirely possible that the hardware requires single-threaded access
anyway (ie I would not be surprised at all if the southbridge got very
confused if you tried to do overlapping config accesses)..

		Linus
