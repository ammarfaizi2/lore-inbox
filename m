Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbWHCMxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbWHCMxd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 08:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbWHCMxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 08:53:33 -0400
Received: from parabel.levigo.net ([62.206.214.16]:59033 "EHLO
	parabel.matrix.de") by vger.kernel.org with ESMTP id S932435AbWHCMxb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 08:53:31 -0400
Message-ID: <44D1F1C5.6040809@gdsys.de>
Date: Thu, 03 Aug 2006 14:53:25 +0200
From: Dirk Eibach <eibach@gdsys.de>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: rmk+serial@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] tty: add ioctl for setting the throttle threshold
  (handshake)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.2-5; AVE: 7.1.1.0; VDF: 6.35.1.43; host: mailrelay)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dirk Eibach <eibach@gdsys.de>

The threshold for throttling tty input is currently set fixed to 128 
byte remaining room (drivers/char/n_tty.c:TTY_THRESHOLD_THROTTLE). The 
unthrottling threshold is set fixed to 128 byte remaining in the buffer.

If the sender reacts slowly and bitrate is high, 128 byte may not be 
sufficient to avoid buffer overflows.

To be more flexible ioctls were added to control the throttling thresholds.

This patch applies to kernel 2.6.16.

Signed-off-by: Dirk Eibach <eibach@gdsys.de>
---
diff -uprN -X linux-2.6.16.orig//Documentation/dontdiff 
linux-2.6.16.tiny/drivers/char/n_tty.c 
linux-2.6.16-throttle/drivers/char/n_tty.c
--- linux-2.6.16.tiny/drivers/char/n_tty.c	2006-03-20 06:53:29.000000000 
+0100
+++ linux-2.6.16-throttle/drivers/char/n_tty.c	2006-08-03 
14:14:35.000000000 +0200
@@ -52,14 +52,6 @@
  /* number of characters left in xmit buffer before select has we have 
room */
  #define WAKEUP_CHARS 256

