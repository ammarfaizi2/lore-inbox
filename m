Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750965AbWCJPYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbWCJPYd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 10:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbWCJPYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 10:24:33 -0500
Received: from pat.uio.no ([129.240.130.16]:28851 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1750965AbWCJPYc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 10:24:32 -0500
Subject: Re: [PATCH] Fix deadlock in RPC scheduling code.
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Aurelien Degremont <aurelien.degremont@cea.fr>
Cc: Jacques-Charles Lafoucriere <jc.lafoucriere@cea.fr>,
       Bruno Faccini <bruno.faccini@bull.net>, linux-kernel@vger.kernel.org
In-Reply-To: <200603101510.QAA17788@styx.bruyeres.cea.fr>
References: <200603091035.LAA04829@styx.bruyeres.cea.fr>
	 <1141915219.8293.5.camel@lade.trondhjem.org>
	 <200603101510.QAA17788@styx.bruyeres.cea.fr>
Content-Type: text/plain
Date: Fri, 10 Mar 2006 10:24:15 -0500
Message-Id: <1142004255.8041.26.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.032, required 12,
	autolearn=disabled, AWL 1.78, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-10 at 16:10 +0100, Aurelien Degremont wrote:
> Trond Myklebust wrote:
> 
> > The real fix is the one I posted in response to this thread last week.
> 
> Oops, I missed it.
> 
> Ok for the patch, the list iteration will be better, but I don't
> understand how this will prevent the race condition?
> 
> I do not think it is not a good idea to keep this lock order in
> rpc_wake_up_task() anyway. I must be missing something but I
> think this function should be modified in order to be in accordance with
> the lock hierarchy in rpc code. It seems to me that the potential race 
> is still there.
> 
> Even if we cannot certify task->u.tk_wait.rpc_waitq is valid, the
> current kernel code cannot either (err... I think it can't). So let's 
> try at least to improve it, even if we cannot set it totally harmless.
> Warn me if I'm wrong :
>     When rpc_wake_up_task() is called, the calling context is helpless. 
> So we have absolutely no information on the task queue. We must 
> atomically check the "queued-ness" of the task and grab the queue lock 
> to prevent any error? Hmmm... So the matter is : the queue mustn't be 
> modified between the test and the lock? Have we some "magical" lock 
> somewhere which could help up? I didn't find it.

Yes. The RPC_TASK_QUEUED bit can only be cleared when both the
RPC_TASK_WAKEUP bit _and_ the queue spinlock are held.
If you are holding either one of those two, then it is safe to test for
RPC_IS_QUEUED(). If the latter is true, then it is also safe to
dereference the value of task->u.tk_wait.rpc_waitq.

Cheers,
  Trond

