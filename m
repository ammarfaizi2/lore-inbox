Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313088AbSDJOE7>; Wed, 10 Apr 2002 10:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313090AbSDJOE6>; Wed, 10 Apr 2002 10:04:58 -0400
Received: from [62.221.7.202] ([62.221.7.202]:47498 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S313088AbSDJOE4>; Wed, 10 Apr 2002 10:04:56 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.8-pre3 set_bit cleanup III
Date: Wed, 10 Apr 2002 23:43:38 +1000
Message-Id: <E16vIOE-0002Ym-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This removes gratuitous & operators in front of tty->process_char_map
and tty->read_flags.

No object code changes,
Rusty.
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.7-pre1/drivers/char/n_tty.c working-2.5.7-pre1-bitops/drivers/char/n_tty.c
--- linux-2.5.7-pre1/drivers/char/n_tty.c	Wed Feb 20 17:55:24 2002
+++ working-2.5.7-pre1-bitops/drivers/char/n_tty.c	Sat Mar 16 12:59:37 2002
@@ -538,7 +538,7 @@
 	 * handle specially, do shortcut processing to speed things
 	 * up.
 	 */
-	if (!test_bit(c, &tty->process_char_map) || tty->lnext) {
+	if (!test_bit(c, tty->process_char_map) || tty->lnext) {
 		finish_erasing(tty);
 		tty->lnext = 0;
 		if (L_ECHO(tty)) {
@@ -659,7 +659,7 @@
 
 		handle_newline:
 			spin_lock_irqsave(&tty->read_lock, flags);
-			set_bit(tty->read_head, &tty->read_flags);
+			set_bit(tty->read_head, tty->read_flags);
 			put_tty_queue_nolock(c, tty);
 			tty->canon_head = tty->read_head;
 			tty->canon_data++;
@@ -811,38 +811,38 @@
 		memset(tty->process_char_map, 0, 256/8);
 
 		if (I_IGNCR(tty) || I_ICRNL(tty))
-			set_bit('\r', &tty->process_char_map);
+			set_bit('\r', tty->process_char_map);
 		if (I_INLCR(tty))
-			set_bit('\n', &tty->process_char_map);
+			set_bit('\n', tty->process_char_map);
 
 		if (L_ICANON(tty)) {
-			set_bit(ERASE_CHAR(tty), &tty->process_char_map);
-			set_bit(KILL_CHAR(tty), &tty->process_char_map);
-			set_bit(EOF_CHAR(tty), &tty->process_char_map);
-			set_bit('\n', &tty->process_char_map);
-			set_bit(EOL_CHAR(tty), &tty->process_char_map);
+			set_bit(ERASE_CHAR(tty), tty->process_char_map);
+			set_bit(KILL_CHAR(tty), tty->process_char_map);
+			set_bit(EOF_CHAR(tty), tty->process_char_map);
+			set_bit('\n', tty->process_char_map);
+			set_bit(EOL_CHAR(tty), tty->process_char_map);
 			if (L_IEXTEN(tty)) {
 				set_bit(WERASE_CHAR(tty),
-					&tty->process_char_map);
+					tty->process_char_map);
 				set_bit(LNEXT_CHAR(tty),
-					&tty->process_char_map);
+					tty->process_char_map);
 				set_bit(EOL2_CHAR(tty),
-					&tty->process_char_map);
+					tty->process_char_map);
 				if (L_ECHO(tty))
 					set_bit(REPRINT_CHAR(tty),
-						&tty->process_char_map);
+						tty->process_char_map);
 			}
 		}
 		if (I_IXON(tty)) {
-			set_bit(START_CHAR(tty), &tty->process_char_map);
-			set_bit(STOP_CHAR(tty), &tty->process_char_map);
+			set_bit(START_CHAR(tty), tty->process_char_map);
+			set_bit(STOP_CHAR(tty), tty->process_char_map);
 		}
 		if (L_ISIG(tty)) {
-			set_bit(INTR_CHAR(tty), &tty->process_char_map);
-			set_bit(QUIT_CHAR(tty), &tty->process_char_map);
-			set_bit(SUSP_CHAR(tty), &tty->process_char_map);
+			set_bit(INTR_CHAR(tty), tty->process_char_map);
+			set_bit(QUIT_CHAR(tty), tty->process_char_map);
+			set_bit(SUSP_CHAR(tty), tty->process_char_map);
 		}
-		clear_bit(__DISABLED_CHAR, &tty->process_char_map);
+		clear_bit(__DISABLED_CHAR, tty->process_char_map);
 		sti();
 		tty->raw = 0;
 		tty->real_raw = 0;
@@ -1058,7 +1058,7 @@
  				int eol;
 
 				eol = test_and_clear_bit(tty->read_tail,
-						&tty->read_flags);
+						tty->read_flags);
 				c = tty->read_buf[tty->read_tail];
 				spin_lock_irqsave(&tty->read_lock, flags);
 				tty->read_tail = ((tty->read_tail+1) &
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.7-pre1/drivers/char/tty_ioctl.c working-2.5.7-pre1-bitops/drivers/char/tty_ioctl.c
--- linux-2.5.7-pre1/drivers/char/tty_ioctl.c	Tue Sep 18 15:52:35 2001
+++ working-2.5.7-pre1-bitops/drivers/char/tty_ioctl.c	Sat Mar 16 12:59:37 2002
@@ -188,7 +188,7 @@
 	nr = (head - tail) & (N_TTY_BUF_SIZE-1);
 	/* Skip EOF-chars.. */
 	while (head != tail) {
-		if (test_bit(tail, &tty->read_flags) &&
+		if (test_bit(tail, tty->read_flags) &&
 		    tty->read_buf[tail] == __DISABLED_CHAR)
 			nr--;
 		tail = (tail+1) & (N_TTY_BUF_SIZE-1);
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
