Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131906AbRAOGzP>; Mon, 15 Jan 2001 01:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132056AbRAOGzG>; Mon, 15 Jan 2001 01:55:06 -0500
Received: from linuxcare.com.au ([203.29.91.49]:52230 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S131906AbRAOGyw>; Mon, 15 Jan 2001 01:54:52 -0500
From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14946.40642.426432.698066@diego.linuxcare.com.au>
Date: Mon, 15 Jan 2001 17:54:58 +1100 (EST)
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
CC: Mike Galbraith <mikeg@wen-online.de>, Alvaro Lopes <alvieboy@alvie.com>
Subject: [PATCH] fix for ppp_async lockup in 2.4.0
X-Mailer: VM 6.75 under Emacs 20.4.1
Reply-To: paulus@linuxcare.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch fixes the lockup inside ppp_async_push which
can occur if you set both the master and slave of a pty to PPP line
discipline.

The patch essentially makes 3 changes to ppp_async.c:

1. We detect the recursion that can occur if the tty driver's write
   function calls back to the PPP line discipline's wakeup function,
   using a bit in the xmit_flags word.  In this case, ppp_async_push
   just sets a bit to say that the wakeup occurred and returns.

2. The stuff that used spin_trylock_bh now uses spin_lock_bh instead.
   The code is a little simpler and clearer now and I have added more
   comments to explain what's going on.

3. I have taken out the stuff in ppp_async that let you send and
   receive PPP frames by reading and writing the tty.  This was only
   compatibility stuff which the current pppd never needs.  Having it
   there doesn't help anything; taking it out means that the exploit
   that was published can't even get to first base.

Paul.

diff -urN linux/drivers/net/ppp_async.c pmac/drivers/net/ppp_async.c
--- linux/drivers/net/ppp_async.c	Sat Apr 22 06:31:10 2000
+++ pmac/drivers/net/ppp_async.c	Mon Jan 15 17:49:28 2001
@@ -33,13 +33,6 @@
 #include <linux/init.h>
 #include <asm/uaccess.h>
 
-#ifndef spin_trylock_bh
-#define spin_trylock_bh(lock)	({ int __r; local_bh_disable();	\
-				   __r = spin_trylock(lock);	\
-				   if (!__r) local_bh_enable();	\
-				   __r; })
-#endif
-
 #define PPP_VERSION	"2.4.1"
 
 #define OBUFSIZE	256
@@ -76,6 +69,7 @@
 /* Bit numbers in xmit_flags */
 #define XMIT_WAKEUP	0
 #define XMIT_FULL	1
+#define XMIT_BUSY	2
 
 /* State bits */
 #define SC_TOSS		0x20000000
@@ -181,18 +175,14 @@
 }
 
 /*
- * Read does nothing.
+ * Read does nothing - no data is ever available this way.
+ * Pppd reads and writes packets via /dev/ppp instead.
  */
 static ssize_t
 ppp_asynctty_read(struct tty_struct *tty, struct file *file,
 		  unsigned char *buf, size_t count)
 {
-	/* For now, do the same as the old 2.3.x code useta */
-	struct asyncppp *ap = tty->disc_data;
-
-	if (ap == 0)
-		return -ENXIO;
-	return ppp_channel_read(&ap->chan, file, buf, count);
+	return -EAGAIN;
 }
 
 /*
@@ -203,12 +193,7 @@
 ppp_asynctty_write(struct tty_struct *tty, struct file *file,
 		   const unsigned char *buf, size_t count)
 {
-	/* For now, do the same as the old 2.3.x code useta */
-	struct asyncppp *ap = tty->disc_data;
-
-	if (ap == 0)
-		return -ENXIO;
-	return ppp_channel_write(&ap->chan, buf, count);
+	return -EAGAIN;
 }
 
 static int
@@ -259,25 +244,6 @@
 		err = 0;
 		break;
 
