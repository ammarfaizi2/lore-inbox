Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262334AbVA0CSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262334AbVA0CSI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 21:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262490AbVA0COl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 21:14:41 -0500
Received: from ozlabs.org ([203.10.76.45]:4051 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262486AbVA0CKk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 21:10:40 -0500
Subject: Re: [PATCH 2.6.11-rc2] modules: add version and srcversion to sysfs
From: Rusty Russell <rusty@rustcorp.com.au>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Matt Domsch <Matt_Domsch@dell.com>, Greg KH <greg@kroah.com>,
       Christoph Hellwig <hch@infradead.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <41F7A9F6.20804@grupopie.com>
References: <20050119171357.GA16136@lst.de>
	 <20050119172106.GB32702@kroah.com> <20050119213924.GG5508@us.ibm.com>
	 <20050119224016.GA5086@kroah.com> <20050119230350.GA23553@infradead.org>
	 <20050119230855.GA5646@kroah.com>
	 <20050119231559.GA10404@lists.us.dell.com>
	 <20050119234219.GA6294@kroah.com>
	 <20050126060541.GA16017@lists.us.dell.com>  <41F7A9F6.20804@grupopie.com>
Content-Type: text/plain
Date: Thu, 27 Jan 2005 13:10:28 +1100
Message-Id: <1106791829.24855.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-26 at 14:32 +0000, Paulo Marques wrote:
> Matt Domsch wrote:
> > [...]
> >  
> > +static char *strdup(const char *str)
...
> Actually, I've just grep'ed the entire tree and there are about 7 
> similar implementations all over the place:

Wow, I'd never noticed.  Linus, please apply 8)

Rusty.
Name: kstrdup
Author: Neil Brown, Rusty Russell and Robert Love
Status: Trivial

Everyone loves reimplementing strdup.  Give them a kstrdup.

Index: linux-2.6.11-rc2-bk4-Misc/include/linux/string.h
===================================================================
--- linux-2.6.11-rc2-bk4-Misc.orig/include/linux/string.h	2004-05-10 15:13:54.000000000 +1000
+++ linux-2.6.11-rc2-bk4-Misc/include/linux/string.h	2005-01-27 13:08:30.042035568 +1100
@@ -88,6 +88,8 @@
 extern void * memchr(const void *,int,__kernel_size_t);
 #endif
 
+extern char *kstrdup(const char *s, int gfp);
+
 #ifdef __cplusplus
 }
 #endif
Index: linux-2.6.11-rc2-bk4-Misc/lib/string.c
===================================================================
--- linux-2.6.11-rc2-bk4-Misc.orig/lib/string.c	2005-01-27 11:26:15.000000000 +1100
+++ linux-2.6.11-rc2-bk4-Misc/lib/string.c	2005-01-27 13:08:30.080029792 +1100
@@ -23,6 +23,7 @@
 #include <linux/string.h>
 #include <linux/ctype.h>
 #include <linux/module.h>
+#include <linux/slab.h>
 
 #ifndef __HAVE_ARCH_STRNICMP
 /**
@@ -599,3 +600,19 @@
 }
 EXPORT_SYMBOL(memchr);
 #endif
+
+/*
+ * kstrdup - allocate space for and copy an existing string
+ *
+ * @s: the string to duplicate
+ * @gfp: the GFP mask used in the kmalloc() call when allocating memory
+ */
+char *kstrdup(const char *s, int gfp)
+{
+	char *buf = kmalloc(strlen(s)+1, gfp);
+	if (buf)
+		strcpy(buf, s);
+	return buf;
+}
+
+EXPORT_SYMBOL(kstrdup);

-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

