Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288953AbSATUE4>; Sun, 20 Jan 2002 15:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288959AbSATUEr>; Sun, 20 Jan 2002 15:04:47 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:19848 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S288953AbSATUEj>; Sun, 20 Jan 2002 15:04:39 -0500
Date: Sun, 20 Jan 2002 13:04:36 -0700
Message-Id: <200201202004.g0KK4aN13185@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Dan Chen <crimsun@email.unc.edu>
Cc: Lawrence Walton <lawrence@the-penguin.otak.com>,
        linux-kernel@vger.kernel.org
Subject: Re: DEVFS broken?
In-Reply-To: <20020117190449.GA2860@opeth.ath.cx>
In-Reply-To: <20020117171229.GA1084@the-penguin.otak.com>
	<20020117190449.GA2860@opeth.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Chen writes:
> Also using Debian sid here (devfsd 1.3.21-1). Over the past two days
> I've seen random nasties with devfs-v199.6 and v199.7 (I backed out
> v199.7 in my local tree because my machine refuses to finish booting
> otherwise). Machine: VIA VT82C693A/694x, PIII/1GHz SMP, 1GB HIGHMEM
> enabled.
> 
> What follows is a series of crashes culled from /var/log/kern.log
> (apologies regarding the format). Before each I'll explain what I did to
> possibly invoke it. All are with devfs-v199.6 and devfsd-1.3.21 running
> 2.4.18-pre4 + ext3-2.4-0.9.17-2418p3 + ide.2.4.16.12102001:
> 
> # modprobe aic7xxx   //I tried to start an Eterm in X 4.1.0.1 afterward
> -- snip --
> Jan 16 22:54:50 opeth kernel: invalid operand: 0000

In future, please just send dmesg output, rather than
/var/log/kern.log output. The former doesn't have all the
date+hostname+" kernel: " crap that syslog puts in.

devfs-patch-v199.6 has a race that causes the Oops. devfs-patch-v199.7
fixes this race, but unfortunately had a silly oversight which could
cause deadlocks under some circumstances (and of course several days
of testing on my box didn't show it:-().

Please apply this patch on top of devfs-patch-v199.7 or on top of
plain 2.5.2, and let me know the result.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

diff -urN linux-2.5.3-pre2/fs/devfs/base.c linux/fs/devfs/base.c
--- linux-2.5.3-pre2/fs/devfs/base.c	Mon Jan 14 10:40:29 2002
+++ linux/fs/devfs/base.c	Sun Jan 20 12:09:55 2002
@@ -1,6 +1,6 @@
 /*  devfs (Device FileSystem) driver.
 
-    Copyright (C) 1998-2001  Richard Gooch
+    Copyright (C) 1998-2002  Richard Gooch
 
     This library is free software; you can redistribute it and/or
     modify it under the terms of the GNU Library General Public
@@ -604,6 +604,9 @@
     20020113   Richard Gooch <rgooch@atnf.csiro.au>
 	       Fixed (rare, old) race in <devfs_lookup>.
   v1.9
+    20020120   Richard Gooch <rgooch@atnf.csiro.au>
+	       Fixed deadlock bug in <devfs_d_revalidate_wait>.
+  v1.10
 */
 #include <linux/types.h>
 #include <linux/errno.h>
@@ -636,7 +639,7 @@
 #include <asm/bitops.h>
 #include <asm/atomic.h>
 
-#define DEVFS_VERSION            "1.9 (20020113)"
+#define DEVFS_VERSION            "1.10 (20020120)"
 
 #define DEVFS_NAME "devfs"
 
@@ -2878,13 +2881,16 @@
     struct devfs_lookup_struct *lookup_info = dentry->d_fsdata;
     DECLARE_WAITQUEUE (wait, current);
 
-    if ( !dentry->d_inode && is_devfsd_or_child (fs_info) )
+    if ( is_devfsd_or_child (fs_info) )
     {
 	devfs_handle_t de = lookup_info->de;
 	struct inode *inode;
 
-	DPRINTK (DEBUG_I_LOOKUP, "(%s): dentry: %p de: %p by: \"%s\"\n",
-		 dentry->d_name.name, dentry, de, current->comm);
+	DPRINTK (DEBUG_I_LOOKUP,
+		 "(%s): dentry: %p inode: %p de: %p by: \"%s\"\n",
+		 dentry->d_name.name, dentry, dentry->d_inode, de,
+		 current->comm);
+	if (dentry->d_inode) return 1;
 	if (de == NULL)
 	{
 	    read_lock (&parent->u.dir.lock);
