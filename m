Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315862AbSFPEBW>; Sun, 16 Jun 2002 00:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315870AbSFPEBV>; Sun, 16 Jun 2002 00:01:21 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:55973 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S315862AbSFPEBT>; Sun, 16 Jun 2002 00:01:19 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Robert White <rwhite@pobox.com>
Reply-To: rwhite@pobox.com
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: n_tty.c driver patch (semantic and performance correction) (all recent versions)
Date: Sat, 15 Jun 2002 21:01:24 -0700
X-Mailer: KMail [version 1.4.5]
X-Evil-Bastard: True (but nice about it)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200206152101.24615.rwhite@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Pleased find attached my first-ever contribution to kernel code... 8-)  It is 
both a "fix" and an "enhancement" (which I know is bad) but the same lines of 
code are involved in both so what are you going to do?)

Kernel Versions: 2.2, 2.4, 2.5 (all of them since 1996 really 8-)

The n_tty line discipline module contains a "semantic error" that limits its 
speed and usefullness in many uses.  The attached patch directly addresses 
serial performance in a completely backwards-compatable way.

In particular, the current handling of VMIN hugely limits, complicates, and/or 
slows down optimal serial use.  The most obvius example is that if you call 
read(2) with a buffer size less than the current value of VMIN, the line 
discipline will insist tha the read call wait for characters that can not be 
returned to that call.  The POSIX standard is silent on the subject of 
whether this is right or wrong.  Common sense says it is wrong.

What does it mean?  If you are running a protocol with variable packet sizes 
you either have to repeatedly reset VMIN or just set it to one (1) and 
potentially bounce in and out of the kernel.  In fact, if you look at 
virtually any code in the world you will find that VMIN is almost always 1 or 
0.  In any cases where it has been set larger than 1 (I havn't found any) the 
buffering of non-fixed-size frames would have to rely on timeouts (which 
would enherantly cost time) or still end up doing in-user-space packet 
recomposition.

Esentially, as it exists today, the in-kernel buffering possibilities must be 
almost unilaterally ignored at the cost of extra context switches and such.

What this patch does to fix this "semantic error" is fairly simple, if VMIN is 
larger than the current read buffer, the blocking code acts like VMIN were 
set to the buffer size.  (The actual value of VMIN is not changed, the lesser 
of VMIN and current read size is always in effect.)

This fix handles the near-end small-read requirements.  But VMIN is an 
unsigned character so the entire standard can not ever be set to explicitly 
satisfy a read of more than 255 characters.  A given read *CAN* return more 
than 255 characters if they have already been buffered, but all the 
multiple-wakeup and user-space buffer reassembly caveats still apply.  
Consider a simple protocol (Xmodem?) that sends 1024 byte packets at 
modem-esque speeds.  Such a protocol would tend to require more than four 
reads per packet.  Yech...

The "extension" is that if VMIN is set to 255 the effective VMIN for any given 
read is the exact size of the read buffer.  That is the minimum receive size 
becomes "set but unconstrained".

The extension is "different than" setting VMIN to 0.  When VMIN == 0, VTIME is 
an absolute timeout for the entire read (the existing behavior) but when VMIN 
!= 0 VTIME is the "intercharacter timer", e.g. a timeout event that is reset 
to time=0 whenever any characters are received.  At high baud rates this is 
fine but at low baud you get back into context-switches and packet 
reassembly.  With the VMIN==255 version you get the full scaled timeout but 
the reduced context switch and packet assembly behavior.

The patch is more comment than code 8-) and I wasn't sure how to split the 
patch up into the two components (fix separate from extension) since they 
involve the same lines of code.  [e.g. the guidelines didn't say whether this 
would be separated by making the "fix-and-extension" version a diff of the 
"fix" version or the original file, so I opted for the less-messy 
just-one-patch. 8-)]

The fix is more important than the enhancement.  The total text of the fix is 
the first non-comment chunk without the "(minimum == 255)" and without "the 
other code chunk" entirely.

