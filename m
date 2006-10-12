Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750879AbWJLTGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbWJLTGf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 15:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbWJLTGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 15:06:35 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:19865 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750879AbWJLTGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 15:06:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=eExLpc/iMhvqCa2NvbSm7x1eaictea/Zd861u9jtnFKAF51nBQ+6TLWjrc9vxUtr9FsoH8cQ6FBXyto0bmNnjd2coQoIwv7aVtlpF9YYXpf18Di/RDxbk8f2jipoobTFt3si/abx2KXDFBpp7ku7o10Y4qOqeeIeQAk8yV4saJ4=
Message-ID: <cda58cb80610121206o6180b3c7n147b8895b8b53d7d@mail.gmail.com>
Date: Thu, 12 Oct 2006 21:06:33 +0200
From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: [PATCH] Fix up mmap_kmem
Cc: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Franck Bui-Huu <fbuihuu@gmail.com>

vma->vm_pgoff is an pfn _offset_ relatif to the begining
of the memory start. The previous code was doing at first:

	vma->vm_pgoff << PAGE_SHIFT

which results into a wrong physical address since some
platforms have a physical mem start that can be different
from 0. After that the previous call __pa() on this
wrong physical address, however __pa() is used to convert
a _virtual_ address into a physical one.

This patch rewrites this convertion. It calculates the
pfn of PAGE_OFFSET which is the pfn of the mem start
then it adds the vma->vm_pgoff to it.

It also uses virt_to_phys() instead of __pa() since the
latter shouldn't be used by drivers.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 drivers/char/mem.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 6511012..a89cb52 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -292,8 +292,8 @@ static int mmap_kmem(struct file * file,
 {
 	unsigned long pfn;

-	/* Turn a kernel-virtual address into a physical page frame */
-	pfn = __pa((u64)vma->vm_pgoff << PAGE_SHIFT) >> PAGE_SHIFT;
+	/* Turn a pfn offset into an absolute pfn */
+	pfn = PFN_DOWN(virt_to_phys((void *)PAGE_OFFSET)) + vma->vm_pgoff;

 	/*
 	 * RED-PEN: on some architectures there is more mapped memory
-- 
1.4.2.1.gcd6f1-dirty
