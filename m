Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263608AbTDDBWr (for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 20:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263609AbTDDBWr (for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 20:22:47 -0500
Received: from palrel10.hp.com ([156.153.255.245]:61830 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S263608AbTDDBWi (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 20:22:38 -0500
Date: Thu, 3 Apr 2003 17:34:05 -0800
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: uart_ioctl OOPS with irtty-sir
Message-ID: <20030404013405.GA19446@bougret.hpl.hp.com>
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

	Hi Russel,

	Sorry to bring more bad news...

	In 2.5.66, somebody (maybe you) added a check to
tty_hung_up_p(filp) in uart_ioctl().
	The code now looks like this (drivers/serial/core.c) :
------------------------------------
static int
uart_ioctl(struct tty_struct *tty, struct file *filp, unsigned int cmd,
	   unsigned long arg)
{
[...]
	if (tty_hung_up_p(filp)) {
		ret = -EIO;
		goto out_up;
	}
[...]
	switch (cmd) {
	case TIOCMSET:
		ret = uart_set_modem_info(state->port, cmd,
					  (unsigned int *)arg);
		break;
------------------------------------

	Unfortunately, the irtty-sir driver, which is a TTY line
discipline and a network driver, need to be able to change the RTS and
DTR line from a kernel thread.
	The code looks like (drivers/net/irda/irtty-sir.c) :
----------------------------
static int irtty_set_dtr_rts(struct sir_dev *dev, int dtr, int rts)
{
[...]
	if (priv->tty->driver.ioctl(priv->tty, NULL, TIOCMSET, (unsigned long) &arg)) { 
		IRDA_DEBUG(2, "%s(), error doing ioctl!\n", __FUNCTION__);
	}
----------------------------

	You can guess the result : instant OPPS.


	I don't really see how I would be able to get hold of a "struct
file" in kernel space, so please advise.

	Have fun, and thanks in advance...

	Jean
