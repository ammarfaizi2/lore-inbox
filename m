Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbTEYLj1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 07:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262021AbTEYLj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 07:39:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37248 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262017AbTEYLjZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 07:39:25 -0400
Date: Sun, 25 May 2003 12:52:34 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Mitch@0Bits.COM
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21-rc3, writing to /dev/console returns ESPIPE
Message-ID: <20030525115234.GD6270@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.53.0305251215020.2812@mx.homelinux.com> <20030525113912.GB6270@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030525113912.GB6270@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 25, 2003 at 12:39:12PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Sun, May 25, 2003 at 12:22:14PM +0100, Mitch@0Bits.COM wrote:
> > The checkin on linux-2.4.21-rc3/drivers/char/tty_io.c
> > 
> > +       /* Can't seek (pwrite) on ttys.  */
> > +       if (ppos != &file->f_pos)
> > +               return -ESPIPE;
> > 
> > should not be there in my opinion.
> 
> s/not be/be not/

Grrr....  Correct patch follows:

--- drivers/char/tty_io.c	Sat May 17 11:14:02 2003
+++ /tmp/tty_io.c	Sun May 25 07:49:08 2003
@@ -751,6 +751,10 @@
 	struct tty_struct * tty;
 	struct inode *inode = file->f_dentry->d_inode;
 
+	/* Can't seek (pwrite) on ttys.  */
+	if (ppos != &file->f_pos)
+		return -ESPIPE;
+
 	/*
 	 *      For now, we redirect writes from /dev/console as
 	 *      well as /dev/tty0.
@@ -770,15 +774,11 @@
 		spin_unlock(&redirect_lock);
 
 		if (p) {
-			ssize_t res = p->f_op->write(p, buf, count, ppos);
+			ssize_t res = p->f_op->write(p, buf, count, &p->f_pos);
 			fput(p);
 			return res;
 		}
 	}
-
-	/* Can't seek (pwrite) on ttys.  */
-	if (ppos != &file->f_pos)
-		return -ESPIPE;
 
 	tty = (struct tty_struct *)file->private_data;
 	if (tty_paranoia_check(tty, inode->i_rdev, "tty_write"))
