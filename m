Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262388AbVAZIjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262388AbVAZIjh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 03:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbVAZIjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 03:39:35 -0500
Received: from mail.mellanox.co.il ([194.90.237.34]:8744 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S262388AbVAZIja
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 03:39:30 -0500
Date: Wed, 26 Jan 2005 10:40:13 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Andi Kleen <ak@suse.de>
Cc: hch@infradead.org, linux-kernel@vger.kernel.org, chrisw@osdl.org,
       davem@davemloft.net
Subject: Re: [PATCH] move common compat ioctls to hash
Message-ID: <20050126084013.GA3791@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20050118072133.GB76018@muc.de> <20050118110432.GE23127@mellanox.co.il> <20050124202609.GA15057@mellanox.co.il> <20050125061741.GA27013@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050125061741.GA27013@wotan.suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Andi Kleen <ak@suse.de>:
> Subject: Re: [PATCH] move common compat ioctls to hash
> 
> On Mon, Jan 24, 2005 at 10:26:09PM +0200, Michael S. Tsirkin wrote:
> > Hi!
> > The new ioctl code in fs/compat.c can be streamlined a little
> > using the compat hash instead of an explicit switch statement.
> > 
> > The attached patch is against 2.6.11-rc2-bk2.
> > Andi, could you please comment? Does this make sence?
> 
> Problem is that when a compat_ioctl handler returns -EINVAL
> instead of -ENOIOCTLCMD on unknown ioctl it won't check the common
> ones.
> 
> I fear this mistake would be common, that is why I put in the switch.
> 
> -Andi

Still, many drivers still need the compat hash lookup to work
properly, and these still require -ENOIOCTLCMD to work properly.
So is it worth it wasting CPU cycles working around only part of the problem?

How about:
1. Adding a comment in fs.h
2. Changing unlocked_ioctl to behave in the same way as compat_ioctl
 (this will help since unlocked_ioctl will be well tested),
 something along the lines of my old patch below [its against 2.6.11-rc1-bk5].

As a bonus, I expect a small speedup in code using unlocked_ioctl
(as well as compat_ioctl) for datapath things like usb transfers.

Andy, if this sounds convincing, let me know and I'll build a real patch.

MST

diff -rup linux-2.6.10-orig/fs/ioctl.c linux-2.6.10-ioctl-sym/fs/ioctl.c
--- linux-2.6.10-orig/fs/ioctl.c	2005-01-18 10:58:33.609880024 +0200
+++ linux-2.6.10-ioctl-sym/fs/ioctl.c	2005-01-18 10:51:55.690372984 +0200
@@ -24,12 +24,7 @@ static long do_ioctl(struct file *filp, 
 	if (!filp->f_op)
 		goto out;
 
-	if (filp->f_op->unlocked_ioctl) {
-		error = filp->f_op->unlocked_ioctl(filp, cmd, arg);
-		if (error == -ENOIOCTLCMD)
-			error = -EINVAL;
-		goto out;
-	} else if (filp->f_op->ioctl) {
+	if (filp->f_op->ioctl) {
 		lock_kernel();
 		error = filp->f_op->ioctl(filp->f_dentry->d_inode,
 					  filp, cmd, arg);
@@ -93,6 +91,12 @@ asmlinkage long sys_ioctl(unsigned int f
  	if (error)
  		goto out_fput;
 
+	if (filp->f_op && filp->f_op->unlocked_ioctl) {
+		error = filp->f_op->unlocked_ioctl(filp, cmd, arg);
+		if (error != -ENOIOCTLCMD)
+			goto out_fput;
+	}
+
 	switch (cmd) {
 		case FIOCLEX:
 			set_close_on_exec(fd, 1);
-- 
I dont speak for Mellanox.
