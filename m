Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965213AbWILAhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965213AbWILAhO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 20:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965216AbWILAhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 20:37:14 -0400
Received: from hu-out-0506.google.com ([72.14.214.224]:31942 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965213AbWILAhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 20:37:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=KJQd1bToQo9IjScqYudb+hJNk5Ab+hRMyrZAhXGKnfXqYpVm6suCKXD/z+HSWh2PQK71KhTv4ddAyzlyDqT6EMjHVh6qE8X7d9X8k7j1gNhGO+UHnyC+EMgPyyZTe7jcifg5UU8KyT6cEPIHVwao/uUULUR/0Sl2N8u0RrV969Q=
Date: Tue, 12 Sep 2006 04:37:12 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] kmemdup: introduce (updated)
Message-ID: <20060912003711.GA5192@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

signed-off-by + updated changelog. second patch remains as is.
------------
One of idiomatic ways to duplicate a region of memory is

	dst = kmalloc(len, GFP_KERNEL);
	if (!dst)
		return -ENOMEM;
	memcpy(dst, src, len);

which is neat code except a programmer needs to write size twice.  Which
sometimes leads to mistakes.  If len passed to kmalloc is smaller that len
passed to memcpy, it's straight overwrite-beyond-end.  If len passed to
memcpy is smaller than len passed to kmalloc, it's either a) legit
behaviour ;-), or b) cloned buffer will contain garbage in second half.

Slight trolling of commit lists shows several duplications bugs
done exactly because of diverged lenghts:

	Linux:
		[CRYPTO]: Fix memcpy/memset args.
		[PATCH] memcpy/memset fixes
	OpenBSD:
		kerberosV/src/lib/asn1: der_copy.c:1.4

If programmer is given only one place to play with lengths, I believe, such
mistakes could be avoided.

With kmemdup, the snippet above will be rewritten as:

	dst = kmemdup(src, len, GFP_KERNEL);
	if (!dst)
		return -ENOMEM;

This also leads to smaller code (kzalloc effect). Quick grep shows
200+ places where kmemdup() can be used.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/linux/string.h |    1 +
 mm/util.c              |   18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

--- a/include/linux/string.h~kmemdup-introduce
+++ a/include/linux/string.h
@@ -99,6 +99,7 @@ extern void * memchr(const void *,int,__
 #endif
 
 extern char *kstrdup(const char *s, gfp_t gfp);
+extern void *kmemdup(const void *src, size_t len, gfp_t gfp);
 
 #ifdef __cplusplus
 }
diff -puN mm/util.c~kmemdup-introduce mm/util.c
--- a/mm/util.c~kmemdup-introduce
+++ a/mm/util.c
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

