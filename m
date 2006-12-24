Return-Path: <linux-kernel-owner+w=401wt.eu-S1754071AbWLXD2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754071AbWLXD2z (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 22:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754070AbWLXD2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 22:28:55 -0500
Received: from lx1.pxnet.com ([195.227.45.3]:38945 "EHLO lx1.pxnet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754066AbWLXD2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 22:28:54 -0500
Date: Sun, 24 Dec 2006 01:28:41 +0100
From: Tilman Schmidt <tilman@imap.cc>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [Patch][RfC] Update to Documentation/tty.txt on line disciplines
Message-ID: <20061223223138.tilman@imap.cc>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While trying to develop a line discipline I found a couple of
things worth mentioning in Documentation/tty.txt which weren't,
so I decided to add them. It would be nice if someone more
knowledgeable than me in that area would look over them, in
case I got something wrong.

Thanks
Tilman


From: Tilman Schmidt <tilman@imap.cc>

Update to Documentation/tty.txt on line disciplines.

Signed-off-by: Tilman Schmidt <tilman@imap.cc>
---

 tty.txt |  115 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 103 insertions(+), 12 deletions(-)

--- linux-2.6.20-rc1-work/Documentation/tty.txt	2006-11-29 22:57:37.000000000 +0100
+++ local/Documentation/tty.txt	2006-12-23 21:11:17.000000000 +0100
@@ -39,28 +39,37 @@
 
 TTY side interfaces:
 
+open()		-	Called when the line discipline is attached to
+			the terminal. No other call into the line
+			discipline for this tty will occur until it
+			completes successfully. Can sleep.
+
 close()		-	This is called on a terminal when the line
 			discipline is being unplugged. At the point of
 			execution no further users will enter the
 			ldisc code for this tty. Can sleep.
 
-open()		-	Called when the line discipline is attached to
-			the terminal. No other call into the line
-			discipline for this tty will occur until it
-			completes successfully. Can sleep.
+hangup()	-	Called when the tty line is hung up.
+			The line discipline should cease I/O to the tty.
+			No further calls into the ldisc code will occur.
+			Can sleep.
 
 write()		-	A process is writing data through the line
 			discipline.  Multiple write calls are serialized
 			by the tty layer for the ldisc.  May sleep. 
 
-flush_buffer()	-	May be called at any point between open and close.
-
-chars_in_buffer() -	Report the number of bytes in the buffer.
-
-set_termios()	-	Called on termios structure changes. The caller
-			passes the old termios data and the current data
-			is in the tty. Called under the termios semaphore so
-			allowed to sleep. Serialized against itself only.
+flush_buffer()	-	(optional) May be called at any point between
+			open and close, and instructs the line discipline
+			to empty its input buffer.
+
+chars_in_buffer() -	(optional) Report the number of bytes in the input
+			buffer.
+
+set_termios()	-	(optional) Called on termios structure changes.
+			The caller passes the old termios data and the
+			current data is in the tty. Called under the
+			termios semaphore so allowed to sleep. Serialized
+			against itself only.
 
 read()		-	Move data from the line discipline to the user.
 			Multiple read calls may occur in parallel and the
@@ -92,6 +101,88 @@
 			this function. In such a situation defer it.
 
 
+Driver Access
+
+Line discipline methods can call the following methods of the underlying
+hardware driver through the function pointers within the tty->driver
+structure:
+
+write()			Write a block of characters to the tty device.
+			Returns the number of characters accepted.
+
+put_char()		Queues a character for writing to the tty device.
+			If there is no room in the queue, the character is
+			ignored.
+
+flush_chars()		(Optional) If defined, must be called after
+			queueing characters with put_char() in order to
+			start transmission.
+
+write_room()		Returns the numbers of characters the tty driver
+			will accept for queueing to be written.
+
+ioctl()			Invoke device specific ioctl.
+			Expects data pointers to refer to userspace.
+			Returns ENOIOCTLCMD for unrecognized ioctl numbers.
+
+set_termios()		Notify the tty driver that the device's termios
+			settings have changed. New settings are in
+			tty->termios. Previous settings should be passed in
+			the "old" argument.
+
+throttle()		Notify the tty driver that input buffers for the
+			line discipline are close to full, and it should
+			somehow signal that no more characters should be
+			sent to the tty.
+
+unthrottle()		Notify the tty driver that characters can now be
+			sent to the tty without fear of overrunning the
+			input buffers of the line disciplines.
+
+stop()			Ask the tty driver to stop outputting characters
+			to the tty device.  
+
+start()			Ask the tty driver to resume sending characters
+			to the tty device.
+
+hangup()		Ask the tty driver to hang up the tty device.
+
+break_ctl()		(Optional) Ask the tty driver to turn on or off
+			BREAK status on the RS-232 port.  If state is -1,
+			then the BREAK status should be turned on; if
+			state is 0, then BREAK should be turned off.
+			If this routine is not implemented, use ioctls
+			TIOCSBRK / TIOCCBRK instead.
+
+wait_until_sent()	Waits until the device has written out all of the
+			characters in its transmitter FIFO.
+
+send_xchar()		Send a high-priority XON/XOFF character to the device.
+
+
+Flags
+
+Line discipline methods have access to tty->flags field containing the
+following interesting flags:
+
+TTY_THROTTLED		Driver input is throttled. The ldisc should call
+			tty->driver->unthrottle() in order to resume
+			reception when it is ready to process more data.
+
+TTY_DO_WRITE_WAKEUP	If set, causes the driver to call the ldisc's
+			write_wakeup() method in order to resume
+			transmission when it can accept more data
+			to transmit.
+
+TTY_IO_ERROR		If set, causes all subsequent userspace read/write
+			calls on the tty to fail, returning -EIO.
+
+TTY_OTHER_CLOSED	Device is a pty and the other side has closed.
+
+TTY_NO_WRITE_SPLIT	Prevent driver from splitting up writes into
+			smaller chunks.
+
+
 Locking
 
 Callers to the line discipline functions from the tty layer are required to
