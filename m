Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265985AbUFIU7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265985AbUFIU7n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 16:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266141AbUFIU62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 16:58:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:2024 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265985AbUFIU5P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 16:57:15 -0400
Date: Wed, 9 Jun 2004 13:57:12 -0700
From: Chris Wright <chrisw@osdl.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Chris Wright <chrisw@osdl.org>,
       linux-kernel@vger.kernel.org, tiwai@suse.de
Subject: Re: [PATCH] ALSA: Remove subsystem-specific malloc (1/8)
Message-ID: <20040609135712.D21045@build.pdx.osdl.net>
References: <200406082124.i58LOuOL016163@melkki.cs.helsinki.fi> <20040609113455.U22989@build.pdx.osdl.net> <1086812001.13026.63.camel@cherry> <1086812486.2810.21.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1086812486.2810.21.camel@laptop.fenrus.com>; from arjanv@redhat.com on Wed, Jun 09, 2004 at 10:21:26PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Arjan van de Ven (arjanv@redhat.com) wrote:
> 
> > + */
> > +void *kcalloc(size_t n, size_t size, int flags)
> > +{
> > +	void *ret = kmalloc(n * size, flags);
> 
> how about making sure n*size doesn't overflow an int in this function?
> We had a few security holes due to that happening a while ago; might as
> well prevent it from happening entirely

Nice point.  Too bad all we can return is NULL, it'd be nice to know the
overflow was the reason.  Do we plop a WARN_ON() in there for a while?
Something like below (w/out any WARN_ON right now)?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

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
+++ kcalloc-2.6.6/mm/slab.c	2004-06-09 23:07:51.262925816 +0300
@@ -2332,6 +2332,28 @@
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
+	/* check for overflow */
+	if (n > UINT_MAX/size)
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