-/*
- * For now, do the same as the old 2.3 driver useta
- */
-	case PPPIOCGFLAGS:
-	case PPPIOCSFLAGS:
-	case PPPIOCGASYNCMAP:
-	case PPPIOCSASYNCMAP:
-	case PPPIOCGRASYNCMAP:
-	case PPPIOCSRASYNCMAP:
-	case PPPIOCGXASYNCMAP:
-	case PPPIOCSXASYNCMAP:
-	case PPPIOCGMRU:
-	case PPPIOCSMRU:
-		err = -EPERM;
-		if (!capable(CAP_NET_ADMIN))
-			break;
-		err = ppp_async_ioctl(&ap->chan, cmd, arg);
-		break;
-
 	case PPPIOCATTACH:
 	case PPPIOCDETACH:
 		err = ppp_channel_ioctl(&ap->chan, cmd, arg);
@@ -294,18 +260,7 @@
 static unsigned int
 ppp_asynctty_poll(struct tty_struct *tty, struct file *file, poll_table *wait)
 {
-	unsigned int mask;
-	struct asyncppp *ap = tty->disc_data;
-
-	mask = POLLOUT | POLLWRNORM;
-/*
- * For now, do the same as the old 2.3 driver useta
- */
-	if (ap != 0)
-		mask |= ppp_channel_poll(&ap->chan, file, wait);
-	if (test_bit(TTY_OTHER_CLOSED, &tty->flags) || tty_hung_up_p(file))
-		mask |= POLLHUP;
-	return mask;
+	return 0;
 }
 
 static int
@@ -637,8 +592,18 @@
 	int tty_stuffed = 0;
 
 	set_bit(XMIT_WAKEUP, &ap->xmit_flags);
-	if (!spin_trylock_bh(&ap->xmit_lock))
+	/*
+	 * We can get called recursively here if the tty write
+	 * function calls our wakeup function.  This can happen
+	 * for example on a pty with both the master and slave
+	 * set to PPP line discipline.
+	 * We use the XMIT_BUSY bit to detect this and get out,
+	 * leaving the XMIT_WAKEUP bit set to tell the other
+	 * instance that it may now be able to write more now.
+	 */
+	if (test_and_set_bit(XMIT_BUSY, &ap->xmit_flags))
 		return 0;
+	spin_lock_bh(&ap->xmit_lock);
 	for (;;) {
 		if (test_and_clear_bit(XMIT_WAKEUP, &ap->xmit_flags))
 			tty_stuffed = 0;
@@ -653,7 +618,7 @@
 				tty_stuffed = 1;
 			continue;
 		}
-		if (ap->optr == ap->olim && ap->tpkt != 0) {
+		if (ap->optr >= ap->olim && ap->tpkt != 0) {
 			if (ppp_async_encode(ap)) {
 				/* finished processing ap->tpkt */
 				clear_bit(XMIT_FULL, &ap->xmit_flags);
@@ -661,17 +626,29 @@
 			}
 			continue;
 		}
-		/* haven't made any progress */
-		spin_unlock_bh(&ap->xmit_lock);
+		/*
+		 * We haven't made any progress this time around.
+		 * Clear XMIT_BUSY to let other callers in, but
+		 * after doing so we have to check if anyone set
+		 * XMIT_WAKEUP since we last checked it.  If they
+		 * did, we should try again to set XMIT_BUSY and go
+		 * around again in case XMIT_BUSY was still set when
+		 * the other caller tried.
+		 */
+		clear_bit(XMIT_BUSY, &ap->xmit_flags);
+		/* any more work to do? if not, exit the loop */
 		if (!(test_bit(XMIT_WAKEUP, &ap->xmit_flags)
 		      || (!tty_stuffed && ap->tpkt != 0)))
 			break;
-		if (!spin_trylock_bh(&ap->xmit_lock))
+		/* more work to do, see if we can do it now */
+		if (test_and_set_bit(XMIT_BUSY, &ap->xmit_flags))
 			break;
 	}
+	spin_unlock_bh(&ap->xmit_lock);
 	return done;
 
 flush:
+	clear_bit(XMIT_BUSY, &ap->xmit_flags);
 	if (ap->tpkt != 0) {
 		kfree_skb(ap->tpkt);
 		ap->tpkt = 0;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
