Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263788AbUFKLDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263788AbUFKLDy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 07:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263817AbUFKLDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 07:03:54 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:22031 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S263788AbUFKLDu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 07:03:50 -0400
Date: Fri, 11 Jun 2004 21:03:14 +1000
To: Pavel Machek <pavel@suse.cz>
Cc: mochel@digitalimplant.org, linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: Fix memory leak in swsusp
Message-ID: <20040611110314.GA8592@gondor.apana.org.au>
References: <20040609130451.GA23107@elf.ucw.cz> <E1BYN8O-0008Vg-00@gondolin.me.apana.org.au> <20040610105629.GA367@gondor.apana.org.au> <20040610212448.GD6634@elf.ucw.cz> <20040610233707.GA4741@gondor.apana.org.au> <20040611094844.GC13834@elf.ucw.cz> <20040611101655.GA8208@gondor.apana.org.au> <20040611102327.GF13834@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <20040611102327.GF13834@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 11, 2004 at 12:23:27PM +0200, Pavel Machek wrote:
> 
> If you want more cleanups, copy_pagedir() should be probably replaced
> by simple memset...

Yes that's a great idea.  Here is the patch to do that.  Again it
relies on all the previous patches in this thread.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

===== kernel/power/pmdisk.c 1.86 vs edited =====
--- 1.86/kernel/power/pmdisk.c	2004-06-11 18:23:44 +10:00
+++ edited/kernel/power/pmdisk.c	2004-06-11 21:01:41 +10:00
@@ -732,19 +732,6 @@
 
 /* More restore stuff */
 
-/* FIXME: Why not memcpy(to, from, 1<<pagedir_order*PAGE_SIZE)? */
-static void __init copy_pagedir(suspend_pagedir_t *to, suspend_pagedir_t *from)
-{
-	int i;
-	char *topointer=(char *)to, *frompointer=(char *)from;
-
-	for(i=0; i < 1 << pagedir_order; i++) {
-		copy_page(topointer, frompointer);
-		topointer += PAGE_SIZE;
-		frompointer += PAGE_SIZE;
-	}
-}
-
 #define does_collide(addr) does_collide_order(pm_pagedir_nosave, addr, 0)
 
 /*
@@ -792,7 +779,7 @@
 	 * We have to avoid recursion (not to overflow kernel stack),
 	 * and that's why code looks pretty cryptic 
 	 */
-	suspend_pagedir_t *new_pagedir, *old_pagedir = pm_pagedir_nosave;
+	suspend_pagedir_t *old_pagedir = pm_pagedir_nosave;
 	void **eaten_memory = NULL;
 	void **c = eaten_memory, *m, *f;
 	int err;
@@ -808,8 +795,9 @@
 	while ((m = (void *) __get_free_pages(GFP_ATOMIC, pagedir_order))) {
 		if (!does_collide_order(old_pagedir, (unsigned long)m,
 					pagedir_order)) {
-			pm_pagedir_nosave = new_pagedir = m;
-			copy_pagedir(new_pagedir, old_pagedir);
+			pm_pagedir_nosave =
+				memcpy(m, old_pagedir,
+				       PAGE_SIZE << pagedir_order);
 			err = 0;
 			break;
 		}
--- linux-2.5/kernel/power/swsusp.c.orig	2004-06-11 20:54:24.000000000 +1000
+++ linux-2.5/kernel/power/swsusp.c	2004-06-11 21:02:22.000000000 +1000
@@ -863,19 +863,6 @@
 
 /* More restore stuff */
 
-/* FIXME: Why not memcpy(to, from, 1<<pagedir_order*PAGE_SIZE)? */
-static void copy_pagedir(suspend_pagedir_t *to, suspend_pagedir_t *from)
-{
-	int i;
-	char *topointer=(char *)to, *frompointer=(char *)from;
-
-	for(i=0; i < 1 << pagedir_order; i++) {
-		copy_page(topointer, frompointer);
-		topointer += PAGE_SIZE;
-		frompointer += PAGE_SIZE;
-	}
-}
-
 #define does_collide(addr) does_collide_order(pagedir_nosave, addr, 0)
 
 /*
@@ -923,7 +910,7 @@
 	 * We have to avoid recursion (not to overflow kernel stack),
 	 * and that's why code looks pretty cryptic 
 	 */
-	suspend_pagedir_t *new_pagedir, *old_pagedir = pagedir_nosave;
+	suspend_pagedir_t *old_pagedir = pagedir_nosave;
 	void **eaten_memory = NULL;
 	void **c = eaten_memory, *m, *f;
 	int ret = 0;
@@ -948,8 +935,8 @@
 		printk("out of memory\n");
 		ret = -ENOMEM;
 	} else {
-		pagedir_nosave = new_pagedir = m;
-		copy_pagedir(new_pagedir, old_pagedir);
+		pagedir_nosave =
+			memcpy(m, old_pagedir, PAGE_SIZE << pagedir_order);
 	}
 
 	c = eaten_memory;

--SLDf9lqlvOQaIe6s--
