Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130032AbRACV7s>; Wed, 3 Jan 2001 16:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130140AbRACV7i>; Wed, 3 Jan 2001 16:59:38 -0500
Received: from jump-isi.interactivesi.com ([207.8.4.2]:37615 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S130111AbRACV7W>; Wed, 3 Jan 2001 16:59:22 -0500
Date: Wed, 3 Jan 2001 15:59:21 -0600
From: Timur Tabi <ttabi@interactivesi.com>
To: Andrea Arcangeli <andrea@suse.de>,
        Linux Kernel Mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20010103225505.R32185@athlon.random>
In-Reply-To: <20010103210714Z129267-457+17@vger.kernel.org> <20010103210714Z129267-457+17@vger.kernel.org> 
	; from ttabi@interactivesi.com on Wed, Jan 03, 2001 at 03:07:03PM -0600
Subject: Re: Should page->count ever be -1?
X-Mailer: The Polarbar Mailer; version=1.19; build=71
Message-Id: <20010103215929Z130111-458+21@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

** Reply to message from Andrea Arcangeli <andrea@suse.de> on Wed, 3 Jan 2001
22:55:05 +0100


> > from page_alloc.c (this is 2.2.18pre15).  It appears that page->count is
> > already zero when this code is executed, and after it's executed, page->count
> > becomes -1 (or more accurately, 0xFFFFFFFF).  Is this acceptable, or is it an
> > error condition?
> 
> It's an error condition. Make sure you marked the page as reserved in the mmap
> callback if it's not an mmio region outside RAM.

I mark the page as reserved when I call ioremap and then unmark it after
ioremap returns, but iounmap will fail if it's still reserved (the same line of
code also checks the reserved bit):

 	if (!PageReserved(page) && atomic_dec_and_test(&page->count)) {
            ^^^^^^^^^^^^^^^^^^^

Is this what you're saying?

iounmap just calls vfree, which does all the work.  However, I'm confused at
this code in vfree:

	vmfree_area_pages(VMALLOC_VMADDR(tmp->addr), tmp->size);
	kfree(tmp);

What's the difference between vmfree_area_pages and kfree?


-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

When replying to a mailing-list message, please direct the reply to the mailing list only.  Don't send another copy to me.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
