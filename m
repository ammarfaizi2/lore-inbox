Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262766AbULQHzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262766AbULQHzk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 02:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbULQHzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 02:55:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:57794 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262766AbULQHz2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 02:55:28 -0500
Date: Thu, 16 Dec 2004 23:55:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc3-mm1
Message-Id: <20041216235505.3eaad88c.akpm@osdl.org>
In-Reply-To: <20041217025127.GP771@holomorphy.com>
References: <20041213020319.661b1ad9.akpm@osdl.org>
	<20041215113515.GJ771@holomorphy.com>
	<20041215034239.2d2f9d9d.akpm@osdl.org>
	<20041217025127.GP771@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> William Lee Irwin III <wli@holomorphy.com> wrote:
> >>  This appears to have trouble on em64t; not only does the following happen,
> >>  but some odd userspace programs (e.g. ssh) appear to be failing.
> >> 
> >>  Shutting down powersaved                                                       cut here ] --------- [please bite here ] ---------
> >>  KDdoneernel BUG at pageattr:156
> 
> On Wed, Dec 15, 2004 at 03:42:39AM -0800, Andrew Morton wrote:
> > I can't say I'm surprised, really, although it booted and did stuff OK on my
> > box.
> > There's a mangled-up mess of ioremap/pageattr patches from Andrea and Andi
> > in there.  I'll drop a few things.  We need to go through those changes a
> > little more carefully.
> 
> The odd userspace programs failing are far more disturbing. They
> suggest COW or something of similar gravity is broken on x86-64
> by some new patch. The ioremap/pageattr issues are merely some
> shutdown-time oops, which is rather minor in comparison, although
> reported far more verbosely.

Oh, I missed that.  Did you apply the ioctl fix?


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

