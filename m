Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264197AbTFPTiO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 15:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264198AbTFPTiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 15:38:14 -0400
Received: from paloalto-smrly2.gtei.net ([131.119.246.6]:32403 "EHLO
	paloalto-smrly2.gtei.net") by vger.kernel.org with ESMTP
	id S264197AbTFPTiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 15:38:04 -0400
Message-ID: <6AF24836F3EB074BA5C922466F9E92E10791B5E1@prince.pc.cognex.com>
From: "Lee, Shuyu" <SLee@cognex.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: locking down memory and map_user_kiobuf
Date: Mon, 16 Jun 2003 15:51:35 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all.

I am developing a Linux driver which allows the hardware to DMA image data
directly into an image buffer allocated by a user. Everything appears to be
working in my driver test, until the full application is run. After some
investigation, it seems that my code which should lock down the image buffer
does not really work. When the memory usage is up, the image buffer is paged
out, causing segmentation fault. If I force all pages to be resident by
writing one byte to every page of the image buffer right before I call
map_user_kiobuf(), it seems to work. By the way, I am using RedHat 8.0
(2.4.18-14) and gcc 3.2 that comes with RedHat 8.0

Here is the code that I use to lock down the image buffer allocated by user
and passed to the driver by an ioctl call:
retVal = alloc_kiovec(1, &pDMAField->iobuf);
// Test code: write to one byte of every page of the image buffer here
retVal = map_user_kiobuf(READ, pDMAField->iobuf, (ULONG)pImgVirt, 
                         pDMAField->height * pDMAField->pitch);

My questions are:
1)	Does map_user_kiobuf() only work when the memory to be locked down
is resident? 
2)	Do I need to call lock_kiovec() as well?
3)	I have tried with both "READ" and "WRITE" when calling
map_user_kiobuf(), does it make any difference?
4)	I took a look at map_user_kiobuf() implementation in memory.c
(attached below). It seems that all it does is to force all pages of the
buffer to be paged in, and then to flush the cache. Am I missing anything?

Any help and suggestion would be greatly appreciated.
Shuyu

// From RedHat 8.0: /usr/src/linux-2.4.18-14/mm/memory.c
int map_user_kiobuf(int rw, struct kiobuf *iobuf, unsigned long va, size_t
len)
{
	int pgcount, err;
	struct mm_struct *	mm;
	
	/* Make sure the iobuf is not already mapped somewhere. */
	if (iobuf->nr_pages)
		return -EINVAL;

	mm = current->mm;
	dprintk ("map_user_kiobuf: begin\n");
	
	pgcount = (va + len + PAGE_SIZE - 1)/PAGE_SIZE - va/PAGE_SIZE;
	/* mapping 0 bytes is not permitted */
	if (!pgcount) BUG();
	err = expand_kiobuf(iobuf, pgcount);
	if (err)
		return err;

	iobuf->locked = 0;
	iobuf->offset = va & (PAGE_SIZE-1);
	iobuf->length = len;
	
	/* Try to fault in all of the necessary pages */
	down_read(&mm->mmap_sem);
	/* rw==READ means read from disk, write into memory area */
	err = get_user_pages(current, mm, va, pgcount,
			(rw==READ), 0, iobuf->maplist, NULL);
	up_read(&mm->mmap_sem);
	if (err < 0) {
		unmap_kiobuf(iobuf);
		dprintk ("map_user_kiobuf: end %d\n", err);
		return err;
	}
	iobuf->nr_pages = err;
	while (pgcount--) {
		/* FIXME: flush superflous for rw==READ,
		 * probably wrong function for rw==WRITE
		 */
		flush_dcache_page(iobuf->maplist[pgcount]);
	}
	dprintk ("map_user_kiobuf: end OK\n");
	return 0;
}





