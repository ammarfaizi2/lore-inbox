Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317434AbSGZKNs>; Fri, 26 Jul 2002 06:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317498AbSGZKNs>; Fri, 26 Jul 2002 06:13:48 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:45324 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317434AbSGZKNr>; Fri, 26 Jul 2002 06:13:47 -0400
Date: Fri, 26 Jul 2002 11:17:00 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [SERIAL] Various updates
Message-ID: <20020726111700.B19802@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following is a copy of what's pending in my BK and CVS repositories,
with the exception of the removal of serial_{21285,amba}.c in drivers/char
(which would push the patch over 40K.)

My preferred route to get this to Linus is via a BK pull; this is for
everyone else.

 Documentation/serial/driver |    2 
 drivers/serial/core.c       |    5 
 4 files changed, 5 insertions, 2513 deletions

ChangeSets:

<rmk@flint.arm.linux.org.uk> (02/07/26 1.444)
	[SERIAL] Stop open() looping while opening a non-present port
	Trying to open a non-present port (for configuration) causes us to
	to endlessly loop (by returning -ERESTARTSYS).  We should be returning
	success.  This cset fixes this.

<rmk@flint.arm.linux.org.uk> (02/07/26 1.443)
	[SERIAL] Fix buglet causing (eg) ttyS-14
	Allocate positive instead of negative line numbers when 8250.c
	registers a new port with the core.  This bug could cause
	registrations to erroneously fail, or oopsen when the pcmcia
	serial device is ejected.

<rmk@flint.arm.linux.org.uk> (02/07/25 1.442)
	[SERIAL] Fix documentation bug for expected stop_tx interrupt state.

diff -Nru a/Documentation/serial/driver b/Documentation/serial/driver
--- a/Documentation/serial/driver	Fri Jul 26 10:52:30 2002
+++ b/Documentation/serial/driver	Fri Jul 26 10:52:30 2002
@@ -120,7 +120,7 @@
 	          TTY stop to the driver (equiv to rs_stop).
 
 	Locking: port->lock taken.
-	Interrupts: caller dependent.
+	Interrupts: locally disabled.
 	This call must not sleep
 
   start_tx(port,tty_start)
diff -Nru a/drivers/serial/core.c b/drivers/serial/core.c
--- a/drivers/serial/core.c	Fri Jul 26 10:52:30 2002
+++ b/drivers/serial/core.c	Fri Jul 26 10:52:30 2002
@@ -1450,6 +1450,9 @@
 	if (signal_pending(current))
 		return -ERESTARTSYS;
 
+	if (info->tty->flags & (1 << TTY_IO_ERROR))
+		return 0;
+
 	if (tty_hung_up_p(filp) || !(info->flags & UIF_INITIALIZED))
 		return (port->flags & UPF_HUP_NOTIFY) ?
 			-EAGAIN : -ERESTARTSYS;
@@ -2425,7 +2428,7 @@
 		state->port->regshift = port->regshift;
 		state->port->iotype   = port->iotype;
 		state->port->flags    = port->flags;
-		state->port->line     = drv->state - state;
+		state->port->line     = state - drv->state;
 
 		__uart_register_port(drv, state, state->port);
 

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

