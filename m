Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262284AbTDUVBL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 17:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbTDUVBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 17:01:11 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:41022 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S262284AbTDUVBI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 17:01:08 -0400
Subject: [PATCH] n_hdlc.c 2.5.68 (try 3)
From: Paul Fulghum <paulkf@microgate.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>,
       "torvalds@transmeta.com" <torvalds@transmeta.com>
In-Reply-To: <20030421204200.A12475@infradead.org>
References: <1050952852.1841.41.camel@diemos>
	 <20030421204200.A12475@infradead.org>
Content-Type: text/plain
Organization: 
Message-Id: <1050959551.1506.5.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 21 Apr 2003 16:12:32 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-04-21 at 14:42, Christoph Hellwig wrote:

> .oO(I guess you'll have me for moaning again, but..)

You dirty bastard :-)

* Remove MODULE_USE_COUNT macros
* add owner member to struct tty_ldisc
* init tty_ldisc using C99 initializers
* make some functions static

-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com

--- linux-2.5.68/drivers/char/n_hdlc.c	2003-04-07 12:30:59.000000000 -0500
+++ linux-2.5.68-mg/drivers/char/n_hdlc.c	2003-04-21 16:05:04.768636536 -0500
@@ -9,7 +9,7 @@
  *	Al Longyear <longyear@netcom.com>, Paul Mackerras <Paul.Mackerras@cs.anu.edu.au>
  *
  * Original release 01/11/99
- * $Id: n_hdlc.c,v 4.2 2002/10/10 14:52:41 paulkf Exp $
+ * $Id: n_hdlc.c,v 4.7 2003/04/21 21:03:41 paulkf Exp $
  *
  * This code is released under the GNU General Public License (GPL)
  *
@@ -78,7 +78,7 @@
  */
 
 #define HDLC_MAGIC 0x239e
-#define HDLC_VERSION "$Revision: 4.2 $"
+#define HDLC_VERSION "$Revision: 4.7 $"
 
 #include <linux/version.h>
 #include <linux/config.h>
@@ -171,9 +171,9 @@
 /*
  * HDLC buffer list manipulation functions
  */
-void n_hdlc_buf_list_init(N_HDLC_BUF_LIST *list);
-void n_hdlc_buf_put(N_HDLC_BUF_LIST *list,N_HDLC_BUF *buf);
-N_HDLC_BUF* n_hdlc_buf_get(N_HDLC_BUF_LIST *list);
+static void n_hdlc_buf_list_init(N_HDLC_BUF_LIST *list);
+static void n_hdlc_buf_put(N_HDLC_BUF_LIST *list,N_HDLC_BUF *buf);
+static N_HDLC_BUF* n_hdlc_buf_get(N_HDLC_BUF_LIST *list);
 
 /* Local functions */
 
@@ -215,6 +215,21 @@
 /* Define this string only once for all macro invocations */
 static char szVersion[] = HDLC_VERSION;
 
+static struct tty_ldisc n_hdlc_ldisc = {
+	.owner		= THIS_MODULE,
+	.magic		= TTY_LDISC_MAGIC,
+	.name		= "hdlc",
+	.open		= n_hdlc_tty_open,
+	.close		= n_hdlc_tty_close,
+	.read		= n_hdlc_tty_read,
+	.write		= n_hdlc_tty_write,
+	.ioctl		= n_hdlc_tty_ioctl,
+	.poll		= n_hdlc_tty_poll,
+	.receive_buf	= n_hdlc_tty_receive,
+	.receive_room	= n_hdlc_tty_room,
+	.write_wakeup	= n_hdlc_tty_wakeup,
+};
+
 /* n_hdlc_release()
  *
  *	release an n_hdlc per device line discipline info structure
@@ -299,7 +314,6 @@
 			n_hdlc->tty = n_hdlc->backup_tty;
 		} else {
 			n_hdlc_release (n_hdlc);
-			MOD_DEC_USE_COUNT;
 		}
 	}
 	
@@ -339,8 +353,6 @@
 	tty->disc_data = n_hdlc;
 	n_hdlc->tty    = tty;
 	
-	MOD_INC_USE_COUNT;
-	
 #if defined(TTY_NO_WRITE_SPLIT)
 	/* change tty_io write() to not split large writes into 8K chunks */
 	set_bit(TTY_NO_WRITE_SPLIT,&tty->flags);
@@ -903,7 +915,7 @@
  * Arguments:	 	list	pointer to buffer list
  * Return Value:	None	
  */
-void n_hdlc_buf_list_init(N_HDLC_BUF_LIST *list)
+static void n_hdlc_buf_list_init(N_HDLC_BUF_LIST *list)
 {
 	memset(list,0,sizeof(N_HDLC_BUF_LIST));
 	spin_lock_init(&list->spinlock);
@@ -920,7 +932,7 @@
  * 
  * Return Value:	None	
  */
-void n_hdlc_buf_put(N_HDLC_BUF_LIST *list,N_HDLC_BUF *buf)
+static void n_hdlc_buf_put(N_HDLC_BUF_LIST *list,N_HDLC_BUF *buf)
 {
 	unsigned long flags;
 	spin_lock_irqsave(&list->spinlock,flags);
@@ -950,7 +962,7 @@
  * 
  * 	pointer to HDLC buffer if available, otherwise NULL
  */
-N_HDLC_BUF* n_hdlc_buf_get(N_HDLC_BUF_LIST *list)
+static N_HDLC_BUF* n_hdlc_buf_get(N_HDLC_BUF_LIST *list)
 {
 	unsigned long flags;
 	N_HDLC_BUF *buf;
@@ -971,7 +983,6 @@
 
 static int __init n_hdlc_init(void)
 {
-	static struct tty_ldisc	n_hdlc_ldisc;
 	int    status;
 
 	/* range check maxframe arg */
@@ -983,21 +994,6 @@
 	printk("HDLC line discipline: version %s, maxframe=%u\n", 
 		szVersion, maxframe);
 
-	/* Register the tty discipline */
-	
-	memset(&n_hdlc_ldisc, 0, sizeof (n_hdlc_ldisc));
-	n_hdlc_ldisc.magic		= TTY_LDISC_MAGIC;
-	n_hdlc_ldisc.name          	= "hdlc";
-	n_hdlc_ldisc.open		= n_hdlc_tty_open;
-	n_hdlc_ldisc.close		= n_hdlc_tty_close;
-	n_hdlc_ldisc.read		= n_hdlc_tty_read;
-	n_hdlc_ldisc.write		= n_hdlc_tty_write;
-	n_hdlc_ldisc.ioctl		= n_hdlc_tty_ioctl;
-	n_hdlc_ldisc.poll		= n_hdlc_tty_poll;
-	n_hdlc_ldisc.receive_room	= n_hdlc_tty_room;
-	n_hdlc_ldisc.receive_buf	= n_hdlc_tty_receive;
-	n_hdlc_ldisc.write_wakeup	= n_hdlc_tty_wakeup;
-
 	status = tty_register_ldisc(N_HDLC, &n_hdlc_ldisc);
 	if (!status)
 		printk (KERN_INFO"N_HDLC line discipline registered.\n");



