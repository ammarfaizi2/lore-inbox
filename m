Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317077AbSEXDU0>; Thu, 23 May 2002 23:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317079AbSEXDUZ>; Thu, 23 May 2002 23:20:25 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:37625 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S317077AbSEXDUY>; Thu, 23 May 2002 23:20:24 -0400
Date: Thu, 23 May 2002 23:20:25 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: linux-fsdevel@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] loop.c forgot a kmap
Message-ID: <20020523232024.A2917@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below fixes a bug in loop.c that causes highmem systems 
to fail spectacularly when a page happens to be allocated in highmem 
by replacing the use of page_address with a kmap/kunmap sequence.  

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."

:r ~/patches/v2.4.19-pre8-loop-kmap.diff
--- /md0/kernels/2.4/v2.4.19-pre8/drivers/block/loop.c	Wed May  8 13:19:02 2002
+++ v2.4.19-pre8/drivers/block/loop.c	Thu May 23 22:44:09 2002
@@ -199,9 +199,9 @@
 		page = grab_cache_page(mapping, index);
 		if (!page)
 			goto fail;
+		kaddr = kmap(page);
 		if (aops->prepare_write(file, page, offset, offset+size))
 			goto unlock;
-		kaddr = page_address(page);
 		flush_dcache_page(page);
 		transfer_result = lo_do_transfer(lo, WRITE, kaddr + offset, data, size, IV);
 		if (transfer_result) {
@@ -216,6 +216,7 @@
 			goto unlock;
 		if (transfer_result)
 			goto unlock;
+		kunmap(page);
 		data += size;
 		len -= size;
 		offset = 0;
@@ -228,6 +229,7 @@
 	return 0;
 
 unlock:
+	kunmap(page);
 	UnlockPage(page);
 	page_cache_release(page);
 fail:
