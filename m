Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289580AbSAON4j>; Tue, 15 Jan 2002 08:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289579AbSAON43>; Tue, 15 Jan 2002 08:56:29 -0500
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:59647 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S289577AbSAON4T>; Tue, 15 Jan 2002 08:56:19 -0500
Subject: Re: [BUG] 2.4.18.3, ide-patch, read_dev_sector hangs in read_cache_page
To: preining@logic.at
Date: Tue, 15 Jan 2002 13:54:57 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, andre@linuxdiskcert.org
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E16QU3F-0005g6-00@libra.cus.cam.ac.uk>
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Norbert,

Could you try this patchlet to fs/partitions/check.c::read_dev_sector() and look if there is any output by dmesg? It's
a bit of a shot in the dark but will at least exclude this as the source for the peoblem...

diff -u -ur linux-2.4.18-pre3-ac2/fs/partitions/check.c linux-2.4.18-pre3-ac2-aia1/fs/partitions/check.c
--- linux-2.4.18-pre3-ac2/fs/partitions/check.c	Fri Oct 12 01:25:10 2001
+++ linux-2.4.18-pre3-ac2-aia1/fs/partitions/check.c	Tue Jan 15 13:21:24 2002
@@ -410,6 +410,14 @@
 	int sect = PAGE_CACHE_SIZE / 512;
 	struct page *page;
 
+	if (mapping->a_ops->sync_page != block_sync_page) {
+		if (mapping->a_ops->sync_page)
+			printk(KERN_CRIT "read_dev_sector: mapping->a_ops->sync_page != block_sync_page!\n");
+		else {
+			printk(KERN_CRIT "read_dev_sector: mapping->a_ops->sync_page is NULL! Setting to default block_sync_page!\n");
+			mapping->a_ops->sync_page = block_sync_page;
+		}
+	}
 	page = read_cache_page(mapping, n/sect,
 			(filler_t *)mapping->a_ops->readpage, NULL);
 	if (!IS_ERR(page)) {


Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/
