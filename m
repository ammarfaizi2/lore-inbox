Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262395AbSJ2RLZ>; Tue, 29 Oct 2002 12:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262397AbSJ2RLZ>; Tue, 29 Oct 2002 12:11:25 -0500
Received: from cmailg1.svr.pol.co.uk ([195.92.195.171]:13 "EHLO
	cmailg1.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S262395AbSJ2RLX>; Tue, 29 Oct 2002 12:11:23 -0500
Date: Tue, 29 Oct 2002 17:17:40 +0000
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] dm update 1/3
Message-ID: <20021029171740.GA1779@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vcalloc, if you don't like it in vmalloc just say and I'll move it
into dm.h.  However I do feel it is generally useful for the implicit
array size overflow check.

--- diff/kernel/ksyms.c	2002-10-29 16:18:17.000000000 +0000
+++ source/kernel/ksyms.c	2002-10-29 16:21:32.000000000 +0000
@@ -106,6 +106,7 @@
 EXPORT_SYMBOL(kfree);
 EXPORT_SYMBOL(vfree);
 EXPORT_SYMBOL(__vmalloc);
+EXPORT_SYMBOL(vcalloc);
 EXPORT_SYMBOL(vmalloc);
 EXPORT_SYMBOL(vmalloc_32);
 EXPORT_SYMBOL(vmap);
--- diff/include/linux/vmalloc.h	2002-10-16 04:29:06.000000000 +0100
+++ source/include/linux/vmalloc.h	2002-10-29 16:21:32.000000000 +0000
@@ -24,6 +24,7 @@
 extern void *vmalloc(unsigned long size);
 extern void *vmalloc_32(unsigned long size);
 extern void *__vmalloc(unsigned long size, int gfp_mask, pgprot_t prot);
+extern void *vcalloc(unsigned long nmemb, unsigned long elem_size);
 extern void vfree(void *addr);
 
 extern void *vmap(struct page **pages, unsigned int count);
--- diff/mm/vmalloc.c	2002-10-23 09:32:25.000000000 +0100
+++ source/mm/vmalloc.c	2002-10-29 16:21:32.000000000 +0000
@@ -520,3 +520,22 @@
 	read_unlock(&vmlist_lock);
 	return buf - buf_start;
 }
+
+void *vcalloc(unsigned long nmemb, unsigned long elem_size)
+{
+	unsigned long size;
+	void *addr;
+
+	/*
+	 * Check that we're not going to overflow.
+	 */
+	if (nmemb > (ULONG_MAX / elem_size))
+		return NULL;
+
+	size = nmemb * elem_size;
+	addr = vmalloc(size);
+	if (addr)
+		memset(addr, 0, size);
+
+	return addr;
+}
