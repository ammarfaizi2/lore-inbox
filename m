Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265187AbUFBI4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265187AbUFBI4P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 04:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265206AbUFBI4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 04:56:15 -0400
Received: from Spamfilter.post.RO ([80.86.96.12]:53962 "EHLO
	spamfilter.post.ro") by vger.kernel.org with ESMTP id S265187AbUFBI4O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 04:56:14 -0400
From: dahood@post.ro
X-Priority: 3
MIME-Version: 1.0
Message-Id: <40BD9615.000002.22735@server.post.ro>
Date: Wed, 2 Jun 2004 11:55:47 +0300 (EEST)
Content-Type: Text/Plain
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Subject: Locking pages in memory
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to lock some pages from a mmaped user memory (say user_addr). (mmap on a file)
For this I did the following (in a kernel module):
1. with get_user I fault every page into the memory, then I get the physical address of each page.
2. I put PG_reserved and do a get_page on each page.
3. After I finish using the memory, I truncate the file used for mmap to 0, and close the file descriptor(this is done in user space).
4. In kernel space, I do set_page_count to 1, for every page, clear PG_reserved, and do put_page.

My problem is that in kernel 2.4, this works perfectly, while in 2.6, when I do put_page, I get an bad state on page, because page_mapped is not 0 (page->pte.direct != 0), which means that the page in take into account into rmap. But because the page is PG_reserved, I think it shoudn't be.

Is there is something more that I should do in kernel 2.6 if I'm using reserved pages, more than in 2.4?  

In kernel 2.4, I know that is my responsability to set the page count to 1, when I'm sure that there is no one else using the pages, and put_page to kernel. 

I tried a workaround in 2.6, by setting page->pte.direct=0, before doing the final put_page. In this way, the put_page function is happy, but when I try do large allocation in user space program, I keep getting segmentation fault, so I think that the pte.direct hack is not ok.

Thank you,
Dan
