Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267514AbUJBTIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267514AbUJBTIT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 15:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267515AbUJBTIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 15:08:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:1476 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267514AbUJBTIR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 15:08:17 -0400
Date: Sat, 2 Oct 2004 12:08:12 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Marcel Sebek <sebek64@post.cz>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.6.9-rc3-bk1] Sleeping function called from invalid context
In-Reply-To: <20041001205658.7c2b8ecf.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0410021201340.2301@ppc970.osdl.org>
References: <20041001203505.GA4480@penguin.localdomain>
 <20041001205658.7c2b8ecf.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 1 Oct 2004, Andrew Morton wrote:
> 
> In rc3 change_termios() was altered so that it calls
> (*tty->driver->set_termios)() under spin_lock_irqsave(tty_termios_lock).
> 
> But ftdi_set_termios() wants to perform USB I/O, which involves sleeping
> allocations all over the place.

Alan, my first reaction was "that's just a buggy driver", but looking at 
the reason for it (telling the device at the other end to change it's 
speed), it's clearly not the driver. The new spinlock is just wrong.

We might be able to change it to a per-tty semaphore instead, which sounds 
reasonably safe, but in the meantime I don't think we have any other 
choice than to just leave the driver/ldisc routines unprotected. They 
should be just reading the state, after all.

I'm committing this temporary fix..

		Linus
----
===== drivers/char/tty_ioctl.c 1.13 vs edited =====
--- 1.13/drivers/char/tty_ioctl.c	2004-09-29 14:27:20 -07:00
+++ edited/drivers/char/tty_ioctl.c	2004-10-02 12:06:40 -07:00
@@ -145,6 +145,13 @@
 			wake_up_interruptible(&tty->link->read_wait);
 		}
 	}
+
+	/*
+	 * Fixme! We should really try to protect the driver and ldisc
+	 * termios usage too. But they need to be able to sleep, so
+	 * the global termios spinlock is not the right thing.
+	 */
+	spin_unlock_irqrestore(&tty_termios_lock, flags);
 	   
 	if (tty->driver->set_termios)
 		(*tty->driver->set_termios)(tty, &old_termios);
@@ -155,7 +162,6 @@
 			(ld->set_termios)(tty, &old_termios);
 		tty_ldisc_deref(ld);
 	}
-	spin_unlock_irqrestore(&tty_termios_lock, flags);
 }
 
 static int set_termios(struct tty_struct * tty, void __user *arg, int opt)
