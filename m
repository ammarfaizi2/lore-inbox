Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265413AbTLSAy2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 19:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265415AbTLSAy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 19:54:27 -0500
Received: from bart.one-2-one.net ([217.115.142.76]:13577 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S265413AbTLSAyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 19:54:25 -0500
Date: Fri, 19 Dec 2003 01:31:01 +0100 (CET)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: jt@hpl.hp.com
cc: Andrew Morton <akpm@osdl.org>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0
In-Reply-To: <20031218231650.GA828@bougret.hpl.hp.com>
Message-ID: <Pine.LNX.4.44.0312190113030.30804-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Dec 2003, Jean Tourrilhes wrote:

> > drivers/net/irda/
> > ~~~~~~~~~~~~~~~~~
> > 
> > o dongle drivers need to be converted to sir-dev
> 
> 	In (slow) progress ; tekram-sir patches on my web page.

I have converted dongle drivers on disk here. So far I was holding back 
basically due to:
* 2.6.0 freeze
* neither hardware nor testers to do even basic validation
* wait for tx-lock and rawmode fixes to get applied first so we would 
  hopefully get some more feedback and trust in the infrastructure.

If you would like to accept it now I'd sent patches this weekend.

> > o new drivers (irtty-sir/smsc-ircc2/donauboe) need more testing
> 
> 	In (slow) progress ; Patch for irtty-sir on my web page.

Yes, tekram-sir is reportedly working now with those patches.

> 	o IrCOMM disconnect race condition Oops ; todo

After some user provided helpful information off-list I found out it gets 
triggered when the app doesn't close the ircomm-fd before exiting.
Just do "cat /dev/ircomm0" and kill -9 the cat to see.

Below my current experimental patch. It works for me and I've got an user
confirmation meanwhile. It's definedly an improvement and I do think it is 
as safe as we can get without reworking the whole ircomm-locking...

Martin

----------------------

diff -urp linux-2.6.0-test9-bk22/net/irda/ircomm/ircomm_tty.c v2.6.0-test9-bk22/net/irda/ircomm/ircomm_tty.c
--- linux-2.6.0-test9-bk22/net/irda/ircomm/ircomm_tty.c	Wed Nov 19 12:33:50 2003
+++ v2.6.0-test9-bk22/net/irda/ircomm/ircomm_tty.c	Wed Nov 19 15:47:23 2003
@@ -982,6 +982,8 @@ static void ircomm_tty_shutdown(struct i
 	if (!(self->flags & ASYNC_INITIALIZED))
 		return;
 
+	ircomm_tty_detach_cable(self);		/* first it does is deleting wd-timer! */
+
 	spin_lock_irqsave(&self->spinlock, flags);
 
 	del_timer(&self->watchdog_timer);
@@ -998,8 +1000,6 @@ static void ircomm_tty_shutdown(struct i
 		self->tx_skb = NULL;
 	}
 
-	ircomm_tty_detach_cable(self);
-
 	if (self->ircomm) {
 		ircomm_close(self->ircomm);
 		self->ircomm = NULL;

