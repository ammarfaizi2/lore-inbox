Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbUCIThY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 14:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262180AbUCITeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 14:34:24 -0500
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:51805 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262154AbUCITa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 14:30:58 -0500
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] Missing return value check on do_write_mem
Date: Mon, 8 Mar 2004 12:46:33 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Z0FTA4EPrGvYb3I"
Message-Id: <200403081246.33897.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_Z0FTA4EPrGvYb3I
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

In drivers/char/mem.c do_write_mem can return -EFAULT but write_kmem forgets 
this and goes blindly.

Note: /dev/kmem can be written to only by root, so this *cannot* have security 
implications.

Also, do_write_mem takes two unused params and is static - so I've removed 
those. I actually double-checked this - however please test compilation on 
Sparc/m68k, since there are some #ifdef.

CC me on replies as I'm not subscribed. Thanks.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--Boundary-00=_Z0FTA4EPrGvYb3I
Content-Type: text/x-diff;
  charset="us-ascii";
  name="Fix-kmem-return.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="Fix-kmem-return.patch"

--- ./drivers/char/mem.c.fix	2004-02-20 16:27:21.000000000 +0100
+++ ./drivers/char/mem.c	2004-03-08 12:17:23.000000000 +0100
@@ -96,13 +96,14 @@
 }
 #endif
 
-static ssize_t do_write_mem(struct file * file, void *p, unsigned long realp,
-			    const char * buf, size_t count, loff_t *ppos)
+static ssize_t do_write_mem(void *p, const char * buf, size_t count,
+			    loff_t *ppos)
 {
-	ssize_t written;
+	ssize_t written = 0;
 
-	written = 0;
 #if defined(__sparc__) || (defined(__mc68000__) && defined(CONFIG_MMU))
+	unsigned long realp = *ppos;
+
 	/* we don't have page 0 mapped on sparc and m68k.. */
 	if (realp < PAGE_SIZE) {
 		unsigned long sz = PAGE_SIZE-realp;
@@ -165,7 +166,7 @@
 
 	if (!valid_phys_addr_range(p, &count))
 		return -EFAULT;
-	return do_write_mem(file, __va(p), p, buf, count, ppos);
+	return do_write_mem(__va(p), buf, count, ppos);
 }
 
 static int mmap_mem(struct file * file, struct vm_area_struct * vma)
@@ -276,7 +277,9 @@
 		if (count > (unsigned long) high_memory - p)
 			wrote = (unsigned long) high_memory - p;
 
-		wrote = do_write_mem(file, (void*)p, p, buf, wrote, ppos);
+		wrote = do_write_mem((void*)p, buf, wrote, ppos);
+		if (wrote < 0)
+			return wrote;
 
 		p += wrote;
 		buf += wrote;

--Boundary-00=_Z0FTA4EPrGvYb3I--

