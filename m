Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267278AbTBNT5s>; Fri, 14 Feb 2003 14:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267308AbTBNT5s>; Fri, 14 Feb 2003 14:57:48 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:51208 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267278AbTBNT5q>; Fri, 14 Feb 2003 14:57:46 -0500
Date: Fri, 14 Feb 2003 20:07:37 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: RFC/CFT 0/1: Alternative tty fasync fix
Message-ID: <20030214200737.F14659@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

tty stuff came up in some conversations this morning, which caused a
re-think the fix that went into 2.5.60 for the tty_fasync whinge.
I think the following is an all-round better fix for the problem.
(I'm not saying that the 2.5.60 fix is wrong though.)

Instead of detecting when filp->private_data becomes NULL in
do_tty_hangup and check_tty_count, we remove the file descriptor
from the list of descriptors associated with the tty.  We use the
same method that dentry_open() uses.

In addition, we change the for() loops into real list_for_each()
loops.

If the general concensus is that this is a better method, please
speak up and I'll push Linus-ward.

--- orig/drivers/char/tty_io.c	Tue Feb 11 16:10:08 2003
+++ linux/drivers/char/tty_io.c	Fri Feb 14 20:03:44 2003
@@ -229,9 +229,8 @@
 	int count = 0;
 	
 	file_list_lock();
-	for(p = tty->tty_files.next; p != &tty->tty_files; p = p->next) {
-		if(list_entry(p, struct file, f_list)->private_data == tty)
-			count++;
+	list_for_each(p, &tty->tty_files) {
+		count++;
 	}
 	file_list_unlock();
 	if (tty->driver.type == TTY_DRIVER_TYPE_PTY &&
@@ -440,15 +439,8 @@
 	
 	check_tty_count(tty, "do_tty_hangup");
 	file_list_lock();
-	for (l = tty->tty_files.next; l != &tty->tty_files; l = l->next) {
+	list_for_each(l, &tty->tty_files) {
 		struct file * filp = list_entry(l, struct file, f_list);
-		/*
-		 * If this file descriptor has been closed, ignore it; it
-		 * will be going away shortly. (We don't test filp->f_count
-		 * for zero since that could open another race.) --rmk
-		 */
-		if (filp->private_data == NULL)
-			continue;
 		if (IS_CONSOLE_DEV(filp->f_dentry->d_inode->i_rdev) ||
 		    IS_SYSCONS_DEV(filp->f_dentry->d_inode->i_rdev)) {
 			cons_filp = filp;
@@ -1060,6 +1052,7 @@
  */
 static void release_dev(struct file * filp)
 {
+	static LIST_HEAD(kill_list);
 	struct tty_struct *tty, *o_tty;
 	int	pty_master, tty_closing, o_tty_closing, do_sleep;
 	int	idx;
@@ -1210,14 +1203,16 @@
 	}
 
 	/*
-	 * We've decremented tty->count, so we should zero out
-	 * filp->private_data, to break the link between the tty and
-	 * the file descriptor.  Otherwise if filp_close() blocks before
-	 * the file descriptor is removed from the inuse_filp
-	 * list, check_tty_count() could observe a discrepancy and
-	 * printk a warning message to the user.
+	 * We've decremented tty->count, so we need to remove this file
+	 * descriptor off the tty->tty_files list; this serves two
+	 * purposes:
+	 *  - check_tty_count sees the correct number of file descriptors
+	 *    associated with this tty.
+	 *  - do_tty_hangup no longer sees this file descriptor as
+	 *    something that needs to be handled for hangups.
 	 */
-	filp->private_data = 0;
+	file_move(filp, &kill_list);
+	filp->private_data = NULL;
 
 	/*
 	 * Perform some housekeeping before deciding whether to return.


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

