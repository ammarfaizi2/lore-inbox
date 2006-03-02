Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932423AbWCBRve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbWCBRve (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 12:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbWCBRvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 12:51:33 -0500
Received: from nproxy.gmail.com ([64.233.182.194]:56213 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932423AbWCBRvd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 12:51:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=R/Xt3W+2afcCzIqC82SMVhXf4fJIY6MipY2di3Y3nFevg7n5bzCrOnIzVC2Q26gLWRiuz2hMKhagwE++/10IdWTw7ybXGMAYfCwqSIEFJKGSzM4gwsYb/7w7/kXrz+1cFpjmbpynNvETVwo2178c29eCHgRVTfymnt0wNd4n1ZA=
Date: Thu, 2 Mar 2006 18:51:26 +0100
From: Frederik Deweerdt <deweerdt@free.fr>
To: Simon Derr <Simon.Derr@bull.net>
Cc: linux-kernel@vger.kernel.org, FACCINI BRUNO <Bruno.Faccini@bull.net>,
       Trond Myklebust <Trond.Myklebust@netapp.com>
Subject: Re: Deadlock in net/sunrpc/sched.c
Message-ID: <20060302175126.GA12335@silenus.home.res>
References: <Pine.LNX.4.61.0603021116030.15393@openx3.frec.bull.fr> <20060302105940.GA9521@silenus.home.res> <Pine.LNX.4.61.0603021242150.15393@openx3.frec.bull.fr> <Pine.LNX.4.61.0603021306540.15393@openx3.frec.bull.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0603021306540.15393@openx3.frec.bull.fr>
User-Agent: mutt-ng/devel-r781 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Added Trond Myklebust to the cc list, as he's working on sunrpc)
> +	if (RPC_IS_QUEUED(task)) {
> +		struct rpc_wait_queue *queue = task->u.tk_wait.rpc_waitq;
> +		spin_lock_bh(&queue->lock);
> +		if (rpc_start_wakeup(task))  {
We may end up list_del'ing a task that is not queued
anymore: we may be interrupted just after the RPC_IS_QUEUED test.
Don't you think this patch could be enough?

--- linux-2.6.16-rc5/net/sunrpc/sched.c 2006-03-01 11:26:15.000000000 +0100
+++ linux-2.6.16-rc5-2/net/sunrpc/sched.c       2006-03-02 15:43:18.000000000 +0100
@@ -521,8 +521,7 @@
        spin_lock_bh(&queue->lock);
        head = &queue->tasks[queue->maxpriority];
        for (;;) {
-               while (!list_empty(head)) {
-                       task = list_entry(head->next, struct rpc_task, u.tk_wait.list);
+               list_for_each_entry(task, head, u.tk_wait.list) {
                        __rpc_wake_up_task(task);
                }
                if (head == &queue->tasks[0])

We don't need to __rpc_wake_up_task a task that is already
rpc_start_wakeup'ed after all.  BTW, there are other while
(!list_empty(head)) on sched.c that could need a similar rewrite.

Regards,
Frederik
