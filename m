Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbUCEJTw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 04:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbUCEJTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 04:19:51 -0500
Received: from gate.crashing.org ([63.228.1.57]:63945 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262272AbUCEJTu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 04:19:50 -0500
Subject: serial driver / tty issues
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1078477351.6327.65.camel@gaston>
References: <1078473270.5703.57.camel@gaston>
	 <20040305085838.B22156@flint.arm.linux.org.uk>
	 <1078477351.6327.65.camel@gaston>
Content-Type: text/plain
Message-Id: <1078478335.5702.79.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 05 Mar 2004 20:18:56 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell !

So, I was tracking down some problems with that pmac_zilog() driver
of mine, some were my fault, but some others are still quite 
interesting as they seem to affect other drivers as well.

The basic issue was an interesting HW situation that resulted in the
SCC flooding me with 0 chars + framing errors like mad (faster than
the serial port speed, more like a stuck irq actually) when the port
is connected to an unplug keyspan adapter (so the input line is
probably getting noise or whatever crap).

That triggered extreme situation both in the driver and the tty layer
due to the fast flood of incoming shit.

 - most/all serial drivers, when the flip buffer is full, will
call tty->flip.work.func() directly with the spinlock held. This is
asking for trouble. I have reproduceable cases where that cause the
tty layer to try to echo, thus calling back the serial_core
uart_put_char() which will try to ... take the spinlock. Dead.

 - what about the call to tty_flip_buffer_push() done by all
drivers with the lock held too ? It's fine as long as we don't
have this low_latency thing set. I suppose nothing but the driver
itself will set it but I got a bit lost in the serial_core, can
you just confirm that is ok ?

 - I had a couple of times a crash in n_tty_receive_buf() called
from keventd (from ldisc flip workqueue), apparently racing with
a close of the port. The scenario is that the close happens, i
get out of my driver back to serial core which goes back to
tty_release afaik. At that point (I'm not sure exactly when, maybe
in the flush of the pending work queues that is done there, maybe
just on the other CPU), the pending work queue is triggered since
our input buffer is still full of crap.
It reliably oopses trying to derefence 0 (writing a byte, it's not
a memcpy, without a spinlocked region, I haven't spotted exactly
where in n_tty_receive_buf(), this function is shit to disassemble
as it seems to get a ton of things inlined).

Ben.


