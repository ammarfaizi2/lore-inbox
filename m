Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264494AbRF3VXY>; Sat, 30 Jun 2001 17:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264477AbRF3VXO>; Sat, 30 Jun 2001 17:23:14 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:33676 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S264494AbRF3VXF>; Sat, 30 Jun 2001 17:23:05 -0400
Date: Sat, 30 Jun 2001 23:10:40 +0200
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: PATCH: drivers/char/vt.c allows virtually locking up nonnetworked machine
Message-ID: <20010630231040.A3501@www42.durchnull.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: Rudolf Polzer <rpolzer@durchnull.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a problem concerning chvt. A normal user can run a

bash$ while [ 1 ]; do chvt 11; done

which cannot be killed using the console (only remotely, virtually never
on a nonnetworked multiuser machine). So I changed the kernel source code
so that only the superuser may change terminals.

Since renaming/deleting chvt is no solution (chvt is a simple ioctl call),
it seems to be the simplest way to prevent this. Console switching
using Ctrl-Alt-Fkey still works, as well as X, so probably there are
no implications in most cases.

But, since this may be too restrictive for some applications, I would
recommend making this a configuration option. Unfortunately I do not
know how to do this :(

--- drivers/char/vt.c.orig	Mon Jun 25 09:00:28 2001
+++ drivers/char/vt.c	Sat Jun 30 23:02:56 2001
@@ -435,10 +435,16 @@
 
 	/*
 	 * To have permissions to do most of the vt ioctls, we either have
-	 * to be the owner of the tty, or super-user.
+	 * to be the owner of the tty, or super-user. Only the superuser
+	 * if you want added security.
+	 */
+         
+	/*
+	 * disable a security hole, therefore the first check is commented
+	 * out!
 	 */
 	perm = 0;
-	if (current->tty == tty || suser())
+	if (/* current->tty == tty || */ suser())
 		perm = 1;
  
 	kbd = kbd_table + console;
