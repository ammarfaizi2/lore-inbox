Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262511AbUCRKxk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 05:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262515AbUCRKxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 05:53:39 -0500
Received: from moutng.kundenserver.de ([212.227.126.176]:41705 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262511AbUCRKxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 05:53:32 -0500
Date: Thu, 18 Mar 2004 11:53:25 +0100 (MET)
From: Armin Schindler <armin@melware.de>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morten <akpm@osdl.org>
Subject: [PATCH 2.6] serialization of kernelcapi work
Message-ID: <Pine.LNX.4.31.0403181117350.10499-100000@phoenix.one.melware.de>
Organization: Cytronics & Melware
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:4f0aeee4703bc17a8237042c4702a75a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

the ISDN kernelcapi function recv_handler() is triggered by
schedule_work() and dispatches the CAPI messages to the applications.

Since a workqueue function may run on another CPU at the same time,
reordering of CAPI messages may occur.

For serialization I suggest a mutex semaphore in recv_handler(),
patch is appended (yet untested).

Is there a better way to do user-context work serialized ?

Armin


--- linux/drivers/isdn/capi/kcapi.c	16 Mar 2004 08:01:47 -0000
+++ linux/drivers/isdn/capi/kcapi.c	18 Mar 2004 10:41:38 -0000
@@ -70,6 +70,7 @@
 static struct sk_buff_head recv_queue;

 static struct work_struct tq_recv_notify;
+static DECLARE_MUTEX(recv_handler_lock);

 /* -------- controller ref counting -------------------------------------- */

@@ -242,6 +243,8 @@
 	struct sk_buff *skb;
 	struct capi20_appl *ap;

+	down(&recv_handler_lock);
+
 	while ((skb = skb_dequeue(&recv_queue)) != 0) {
 		ap = get_capi_appl_by_nr(CAPIMSG_APPID(skb->data));
 		if (!ap) {
@@ -257,6 +260,8 @@
 			ap->nrecvctlpkt++;
 		ap->recv_message(ap, skb);
 	}
+
+	up(&recv_handler_lock);
 }

 void capi_ctr_handle_message(struct capi_ctr * card, u16 appl, struct sk_buff *skb)


