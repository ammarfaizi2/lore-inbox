Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbTEEWmZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 18:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbTEEWmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 18:42:25 -0400
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:11407 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S261919AbTEEWmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 18:42:21 -0400
Date: Mon, 5 May 2003 18:53:30 -0400
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Message-Id: <200305052253.h45MrUTj020679@locutus.cmf.nrl.navy.mil>
To: davem@redhat.com
Subject: [PATCH][ATM] svc's possibly race with sigd
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pretty sure the author wanted the wait queues in place before
talking to sigd which might cause a wakeup on the vcc in question.
this race is VERY unlikely, since going down to user space and back
is quite slow.

--- linux-2.5.68/net/atm/svc.c.000	Mon May  5 18:31:34 2003
+++ linux-2.5.68/net/atm/svc.c	Mon May  5 18:33:04 2003
@@ -64,8 +64,8 @@
 
 	DPRINTK("svc_disconnect %p\n",vcc);
 	if (test_bit(ATM_VF_REGIS,&vcc->flags)) {
-		sigd_enq(vcc,as_close,NULL,NULL,NULL);
 		add_wait_queue(&vcc->sleep,&wait);
+		sigd_enq(vcc,as_close,NULL,NULL,NULL);
 		while (!test_bit(ATM_VF_RELEASED,&vcc->flags) && sigd) {
 			set_current_state(TASK_UNINTERRUPTIBLE);
 			schedule();
@@ -124,8 +124,8 @@
 	if (!test_bit(ATM_VF_HASQOS,&vcc->flags)) return -EBADFD;
 	vcc->local = *addr;
 	vcc->reply = WAITING;
-	sigd_enq(vcc,as_bind,NULL,NULL,&vcc->local);
 	add_wait_queue(&vcc->sleep,&wait);
+	sigd_enq(vcc,as_bind,NULL,NULL,&vcc->local);
 	while (vcc->reply == WAITING && sigd) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule();
@@ -169,12 +169,13 @@
 		    !vcc->qos.rxtp.traffic_class) return -EINVAL;
 		vcc->remote = *addr;
 		vcc->reply = WAITING;
+		add_wait_queue(&vcc->sleep,&wait);
 		sigd_enq(vcc,as_connect,NULL,NULL,&vcc->remote);
 		if (flags & O_NONBLOCK) {
+			remove_wait_queue(&vcc->sleep,&wait);
 			sock->state = SS_CONNECTING;
 			return -EINPROGRESS;
 		}
-		add_wait_queue(&vcc->sleep,&wait);
 		error = 0;
 		while (vcc->reply == WAITING && sigd) {
 			set_current_state(TASK_INTERRUPTIBLE);
@@ -243,8 +244,8 @@
 	/* let server handle listen on unbound sockets */
 	if (test_bit(ATM_VF_SESSION,&vcc->flags)) return -EINVAL;
 	vcc->reply = WAITING;
-	sigd_enq(vcc,as_listen,NULL,NULL,&vcc->local);
 	add_wait_queue(&vcc->sleep,&wait);
+	sigd_enq(vcc,as_listen,NULL,NULL,&vcc->local);
 	while (vcc->reply == WAITING && sigd) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule();
@@ -313,8 +314,8 @@
 		}
 		/* wait should be short, so we ignore the non-blocking flag */
 		new_vcc->reply = WAITING;
-		sigd_enq(new_vcc,as_accept,old_vcc,NULL,NULL);
 		add_wait_queue(&new_vcc->sleep,&wait);
+		sigd_enq(new_vcc,as_accept,old_vcc,NULL,NULL);
 		while (new_vcc->reply == WAITING && sigd) {
 			set_current_state(TASK_UNINTERRUPTIBLE);
 			schedule();
@@ -347,8 +348,8 @@
 	DECLARE_WAITQUEUE(wait,current);
 
 	vcc->reply = WAITING;
-	sigd_enq2(vcc,as_modify,NULL,NULL,&vcc->local,qos,0);
 	add_wait_queue(&vcc->sleep,&wait);
+	sigd_enq2(vcc,as_modify,NULL,NULL,&vcc->local,qos,0);
 	while (vcc->reply == WAITING && !test_bit(ATM_VF_RELEASED,&vcc->flags)
 	    && sigd) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
