Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310285AbSCLBGv>; Mon, 11 Mar 2002 20:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310280AbSCLBGn>; Mon, 11 Mar 2002 20:06:43 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:27801 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S310279AbSCLBG2>;
	Mon, 11 Mar 2002 20:06:28 -0500
Date: Tue, 12 Mar 2002 12:04:52 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrea Arcangeli <andrea@suse.de>
Cc: oskar@osk.mine.nu, linux-kernel@vger.kernel.org
Subject: Re: directory notifications lost after fork?
Message-Id: <20020312120452.3038c4bc.sfr@canb.auug.org.au>
In-Reply-To: <20020311112652.E10413@dualathlon.random>
In-Reply-To: <20020310210802.GA1695@oskar>
	<20020311112652.E10413@dualathlon.random>
X-Mailer: Sylpheed version 0.7.2 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

On Mon, 11 Mar 2002 11:26:52 +0100 Andrea Arcangeli <andrea@suse.de> wrote:
>
> On Sun, Mar 10, 2002 at 10:08:02PM +0100, Oskar Liljeblad wrote:
> > The code snipper demonstrates what I consider a bug in the
> > dnotify facilities in the kernel. After a fork, all registered
> > notifications are lost in the process where they originally
> > where registered (the parent process). "lost" here means that
> > the signal specified with F_SETSIG fcntl no longer is delivered
> > when notified.
> 
> this should fix your problem:
> 
> 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre2aa2/00_dnotify-fl_owner-1
> 
> Andrea

Can you see any reason we should not use hte patch below instead?
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.4.19-pre3/fs/dnotify.c 2.4.19-pre3-notify/fs/dnotify.c
--- 2.4.19-pre3/fs/dnotify.c	Wed Nov  8 18:27:57 2000
+++ 2.4.19-pre3-notify/fs/dnotify.c	Tue Mar 12 12:02:15 2002
@@ -1,7 +1,7 @@
 /*
  * Directory notifications for Linux.
  *
- * Copyright (C) 2000 Stephen Rothwell
+ * Copyright (C) 2000,2001,2002 Stephen Rothwell
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
@@ -59,7 +59,7 @@
 	write_lock(&dn_lock);
 	prev = &inode->i_dnotify;
 	for (odn = *prev; odn != NULL; prev = &odn->dn_next, odn = *prev)
-		if (odn->dn_filp == filp)
+		if ((odn->dn_owner == current->files) && (odn->dn_filp == filp))
 			break;
 	if (odn != NULL) {
 		if (turning_off) {
@@ -82,6 +82,7 @@
 	dn->dn_mask = arg;
 	dn->dn_fd = fd;
 	dn->dn_filp = filp;
+	dn->dn_owner = current->files;
 	inode->i_dnotify_mask |= arg & ~DN_MULTISHOT;
 	dn->dn_next = inode->i_dnotify;
 	inode->i_dnotify = dn;
diff -ruN 2.4.19-pre3/include/linux/dnotify.h 2.4.19-pre3-notify/include/linux/dnotify.h
--- 2.4.19-pre3/include/linux/dnotify.h	Wed Mar  6 16:08:12 2002
+++ 2.4.19-pre3-notify/include/linux/dnotify.h	Tue Mar 12 11:23:07 2002
@@ -11,6 +11,7 @@
 						   see linux/fcntl.h */
 	int			dn_fd;
 	struct file *		dn_filp;
+	fl_owner_t		dn_owner;
 };
 
 #define DNOTIFY_MAGIC	0x444E4F54
