Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbTFZQDb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 12:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbTFZQDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 12:03:31 -0400
Received: from smtp6.dti.ne.jp ([202.216.228.41]:32475 "EHLO smtp6.dti.ne.jp")
	by vger.kernel.org with ESMTP id S261994AbTFZQD3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 12:03:29 -0400
Date: Fri, 27 Jun 2003 01:17:37 +0900
From: Hiroshi Inoue <inoueh@uranus.dti.ne.jp>
To: linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: [PATCH] Repeatable kernel crash in tty_io.c (2.5.73 & 2.4.21)
X-Mailer-Plugin: AntiSpam for Becky!2 Ver.0.306
X-Spam-TotalCounts: 15 Counts
X-Spam-TotalRatios: 2 Percents
Message-Id: <20030627001520.5237.INOUEH@uranus.dti.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.06
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

I found that kernel 2.5.73 (and also 2.4.21) crashed 
in drivers/char/tty_io.c at situation described below.

1. login to tty2 (not tty1)
2. start kon (Kanji cONsole emulator, console which support
   Japanese characters)
3. exit kon
4. logout

This crash is repeatable.
I use Redhat 9 on ThinkPad T20.

These patches (for kernel 2.5.73 and 2.4.21) prevent list_del() when 
the list is empty.
In kernel 2.5.73, these applying list_del() to empty list 
seems to be occured very often (not only at the above situation). 
I think this might be harmful.


Regards, 
Hiroshi Inoue 



--- /usr/src/linux-2.5.73.orig/drivers/char/tty_io.c	2003-06-25 10:45:30.000000000 +0900
+++ /usr/src/linux-2.5.73/drivers/char/tty_io.c	2003-06-27 00:17:12.000000000 +0900
@@ -1018,9 +1018,11 @@
 		}
 		o_tty->magic = 0;
 		o_tty->driver->refcount--;
-		file_list_lock();
-		list_del(&o_tty->tty_files);
-		file_list_unlock();
+		if (o_tty->tty_files.next != &o_tty->tty_files) {
+			file_list_lock();
+			list_del(&o_tty->tty_files);
+			file_list_unlock();
+		}
 		free_tty_struct(o_tty);
 	}
 
@@ -1032,9 +1034,11 @@
 	}
 	tty->magic = 0;
 	tty->driver->refcount--;
-	file_list_lock();
-	list_del(&tty->tty_files);
-	file_list_unlock();
+	if (tty->tty_files.next != &tty->tty_files) {
+		file_list_lock();
+		list_del(&tty->tty_files);
+		file_list_unlock();
+	}
 	module_put(tty->driver->owner);
 	free_tty_struct(tty);
 }
@@ -1372,7 +1376,10 @@
 	}
 
 	filp->private_data = tty;
-	file_move(filp, &tty->tty_files);
+	if (filp->f_list.next == &filp->f_list)
+		list_add(&filp->f_list, &tty->tty_files);
+	else 
+		file_move(filp, &tty->tty_files);
 	check_tty_count(tty, "tty_open");
 	if (tty->driver->type == TTY_DRIVER_TYPE_PTY &&
 	    tty->driver->subtype == PTY_TYPE_MASTER)



--- /usr/src/linux-2.4.21.orig/drivers/char/tty_io.c	2003-06-13 23:51:33.000000000 +0900
+++ /usr/src/linux-2.4.21/drivers/char/tty_io.c	2003-06-27 00:34:53.798982568 +0900
@@ -1043,7 +1043,8 @@
 		}
 		o_tty->magic = 0;
 		(*o_tty->driver.refcount)--;
-		list_del(&o_tty->tty_files);
+		if (o_tty->tty_files.next != &o_tty->tty_files)
+			list_del(&o_tty->tty_files);
 		free_tty_struct(o_tty);
 	}
 
@@ -1055,7 +1056,8 @@
 	}
 	tty->magic = 0;
 	(*tty->driver.refcount)--;
-	list_del(&tty->tty_files);
+	if (tty->tty_files.next != &tty->tty_files)
+		list_del(&tty->tty_files);
 	free_tty_struct(tty);
 }
 
@@ -1383,7 +1385,10 @@
 init_dev_done:
 #endif
 	filp->private_data = tty;
-	file_move(filp, &tty->tty_files);
+	if (filp->f_list.next == &filp->f_list)
+		list_add(&filp->f_list, &tty->tty_files);
+	else 
+		file_move(filp, &tty->tty_files);
 	check_tty_count(tty, "tty_open");
 	if (tty->driver.type == TTY_DRIVER_TYPE_PTY &&
 	    tty->driver.subtype == PTY_TYPE_MASTER)


