Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262336AbTESE1a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 00:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbTESE1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 00:27:30 -0400
Received: from dp.samba.org ([66.70.73.150]:41116 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262336AbTESE12 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 00:27:28 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16072.24604.834386.374479@argo.ozlabs.ibm.com>
Date: Mon, 19 May 2003 14:39:56 +1000
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: [PATCH] module owner for ppp_synctty.c
X-Mailer: VM 7.15 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes ppp_synctty.c (used for doing PPP over some synchronous
serial HDLC links) so that it sets the owner field of the tty line
discipline it exports, rather than using MOD_INC/DEC_USE_COUNT.  This
is more or less from Stephen Hemminger.

Please apply.

Thanks,
Paul.

diff -urN linux-2.5/drivers/net/ppp_synctty.c pmac-2.5/drivers/net/ppp_synctty.c
--- linux-2.5/drivers/net/ppp_synctty.c	2003-04-25 09:17:22.000000000 +1000
+++ pmac-2.5/drivers/net/ppp_synctty.c	2003-04-27 17:58:13.000000000 +1000
@@ -202,7 +202,6 @@
 	struct syncppp *ap;
 	int err;
 
-	MOD_INC_USE_COUNT;
 	ap = kmalloc(sizeof(*ap), GFP_KERNEL);
 	err = -ENOMEM;
 	if (ap == 0)
@@ -236,7 +235,6 @@
  out_free:
 	kfree(ap);
  out:
-	MOD_DEC_USE_COUNT;
 	return err;
 }
 
@@ -276,7 +274,6 @@
 	if (ap->tpkt != 0)
 		kfree_skb(ap->tpkt);
 	kfree(ap);
-	MOD_DEC_USE_COUNT;
 }
 
 /*
@@ -404,6 +401,7 @@
 
 
 static struct tty_ldisc ppp_sync_ldisc = {
+	.owner	= THIS_MODULE,
 	.magic	= TTY_LDISC_MAGIC,
 	.name	= "pppsync",
 	.open	= ppp_sync_open,
