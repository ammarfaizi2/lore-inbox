Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbTJTRmm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 13:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262739AbTJTRmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 13:42:42 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:41921 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S262731AbTJTRmh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 13:42:37 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] prevent "dd if=/dev/mem" crash
Date: Mon, 20 Oct 2003 11:42:26 -0600
User-Agent: KMail/1.5.3
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200310171610.36569.bjorn.helgaas@hp.com> <200310171725.10883.bjorn.helgaas@hp.com> <20031017165543.2f7e9d49.akpm@osdl.org>
In-Reply-To: <20031017165543.2f7e9d49.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310201142.26676.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 October 2003 5:55 pm, Andrew Morton wrote:
> Still, the code you have is quite reasonable.  But please structure it
> thusly:
> ...

Here's a patch structured that way.

> As for return values: if the requested read or write starts at a
> not-present address it should probably return -EFAULT.  This is what ia32
> will do.  Arguably this is indistinguishable from a bad address on the
> userspace side and we should return -EINVAL but whatever.

I made it return -EFAULT.  I worry a little bit because ia32
returned 0 (short read) when (addr >= high_memory) before,
but I don't have a strong opinion one way or the other.

===== drivers/char/mem.c 1.44 vs edited =====
--- 1.44/drivers/char/mem.c	Sun Sep 21 15:50:34 2003
+++ edited/drivers/char/mem.c	Mon Oct 20 10:43:08 2003
@@ -79,6 +79,22 @@
 #endif
 }
 
+#ifndef ARCH_HAS_VALID_PHYS_ADDR_RANGE
+static inline int valid_phys_addr_range(unsigned long addr, size_t *count)
+{
+	unsigned long end_mem;
+
+	end_mem = __pa(high_memory);
+	if (addr >= end_mem)
+		return 0;
+
+	if (*count > end_mem - addr)
+		*count = end_mem - addr;
+
+	return 1;
+}
+#endif
+
 static ssize_t do_write_mem(struct file * file, void *p, unsigned long realp,
 			    const char * buf, size_t count, loff_t *ppos)
 {
@@ -113,14 +129,10 @@
 			size_t count, loff_t *ppos)
 {
 	unsigned long p = *ppos;
-	unsigned long end_mem;
 	ssize_t read;
 
-	end_mem = __pa(high_memory);
-	if (p >= end_mem)
-		return 0;
-	if (count > end_mem - p)
-		count = end_mem - p;
+	if (!valid_phys_addr_range(p, &count))
+		return -EFAULT;
 	read = 0;
 #if defined(__sparc__) || (defined(__mc68000__) && defined(CONFIG_MMU))
 	/* we don't have page 0 mapped on sparc and m68k.. */
@@ -149,13 +161,9 @@
 			 size_t count, loff_t *ppos)
 {
 	unsigned long p = *ppos;
-	unsigned long end_mem;
 
-	end_mem = __pa(high_memory);
-	if (p >= end_mem)
-		return 0;
-	if (count > end_mem - p)
-		count = end_mem - p;
+	if (!valid_phys_addr_range(p, &count))
+		return -EFAULT;
 	return do_write_mem(file, __va(p), p, buf, count, ppos);
 }
 

