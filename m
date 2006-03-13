Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750913AbWCMO26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbWCMO26 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 09:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbWCMO26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 09:28:58 -0500
Received: from pat.uio.no ([129.240.130.16]:60873 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1750839AbWCMO26 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 09:28:58 -0500
Subject: Re: [PATCH] Fix deadlock in RPC scheduling code.
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Aurelien Degremont <aurelien.degremont@cea.fr>
Cc: Jacques-Charles Lafoucriere <jc.lafoucriere@cea.fr>,
       Bruno Faccini <bruno.faccini@bull.net>, linux-kernel@vger.kernel.org
In-Reply-To: <200603131007.LAA10812@styx.bruyeres.cea.fr>
References: <200603091035.LAA04829@styx.bruyeres.cea.fr>
	 <1141915219.8293.5.camel@lade.trondhjem.org>
	 <200603101510.QAA17788@styx.bruyeres.cea.fr>
	 <1142004255.8041.26.camel@lade.trondhjem.org>
	 <200603131007.LAA10812@styx.bruyeres.cea.fr>
Content-Type: text/plain
Date: Mon, 13 Mar 2006 09:28:35 -0500
Message-Id: <1142260115.7996.13.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.05, required 12,
	autolearn=disabled, AWL 1.76, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-13 at 11:07 +0100, Aurelien Degremont wrote:
> Trond Myklebust wrote:
> > Yes. The RPC_TASK_QUEUED bit can only be cleared when both the
> > RPC_TASK_WAKEUP bit _and_ the queue spinlock are held.
> > If you are holding either one of those two, then it is safe to test for
> > RPC_IS_QUEUED(). If the latter is true, then it is also safe to
> > dereference the value of task->u.tk_wait.rpc_waitq.
> 
> Hmmm... With those constraints, it seems difficult to be able to modify 
> the current rpc_wake_up_task() function...

That is the price of optimisation in this case.

> But, are you sure the patch you provided is sufficient to remove the 
> potential deadlock we faced ? I do not see how, could you explain ?

Your deadlock problem resulted in __rpc_wake_up_task() iterating forever
on the same task since the while() loop would not ever exit before it
was empty. By changing the iteration scheme into one where we only try
to wake up each task once, we allow rpc_wake_up()/rpc_wake_up_status()
to complete.

Cheers,
 Trond

