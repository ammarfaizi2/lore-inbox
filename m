Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261412AbULEWk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbULEWk1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 17:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbULEWk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 17:40:27 -0500
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:14642 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S261412AbULEWkT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 17:40:19 -0500
Subject: Re: 2.4.27 Potential race in n_tty.c:write_chan()
From: Paul Fulghum <paulkf@microgate.com>
To: Ryan Reading <rreading@msm.umr.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1102280061.10493.19.camel@localhost>
References: <1102280061.10493.19.camel@localhost>
Content-Type: text/plain
Date: Sun, 05 Dec 2004 16:40:20 -0600
Message-Id: <1102286420.3386.20.camel@at2.pipehead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-12-05 at 15:54 -0500, Ryan Reading wrote:
> So when write_chan() calls usb_driver::write(), typically the driver
> calls usb_submit_urb().  The write() call then returns immediately
> indicating that all of the data has been written (assuming it is less
> than the USB packets size).  The driver however is still waiting for an
> interrupt to complete the write and wakeup the current kernel path.  If
> write_chan() is called again and the interrupt is received within the
> window I outlined above, the current_state will be reset to TASK_RUNNING
> before the next usb_driver::write() is ever called!  If this happens, it
> seems that we would lose synchronisity and potentially lock the kernel
> path.

The line discipline write routine is serialized
on a per tty basis in do_tty_write() of tty_io.c
using tty->atomic_write semaphore, so you will not
reenter write_chan() for a particular tty instance.

Even if this were not the case, if the task state
changes to TASK_RUNNING inside the window
you describe, the only thing that happens is the loop
executes again. The driver must decide if it can accept
more data or not and return the appropriate value.

There is no potential for deadlock.

> It is also my understanding that the usb interrupt is generated from the
> ACK/NAK of the original usb_submit_urb().  If the driver is returning
> immediately without waiting on the interrupt and schedule() is never
> being called, there is no guarantee that the write() happened
> successfully (although we return that it has).  It seems if a driver
> wanted to guarantee this, it would have to artificially wait of the
> interrupt before returning.

True, but this is a matter of layering.

The line discipline knows nothing about the driver's concept
of write completion apart from the driver's write method
return value. If it is critical for the write not to complete
until the URB is sent, it is up to the driver to block
and return the appropriate return value.
 
--
Paul Fulghum
paulkf@microgate.com

