Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266161AbUFUIXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266161AbUFUIXx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 04:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266164AbUFUIXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 04:23:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:15779 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266161AbUFUIW5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 04:22:57 -0400
X-Authenticated: #12437197
Date: Mon, 21 Jun 2004 11:24:30 +0300
From: Dan Aloni <da-x@gmx.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] missing NULL check in drivers/char/n_tty.c
Message-ID: <20040621082430.GA11566@callisto.yi.org>
Reply-To: Dan Aloni <da-x@colinux.org>
References: <20040621063845.GA6379@callisto.yi.org> <20040620235824.5407bc4c.akpm@osdl.org> <20040621073644.GA10781@callisto.yi.org> <20040621003944.48f4b4be.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040621003944.48f4b4be.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2004 at 12:39:44AM -0700, Andrew Morton wrote:
> Dan Aloni <da-x@gmx.net> wrote:
> >
> > On Sun, Jun 20, 2004 at 11:58:24PM -0700, Andrew Morton wrote:
> > > Dan Aloni <da-x@gmx.net> wrote:
> > > >
> > > > The rest of the kernel treats tty->driver->chars_in_buffer as a possible
> > > >  NULL. This patch changes normal_poll() to be consistent with the rest of
> > > >  the code.
> > > 
> > > It would be better to change the rest of the kernel - remove the tests.
> > > 
> > > If any driver fails to implement ->chars_in_buffer() then we get a nice
> > > oops which tells us that driver needs a stub handler.
> > 
> > Are you sure that it won't affect the logic in tty_wait_until_sent() 
> > drastically? It acts quite differently when ->chars_in_buffer == NULL.
> 
> I did a quick grep and it appears that all drivers have set ->chars_in_buffer().
> 
> I suspect there are no drivers which fail to set chars_in_buffer. 
> Otherwise normal_poll() would have been oopsing in 2.4, 2.5 and 2.6?

Right. Perhaps this should be applied:

Signed-off-by: Dan Aloni <da-x@colinux.org>

--- linux-2.6.7/drivers/char/n_hdlc.c
+++ linux-2.6.7/drivers/char/n_hdlc.c
@@ -760,8 +760,7 @@
 
 	case TIOCOUTQ:
 		/* get the pending tx byte count in the driver */
-		count = tty->driver->chars_in_buffer ?
-				tty->driver->chars_in_buffer(tty) : 0;
+		count = tty->driver->chars_in_buffer(tty);
 		/* add size of next output frame in queue */
 		spin_lock_irqsave(&n_hdlc->tx_buf_list.spinlock,flags);
 		if (n_hdlc->tx_buf_list.head)
--- linux-2.6.7/drivers/char/tty_ioctl.c
+++ linux-2.6.7/drivers/char/tty_ioctl.c
@@ -45,8 +45,6 @@
 	
 	printk(KERN_DEBUG "%s wait until sent...\n", tty_name(tty, buf));
 #endif
-	if (!tty->driver->chars_in_buffer)
-		return;
 	add_wait_queue(&tty->write_wait, &wait);
 	if (!timeout)
 		timeout = MAX_SCHEDULE_TIMEOUT;
@@ -461,8 +459,7 @@
 			}
 			return 0;
 		case TIOCOUTQ:
-			return put_user(tty->driver->chars_in_buffer ?
-					tty->driver->chars_in_buffer(tty) : 0,
+			return put_user(tty->driver->chars_in_buffer(tty),
 					(int __user *) arg);
 		case TIOCINQ:
 			retval = tty->read_cnt;

-- 
Dan Aloni
da-x@colinux.org
