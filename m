Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318196AbSHZSG3>; Mon, 26 Aug 2002 14:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318205AbSHZSG3>; Mon, 26 Aug 2002 14:06:29 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:5091 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S318196AbSHZSG2>;
	Mon, 26 Aug 2002 14:06:28 -0400
Date: Mon, 26 Aug 2002 11:07:49 -0700
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, tytso@mit.edu,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <andrewm@uow.edu.eu>
Cc: irda-users@lists.sourceforge.net
Subject: [BUG/PATCH] : bug in tty_default_put_char()
Message-ID: <20020826180749.GA8630@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

	Bug : tty_default_put_char() doesn't check the return value of
tty->driver.write(). However, the later may fail if buffers are full.

	Solution : It's not obvious what should be done. The attached
patch is certainly wrong, but gives you an idea of what the problem
is.

	Long story :
	User weant to do PPP over IrCOMM. "chat" opens ircomm device
in non blocking mode and write char by char. I suspect that it's using
the above call, but can't verify (because it doesn't happen to me). As
IrCOMM has not finished its initialisation (the open was
non-blocking), it refuses the write and returns 0.
	Character dropped, user unhappy, bugs me about it.
	I'll try to workaround that in IrCOMM.

	Regards,

	Jean

-----------------------------------------------
diff -u -p linux/drivers/char/tty_io.t1.c linux/drivers/char/tty_io.c
--- linux/drivers/char/tty_io.t1.c      Mon Aug 26 10:55:33 2002
+++ linux/drivers/char/tty_io.c Mon Aug 26 10:58:34 2002
@@ -2021,7 +2021,11 @@ static void initialize_tty_struct(struct
  */
 void tty_default_put_char(struct tty_struct *tty, unsigned char ch)
 {
-       tty->driver.write(tty, 0, &ch, 1);
+       int ret = tty->driver.write(tty, 0, &ch, 1);
+       /* This might fail if the lower layer is already full - Jean II */
+       if (ret == 0)
+               printk(KERN_WARNING "Warning: dev (%s) put_char failed\n",
+                      kdevname(tty->device));
 }
 
 /*
