Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261258AbSIWNCY>; Mon, 23 Sep 2002 09:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261291AbSIWNCY>; Mon, 23 Sep 2002 09:02:24 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:647 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261258AbSIWNCX>;
	Mon, 23 Sep 2002 09:02:23 -0400
Message-ID: <3D8F1215.8060108@colorfullife.com>
Date: Mon, 23 Sep 2002 15:07:33 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.37: oom stress test crashes immediately
Content-Type: multipart/mixed;
 boundary="------------070607000906050502080907"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070607000906050502080907
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I've added oom handling into the natsemi network driver, but testing it 
was tricky: I immediately ran into oopses.

The attached patch fails kmalloc and kmem_cache_alloc if

		(jiffies%HZ) < HZ/10

with a 5 minute guaranteed success, for the boot process.

Is that something the kernel should survive? Obviously the computer is 
unusable after the 5 minute grace period, but I didn't expect oopses.

-- 

	Manfred

--------------070607000906050502080907
Content-Type: text/plain;
 name="patch-kmalloc-fail"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-kmalloc-fail"

--- 2.5/mm/slab.c	Sat Sep 21 17:03:15 2002
+++ build-2.5/mm/slab.c	Sun Sep 22 16:59:29 2002
@@ -1568,6 +1568,9 @@
  */
 void * kmem_cache_alloc (kmem_cache_t *cachep, int flags)
 {
+	if (jiffies > HZ*300 && (jiffies % HZ) < HZ/10)
+		return NULL;
+
 	return __kmem_cache_alloc(cachep, flags);
 }
 
@@ -1596,6 +1599,9 @@
 {
 	cache_sizes_t *csizep = cache_sizes;
 
+	if (jiffies > HZ*300 && (jiffies % HZ) < HZ/10)
+		return NULL;
+
 	for (; csizep->cs_size; csizep++) {
 		if (size > csizep->cs_size)
 			continue;

--------------070607000906050502080907--