-/*
- * This defines the low- and high-watermarks for throttling and
- * unthrottling the TTY driver.  These watermarks are used for
- * controlling the space in the read buffer.
- */
-#define TTY_THRESHOLD_THROTTLE		128 /* now based on remaining room */
-#define TTY_THRESHOLD_UNTHROTTLE 	128
-
  static inline unsigned char *alloc_buf(void)
  {
  	gfp_t prio = in_interrupt() ? GFP_ATOMIC : GFP_KERNEL;
@@ -968,7 +960,7 @@ static void n_tty_receive_buf(struct tty
  	 * mode.  We don't want to throttle the driver if we're in
  	 * canonical mode and don't have a newline yet!
  	 */
-	if (tty->receive_room < TTY_THRESHOLD_THROTTLE) {
+	if (tty->receive_room < tty->threshold_throttle) {
  		/* check TTY_THROTTLED first so it indicates our state */
  		if (!test_and_set_bit(TTY_THROTTLED, &tty->flags) &&
  		    tty->driver->throttle)
@@ -1384,7 +1376,7 @@ do_it_again:
  		 * longer than TTY_THRESHOLD_UNTHROTTLE in canonical mode,
  		 * we won't get any more characters.
  		 */
-		if (n_tty_chars_in_buffer(tty) <= TTY_THRESHOLD_UNTHROTTLE)
+		if (n_tty_chars_in_buffer(tty) <= tty->threshold_unthrottle)
  			check_unthrottle(tty);

  		if (b - buf >= minimum)
diff -uprN -X linux-2.6.16.orig//Documentation/dontdiff 
linux-2.6.16.tiny/drivers/char/tty_io.c 
linux-2.6.16-throttle/drivers/char/tty_io.c
--- linux-2.6.16.tiny/drivers/char/tty_io.c	2006-03-20 
06:53:29.000000000 +0100
+++ linux-2.6.16-throttle/drivers/char/tty_io.c	2006-08-03 
14:15:37.000000000 +0200
@@ -111,6 +111,14 @@
  #define TTY_PARANOIA_CHECK 1
  #define CHECK_TTY_COUNT 1

+/*
+* This defines the low- and high-watermarks for throttling and
+* unthrottling the TTY driver.  These watermarks are used for
+* controlling the space in the read buffer.
+*/
+#define TTY_THRESHOLD_THROTTLE		128 /* now based on remaining room */
+#define TTY_THRESHOLD_UNTHROTTLE 	128
+
  struct termios tty_std_termios = {	/* for the benefit of tty drivers  */
  	.c_iflag = ICRNL | IXON,
  	.c_oflag = OPOST | ONLCR,
@@ -2920,6 +2928,8 @@ static void initialize_tty_struct(struct
  	spin_lock_init(&tty->read_lock);
  	INIT_LIST_HEAD(&tty->tty_files);
  	INIT_WORK(&tty->SAK_work, NULL, NULL);
+	tty->threshold_throttle = TTY_THRESHOLD_THROTTLE;
+	tty->threshold_unthrottle = TTY_THRESHOLD_UNTHROTTLE;
  }

  /*
diff -uprN -X linux-2.6.16.orig//Documentation/dontdiff 
linux-2.6.16.tiny/drivers/char/tty_ioctl.c 
linux-2.6.16-throttle/drivers/char/tty_ioctl.c
--- linux-2.6.16.tiny/drivers/char/tty_ioctl.c	2006-03-20 
06:53:29.000000000 +0100
+++ linux-2.6.16-throttle/drivers/char/tty_ioctl.c	2006-08-03 
10:38:10.000000000 +0200
@@ -543,6 +543,26 @@ int n_tty_ioctl(struct tty_struct * tty,
  				 (arg ? CLOCAL : 0));
  			up(&tty->termios_sem);
  			return 0;
+#ifdef TIOCGTHROTTLE
+		case TIOCGTHROTTLE:
+			return put_user(tty->threshold_throttle, (unsigned int __user *)arg);
+		case TIOCSTHROTTLE:
+			if (get_user(arg, (unsigned int __user *) arg))
+				return -EFAULT;
+			if ((arg >= N_TTY_BUF_SIZE) || (arg == 0))
+				return -EINVAL;
+			tty->threshold_throttle = arg;
+			return 0;
+		case TIOCGUNTHROTTLE:
+			return put_user(tty->threshold_unthrottle, (unsigned int __user *)arg);
+		case TIOCSUNTHROTTLE:
+			if (get_user(arg, (unsigned int __user *) arg))
+				return -EFAULT;
+			if ((arg >= N_TTY_BUF_SIZE) || (arg == 0))
+				return -EINVAL;
+			tty->threshold_unthrottle = arg;
+			return 0;
+#endif
  		default:
  			return -ENOIOCTLCMD;
  		}
diff -uprN -X linux-2.6.16.orig//Documentation/dontdiff 
linux-2.6.16.tiny/include/asm-alpha/ioctls.h 
linux-2.6.16-throttle/include/asm-alpha/ioctls.h
--- linux-2.6.16.tiny/include/asm-alpha/ioctls.h	2006-03-20 
06:53:29.000000000 +0100
+++ linux-2.6.16-throttle/include/asm-alpha/ioctls.h	2006-08-03 
13:54:37.000000000 +0200
@@ -109,4 +109,9 @@
  #define TIOCGHAYESESP	0x545E  /* Get Hayes ESP configuration */
  #define TIOCSHAYESESP	0x545F  /* Set Hayes ESP configuration */

+#define TIOCGTHROTTLE	_IOR('T',0x70, unsigned int)
+#define TIOCSTHROTTLE	_IOW('T',0x71, unsigned int)
+#define TIOCGUNTHROTTLE	_IOR('T',0x72, unsigned int)
+#define TIOCSUNTHROTTLE	_IOW('T',0x73, unsigned int)
+
  #endif /* _ASM_ALPHA_IOCTLS_H */
diff -uprN -X linux-2.6.16.orig//Documentation/dontdiff 
linux-2.6.16.tiny/include/asm-arm/ioctls.h 
linux-2.6.16-throttle/include/asm-arm/ioctls.h
--- linux-2.6.16.tiny/include/asm-arm/ioctls.h	2006-03-20 
06:53:29.000000000 +0100
+++ linux-2.6.16-throttle/include/asm-arm/ioctls.h	2006-08-03 
13:53:39.000000000 +0200
@@ -66,6 +66,11 @@
  #define TIOCGICOUNT	0x545D	/* read serial port inline interrupt counts */
  #define FIOQSIZE	0x545E

+#define TIOCGTHROTTLE	_IOR('T',0x70, unsigned int)
+#define TIOCSTHROTTLE	_IOW('T',0x71, unsigned int)
+#define TIOCGUNTHROTTLE	_IOR('T',0x72, unsigned int)
+#define TIOCSUNTHROTTLE	_IOW('T',0x73, unsigned int)
+
  /* Used for packet mode */
  #define TIOCPKT_DATA		 0
  #define TIOCPKT_FLUSHREAD	 1
diff -uprN -X linux-2.6.16.orig//Documentation/dontdiff 
linux-2.6.16.tiny/include/asm-arm26/ioctls.h 
linux-2.6.16-throttle/include/asm-arm26/ioctls.h
--- linux-2.6.16.tiny/include/asm-arm26/ioctls.h	2006-03-20 
06:53:29.000000000 +0100
+++ linux-2.6.16-throttle/include/asm-arm26/ioctls.h	2006-08-03 
13:55:41.000000000 +0200
@@ -67,6 +67,11 @@
  #define TIOCGICOUNT	0x545D	/* read serial port inline interrupt counts */
  #define FIOQSIZE	0x545E

+#define TIOCGTHROTTLE	_IOR('T',0x70, unsigned int)
+#define TIOCSTHROTTLE	_IOW('T',0x71, unsigned int)
+#define TIOCGUNTHROTTLE	_IOR('T',0x72, unsigned int)
+#define TIOCSUNTHROTTLE	_IOW('T',0x73, unsigned int)
+
  /* Used for packet mode */
  #define TIOCPKT_DATA		 0
  #define TIOCPKT_FLUSHREAD	 1
diff -uprN -X linux-2.6.16.orig//Documentation/dontdiff 
linux-2.6.16.tiny/include/asm-cris/ioctls.h 
linux-2.6.16-throttle/include/asm-cris/ioctls.h
--- linux-2.6.16.tiny/include/asm-cris/ioctls.h	2006-03-20 
06:53:29.000000000 +0100
+++ linux-2.6.16-throttle/include/asm-cris/ioctls.h	2006-08-03 
13:56:04.000000000 +0200
@@ -73,6 +73,11 @@
  #define TIOCSERSETRS485 0x5461  /* enable rs-485 */
  #define TIOCSERWRRS485  0x5462  /* write rs-485 */

+#define TIOCGTHROTTLE	_IOR('T',0x70, unsigned int)
+#define TIOCSTHROTTLE	_IOW('T',0x71, unsigned int)
+#define TIOCGUNTHROTTLE	_IOR('T',0x72, unsigned int)
+#define TIOCSUNTHROTTLE	_IOW('T',0x73, unsigned int)
+
  /* Used for packet mode */
  #define TIOCPKT_DATA		 0
  #define TIOCPKT_FLUSHREAD	 1
diff -uprN -X linux-2.6.16.orig//Documentation/dontdiff 
linux-2.6.16.tiny/include/asm-frv/ioctls.h 
linux-2.6.16-throttle/include/asm-frv/ioctls.h
--- linux-2.6.16.tiny/include/asm-frv/ioctls.h	2006-03-20 
06:53:29.000000000 +0100
+++ linux-2.6.16-throttle/include/asm-frv/ioctls.h	2006-08-03 
13:56:28.000000000 +0200
@@ -67,6 +67,11 @@
  #define TIOCGICOUNT	0x545D	/* read serial port inline interrupt counts */
  #define FIOQSIZE	0x545E

+#define TIOCGTHROTTLE	_IOR('T',0x70, unsigned int)
+#define TIOCSTHROTTLE	_IOW('T',0x71, unsigned int)
+#define TIOCGUNTHROTTLE	_IOR('T',0x72, unsigned int)
+#define TIOCSUNTHROTTLE	_IOW('T',0x73, unsigned int)
+
  /* Used for packet mode */
  #define TIOCPKT_DATA		 0
  #define TIOCPKT_FLUSHREAD	 1
diff -uprN -X linux-2.6.16.orig//Documentation/dontdiff 
linux-2.6.16.tiny/include/asm-h8300/ioctls.h 
linux-2.6.16-throttle/include/asm-h8300/ioctls.h
--- linux-2.6.16.tiny/include/asm-h8300/ioctls.h	2006-03-20 
06:53:29.000000000 +0100
+++ linux-2.6.16-throttle/include/asm-h8300/ioctls.h	2006-08-03 
13:56:57.000000000 +0200
@@ -67,6 +67,11 @@
  #define TIOCGICOUNT	0x545D	/* read serial port inline interrupt counts */
  #define FIOQSIZE	0x545E

+#define TIOCGTHROTTLE	_IOR('T',0x70, unsigned int)
+#define TIOCSTHROTTLE	_IOW('T',0x71, unsigned int)
+#define TIOCGUNTHROTTLE	_IOR('T',0x72, unsigned int)
+#define TIOCSUNTHROTTLE	_IOW('T',0x73, unsigned int)
+
  /* Used for packet mode */
  #define TIOCPKT_DATA		 0
  #define TIOCPKT_FLUSHREAD	 1
diff -uprN -X linux-2.6.16.orig//Documentation/dontdiff 
linux-2.6.16.tiny/include/asm-i386/ioctls.h 
linux-2.6.16-throttle/include/asm-i386/ioctls.h
--- linux-2.6.16.tiny/include/asm-i386/ioctls.h	2006-03-20 
06:53:29.000000000 +0100
+++ linux-2.6.16-throttle/include/asm-i386/ioctls.h	2006-08-03 
13:54:25.000000000 +0200
@@ -69,6 +69,11 @@
  #define TIOCSHAYESESP   0x545F  /* Set Hayes ESP configuration */
  #define FIOQSIZE	0x5460

+#define TIOCGTHROTTLE	_IOR('T',0x70, unsigned int)
+#define TIOCSTHROTTLE	_IOW('T',0x71, unsigned int)
+#define TIOCGUNTHROTTLE	_IOR('T',0x72, unsigned int)
+#define TIOCSUNTHROTTLE	_IOW('T',0x73, unsigned int)
+
  /* Used for packet mode */
  #define TIOCPKT_DATA		 0
  #define TIOCPKT_FLUSHREAD	 1
diff -uprN -X linux-2.6.16.orig//Documentation/dontdiff 
linux-2.6.16.tiny/include/asm-ia64/ioctls.h 
linux-2.6.16-throttle/include/asm-ia64/ioctls.h
--- linux-2.6.16.tiny/include/asm-ia64/ioctls.h	2006-03-20 
06:53:29.000000000 +0100
+++ linux-2.6.16-throttle/include/asm-ia64/ioctls.h	2006-08-03 
13:57:31.000000000 +0200
@@ -75,6 +75,11 @@
  #define TIOCSHAYESESP   0x545F  /* Set Hayes ESP configuration */
  #define FIOQSIZE	0x5460

+#define TIOCGTHROTTLE	_IOR('T',0x70, unsigned int)
+#define TIOCSTHROTTLE	_IOW('T',0x71, unsigned int)
+#define TIOCGUNTHROTTLE	_IOR('T',0x72, unsigned int)
+#define TIOCSUNTHROTTLE	_IOW('T',0x73, unsigned int)
+
  /* Used for packet mode */
  #define TIOCPKT_DATA		 0
  #define TIOCPKT_FLUSHREAD	 1
diff -uprN -X linux-2.6.16.orig//Documentation/dontdiff 
linux-2.6.16.tiny/include/asm-m32r/ioctls.h 
linux-2.6.16-throttle/include/asm-m32r/ioctls.h
--- linux-2.6.16.tiny/include/asm-m32r/ioctls.h	2006-03-20 
06:53:29.000000000 +0100
+++ linux-2.6.16-throttle/include/asm-m32r/ioctls.h	2006-08-03 
13:57:58.000000000 +0200
@@ -73,6 +73,11 @@
  #define TIOCSHAYESESP   0x545F  /* Set Hayes ESP configuration */
  #define FIOQSIZE	0x5460

+#define TIOCGTHROTTLE	_IOR('T',0x70, unsigned int)
+#define TIOCSTHROTTLE	_IOW('T',0x71, unsigned int)
+#define TIOCGUNTHROTTLE	_IOR('T',0x72, unsigned int)
+#define TIOCSUNTHROTTLE	_IOW('T',0x73, unsigned int)
+
  /* Used for packet mode */
  #define TIOCPKT_DATA		 0
  #define TIOCPKT_FLUSHREAD	 1
diff -uprN -X linux-2.6.16.orig//Documentation/dontdiff 
linux-2.6.16.tiny/include/asm-m68k/ioctls.h 
linux-2.6.16-throttle/include/asm-m68k/ioctls.h
--- linux-2.6.16.tiny/include/asm-m68k/ioctls.h	2006-03-20 
06:53:29.000000000 +0100
+++ linux-2.6.16-throttle/include/asm-m68k/ioctls.h	2006-08-03 
13:58:22.000000000 +0200
@@ -66,6 +66,11 @@
  #define TIOCGICOUNT	0x545D	/* read serial port inline interrupt counts */
  #define FIOQSIZE	0x545E

+#define TIOCGTHROTTLE	_IOR('T',0x70, unsigned int)
+#define TIOCSTHROTTLE	_IOW('T',0x71, unsigned int)
+#define TIOCGUNTHROTTLE	_IOR('T',0x72, unsigned int)
+#define TIOCSUNTHROTTLE	_IOW('T',0x73, unsigned int)
+
  /* Used for packet mode */
  #define TIOCPKT_DATA		 0
  #define TIOCPKT_FLUSHREAD	 1
diff -uprN -X linux-2.6.16.orig//Documentation/dontdiff 
linux-2.6.16.tiny/include/asm-mips/ioctls.h 
linux-2.6.16-throttle/include/asm-mips/ioctls.h
--- linux-2.6.16.tiny/include/asm-mips/ioctls.h	2006-03-20 
06:53:29.000000000 +0100
+++ linux-2.6.16-throttle/include/asm-mips/ioctls.h	2006-08-03 
13:59:18.000000000 +0200
@@ -80,6 +80,11 @@
  #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of 
pty-mux device) */
  #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */

+#define TIOCGTHROTTLE	_IOR('T',0x70, unsigned int)
+#define TIOCSTHROTTLE	_IOW('T',0x71, unsigned int)
+#define TIOCGUNTHROTTLE	_IOR('T',0x72, unsigned int)
+#define TIOCSUNTHROTTLE	_IOW('T',0x73, unsigned int)
+
  /* I hope the range from 0x5480 on is free ... */
  #define TIOCSCTTY	0x5480		/* become controlling tty */
  #define TIOCGSOFTCAR	0x5481
diff -uprN -X linux-2.6.16.orig//Documentation/dontdiff 
linux-2.6.16.tiny/include/asm-parisc/ioctls.h 
linux-2.6.16-throttle/include/asm-parisc/ioctls.h
--- linux-2.6.16.tiny/include/asm-parisc/ioctls.h	2006-03-20 
06:53:29.000000000 +0100
+++ linux-2.6.16-throttle/include/asm-parisc/ioctls.h	2006-08-03 
13:59:46.000000000 +0200
@@ -72,6 +72,11 @@
  #define TIOCSTOP	0x5462
  #define TIOCSLTC	0x5462

+#define TIOCGTHROTTLE	_IOR('T',0x70, unsigned int)
+#define TIOCSTHROTTLE	_IOW('T',0x71, unsigned int)
+#define TIOCGUNTHROTTLE	_IOR('T',0x72, unsigned int)
+#define TIOCSUNTHROTTLE	_IOW('T',0x73, unsigned int)
+
  /* Used for packet mode */
  #define TIOCPKT_DATA		 0
  #define TIOCPKT_FLUSHREAD	 1
diff -uprN -X linux-2.6.16.orig//Documentation/dontdiff 
linux-2.6.16.tiny/include/asm-powerpc/ioctls.h 
linux-2.6.16-throttle/include/asm-powerpc/ioctls.h
--- linux-2.6.16.tiny/include/asm-powerpc/ioctls.h	2006-03-20 
06:53:29.000000000 +0100
+++ linux-2.6.16-throttle/include/asm-powerpc/ioctls.h	2006-08-03 
14:00:15.000000000 +0200
@@ -107,4 +107,9 @@
  #define TIOCMIWAIT	0x545C	/* wait for a change on serial input line(s) */
  #define TIOCGICOUNT	0x545D	/* read serial port inline interrupt counts */

+#define TIOCGTHROTTLE	_IOR('T',0x70, unsigned int)
+#define TIOCSTHROTTLE	_IOW('T',0x71, unsigned int)
+#define TIOCGUNTHROTTLE	_IOR('T',0x72, unsigned int)
+#define TIOCSUNTHROTTLE	_IOW('T',0x73, unsigned int)
+
  #endif	/* _ASM_POWERPC_IOCTLS_H */
diff -uprN -X linux-2.6.16.orig//Documentation/dontdiff 
linux-2.6.16.tiny/include/asm-s390/ioctls.h 
linux-2.6.16-throttle/include/asm-s390/ioctls.h
--- linux-2.6.16.tiny/include/asm-s390/ioctls.h	2006-03-20 
06:53:29.000000000 +0100
+++ linux-2.6.16-throttle/include/asm-s390/ioctls.h	2006-08-03 
14:01:01.000000000 +0200
@@ -74,6 +74,11 @@
  #define TIOCGICOUNT	0x545D	/* read serial port inline interrupt counts */
  #define FIOQSIZE	0x545E

+#define TIOCGTHROTTLE	_IOR('T',0x70, unsigned int)
+#define TIOCSTHROTTLE	_IOW('T',0x71, unsigned int)
+#define TIOCGUNTHROTTLE	_IOR('T',0x72, unsigned int)
+#define TIOCSUNTHROTTLE	_IOW('T',0x73, unsigned int)
+
  /* Used for packet mode */
  #define TIOCPKT_DATA		 0
  #define TIOCPKT_FLUSHREAD	 1
diff -uprN -X linux-2.6.16.orig//Documentation/dontdiff 
linux-2.6.16.tiny/include/asm-sparc/ioctls.h 
linux-2.6.16-throttle/include/asm-sparc/ioctls.h
--- linux-2.6.16.tiny/include/asm-sparc/ioctls.h	2006-03-20 
06:53:29.000000000 +0100
+++ linux-2.6.16-throttle/include/asm-sparc/ioctls.h	2006-08-03 
14:01:50.000000000 +0200
@@ -111,6 +111,11 @@
  #define TIOCMIWAIT	0x545C /* Wait input */
  #define TIOCGICOUNT	0x545D /* Read serial port inline interrupt counts */

+#define TIOCGTHROTTLE	_IOR('T',0x70, unsigned int)
+#define TIOCSTHROTTLE	_IOW('T',0x71, unsigned int)
+#define TIOCGUNTHROTTLE	_IOR('T',0x72, unsigned int)
+#define TIOCSUNTHROTTLE	_IOW('T',0x73, unsigned int)
+
  /* Kernel definitions */
  #ifdef __KERNEL__
  #define TIOCGETC __TIOCGETC
diff -uprN -X linux-2.6.16.orig//Documentation/dontdiff 
linux-2.6.16.tiny/include/asm-sparc64/ioctls.h 
linux-2.6.16-throttle/include/asm-sparc64/ioctls.h
--- linux-2.6.16.tiny/include/asm-sparc64/ioctls.h	2006-03-20 
06:53:29.000000000 +0100
+++ linux-2.6.16-throttle/include/asm-sparc64/ioctls.h	2006-08-03 
14:02:15.000000000 +0200
@@ -112,6 +112,11 @@
  #define TIOCMIWAIT	0x545C /* Wait for change on serial input line(s) */
  #define TIOCGICOUNT	0x545D /* Read serial port inline interrupt counts */

+#define TIOCGTHROTTLE	_IOR('T',0x70, unsigned int)
+#define TIOCSTHROTTLE	_IOW('T',0x71, unsigned int)
+#define TIOCGUNTHROTTLE	_IOR('T',0x72, unsigned int)
+#define TIOCSUNTHROTTLE	_IOW('T',0x73, unsigned int)
+
  /* Kernel definitions */
  #ifdef __KERNEL__
  #define TIOCGETC __TIOCGETC
diff -uprN -X linux-2.6.16.orig//Documentation/dontdiff 
linux-2.6.16.tiny/include/asm-v850/ioctls.h 
linux-2.6.16-throttle/include/asm-v850/ioctls.h
--- linux-2.6.16.tiny/include/asm-v850/ioctls.h	2006-03-20 
06:53:29.000000000 +0100
+++ linux-2.6.16-throttle/include/asm-v850/ioctls.h	2006-08-03 
14:02:56.000000000 +0200
@@ -66,6 +66,11 @@
  #define TIOCGICOUNT	0x545D	/* read serial port inline interrupt counts */
  #define FIOQSIZE	0x545E

+#define TIOCGTHROTTLE	_IOR('T',0x70, unsigned int)
+#define TIOCSTHROTTLE	_IOW('T',0x71, unsigned int)
+#define TIOCGUNTHROTTLE	_IOR('T',0x72, unsigned int)
+#define TIOCSUNTHROTTLE	_IOW('T',0x73, unsigned int)
+
  /* Used for packet mode */
  #define TIOCPKT_DATA		 0
  #define TIOCPKT_FLUSHREAD	 1
diff -uprN -X linux-2.6.16.orig//Documentation/dontdiff 
linux-2.6.16.tiny/include/asm-x86_64/ioctls.h 
linux-2.6.16-throttle/include/asm-x86_64/ioctls.h
--- linux-2.6.16.tiny/include/asm-x86_64/ioctls.h	2006-03-20 
06:53:29.000000000 +0100
+++ linux-2.6.16-throttle/include/asm-x86_64/ioctls.h	2006-08-03 
14:03:23.000000000 +0200
@@ -68,6 +68,11 @@
  #define TIOCSHAYESESP   0x545F  /* Set Hayes ESP configuration */
  #define FIOQSIZE       0x5460

+#define TIOCGTHROTTLE	_IOR('T',0x70, unsigned int)
+#define TIOCSTHROTTLE	_IOW('T',0x71, unsigned int)
+#define TIOCGUNTHROTTLE	_IOR('T',0x72, unsigned int)
+#define TIOCSUNTHROTTLE	_IOW('T',0x73, unsigned int)
+
  /* Used for packet mode */
  #define TIOCPKT_DATA		 0
  #define TIOCPKT_FLUSHREAD	 1
diff -uprN -X linux-2.6.16.orig//Documentation/dontdiff 
linux-2.6.16.tiny/include/asm-xtensa/ioctls.h 
linux-2.6.16-throttle/include/asm-xtensa/ioctls.h
--- linux-2.6.16.tiny/include/asm-xtensa/ioctls.h	2006-03-20 
06:53:29.000000000 +0100
+++ linux-2.6.16-throttle/include/asm-xtensa/ioctls.h	2006-08-03 
14:04:00.000000000 +0200
@@ -94,6 +94,11 @@
  #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of 
pty-mux device) */
  #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */

+#define TIOCGTHROTTLE	_IOR('T',0x70, unsigned int)
+#define TIOCSTHROTTLE	_IOW('T',0x71, unsigned int)
+#define TIOCGUNTHROTTLE	_IOR('T',0x72, unsigned int)
+#define TIOCSUNTHROTTLE	_IOW('T',0x73, unsigned int)
+
  #define TIOCSERCONFIG	_IO('T', 83)
  #define TIOCSERGWILD	_IOR('T', 84,  int)
  #define TIOCSERSWILD	_IOW('T', 85,  int)
diff -uprN -X linux-2.6.16.orig//Documentation/dontdiff 
linux-2.6.16.tiny/include/linux/tty.h 
linux-2.6.16-throttle/include/linux/tty.h
--- linux-2.6.16.tiny/include/linux/tty.h	2006-03-20 06:53:29.000000000 
+0100
+++ linux-2.6.16-throttle/include/linux/tty.h	2006-08-03 
14:15:48.000000000 +0200
@@ -238,6 +238,10 @@ struct tty_struct {
  	spinlock_t read_lock;
  	/* If the tty has a pending do_SAK, queue it here - akpm */
  	struct work_struct SAK_work;
+	
+	/* dynamic throttle support */
+	unsigned int threshold_throttle;
+	unsigned int threshold_unthrottle;
  };

  /* tty magic number */



