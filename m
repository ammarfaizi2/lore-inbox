Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288248AbSCCVJy>; Sun, 3 Mar 2002 16:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288557AbSCCVJo>; Sun, 3 Mar 2002 16:09:44 -0500
Received: from mnh-1-21.mv.com ([207.22.10.53]:65288 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S288248AbSCCVJi>;
	Sun, 3 Mar 2002 16:09:38 -0500
Message-Id: <200203032112.QAA03497@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: linux-kernel@vger.kernel.org
Subject: [RFC] Arch option to touch newly allocated pages
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 03 Mar 2002 16:12:38 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What I'd like is for the arch to have __alloc_pages touch all pages that it 
has allocated and is about to return.

The reason for this is that for UML, those pages are backed by host memory,
which may or may not be available when they are finally touched at some
arbitrary place in the kernel.  I hit this by tmpfs running out of room
because my UMLs have their memory backed by tmpfs mounted on /tmp.  So, I
want to be able to dirty those pages before they are seen by any other code.

My first guess at what I want in the code is for all the places that 
__alloc_pages says this:

			if (page)
				return page;

to change to this:

			if (page)
				return arch_validate(page);

arch_validate would be defined as basically empty somewhere in a
include/linux/*.h unless the arch has defined one already.  And I may want
to add order to the arg list if it can't be inferred from the page alignment.

My arch_validate would look something like this:

struct page_struct *arch_validate(page_struct *page)
{
	unsigned long zero = 0;
	unsigned long addr = page_address(page);

	set_fs(USER_DS);
	for(i = 0; i < 1 << order; i++){
		if(copy_to_user(addr + i * PAGE_SIZE, &zero, sizeof(zero))){
			set_fs(KERNEL_DS);
			free_pages(addr, order);
			return(NULL);
		}
	}
	set_fs(KERNEL_DS);
	return(page);
}

The use of set_fs/copy_to_user is somewhat hokey, but that's exactly the
effect that I want.  Is there a better way of doing that?

So, is this a reasonable thing to do, and is the above the right way of
getting it?

				Jeff
