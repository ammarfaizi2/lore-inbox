Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261812AbVATNe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbVATNe3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 08:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262037AbVATNe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 08:34:29 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:52871 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261812AbVATNeR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 08:34:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=NJ2DJM6HKl+YAxHLKGJft96pndjNwpbVZUIKrryvhFYyEE1my22A5tcPd55GesuStZDMChcwn2Pt9RtpkwRLCUnGjLrELf2eUG6nyONpYQujVdQAUUffKuwPX/bYleHWtpunkEhhrOdHMtClqK15NpGINpjYyh7gsKDwGjBm5Kg=
Message-ID: <73e62045050120053463b7e763@mail.gmail.com>
Date: Thu, 20 Jan 2005 21:34:17 +0800
From: zhan rongkai <zhanrk@gmail.com>
Reply-To: zhan rongkai <zhanrk@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: fix the bug of __free_pages() of mm/page_alloc.c
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH]: fix the bug of __free_pages() of mm/page_alloc.c
=========================================================

The buddy allocator's __free_pages() function seems to be buggy.

The following codes are from kernel 2.6.10:

fastcall void __free_pages(struct page *page, unsigned int order)
{
	if (!PageReserved(page) && put_page_testzero(page)) {
		if (order == 0)
			free_hot_page(page);
		else
			__free_pages_ok(page, order);
	}
}

As you know, before truely freeing all pages, this function calls
put_page_testzero(page) to
drop the refcount of the pages.

But, in fact the macro put_page_testzero(page) **only** drops **one**
page's refcount.
Therefore, if (order > 0), the refcounts of (page+1) ..
(page+(1<<order)-1) are unchanged!
This will cause __free_pages_ok() to dump stack, because it finds some
pages' page_count()
are not zero!

The following is the OOPS of this bug (I make kernel print verbose info):

slab cache: size-32768 is to be destroyed!
__free_pages: order=3, we are freeing page: 001d8740-001d8858
page 001d8740 count: 1
page 001d8768 count: 1
page 001d8790 count: 1
page 001d87b8 count: 1
page 001d87e0 count: 1
page 001d8808 count: 1
page 001d8830 count: 1
page 001d8858 count: 1
put_page_testzero() has been called!
page 001d8740 count: 0
page 001d8768 count: 1
page 001d8790 count: 1
page 001d87b8 count: 1
page 001d87e0 count: 1
page 001d8808 count: 1
page 001d8830 count: 1
page 001d8858 count: 1
Bad page state at __free_pages_ok (in process 'hello', mem_map
00139000, order 3, page 001d8768, i
1)
flags:0x20000000 mapping:00000000 mapped:0 count:1
Backtrace:
Call Trace:
 [<00034b9c>] __free_pages_ok+0x12c/0x1f0
 [<000358d0>] __free_pages+0xd0/0x1a0
 [<000359f4>] free_pages+0x54/0x70
 [<00038df4>] slab_destroy+0x114/0x1e0
 [<0003a0b4>] reap_timer_fnc+0x194/0x300
 [<0001e058>] do_timer+0x58/0x600
 [<0001de7c>] run_timer_softirq+0x10c/0x200
 [<0001ace4>] do_softirq+0xb4/0x140
 [<00124548>] init_bio+0x8/0x200
 [<0000be68>] do_IRQ+0x208/0x280
 [<00124548>] init_bio+0x8/0x200
 [<000e22f8>] handle_IRQ+0x58/0x60
 [<000d7344>] blkdev_ioctl+0x304/0x8f0
 [<00122ca0>] free_bootmem_core+0xa0/0xf0
 [<00124548>] init_bio+0x8/0x200
 [<0001101c>] try_to_wake_up+0x14c/0x250
 [<00011140>] wake_up_process+0x20/0x30
 [<000370a0>] pdflush_operation+0xc0/0xe0
 [<00036ab4>] wb_timer_fn+0x24/0x70
 [<0001de7c>] run_timer_softirq+0x10c/0x200
 [<00123a88>] free_area_init_node+0x158/0x450
 [<00090bb8>] group_reserve_blocks+0x8/0x90
 [<0000ee00>] do_gettimeofday+0xb0/0x160
 ......

Please confirm me! This is a patch to fix this bug:
---------------------------------------------------

--- linux-2.6.10.orig/mm/page_alloc.c	2004-12-25 05:33:51.000000000 +0800
+++ linux-2.6.10/mm/page_alloc.c	2005-01-20 21:31:07.000000000 +0800
@@ -786,9 +786,19 @@
 		free_hot_cold_page(pvec->pages[i], pvec->cold);
 }
 
+static inline int drop_pages_testzero(struct page *page, unsigned int order)
+{
+	int i, ret = 1;
+	struct page *pg = page;
+	
+	for (i = 0; i < (1 << order); i++, pg++)
+		ret &= put_page_testzero(pg);
+	return ret;
+}
+
 fastcall void __free_pages(struct page *page, unsigned int order)
 {
-	if (!PageReserved(page) && put_page_testzero(page)) {
+	if (!PageReserved(page) && drop_pages_testzero(page, order)) {
 		if (order == 0)
 			free_hot_page(page);
 		else



-- 
Rongkai Zhan
