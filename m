Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbUDBWEI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 17:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbUDBWEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 17:04:07 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:28167 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261210AbUDBWDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 17:03:03 -0500
Date: Fri, 2 Apr 2004 23:02:59 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David L <idht4n@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: serial port canonical mode weirdness?
Message-ID: <20040402230259.C12306@flint.arm.linux.org.uk>
Mail-Followup-To: David L <idht4n@hotmail.com>,
	linux-kernel@vger.kernel.org
References: <BAY2-F51LDp7mvjkO2200021e67@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <BAY2-F51LDp7mvjkO2200021e67@hotmail.com>; from idht4n@hotmail.com on Wed, Mar 31, 2004 at 04:44:32PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2004 at 04:44:32PM -0800, David L wrote:
> When I configure a serial port for canonical mode (newtio.c_lflag = ICANON),
> I get behavior that isn't what I'd expect.
>...
> Is this a kernel bug or an ignorant user?  I might expect some
> data to be lost if a buffer overruns, but I didn't expect this behavior.

It's a kernel bug.  There are actually three bugs:

1. when we receive a buffer-full of characters, followed by a new line,
   we mark the first character of the buffer as being the last character
   of that line.  (this is why you get one character returned.)

2. when the new line is received, we have no buffer space to store it.
   with (1) fixed, this results in the canon head never being reached,
   so future read() calls returning zero without waiting.

3. we don't atomically add two and three byte character sequences to the
   buffer, so it's possible to have incomplete sequences in the buffer.

This patch fixes all three (according to my rudimentary testing here),
though please test it anyway.

Please note that this actually means that we can only receive 4094
characters before we overrun the buffer instead of 4096, even in raw
mode.

--- orig/drivers/char/n_tty.c	Sat Feb 28 10:09:05 2004
+++ linux/drivers/char/n_tty.c	Fri Apr  2 22:57:27 2004
@@ -83,24 +83,30 @@ static inline void free_buf(unsigned cha
 		free_page((unsigned long) buf);
 }
 
-static inline void put_tty_queue_nolock(unsigned char c, struct tty_struct *tty)
+static inline void put_tty_queue_nolock(struct tty_struct *tty, unsigned char *s, int num)
 {
-	if (tty->read_cnt < N_TTY_BUF_SIZE) {
-		tty->read_buf[tty->read_head] = c;
-		tty->read_head = (tty->read_head + 1) & (N_TTY_BUF_SIZE-1);
-		tty->read_cnt++;
+	if (tty->read_cnt + num < N_TTY_BUF_SIZE) {
+		while (num--) {
+			tty->read_buf[tty->read_head] = *s++;
+			tty->read_head = (tty->read_head + 1) & (N_TTY_BUF_SIZE-1);
+			tty->read_cnt++;
+		}
 	}
 }
 
-static inline void put_tty_queue(unsigned char c, struct tty_struct *tty)
+static inline void put_tty_queue(struct tty_struct *tty, unsigned char *s, int num)
 {
 	unsigned long flags;
 	/*
 	 *	The problem of stomping on the buffers ends here.
 	 *	Why didn't anyone see this one coming? --AJK
+	 *
+	 *	We must allow two spare characters for the EOL
+	 *	character(s). --rmk
 	*/
 	spin_lock_irqsave(&tty->read_lock, flags);
-	put_tty_queue_nolock(c, tty);
+	if (tty->read_cnt + num < N_TTY_BUF_SIZE - 2)
+		put_tty_queue_nolock(tty, s, num);
 	spin_unlock_irqrestore(&tty->read_lock, flags);
 }
 
@@ -481,6 +487,9 @@ static inline void isig(int sig, struct 
 
 static inline void n_tty_receive_break(struct tty_struct *tty)
 {
+	unsigned char str[3];
+	int idx = 0;
+
 	if (I_IGNBRK(tty))
 		return;
 	if (I_BRKINT(tty)) {
@@ -488,10 +497,11 @@ static inline void n_tty_receive_break(s
 		return;
 	}
 	if (I_PARMRK(tty)) {
-		put_tty_queue('\377', tty);
-		put_tty_queue('\0', tty);
+		str[idx++] = '\377';
+		str[idx++] = '\0';
 	}
-	put_tty_queue('\0', tty);
+	str[idx++] = '\0';
+	put_tty_queue(tty, str, idx);
 	wake_up_interruptible(&tty->read_wait);
 }
 
@@ -511,26 +521,32 @@ static inline void n_tty_receive_overrun
 static inline void n_tty_receive_parity_error(struct tty_struct *tty,
 					      unsigned char c)
 {
+	unsigned char str[3];
+	int idx = 0;
+
 	if (I_IGNPAR(tty)) {
 		return;
 	}
 	if (I_PARMRK(tty)) {
-		put_tty_queue('\377', tty);
-		put_tty_queue('\0', tty);
-		put_tty_queue(c, tty);
+		str[idx++] = '\377';
+		str[idx++] = '\0';
+		str[idx++] = c;
 	} else	if (I_INPCK(tty))
-		put_tty_queue('\0', tty);
+		str[idx++] = '\0';
 	else
-		put_tty_queue(c, tty);
+		str[idx++] = c;
+	put_tty_queue(tty, str, idx);
 	wake_up_interruptible(&tty->read_wait);
 }
 
 static inline void n_tty_receive_char(struct tty_struct *tty, unsigned char c)
 {
 	unsigned long flags;
+	unsigned char str[3];
+	int idx;
 
 	if (tty->raw) {
-		put_tty_queue(c, tty);
+		put_tty_queue(tty, &c, 1);
 		return;
 	}
 	
@@ -574,9 +590,11 @@ static inline void n_tty_receive_char(st
 				tty->canon_column = tty->column;
 			echo_char(c, tty);
 		}
+		idx = 0;
 		if (I_PARMRK(tty) && c == (unsigned char) '\377')
-			put_tty_queue(c, tty);
-		put_tty_queue(c, tty);
+			str[idx++] = c;
+		str[idx++] = c;
+		put_tty_queue(tty, str, idx);
 		return;
 	}
 		
@@ -613,6 +631,7 @@ send_signal:
 		}
 	}
 	if (tty->icanon) {
+		idx = 0;
 		if (c == ERASE_CHAR(tty) || c == KILL_CHAR(tty) ||
 		    (c == WERASE_CHAR(tty) && L_IEXTEN(tty))) {
 			eraser(c, tty);
@@ -678,12 +697,13 @@ send_signal:
 			 * EOL_CHAR and EOL2_CHAR?
 			 */
 			if (I_PARMRK(tty) && c == (unsigned char) '\377')
-				put_tty_queue(c, tty);
+				str[idx++] = c;
 
 		handle_newline:
+			str[idx++] = c;
 			spin_lock_irqsave(&tty->read_lock, flags);
 			set_bit(tty->read_head, tty->read_flags);
-			put_tty_queue_nolock(c, tty);
+			put_tty_queue_nolock(tty, str, idx);
 			tty->canon_head = tty->read_head;
 			tty->canon_data++;
 			spin_unlock_irqrestore(&tty->read_lock, flags);
@@ -710,10 +730,13 @@ send_signal:
 		}
 	}
 
+	idx = 0;
 	if (I_PARMRK(tty) && c == (unsigned char) '\377')
-		put_tty_queue(c, tty);
+		str[idx++] = c;
+
+	str[idx++] = c;
 
-	put_tty_queue(c, tty);
+	put_tty_queue(tty, str, idx);
 }	
 
 static int n_tty_receive_room(struct tty_struct *tty)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