The second code chunk in the patch prevents a deadlock in the flow-control 
mechanisim of the UART driver.  If the read buffer size is "too big" the 
internal driver buffer could fill and cause the serial flow-control logic to 
trip, which would, of course, stop characters from arriving.  This second 
chunk sets a rational ceiling on the minimum_to_wake, which makes the 
partial-copy mechanisim transfer the driver buffer contents into the read 
buffer.  This was previously handled by the assumption that VMIN was 
(effectively) never larger than 255.  Now that it can be effectively larger 
this block sets the ceiling explicitly.

(Wow, that was a lot of text for this little thing... 8-)

Rob White
Newcastle, WA
rwhite@pobox.com

(Sorry, I don't speak manual page so I didn't patch it... 8-)

BEGIN PATCH:

--- drivers/char/n_tty.c.orig	Tue Jan 29 18:26:54 2002
+++ drivers/char/n_tty.c	Thu Jan 31 02:28:51 2002
@@ -18,11 +18,35 @@
  * This file may be redistributed under the terms of the GNU General Public
  * License.
  *
+ * 2002/01/29	Fixed & Extended VMIN handling.
+ *		Patch By:  Robert White <rwhite@pobox.com>
+ *		Problem:  Where VTIME == 0 and VMIN > nr durring read,
+ *		   read would block for characters it couldn't possibly return.
+ *		   Reading variable sized blocks required multiple syscalls
+ *		   (termio set followed by read) or reliance on timeout.
+ *		   or multiple reads of fragments. For large reads n_tty
+ *		   was not capible of returning more than 255 bytes (bad
+ *		   for performance of any serial protocols. c.f. Z-MODEM etc)
+ *		Fix: if VMIN > nr, use nr to set minimum instead. (adjust down)
+ *		Extension: if VMIN == 255, always set minimum to nr (up OR down)
+ *		(Fix and Extension apply to each read call, VMIN itself is not adjusted)
+ *		Consider: (w/8 or 1500 chars from device to be delivered respectively)
+ *		VMIN=30, VTIME=0, read(fd,buf,8);
+ *		  Old: read never returns, New: returns immed on 8th char
+ *		VMIN=30, VTIME=200, read(fd,buf,8);
+ *		  Old: return in 20 seconds, New: returns immed on 8th char
+ *		VMIN=255, VTIME=0, read(fd,buf,1500); 
+ *		  Old: 5 reads of ~255 then deadlock, New: 1 read to complete
+ *		VMIN=255, VTIME>0, read(fd,buf,1500);
+ *		  Old: 5 reads then timout for remainder, New: 1 read
+ *			or more depending timeout occurences)
+ *
  * Reduced memory usage for older ARM systems  - Russell King
  *
  * 2000/01/20   Fixed SMP locking on put_tty_queue using bits of 
  *		the patch by Andrew J. Kroll <ag784@freenet.buffalo.edu>
  *		who actually finally proved there really was a race.
+ *		
  */
 
 #include <linux/types.h>
@@ -974,6 +998,11 @@
 	if (!tty->icanon) {
 		time = (HZ / 10) * TIME_CHAR(tty);
 		minimum = MIN_CHAR(tty);
+		/* Added rwhite@pobox.com Jan 29, 2002 */
+		if ((minimum == 255) || (minimum > nr))	{
+			minimum = nr;
+		}
+		/* End Addition */
 		if (minimum) {
 			if (time)
 				tty->minimum_to_wake = 1;
@@ -1021,6 +1050,16 @@
 		if (((minimum - (b - buf)) < tty->minimum_to_wake) &&
 		    ((minimum - (b - buf)) >= 1))
 			tty->minimum_to_wake = (minimum - (b - buf));
+
+		/* Added rwhite@pobox.com Jan 29, 2002 */
+		// minimum and therefore minimum_to_wake could be much larger
+		// than the actual buffer here, so...
+		if (tty->minimum_to_wake >= TTY_FLIPBUF_SIZE)	{
+			// Flow Control would deadlock at  (N_TTY_BUF_SIZE - 
TTY_THRESHOLD_THROTTLE)
+			// using TTY_FLIPBUF_SIZE-1 is safe and likely linear/streaming.
+			tty->minimum_to_wake = TTY_FLIPBUF_SIZE - 1;
+		}
+		/* End Addition */
 		
 		if (!input_available_p(tty, 0)) {
 			if (test_bit(TTY_OTHER_CLOSED, &tty->flags)) {


