Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbTEDRCY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 13:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbTEDRCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 13:02:24 -0400
Received: from verein.lst.de ([212.34.181.86]:26895 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S261230AbTEDRCW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 13:02:22 -0400
Date: Sun, 4 May 2003 19:14:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com, trond.myklebust@fys.uio.no
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove useless MOD_{INC,DEC}_USE_COUNT from sunrpc
Message-ID: <20030504191447.C10659@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 - both rpciod_up and rpciod_down do a gratious inc/dec of the
   use count - but we can't ever be inside those function unless
   it's called from an other module -> totally useless
 - rpciod() (the ernel thread) also bumps the refcount when starting
   and decrements it when exiting.  but as a different module must
   initiate this using rpciod_up/rpciod_down this is again not needed.
   (except when a module does rpciod_up without a matching rpciod_down -
   but that a big bug anyway and we don't need to partially handle that
   using module refcounts).


--- 1.24/net/sunrpc/sched.c	Thu Mar 27 12:42:11 2003
+++ edited/net/sunrpc/sched.c	Thu May  1 16:52:23 2003
@@ -952,7 +952,6 @@
 	wait_queue_head_t *assassin = (wait_queue_head_t*) ptr;
 	int		rounds = 0;
 
-	MOD_INC_USE_COUNT;
 	lock_kernel();
 	/*
 	 * Let our maker know we're running ...
@@ -995,7 +994,6 @@
 
 	dprintk("RPC: rpciod exiting\n");
 	unlock_kernel();
-	MOD_DEC_USE_COUNT;
 	return 0;
 }
 
@@ -1027,7 +1025,6 @@
 {
 	int error = 0;
 
-	MOD_INC_USE_COUNT;
 	down(&rpciod_sema);
 	dprintk("rpciod_up: pid %d, users %d\n", rpciod_pid, rpciod_users);
 	rpciod_users++;
@@ -1051,7 +1048,6 @@
 	error = 0;
 out:
 	up(&rpciod_sema);
-	MOD_DEC_USE_COUNT;
 	return error;
 }
 
@@ -1060,7 +1056,6 @@
 {
 	unsigned long flags;
 
-	MOD_INC_USE_COUNT;
 	down(&rpciod_sema);
 	dprintk("rpciod_down pid %d sema %d\n", rpciod_pid, rpciod_users);
 	if (rpciod_users) {
@@ -1097,7 +1092,6 @@
 	spin_unlock_irqrestore(&current->sighand->siglock, flags);
 out:
 	up(&rpciod_sema);
-	MOD_DEC_USE_COUNT;
 }
 
 #ifdef RPC_DEBUG
