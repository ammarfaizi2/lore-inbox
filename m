Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267151AbSLSUdo>; Thu, 19 Dec 2002 15:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267135AbSLSUdo>; Thu, 19 Dec 2002 15:33:44 -0500
Received: from www.microgate.com ([216.30.46.105]:55301 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP
	id <S267151AbSLSUdl>; Thu, 19 Dec 2002 15:33:41 -0500
Subject: [PATCH] 2.4.20 n_hdlc.c
From: Paul Fulghum <paulkf@microgate.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "marcelo@conectiva.com.br" <marcelo@conectiva.com.br>,
       "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.4 
Date: 19 Dec 2002 14:41:18 -0600
Message-Id: <1040330478.947.5.camel@diemos.microgate.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make global func/var static to avoid namespace polution.
Fix memory leak.

--- linux-2.4.20/drivers/char/n_hdlc.c	Mon Feb 25 13:37:57 2002
+++ linux-2.4.20-mg/drivers/char/n_hdlc.c	Thu Dec 19 12:01:09 2002
@@ -9,7 +9,7 @@
  *	Al Longyear <longyear@netcom.com>, Paul Mackerras <Paul.Mackerras@cs.anu.edu.au>
  *
  * Original release 01/11/99
- * $Id: n_hdlc.c,v 3.3 2001/11/08 16:16:03 paulkf Exp $
+ * $Id: n_hdlc.c,v 3.6 2002/12/19 18:58:56 paulkf Exp $
  *
  * This code is released under the GNU General Public License (GPL)
  *
@@ -78,7 +78,7 @@
  */
 
 #define HDLC_MAGIC 0x239e
-#define HDLC_VERSION "$Revision: 3.3 $"
+#define HDLC_VERSION "$Revision: 3.6 $"
 
 #include <linux/version.h>
 #include <linux/config.h>
@@ -172,9 +172,9 @@
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
 
@@ -186,10 +186,10 @@
 
 /* debug level can be set by insmod for debugging purposes */
 #define DEBUG_LEVEL_INFO	1
-int debuglevel=0;
+static int debuglevel=0;
 
 /* max frame size for memory allocations */
-ssize_t	maxframe=4096;
+static ssize_t	maxframe=4096;
 
 /* TTY callbacks */
 
@@ -265,7 +265,8 @@
 		} else
 			break;
 	}
-	
+	if (n_hdlc->tbuf)
+		kfree(n_hdlc->tbuf);
 	kfree(n_hdlc);
 	
 }	/* end of n_hdlc_release() */
@@ -905,7 +906,7 @@
  * Arguments:	 	list	pointer to buffer list
  * Return Value:	None	
  */
-void n_hdlc_buf_list_init(N_HDLC_BUF_LIST *list)
+static void n_hdlc_buf_list_init(N_HDLC_BUF_LIST *list)
 {
 	memset(list,0,sizeof(N_HDLC_BUF_LIST));
 	spin_lock_init(&list->spinlock);
@@ -922,7 +923,7 @@
  * 
  * Return Value:	None	
  */
-void n_hdlc_buf_put(N_HDLC_BUF_LIST *list,N_HDLC_BUF *buf)
+static void n_hdlc_buf_put(N_HDLC_BUF_LIST *list,N_HDLC_BUF *buf)
 {
 	unsigned long flags;
 	spin_lock_irqsave(&list->spinlock,flags);
@@ -952,7 +953,7 @@
  * 
  * 	pointer to HDLC buffer if available, otherwise NULL
  */
-N_HDLC_BUF* n_hdlc_buf_get(N_HDLC_BUF_LIST *list)
+static N_HDLC_BUF* n_hdlc_buf_get(N_HDLC_BUF_LIST *list)
 {
 	unsigned long flags;
 	N_HDLC_BUF *buf;



