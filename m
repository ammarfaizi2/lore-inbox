Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267418AbRHJMa2>; Fri, 10 Aug 2001 08:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267505AbRHJMaS>; Fri, 10 Aug 2001 08:30:18 -0400
Received: from camus.xss.co.at ([194.152.162.19]:51209 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id <S267418AbRHJMaO>;
	Fri, 10 Aug 2001 08:30:14 -0400
Message-ID: <3B73D3D6.AEDE9848@xss.co.at>
Date: Fri, 10 Aug 2001 14:30:14 +0200
From: Daniel Wagner <daniel.wagner@xss.co.at>
Organization: xS+S
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: devfsd-v1.3.13 available
In-Reply-To: <200108080643.f786hwk15743@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
> 
>   Hi, all. I've just released version 1.3.13 of my devfsd (devfs
> daemon) at: http://www.atnf.csiro.au/~rgooch/linux/
> 
> Tarball directly available from:
> ftp://ftp.??.kernel.org/pub/linux/daemons/devfsd/devfsd.tar.gz
> 
> AND:
> ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/daemons/devfsd/devfsd.tar.gz
> 
> This works with devfs-patch-v130, kernel 2.3.46 and devfs-patch-v99.7
> (or later).
> 
> The main changes are:
> 
> - Added support for DELETE event
> 
> - Added debug trace to <action_modload>
> 
> - Added compatibility entry support for SCSI discs 16 to 127
> 
> - Added support for recursively reading config directories
> 
> - Documentation updates.

consider this small patch against linux-2.2.19 with devfs-patch-v99.20,
to
allow users of 2.2 kernel the use of devfsd 1.3.13.

--- fs/devfs/base.c     2001/07/27 13:30:51     1.17
+++ fs/devfs/base.c     2001/08/10 12:22:00
@@ -2829,6 +2829,7 @@
 static int devfs_unlink (struct inode *dir, struct dentry *dentry)
 {
     struct devfs_inode *di;
+    struct inode *inode = dentry->d_inode;
 
 #ifdef CONFIG_DEVFS_DEBUG
     char txt[STRING_LENGTH];
@@ -2847,6 +2848,8 @@
     di = get_devfs_inode_from_vfs_inode (dentry->d_inode);
     if (di == NULL) return -ENOENT;
     if (!di->de->registered) return -ENOENT;
+    devfsd_notify_one (di->de, DEVFSD_NOTIFY_DELETE, inode->i_mode,
+                       inode->i_uid, inode->i_gid,
inode->i_sb->u.generic_sbp);
     di->de->registered = FALSE;
     di->de->hide = TRUE;
     free_dentries (di->de);
diff -u -r1.1.1.1 devfs_fs.h
--- include/linux/devfs_fs.h    2000/06/09 08:56:12     1.1.1.1
+++ include/linux/devfs_fs.h    2001/08/10 12:22:01
@@ -20,6 +20,7 @@
 #define DEVFSD_NOTIFY_LOOKUP        4
 #define DEVFSD_NOTIFY_CHANGE        5
 #define DEVFSD_NOTIFY_CREATE        6
+#define DEVFSD_NOTIFY_DELETE        7
 
 #define DEVFS_PATHLEN               1024  /*  Never change this
otherwise the
                                              binary interface will
change   */

-- 
Daniel Wagner                      | mailto:daniel@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
