Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265595AbUBGNtb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 08:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265598AbUBGNtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 08:49:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:60635 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265595AbUBGNt3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 08:49:29 -0500
Date: Sat, 7 Feb 2004 08:49:28 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Valdis.Kletnieks@vt.edu
cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@epoch.ncsc.mil>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.2-mm1, selinux, and initrd 
In-Reply-To: <200402070505.i17553g6002224@turing-police.cc.vt.edu>
Message-ID: <Xine.LNX.4.44.0402070846040.19428-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Feb 2004 Valdis.Kletnieks@vt.edu wrote:

> On Fri, 06 Feb 2004 22:39:45 EST, James Morris said:
> 
> > Can you please try the patch below against  the 2.6.2-mm1 kernel and let 
> > me know if you still see the problem.
> 
> > diff -urN -X dontdiff linux-2.6.2-mm1.o/fs/super.c linux-2.6.2-mm1.w/fs/super
> .c
> > --- linux-2.6.2-mm1.o/fs/super.c	2004-02-05 09:24:12.000000000 -0500
> > +++ linux-2.6.2-mm1.w/fs/super.c	2004-02-06 22:32:43.309927664 -0500
> > @@ -709,7 +709,6 @@
> >  	struct super_block *sb = ERR_PTR(-ENOMEM);
> >  	struct vfsmount *mnt;
> >  	int error;
> > -	char *secdata = NULL;
> 
> Yes, backing out that part of the 3 patches that hits fs/super.c makes
> a kernel that boots with selinux enabled.

Ok, looks like a problem where devfs is passing an empty string to 
do_mount when it expects a page.

Please try the patch below against 2.6.2-mm1.


- James
-- 
James Morris
<jmorris@redhat.com>

diff -urN -X dontdiff linux-2.6.2-mm1.o/fs/devfs/base.c linux-2.6.2-mm1.w/fs/devfs/base.c
--- linux-2.6.2-mm1.o/fs/devfs/base.c	2004-02-05 09:24:12.000000000 -0500
+++ linux-2.6.2-mm1.w/fs/devfs/base.c	2004-02-07 08:39:17.000000000 -0500
@@ -2832,7 +2832,7 @@
     int err;
 
     if ( !(boot_options & OPTION_MOUNT) ) return;
-    err = do_mount ("none", "/dev", "devfs", 0, "");
+    err = do_mount ("none", "/dev", "devfs", 0, NULL);
     if (err == 0) printk (KERN_INFO "Mounted devfs on /dev\n");
     else PRINTK ("(): unable to mount devfs, err: %d\n", err);
 }   /*  End Function mount_devfs_fs  */

