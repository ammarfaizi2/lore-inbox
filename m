Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268957AbUIMUjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268957AbUIMUjj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 16:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268961AbUIMUjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 16:39:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:28807 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268957AbUIMUjg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 16:39:36 -0400
Date: Mon, 13 Sep 2004 13:39:33 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Christian Borntraeger <linux-kernel@borntraeger.net>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>
Subject: Re: Linux 2.6.9-rc2 : oops
In-Reply-To: <200409132203.08286.linux-kernel@borntraeger.net>
Message-ID: <Pine.LNX.4.58.0409131318320.2378@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409130937050.4094@ppc970.osdl.org>
 <200409132203.08286.linux-kernel@borntraeger.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 Sep 2004, Christian Borntraeger wrote:
>
> I got an oops with 2.6.9-rc2 in free_block. 

The disassembly is:

		mov    0xc04fef10,%edx			edx is "mem_map"
		lea    0x40000000(%ecx),%eax		ecx is virtual address of "obj"
		shr    $0xc,%eax			eax is now pfn
		shl    $0x5,%eax			pfn * sizeof(struct page)
		mov    0x1c(%edx,%eax,1),%ebx		page->lru.prev
****		mov    0x4(%ebx),%edx			*****
		mov    (%ebx),%eax
		mov    %edx,0x4(%eax)
		mov    %eax,(%edx)

and your "%ebx" value is obviously crap. In fact, it looks like your %ecx 
is crap to begin with.

Looks like this code (mm/slab.c: 2131):

                slabp = GET_PAGE_SLAB(virt_to_page(objp));
		list_del(&slabp->list);

and in particular, you have "slabp" in %ebx, and the thing that oopses is 
trying to load "entry->prev" in list_del(). 

Looking at the register state:

	eax: 0080cc00   ebx: 013bab03   ecx: 00660044   edx: c1000000
	esi: c178f7e0   edi: 00000000   ebp: eff09f04   esp: eff09ee8

That "ecx" value looks strange. It should be a kernel virtual address, and 
it isn't.

Looks like somebody is trying to free an invalid address. Sadly, your 
traceback doesn't show _who_, because it's hidden in the buffering.

The only changes to slab itself have been by Christoph lately, I don't 
think that matters. Can you enable slab debugging? That should catch it 
much earlier..

		Linus
