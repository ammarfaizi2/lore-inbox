Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268929AbUHMBcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268929AbUHMBcV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 21:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268932AbUHMBcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 21:32:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:60620 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268929AbUHMBbi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 21:31:38 -0400
Date: Thu, 12 Aug 2004 18:31:31 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: Possible dcache BUG
In-Reply-To: <20040812180033.62b389db@laptop.delusion.de>
Message-ID: <Pine.LNX.4.58.0408121813190.1839@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org>
 <20040808113930.24ae0273.akpm@osdl.org> <200408100012.08945.gene.heskett@verizon.net>
 <200408102342.12792.gene.heskett@verizon.net> <Pine.LNX.4.58.0408102044220.1839@ppc970.osdl.org>
 <20040810211849.0d556af4@laptop.delusion.de> <Pine.LNX.4.58.0408102201510.1839@ppc970.osdl.org>
 <Pine.LNX.4.58.0408102213250.1839@ppc970.osdl.org> <20040812180033.62b389db@laptop.delusion.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 12 Aug 2004, Udo A. Steinberg wrote:
> 
> After nearly 2 days of running 2.6.8-rc4 with above patch backed out, the 
> machine has gone back into heavy swapping, being rather unresponsive for
> several minutes. At that time the only bigger applications running were
> X and my mailer, as can be seen in the ps output below.

Your slab usage seems to be:

	cumulative	     usage	name
	=========	    ======	====
		.....
	  2,021,428	   151,552	pgd
	  2,182,804	   161,376	size-96
	  2,367,124	   184,320	biovec-(256)
	  2,559,124	   192,000	biovec-128
	  2,751,124	   192,000	biovec-64
	  2,997,076	   245,952	ext3_inode_cache
	  3,255,124	   258,048	size-1024
	  3,545,940	   290,816	size-512
	  3,843,468	   297,528	radix_tree_node
	  4,153,932	   310,464	inode_cache
	  4,494,972	   341,040	dentry_cache
	  4,994,684	   499,712	size-8192
	  5,912,188	   917,504	size-32768
	105,397,820	99,485,632	size-64

Something pretty much stands out.

What the _heck_ is doing 64-byte allocations and leaking them?

Can you figure out what triggers it for you? If nothing obvious comes to 
mind, could you do something really silly like this

	--- 1.141/mm/slab.c     2004-07-11 01:52:48 -07:00
	+++ edited/mm/slab.c    2004-08-12 18:30:00 -07:00
	@@ -2360,6 +2360,11 @@
	                 */
	                BUG_ON(csizep->cs_cachep == NULL);
	 #endif
	+               if (csizep->cs_size == 64) {
	+                       static unsigned count;
	+                       if (!(4095 & ++count))
	+                               dump_stack();
	+               }
	                return __cache_alloc(flags & GFP_DMA ?
	                         csizep->cs_dmacachep : csizep->cs_cachep, flags);
	        }

(totally whitespace-damaged) which should just print out a stack dump 
every four thoudand allocations, which should give a good clue (somebody 
else might also be allocating those 64-byte things, but _likely_ we'll see 
at least one of the leakers.. Maybe.)


			Linus
