Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264764AbSJOT0b>; Tue, 15 Oct 2002 15:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264765AbSJOT0a>; Tue, 15 Oct 2002 15:26:30 -0400
Received: from ra.abo.fi ([130.232.213.1]:30414 "EHLO ra.abo.fi")
	by vger.kernel.org with ESMTP id <S264764AbSJOT03>;
	Tue, 15 Oct 2002 15:26:29 -0400
Date: Tue, 15 Oct 2002 22:32:22 +0300 (EEST)
From: Marcus Alanen <maalanen@ra.abo.fi>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: [patch, 2.5] __vmalloc allocates spurious page?
Message-ID: <Pine.LNX.4.44.0210152221080.14143-100000@tuxedo.abo.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I think __vmalloc allocates an unnecessary page. While the virtual 
address space should have a one-page hole in it, that is taken care of 
by get_vm_area. All other routines (particularly map_vm_area)
subtract PAGE_SIZE from area->size before usage, so the last page 
table entry isn't even set up.

The unnecessary page is allocated only if size is initially a multiple 
of PAGE_SIZE, which sounds like a common case.

Marcus

diff -Naurd --exclude-from=/home/maalanen/linux/base/diff_exclude linus-2.5.42/mm/vmalloc.c msa-2.5.42/mm/vmalloc.c
--- linus-2.5.42/mm/vmalloc.c	Sat Oct 12 16:42:57 2002
+++ msa-2.5.42/mm/vmalloc.c	Tue Oct 15 21:53:10 2002
@@ -387,7 +387,7 @@
 	if (!area)
 		return NULL;
 
-	nr_pages = (size+PAGE_SIZE) >> PAGE_SHIFT;
+	nr_pages = (size+PAGE_SIZE-1) >> PAGE_SHIFT;
 	array_size = (nr_pages * sizeof(struct page *));
 
 	area->nr_pages = nr_pages;

-- 
Marcus Alanen                       * Software Construction Laboratory *
marcus.alanen@abo.fi   * http://www.tucs.fi/Research/labs/softcons.php *

