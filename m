Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270619AbRIWRa6>; Sun, 23 Sep 2001 13:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272369AbRIWRat>; Sun, 23 Sep 2001 13:30:49 -0400
Received: from fysh.org ([212.47.68.126]:32273 "EHLO bowl.fysh.org")
	by vger.kernel.org with ESMTP id <S270619AbRIWRad>;
	Sun, 23 Sep 2001 13:30:33 -0400
From: zefram@fysh.org
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] tty canonical mode: nicer erase behaviour
Message-Id: <E15kyyG-0000mq-00@dext.rous.org>
Date: Sun, 23 Sep 2001 02:26:16 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

problem rationale
-----------------

One of the long-standing problems preventing Unix from being a
user-friendly desktop OS is its handling of erase keys.  There are
often two such keys on a keyboard (Backspace and Delete), and which one
works depends very much on context -- many text editing programs will
only accept one of the erase-related characters (^H and ^?), and the
mapping from keys to characters is terminal-dependent.  Unfortunately,
any solution to this problem has to be implemented in each program that
faces this problem.

Theoretically every program should be able to determine which erase
character to accept by looking at terminfo, but that's very cumbersome,
particularly in programs that might not otherwise need to use terminfo.
It also utterly fails in programs that don't know what kind of terminal
they are interacting with.  The more practical solution, therefore, is
that the program should accept *both* ^H and ^? as erase characters.
Look at bash's and zsh's command line editors for examples of this
approach.

One of the programs that exhibits the ^H/^? problem is the tty
line discipline in the Linux kernel.  It falls into the category of
programs that don't know (and don't care) what kind of terminal they
are interacting with.  This patch implements the accept-both-characters
solution.

patch rationale
---------------

The exact semantics changed are: in canonical mode, if IEXTEN is on
and the ERASE character is set to either ^H or ^?, then both ^H and
^? are treated as ERASE characters.  The standard single-erase-character
behaviour is followed if IEXTEN is off (which prohibits non-POSIX extended
behaviour) or if the ERASE character is neither ^H or ^? (indicating
that the user actually wants erase behaviour other than the usual use
of the erase keys).

At first glance, a more obvious way to implement handling of both erase
characters would be to have an ERASE2 character setting in the tty state,
much as there is EOL and EOL2.  However, this solution would suffer
some annoying problems.  It would rely on the user setting the two erase
characters properly in order to take advantage of it.  Even if they're
set to ^H and ^? by default, user code that tries to set ERASE based on
the terminal type (and doesn't know about ERASE2) might end up with ERASE
and ERASE2 set to the same character, breaking the solution.  Also, code
(and users) that doesn't know about ERASE2 would get surprising results
if they try to set ERASE to something other than ^H/^?.  All of this
points to it being preferable not to change the tty settings interface,
but only change the behaviour to this preferable form.

the patch
---------

This patch is based on kernel version 2.4.8.  It will also apply cleanly
up to at least kernel version 2.4.10-pre14.

--- drivers/char/n_tty.c.orig	Sat Sep 22 22:14:19 2001
+++ drivers/char/n_tty.c	Sun Sep 23 02:59:30 2001
@@ -329,9 +329,11 @@
 	}
 }
 
-static void eraser(unsigned char c, struct tty_struct *tty)
+enum kill_type { ERASE, WERASE, KILL };
+
+static void eraser(int kill_type, unsigned char cc, struct tty_struct *tty)
 {
-	enum { ERASE, WERASE, KILL } kill_type;
+	unsigned char c;
 	int head, seen_alnums;
 	unsigned long flags;
 
@@ -339,11 +341,7 @@
 		/* opost('\a', tty); */		/* what do you think? */
 		return;
 	}
-	if (c == ERASE_CHAR(tty))
-		kill_type = ERASE;
-	else if (c == WERASE_CHAR(tty))
-		kill_type = WERASE;
-	else {
+	if (kill_type == KILL) {
 		if (!L_ECHO(tty)) {
 			spin_lock_irqsave(&tty->read_lock, flags);
 			tty->read_cnt -= ((tty->read_head - tty->canon_head) &
@@ -359,13 +357,12 @@
 			tty->read_head = tty->canon_head;
 			spin_unlock_irqrestore(&tty->read_lock, flags);
 			finish_erasing(tty);
-			echo_char(KILL_CHAR(tty), tty);
+			echo_char(cc, tty);
 			/* Add a newline if ECHOK is on and ECHOKE is off. */
 			if (L_ECHOK(tty))
 				opost('\n', tty);
 			return;
 		}
-		kill_type = KILL;
 	}
 
 	seen_alnums = 0;
@@ -392,7 +389,7 @@
 				}
 				echo_char(c, tty);
 			} else if (kill_type == ERASE && !L_ECHOE(tty)) {
-				echo_char(ERASE_CHAR(tty), tty);
+				echo_char(cc, tty);
 			} else if (c == '\t') {
 				unsigned int col = tty->canon_column;
 				unsigned long tail = tty->canon_head;
@@ -590,9 +587,19 @@
 		}
 	}
 	if (tty->icanon) {
-		if (c == ERASE_CHAR(tty) || c == KILL_CHAR(tty) ||
-		    (c == WERASE_CHAR(tty) && L_IEXTEN(tty))) {
-			eraser(c, tty);
+		if (c == ERASE_CHAR(tty) ||
+		    (L_IEXTEN(tty) &&
+		     (ERASE_CHAR(tty) == 8 || ERASE_CHAR(tty) == 127) &&
+		     (c == 8 || c == 127))) {
+			eraser(ERASE, c, tty);
+			return;
+		}
+		if (c == KILL_CHAR(tty)) {
+			eraser(KILL, c, tty);
+			return;
+		}
+		if (c == WERASE_CHAR(tty) && L_IEXTEN(tty)) {
+			eraser(WERASE, c, tty);
 			return;
 		}
 		if (c == LNEXT_CHAR(tty) && L_IEXTEN(tty)) {
@@ -822,6 +829,11 @@
 			set_bit('\n', &tty->process_char_map);
 			set_bit(EOL_CHAR(tty), &tty->process_char_map);
 			if (L_IEXTEN(tty)) {
+				if (ERASE_CHAR(tty) == 8 ||
+				    ERASE_CHAR(tty) == 127) {
+					set_bit(8, &tty->process_char_map);
+					set_bit(127, &tty->process_char_map);
+				}
 				set_bit(WERASE_CHAR(tty),
 					&tty->process_char_map);
 				set_bit(LNEXT_CHAR(tty),

-zefram
