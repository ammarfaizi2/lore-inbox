Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751937AbWCBLpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937AbWCBLpb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 06:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751777AbWCBLpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 06:45:31 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:64697 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1750701AbWCBLpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 06:45:30 -0500
Date: Thu, 2 Mar 2006 12:45:25 +0100 (CET)
From: Simon Derr <Simon.Derr@bull.net>
X-X-Sender: derrs@openx3.frec.bull.fr
To: Frederik Deweerdt <deweerdt@free.fr>
Cc: Simon Derr <Simon.Derr@bull.net>, linux-kernel@vger.kernel.org,
       FACCINI BRUNO <Bruno.Faccini@bull.net>
Subject: Re: Deadlock in net/sunrpc/sched.c
In-Reply-To: <20060302105940.GA9521@silenus.home.res>
Message-ID: <Pine.LNX.4.61.0603021242150.15393@openx3.frec.bull.fr>
References: <Pine.LNX.4.61.0603021116030.15393@openx3.frec.bull.fr>
 <20060302105940.GA9521@silenus.home.res>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 02/03/2006 12:46:56,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 02/03/2006 12:46:59,
	Serialize complete at 02/03/2006 12:46:59
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Mar 2006, Frederik Deweerdt wrote:

> On Thu, Mar 02, 2006 at 11:38:10AM +0100, Simon Derr wrote:
> > This happened with 2.6.12 but it seems that the code has not changed and 
> > the issue is very probably still present in the current kernels.
> Looks like it's fixed in 2.6.16-rc5, could you check agains the current
> tree?

No, the code is still the same.

> Hmm, not sure this will even compile...

oops....

Index: linux-2.6.12.6/net/sunrpc/sched.c
===================================================================
--- linux-2.6.12.6.orig/net/sunrpc/sched.c	2005-08-29 18:55:27.000000000 +0200
+++ linux-2.6.12.6/net/sunrpc/sched.c	2006-03-02 12:41:42.000000000 +0100
@@ -400,16 +400,16 @@ __rpc_default_timer(struct rpc_task *tas
  */
 void rpc_wake_up_task(struct rpc_task *task)
 {
+	struct rpc_wait_queue *queue = task->u.tk_wait.rpc_waitq;
+	spin_lock_bh(&queue->lock);
 	if (rpc_start_wakeup(task)) {
 		if (RPC_IS_QUEUED(task)) {
-			struct rpc_wait_queue *queue = task->u.tk_wait.rpc_waitq;
 
-			spin_lock_bh(&queue->lock);
 			__rpc_do_wake_up_task(task);
-			spin_unlock_bh(&queue->lock);
 		}
 		rpc_finish_wakeup(task);
 	}
+	spin_unlock_bh(&queue->lock);
 }
 
 /*
