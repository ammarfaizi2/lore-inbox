Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262164AbSJJTLQ>; Thu, 10 Oct 2002 15:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262165AbSJJTLP>; Thu, 10 Oct 2002 15:11:15 -0400
Received: from www.microgate.com ([216.30.46.105]:29450 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP
	id <S262164AbSJJTK2>; Thu, 10 Oct 2002 15:10:28 -0400
Subject: [PATCH] n_hdlc.c 2.5.41
From: Paul Fulghum <paulkf@microgate.com>
To: "davej@suse.de" <davej@suse.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.4 
Date: 10 Oct 2002 14:16:17 -0500
Message-Id: <1034277377.785.13.camel@diemos.microgate.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Remove cli()/restore()
* Fix memory leak

Please apply

Paul Fulghum
paulkf@microgate.com


--- linux-2.5.41/drivers/char/n_hdlc.c	Thu Oct 10 09:56:24 2002
+++ linux-2.5.41-mg/drivers/char/n_hdlc.c	Thu Oct 10 09:56:04 2002
@@ -9,7 +9,7 @@
  *	Al Longyear <longyear@netcom.com>, Paul Mackerras <Paul.Mackerras@cs.anu.edu.au>
  *
  * Original release 01/11/99
- * $Id: n_hdlc.c,v 4.1 2002/04/10 19:30:58 paulkf Exp $
+ * $Id: n_hdlc.c,v 4.2 2002/10/10 14:52:41 paulkf Exp $
  *
  * This code is released under the GNU General Public License (GPL)
  *
@@ -78,7 +78,7 @@
  */
 
 #define HDLC_MAGIC 0x239e
-#define HDLC_VERSION "$Revision: 4.1 $"
+#define HDLC_VERSION "$Revision: 4.2 $"
 
 #include <linux/version.h>
 #include <linux/config.h>
@@ -264,7 +264,8 @@
 		} else
 			break;
 	}
-	
+	if (n_hdlc->tbuf)
+		kfree(n_hdlc->tbuf);
 	kfree(n_hdlc);
 	
 }	/* end of n_hdlc_release() */
@@ -381,16 +382,15 @@
 		printk("%s(%d)n_hdlc_send_frames() called\n",__FILE__,__LINE__);
  check_again:
 		
-	save_flags(flags);
-	cli ();
+ 	spin_lock_irqsave(&n_hdlc->tx_buf_list.spinlock, flags);
 	if (n_hdlc->tbusy) {
 		n_hdlc->woke_up = 1;
-		restore_flags(flags);
+ 		spin_unlock_irqrestore(&n_hdlc->tx_buf_list.spinlock, flags);
 		return;
 	}
 	n_hdlc->tbusy = 1;
 	n_hdlc->woke_up = 0;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&n_hdlc->tx_buf_list.spinlock, flags);
 
 	/* get current transmit buffer or get new transmit */
 	/* buffer from list of pending transmit buffers */
@@ -445,10 +445,9 @@
 		tty->flags  &= ~(1 << TTY_DO_WRITE_WAKEUP);
 	
 	/* Clear the re-entry flag */
-	save_flags(flags);
-	cli ();
+	spin_lock_irqsave(&n_hdlc->tx_buf_list.spinlock, flags);
 	n_hdlc->tbusy = 0;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&n_hdlc->tx_buf_list.spinlock, flags); 
 	
         if (n_hdlc->woke_up)
 	  goto check_again;



