Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314680AbSFJNBN>; Mon, 10 Jun 2002 09:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314707AbSFJNAH>; Mon, 10 Jun 2002 09:00:07 -0400
Received: from [195.63.194.11] ([195.63.194.11]:40199 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314483AbSFJM6k>; Mon, 10 Jun 2002 08:58:40 -0400
Message-ID: <3D0494BE.40208@evision-ventures.com>
Date: Mon, 10 Jun 2002 13:59:58 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>, buendgen@de.ibm.com
Subject: [REVERT] 2.5.21  s390/block/xpram.c
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------060407030403000707080105"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060407030403000707080105
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

During the course of the patch-2.5.21 I noticed the
following attached chunk, which resurrect hardsects array in the
affected code. This is of course entierly bogous.
Please revert this chunk, since it's most propably just
a merge error on behalf of the Big Blue.

Oh well oh well...

--------------060407030403000707080105
Content-Type: text/plain;
 name="bumb-2.5.21.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bumb-2.5.21.diff"

diff -Nru a/drivers/s390/block/xpram.c b/drivers/s390/block/xpram.c
--- a/drivers/s390/block/xpram.c	Sat Jun  8 22:31:51 2002
+++ b/drivers/s390/block/xpram.c	Sat Jun  8 22:31:51 2002
@@ -158,6 +158,7 @@
 /* The following items are obtained through kmalloc() in init_module() */
 
 Xpram_Dev *xpram_devices = NULL;
+int *xpram_hardsects = NULL;
 int *xpram_offsets = NULL;   /* partition offsets */
 
 #define MIN(x,y) ((x) < (y) ? (x) : (y))
@@ -938,7 +939,6 @@
 
 	q = BLK_DEFAULT_QUEUE(major);
 	blk_init_queue (q, xpram_request);
-	blk_queue_hardsect_size(q, xpram_hardsect);
 
 	/* we want to have XPRAM_UNUSED blocks security buffer between devices */
 	mem_usable=xpram_mem_avail-(XPRAM_UNUSED*(xpram_devs-1));
@@ -978,6 +978,16 @@
 		PRINT_DEBUG(" device(%d) offset = %d kB, size = %d kB\n",i, xpram_offsets[i], xpram_sizes[i]);
 #endif
 
+	xpram_hardsects = kmalloc(xpram_devs * sizeof(int), GFP_KERNEL);
+	if (!xpram_hardsects) {
+		PRINT_ERR("Not enough memory for xpram_hardsects\n");
+                PRINT_ERR("Giving up xpram\n");
+		goto fail_malloc_hardsects;
+	}
+	for (i=0; i < xpram_devs; i++) /* all the same hardsect */
+		xpram_hardsects[i] = xpram_hardsect;
+	hardsect_size[major]=xpram_hardsects;
+   
 	/* 
 	 * allocate the devices -- we can't have them static, as the number
 	 * can be specified at load time
@@ -1030,6 +1040,7 @@
 		  goto fail_devfs_register;
 		}
 #endif  /* WHY? */
+				 
 	}
 
 	return 0; /* succeed */
@@ -1042,7 +1053,10 @@
 	}
 	kfree(xpram_devices);
 	kfree (xpram_offsets);
+ fail_malloc_hardsects:
  fail_malloc_devices:
+	kfree(xpram_hardsects);
+	hardsect_size[major] = NULL;
  fail_malloc:
 	/* ???	unregister_chrdev(major, "xpram"); */
 	unregister_blkdev(major, "xpram");
@@ -1072,6 +1086,7 @@
 	int i;
 
 	/* first of all, reset all the data structures */
+	kfree(hardsect_size[major]);
 	kfree(xpram_offsets);
 	blk_clear(major);
 

--------------060407030403000707080105--

