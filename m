Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130867AbQK0Nx3>; Mon, 27 Nov 2000 08:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130897AbQK0NxT>; Mon, 27 Nov 2000 08:53:19 -0500
Received: from Cantor.suse.de ([194.112.123.193]:57100 "HELO Cantor.suse.de")
        by vger.kernel.org with SMTP id <S130867AbQK0NxG>;
        Mon, 27 Nov 2000 08:53:06 -0500
Date: Mon, 27 Nov 2000 14:23:01 +0100
From: Andi Kleen <ak@suse.de>
To: "Igor Yu. Zhbanov" <bsg@uniyar.ac.ru>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
        andy@lysaker.kvaerner.no, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Kernel Oops on locking sockets via fcntl()
Message-ID: <20001127142301.A30980@gruyere.muc.suse.de>
In-Reply-To: <20001124145540.A13064@gruyere.muc.suse.de> <Pine.GSO.3.96.SK.1001127155810.24276A-100000@univ.uniyar.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.SK.1001127155810.24276A-100000@univ.uniyar.ac.ru>; from bsg@uniyar.ac.ru on Mon, Nov 27, 2000 at 03:59:05PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2000 at 03:59:05PM +0300, Igor Yu. Zhbanov wrote:
> On Fri, 24 Nov 2000, Andi Kleen wrote:
> 
> > On Fri, Nov 24, 2000 at 04:32:26PM +0300, Igor Yu. Zhbanov wrote:
> > > Hello!
> > > 
> > > One fine day accidentally I have opened an Xserver's socket placed in /tmp
> > > with my favourite text editor "le". I have got a message from the kernel similar
> > > to this:
> > 
> > 
> > Which kernel version are you using ? It should be already fixed in all 
> > modern kernels (newer 2.2 and 2.4) 
> > 
> > 
> > -Andi
> > 
> 
> My Kernel version is 2.2.17

Oops, looks like the patch got lost. I cannot find it in 2.2.18pre23 anymore.
It came up a few weeks ago and was included in some distribution kernels
(e.g. the SuSE one), but apparently fell through the tracks in the official
2.2 kernel.

Alan? Would you consider including it still in 2.2.18 ?


-Andi


diff -urN linux.a/fs/locks.c linux.s/fs/locks.c
--- linux.a/fs/locks.c	Fri Sep  1 01:01:12 2000
+++ linux.s/fs/locks.c	Fri Sep  1 01:33:05 2000
@@ -345,6 +345,9 @@
 	if (!filp->f_dentry || !filp->f_dentry->d_inode)
 		goto out_putf;
 
+	if (!filp->f_op)
+		goto out_putf;
+
 	if (!flock_to_posix_lock(filp, &file_lock, &flock))
 		goto out_putf;
 
@@ -425,6 +428,8 @@
 		goto out_putf;
 	if (!(inode = dentry->d_inode))
 		goto out_putf;
+	if (!filp->f_op)
+		goto out_putf;	
 
 	/* Don't allow mandatory locks on files that may be memory mapped
 	 * and shared.
@@ -517,6 +522,8 @@
 	error = -EINVAL;
 	if (!filp->f_dentry || !filp->f_dentry->d_inode)
 		goto out_putf;
+	if (!filp->f_op)
+		goto out_putf;
 
 	if (!flock64_to_posix_lock(filp, &file_lock, &flock))
 		goto out_putf;
@@ -585,6 +592,8 @@
 		goto out_putf;
 	if (!(inode = dentry->d_inode))
 		goto out_putf;
+	if (!filp->f_op)
+		goto out_putf;
 
 	/* Don't allow mandatory locks on files that may be memory mapped
 	 * and shared.
@@ -669,8 +678,9 @@
 	before = &inode->i_flock;
 	while ((fl = *before) != NULL) {
 		if ((fl->fl_flags & FL_POSIX) && fl->fl_owner == owner) {
-			int (*lock)(struct file *, int, struct file_lock *);
-			lock = filp->f_op->lock;
+			int (*lock)(struct file *, int, struct file_lock *) = NULL; 
+			if (filp->f_op)
+				lock = filp->f_op->lock;
 			if (lock) {
 				file_lock = *fl;
 				file_lock.fl_type = F_UNLCK;



-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
