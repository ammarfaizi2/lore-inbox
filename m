Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030428AbWAMBOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030428AbWAMBOb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 20:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030382AbWAMBOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 20:14:31 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51419 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030369AbWAMBO3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 20:14:29 -0500
Date: Thu, 12 Jan 2006 17:14:25 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Oops in ufs_fill_super at mount time
In-Reply-To: <20060113005450.GA7971@mipter.zuzino.mipt.ru>
Message-ID: <Pine.LNX.4.64.0601121700041.3535@g5.osdl.org>
References: <20060113005450.GA7971@mipter.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 13 Jan 2006, Alexey Dobriyan wrote:
>
> Version 2.6.15-43ecb9a33ba8c93ebbda81d48ca05f0d1bbf9056
> 
> Actually more or less latest -git is affected too, but
> I'm sick of recompiling right now so please wait for bisecting results.

Hmm.. I don't see any recent changes that could affect this. Not after 
2.6.15, but in fact not even after 2.6.14.

Your oops is also interesting in another way...

> Unable to handle kernel paging request at virtual address d734c158
>  printing eip:
> c019f138
> *pde = 0005c067
> *pte = 1734c000
> Oops: 0000 [#1]
> PREEMPT DEBUG_PAGEALLOC

This is a free'd page fault, so it's due to DEBUG_PAGEALLOC rather than a 
wild pointer.

Is that something new for you? Maybe the bug is older, but you've enabled 
PAGEALLOC only recently? Also, out of interest, have you enabled slab 
debugging?

That said, the whole ubh_get_usb_second() and ubh_get_usb_third() thing is 
pretty damn scary. There's no testing of the values passed in at all and 
comparing them to the allocated buffer heads. But from what I can tell, 
ubh_bread_uspi() will zero out any unallocated bh's, and it certainly 
_looks_ like the calculations to calculate "usb2" should fit within the 
sectors that were read..

Very strange.

			Linus
