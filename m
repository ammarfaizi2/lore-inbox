Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262659AbTIQK0v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 06:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262675AbTIQK0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 06:26:51 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:8067 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262659AbTIQK0t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 06:26:49 -0400
Date: Wed, 17 Sep 2003 12:26:29 +0200
From: Jens Axboe <axboe@suse.de>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Stephan von Krawczynski <skraw@ithnet.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       neilb@cse.unsw.edu.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: experiences beyond 4 GB RAM with 2.4.22
Message-ID: <20030917102629.GL906@suse.de>
References: <20030916102113.0f00d7e9.skraw@ithnet.com> <Pine.LNX.4.44.0309161009460.1636-100000@logos.cnet> <20030916153658.3081af6c.skraw@ithnet.com> <1063722973.10037.65.camel@dhcp23.swansea.linux.org.uk> <20030917084102.A19276@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030917084102.A19276@bitwizard.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 17 2003, Rogier Wolff wrote:
> On Tue, Sep 16, 2003 at 03:36:14PM +0100, Alan Cox wrote:
> > I/O is a real pain. Also in some cases it might be interesting to try
> > using the extra RAM above the 4G boundary as a giant ram disk and using
> > it as first swap device.
> 
> 4G? Above 4G? The limit should be configurable a lot earlier. 
> 
> I'd want to configure that on the machines I'm installing tomorrow. 
> 4G RAM, but I'd rather not use the highmem stuff. I think the workload
> that this machine is likely to get will work very well with this setup. 
> 
> Why does this have the opportunity to work better than just using the 
> 2 or 4G of RAM? Because after you've used the bottom 1G, that might 
> just remain there, requiring lots of IO to go through bounce buffers
> and memory remappings. By considering the top part of RAM as swap,
> you'll force the important stuff into the more easily accessable
> RAM (Compare to fastram as it was called on the Amiga!). 

You are misunderstanding the problem. You don't use bounce buffers just
because the page happens to reside in high memory, it is only used if
the hardware cannot DMA to it. And that is exactly the problem here with
the 3ware adapter, it cannot dma to > 4GB. So in a 6GB setup (with
potentially 5G of highmem), only the last 2G requires bouncing.

To answer one of the other questions regarding slowdown - it can be
nastier than 2x, remember that for reads the copy back happens inside
the interrupt handler... It would also be interesting to note (with
vmstat 1) whether it's all system time, or if you see something like
kswapd going crazy too. If the attached patch makes a difference, then
it could be a vm issue as well.

Still doesn't change that fact that if you build a machine with 6GB of
RAM and expect it to perform, then you don't add io controllers that
cannot DMA to all of your RAM.

===== mm/highmem.c 1.15 vs edited =====
--- 1.15/mm/highmem.c	Thu Feb 20 21:45:27 2003
+++ edited/mm/highmem.c	Wed Sep 17 12:25:06 2003
@@ -335,7 +335,7 @@
 	struct list_head *tmp;
 	struct page *page;
 
-	page = alloc_page(GFP_NOHIGHIO);
+	page = alloc_page(GFP_ATOMIC);
 	if (page)
 		return page;
 	/*

-- 
Jens Axboe

