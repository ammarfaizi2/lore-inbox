Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266116AbUHTKKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266116AbUHTKKq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 06:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266196AbUHTKKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 06:10:45 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:29269 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S266116AbUHTKKX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 06:10:23 -0400
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
To: linux-kernel@vger.kernel.org
Subject: BUG: mmap(): any driver changing addr ignores MAP_FIXED
Date: Tue, 17 Aug 2004 16:53:52 +0200
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200408141252.36943.blaisorblade_personal@yahoo.it>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 2.6 mm/mmap.c:do_mmap_pgoff, about the address where to install the new 
mapping:

        /* Can addr have changed??
         *
         * Answer: Yes, several device drivers can do it in their
         *         f_op->mmap method. -DaveM
         */
        addr = vma->vm_start;

But if I mmaped with MAP_FIXED? MAP_FIXED is accounted for only inside 
get_unmapped_area(); so, if the driver changes the addr, MAP_FIXED is 
actually ignored. Shouldn't we add something like:

if (flags & MAP_FIXED && addr != vma->vm_start) {
   /*fail the mmap() call cleanly*/
  error = -EINVAL;				/*???*/
  goto unmap_and_free_vma;  /*add there a check if(file != NULL) before 
fput()ing it*/
}

But I also have two questions:
1) I cannot find the "several drivers" DaveM speaks about.

In 2.4, there is just drivers/video/epson1356fb.c, for very crappy reasons 
(because the returned address must not be 32 byte aligned, it explains in the 
comment); in 2.6, drivers/video/68328fb.c, and only #ifndef MMU (which is a 
very different case - i.e. providing the physical address instead of 
mmap()'ing). I found them by hand-checking the output of this command:

find drivers/ -type f|xargs grep 'vm_start.*='

Anyway, in both cases the above MAP_FIXED check should be added anyway.
2) Which is a good reason to allow such crap?
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

