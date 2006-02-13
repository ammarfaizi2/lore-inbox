Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932441AbWBMTe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbWBMTe6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 14:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbWBMTe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 14:34:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:43410 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932441AbWBMTe5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 14:34:57 -0500
Date: Mon, 13 Feb 2006 11:34:43 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Roland Dreier <rdreier@cisco.com>
cc: "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       openib-general@openib.org, Petr Vandrovec <vandrove@vc.cvut.cz>,
       Badari Pulavarty <pbadari@us.ibm.com>, Hugh Dickins <hugh@veritas.com>
Subject: Re: [openib-general] Re: madvise MADV_DONTFORK/MADV_DOFORK
In-Reply-To: <adar767133j.fsf@cisco.com>
Message-ID: <Pine.LNX.4.64.0602131125180.3691@g5.osdl.org>
References: <20060213154114.GO32041@mellanox.co.il> <Pine.LNX.4.64.0602131104460.3691@g5.osdl.org>
 <adar767133j.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 Feb 2006, Roland Dreier wrote:
> 
> VM_DONTCOPY is hardly used in the kernel, so the semantics aren't very
> precisely defined.

Now, I agree - it's a strange bit, and was initially just done "because we 
can and it seems to be a conceptually valid notion", so it's not used a 
lot.

That said, the semantics shouldn't be all that unexpected:

	#define VM_DONTCOPY  0x00020000		/* Do not copy this vma on fork */

and the usage ends up matching that (except for some really strange issue 
with hugepage counting, which just looks wrong, but never mind).

>		But the idea is that a driver setting VM_DONTCOPY
> probably has a good reason for doing it, and we don't want userspace
> to be able to erase that flag through madvise().

Well, I can't actually see any case where a driver could validly do 
something that confuses the VM enough that clearing that bit could cause 
new problems. 

Put another way: if that is true, then we have bigger issues, and should 
fix those problems instead.

So at most we might have _applications_ that depend on the fork not 
causing a copy-on-write thing (due to the old and broken private mapping 
of ioremapped areas behaviour), but if that's true, then it would have to 
be the driver itself that does the MADV_DOFORK thing, so..

> As Hugh said in his suggestion for a better changelog entry:
> 
>     > Explain that MADV_DONTFORK should be reversible, hence
>     > MADV_DOFORK; but should not be reversible on areas a driver has
>     > so marked, hence VM_DONTFORK distinct from VM_DONTCOPY.
> 
> Perhaps we don't care for now, and we should wait and add
> VM_KERNEL_DONTCOPY later if we really need it.  I honestly don't know.

I can see where Hugh is coming from, but I think it's adding cruft very 
much for a "be very careful" reason.

I would suggest that if you wanted to be very careful, you'd simply 
disallow changing - or perhaps just clearing - that DONTCOPY flag on 
special regions (ie ones that have been marked with VM_IO or VM_RESERVED).

			Linus
