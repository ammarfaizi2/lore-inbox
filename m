Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUCZU7c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 15:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbUCZU7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 15:59:32 -0500
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:27261 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261232AbUCZU7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 15:59:18 -0500
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
To: marcelo.tosatti@cyclades.com
Subject: [PATCH/2.4]: do_write_mem() return value check / v2
Date: Thu, 25 Mar 2004 20:15:34 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_W/yYAyaDf7ZEXLA"
Message-Id: <200403252015.34635.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_W/yYAyaDf7ZEXLA
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

From: Andrew Morton, and me (I did a first fix for 2.6 and sent to him, he 
checked everything and committed it and I changed the trivial bits for 2.4 + 
did a little fix).

- remove unused `file *' arg from do_write_mem()

- Add checking for copy_from_user() failures in do_write_mem()

(Note: /dev/kmem can be written to only by root, so this *cannot* have 
security implications)

- Return correct value from kmem writes() when a fault is encountered.  A
  write()-style syscall's return values are:

   0 when nothing was written and there was no error (someone tried to
   write zero bytes)

   >0: the number of bytes copied, whether or not there was an error. 
   Userspace detects errors by noting that the write() return value is less
   than was requested.

   <0: there was an error and no bytes were copied

- Fix this line:
+                              unwritten = copy_from_user(kbuf, buf, len);
+                              if (unwritten != len) {

to this:
+                              unwritten = copy_from_user(kbuf, buf, len);
+                              if (unwritten != 0) {

TODO: Do the same changes for read_mem() and read_kmem(). The code is more 
messy so I must create do_read_mem() to avoid clumsy counting; I have posted 
the patch first for 2.6, when it is accepted I'll backport it.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729











--Boundary-00=_W/yYAyaDf7ZEXLA
Content-Type: text/x-diff;
  charset="us-ascii";
  name="do_write_kmem-return.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="do_write_kmem-return.patch"

--- ./drivers/char/mem.c.fix	2004-02-22 18:35:31.000000000 +0100
+++ ./drivers/char/mem.c	2004-03-23 16:02:54.000000000 +0100
@@ -43,10 +43,11 @@
 extern void tapechar_init(void);
 #endif
      
-static ssize_t do_write_mem(struct file * file, void *p, unsigned long realp,
+static ssize_t do_write_mem(void *p, unsigned long realp,
 			    const char * buf, size_t count, loff_t *ppos)
 {
 	ssize_t written;
+	unsigned long uncopied;
 
 	written = 0;
 #if defined(__sparc__) || defined(__mc68000__)
@@ -61,8 +62,14 @@
 		written+=sz;
 	}
 #endif
-	if (copy_from_user(p, buf, count))
-		return -EFAULT;
+	uncopied = copy_from_user(p, buf, count);
+	if (uncopied) {
+		ssize_t ret = written + (count - uncopied);
+
+		if (ret)
+			return ret;
+ 		return -EFAULT;
+	}
 	written += count;
 	*ppos += written;
 	return written;
@@ -120,7 +127,7 @@
 		return 0;
 	if (count > end_mem - p)
 		count = end_mem - p;
-	return do_write_mem(file, __va(p), p, buf, count, ppos);
+	return do_write_mem(__va(p), p, buf, count, ppos);
 }
 
 #ifndef pgprot_noncached
@@ -287,11 +294,16 @@
 	char * kbuf; /* k-addr because vwrite() takes vmlist_lock rwlock */
 
 	if (p < (unsigned long) high_memory) {
+		ssize_t written;
+
 		wrote = count;
 		if (count > (unsigned long) high_memory - p)
 			wrote = (unsigned long) high_memory - p;
 
-		wrote = do_write_mem(file, (void*)p, p, buf, wrote, ppos);
+		written = do_write_mem((void*)p, p, buf, wrote, ppos);
+		if (written != wrote)
+			return written;
+		wrote = written;
 
 		p += wrote;
 		buf += wrote;
@@ -301,15 +313,22 @@
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
+				ssize_t unwritten;
+				unwritten = copy_from_user(kbuf, buf, len);
+				if (unwritten != len) {
+					ssize_t ret;
+
+					free_page((unsigned long)kbuf);
+					ret = wrote + virtr + (len - unwritten);
+					return ret ? ret : -EFAULT;
+				}
 			}
 			len = vwrite(kbuf, (char *)p, len);
 			count -= len;

--Boundary-00=_W/yYAyaDf7ZEXLA--


