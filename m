Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263608AbTJQWKr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 18:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbTJQWKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 18:10:47 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:43910 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S261188AbTJQWKi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 18:10:38 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC] prevent "dd if=/dev/mem" crash
Date: Fri, 17 Oct 2003 16:10:36 -0600
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310171610.36569.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the generic part of a change to prevent "dd if=/dev/mem"
from causing a machine check on ia64.

read_mem() and write_mem() already check the requested address
against "high_memory", but that is only a complete check if
everything from 0 to high_memory is valid, readable/writable
memory.  Obviously that's not the case for architectures with
discontiguous memory, like ia64.

Old behavior:

    # dd if=/dev/mem of=/dev/null
    <unrecoverable machine check>

New behavior (this system has a hole from 0-16MB, then memory
from 16MB-1GB):

    # dd if=/dev/mem of=/dev/null
    0+0 records in
    0+0 records out
    0 bytes transferred in 0.000282 seconds (0 bytes/sec)

    # dd if=/dev/mem of=/dev/null bs=1M skip=16 
    1004+10 records in
    1004+10 records out
    1056964608 bytes transferred in 1.629262 seconds (648738280 bytes/sec)

I expect there are probably different opinions about the idea
that "dd if=/dev/mem" exits without doing anything.  Sparc and
68K have nearby code that bit-buckets writes and returns zeroes
for reads of page zero.  We could do that, too, but it seems like
kind of a hack, and holes on ia64 can be BIG (on the order of
256GB for one box).

So flame away :-)

The patch below is mangled so it won't apply easily.  If this
seems a reasonable approach, I'll submit the ia64 piece first,
then repost this.

Bjorn

===== drivers/char/mem.c 1.44 vs edited =====
--- 1.44/ drivers/char/mem.c	Sun Sep 21 15:50:34 2003
+++ edited/ drivers/char/mem.c	Fri Oct 17 15:37:47 2003
@@ -79,6 +79,24 @@
 #endif
 }
 
+static inline int valid_mem_range(unsigned long addr, size_t *count)
+{
+#if defined(CONFIG_IA64)
+	return efi_valid_mem_range(addr, count);
+#else
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
+#endif
+}
+
 static ssize_t do_write_mem(struct file * file, void *p, unsigned long realp,
 			    const char * buf, size_t count, loff_t *ppos)
 {
@@ -113,14 +131,10 @@
 			size_t count, loff_t *ppos)
 {
 	unsigned long p = *ppos;
-	unsigned long end_mem;
 	ssize_t read;
 
-	end_mem = __pa(high_memory);
-	if (p >= end_mem)
+	if (!valid_mem_range(p, &count))
 		return 0;
-	if (count > end_mem - p)
-		count = end_mem - p;
 	read = 0;
 #if defined(__sparc__) || (defined(__mc68000__) && defined(CONFIG_MMU))
 	/* we don't have page 0 mapped on sparc and m68k.. */
@@ -149,13 +163,9 @@
 			 size_t count, loff_t *ppos)
 {
 	unsigned long p = *ppos;
-	unsigned long end_mem;
 
-	end_mem = __pa(high_memory);
-	if (p >= end_mem)
+	if (!valid_mem_range(p, &count))
 		return 0;
-	if (count > end_mem - p)
-		count = end_mem - p;
 	return do_write_mem(file, __va(p), p, buf, count, ppos);
 }
 
===== include/linux/efi.h 1.3 vs edited =====
--- 1.3/ include/linux/efi.h	Thu Aug  7 14:01:48 2003
+++ edited/ include/linux/efi.h	Thu Oct 16 16:54:52 2003
@@ -266,6 +266,7 @@
 extern u64 efi_get_iobase (void);
 extern u32 efi_mem_type (unsigned long phys_addr);
 extern u64 efi_mem_attributes (unsigned long phys_addr);
+extern int efi_valid_mem_range (unsigned long phys_addr, unsigned long *count);
 
 /*
  * Variable Attributes

