Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262673AbTIQUqk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 16:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262713AbTIQUpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 16:45:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:1708 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262673AbTIQUpP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 16:45:15 -0400
Date: Wed, 17 Sep 2003 13:44:46 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] (1/2) drivers/char/misc -- use list() macros
Message-Id: <20030917134446.3ebcf234.shemminger@osdl.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.4claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use list macros for misc_device list.
Patch against 2.6.0-test5 bk latest.

diff -Nru a/drivers/char/misc.c b/drivers/char/misc.c
--- a/drivers/char/misc.c	Wed Sep 17 13:43:05 2003
+++ b/drivers/char/misc.c	Wed Sep 17 13:43:05 2003
@@ -53,7 +53,7 @@
 /*
  * Head entry for the doubly linked miscdevice list
  */
-static struct miscdevice misc_list = { 0, "head", NULL, &misc_list, &misc_list };
+static LIST_HEAD(misc_list);
 static DECLARE_MUTEX(misc_sem);
 
 /*
@@ -80,7 +80,9 @@
 	int written;
 
 	written=0;
-	for (p = misc_list.next; p != &misc_list && written < len; p = p->next) {
+	list_for_each_entry(p, &misc_list, list) {
+		if (written >= len)
+			break;
 		written += sprintf(buf+written, "%3i %s\n",p->minor, p->name ?: "");
 		if (written < offset) {
 			offset -= written;
@@ -97,7 +99,6 @@
 	return (written<0) ? 0 : written;
 }
 
-
 static int misc_open(struct inode * inode, struct file * file)
 {
 	int minor = iminor(inode);
@@ -107,21 +108,27 @@
 	
 	down(&misc_sem);
 	
-	c = misc_list.next;
-
-	while ((c != &misc_list) && (c->minor != minor))
-		c = c->next;
-	if (c != &misc_list)
-		new_fops = fops_get(c->fops);
+	list_for_each_entry(c, &misc_list, list) {
+		if (c->minor == minor) {
+			new_fops = fops_get(c->fops);		
+			break;
+		}
+	}
+		
 	if (!new_fops) {
 		up(&misc_sem);
 		request_module("char-major-%d-%d", MISC_MAJOR, minor);
 		down(&misc_sem);
-		c = misc_list.next;
-		while ((c != &misc_list) && (c->minor != minor))
-			c = c->next;
-		if (c == &misc_list || (new_fops = fops_get(c->fops)) == NULL)
-			goto fail;
+
+		list_for_each_entry(c, &misc_list, list) {
+			if (c->minor == minor) {
+				new_fops = fops_get(c->fops);
+				if (!new_fops)
+					goto fail;
+				break;
+			}
+		}
+		goto fail;
 	}
 
 	err = 0;
@@ -166,16 +173,12 @@
 {
 	struct miscdevice *c;
 	
-	if (misc->next || misc->prev)
-		return -EBUSY;
 	down(&misc_sem);
-	c = misc_list.next;
-
-	while ((c != &misc_list) && (c->minor != misc->minor))
-		c = c->next;
-	if (c != &misc_list) {
-		up(&misc_sem);
-		return -EBUSY;
+	list_for_each_entry(c, &misc_list, list) {
+		if (c->minor == misc->minor) {
+			up(&misc_sem);
+			return -EBUSY;
+		}
 	}
 
 	if (misc->minor == MISC_DYNAMIC_MINOR) {
@@ -205,10 +208,7 @@
 	 * Add it to the front, so that later devices can "override"
 	 * earlier defaults
 	 */
-	misc->prev = &misc_list;
-	misc->next = misc_list.next;
-	misc->prev->next = misc;
-	misc->next->prev = misc;
+	list_add(&misc->list, &misc_list);
 	up(&misc_sem);
 	return 0;
 }
@@ -226,13 +226,12 @@
 int misc_deregister(struct miscdevice * misc)
 {
 	int i = misc->minor;
-	if (!misc->next || !misc->prev)
+
+	if (list_empty(&misc->list))
 		return -EINVAL;
+
 	down(&misc_sem);
-	misc->prev->next = misc->next;
-	misc->next->prev = misc->prev;
-	misc->next = NULL;
-	misc->prev = NULL;
+	list_del(&misc->list);
 	devfs_remove(misc->devfs_name);
 	if (i < DYNAMIC_MINORS && i>0) {
 		misc_minors[i>>3] &= ~(1 << (misc->minor & 7));
diff -Nru a/include/linux/miscdevice.h b/include/linux/miscdevice.h
--- a/include/linux/miscdevice.h	Wed Sep 17 13:43:05 2003
+++ b/include/linux/miscdevice.h	Wed Sep 17 13:43:05 2003
@@ -43,7 +43,7 @@
 	int minor;
 	const char *name;
 	struct file_operations *fops;
-	struct miscdevice * next, * prev;
+	struct list_head list;
 	char devfs_name[64];
 };
 
