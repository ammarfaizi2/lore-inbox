Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268745AbUIXNm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268745AbUIXNm4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 09:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268750AbUIXNm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 09:42:56 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:64998 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268745AbUIXNmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 09:42:53 -0400
Subject: Re: ldisc writes during tty release_dev() causing problems.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ryan Arnold <rsa@us.ibm.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1095988521.3372.240.camel@localhost.localdomain>
References: <1095273835.3294.278.camel@localhost>
	 <20040915204107.GA26776@thunk.org>
	 <1095988521.3372.240.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096029621.9790.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 24 Sep 2004 13:40:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-09-24 at 02:15, Ryan Arnold wrote:
> I greped through the drivers directory and it appears that the only tty
> drivers that actually invoke ldisc.close() are those drivers that don't
> use the N_TTY line discipline (serial drivers).

Doing ldisc closes in the driver close path is also rather unsafe. The
ones I've found doing it I've removed.

> Many of the drivers actually call ldisc.flush_buffers() which
> effectively does the same as a ldisc.close(), cleaning up the
> tty->read_buf and tasks waiting on tty->read_wait.

ldisc dependant. It flushes the buffers but may not stop pending 
queued events.

> If tty release_dev() is called when write_chan() is blocked awaiting I/O
> with the driver and tty->count == 1 the final call to driver->close()
> will clean up the driver without the ldisc knowing that the driver has
> closed the device.

That should not be possible. The terminal cannot be both blocking in
write_chan and executing a close path for the final opener.

> Following this release_dev() actually awakens the tty->write_wait, which
> basically tells the ldisc to continue trying to send data to the driver
> for the device it has just told the driver to close!

In the old 2.0/lock_kernel world the wakeup would have woken the device
which would always have tested for hangup before queuing I/O. Nowdays a
lot of those are broken.

> Ideally I would want hvc_close() to be able to tell the ldisc to wake up
> the thread blocking on tty->write_wait and discard any unsent data. 
> Unless I'm mistaken there is currrently no way to do this.

There is no way to do this. The close path isn't too nasty but hangup
makes it all quite evil. 

> I suppose I could make hvc_write() return -EIO if hvc_struct->count ==
> 0.  I can't think of any races with this but it doesn't seem correct.

On SMP the risk is that you've got pending events on another processor.
We ought to be ok for the main part because of the ref count on the file
and the close code making sure it cleans up for the ldisc. We do
have a problem because the ldisc and driver both needed to close first
in the old model. Thats mostly cured since drivers now take ldisc refs
the ldisc can reliably close first.

> Additionally, there doesn't seem to be anything to prevent hangup being
> called on a tty during the final close operation (this actually happened
> in hvc_console).

I had assumed would have to come from the serial side because if the
last owner is executing close() they can't be executing vhangup on the
same but given a rapid close/re-open/vhangup on a new fd it might be
a dangerous assumption. Added to the TODO pile

Alan

