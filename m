Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271577AbRHUGzN>; Tue, 21 Aug 2001 02:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271578AbRHUGzD>; Tue, 21 Aug 2001 02:55:03 -0400
Received: from albatross-ext.wise.edt.ericsson.se ([194.237.142.116]:53501
	"EHLO albatross-ext.wise.edt.ericsson.se") by vger.kernel.org
	with ESMTP id <S271577AbRHUGy5>; Tue, 21 Aug 2001 02:54:57 -0400
Date: Tue, 21 Aug 2001 08:55:02 +0200
From: Istvan Varadi <istvan.varadi@eth.ericsson.se>
To: linux-kernel@vger.kernel.org, mnalis-umsdos@voyager.hr
Cc: torvalds@transmeta.com
Subject: [PATCH] umsdos, kernel 2.4.9
Message-ID: <20010821085501.A10721@duna48.eth.ericsson.se>
Reply-To: ivaradi@freemail.c3.hu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I noticed, that sometimes the EMD file (--linux-.---) does not contain
the full name of the files in the directores, which results in file
not found errors. It happens, e.g. when extracting the HTML version of
the PHP manual (http://www.php.net/manual/en/manual.tar.gz).

The problem occurs when a directory entry crosses a page boundary.
The contents of the second page are copied from the wrong starting
address. The patch below solves this problem.

Istvan

diff -ruN linux-2.4.9.orig/fs/umsdos/emd.c linux-2.4.9/fs/umsdos/emd.c
--- linux-2.4.9.orig/fs/umsdos/emd.c	Sun Aug 19 10:31:51 2001
+++ linux-2.4.9/fs/umsdos/emd.c	Sun Aug 19 10:43:15 2001
@@ -259,10 +259,10 @@
 		p->ctime = cpu_to_le32(entry->ctime);
 		p->rdev = cpu_to_le16(entry->rdev);
 		p->mode = cpu_to_le16(entry->mode);
-		memcpy(p->name,entry->name,
+		memcpy(p->spare,entry->spare,
 			(char *)(page_address(page) + PAGE_CACHE_SIZE) - p->spare);
 		memcpy(page_address(page2),
-				entry->spare+PAGE_CACHE_SIZE-offs,
+				((char*)entry)+PAGE_CACHE_SIZE-offs,
 				offs+info->recsize-PAGE_CACHE_SIZE);
 		ret = mapping->a_ops->commit_write(NULL,page2,0,
 					offs+info->recsize-PAGE_CACHE_SIZE);
