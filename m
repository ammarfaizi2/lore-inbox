Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbVCGTIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVCGTIy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 14:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbVCGTIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 14:08:54 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:2822 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261246AbVCGTHi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 14:07:38 -0500
Message-Id: <200503072038.j27Kcvbc004013@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 15/16] UML - Improve error reporting
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 07 Mar 2005 15:38:57 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds some errors and warnings where there were none before:
    If someone typos "ubd" as "udb", that is caught and a warning is printed
    If a ubd file can't be opened, that now results in an error message
    If there are more telnet connections to port consoles than there are 
consoles, then a message will appear in the telnet session explaining why
there is no login prompt.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/drivers/port_kern.c
===================================================================
--- linux-2.6.11.orig/arch/um/drivers/port_kern.c	2005-03-05 12:07:31.000000000 -0500
+++ linux-2.6.11/arch/um/drivers/port_kern.c	2005-03-05 12:25:42.000000000 -0500
@@ -10,6 +10,7 @@
 #include "linux/irq.h"
 #include "linux/spinlock.h"
 #include "linux/errno.h"
+#include "asm/atomic.h"
 #include "asm/semaphore.h"
 #include "asm/errno.h"
 #include "kern_util.h"
@@ -22,6 +23,7 @@
 
 struct port_list {
 	struct list_head list;
+	atomic_t wait_count;
 	int has_connection;
 	struct semaphore sem;
 	int port;
@@ -70,6 +72,13 @@
 	return(IRQ_HANDLED);
 }
 
+#define NO_WAITER_MSG \
+    "****\n" \
+    "There are currently no UML consoles waiting for port connections.\n" \
+    "Either disconnect from one to make it available or activate some more\n" \
+    "by enabling more consoles in the UML /etc/inittab.\n" \
+    "****\n"
+
 static int port_accept(struct port_list *port)
 {
 	struct connection *conn;
@@ -104,6 +113,10 @@
 		goto out_free;
 	}
 
+	if(atomic_read(&port->wait_count) == 0){
+		os_write_file(fd, NO_WAITER_MSG, sizeof(NO_WAITER_MSG));
+		printk("No one waiting for port\n");
+	}
 	list_add(&conn->list, &port->pending);
 	return(1);
 
@@ -182,6 +195,7 @@
 
 	*port = ((struct port_list) 
 		{ .list 	 	= LIST_HEAD_INIT(port->list),
+		  .wait_count		= ATOMIC_INIT(0),
 		  .has_connection 	= 0,
 		  .sem 			= __SEMAPHORE_INITIALIZER(port->sem, 
 								  0),
@@ -220,9 +234,11 @@
 	struct port_list *port = dev->port;
 	int fd;
 
+        atomic_inc(&port->wait_count);
 	while(1){
+		fd = -ERESTARTSYS;
 		if(down_interruptible(&port->sem))
-			return(-ERESTARTSYS);
+                        goto out;
 
 		spin_lock(&port->lock);
 
@@ -254,8 +270,9 @@
 	dev->helper_pid = conn->helper_pid;
 	dev->telnetd_pid = conn->telnetd_pid;
 	kfree(conn);
-
-	return(fd);
+ out:
+	atomic_dec(&port->wait_count);
+	return fd;
 }
 
 void port_remove_dev(void *d)
Index: linux-2.6.11/arch/um/drivers/ubd_kern.c
===================================================================
--- linux-2.6.11.orig/arch/um/drivers/ubd_kern.c	2005-03-05 12:11:43.000000000 -0500
+++ linux-2.6.11/arch/um/drivers/ubd_kern.c	2005-03-05 12:24:27.000000000 -0500
@@ -453,6 +453,22 @@
 "    an 's' will cause data to be written to disk on the host immediately.\n\n"
 );
 
+static int udb_setup(char *str)
+{
+	printk("udb%s specified on command line is almost certainly a ubd -> "
+	       "udb TYPO\n", str);
+	return(1);
+}
+
+__setup("udb", udb_setup);
+__uml_help(udb_setup,
+"udb\n"
+"    This option is here solely to catch ubd -> udb typos, which can be\n\n"
+"    to impossible to catch visually unless you specifically look for\n\n"
+"    them.  The only result of any option starting with 'udb' is an error\n\n"
+"    in the boot output.\n\n"
+);
+
 static int fakehd_set = 0;
 static int fakehd(char *str)
 {
@@ -605,7 +621,11 @@
 		}
 	}
 
-	if(dev->fd < 0) return(dev->fd);
+	if(dev->fd < 0){
+		printk("Failed to open '%s', errno = %d\n", dev->file, 
+		       -dev->fd);
+		return(dev->fd);
+	}
 
 	if(dev->cow.file != NULL){
 		err = -ENOMEM;

