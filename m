Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbUDOCwG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 22:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263555AbUDOCwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 22:52:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:17896 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261803AbUDOCwB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 22:52:01 -0400
Date: Wed, 14 Apr 2004 19:51:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nathan Lynch <nathanl@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org, olof@austin.ibm.com
Subject: Re: [PATCH] Increase number of dynamic inodes in procfs (2.6.5)
Message-Id: <20040414195116.778fa4b2.akpm@osdl.org>
In-Reply-To: <407DF5AD.5090909@austin.ibm.com>
References: <407C4130.8000901@austin.ibm.com>
	<20040413170642.22894ebc.akpm@osdl.org>
	<407DF5AD.5090909@austin.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Lynch <nathanl@austin.ibm.com> wrote:
>
> > This open-codes a simple version of lib/idr.c.  Please use lib/idr.c
>  > instead.  There's an example in fs/super.c
> 
>  Ok, thanks for the tip.  Is this better?

Looks OK.  How well tested was it?  Nothing calls init_proc_inum_idr().
Maybe all-zeroes happens to work.

Happily, there's an idr patch in -mm which allows us to initialise these
guys at compile time, so...


diff -puN fs/proc/generic.c~increase-number-of-dynamic-inodes-in-procfs-265-idr-init fs/proc/generic.c
--- 25/fs/proc/generic.c~increase-number-of-dynamic-inodes-in-procfs-265-idr-init	2004-04-14 19:47:41.313236640 -0700
+++ 25-akpm/fs/proc/generic.c	2004-04-14 19:48:42.484937128 -0700
@@ -277,16 +277,11 @@ static int xlate_proc_name(const char *n
 	return 0;
 }
 
-static struct idr proc_inum_idr;
+static DEFINE_IDR(proc_inum_idr);
 static spinlock_t proc_inum_lock = SPIN_LOCK_UNLOCKED; /* protects the above */
 
 #define PROC_DYNAMIC_FIRST 0xF0000000UL
 
-void __init init_proc_inum_idr(void)
-{
-	idr_init(&proc_inum_idr);
-}
-
 /*
  * Return an inode number between PROC_DYNAMIC_FIRST and
  * 0xffffffff, or zero on failure.
@@ -376,6 +371,7 @@ struct dentry *proc_lookup(struct inode 
 				continue;
 			if (!memcmp(dentry->d_name.name, de->name, de->namelen)) {
 				unsigned int ino = de->low_ino;
+
 				error = -EINVAL;
 				inode = proc_get_inode(dir->i_sb, ino, de);
 				break;

_

