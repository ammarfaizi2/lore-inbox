Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751546AbWCIOks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbWCIOks (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 09:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751990AbWCIOks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 09:40:48 -0500
Received: from pat.uio.no ([129.240.130.16]:62624 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751546AbWCIOkr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 09:40:47 -0500
Subject: Re: [PATCH] Fix deadlock in RPC scheduling code.
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Aurelien Degremont <aurelien.degremont@cea.fr>
Cc: Jacques-Charles Lafoucriere <jc.lafoucriere@cea.fr>,
       Bruno Faccini <bruno.faccini@bull.net>, linux-kernel@vger.kernel.org
In-Reply-To: <200603091035.LAA04829@styx.bruyeres.cea.fr>
References: <200603091035.LAA04829@styx.bruyeres.cea.fr>
Content-Type: text/plain
Date: Thu, 09 Mar 2006 09:40:19 -0500
Message-Id: <1141915219.8293.5.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.032, required 12,
	autolearn=disabled, AWL 1.78, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-09 at 11:35 +0100, Aurelien Degremont wrote:
> Hello,
> 
> Here is a small patch which fixes a deadlock issue in RPC scheduling
> code (rpc_wake_up_task() is mainly concerned). This problem happens if a
> RPC task, waiting for the response of a sync request, is woken up by a
> signal, and, in the same time, the kernel tries to wake up some RPC
> tasks. If this is done, a deadlock could occurs due to an error in RPC
> workqueue lock management.
> 
> This error was added by linux-2.6.8.1-49-rpc_workqueue.patch (included
> in 2.6.11). This code was not changed since. The issue was detected on
> linux-2.6.12.
> 
> 
> **DESCRIPTION**
> 
> This deadlock is due to the wrong management of two locks: queue->lock
> and the bit RPC_TASK_WAKEUP in task->tk_runstate.
> When dealing with RPC workqueues, the code must take care of locking the
> associated queue lock before doing any modifications on it or its tasks.
> And it does it... except for one function. Nested locks should always be
> taken in the same order.
> 
> As a consequence, in some circumstances (in fact, I noticed it several
> times), this code deadlocks. Moreover, when this code is called, by
> example by nfs_file_flush(), the lock_kernel() is held and so all the
> system hangs.
> 
> 
> **PATCH**
> 
> To fix the problem, we only need to invert the lock hierarchy in
> rpc_wake_up_task() and taking care of checking the task is really queued
> before trying to grab the lock.

No you can't. You have absolutely _no_ guarantee that
task->u.tk_wait.rpc_waitq is valid here.

The real fix is the one I posted in response to this thread last week.
See

http://client.linux-nfs.org/Linux-2.6.x/2.6.16-rc5/linux-2.6.16-89-fix_race_in_rpc_wakeup.dif

Cheers,
  Trond

