Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262891AbVAFQQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262891AbVAFQQf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 11:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262893AbVAFQQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 11:16:35 -0500
Received: from mail.mellanox.co.il ([194.90.237.34]:51943 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S262891AbVAFQQb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 11:16:31 -0500
Date: Thu, 6 Jan 2005 18:18:10 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Andrew Morton <akpm@osdl.org>
Cc: Takashi Iwai <tiwai@suse.de>, ak@suse.de, mingo@elte.hu,
       rlrevell@joe-job.com, linux-kernel@vger.kernel.org, pavel@suse.cz,
       discuss@x86-64.org, gordon.jin@intel.com,
       alsa-devel@lists.sourceforge.net, greg@kroah.com
Subject: [PATCH] fget_light/fput_light for ioctls (fixed)
Message-ID: <20050106161810.GE25955@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20041215065650.GM27225@wotan.suse.de> <20041217014345.GA11926@mellanox.co.il> <20050103011113.6f6c8f44.akpm@osdl.org> <20050105144043.GB19434@mellanox.co.il> <s5hd5wjybt8.wl@alsa2.suse.de> <20050105133448.59345b04.akpm@osdl.org> <20050106145103.GB25898@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106145103.GB25898@mellanox.co.il>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
Sorry, that patch had a typo. Here's an updated version.

>>> Quoting r. Michael S. Tsirkin (mst@mellanox.co.il)

With new unlocked_ioctl and ioctl_compat, ioctls can now
be as fast as read/write.  So lets use fget_light/fput_light there,
to get some speedup in common case on SMP.

mst

Signed-off-by: Michael s. Tsirkin <mst@mellanox.co.il>

diff -rup linux-2.6.10/fs/compat.c linux-2.6.10-ioctls/fs/compat.c
--- linux-2.6.10/fs/compat.c	2005-01-06 17:54:13.000000000 +0200
+++ linux-2.6.10-ioctls/fs/compat.c	2005-01-06 20:15:44.407259408 +0200
@@ -431,8 +431,9 @@ asmlinkage long compat_sys_ioctl(unsigne
 	struct file *filp;
 	int error = -EBADF;
 	struct ioctl_trans *t;
+	int fput_needed;
 
-	filp = fget(fd);
+	filp = fget_light(fd, &fput_needed);
 	if (!filp)
 		goto out;
 
@@ -476,7 +479,7 @@ asmlinkage long compat_sys_ioctl(unsigne
  do_ioctl:
 	error = sys_ioctl(fd, cmd, arg);
  out_fput:
-	fput(filp);
+	fput_light(filp, fput_needed);
  out:
 	return error;
 }
diff -rup linux-2.6.10/fs/ioctl.c linux-2.6.10-ioctls/fs/ioctl.c
--- linux-2.6.10/fs/ioctl.c	2005-01-06 17:54:13.000000000 +0200
+++ linux-2.6.10-ioctls/fs/ioctl.c	2005-01-06 20:34:09.329285728 +0200
@@ -80,8 +83,9 @@ asmlinkage long sys_ioctl(unsigned int f
 	struct file * filp;
 	unsigned int flag;
 	int on, error = -EBADF;
+	int fput_needed;
 
-	filp = fget(fd);
+	filp = fget_light(fd, &fput_needed);
 	if (!filp)
 		goto out;
 
@@ -154,7 +158,7 @@ asmlinkage long sys_ioctl(unsigned int f
 			break;
 	}
  out_fput:
-	fput(filp);
+	fput_light(filp, fput_needed);
  out:
 	return error;
 }
