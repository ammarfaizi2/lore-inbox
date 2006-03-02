Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750993AbWCBR6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbWCBR6G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 12:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751612AbWCBR6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 12:58:06 -0500
Received: from mx2.netapp.com ([216.240.18.37]:4367 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S1750993AbWCBR6D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 12:58:03 -0500
X-IronPort-AV: i="4.02,160,1139212800"; 
   d="scan'208"; a="364081855:sNHT19326248"
Subject: Re: Deadlock in net/sunrpc/sched.c
From: Trond Myklebust <Trond.Myklebust@netapp.com>
To: Frederik Deweerdt <deweerdt@free.fr>
Cc: Simon Derr <Simon.Derr@bull.net>, linux-kernel@vger.kernel.org,
       FACCINI BRUNO <Bruno.Faccini@bull.net>
In-Reply-To: <20060302175126.GA12335@silenus.home.res>
References: <Pine.LNX.4.61.0603021116030.15393@openx3.frec.bull.fr>
	 <20060302105940.GA9521@silenus.home.res>
	 <Pine.LNX.4.61.0603021242150.15393@openx3.frec.bull.fr>
	 <Pine.LNX.4.61.0603021306540.15393@openx3.frec.bull.fr>
	 <20060302175126.GA12335@silenus.home.res>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Network Appliance, Inc
Date: Thu, 02 Mar 2006 09:58:02 -0800
Message-Id: <1141322282.10398.22.camel@netapplinux-10.connectathon.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
X-OriginalArrivalTime: 02 Mar 2006 17:58:03.0024 (UTC) FILETIME=[D9C87100:01C63E22]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-02 at 18:51 +0100, Frederik Deweerdt wrote:
> (Added Trond Myklebust to the cc list, as he's working on sunrpc)
> > +	if (RPC_IS_QUEUED(task)) {
> > +		struct rpc_wait_queue *queue = task->u.tk_wait.rpc_waitq;
> > +		spin_lock_bh(&queue->lock);
> > +		if (rpc_start_wakeup(task))  {
> We may end up list_del'ing a task that is not queued
> anymore: we may be interrupted just after the RPC_IS_QUEUED test.
> Don't you think this patch could be enough?
> 
> --- linux-2.6.16-rc5/net/sunrpc/sched.c 2006-03-01 11:26:15.000000000 +0100
> +++ linux-2.6.16-rc5-2/net/sunrpc/sched.c       2006-03-02 15:43:18.000000000 +0100
> @@ -521,8 +521,7 @@
>         spin_lock_bh(&queue->lock);
>         head = &queue->tasks[queue->maxpriority];
>         for (;;) {
> -               while (!list_empty(head)) {
> -                       task = list_entry(head->next, struct rpc_task, u.tk_wait.list);
> +               list_for_each_entry(task, head, u.tk_wait.list) {
>                         __rpc_wake_up_task(task);
>                 }
>                 if (head == &queue->tasks[0])

You need a list_for_each_entry_safe() here, since __rpc_wake_up_task()
will cause the task to be removed from the list. See the patch I sent
out 1/2 hour ago.

Cheers
  Trond
