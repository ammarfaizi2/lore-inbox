Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030271AbVIVL45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030271AbVIVL45 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 07:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030272AbVIVL45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 07:56:57 -0400
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:47004 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S1030271AbVIVL44 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 07:56:56 -0400
To: linux-kernel@vger.kernel.org
cc: Keir.Fraser@cl.cam.ac.uk, akpm@osdl.org, rddunlap@osdl.org,
       cosmos@visi.com
Subject: [PATCH] Fix mmap() of /dev/hpet
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----- =_aaaaaaaaaa0"
Content-ID: <5552.1127390210.0@cl.cam.ac.uk>
Date: Thu, 22 Sep 2005 12:56:50 +0100
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Message-Id: <E1EIPh5-0001Xp-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------- =_aaaaaaaaaa0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5552.1127390210.1@cl.cam.ac.uk>

The address passed to io_remap_pfn_range() in hpet_mmap() does not
need to be converted using __pa(): it is already a physical
address. This bug was found and the patch suggested by Clay Harris. 

I introduced this particular bug when making io_remap_pfn_range
changes a few months ago. In fact mmap()ing /dev/hpet has *never*
previously worked: before my changes __pa() was being executed on an
ioremap()ed virtual address, which is also invalid.

Signed-off-by: Keir Fraser <keir@xensource.com>


------- =_aaaaaaaaaa0
Content-Type: text/plain; name="hpet.patch"; charset="us-ascii"
Content-ID: <5552.1127390210.2@cl.cam.ac.uk>

diff -urpP linux-2.6.14-rc2.old/drivers/char/hpet.c linux-2.6.14-rc2.new/drivers/char/hpet.c
--- linux-2.6.14-rc2.old/drivers/char/hpet.c	2005-09-22 12:47:00.773424663 +0100
+++ linux-2.6.14-rc2.new/drivers/char/hpet.c	2005-09-22 12:47:18.216928551 +0100
@@ -273,7 +273,6 @@ static int hpet_mmap(struct file *file, 
 
 	vma->vm_flags |= VM_IO;
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-	addr = __pa(addr);
 
 	if (io_remap_pfn_range(vma, vma->vm_start, addr >> PAGE_SHIFT,
 					PAGE_SIZE, vma->vm_page_prot)) {

------- =_aaaaaaaaaa0--
