Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266603AbUIISWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266603AbUIISWy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 14:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266555AbUIISWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 14:22:53 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30662 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266616AbUIISDH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 14:03:07 -0400
Date: Thu, 9 Sep 2004 13:39:29 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] cacheline align pagevec structure
Message-ID: <20040909163929.GA4484@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

I commented this with Andrew before, we can shrink the pagevec structure to 
cacheline align it. It is used all over VM reclaiming and mpage 
pagecache read code.

Right now it is 140 bytes on 64-bit and 72 bytes on 32-bit. Thats just a little bit more 
than a power of 2 (which will cacheline align), so shrink it to be aligned: 64 bytes on 
32bit and 124bytes on 64-bit. 

It now occupies two cachelines most of the time instead of three. 

I changed nr and cold to "unsigned short" because they'll never reach 2 ^ 16.

I do not see a problem with changing pagevec to "15" page pointers either, 
Andrew, is there a special reason for that "16"? Is intentional to align
to 64 kbytes (IO device alignment)? I dont think that matters much because
of the elevator which sorts and merges requests anyway?



Did some reaim benchmarking on 4way PIII (32byte cacheline), with 512MB RAM:

#### stock 2.6.9-rc1-mm4 ####

Peak load Test: Maximum Jobs per Minute 4144.44 (average of 3 runs)
Quick Convergence Test: Maximum Jobs per Minute 4007.86 (average of 3 runs)

Peak load Test: Maximum Jobs per Minute 4207.48 (average of 3 runs)
Quick Convergence Test: Maximum Jobs per Minute 3999.28 (average of 3 runs)

#### shrink-pagevec #####

Peak load Test: Maximum Jobs per Minute 4717.88 (average of 3 runs)
Quick Convergence Test: Maximum Jobs per Minute 4360.59 (average of 3 runs)

Peak load Test: Maximum Jobs per Minute 4493.18 (average of 3 runs)
Quick Convergence Test: Maximum Jobs per Minute 4327.77 (average of 3 runs)


--- linux-2.6.9-rc1-mm4.orig/include/linux/pagevec.h	2004-09-08 16:13:14.000000000 -0300
+++ linux-2.6.9-rc1-mm4/include/linux/pagevec.h	2004-09-08 16:48:51.703401288 -0300
@@ -5,14 +5,14 @@
  * pages.  A pagevec is a multipage container which is used for that.
  */
 
-#define PAGEVEC_SIZE	16
+#define PAGEVEC_SIZE	15
 
 struct page;
 struct address_space;
 
 struct pagevec {
-	unsigned nr;
-	int cold;
+	unsigned short nr;
+	unsigned short cold;
 	struct page *pages[PAGEVEC_SIZE];
 };
 



