Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267648AbUIXBGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267648AbUIXBGt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 21:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267749AbUIXBGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 21:06:46 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:62646 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S267648AbUIXBFH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 21:05:07 -0400
Subject: ldisc writes during tty release_dev() causing problems.
From: Ryan Arnold <rsa@us.ibm.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       alan@lxorguk.ukuu.org.uk
In-Reply-To: <20040915204107.GA26776@thunk.org>
References: <1095273835.3294.278.camel@localhost>
	 <20040915204107.GA26776@thunk.org>
Content-Type: text/plain
Organization: IBM Linux Technology Center
Message-Id: <1095988521.3372.240.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 23 Sep 2004 20:15:40 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-15 at 15:41, Theodore Ts'o wrote:

> The current (I can't speak to what Alan Cox is going to change) rules
> with tty drivers is that tty drivers are supposed to close the line
> discpline in their close routines.  That's the much safer and cleaner
> way of fixing this problem, and it is in line with what most of the
> other tty drivers are doing.
> 					- Ted

Ted,

I greped through the drivers directory and it appears that the only tty
drivers that actually invoke ldisc.close() are those drivers that don't
use the N_TTY line discipline (serial drivers).

Many of the drivers actually call ldisc.flush_buffers() which
effectively does the same as a ldisc.close(), cleaning up the
tty->read_buf and tasks waiting on tty->read_wait.

The story is different with writes.  The tty layer dipatches a write via
the line discpline's write_chan() function.  The line discipline is then
responsible for delivering this data to the driver's write() function.

If driver->write() returns 0 [device is blocking] (which it can do often
in the case of hvc_console) the ldisc write_chan() function will
schedule() and get put on the tty->write_wait queue with the expectation
that it will be awoken by the driver when the device is available for
further writes.

If tty release_dev() is called when write_chan() is blocked awaiting I/O
with the driver and tty->count == 1 the final call to driver->close()
will clean up the driver without the ldisc knowing that the driver has
closed the device.

Following this release_dev() actually awakens the tty->write_wait, which
basically tells the ldisc to continue trying to send data to the driver
for the device it has just told the driver to close!

Ideally I would want hvc_close() to be able to tell the ldisc to wake up
the thread blocking on tty->write_wait and discard any unsent data. 
Unless I'm mistaken there is currrently no way to do this.

I suppose I could make hvc_write() return -EIO if hvc_struct->count ==
0.  I can't think of any races with this but it doesn't seem correct.

Additionally, there doesn't seem to be anything to prevent hangup being
called on a tty during the final close operation (this actually happened
in hvc_console).

Do you have any wisdom or advice?  Am I missing something obvious?

Ryan S. Arnold
IBM Linux Technology Center




