Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbWIIBf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbWIIBf4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 21:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbWIIBf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 21:35:56 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:15179 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751299AbWIIBfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 21:35:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=mwgik1dN8OGbItCYi5YiqYxbOHgOElBOvvxeQY//5W94Me06l2dXlDhHBVHqtR/YDjOFQ7otDJKEZKIKldCcOis+My8szELxJ3tTlr9Rgm+7iQwu5ZPTqr4VpUovZOfxz4l6tUQF1JF01sOE2S7AWNjtEJP8blQRBzoP5483WCc=
Date: Sat, 9 Sep 2006 05:35:55 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC 1/2] kmemdup: introduce
Message-ID: <20060909013555.GC5192@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One of idiomatic ways to duplicate a region of memory is

	dst = kmalloc(len, GFP_KERNEL);
	if (!dst)
		return -ENOMEM;
	memcpy(dst, src, len);

which is neat code except a programmer needs to write size twice. Which
sometimes leads to mistakes. If len passed to kmalloc is smaller that len
passed to memcpy, it's straight overwrite-beyond-end. If len passed to
memcpy is smaller than len passed to kmalloc, it's either a) legit
behaviour ;-), or b) cloned buffer will contain garbage in second half.

	[TODO: list of such bugs in Linux, other kernels, userspace]

If programmer is given only one place to play with lengths, I believe, such
mistakes could be avoided.

With kmemdup, the snippet above will be rewritten as:

	dst = kmemdup(src, len, GFP_KERNEL);
	if (!dst)
		return -ENOMEM;

This also leads to smaller code (kzalloc effect).

Not tested yet, this is for semantics commentary.

The plan is to
a) merge kmemdup
b) get some users (patch #2)
c) stick kmemdup conversion into -kj TODO
d) grep for memcpy and caaaarefully convert the rest. Promise to be a bastard.
----------------
e) try to get memdup(3) somehow, but I'm probably dreaming...

P.S.: No idea why kstrdup() and kzalloc() use _____________kmalloc(),
      but I followed the crowd.
---

 include/linux/string.h |    1 +
 mm/util.c              |   18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -99,6 +99,7 @@ extern void * memchr(const void *,int,__
 #endif
 
 extern char *kstrdup(const char *s, gfp_t gfp);
+extern void *kmemdup(const void *src, size_t len, gfp_t gfp);
 
 #ifdef __cplusplus
 }
--- a/mm/util.c
+++ b/mm/util.c
@@ -40,6 +40,24 @@ char *kstrdup(const char *s, gfp_t gfp)
 }
 EXPORT_SYMBOL(kstrdup);
 
+/**
+ * kmemdup - duplicate region of memory
+ *
+ * @src: memory region to duplicate
+ * @len: memory region length
+ * @gfp: GFP mask to use
+ */
+void *kmemdup(const void *src, size_t len, gfp_t gfp)
+{
+	void *p;
+
+	p = ____kmalloc(len, gfp);
+	if (p)
+		memcpy(p, src, len);
+	return p;
+}
+EXPORT_SYMBOL(kmemdup);
+
 /*
  * strndup_user - duplicate an existing string from user space
  *

