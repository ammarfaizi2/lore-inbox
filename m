Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261657AbUKIUGD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbUKIUGD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 15:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261658AbUKIUGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 15:06:03 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44692 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261657AbUKIUFv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 15:05:51 -0500
Date: Tue, 9 Nov 2004 14:41:13 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Stefan Schmidt <zaphodb@zaphods.net>
Cc: linux-kernel@vger.kernel.org, Lukas Hejtmanek <xhejtman@mail.muni.cz>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <piggin@cyberone.com.au>
Subject: Re: Kernel 2.6.9 Multiple Page Allocation Failures
Message-ID: <20041109164113.GD7632@logos.cnet>
References: <20041103222447.GD28163@zaphods.net> <20041104121722.GB8537@logos.cnet> <20041104181856.GE28163@zaphods.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104181856.GE28163@zaphods.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Nov 04, 2004 at 07:18:57PM +0100, Stefan Schmidt wrote:
> On Thu, Nov 04, 2004 at 10:17:22AM -0200, Marcelo Tosatti wrote:
> > What is min_free_kbytes default on your machine?
> I think it was 768, definitely around 700-800.
> 2.6.9 said:
> Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> Memory: 4058200k/4095936k available (2005k kernel code, 36816k reserved, 995k
> data, 196k init, 3178432k highmem)
> 
> > > I tried the following kernels: 2.6.9-mm1, 2.6.10-rc1-bk12, 2.6.9-rc3-bk6,
> > > 2.6.9-rc3-bk5 all of which froze at some point presenting me only with the
> > > above page allocation failure. (no more sysrq) 
> > This should be harmless as Andrew said - it would be helpful if you could 
> > plug a serial cable to the box - this last oops on the picture doesnt say 
> > much.
> Well right now the machine is running 2.4.28-rc1 with the 3w-9nnn patch by
> Adam Radford from this list and i would like to see it run stable for about a
> day before i give 2.6 another try. I think i'll have a terminal server hooked
> up by then.
> 
> > How intense is the network traffic you're generating?
> I was around 60-80 mbit/s each direction at i think 16k interrupts/s.
> 
> With 2.4.28-rc1 this is currently at 180mbit/s 27kpps up, 116mbit/s 24kpps down 
> still swapping a bit but no kernel messages on this, just around 1.7 rx
> errors/s.
> 
> > 2.6.7 was stable under the same load?
> No, sorry to give you this impression, 2.6.7 is just what some of my collegues
> and i consider the more stable 2.6 kernel under heavy i/o load.
> 
> > Something is definately screwed, and there are quite an amount of 
> > similar reports.
> Can i tell people its ok to see nf_hook_slow in the stack trace as it's
> vm-related? A collegue was quite bluffed when i showed him. ;)
> 
> > XFS also seems to be very memory hungry...
> I have 8 XFS-Filesystems in use here with several thousand files from some k to
> your 'usual' 4GB DVD-image. XFS built as a module at first and then inline but
> that did not change anything off course. 2x200 + 6x250GB that is.


Stefan, Lukas, 

Can you please run your workload which cause 0-order page allocation 
failures with the following patch, pretty please? 

We will have more information on the free areas state when the allocation 
fails.

Andrew, please apply it to the next -mm, will you?


--- a/mm/page_alloc.c	2004-11-04 22:52:03.000000000 -0200
+++ b/mm/page_alloc.c	2004-11-09 16:57:04.823514992 -0200
@@ -902,6 +902,7 @@
 			" order:%d, mode:0x%x\n",
 			p->comm, order, gfp_mask);
 		dump_stack();
+		show_free_areas();
 	}
 	return NULL;
 got_pg:

