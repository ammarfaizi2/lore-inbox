Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbULFEmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbULFEmi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 23:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbULFEmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 23:42:38 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:43946 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261468AbULFEmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 23:42:23 -0500
Subject: Re: 2.4.27 Potential race in n_tty.c:write_chan()
From: Ryan Reading <rreading@msm.umr.edu>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1102286420.3386.20.camel@at2.pipehead.org>
References: <1102280061.10493.19.camel@localhost>
	 <1102286420.3386.20.camel@at2.pipehead.org>
Content-Type: text/plain
Message-Id: <1102308142.1882.31.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 05 Dec 2004 23:42:22 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-12-05 at 17:40, Paul Fulghum wrote:
> On Sun, 2004-12-05 at 15:54 -0500, Ryan Reading wrote:
> > So when write_chan() calls usb_driver::write(), typically the driver
> > calls usb_submit_urb().  The write() call then returns immediately
> > indicating that all of the data has been written (assuming it is
less
> > than the USB packets size).  The driver however is still waiting for
an
> > interrupt to complete the write and wakeup the current kernel path. 
If
> > write_chan() is called again and the interrupt is received within
the
> > window I outlined above, the current_state will be reset to
TASK_RUNNING
> > before the next usb_driver::write() is ever called!  If this
happens, it
> > seems that we would lose synchronisity and potentially lock the
kernel
> > path.
> 
> The line discipline write routine is serialized
> on a per tty basis in do_tty_write() of tty_io.c
> using tty->atomic_write semaphore, so you will not
> reenter write_chan() for a particular tty instance.

Per tty instance this is true, but this is not the case for multiple
userland::write() calls.

> Even if this were not the case, if the task state
> changes to TASK_RUNNING inside the window
> you describe, the only thing that happens is the loop
> executes again. The driver must decide if it can accept
> more data or not and return the appropriate value.
> 
> There is no potential for deadlock.

Yes this does seem to be true.  However, it can throw a driver into a
wierd state if this happens.  Ideally the driver should be able to
recover.  I'm not sure if we can guarantee that user_land protocol could
recover though, especially if write()s aren't guaranteed to complete
successfully.

> > It is also my understanding that the usb interrupt is generated from
the
> > ACK/NAK of the original usb_submit_urb().  If the driver is
returning
> > immediately without waiting on the interrupt and schedule() is never
> > being called, there is no guarantee that the write() happened
> > successfully (although we return that it has).  It seems if a driver
> > wanted to guarantee this, it would have to artificially wait of the
> > interrupt before returning.
> 
> True, but this is a matter of layering.
> 
> The line discipline knows nothing about the driver's concept
> of write completion apart from the driver's write method
> return value. If it is critical for the write not to complete
> until the URB is sent, it is up to the driver to block
> and return the appropriate return value.

I guess my biggest concern here is the definition of the
tty_driver::write() interface.  Should a driver be able to rely on the
schedule() call to complete its write?  It seems that since the driver
is responsible for waking up the tty->write_wait, it should be able to
rely on the schedule() call.  However in this implementation it cannot
which I'm sure is for performance reasons.  Because of this, I don't
think the USB layer should be interacting with the tty layer in this
fashion.

So for this implementation of write_chan(), the tty_driver::write()
interface should note that the driver needs only to wakeup the
tty->write_wait iff it does not write all of the requested data in this
call.  Is this a fair assessment and can this be depended on for future
implementations?

Anyway, part of this discussion needs to happen on the USB mailing list
since the usb-skeleton driver outlines this method of interacting with
the tty layer.  Given the current implementation I don't think the
usb-skeleton is correct.

Thanks for your help.

-- Ryan


> --
> Paul Fulghum
> paulkf@microgate.com
> 

