Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbULEUzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbULEUzg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 15:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbULEUzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 15:55:36 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:5318 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261384AbULEUy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 15:54:27 -0500
Subject: 2.4.27 Potential race in n_tty.c:write_chan()
From: Ryan Reading <rreading@msm.umr.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1102280061.10493.19.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 05 Dec 2004 15:54:21 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been staring at this for a while and it seems there is a
potential race condition in the write_chan() function in n_tty.c.  The
problem I have noticed is in tty USB drivers.  Here is a rough sketch
of the current write_chan().

static ssize_t write_chan()
{
...
add_wait_queue(&tty->write_wait, &wait);
while(1) {     
  set_current_state(TASK_INTERRUPTIBLE);

  ...  // <- Window for race

  c = tty->driver.write(tty, 1, b, nr);
  nr -= c
  if (!nr)
    break;	<-- schedule() isn't called if all data was written!

  schedule();
}
set_current_state(TASK_RUNNING);
remove_wait_queue(&tty->write_wait, &wait);
return;
}

So when write_chan() calls usb_driver::write(), typically the driver
calls usb_submit_urb().  The write() call then returns immediately
indicating that all of the data has been written (assuming it is less
than the USB packets size).  The driver however is still waiting for an
interrupt to complete the write and wakeup the current kernel path.  If
write_chan() is called again and the interrupt is received within the
window I outlined above, the current_state will be reset to TASK_RUNNING
before the next usb_driver::write() is ever called!  If this happens, it
seems that we would lose synchronisity and potentially lock the kernel
path.

It is also my understanding that the usb interrupt is generated from the
ACK/NAK of the original usb_submit_urb().  If the driver is returning
immediately without waiting on the interrupt and schedule() is never
being called, there is no guarantee that the write() happened
successfully (although we return that it has).  It seems if a driver
wanted to guarantee this, it would have to artificially wait of the
interrupt before returning.

Anyone have any thoughts on this?  Thanks.

-- Ryan

