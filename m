Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965011AbVINFJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965011AbVINFJI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 01:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965010AbVINFJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 01:09:08 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:29545 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S965011AbVINFJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 01:09:06 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Create __kzalloc_gfp_kernel()
X-Message-Flag: Warning: May contain useful information
References: <Pine.LNX.4.63.0509131116280.3479@excalibur.intercode>
	<20050913120707.74a19800.akpm@osdl.org> <52y8602zl7.fsf@cisco.com>
From: Roland Dreier <rolandd@cisco.com>
Date: Tue, 13 Sep 2005 22:09:00 -0700
In-Reply-To: <52y8602zl7.fsf@cisco.com> (Roland Dreier's message of "Tue, 13
 Sep 2005 18:43:48 -0700")
Message-ID: <52acig2q37.fsf_-_@cisco.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 14 Sep 2005 05:09:02.0642 (UTC) FILETIME=[6C292120:01C5B8EA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, it turns out that your idea of kzalloc_gfp_kernel() does save
a bit.  Here's a patch that shouldn't even make Linus look for a
cattle prod.

[BTW, it's rather amusing watching ld use a gig of memory and several
minutes of CPU time as it strains to link an allyesconfig kernel]

 - R.


Here's a patch to get the effect of having kzalloc_gfp_kernel()
without affecting any callers.  It makes kzalloc() an inline that just
calls __kzalloc_gfp_kernel() if the flags parameter is a compile-time
constant and is GFP_KERNEL, and calls __kzalloc() otherwise.

On an x86_64 allyesconfig kernel, I see the following size:

       text    data     bss     dec     hex filename
    24202272 7609162 1998512 33809946 203e61a ../kbuild-before/vmlinux
    24201601 7609266 1998512 33809379 203e3e3 ../kbuild-after/vmlinux

for a net savings of 671 bytes of text (at a cost of 104 bytes of data
for some reason).  As use of kzalloc() becomes more widespread, this
should get even better.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

diff --git a/include/linux/slab.h b/include/linux/slab.h
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -99,7 +99,16 @@ found:
 	return __kmalloc(size, flags);
 }
 
-extern void *kzalloc(size_t, unsigned int __nocast);
+extern void *__kzalloc(size_t, unsigned int __nocast);
+extern void *__kzalloc_gfp_kernel(size_t);
+
+static inline void *kzalloc(size_t size, unsigned int __nocast flags)
+{
+	if (__builtin_constant_p(flags) && flags == GFP_KERNEL)
+		return __kzalloc_gfp_kernel(size);
+	else
+		return __kzalloc(size, flags);
+}
 
 /**
  * kcalloc - allocate memory for an array. The memory is set to zero.
diff --git a/mm/slab.c b/mm/slab.c
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2985,14 +2985,20 @@ EXPORT_SYMBOL(kmem_cache_free);
  * @size: how many bytes of memory are required.
  * @flags: the type of memory to allocate.
  */
-void *kzalloc(size_t size, unsigned int __nocast flags)
+void *__kzalloc(size_t size, unsigned int __nocast flags)
 {
 	void *ret = kmalloc(size, flags);
 	if (ret)
 		memset(ret, 0, size);
 	return ret;
 }
-EXPORT_SYMBOL(kzalloc);
+EXPORT_SYMBOL(__kzalloc);
+
+void *__kzalloc_gfp_kernel(size_t size)
+{
+	return __kzalloc(size, GFP_KERNEL);
+}
+EXPORT_SYMBOL(__kzalloc_gfp_kernel);
 
 /**
  * kfree - free previously allocated memory
