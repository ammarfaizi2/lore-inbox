Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267937AbUHKFNO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267937AbUHKFNO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 01:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267943AbUHKFNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 01:13:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:1004 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267937AbUHKFNI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 01:13:08 -0400
Date: Tue, 10 Aug 2004 22:13:01 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: Possible dcache BUG
In-Reply-To: <20040810211849.0d556af4@laptop.delusion.de>
Message-ID: <Pine.LNX.4.58.0408102201510.1839@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org>
 <20040808113930.24ae0273.akpm@osdl.org> <200408100012.08945.gene.heskett@verizon.net>
 <200408102342.12792.gene.heskett@verizon.net> <Pine.LNX.4.58.0408102044220.1839@ppc970.osdl.org>
 <20040810211849.0d556af4@laptop.delusion.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 10 Aug 2004, Udo A. Steinberg wrote:
> 
> I'm currently using 2.6.8-rc4 and I'm seeing the same problem. Each day the
> machine just gets slower and swappier, even though I'm always running the same
> workload. Rebooting helps a lot. The machine has very little memory (128MB).

This is your slab-info sorted according to use:

	bytes used	slab
	----------	-----
	  128,000	filp
	  128,832	size-64
	  142,128	vm_area_struct
	  161,376	size-96
	  184,320	biovec-(256)
	  188,160	biovec-64
	  188,416	pgd
	  188,416	size-1024
	  192,000	biovec-128
	  217,088	size-4096
	  241,664	size-2048
	  290,816	size-512
	  310,464	inode_cache
	  564,144	radix_tree_node
	  608,832	ext3_inode_cache
	  611,520	dentry_cache
	  688,128	size-8192
	  917,504	size-32768
	1,734,048	buffer_head

and that "buffer_head" thing really looks strange. I also wonder what the 
hell is allocating so many 8kB and 32kB entries.

That said, the cumulative slabinfo usage seems to be no more than 
8,924,868 bytes, so it doesn't seem to be slab that is the problem.

> MemTotal:       125124 kB
> MemFree:          1404 kB
> Buffers:         19060 kB
> Cached:          40484 kB
> SwapCached:      33336 kB
> Active:          70176 kB
> Inactive:        41892 kB

"active+inactive" adds up to ~111MB, which together with slab accounts for 
pretty much all your memory. So there isn't anything unaccounted either.

So I suspect it's a balancing issue. Possibly just the slight change in 
slab balancing to fix the highmem problems. Maybe we shrink slab _too_ 
aggressively or something. 

			Linus
