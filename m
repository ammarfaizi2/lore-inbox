Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264452AbTKMWPG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 17:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264453AbTKMWPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 17:15:06 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48649 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264452AbTKMWO6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 17:14:58 -0500
Subject: vhangup when the console is serial
From: "Guy M. Streeter" <streeter@redhat.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1068761694.8714.33.camel@jarjar.hsv.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 Nov 2003 16:14:54 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  I'm experiencing a problem on an embedded system with 2.4.23-pre2 or
later, and in 2.4.22-ac4. The system has a serial console, and I see a
call to the driver's hangup routine in the middle of the login sequence
(after login:, before password:).
  I've traced this to do_tty_hangup() (called from sys_vhangup), and I
see
that it attempts to avoid calling the driver's hangup() routine for the
console device. The test for the console doesn't account for serial
console.
  A change like the one below resolves this problem for me. However, I
don't understand why the problem doesn't occur on earlier kernels. I
hope someone more familiar with this code can comment on it.
  I've searched the archives of this list for any discussion of this
problem, without any luck. I am not subscribed to this list, and would
appreciate being CC-ed on any replies.

thanks,
--Guy
streeter@redhat.com

--- v2.4.23-pre8/drivers/char/tty_io.c.orig	2003-10-27
13:22:19.000000000 -0600
+++ v2.4.23-pre8/drivers/char/tty_io.c	2003-10-27 13:23:49.000000000
-0600
@@ -109,6 +109,7 @@ extern void con_init_devfs (void);
 extern void disable_early_printk(void);
 
 #define CONSOLE_DEV MKDEV(TTY_MAJOR,0)
+#define SERIAL_CONSOLE_DEV MKDEV(TTY_MAJOR,64)
 #define TTY_DEV MKDEV(TTYAUX_MAJOR,0)
 #define SYSCONS_DEV MKDEV(TTYAUX_MAJOR,1)
 #define PTMX_DEV MKDEV(TTYAUX_MAJOR,2)
@@ -461,6 +462,9 @@ void do_tty_hangup(void *data)
 	for (l = tty->tty_files.next; l != &tty->tty_files; l = l->next) {
 		struct file * filp = list_entry(l, struct file, f_list);
 		if (filp->f_dentry->d_inode->i_rdev == CONSOLE_DEV ||
+#ifdef CONFIG_SERIAL_CONSOLE
+		    filp->f_dentry->d_inode->i_rdev == SERIAL_CONSOLE_DEV ||
+#endif
 		    filp->f_dentry->d_inode->i_rdev == SYSCONS_DEV) {
 			cons_filp = filp;
 			continue;



