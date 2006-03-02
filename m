Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbWCBMR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWCBMR6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 07:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbWCBMR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 07:17:58 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:64996 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1751134AbWCBMR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 07:17:58 -0500
Date: Thu, 2 Mar 2006 13:17:52 +0100 (CET)
From: Simon Derr <Simon.Derr@bull.net>
X-X-Sender: derrs@openx3.frec.bull.fr
To: Simon Derr <Simon.Derr@bull.net>
Cc: Frederik Deweerdt <deweerdt@free.fr>, linux-kernel@vger.kernel.org,
       FACCINI BRUNO <Bruno.Faccini@bull.net>
Subject: Re: Deadlock in net/sunrpc/sched.c
In-Reply-To: <Pine.LNX.4.61.0603021242150.15393@openx3.frec.bull.fr>
Message-ID: <Pine.LNX.4.61.0603021306540.15393@openx3.frec.bull.fr>
References: <Pine.LNX.4.61.0603021116030.15393@openx3.frec.bull.fr>
 <20060302105940.GA9521@silenus.home.res> <Pine.LNX.4.61.0603021242150.15393@openx3.frec.bull.fr>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 02/03/2006 13:19:23,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 02/03/2006 13:19:26,
	Serialize complete at 02/03/2006 13:19:26
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Mar 2006, Simon Derr wrote:

> Index: linux-2.6.12.6/net/sunrpc/sched.c
> ===================================================================
> --- linux-2.6.12.6.orig/net/sunrpc/sched.c	2005-08-29 18:55:27.000000000 +0200
> +++ linux-2.6.12.6/net/sunrpc/sched.c	2006-03-02 12:41:42.000000000 +0100
> @@ -400,16 +400,16 @@ __rpc_default_timer(struct rpc_task *tas
>   */
>  void rpc_wake_up_task(struct rpc_task *task)
>  {
> +	struct rpc_wait_queue *queue = task->u.tk_wait.rpc_waitq;
> +	spin_lock_bh(&queue->lock);
>  	if (rpc_start_wakeup(task)) {
>  		if (RPC_IS_QUEUED(task)) {
> -			struct rpc_wait_queue *queue = task->u.tk_wait.rpc_waitq;
>  
> -			spin_lock_bh(&queue->lock);
>  			__rpc_do_wake_up_task(task);
> -			spin_unlock_bh(&queue->lock);
>  		}
>  		rpc_finish_wakeup(task);
>  	}
> +	spin_unlock_bh(&queue->lock);
>  }

Hmm, this is just to show how to reverse the locking order.
I'm not too familiar with the rpc_tasks, and 
task->u.tk_wait.rpc_waitq might not be valid.

Maybe this would be better:



--- linux-2.6.12.6.orig/net/sunrpc/sched.c	2006-03-02 13:11:51.000000000 +0100
+++ linux-2.6.12.6/net/sunrpc/sched.c	2006-03-02 13:16:19.000000000 +0100
@@ -400,15 +400,14 @@ __rpc_default_timer(struct rpc_task *tas
  */
 void rpc_wake_up_task(struct rpc_task *task)
 {
-	if (rpc_start_wakeup(task)) {
-		if (RPC_IS_QUEUED(task)) {
-			struct rpc_wait_queue *queue = task->u.tk_wait.rpc_waitq;
-
-			spin_lock_bh(&queue->lock);
+	if (RPC_IS_QUEUED(task)) {
+		struct rpc_wait_queue *queue = task->u.tk_wait.rpc_waitq;
+		spin_lock_bh(&queue->lock);
+		if (rpc_start_wakeup(task))  {
 			__rpc_do_wake_up_task(task);
-			spin_unlock_bh(&queue->lock);
+			rpc_finish_wakeup(task);
 		}
-		rpc_finish_wakeup(task);
+		spin_unlock_bh(&queue->lock);
 	}
 }
 
