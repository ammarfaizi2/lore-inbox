Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbTIKNjh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 09:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbTIKNjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 09:39:37 -0400
Received: from bilbo.math.uni-mannheim.de ([134.155.88.153]:33958 "EHLO
	bilbo.math.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S261281AbTIKNjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 09:39:32 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] kmalloc + memset(foo, 0, bar) = kmalloc0
Date: Thu, 11 Sep 2003 15:40:58 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309111540.58729@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

a (very) simple grep in drivers/ showed more than 300 matches of code like
this:

foo = kmalloc(bar, baz);
if (! foo)
	return -ENOMEM;
memset(foo, 0, sizeof(foo));

Why not add a small inlined function doing the memset for us
and reducing the code to

foo = kmalloc0(bar, baz);
if (! foo)
	return -ENOMEM;

Eike

--- linux-2.6.0-test5-bk1/include/linux/slab.h	2003-09-11 15:19:40.000000000 +0200
+++ linux-2.6.0-test5-bk1-caliban/include/linux/slab.h	2003-09-11 15:22:56.000000000 +0200
@@ -14,6 +14,7 @@
 #include	<linux/config.h>	/* kmalloc_sizes.h needs CONFIG_ options */
 #include	<linux/gfp.h>
 #include	<linux/types.h>
+#include	<linux/string.h>	/* for memset */
 #include	<asm/page.h>		/* kmalloc_sizes.h needs PAGE_SIZE */
 #include	<asm/cache.h>		/* kmalloc_sizes.h needs L1_CACHE_BYTES */
 
@@ -97,6 +98,16 @@
 	return __kmalloc(size, flags);
 }
 
+static inline void *kmalloc0(size_t size, int flags)
+{
+	void *res = kmalloc(size, flags);
+
+	if (res != NULL)
+		memset(res, 0, size);
+
+	return res;
+}
+
 extern void kfree(const void *);
 extern unsigned int ksize(const void *);
 
