Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264645AbSJORiT>; Tue, 15 Oct 2002 13:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264648AbSJORiT>; Tue, 15 Oct 2002 13:38:19 -0400
Received: from mail18.svr.pol.co.uk ([195.92.67.23]:9489 "EHLO
	mail18.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S264645AbSJORiS>; Tue, 15 Oct 2002 13:38:18 -0400
Date: Tue, 15 Oct 2002 18:44:12 +0100
To: Linux Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>
Subject: [PATCH] Device-mapper submission 2/7
Message-ID: <20021015174412.GB27753@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[vmalloc]
Introduce vcalloc, I only really want it to automate the size overflow
check when allocating arrays.

--- a/include/linux/vmalloc.h	Tue Oct 15 18:24:33 2002
+++ b/include/linux/vmalloc.h	Tue Oct 15 18:24:33 2002
@@ -24,6 +24,7 @@
 extern void *vmalloc(unsigned long size);
 extern void *vmalloc_32(unsigned long size);
 extern void *__vmalloc(unsigned long size, int gfp_mask, pgprot_t prot);
+extern void *vcalloc(unsigned long nmemb, unsigned long elem_size);
 extern void vfree(void *addr);
 
 extern void *vmap(struct page **pages, unsigned int count);
--- a/kernel/ksyms.c	Tue Oct 15 18:24:33 2002
+++ b/kernel/ksyms.c	Tue Oct 15 18:24:33 2002
@@ -108,6 +108,7 @@
 EXPORT_SYMBOL(kfree);
 EXPORT_SYMBOL(vfree);
 EXPORT_SYMBOL(__vmalloc);
+EXPORT_SYMBOL(vcalloc);
 EXPORT_SYMBOL(vmalloc);
 EXPORT_SYMBOL(vmalloc_32);
 EXPORT_SYMBOL(vmap);
--- a/mm/vmalloc.c	Tue Oct 15 18:24:33 2002
+++ b/mm/vmalloc.c	Tue Oct 15 18:24:33 2002
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
