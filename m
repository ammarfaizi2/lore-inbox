Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263179AbTDRQKL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 12:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263176AbTDRQJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 12:09:57 -0400
Received: from verein.lst.de ([212.34.181.86]:16909 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S263179AbTDRQJH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 12:09:07 -0400
Date: Fri, 18 Apr 2003 18:21:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devfs (1/7) - fix compilation
Message-ID: <20030418182101.A513@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <20030418181246.A363@lst.de> <Pine.LNX.4.44.0304180918010.2950-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0304180918010.2950-100000@home.transmeta.com>; from torvalds@transmeta.com on Fri, Apr 18, 2003 at 09:19:00AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 18, 2003 at 09:19:00AM -0700, Linus Torvalds wrote:
> 
> On Fri, 18 Apr 2003, Christoph Hellwig wrote:
> > @@ -1456,8 +1455,8 @@
> >      dev_t devnum = 0, dev = MKDEV(major, minor);
> >      struct devfs_entry *de;
> >  
> > -    if (flags)
> > -	printk(KERN_ERR "%s called with flags != 0, please fix!\n");
> > +    /* we don't accept any flags anymore.  prototype will change soon. */
> > +    BUG_ON(flags);
> 
> PLEASE don't use BUG_ON() except for conditions that you really cannot 
> continue from. It's damn impolite (and it makes debugging impossible) to 
> kill the kernel startup if somebody has a unconverted driver or similar.

Ok.  Is this one better?


diff -Nru a/fs/devfs/base.c b/fs/devfs/base.c
--- a/fs/devfs/base.c	Fri Apr 18 15:56:18 2003
+++ b/fs/devfs/base.c	Fri Apr 18 15:56:18 2003
@@ -1377,7 +1377,6 @@
  *	@uid: The user ID.
  *	@gid: The group ID.
  *	@fs_info: The filesystem info.
- *	@atomic: If TRUE, an atomic allocation is required.
  *
  *	Returns %TRUE if an event was queued and devfsd woken up, else %FALSE.
  */
@@ -1423,7 +1422,7 @@
 static void devfsd_notify (struct devfs_entry *de,unsigned short type)
 {
 	devfsd_notify_de(de, type, de->mode, current->euid,
-			 current->egid, &fs_info, 0);
+			 current->egid, &fs_info);
 } 
 
 
@@ -1456,8 +1455,8 @@
     dev_t devnum = 0, dev = MKDEV(major, minor);
     struct devfs_entry *de;
 
-    if (flags)
-	printk(KERN_ERR "%s called with flags != 0, please fix!\n");
+    /* we don't accept any flags anymore.  prototype will change soon. */
+    WARN_ON(flags);
 
     if (name == NULL)
     {
