Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266886AbSL3JF2>; Mon, 30 Dec 2002 04:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266854AbSL3JEK>; Mon, 30 Dec 2002 04:04:10 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:30990 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S266844AbSL3JCq>;
	Mon, 30 Dec 2002 04:02:46 -0500
Date: Mon, 30 Dec 2002 01:06:17 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] minor TTY changes for 2.5.53
Message-ID: <20021230090617.GE29926@kroah.com>
References: <20021230090221.GA29926@kroah.com> <20021230090303.GB29926@kroah.com> <20021230090409.GC29926@kroah.com> <20021230090456.GD29926@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021230090456.GD29926@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.956.3.4, 2002/12/29 23:59:37-08:00, greg@kroah.com

TTY: replace MIN and MAX macro usages with min() and max()


diff -Nru a/drivers/char/n_tty.c b/drivers/char/n_tty.c
--- a/drivers/char/n_tty.c	Mon Dec 30 01:04:37 2002
+++ b/drivers/char/n_tty.c	Mon Dec 30 01:04:37 2002
@@ -48,10 +48,6 @@
 #define IS_CONSOLE_DEV(dev)	(kdev_val(dev) == __mkdev(TTY_MAJOR,0))
 #define IS_SYSCONS_DEV(dev)	(kdev_val(dev) == __mkdev(TTYAUX_MAJOR,1))
 
-#ifndef MIN
-#define MIN(a,b)	((a) < (b) ? (a) : (b))
-#endif
-
 /* number of characters left in xmit buffer before select has we have room */
 #define WAKEUP_CHARS 256
 
@@ -725,16 +721,18 @@
 
 	if (tty->real_raw) {
 		spin_lock_irqsave(&tty->read_lock, cpuflags);
-		i = MIN(count, MIN(N_TTY_BUF_SIZE - tty->read_cnt,
-				   N_TTY_BUF_SIZE - tty->read_head));
+		i = min(N_TTY_BUF_SIZE - tty->read_cnt,
+			N_TTY_BUF_SIZE - tty->read_head);
+		i = min(count, i);
 		memcpy(tty->read_buf + tty->read_head, cp, i);
 		tty->read_head = (tty->read_head + i) & (N_TTY_BUF_SIZE-1);
 		tty->read_cnt += i;
 		cp += i;
 		count -= i;
 
-		i = MIN(count, MIN(N_TTY_BUF_SIZE - tty->read_cnt,
-			       N_TTY_BUF_SIZE - tty->read_head));
+		i = min(N_TTY_BUF_SIZE - tty->read_cnt,
+			N_TTY_BUF_SIZE - tty->read_head);
+		i = min(count, i);
 		memcpy(tty->read_buf + tty->read_head, cp, i);
 		tty->read_head = (tty->read_head + i) & (N_TTY_BUF_SIZE-1);
 		tty->read_cnt += i;
@@ -915,7 +913,8 @@
 
 	retval = 0;
 	spin_lock_irqsave(&tty->read_lock, flags);
-	n = MIN(*nr, MIN(tty->read_cnt, N_TTY_BUF_SIZE - tty->read_tail));
+	n = min(tty->read_cnt, N_TTY_BUF_SIZE - tty->read_tail);
+	n = min((ssize_t)*nr, n);
 	spin_unlock_irqrestore(&tty->read_lock, flags);
 	if (n) {
 		mb();
diff -Nru a/drivers/char/pty.c b/drivers/char/pty.c
--- a/drivers/char/pty.c	Mon Dec 30 01:04:37 2002
+++ b/drivers/char/pty.c	Mon Dec 30 01:04:37 2002
@@ -64,8 +64,6 @@
 static struct pty_struct ptm_state[UNIX98_NR_MAJORS][NR_PTYS];
 #endif
 
-#define MIN(a,b)	((a) < (b) ? (a) : (b))
-
 static void pty_close(struct tty_struct * tty, struct file * filp)
 {
 	if (!tty)
@@ -156,7 +154,7 @@
 				n = count;
 			if (!n) break;
 
-			n  = MIN(n, PTY_BUF_SIZE);
+			n  = min(n, PTY_BUF_SIZE);
 			n -= copy_from_user(temp_buffer, buf, n);
 			if (!n) {
 				if (!c)
diff -Nru a/drivers/char/tty_io.c b/drivers/char/tty_io.c
--- a/drivers/char/tty_io.c	Mon Dec 30 01:04:37 2002
+++ b/drivers/char/tty_io.c	Mon Dec 30 01:04:37 2002
@@ -159,13 +159,6 @@
 extern void tx3912_rs_init(void);
 extern void hvc_console_init(void);
 
-#ifndef MIN
-#define MIN(a,b)	((a) < (b) ? (a) : (b))
-#endif
-#ifndef MAX
-#define MAX(a,b)	((a) < (b) ? (b) : (a))
-#endif
-
 static struct tty_struct *alloc_tty_struct(void)
 {
 	struct tty_struct *tty;
@@ -714,7 +707,7 @@
 		unlock_kernel();
 	} else {
 		for (;;) {
-			unsigned long size = MAX(PAGE_SIZE*2,16384);
+			unsigned long size = max((unsigned long)PAGE_SIZE*2, 16384UL);
 			if (size > count)
 				size = count;
 			lock_kernel();
