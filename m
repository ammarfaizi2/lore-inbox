Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268586AbTCCVl3>; Mon, 3 Mar 2003 16:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268602AbTCCVl3>; Mon, 3 Mar 2003 16:41:29 -0500
Received: from modemcable166.48-200-24.mtl.mc.videotron.ca ([24.200.48.166]:6083
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S268586AbTCCVlZ>; Mon, 3 Mar 2003 16:41:25 -0500
Date: Mon, 3 Mar 2003 16:51:42 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] small tty irq race fix
In-Reply-To: <Pine.LNX.4.44.0303031338260.12285-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0303031650230.31566-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Mar 2003, Linus Torvalds wrote:

> 
> On Mon, 3 Mar 2003, Nicolas Pitre wrote:
> > 
> > What about this one?  It just happens that tty->read_lock is actually used
> > deeper in the same call instance (in n_tty.c) so this looks to be the best
> > lock to use.
> 
> Looks ok. I would suggest moving the "spin_lock_irqsave()" to outside the 
> 'if'-statement, though, since that should make the code a lot more 
> readable, and if the lock is supposed to protect tty->flip.buf_num, then 
> let's do it right and protect the read as well, no?

Oh sure.

--- linux-2.5.63/drivers/char/tty_io.c.orig	Mon Feb 24 14:05:34 2003
+++ linux-2.5.63/drivers/char/tty_io.c	Mon Mar  3 16:49:44 2003
@@ -1944,27 +1944,25 @@
 		schedule_delayed_work(&tty->flip.work, 1);
 		return;
 	}
+
+	spin_lock_irqsave(&tty->read_lock, flags);
 	if (tty->flip.buf_num) {
 		cp = tty->flip.char_buf + TTY_FLIPBUF_SIZE;
 		fp = tty->flip.flag_buf + TTY_FLIPBUF_SIZE;
 		tty->flip.buf_num = 0;
-
-		local_irq_save(flags); // FIXME: is this safe?
 		tty->flip.char_buf_ptr = tty->flip.char_buf;
 		tty->flip.flag_buf_ptr = tty->flip.flag_buf;
 	} else {
 		cp = tty->flip.char_buf;
 		fp = tty->flip.flag_buf;
 		tty->flip.buf_num = 1;
-
-		local_irq_save(flags); // FIXME: is this safe?
 		tty->flip.char_buf_ptr = tty->flip.char_buf + TTY_FLIPBUF_SIZE;
 		tty->flip.flag_buf_ptr = tty->flip.flag_buf + TTY_FLIPBUF_SIZE;
 	}
 	count = tty->flip.count;
 	tty->flip.count = 0;
-	local_irq_restore(flags); // FIXME: is this safe?
-	
+	spin_unlock_irqrestore(&tty->read_lock, flags);
+
 	tty->ldisc.receive_buf(tty, cp, fp, count);
 }
 


Nicolas

