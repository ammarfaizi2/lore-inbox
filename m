Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263986AbRFIP7w>; Sat, 9 Jun 2001 11:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264259AbRFIP7m>; Sat, 9 Jun 2001 11:59:42 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:14233 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S263986AbRFIP7e>; Sat, 9 Jun 2001 11:59:34 -0400
Message-ID: <3B224613.440AE25C@uow.edu.au>
Date: Sun, 10 Jun 2001 01:51:47 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] truncate_inode_pages
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ftruncate() in this program:

#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>

int clean = 64 * 1024 * 1024;
int dirty = 64 * 1024 * 1024;

main()
{
	int fd = open("foo", O_RDWR|O_TRUNC|O_CREAT, 0666);
	void *mem;

	ftruncate(fd, clean + dirty);
	mem = mmap(0, clean + dirty, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
	memset(mem, 0, clean + dirty);
	msync(mem, clean, MS_SYNC);
	ftruncate(fd, clean);
}


takes 45 seconds CPU time due to the O(clean * dirty) algorithm in
truncate_inode_pages().  The machine is locked up for the duration.
The patch reduces this to 20 milliseconds via an O(clean + dirty)
algorithm.


--- linux-2.4.5/mm/filemap.c	Mon May 28 13:31:49 2001
+++ linux-akpm/mm/filemap.c	Sun Jun 10 01:27:09 2001
@@ -273,15 +273,24 @@
 {
 	unsigned long start = (lstart + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
 	unsigned partial = lstart & (PAGE_CACHE_SIZE - 1);
+	int complete;
 
-repeat:
 	spin_lock(&pagecache_lock);
-	if (truncate_list_pages(&mapping->clean_pages, start, &partial))
-		goto repeat;
-	if (truncate_list_pages(&mapping->dirty_pages, start, &partial))
-		goto repeat;
-	if (truncate_list_pages(&mapping->locked_pages, start, &partial))
-		goto repeat;
+	do {
+		complete = 1;
+		while (truncate_list_pages(&mapping->clean_pages, start, &partial)) {
+			spin_lock(&pagecache_lock);
+			complete = 0;
+		}
+		while (truncate_list_pages(&mapping->dirty_pages, start, &partial)) {
+			spin_lock(&pagecache_lock);
+			complete = 0;
+		}
+		while (truncate_list_pages(&mapping->locked_pages, start, &partial)) {
+			spin_lock(&pagecache_lock);
+			complete = 0;
+		}
+	} while (!complete);
 	spin_unlock(&pagecache_lock);
 }
