Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292707AbSCJB7K>; Sat, 9 Mar 2002 20:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292733AbSCJB7B>; Sat, 9 Mar 2002 20:59:01 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15369 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292707AbSCJB6u>;
	Sat, 9 Mar 2002 20:58:50 -0500
Message-ID: <3C8ABD69.B454F1B9@zip.com.au>
Date: Sat, 09 Mar 2002 17:56:57 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] fix layout of mapped files
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you create a shared mapping of a sparse file, dirty it
and then run msync, all the file's blocks are laid out
backwards:

mnm:/mnt/sda6> 0 bmap foo 
0-0: 530-530 (1)
1-1: 529-529 (1)
2-2: 528-528 (1)
3-3: 527-527 (1)
4-4: 526-526 (1)
5-5: 525-525 (1)
6-6: 524-524 (1)
7-7: 523-523 (1)
8-8: 522-522 (1)
9-9: 521-521 (1)
10-10: 520-520 (1)
11-11: 519-519 (1)
12-12: 518-518 (1)
13-13: 517-517 (1)
14-14: 516-516 (1)
15-15: 515-515 (1)

This is because filemap_sync puts the lowest-index page at
mapping->dirty_pages.prev and the highest at mapping->dirty_pages.next.

I think that by walking the dirty pages list in ascending file
offset order as we instantiate their disk mappings we will generally
get better layout.

mnm:/mnt/sda6> 0 bmap foo2
0-11: 531-542 (12)
12-15: 544-547 (4)


--- linux-2.5.6/mm/filemap.c	Sat Mar  9 00:18:43 2002
+++ 25/mm/filemap.c	Sat Mar  9 17:41:29 2002
@@ -550,7 +550,7 @@ int filemap_fdatasync(struct address_spa
 	spin_lock(&pagecache_lock);
 
         while (!list_empty(&mapping->dirty_pages)) {
-		struct page *page = list_entry(mapping->dirty_pages.next, struct page, list);
+		struct page *page = list_entry(mapping->dirty_pages.prev, struct page, list);
 
 		list_del(&page->list);
 		list_add(&page->list, &mapping->locked_pages);



#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <sys/mman.h>

int main(int argc, char *argv[])
{
	int fd;
	loff_t size = 4096*16;
	char *filename;
	void *mapped_mem;

	if (argc != 2) {
		fprintf(stderr, "Usage; %s filename\n", argv[0]);
		exit(1);
	}

	filename = argv[1];
	fd = open(filename, O_RDWR|O_TRUNC|O_CREAT, 0666);
	if (fd < 0) {
		fprintf(stderr, "%s: Cannot open `%s': %s\n",
			argv[0], filename, strerror(errno));
		exit(1);
	}

	printf("%s: expanding `%s' to size %Ld\n", argv[0], filename, size);
	if (ftruncate(fd, size) < 0) {
		perror("ftruncate");
		exit(1);
	}
	mapped_mem = mmap(0, size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
	if (mapped_mem == MAP_FAILED) {
		perror("mmap");
		exit(1);
	}
	printf("dirtying %Ld bytes of memory\n", size);
	memset(mapped_mem, 0, size);
	msync(mapped_mem, size, MS_SYNC);
	exit(0);
}


-
