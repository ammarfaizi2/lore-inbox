Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287279AbSBDARP>; Sun, 3 Feb 2002 19:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287919AbSBDAQ4>; Sun, 3 Feb 2002 19:16:56 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:38579 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S287279AbSBDAQl>; Sun, 3 Feb 2002 19:16:41 -0500
Date: Mon, 4 Feb 2002 01:16:25 +0100
From: Andi Kleen <ak@muc.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Allow /dev/kmem write to vmalloc space
Message-ID: <20020204011625.A2108@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

This patch allows to write vmalloc space via /dev/kmem. Without it is 
only readable. Writing is useful for example to change debugging variables
in modules. 

The patch is originally from Marc Boucher. 

Patch against 2.5.3. 
Please consider applying it.

Thanks,
-Andi


--- linux/drivers/char/mem.c-KMEM	Wed Jan 23 12:27:33 2002
+++ linux/drivers/char/mem.c	Mon Feb  4 01:08:07 2002
@@ -279,12 +279,46 @@
 			  size_t count, loff_t *ppos)
 {
 	unsigned long p = *ppos;
+	ssize_t wrote = 0;
+	ssize_t virtr = 0;
+	char * kbuf; /* k-addr because vwrite() takes vmlist_lock rwlock */
 
-	if (p >= (unsigned long) high_memory)
-		return 0;
-	if (count > (unsigned long) high_memory - p)
-		count = (unsigned long) high_memory - p;
-	return do_write_mem(file, (void*)p, p, buf, count, ppos);
+	if (p < (unsigned long) high_memory) {
+		wrote = count;
+		if (count > (unsigned long) high_memory - p)
+			wrote = (unsigned long) high_memory - p;
+
+		wrote = do_write_mem(file, (void*)p, p, buf, wrote, ppos);
+
+		p += wrote;
+		buf += wrote;
+		count -= wrote;
+	}
+
+	if (count > 0) {
+		kbuf = (char *)__get_free_page(GFP_KERNEL);
+		if (!kbuf)
+			return -ENOMEM;
+		while (count > 0) {
+			int len = count;
+
+			if (len > PAGE_SIZE)
+				len = PAGE_SIZE;
+			if (len && copy_from_user(kbuf, buf, len)) {
+				free_page((unsigned long)kbuf);
+				return -EFAULT;
+			}
+			len = vwrite(kbuf, (char *)p, len);
+			count -= len;
+			buf += len;
+			virtr += len;
+			p += len;
+		}
+		free_page((unsigned long)kbuf);
+	}
+
+ 	*ppos = p;
+ 	return virtr + wrote;
 }
 
 #if !defined(__mc68000__)
--- linux/include/linux/vmalloc.h-KMEM	Sun Feb  3 11:15:37 2002
+++ linux/include/linux/vmalloc.h	Mon Feb  4 01:07:56 2002
@@ -22,6 +22,7 @@
 extern void vfree(void * addr);
 extern void * __vmalloc (unsigned long size, int gfp_mask, pgprot_t prot);
 extern long vread(char *buf, char *addr, unsigned long count);
+extern long vwrite(char *buf, char *addr, unsigned long count);
 extern void vmfree_area_pages(unsigned long address, unsigned long size);
 extern int vmalloc_area_pages(unsigned long address, unsigned long size,
                               int gfp_mask, pgprot_t prot);
--- linux/mm/vmalloc.c-KMEM	Tue Jan 15 06:18:19 2002
+++ linux/mm/vmalloc.c	Sun Feb  3 12:42:37 2002
@@ -6,6 +6,7 @@
  *  SMP-safe vmalloc/vfree/ioremap, Tigran Aivazian <tigran@veritas.com>, May 2000
  */
 
+#include <linux/config.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/spinlock.h>
@@ -273,6 +274,43 @@
 			if (count == 0)
 				goto finished;
 			*buf = *addr;
+			buf++;
+			addr++;
+			count--;
+		} while (--n > 0);
+	}
+finished:
+	read_unlock(&vmlist_lock);
+	return buf - buf_start;
+}
+
+long vwrite(char *buf, char *addr, unsigned long count)
+{
+	struct vm_struct *tmp;
+	char *vaddr, *buf_start = buf;
+	unsigned long n;
+
+	/* Don't allow overflow */
+	if ((unsigned long) addr + count < count)
+		count = -(unsigned long) addr;
+
+	read_lock(&vmlist_lock);
+	for (tmp = vmlist; tmp; tmp = tmp->next) {
+		vaddr = (char *) tmp->addr;
+		if (addr >= vaddr + tmp->size - PAGE_SIZE)
+			continue;
+		while (addr < vaddr) {
+			if (count == 0)
+				goto finished;
+			buf++;
+			addr++;
+			count--;
+		}
+		n = vaddr + tmp->size - PAGE_SIZE - addr;
+		do {
+			if (count == 0)
+				goto finished;
+			*addr = *buf;
 			buf++;
 			addr++;
 			count--;
