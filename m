Return-Path: <linux-kernel-owner+w=401wt.eu-S1161253AbXAHMEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161253AbXAHMEd (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 07:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161252AbXAHMEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 07:04:33 -0500
Received: from [81.2.110.250] ([81.2.110.250]:36655 "EHLO lxorguk.ukuu.org.uk"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161251AbXAHMEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 07:04:32 -0500
Date: Mon, 8 Jan 2007 12:15:22 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tty: Improve encode_baud_rate logic
Message-ID: <20070108121522.111ebc06@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mostly so people can see the work in progress. This enhances the encode
function which isn't currently used in the base tree but is when using
some of the testing tty patches.

This resolves a problem with some hardware where applications got
confusing information from the tty ioctls. Correct but confusing.

In some situations asking for, say, 9600 baud actually gets you 9595 baud
or similar near-miss values. With the old code this meant that a request
for B9600 got a return of BOTHER, 9595 which programs interpreted as a
failure.

The new code now works on the following basis
	- If you ask for specific rate via BOTHER, you get a precise
return
	- If you ask for a standard Bfoo rate and the result is close you
get a Bfoo return
	- If you ask for a standard Bfoo rate and get something way off
you get a BOTHER/rate return

This seems to fix up the cases I've found where this broke compatibility.


Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.20-rc3-mm1/drivers/char/tty_ioctl.c linux-2.6.20-rc3-mm1/drivers/char/tty_ioctl.c
--- linux.vanilla-2.6.20-rc3-mm1/drivers/char/tty_ioctl.c	2007-01-05 13:08:29.000000000 +0000
+++ linux-2.6.20-rc3-mm1/drivers/char/tty_ioctl.c	2007-01-05 14:12:01.000000000 +0000
@@ -225,7 +225,7 @@
 
 /**
  *	tty_termios_encode_baud_rate
- *	@termios: termios structure
+ *	@termios: ktermios structure holding user requested state
  *	@ispeed: input speed
  *	@ospeed: output speed
  *
@@ -233,7 +233,10 @@
  *	used as a library helper for drivers os that they can report back
  *	the actual speed selected when it differs from the speed requested
  *
- *	For now input and output speed must agree.
+ *	For maximal back compatibility with legacy SYS5/POSIX *nix behaviour
+ *	we need to carefully set the bits when the user does not get the
+ *	desired speed. We allow small margins and preserve as much of possible
+ *	of the input intent to keep compatiblity.
  *
  *	Locking: Caller should hold termios lock. This is already held
  *	when calling this function from the driver termios handler.
@@ -242,32 +245,44 @@
 void tty_termios_encode_baud_rate(struct ktermios *termios, speed_t ibaud, speed_t obaud)
 {
 	int i = 0;
-	int ifound = 0, ofound = 0;
+	int ifound = -1, ofound = -1;
+	int iclose = ibaud/50, oclose = obaud/50;
+	int ibinput = 0;
 
 	termios->c_ispeed = ibaud;
 	termios->c_ospeed = obaud;
+	
+	/* If the user asked for a precise weird speed give a precise weird
+	   answer. If they asked for a Bfoo speed they many have problems 
+	   digesting non-exact replies so fuzz a bit */
+	   
+	if ((termios->c_cflag & CBAUD) == BOTHER)
+		oclose = 0;
+	if (((termios->c_cflag >> IBSHIFT) & CBAUD) == BOTHER)
+		iclose = 0;
+	if ((termios->c_cflag >> IBSHIFT) & CBAUD)
+		ibinput = 1;	/* An input speed was specified */
 
 	termios->c_cflag &= ~CBAUD;
-	/* Identical speed means no input encoding (ie B0 << IBSHIFT)*/
-	if (termios->c_ispeed == termios->c_ospeed)
-		ifound = 1;
 
 	do {
-		if (obaud == baud_table[i]) {
+		if (obaud - oclose >= baud_table[i] && obaud + oclose <= baud_table[i]) {
 			termios->c_cflag |= baud_bits[i];
-			ofound = 1;
-			/* So that if ibaud == obaud we don't set it */
-			continue;
+			ofound = i;
 		}
-		if (ibaud == baud_table[i]) {
-			termios->c_cflag |= (baud_bits[i] << IBSHIFT);
-			ifound = 1;
+		if (ibaud - iclose >= baud_table[i] && ibaud + iclose <= baud_table[i]) {
+			/* For the case input == output don't set IBAUD bits if the user didn't do so */
+			if (ofound != i || ibinput)
+				termios->c_cflag |= (baud_bits[i] << IBSHIFT);
+			ifound = i;
 		}
 	}
 	while(++i < n_baud_table);
-	if (!ofound)
+	if (ofound == -1)
 		termios->c_cflag |= BOTHER;
-	if (!ifound)
+	/* Set exact input bits only if the input and output differ or the
+	   user already did */
+	if (ifound == -1 && (ibaud != obaud  || ibinput))
 		termios->c_cflag |= (BOTHER << IBSHIFT);
 }
 
