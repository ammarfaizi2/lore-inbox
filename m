Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265059AbTIDOh2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 10:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265085AbTIDOhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 10:37:14 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:63543 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S265067AbTIDOfD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 10:35:03 -0400
Subject: [PATCH] n_hdlc.c 2.4.23-pre3
From: Paul Fulghum <paulkf@microgate.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1062686054.2183.12.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 04 Sep 2003 09:34:14 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* make global vars static
* fix memory leak

please apply

-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com


--- linux-2.4.23-pre3/drivers/char/n_hdlc.c	2002-02-25 13:37:57.000000000 -0600
+++ linux-2.4.23-pre3-mg/drivers/char/n_hdlc.c	2003-09-04 09:17:06.000000000 -0500
@@ -9,7 +9,7 @@
  *	Al Longyear <longyear@netcom.com>, Paul Mackerras <Paul.Mackerras@cs.anu.edu.au>
  *
  * Original release 01/11/99
- * $Id: n_hdlc.c,v 3.3 2001/11/08 16:16:03 paulkf Exp $
+ * $Id: n_hdlc.c,v 3.7 2003/05/01 15:45:29 paulkf Exp $
  *
  * This code is released under the GNU General Public License (GPL)
  *
@@ -78,7 +78,7 @@
  */
 
 #define HDLC_MAGIC 0x239e
-#define HDLC_VERSION "$Revision: 3.3 $"
+#define HDLC_VERSION "$Revision: 3.7 $"
 
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
 
@@ -183,13 +183,16 @@
 MODULE_PARM(debuglevel, "i");
 MODULE_PARM(maxframe, "i");
 
+#ifdef MODULE_LICENSE
+MODULE_LICENSE("GPL");
+#endif
 
 /* debug level can be set by insmod for debugging purposes */
 #define DEBUG_LEVEL_INFO	1
-int debuglevel=0;
+static int debuglevel=0;
 
 /* max frame size for memory allocations */
-ssize_t	maxframe=4096;
+static ssize_t	maxframe=4096;
 
 /* TTY callbacks */
 
@@ -265,7 +268,8 @@
 		} else
 			break;
 	}
-	
+	if (n_hdlc->tbuf)
+		kfree(n_hdlc->tbuf);
 	kfree(n_hdlc);
 	
 }	/* end of n_hdlc_release() */
@@ -905,7 +909,7 @@
  * Arguments:	 	list	pointer to buffer list
  * Return Value:	None	
  */
-void n_hdlc_buf_list_init(N_HDLC_BUF_LIST *list)
+static void n_hdlc_buf_list_init(N_HDLC_BUF_LIST *list)
 {
 	memset(list,0,sizeof(N_HDLC_BUF_LIST));
 	spin_lock_init(&list->spinlock);
@@ -922,7 +926,7 @@
  * 
  * Return Value:	None	
  */
-void n_hdlc_buf_put(N_HDLC_BUF_LIST *list,N_HDLC_BUF *buf)
+static void n_hdlc_buf_put(N_HDLC_BUF_LIST *list,N_HDLC_BUF *buf)
 {
 	unsigned long flags;
 	spin_lock_irqsave(&list->spinlock,flags);
@@ -952,7 +956,7 @@
  * 
  * 	pointer to HDLC buffer if available, otherwise NULL
  */
-N_HDLC_BUF* n_hdlc_buf_get(N_HDLC_BUF_LIST *list)
+static N_HDLC_BUF* n_hdlc_buf_get(N_HDLC_BUF_LIST *list)
 {
 	unsigned long flags;
 	N_HDLC_BUF *buf;
@@ -1025,5 +1029,4 @@
 module_init(n_hdlc_init);
 module_exit(n_hdlc_exit);
 
-MODULE_LICENSE("GPL");
 EXPORT_NO_SYMBOLS;



