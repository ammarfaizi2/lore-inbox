Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbUKETh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbUKETh0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 14:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbUKEThZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 14:37:25 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:9101 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261184AbUKETew (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 14:34:52 -0500
Subject: [PATCH] Oops in aio_free_ring on 2.6.9
From: "Darrick J. Wong" <djwong@us.ibm.com>
To: linux-aio@kvack.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1099683260.12365.348.camel@bluebox>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 05 Nov 2004 11:34:20 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In pounding on various i386 machines with a random syscall generator, I
uncovered a situation in which the kernel oopses:

1. Use mmap() to map out as much of the process address
   space as possible.  This is about 2047M on i386.
2. Call io_setup with the first argument set to a
   large (~65000) value.

(These notes reference the mainline 2.6.9 source.)

What happens is that the number of pages required to service the
io_setup request is larger than the block of internally allocated page
pointers (fs/aio.c:126), so aio_setup_ring kmalloc's a blob of struct
page pointers, and initializes these pointers to NULL. (fs/aio.c:130)

Next, the aio_setup_ring function tries to mmap a bunch of pages and
fails, because in step 1 we used up all the address space. 
aio_setup_ring then calls aio_free_ring to tear all of this down.
(fs/aio.c:143)

aio_free_ring sees the block of struct page pointers and calls free_page
(fs/aio.c:88) on the pointers without checking that they're not NULL. 
Unfortunately, they _are_ NULL and *oops*!  My patch amends the function
to include a null pointer check.

I have a simple testcase that causes this oops; see
http://submarine.dyndns.org/~djwong/docs/iosetup_crash.c.  Run
"./iosetup_crash 100 100000 1000000" to reproduce the oops.

This flaw shows up on mainline 2.6.9, Debian 2.6.8 and SLES9 2.6.5 on
four different machines.  The patch is against 2.6.9 mainline and the
problem isn't fixed in 2.6.10-rc1.

Please send replies directly to me, as I'm not subscribed to
linux-kernel or linux-aio.

--Darrick

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>

diff -uprN linux-2.6.9-orig/fs/aio.c linux-2.6.9/fs/aio.c
--- linux-2.6.9-orig/fs/aio.c	2004-10-18 14:54:07.000000000 -0700
+++ linux-2.6.9/fs/aio.c	2004-11-03 08:47:51.000000000 -0800
@@ -85,7 +85,8 @@ static void aio_free_ring(struct kioctx 
 	long i;
 
 	for (i=0; i<info->nr_pages; i++)
-		put_page(info->ring_pages[i]);
+		if (info->ring_pages[i])
+			put_page(info->ring_pages[i]);
 
 	if (info->mmap_size) {
 		down_write(&ctx->mm->mmap_sem);

