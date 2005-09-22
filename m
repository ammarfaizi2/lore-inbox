Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030224AbVIVHwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbVIVHwj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 03:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbVIVHuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 03:50:10 -0400
Received: from mail.kroah.org ([69.55.234.183]:18611 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932173AbVIVHtq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 03:49:46 -0400
Date: Thu, 22 Sep 2005 00:48:49 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       pfavr@how.dk
Subject: [patch 11/18] USB: ftdi_sio: allow baud rate to be changed without raising RTS and DTR
Message-ID: <20050922074849.GL15053@kroah.com>
References: <20050922003901.814147000@echidna.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-ftdi_sio-baud-rate-change.patch"
In-Reply-To: <20050922074643.GA15053@kroah.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Favrholdt <pfavr@how.dk>

I'm using a 2 port USB RS232 dongle to connect to a serial-IR cradle for
a bar code reader). Detecting the baudrate of the serial-IR involves
keeping DTR low while changing baudrate.

This works using normal 16550A serial ports as well as the FTDI driver
version 1.4.0 (Linux 2.6.8) but stopped working with the change to
"ensure RTS and DTR are raised when changing baudrate" introduced in
version 1.4.1 (Linux 2.6.9).

The attached patch fixes this, so RTS and DTR is only raised when
changing baudrate iff the previous baudrate was B0.

Signed-off-by: Peter Favrholdt <pfavr@how.dk>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/serial/ftdi_sio.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- scsi-2.6.orig/drivers/usb/serial/ftdi_sio.c	2005-09-20 06:00:04.000000000 -0700
+++ scsi-2.6/drivers/usb/serial/ftdi_sio.c	2005-09-21 17:29:41.000000000 -0700
@@ -1846,10 +1846,12 @@
 	} else {
 		/* set the baudrate determined before */
 		if (change_speed(port)) {
-			err("%s urb failed to set baurdrate", __FUNCTION__);
+			err("%s urb failed to set baudrate", __FUNCTION__);
+		}
+		/* Ensure RTS and DTR are raised when baudrate changed from 0 */
+		if ((old_termios->c_cflag & CBAUD) == B0) {
+			set_mctrl(port, TIOCM_DTR | TIOCM_RTS);
 		}
-		/* Ensure  RTS and DTR are raised */
-		set_mctrl(port, TIOCM_DTR | TIOCM_RTS);
 	}
 
 	/* Set flow control */

--
