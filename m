Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752232AbWCCJbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232AbWCCJbW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 04:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752233AbWCCJbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 04:31:22 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:48654
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1752227AbWCCJbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 04:31:21 -0500
Message-Id: <44081B03.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Fri, 03 Mar 2006 10:31:31 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] adjust /dev/{kmem,mem,port} write handlers
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The /dev/mem and /dev/kmem write handlers weren't fully POSIX compliant in
that they wouldn't always force the file pointer to be updated when returning
success status.
The /dev/port write handler was inconsistent with the /dev/mem and /dev/kmem
handlers in that when encountering a -EFAULT condition after already having
written a number of items it would return -EFAULT rather than the number of
bytes written.

Signed-Off-By: Jan Beulich <jbeulich@novell.com>

diff -Npru /home/jbeulich/tmp/linux-2.6.16-rc5/drivers/char/mem.c 2.6.16-rc5-posix-dev-mem/drivers/char/mem.c
--- /home/jbeulich/tmp/linux-2.6.16-rc5/drivers/char/mem.c	2006-03-03 09:55:50.000000000 +0100
+++ 2.6.16-rc5-posix-dev-mem/drivers/char/mem.c	2006-03-02 11:45:28.000000000 +0100
@@ -216,11 +216,9 @@ static ssize_t write_mem(struct file * f
 
 		copied = copy_from_user(ptr, buf, sz);
 		if (copied) {
-			ssize_t ret;
-
-			ret = written + (sz - copied);
-			if (ret)
-				return ret;
+			written += sz - copied;
+			if (written)
+				break;
 			return -EFAULT;
 		}
 		buf += sz;
@@ -456,11 +454,9 @@ do_write_kmem(void *p, unsigned long rea
 
 		copied = copy_from_user(ptr, buf, sz);
 		if (copied) {
-			ssize_t ret;
-
-			ret = written + (sz - copied);
-			if (ret)
-				return ret;
+			written += sz - copied;
+			if (written)
+				break;
 			return -EFAULT;
 		}
 		buf += sz;
@@ -514,11 +510,10 @@ static ssize_t write_kmem(struct file * 
 			if (len) {
 				written = copy_from_user(kbuf, buf, len);
 				if (written) {
-					ssize_t ret;
-
+					if (wrote + virtr)
+						break;
 					free_page((unsigned long)kbuf);
-					ret = wrote + virtr + (len - written);
-					return ret ? ret : -EFAULT;
+					return -EFAULT;
 				}
 			}
 			len = vwrite(kbuf, (char *)p, len);
@@ -563,8 +558,11 @@ static ssize_t write_port(struct file * 
 		return -EFAULT;
 	while (count-- > 0 && i < 65536) {
 		char c;
-		if (__get_user(c, tmp)) 
+		if (__get_user(c, tmp)) {
+			if (tmp > buf)
+				break;
 			return -EFAULT; 
+		}
 		outb(c,i);
 		i++;
 		tmp++;

