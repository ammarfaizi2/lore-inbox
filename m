Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263225AbUCNAO7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 19:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263226AbUCNAO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 19:14:59 -0500
Received: from fw.osdl.org ([65.172.181.6]:36249 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263225AbUCNAOz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 19:14:55 -0500
Date: Sat, 13 Mar 2004 16:15:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Missing return value check on do_write_mem
Message-Id: <20040313161500.72a7d098.akpm@osdl.org>
In-Reply-To: <200403132049.54554.blaisorblade_spam@yahoo.it>
References: <200403081246.33897.blaisorblade_spam@yahoo.it>
	<20040309134648.61e3cb9f.akpm@osdl.org>
	<200403132049.54554.blaisorblade_spam@yahoo.it>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BlaisorBlade <blaisorblade_spam@yahoo.it> wrote:
>
> Alle 22:46, martedì 9 marzo 2004, Andrew Morton ha scritto:
>  > BlaisorBlade <blaisorblade_spam@yahoo.it> wrote:
>  > > In drivers/char/mem.c do_write_mem can return -EFAULT but write_kmem
>  > > forgets this and goes blindly.
> 
>  First: do not forget this first fix.

Actually, you converted this code from "wrong" to "still wrong".  How's this?


- remove unused `file *' arg from do_write_mem()

- Add checking for copy_from_user() failures in do_write_mem()

- Return correct value from kmem writes() when a fault is encountered.  A
  write()-style syscall's return values are:

   0: nothing was written and there was no error (someone tried to write
   zero bytes)

   >0: the number of bytes copied, whether or not there was an error. 
   Userspace detects errors by noting that the write() return value is less
   than was requested.

   <0: there was an error and no bytes were copied


---

 25-akpm/drivers/char/mem.c |   35 ++++++++++++++++++++++++++---------
 1 files changed, 26 insertions(+), 9 deletions(-)

diff -puN drivers/char/mem.c~do_write_mem-retval-check drivers/char/mem.c
--- 25/drivers/char/mem.c~do_write_mem-retval-check	2004-03-13 16:01:00.941435904 -0800
+++ 25-akpm/drivers/char/mem.c	2004-03-13 16:08:57.522984496 -0800
@@ -105,10 +105,11 @@ static inline int valid_phys_addr_range(
 }
 #endif
 
-static ssize_t do_write_mem(struct file * file, void *p, unsigned long realp,
+static ssize_t do_write_mem(void *p, unsigned long realp,
 			    const char * buf, size_t count, loff_t *ppos)
 {
 	ssize_t written;
+	unsigned long copied;
 
 	written = 0;
 #if defined(__sparc__) || (defined(__mc68000__) && defined(CONFIG_MMU))
@@ -123,8 +124,14 @@ static ssize_t do_write_mem(struct file 
 		written+=sz;
 	}
 #endif
-	if (copy_from_user(p, buf, count))
+	copied = copy_from_user(p, buf, count);
+	if (copied) {
+		ssize_t ret = written + (count - copied);
+
+		if (ret)
+			return ret;
 		return -EFAULT;
+	}
 	written += count;
 	*ppos += written;
 	return written;
@@ -174,7 +181,7 @@ static ssize_t write_mem(struct file * f
 
 	if (!valid_phys_addr_range(p, &count))
 		return -EFAULT;
-	return do_write_mem(file, __va(p), p, buf, count, ppos);
+	return do_write_mem(__va(p), p, buf, count, ppos);
 }
 
 static int mmap_mem(struct file *file, struct vm_area_struct *vma)
@@ -274,15 +281,19 @@ static ssize_t write_kmem(struct file * 
 	unsigned long p = *ppos;
 	ssize_t wrote = 0;
 	ssize_t virtr = 0;
+	ssize_t written;
 	char * kbuf; /* k-addr because vwrite() takes vmlist_lock rwlock */
 
 	if (p < (unsigned long) high_memory) {
+
 		wrote = count;
 		if (count > (unsigned long) high_memory - p)
 			wrote = (unsigned long) high_memory - p;
 
-		wrote = do_write_mem(file, (void*)p, p, buf, wrote, ppos);
-
+		written = do_write_mem((void*)p, p, buf, wrote, ppos);
+		if (written != wrote)
+			return written;
+		wrote = written;
 		p += wrote;
 		buf += wrote;
 		count -= wrote;
@@ -291,15 +302,21 @@ static ssize_t write_kmem(struct file * 
 	if (count > 0) {
 		kbuf = (char *)__get_free_page(GFP_KERNEL);
 		if (!kbuf)
-			return -ENOMEM;
+			return wrote ? wrote : -ENOMEM;
 		while (count > 0) {
 			int len = count;
 
 			if (len > PAGE_SIZE)
 				len = PAGE_SIZE;
-			if (len && copy_from_user(kbuf, buf, len)) {
-				free_page((unsigned long)kbuf);
-				return -EFAULT;
+			if (len) {
+				written = copy_from_user(kbuf, buf, len);
+				if (written != len) {
+					ssize_t ret;
+
+					free_page((unsigned long)kbuf);
+					ret = wrote + virtr + (len - written)
+					return ret ? ret : -EFAULT;
+				}
 			}
 			len = vwrite(kbuf, (char *)p, len);
 			count -= len;

_

