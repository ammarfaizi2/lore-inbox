Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265978AbUFIVPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265978AbUFIVPw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 17:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265979AbUFIVPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 17:15:52 -0400
Received: from smtp2.pp.htv.fi ([213.243.153.35]:62387 "EHLO smtp2.pp.htv.fi")
	by vger.kernel.org with ESMTP id S265978AbUFIVPq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 17:15:46 -0400
Subject: Re: [PATCH] ALSA: Remove subsystem-specific malloc (1/8)
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Chris Wright <chrisw@osdl.org>
Cc: arjanv@redhat.com, linux-kernel@vger.kernel.org, tiwai@suse.de
In-Reply-To: <20040609140056.E21045@build.pdx.osdl.net>
References: <200406082124.i58LOuOL016163@melkki.cs.helsinki.fi>
	 <20040609113455.U22989@build.pdx.osdl.net>
	 <1086812001.13026.63.camel@cherry>
	 <1086812486.2810.21.camel@laptop.fenrus.com>
	 <1086814663.13026.70.camel@cherry>
	 <20040609140056.E21045@build.pdx.osdl.net>
Content-Type: text/plain
Message-Id: <1086815893.13026.79.camel@cherry>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 10 Jun 2004 00:18:13 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-06-10 at 00:00, Chris Wright wrote:
> > +	void *ret = kmalloc(n * size, flags);
> 
> This is only C99, and will make some compilers spit up warning.

Indeed, I'd better fix that as well then ;)

		Pekka

diff -urN linux-2.6.6/include/linux/slab.h kcalloc-2.6.6/include/linux/slab.h
--- linux-2.6.6/include/linux/slab.h	2004-06-09 22:56:11.874249056 +0300
+++ kcalloc-2.6.6/include/linux/slab.h	2004-06-09 23:03:10.597593432 +0300
@@ -95,6 +95,7 @@
 	return __kmalloc(size, flags);
 }
 
+extern void *kcalloc(size_t, size_t, int);
 extern void kfree(const void *);
 extern unsigned int ksize(const void *);
 
diff -urN linux-2.6.6/mm/slab.c kcalloc-2.6.6/mm/slab.c
--- linux-2.6.6/mm/slab.c	2004-06-09 22:59:13.081701336 +0300
+++ kcalloc-2.6.6/mm/slab.c	2004-06-10 00:08:44.004624672 +0300
@@ -2332,6 +2332,27 @@
 EXPORT_SYMBOL(kmem_cache_free);
 
 /**
+ * kcalloc - allocate memory for an array. The memory is set to zero.
+ * @n: number of elements.
+ * @size: element size.
+ * @flags: the type of memory to allocate.
+ */
+void *kcalloc(size_t n, size_t size, int flags)
+{
+	void *ret = NULL;
+
+	if (n != 0 && size > INT_MAX / n)
+		return ret;
+
+	ret = kmalloc(n * size, flags);
+	if (ret)
+		memset(ret, 0, n * size);
+	return ret;
+}
+
+EXPORT_SYMBOL(kcalloc);
+
+/**
  * kfree - free previously allocated memory
  * @objp: pointer returned by kmalloc.
  *


