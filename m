Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266064AbUA1Pmq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 10:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266058AbUA1Plb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 10:41:31 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:7435 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S266054AbUA1Pkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 10:40:53 -0500
Date: Wed, 28 Jan 2004 23:39:59 +0800 (WST)
From: raven@themaw.net
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@osdl.org>, Maneesh Soni <maneesh@in.ibm.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       Mike Waychison <Michael.Waychison@Sun.COM>
Subject: [PATCH 4/8] autofs4-2.6 - to support autofs 4.1.x
Message-ID: <Pine.LNX.4.58.0401282321530.17471@raven.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=0.3, required 8,
	NO_REAL_NAME, PATCH_UNIFIED_DIFF, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Patch:

4-autofs4-2.6.0-test9-waitq2.patch

Adds a spin lock to serialize access to wait queue in the super block info
struct.

diff -Nur linux-2.6.0-0.test9.waitq1/fs/autofs4/waitq.c linux-2.6.0-0.test9.waitq2/fs/autofs4/waitq.c
--- linux-2.6.0-0.test9.waitq1/fs/autofs4/waitq.c	2003-11-30 08:58:47.000000000 +0800
+++ linux-2.6.0-0.test9.waitq2/fs/autofs4/waitq.c	2003-11-30 09:07:29.000000000 +0800
@@ -16,6 +16,8 @@
 #include <linux/file.h>
 #include "autofs_i.h"
 
+static spinlock_t waitq_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
+
 /* We make this a static variable rather than a part of the superblock; it
    is better if we don't reassign numbers easily even across filesystems */
 static autofs_wqt_t autofs4_next_wait_queue = 1;
@@ -138,12 +140,14 @@
 	if ( name->len > NAME_MAX )
 		return -ENOENT;
 
+	spin_lock(&waitq_lock);
 	for ( wq = sbi->queues ; wq ; wq = wq->next ) {
 		if ( wq->hash == name->hash &&
 		     wq->len == name->len &&
 		     wq->name && !memcmp(wq->name,name->name,name->len) )
 			break;
 	}
+	spin_unlock(&waitq_lock);
 	
 	if ( !wq ) {
 		/* Create a new wait queue */
@@ -164,11 +168,13 @@
 		wq->len = name->len;
 		wq->status = -EINTR; /* Status return if interrupted */
 		memcpy(wq->name, name->name, name->len);
+		spin_lock(&waitq_lock);
 		wq->next = sbi->queues;
 		sbi->queues = wq;
+		spin_unlock(&waitq_lock);
 
 		DPRINTK(("autofs_wait: new wait id = 0x%08lx, name = %.*s, nfy=%d\n",
-			 wq->wait_queue_token, wq->len, wq->name, notify));
+			 (unsigned long) wq->wait_queue_token, wq->len, wq->name, notify));
 		/* autofs4_notify_daemon() may block */
 		wq->wait_ctr = 2;
 		if (notify != NFY_NONE) {
@@ -179,7 +185,7 @@
 	} else {
 		wq->wait_ctr++;
 		DPRINTK(("autofs_wait: existing wait id = 0x%08lx, name = %.*s, nfy=%d\n",
-			 wq->wait_queue_token, wq->len, wq->name, notify));
+			 (unsigned long) wq->wait_queue_token, wq->len, wq->name, notify));
 	}
 
 	/* wq->name is NULL if and only if the lock is already released */
@@ -238,14 +244,19 @@
 {
 	struct autofs_wait_queue *wq, **wql;
 
+	spin_lock(&waitq_lock);
 	for ( wql = &sbi->queues ; (wq = *wql) ; wql = &wq->next ) {
 		if ( wq->wait_queue_token == wait_queue_token )
 			break;
 	}
-	if ( !wq )
+
+	if ( !wq ) {
+		spin_unlock(&waitq_lock);
 		return -EINVAL;
+	}
 
 	*wql = wq->next;	/* Unlink from chain */
+	spin_unlock(&waitq_lock);
 	kfree(wq->name);
 	wq->name = NULL;	/* Do not wait on this queue */
 

