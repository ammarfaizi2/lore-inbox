Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261488AbVBPTuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbVBPTuU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 14:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbVBPTuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 14:50:20 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:16560 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261488AbVBPTuF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 14:50:05 -0500
Date: Wed, 16 Feb 2005 20:49:52 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Linus Torvalds <torvalds@osdl.org>
cc: Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org,
       "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: Pty is losing bytes
In-Reply-To: <Pine.LNX.4.58.0502151942530.2383@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.61.0502161147510.15340@scrub.home>
References: <jebramy75q.fsf@sykes.suse.de> <Pine.LNX.4.58.0502151053060.5570@ppc970.osdl.org>
 <je1xbhy3ap.fsf@sykes.suse.de> <Pine.LNX.4.58.0502151239160.2330@ppc970.osdl.org>
 <Pine.LNX.4.61.0502160405410.15339@scrub.home> <Pine.LNX.4.58.0502151942530.2383@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 15 Feb 2005, Linus Torvalds wrote:

> So I'd still worry whether that added -1 actually fixes the bug, or just 
> means that a off-by-one has to now be off-by-two to be noticeable..

You're right, even if one just writes 4095 bytes, it will also drop 
tty->read_cnt characters later.

> Does that make sense to you? Maybe the "input full, but no canon_data" 
> special case would be better handled in the read path, rather than the 
> write path?

There might be no reader at this time. The basic problem is that this 
should be handled in the receive_buf path, but for that it had to return 
the numbers of characters written (or dropped in the no canon_data case). 
Relying on receive_room value instead is rather bogus.

Below is a new patch, which also fixes problems with very long lines.
1. if receive_room() returns a small number, write_chan() has to 
continue writing, otherwise it will sleep with nobody waking it up.
2. we mustn't simply drop eol characters in n_tty_receive_char otherwise 
canon_data isn't increased and the reader isn't woken up.

bye, Roman

 n_tty.c |   33 +++++++++++++++------------------
 1 files changed, 15 insertions(+), 18 deletions(-)

Index: linux-2.6/drivers/char/n_tty.c
===================================================================
--- linux-2.6.orig/drivers/char/n_tty.c	2005-02-16 16:01:35.000000000 +0100
+++ linux-2.6/drivers/char/n_tty.c	2005-02-16 19:17:13.053000548 +0100
@@ -770,10 +770,8 @@ send_signal:
 		}
 		if (c == '\n') {
 			if (L_ECHO(tty) || L_ECHONL(tty)) {
-				if (tty->read_cnt >= N_TTY_BUF_SIZE-1) {
+				if (tty->read_cnt >= N_TTY_BUF_SIZE-1)
 					put_char('\a', tty);
-					return;
-				}
 				opost('\n', tty);
 			}
 			goto handle_newline;
@@ -790,10 +788,8 @@ send_signal:
 			 * XXX are EOL_CHAR and EOL2_CHAR echoed?!?
 			 */
 			if (L_ECHO(tty)) {
-				if (tty->read_cnt >= N_TTY_BUF_SIZE-1) {
+				if (tty->read_cnt >= N_TTY_BUF_SIZE-1)
 					put_char('\a', tty);
-					return;
-				}
 				/* Record the column of first canon char. */
 				if (tty->canon_head == tty->read_head)
 					tty->canon_column = tty->column;
@@ -862,12 +858,9 @@ static int n_tty_receive_room(struct tty
 	 * that erase characters will be handled.  Other excess
 	 * characters will be beeped.
 	 */
-	if (tty->icanon && !tty->canon_data)
-		return N_TTY_BUF_SIZE;
-
-	if (left > 0)
-		return left;
-	return 0;
+	if (left <= 0)
+		left = tty->icanon && !tty->canon_data;
+	return left;
 }
 
 /**
@@ -1473,13 +1466,17 @@ static ssize_t write_chan(struct tty_str
 			if (tty->driver->flush_chars)
 				tty->driver->flush_chars(tty);
 		} else {
-			c = tty->driver->write(tty, b, nr);
-			if (c < 0) {
-				retval = c;
-				goto break_out;
+			while (nr > 0) {
+				c = tty->driver->write(tty, b, nr);
+				if (c < 0) {
+					retval = c;
+					goto break_out;
+				}
+				if (!c)
+					break;
+				b += c;
+				nr -= c;
 			}
-			b += c;
-			nr -= c;
 		}
 		if (!nr)
 			break;
