Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270752AbTGNRZf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 13:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270750AbTGNRXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 13:23:00 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:15778 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S270733AbTGNRW2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 13:22:28 -0400
Message-ID: <3F12EA43.3030401@colorfullife.com>
Date: Mon, 14 Jul 2003 19:37:07 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nicolas <linux@1g6.biz>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1 oops mm/slab.c:1631
Content-Type: multipart/mixed;
 boundary="------------030406000409000700020607"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030406000409000700020607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Nicolas wrote:

>kernel BUG at mm/slab.c:1631!
>
 That's
      BUG_ON(GET_PAGE_CACHE(page) != cachep);

Someone called kmem_cache_free(cachep, obj), but cachep is for a 
different object type.

>Call Trace:
>[sys_open+120/133] sys_open+0x78/0x85
>
Within sys_open - probably putname().
I have no idea how the bug could be triggered. If you can easily 
reproduce it: can you try the attached patch? It prints additional data.

And please add more details: Which gcc compiler, which filesystems, etc.

--
    Manfred

--------------030406000409000700020607
Content-Type: text/plain;
 name="patch-slab-cachedebug"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-slab-cachedebug"

--- 2.5/mm/slab.c	2003-07-10 23:27:00.000000000 +0200
+++ build-2.5/mm/slab.c	2003-07-14 19:36:26.000000000 +0200
@@ -1628,7 +1628,13 @@
 	kfree_debugcheck(objp);
 	page = virt_to_page(objp);
 
-	BUG_ON(GET_PAGE_CACHE(page) != cachep);
+	if (GET_PAGE_CACHE(page) != cachep) {
+		printk(KERN_ERR "mismatch in kmem_cache_free: expected cache %p, got %p\n",
+				GET_PAGE_CACHE(page),cachep);
+		printk(KERN_ERR "%p is %s.\n", cachep, cachep->name);
+		printk(KERN_ERR "%p is %s.\n", GET_PAGE_CACHE(page), GET_PAGE_CACHE(page)->name);
+		WARN_ON(1);
+	}
 	slabp = GET_PAGE_SLAB(page);
 
 	if (cachep->flags & SLAB_STORE_USER) {

--------------030406000409000700020607--

