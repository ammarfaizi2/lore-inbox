Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262102AbTEGANz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 20:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbTEGANz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 20:13:55 -0400
Received: from relax.cmf.nrl.navy.mil ([134.207.10.227]:1152 "EHLO
	relax.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S262102AbTEGANv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 20:13:51 -0400
Date: Tue, 6 May 2003 20:26:25 -0400
From: chas williams <chas@cmf.nrl.navy.mil>
Message-Id: <200305070026.h470QP503306@relax.cmf.nrl.navy.mil>
To: davem@redhat.com
Subject: [PATCH][ATM] clip locking and more atmvcc cleanup
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ATM]: clip should lock the individual table entires

--- linux-2.5.68/net/atm/clip.c.000	Tue May  6 10:31:24 2003
+++ linux-2.5.68/net/atm/clip.c	Tue May  6 10:34:02 2003
@@ -127,6 +127,8 @@
 			struct atmarp_entry *entry = NEIGH2ENTRY(n);
 			struct clip_vcc *clip_vcc;
 
+			write_lock(&n->lock);
+
 			for (clip_vcc = entry->vccs; clip_vcc;
 			    clip_vcc = clip_vcc->next)
 				if (clip_vcc->idle_timeout &&
@@ -141,6 +143,7 @@
 			if (entry->vccs ||
 			    time_before(jiffies, entry->expires)) {
 				np = &n->next;
+				write_unlock(&n->lock);
 				continue;
 			}
 			if (atomic_read(&n->refcnt) > 1) {
@@ -152,11 +155,13 @@
 				     NULL) 
 					dev_kfree_skb(skb);
 				np = &n->next;
+				write_unlock(&n->lock);
 				continue;
 			}
 			*np = n->next;
 			DPRINTK("expired neigh %p\n",n);
 			n->dead = 1;
+			write_unlock(&n->lock);
 			neigh_release(n);
 		}
 	}




[ATM]: listenq and backlog are redundant with existing sk members
       (a 'listen' socket never recv's data so you dont typically
       need a seperate listenq -- even for atm)

--- linux-2.5.68/include/linux/atmdev.h.000	Mon May  5 19:06:34 2003
+++ linux-2.5.68/include/linux/atmdev.h	Mon May  5 19:06:42 2003
@@ -304,9 +304,6 @@
 	struct sockaddr_atmsvc local;
 	struct sockaddr_atmsvc remote;
 	void (*callback)(struct atm_vcc *vcc);
-	struct sk_buff_head listenq;
-	int		backlog_quota;	/* number of connection requests we */
-					/* can still accept */
 	int		reply;		/* also used by ATMTCP */
 	/* Multipoint part ------------------------------------------------- */
 	struct atm_vcc	*session;	/* session VCC descriptor */
--- linux-2.5.68/net/atm/svc.c.001	Mon May  5 19:03:10 2003
+++ linux-2.5.68/net/atm/svc.c	Mon May  5 19:31:02 2003
@@ -74,7 +74,7 @@
 	}
 	/* beware - socket is still in use by atmsigd until the last
 	   as_indicate has been answered */
-	while ((skb = skb_dequeue(&vcc->listenq))) {
+	while ((skb = skb_dequeue(&vcc->sk->receive_queue))) {
 		DPRINTK("LISTEN REL\n");
 		sigd_enq2(NULL,as_reject,vcc,NULL,NULL,&vcc->qos,0);
 		dev_kfree_skb(skb);
@@ -253,7 +253,7 @@
 	remove_wait_queue(&vcc->sleep,&wait);
 	if (!sigd) return -EUNATCH;
 	set_bit(ATM_VF_LISTEN,&vcc->flags);
-	vcc->backlog_quota = backlog > 0 ? backlog : ATM_BACKLOG_DEFAULT;
+	vcc->sk->max_ack_backlog = backlog > 0 ? backlog : ATM_BACKLOG_DEFAULT;
 	return vcc->reply;
 }
 
@@ -277,7 +277,7 @@
 		DECLARE_WAITQUEUE(wait,current);
 
 		add_wait_queue(&old_vcc->sleep,&wait);
-		while (!(skb = skb_dequeue(&old_vcc->listenq)) && sigd) {
+		while (!(skb = skb_dequeue(&old_vcc->sk->receive_queue)) && sigd) {
 			if (test_bit(ATM_VF_RELEASED,&old_vcc->flags)) break;
 			if (test_bit(ATM_VF_CLOSE,&old_vcc->flags)) {
 				error = old_vcc->reply;
@@ -306,7 +306,7 @@
 		error = atm_connect(newsock,msg->pvc.sap_addr.itf,
 		    msg->pvc.sap_addr.vpi,msg->pvc.sap_addr.vci);
 		dev_kfree_skb(skb);
-		old_vcc->backlog_quota++;
+		old_vcc->sk->ack_backlog--;
 		if (error) {
 			sigd_enq2(NULL,as_reject,old_vcc,NULL,NULL,
 			    &old_vcc->qos,error);
--- linux-2.5.68/net/atm/signaling.c.000	Mon May  5 19:03:03 2003
+++ linux-2.5.68/net/atm/signaling.c	Mon May  5 19:33:48 2003
@@ -129,12 +129,12 @@
 		case as_indicate:
 			vcc = *(struct atm_vcc **) &msg->listen_vcc;
 			DPRINTK("as_indicate!!!\n");
-			if (!vcc->backlog_quota) {
+			if (vcc->sk->ack_backlog == vcc->sk->max_ack_backlog) {
 				sigd_enq(0,as_reject,vcc,NULL,NULL);
 				return 0;
 			}
-			vcc->backlog_quota--;
-			skb_queue_tail(&vcc->listenq,skb);
+			vcc->sk->ack_backlog++;
+			skb_queue_tail(&vcc->sk->receive_queue,skb);
 			if (vcc->callback) {
 				DPRINTK("waking vcc->sleep 0x%p\n",
 				    &vcc->sleep);
--- linux-2.5.68/net/atm/common.c.000	Mon May  5 19:02:56 2003
+++ linux-2.5.68/net/atm/common.c	Tue May  6 11:08:34 2003
@@ -120,7 +120,6 @@
 	vcc->vpi = vcc->vci = 0; /* no VCI/VPI yet */
 	vcc->atm_options = vcc->aal_options = 0;
 	init_waitqueue_head(&vcc->sleep);
-	skb_queue_head_init(&vcc->listenq);
 	sk->sleep = &vcc->sleep;
 	sock->sk = sk;
 	return 0;
@@ -489,7 +488,7 @@
 	vcc = ATM_SD(sock);
 	poll_wait(file,&vcc->sleep,wait);
 	mask = 0;
-	if (skb_peek(&vcc->sk->receive_queue) || skb_peek(&vcc->listenq))
+	if (skb_peek(&vcc->sk->receive_queue))
 		mask |= POLLIN | POLLRDNORM;
 	if (test_bit(ATM_VF_RELEASED,&vcc->flags) ||
 	    test_bit(ATM_VF_CLOSE,&vcc->flags))
