Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268812AbTCCVKh>; Mon, 3 Mar 2003 16:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268813AbTCCVKh>; Mon, 3 Mar 2003 16:10:37 -0500
Received: from modemcable166.48-200-24.mtl.mc.videotron.ca ([24.200.48.166]:60866
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S268812AbTCCVKg>; Mon, 3 Mar 2003 16:10:36 -0500
Date: Mon, 3 Mar 2003 16:20:51 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] small tty irq race fix
In-Reply-To: <1046721965.7320.9.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0303031615020.31566-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Mar 2003, Alan Cox wrote:

> 
> > 		fp = tty->flip.flag_buf + TTY_FLIPBUF_SIZE;
> > -		tty->flip.buf_num = 0;
> >  
> >  		local_irq_save(flags); // FIXME: is this safe?
> > +		tty->flip.buf_num = 0;
> 
> The other CPU can be touching these fields too surely. Its a
> useful note that the spinlocks need putting in the right spot
> but its still broken 8(

What about this one?  It just happens that tty->read_lock is actually used
deeper in the same call instance (in n_tty.c) so this looks to be the best
lock to use.

--- linux-2.5.63/drivers/char/tty_io.c.orig	Mon Feb 24 14:05:34 2003
+++ linux-2.5.63/drivers/char/tty_io.c	Mon Mar  3 16:13:30 2003
@@ -1947,23 +1947,23 @@
 	if (tty->flip.buf_num) {
 		cp = tty->flip.char_buf + TTY_FLIPBUF_SIZE;
 		fp = tty->flip.flag_buf + TTY_FLIPBUF_SIZE;
-		tty->flip.buf_num = 0;
 
-		local_irq_save(flags); // FIXME: is this safe?
+		spin_lock_irqsave(&tty->read_lock, flags);
+		tty->flip.buf_num = 0;
 		tty->flip.char_buf_ptr = tty->flip.char_buf;
 		tty->flip.flag_buf_ptr = tty->flip.flag_buf;
 	} else {
 		cp = tty->flip.char_buf;
 		fp = tty->flip.flag_buf;
-		tty->flip.buf_num = 1;
 
-		local_irq_save(flags); // FIXME: is this safe?
+		spin_lock_irqsave(&tty->read_lock, flags);
+		tty->flip.buf_num = 1;
 		tty->flip.char_buf_ptr = tty->flip.char_buf + TTY_FLIPBUF_SIZE;
 		tty->flip.flag_buf_ptr = tty->flip.flag_buf + TTY_FLIPBUF_SIZE;
 	}
 	count = tty->flip.count;
 	tty->flip.count = 0;
-	local_irq_restore(flags); // FIXME: is this safe?
+	spin_unlock_irqrestore(&tty->read_lock, flags);
 	
 	tty->ldisc.receive_buf(tty, cp, fp, count);
 }

Nicolas

