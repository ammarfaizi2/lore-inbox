Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261329AbULMTyC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbULMTyC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 14:54:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbULMTwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 14:52:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:54955 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262290AbULMTeL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 14:34:11 -0500
Date: Mon, 13 Dec 2004 11:33:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Rudmer van Dijk <rudmer@legolas.dynup.net>
Cc: marado@student.dei.uc.pt, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc3-mm1
Message-Id: <20041213113336.02a0abfd.akpm@osdl.org>
In-Reply-To: <200412131910.24255.rudmer@legolas.dynup.net>
References: <20041213020319.661b1ad9.akpm@osdl.org>
	<Pine.LNX.4.61.0412131603370.14874@student.dei.uc.pt>
	<200412131910.24255.rudmer@legolas.dynup.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rudmer van Dijk <rudmer@legolas.dynup.net> wrote:
>
> > OTOH, while I had no problems with the previous mm's or with 2.6.10-rc3,
>  > with -rc3-mm1 kdm has an weird function: with kdm/unstable uptodate
>  > 4:3.3.1-3 from Debian it just restarts X when it's going to show the
>  > login/password form, restarting over and over.
> 
>  saw it too with gdm on Gentoo,

It's probably the ioctl screwup.


From: Mikael Pettersson <mikpe@csd.uu.se>

The ioctl-cleanup.patch in 2.6.10-rc3-mm1 broke the file ioctls: FIONREAD
etc.  These ioctls have inline code for S_ISREG() cases, but should be
redirected to ->ioctl() for other cases.  ioctl-cleanup.patch removed that
redirection.

For me, both emacs and X refused to start from a console with ENOTTY
errors; at least emacs got the ENOTTY from FIONREAD.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/fs/ioctl.c |   18 ++++++------------
 1 files changed, 6 insertions(+), 12 deletions(-)

diff -puN fs/ioctl.c~ioctl-cleanups-broke-fionread-et-al fs/ioctl.c
--- 25/fs/ioctl.c~ioctl-cleanups-broke-fionread-et-al	2004-12-13 11:12:37.687951760 -0800
+++ 25-akpm/fs/ioctl.c	2004-12-13 11:12:37.690951304 -0800
@@ -91,10 +91,8 @@ asmlinkage long sys_ioctl(unsigned int f
 			int block;
 			int res;
 
-			if (!S_ISREG(inode->i_mode)) {
-				error = -ENOTTY;
-				goto done;
-			}
+			if (!S_ISREG(inode->i_mode))
+				break;
 			/* do we support this mess? */
 			if (!mapping->a_ops->bmap) {
 				error = -EINVAL;
@@ -112,19 +110,15 @@ asmlinkage long sys_ioctl(unsigned int f
 			goto done;
 		}
 	case FIGETBSZ:
-		if (!S_ISREG(inode->i_mode)) {
-			error = -ENOTTY;
-			goto done;
-		}
+		if (!S_ISREG(inode->i_mode))
+			break;
 		error = -EBADF;
 		if (inode->i_sb)
 			error = put_user(inode->i_sb->s_blocksize, p);
 		goto done;
 	case FIONREAD:
-		if (!S_ISREG(inode->i_mode)) {
-			error = -ENOTTY;
-			goto done;
-		}
+		if (!S_ISREG(inode->i_mode))
+			break;
 		error = put_user(i_size_read(inode) - filp->f_pos, p);
 		goto done;
 	}
_

