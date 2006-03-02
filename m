Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbWCBRcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbWCBRcJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 12:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbWCBRcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 12:32:09 -0500
Received: from pat.uio.no ([129.240.130.16]:12744 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932260AbWCBRcG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 12:32:06 -0500
Subject: Re: Deadlock in net/sunrpc/sched.c
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Simon Derr <Simon.Derr@bull.net>
Cc: Frederik Deweerdt <deweerdt@free.fr>, linux-kernel@vger.kernel.org,
       FACCINI BRUNO <Bruno.Faccini@bull.net>
In-Reply-To: <Pine.LNX.4.61.0603021242150.15393@openx3.frec.bull.fr>
References: <Pine.LNX.4.61.0603021116030.15393@openx3.frec.bull.fr>
	 <20060302105940.GA9521@silenus.home.res>
	 <Pine.LNX.4.61.0603021242150.15393@openx3.frec.bull.fr>
Content-Type: text/plain
Date: Thu, 02 Mar 2006 09:31:35 -0800
Message-Id: <1141320695.10398.4.camel@netapplinux-10.connectathon.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.45, required 12,
	autolearn=disabled, AWL 2.50, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-02 at 12:45 +0100, Simon Derr wrote:
> On Thu, 2 Mar 2006, Frederik Deweerdt wrote:
> 
> > On Thu, Mar 02, 2006 at 11:38:10AM +0100, Simon Derr wrote:
> > > This happened with 2.6.12 but it seems that the code has not changed and 
> > > the issue is very probably still present in the current kernels.
> > Looks like it's fixed in 2.6.16-rc5, could you check agains the current
> > tree?
> 
> No, the code is still the same.
> 
> > Hmm, not sure this will even compile...
> 
> oops....
> 
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


Bzzzt... Race: How do you know that task->u.tk_wait.rpc_waitq contains a
valid pointer to a queue before you call rpc_start_wakeup()?

Cheers,
  Trond

>  /*
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

