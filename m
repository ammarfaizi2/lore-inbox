Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbUCaIwI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 03:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261854AbUCaIwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 03:52:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:53995 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261846AbUCaIwA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 03:52:00 -0500
Date: Wed, 31 Mar 2004 00:51:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc3-mm1
Message-Id: <20040331005152.03b46cc5.akpm@osdl.org>
In-Reply-To: <20040331082514.A27804@flint.arm.linux.org.uk>
References: <20040330023437.72bb5192.akpm@osdl.org>
	<20040331000301.GB9269@kroah.com>
	<20040330162850.50a0fad4.akpm@osdl.org>
	<20040330182627.0e43f1ae.akpm@osdl.org>
	<20040331082514.A27804@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
> On Tue, Mar 30, 2004 at 06:26:27PM -0800, Andrew Morton wrote:
> > Andrew Morton <akpm@osdl.org> wrote:
> > >
> > > I'm thinking that this can be fixed from the other direction: just before
> > >  release_dev() calls close (dropping BKL), if tty->count==1, make the
> > >  going-away tty ineligible for concurrent lookups.  Do that by setting
> > >  tty->driver->ttys[idx] to NULL.  Maybe.
> > 
> > Famous last word: Volia!
> 
> I suspect you may just be able to get away with this for serial drivers
> using serial_core.  However, I suspect it'll break non-serial_core using
> serial drivers.
> 
> The serial drivers track the tty count themselves, so that they know
> when to do the final close processing (why you may ask - because of
> the blocking for DCD in the open code.)  I wouldn't like to say what
> would happen if ->open were called for a different tty structure for
> the same port while ->close was in progress.

You cannot defeat me that easily!

Actually the race+oops _was_ fixed in Linus's tree a week ago, sort-of.  If
the race happens we end up running vcs_devfs_add() and vcs_devfs_remove()
against the tty concurrently, leaving it in indeterminate state.  This will
cause devfs warnings and missing devfs/sysfs stuff, but no oops.

The con_open-speedup.patch in -mm reintroduces the oops by not bogusly
overwriting tty->driver_data when tty->count > 1.  Fun.

This rather nasty patch fixes things up again.


 25-akpm/drivers/char/tty_io.c |    2 +-
 25-akpm/drivers/char/vt.c     |   14 ++++++++++++++
 25-akpm/include/linux/tty.h   |    3 +++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff -puN drivers/char/vt.c~tty-race-fix-43 drivers/char/vt.c
--- 25/drivers/char/vt.c~tty-race-fix-43	2004-03-31 00:44:54.582831728 -0800
+++ 25-akpm/drivers/char/vt.c	2004-03-31 00:44:54.589830664 -0800
@@ -2480,8 +2480,16 @@ static int con_open(struct tty_struct *t
 	return ret;
 }
 
+/*
+ * We take tty_sem in here to prevent another thread from coming in via init_dev
+ * and taking a ref against the tty while we're in the process of forgetting
+ * about it and cleaning things up.
+ *
+ * This is because vcs_remove_devfs() can sleep and will drop the BKL.
+ */
 static void con_close(struct tty_struct *tty, struct file *filp)
 {
+	down(&tty_sem);
 	acquire_console_sem();
 	if (tty && tty->count == 1) {
 		struct vt_struct *vt;
@@ -2492,9 +2500,15 @@ static void con_close(struct tty_struct 
 		tty->driver_data = 0;
 		release_console_sem();
 		vcs_remove_devfs(tty);
+		up(&tty_sem);
+		/*
+		 * tty_sem is released, but we still hold BKL, so there is
+		 * still exclusion against init_dev()
+		 */
 		return;
 	}
 	release_console_sem();
+	up(&tty_sem);
 }
 
 static void vc_init(unsigned int currcons, unsigned int rows,
diff -puN drivers/char/tty_io.c~tty-race-fix-43 drivers/char/tty_io.c
--- 25/drivers/char/tty_io.c~tty-race-fix-43	2004-03-31 00:44:54.584831424 -0800
+++ 25-akpm/drivers/char/tty_io.c	2004-03-31 00:44:54.591830360 -0800
@@ -123,7 +123,7 @@ LIST_HEAD(tty_drivers);			/* linked list
 struct tty_ldisc ldiscs[NR_LDISCS];	/* line disc dispatch table	*/
 
 /* Semaphore to protect creating and releasing a tty */
-static DECLARE_MUTEX(tty_sem);
+DECLARE_MUTEX(tty_sem);
 
 #ifdef CONFIG_UNIX98_PTYS
 extern struct tty_driver *ptm_driver;	/* Unix98 pty masters; for /dev/ptmx */
diff -puN include/linux/tty.h~tty-race-fix-43 include/linux/tty.h
--- 25/include/linux/tty.h~tty-race-fix-43	2004-03-31 00:44:54.586831120 -0800
+++ 25-akpm/include/linux/tty.h	2004-03-31 00:44:54.592830208 -0800
@@ -363,6 +363,9 @@ extern void tty_flip_buffer_push(struct 
 extern int tty_get_baud_rate(struct tty_struct *tty);
 extern int tty_termios_baud_rate(struct termios *termios);
 
+struct semaphore;
+extern struct semaphore tty_sem;
+
 /* n_tty.c */
 extern struct tty_ldisc tty_ldisc_N_TTY;
 

_

