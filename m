Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317864AbSHPV5Y>; Fri, 16 Aug 2002 17:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318174AbSHPV5Y>; Fri, 16 Aug 2002 17:57:24 -0400
Received: from p024.as-l031.contactel.cz ([212.65.234.216]:3456 "EHLO
	ppc.vc.cvut.cz") by vger.kernel.org with ESMTP id <S317864AbSHPV5X>;
	Fri, 16 Aug 2002 17:57:23 -0400
Date: Fri, 16 Aug 2002 23:59:04 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: torvalds@transmeta.com, jsimmons@users.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] oops from console subsystem: dereferencing wild pointer
Message-ID: <20020816215904.GA13358@ppc.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, hi James,
  recently I found that my (2.5.31) system sometime oopses when I hit a key 
while looking for results of tasks I started in single-user mode by using
xxx > /dev/ttyXX. Stack trace reveals that oops happens in handle_scancode 
in drivers/char/keyboard.c. It does:

        tty = vc->vc_tty;

        if (tty && (!tty->driver_data)) {
                /*
                 * We touch the tty structure via the ttytab array
                 * without knowing whether or not tty is open, which
                 * is inherently dangerous.  We currently rely on that
                 * fact that console_open sets tty->driver_data when
                 * it opens it, and clears it when it closes it.
                 */
                tty = NULL;
        }

but unfortunately this worked only before we started doing kfree()
on tty structures, when they were statically allocated in console code. 
Now, when we release tty, vc->vc_tty points to random memory, and sooner 
or later tty memory will be used for something else, and kernel will oops 
(in my case L_ECHO(tty) will fail because of tty->termios cannot be 
dereferenced).

Patch below fixes problem for me, and I also believe that after patch 
below we can remove if () shown above from the keyboard.c.

I have no idea how VT code synchronizes, so I did not added any locking
around setting vc_tty (maybe con_close should call 
acquire_console_sem/release_console_sem around code which touches 
tty->driver_data and clears vc_tty so that other CPUs can stop using 
tty struct before pointer will become wild, but it should be already 
ensured by checking tty->count != 1). I'm sure that patch below does not 
make locking situation worse than it is before applying patch: any 
potentially not synchronized code could use wild pointer before, and 
it will use NULL pointer now.

You can reproduce oopses without patch below by booting with 'init=/bin/bash',
then do 'echo xxx > /dev/tty2', then start filling all computer memory with 
something (dd if=/dev/hda of=/dev/null works for me), switch to VT 2, and
hit key from time to time. Sooner or later oopses appears. If you have
enabled filling kfreed memory with 0x5A, you can skip dd step.

					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz


diff -urdN linux/drivers/char/console.c linux/drivers/char/console.c
--- linux/drivers/char/console.c	2002-08-16 20:17:03.000000000 +0200
+++ linux/drivers/char/console.c	2002-08-16 23:08:50.000000000 +0200
@@ -2395,10 +2395,16 @@
 
 static void con_close(struct tty_struct *tty, struct file * filp)
 {
+	struct vt_struct *vt;
+	
 	if (!tty)
 		return;
 	if (tty->count != 1) return;
 	vcs_make_devfs (minor(tty->device) - tty->driver.minor_start, 1);
+	vt = (struct vt_struct*)tty->driver_data;
+	if (vt) {
+		vc_cons[vt->vc_num].d->vc_tty = NULL;
+	}
 	tty->driver_data = 0;
 }
 
