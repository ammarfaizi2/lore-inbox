Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129733AbQLGFtJ>; Thu, 7 Dec 2000 00:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129231AbQLGFs7>; Thu, 7 Dec 2000 00:48:59 -0500
Received: from linuxcare.com.au ([203.29.91.49]:5641 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S129361AbQLGFsu>; Thu, 7 Dec 2000 00:48:50 -0500
From: Anton Blanchard <anton@linuxcare.com.au>
Date: Thu, 7 Dec 2000 16:15:54 +1100
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, riel@conectiva.com.br, davej@suse.de
Subject: [PATCH]: sysctl to tune async and sync bdflush triggers
Message-ID: <20001207161554.A9375@linuxcare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

At the moment the synchronous flush trigger for bdflush is hardwired to be
double the asynchronous one. This is a pain for people with lots of RAM.

This patch adds a new variable to the bdflush sysctl so both can be
tuned independently. It also sets the defaults to 40% and 80% for async and
sync flushing. This has worked fine on my test machines (128M RAM and 2G RAM).

btw: does anything still touch these dummy entries?

Cheers,
Anton


diff -urN linux/fs/buffer.c linux_intel/fs/buffer.c
--- linux/fs/buffer.c	Thu Dec  7 11:24:40 2000
+++ linux_intel/fs/buffer.c	Thu Dec  7 00:08:06 2000
@@ -122,16 +122,17 @@
 				  when trying to refill buffers. */
 		int interval; /* jiffies delay between kupdate flushes */
 		int age_buffer;  /* Time for normal buffer to age before we flush it */
-		int dummy1;    /* unused, was age_super */
+		int nfract_sync; /* Percentage of buffer cache dirty to 
+				    activate bdflush synchronously */
 		int dummy2;    /* unused */
 		int dummy3;    /* unused */
 	} b_un;
 	unsigned int data[N_PARAM];
-} bdf_prm = {{40, 500, 64, 256, 5*HZ, 30*HZ, 5*HZ, 1884, 2}};
+} bdf_prm = {{40, 500, 64, 256, 5*HZ, 30*HZ, 80, 0, 0}};
 
 /* These are the min and max parameter values that we will allow to be assigned */
-int bdflush_min[N_PARAM] = {  0,  10,    5,   25,  0,   1*HZ,   1*HZ, 1, 1};
-int bdflush_max[N_PARAM] = {100,50000, 20000, 20000,600*HZ, 6000*HZ, 6000*HZ, 2047, 5};
+int bdflush_min[N_PARAM] = {  0,  10,    5,   25,  0,   1*HZ,   0, 0, 0};
+int bdflush_max[N_PARAM] = {100,50000, 20000, 20000,600*HZ, 6000*HZ, 100, 0, 0};
 
 /*
  * Rewrote the wait-routines to use the "new" wait-queue functionality,
@@ -1036,9 +1037,9 @@
 	dirty = size_buffers_type[BUF_DIRTY] >> PAGE_SHIFT;
 	tot = nr_free_buffer_pages();
 
-	dirty *= 200;
+	dirty *= 100;
 	soft_dirty_limit = tot * bdf_prm.b_un.nfract;
-	hard_dirty_limit = soft_dirty_limit * 2;
+	hard_dirty_limit = tot * bdf_prm.b_un.nfract_sync;
 
 	/* First, check for the "real" dirty limit. */
 	if (dirty > soft_dirty_limit) {
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
