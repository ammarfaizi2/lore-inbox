Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289007AbSBDPC1>; Mon, 4 Feb 2002 10:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289009AbSBDPCR>; Mon, 4 Feb 2002 10:02:17 -0500
Received: from osiris.silug.org ([64.240.156.225]:13255 "EHLO osiris.silug.org")
	by vger.kernel.org with ESMTP id <S289007AbSBDPCC>;
	Mon, 4 Feb 2002 10:02:02 -0500
Date: Mon, 4 Feb 2002 09:02:00 -0600
From: Steven Pritchard <steve@silug.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Specialix RIO Oops fix
Message-ID: <20020204090200.A30872@osiris.silug.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below fixes an Oops in the Specialix RIO driver.  I sent
this to the maintainer a couple of months ago and never got a
response.

Note that this patch doesn't actually make the driver *work* for my
client...  It still causes a hard lockup that I was unable to debug in
the short time I had to work on it.  Specialix apparently told my
client that they would have to switch to the original Red Hat 7.1
kernel (2.4.2-something) if they wanted it to actually work.

In any case, this patch seems to be a no-brainer.  It merely adds a
check that I see in every other serial driver's set_real_termios()
function.

Steve
-- 
steve@silug.org           | Southern Illinois Linux Users Group
(618)398-7360             | See web site for meeting details.
Steven Pritchard          | http://www.silug.org/

--- linux-2.4.17.orig/drivers/char/rio/rio_linux.c	Thu Oct 25 15:53:47 2001
+++ linux-2.4.17/drivers/char/rio/rio_linux.c	Mon Feb  4 08:53:34 2002
@@ -422,6 +422,11 @@
   struct tty_struct *tty;
   func_enter();
 
+  if (!((struct Port *)ptr)->gs.tty || !((struct Port *)ptr)->gs.tty->termios) {
+    func_exit();
+    return 0;
+  }
+
   tty = ((struct Port *)ptr)->gs.tty;
 
   modem = (MAJOR(tty->device) == RIO_NORMAL_MAJOR0) || (MAJOR(tty->device) == RIO_NORMAL_MAJOR1);
