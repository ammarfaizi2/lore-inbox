Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262807AbSJLFQo>; Sat, 12 Oct 2002 01:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262808AbSJLFQo>; Sat, 12 Oct 2002 01:16:44 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:42182 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S262807AbSJLFQm>; Sat, 12 Oct 2002 01:16:42 -0400
Message-ID: <3DA7B1C4.6030800@quark.didntduck.org>
Date: Sat, 12 Oct 2002 01:23:16 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] convert tty_drivers to list_heads
Content-Type: multipart/mixed;
 boundary="------------040904040202060905040901"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040904040202060905040901
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Convert the tty_drivers list to use list_heads instead of open coded 
doubly-linked lists.

--
				Brian Gerst

--------------040904040202060905040901
Content-Type: text/plain;
 name="tty_drivers-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tty_drivers-1"

diff -urN linux-2.5.42/drivers/char/tty_io.c linux/drivers/char/tty_io.c
--- linux-2.5.42/drivers/char/tty_io.c	Fri Oct 11 22:51:09 2002
+++ linux/drivers/char/tty_io.c	Sat Oct 12 01:12:11 2002
@@ -113,7 +113,7 @@
 #define CHECK_TTY_COUNT 1
 
 struct termios tty_std_termios;		/* for the benefit of tty drivers  */
-struct tty_driver *tty_drivers;		/* linked list of tty drivers */
+LIST_HEAD(tty_drivers);			/* linked list of tty drivers */
 struct tty_ldisc ldiscs[NR_LDISCS];	/* line disc dispatch table	*/
 
 #ifdef CONFIG_UNIX98_PTYS
@@ -338,7 +338,7 @@
 	minor = minor(device);
 	major = major(device);
 
-	for (p = tty_drivers; p; p = p->next) {
+	list_for_each_entry(p, &tty_drivers, tty_drivers) {
 		if (p->major != major)
 			continue;
 		if (minor < p->minor_start)
@@ -2083,10 +2083,7 @@
 	if (!driver->put_char)
 		driver->put_char = tty_default_put_char;
 	
-	driver->prev = 0;
-	driver->next = tty_drivers;
-	if (tty_drivers) tty_drivers->prev = driver;
-	tty_drivers = driver;
+	list_add(&driver->tty_drivers, &tty_drivers);
 	
 	if ( !(driver->flags & TTY_DRIVER_NO_DEVFS) ) {
 		for(i = 0; i < driver->num; i++)
@@ -2110,7 +2107,7 @@
 	if (*driver->refcount)
 		return -EBUSY;
 
-	for (p = tty_drivers; p; p = p->next) {
+	list_for_each_entry(p, &tty_drivers, tty_drivers) {
 		if (p == driver)
 			found++;
 		else if (p->major == driver->major)
@@ -2127,13 +2124,7 @@
 	} else
 		register_chrdev(driver->major, othername, &tty_fops);
 
-	if (driver->prev)
-		driver->prev->next = driver->next;
-	else
-		tty_drivers = driver->next;
-	
-	if (driver->next)
-		driver->next->prev = driver->prev;
+	list_del(&driver->tty_drivers);
 
 	/*
 	 * Free the termios and termios_locked structures because
diff -urN linux-2.5.42/fs/proc/proc_tty.c linux/fs/proc/proc_tty.c
--- linux-2.5.42/fs/proc/proc_tty.c	Sun Sep 15 22:18:26 2002
+++ linux/fs/proc/proc_tty.c	Sat Oct 12 00:46:21 2002
@@ -14,7 +14,6 @@
 #include <linux/tty.h>
 #include <asm/bitops.h>
 
-extern struct tty_driver *tty_drivers;	/* linked list of tty drivers */
 extern struct tty_ldisc ldiscs[];
 
 
@@ -40,7 +39,7 @@
 	char	range[20], deftype[20];
 	char	*type;
 
-	for (p = tty_drivers; p; p = p->next) {
+	list_for_each_entry(p, &tty_drivers, tty_drivers) {
 		if (p->num > 1)
 			sprintf(range, "%d-%d", p->minor_start,
 				p->minor_start + p->num - 1);
diff -urN linux-2.5.42/include/linux/tty_driver.h linux/include/linux/tty_driver.h
--- linux-2.5.42/include/linux/tty_driver.h	Sun Sep 15 22:18:39 2002
+++ linux/include/linux/tty_driver.h	Sat Oct 12 00:46:21 2002
@@ -116,6 +116,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/list.h>
 
 struct tty_driver {
 	int	magic;		/* magic number for this structure */
@@ -170,14 +171,11 @@
 			  int count, int *eof, void *data);
 	int (*write_proc)(struct file *file, const char *buffer,
 			  unsigned long count, void *data);
-
-	/*
-	 * linked list pointers
-	 */
-	struct tty_driver *next;
-	struct tty_driver *prev;
+	struct list_head tty_drivers;
 };
 
+extern struct list_head tty_drivers;
+
 /* tty driver magic number */
 #define TTY_DRIVER_MAGIC		0x5402
 

--------------040904040202060905040901--

