Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266633AbUBQXDm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 18:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266621AbUBQXBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 18:01:30 -0500
Received: from hera.cwi.nl ([192.16.191.8]:58075 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S266704AbUBQW7p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 17:59:45 -0500
From: Andries.Brouwer@cwi.nl
Date: Tue, 17 Feb 2004 23:59:33 +0100 (MET)
Message-Id: <UTC200402172259.i1HMxXX20656.aeb@smtp.cwi.nl>
To: jamie@shareable.org, torvalds@osdl.org
Subject: Re: stty utf8
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    > When you edit a line with the kernel's terminal line editor, when you
    > press the Delete key, it writes backspace-space-backspace and removes
    > one byte from the input.  That fails to do the right thing on UTF-8
    > terminals.

    Yes. I looked at that a year ago, and it should be pretty easy to make the 
    backspace code look more like the "delete word" code - except the "word" 
    is just a utf character.

    I didn't care enough to really bother fixing it - the fact is, that people 
    who care about UTF-8 tend to have to be in graphics mode anyway, and there 
    is something to be said for keeping the text console simple even if it 
    means it lacks functionality.

    But if somebody cares more than I do (hint, hint ;), I do think it should 
    be fixed.

    > There is no fancy environment setting which corrects this problem.
    > The kernel needs to know it's dealing with a UTF-8 terminal for basic
    > line editing to work.

    Yes. And I'd happily take patches for it.

OK - this sounds like a good moment to come with such patches.
The below is essentially a five-year-old patch by Bruno Haible.
It introduces utf8 mode, and the effect it has on erasing input characters.
(For the console more is needed, there are a few more patches there.)

Andries


P.S. Is there a reason for the different definition of
IMAXBEL in asm-parisc/termbits.h, or was that a typo?
If there is a reason, I think a comment is in order.

-----
diff -uprN -X /linux/dontdiff a/drivers/char/n_tty.c b/drivers/char/n_tty.c
--- a/drivers/char/n_tty.c	2003-12-18 03:58:04.000000000 +0100
+++ b/drivers/char/n_tty.c	2004-02-17 23:25:36.000000000 +0100
@@ -172,6 +172,16 @@ ssize_t n_tty_chars_in_buffer(struct tty
 	return n;
 }
 
+static inline int is_utf8_continuation(unsigned char c)
+{
+	return (c & 0xc0) == 0x80;
+}
+
+static inline int is_continuation(unsigned char c, struct tty_struct *tty)
+{
+	return I_IUTF8(tty) && is_utf8_continuation(c);
+}
+
 /*
  * Perform OPOST processing.  Returns -1 when the output device is
  * full and the character must be retried.
@@ -226,7 +236,7 @@ static int opost(unsigned char c, struct
 		default:
 			if (O_OLCUC(tty))
 				c = toupper(c);
-			if (!iscntrl(c))
+			if (!iscntrl(c) && !is_continuation(c, tty))
 				tty->column++;
 			break;
 		}
@@ -330,7 +340,7 @@ static inline void finish_erasing(struct
 static void eraser(unsigned char c, struct tty_struct *tty)
 {
 	enum { ERASE, WERASE, KILL } kill_type;
-	int head, seen_alnums;
+	int head, seen_alnums, cnt;
 	unsigned long flags;
 
 	if (tty->read_head == tty->canon_head) {
@@ -368,8 +378,18 @@ static void eraser(unsigned char c, stru
 
 	seen_alnums = 0;
 	while (tty->read_head != tty->canon_head) {
-		head = (tty->read_head - 1) & (N_TTY_BUF_SIZE-1);
-		c = tty->read_buf[head];
+		head = tty->read_head;
+
+		/* erase a single possibly multibyte character */
+		do {
+			head = (head - 1) & (N_TTY_BUF_SIZE-1);
+			c = tty->read_buf[head];
+		} while (is_continuation(c, tty) && head != tty->canon_head);
+
+		/* do not partially erase */
+		if (is_continuation(c, tty))
+			break;
+
 		if (kill_type == WERASE) {
 			/* Equivalent to BSD's ALTWERASE. */
 			if (isalnum(c) || c == '_')
@@ -377,9 +397,10 @@ static void eraser(unsigned char c, stru
 			else if (seen_alnums)
 				break;
 		}
+		cnt = (tty->read_head - head) & (N_TTY_BUF_SIZE-1);
 		spin_lock_irqsave(&tty->read_lock, flags);
 		tty->read_head = head;
-		tty->read_cnt--;
+		tty->read_cnt -= cnt;
 		spin_unlock_irqrestore(&tty->read_lock, flags);
 		if (L_ECHO(tty)) {
 			if (L_ECHOPRT(tty)) {
@@ -388,7 +409,12 @@ static void eraser(unsigned char c, stru
 					tty->column++;
 					tty->erasing = 1;
 				}
+				/* if cnt > 1, output a multi-byte character */
 				echo_char(c, tty);
+				while (--cnt > 0) {
+					head = (head+1) & (N_TTY_BUF_SIZE-1);
+					put_char(tty->read_buf[head], tty);
+				}
 			} else if (kill_type == ERASE && !L_ECHOE(tty)) {
 				echo_char(ERASE_CHAR(tty), tty);
 			} else if (c == '\t') {
@@ -403,7 +429,7 @@ static void eraser(unsigned char c, stru
 					else if (iscntrl(c)) {
 						if (L_ECHOCTL(tty))
 							col += 2;
-					} else
+					} else if (!is_continuation(c, tty))
 						col++;
 					tail = (tail+1) & (N_TTY_BUF_SIZE-1);
 				}
diff -uprN -X /linux/dontdiff a/include/asm-alpha/termbits.h b/include/asm-alpha/termbits.h
--- a/include/asm-alpha/termbits.h	2003-12-18 03:59:05.000000000 +0100
+++ b/include/asm-alpha/termbits.h	2004-02-17 23:18:21.000000000 +0100
@@ -56,12 +56,10 @@ struct termios {
 #define ICRNL	0000400
 #define IXON	0001000
 #define IXOFF	0002000
-#if !defined(KERNEL) || defined(__USE_BSD)
-  /* POSIX.1 doesn't want these... */
-# define IXANY		0004000
-# define IUCLC		0010000
-# define IMAXBEL	0020000
-#endif
+#define IXANY	0004000
+#define IUCLC	0010000
+#define IMAXBEL	0020000
+#define IUTF8	0040000
 
 /* c_oflag bits */
 #define OPOST	0000001
diff -uprN -X /linux/dontdiff a/include/asm-arm/termbits.h b/include/asm-arm/termbits.h
--- a/include/asm-arm/termbits.h	2003-12-18 04:00:00.000000000 +0100
+++ b/include/asm-arm/termbits.h	2004-02-17 23:12:29.000000000 +0100
@@ -49,6 +49,7 @@ struct termios {
 #define IXANY	0004000
 #define IXOFF	0010000
 #define IMAXBEL	0020000
+#define IUTF8	0040000
 
 /* c_oflag bits */
 #define OPOST	0000001
diff -uprN -X /linux/dontdiff a/include/asm-arm26/termbits.h b/include/asm-arm26/termbits.h
--- a/include/asm-arm26/termbits.h	2003-12-18 03:59:04.000000000 +0100
+++ b/include/asm-arm26/termbits.h	2004-02-17 23:22:31.000000000 +0100
@@ -49,6 +49,7 @@ struct termios {
 #define IXANY	0004000
 #define IXOFF	0010000
 #define IMAXBEL	0020000
+#define IUTF8	0040000
 
 /* c_oflag bits */
 #define OPOST	0000001
diff -uprN -X /linux/dontdiff a/include/asm-cris/termbits.h b/include/asm-cris/termbits.h
--- a/include/asm-cris/termbits.h	2003-12-18 03:58:16.000000000 +0100
+++ b/include/asm-cris/termbits.h	2004-02-17 23:23:05.000000000 +0100
@@ -53,6 +53,7 @@ struct termios {
 #define IXANY	0004000
 #define IXOFF	0010000
 #define IMAXBEL	0020000
+#define IUTF8	0040000
 
 /* c_oflag bits */
 #define OPOST	0000001
diff -uprN -X /linux/dontdiff a/include/asm-h8300/termbits.h b/include/asm-h8300/termbits.h
--- a/include/asm-h8300/termbits.h	2003-12-18 03:59:58.000000000 +0100
+++ b/include/asm-h8300/termbits.h	2004-02-17 23:21:34.000000000 +0100
@@ -52,6 +52,7 @@ struct termios {
 #define IXANY	0004000
 #define IXOFF	0010000
 #define IMAXBEL	0020000
+#define IUTF8	0040000
 
 /* c_oflag bits */
 #define OPOST	0000001
diff -uprN -X /linux/dontdiff a/include/asm-i386/termbits.h b/include/asm-i386/termbits.h
--- a/include/asm-i386/termbits.h	2003-12-18 03:58:40.000000000 +0100
+++ b/include/asm-i386/termbits.h	2004-02-17 23:20:59.000000000 +0100
@@ -51,6 +51,7 @@ struct termios {
 #define IXANY	0004000
 #define IXOFF	0010000
 #define IMAXBEL	0020000
+#define IUTF8	0040000
 
 /* c_oflag bits */
 #define OPOST	0000001
diff -uprN -X /linux/dontdiff a/include/asm-ia64/termbits.h b/include/asm-ia64/termbits.h
--- a/include/asm-ia64/termbits.h	2004-02-05 19:55:21.000000000 +0100
+++ b/include/asm-ia64/termbits.h	2004-02-17 23:10:43.000000000 +0100
@@ -60,6 +60,7 @@ struct termios {
 #define IXANY	0004000
 #define IXOFF	0010000
 #define IMAXBEL	0020000
+#define IUTF8	0040000
 
 /* c_oflag bits */
 #define OPOST	0000001
diff -uprN -X /linux/dontdiff a/include/asm-m68k/termbits.h b/include/asm-m68k/termbits.h
--- a/include/asm-m68k/termbits.h	2003-12-18 03:59:46.000000000 +0100
+++ b/include/asm-m68k/termbits.h	2004-02-17 23:11:54.000000000 +0100
@@ -52,6 +52,7 @@ struct termios {
 #define IXANY	0004000
 #define IXOFF	0010000
 #define IMAXBEL	0020000
+#define IUTF8	0040000
 
 /* c_oflag bits */
 #define OPOST	0000001
diff -uprN -X /linux/dontdiff a/include/asm-mips/termbits.h b/include/asm-mips/termbits.h
--- a/include/asm-mips/termbits.h	2003-12-18 03:58:08.000000000 +0100
+++ b/include/asm-mips/termbits.h	2004-02-17 23:10:02.000000000 +0100
@@ -77,6 +77,7 @@ struct termios {
 #define IXANY	0004000		/* Any character will restart after stop.  */
 #define IXOFF	0010000		/* Enable start/stop input control.  */
 #define IMAXBEL	0020000		/* Ring bell when input queue is full.  */
+#define IUTF8	0040000		/* Input is UTF8 */
 
 /* c_oflag bits */
 #define OPOST	0000001		/* Perform output processing.  */
diff -uprN -X /linux/dontdiff a/include/asm-parisc/termbits.h b/include/asm-parisc/termbits.h
--- a/include/asm-parisc/termbits.h	2003-12-18 03:58:56.000000000 +0100
+++ b/include/asm-parisc/termbits.h	2004-02-17 23:07:35.000000000 +0100
@@ -52,6 +52,7 @@ struct termios {
 #define IXANY	0004000
 #define IXOFF	0010000
 #define IMAXBEL	0040000
+#define IUTF8	0100000
 
 /* c_oflag bits */
 #define OPOST	0000001
diff -uprN -X /linux/dontdiff a/include/asm-ppc/termbits.h b/include/asm-ppc/termbits.h
--- a/include/asm-ppc/termbits.h	2003-12-18 03:58:57.000000000 +0100
+++ b/include/asm-ppc/termbits.h	2004-02-17 23:11:14.000000000 +0100
@@ -58,6 +58,7 @@ struct termios {
 #define IXANY		0004000
 #define IUCLC		0010000
 #define IMAXBEL	0020000
+#define IUTF8	0040000
 
 /* c_oflag bits */
 #define OPOST	0000001
diff -uprN -X /linux/dontdiff a/include/asm-ppc64/termbits.h b/include/asm-ppc64/termbits.h
--- a/include/asm-ppc64/termbits.h	2003-12-18 03:59:04.000000000 +0100
+++ b/include/asm-ppc64/termbits.h	2004-02-17 23:09:02.000000000 +0100
@@ -66,6 +66,7 @@ struct termios {
 #define IXANY	0004000
 #define IUCLC	0010000
 #define IMAXBEL	0020000
+#define	IUTF8	0040000
 
 /* c_oflag bits */
 #define OPOST	0000001
diff -uprN -X /linux/dontdiff a/include/asm-s390/termbits.h b/include/asm-s390/termbits.h
--- a/include/asm-s390/termbits.h	2003-12-18 03:59:29.000000000 +0100
+++ b/include/asm-s390/termbits.h	2004-02-17 23:20:26.000000000 +0100
@@ -59,6 +59,7 @@ struct termios {
 #define IXANY	0004000
 #define IXOFF	0010000
 #define IMAXBEL	0020000
+#define IUTF8	0040000
 
 /* c_oflag bits */
 #define OPOST	0000001
diff -uprN -X /linux/dontdiff a/include/asm-sh/termbits.h b/include/asm-sh/termbits.h
--- a/include/asm-sh/termbits.h	2003-12-18 03:58:18.000000000 +0100
+++ b/include/asm-sh/termbits.h	2004-02-17 23:23:40.000000000 +0100
@@ -51,6 +51,7 @@ struct termios {
 #define IXANY	0004000
 #define IXOFF	0010000
 #define IMAXBEL	0020000
+#define IUTF8	0040000
 
 /* c_oflag bits */
 #define OPOST	0000001
diff -uprN -X /linux/dontdiff a/include/asm-sparc/termbits.h b/include/asm-sparc/termbits.h
--- a/include/asm-sparc/termbits.h	2003-12-18 03:59:20.000000000 +0100
+++ b/include/asm-sparc/termbits.h	2004-02-17 23:13:13.000000000 +0100
@@ -78,6 +78,7 @@ struct termios {
 #define IXANY	0x00000800
 #define IXOFF	0x00001000
 #define IMAXBEL	0x00002000
+#define IUTF8   0x00004000
 
 /* c_oflag bits */
 #define OPOST	0x00000001
diff -uprN -X /linux/dontdiff a/include/asm-sparc64/termbits.h b/include/asm-sparc64/termbits.h
--- a/include/asm-sparc64/termbits.h	2003-12-18 03:58:18.000000000 +0100
+++ b/include/asm-sparc64/termbits.h	2004-02-17 23:22:06.000000000 +0100
@@ -80,6 +80,7 @@ struct termios {
 #define IXANY	0x00000800
 #define IXOFF	0x00001000
 #define IMAXBEL	0x00002000
+#define IUTF8	0x00004000
 
 /* c_oflag bits */
 #define OPOST	0x00000001
diff -uprN -X /linux/dontdiff a/include/asm-v850/termbits.h b/include/asm-v850/termbits.h
--- a/include/asm-v850/termbits.h	2003-12-18 03:58:04.000000000 +0100
+++ b/include/asm-v850/termbits.h	2004-02-17 23:23:25.000000000 +0100
@@ -52,6 +52,7 @@ struct termios {
 #define IXANY	0004000
 #define IXOFF	0010000
 #define IMAXBEL	0020000
+#define IUTF8	0040000
 
 /* c_oflag bits */
 #define OPOST	0000001
diff -uprN -X /linux/dontdiff a/include/asm-x86_64/termbits.h b/include/asm-x86_64/termbits.h
--- a/include/asm-x86_64/termbits.h	2003-12-18 03:58:08.000000000 +0100
+++ b/include/asm-x86_64/termbits.h	2004-02-17 23:06:05.000000000 +0100
@@ -51,6 +51,7 @@ struct termios {
 #define IXANY	0004000
 #define IXOFF	0010000
 #define IMAXBEL	0020000
+#define IUTF8	0040000
 
 /* c_oflag bits */
 #define OPOST	0000001
diff -uprN -X /linux/dontdiff a/include/linux/tty.h b/include/linux/tty.h
--- a/include/linux/tty.h	2003-12-18 03:58:49.000000000 +0100
+++ b/include/linux/tty.h	2004-02-17 23:04:31.000000000 +0100
@@ -200,6 +200,7 @@ struct tty_flip_buffer {
 #define I_IXANY(tty)	_I_FLAG((tty),IXANY)
 #define I_IXOFF(tty)	_I_FLAG((tty),IXOFF)
 #define I_IMAXBEL(tty)	_I_FLAG((tty),IMAXBEL)
+#define I_IUTF8(tty)	_I_FLAG((tty),IUTF8)
 
 #define O_OPOST(tty)	_O_FLAG((tty),OPOST)
 #define O_OLCUC(tty)	_O_FLAG((tty),OLCUC)
