Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263315AbTFYAwb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 20:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbTFYAwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 20:52:31 -0400
Received: from dp.samba.org ([66.70.73.150]:54951 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263315AbTFYAwX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 20:52:23 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16120.62725.356692.174022@cargo.ozlabs.ibm.com>
Date: Wed, 25 Jun 2003 11:04:05 +1000
From: Paul Mackerras <paulus@samba.org>
To: linux-kernel@vger.kernel.org
Subject: Use of ERESTARTSYS in serial drivers
X-Mailer: VM 7.16 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As part of a process of rewriting some of the ppc32 signal handling
code, I decided to go through and look at all the uses of ERESTARTSYS,
ERESTARTNOINTR and ERESTARTNOHAND in the kernel.

My basic assertion is that the three ERESTART* error codes should only
be returned by a system call when there is a signal pending.  Those
three errors are not intended to be ever seen by usermode processes.
They are handled in the signal delivery code, either by being
converted to EINTR or by restarting the system call.

In most places where ERESTART* are used, it is pretty obvious that it
is only returned if a signal is pending.  However, many of the serial
drivers seem to be returning ERESTARTSYS in a situation where it is
not obvious that a signal is pending.  Take for example this code from
drivers/serial/core.c, near the end of uart_block_til_ready():

	if (signal_pending(current))
		return -ERESTARTSYS;

	if (!info->tty || tty_hung_up_p(filp))
		return (port->flags & UPF_HUP_NOTIFY) ?
			-EAGAIN : -ERESTARTSYS;

	return 0;

Here it seems pretty obvious that we could return -ERESTARTSYS without
having a signal pending.  Other older serial drivers do something
similar, for example drivers/char/amiserial.c, in block_til_ready():

	/*
	 * If the device is in the middle of being closed, then block
	 * until it's done, and then try again.
	 */
	if (tty_hung_up_p(filp) ||
	    (info->flags & ASYNC_CLOSING)) {
		if (info->flags & ASYNC_CLOSING)
			interruptible_sleep_on(&info->close_wait);
#ifdef SERIAL_DO_RESTART
		return ((info->flags & ASYNC_HUP_NOTIFY) ?
			-EAGAIN : -ERESTARTSYS);
#else
		return -EAGAIN;
#endif
	}

Note that SERIAL_DO_RESTART is #define'd near the beginning of the
file.  This is the first thing that block_til_ready() does, so there
is not necessarily a signal pending at this point.

Does anyone remember what the motivation was for returning
-ERESTARTSYS from the open function for a serial port?

Paul.
