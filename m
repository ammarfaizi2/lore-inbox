Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161357AbWKERCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161357AbWKERCA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 12:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161369AbWKERCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 12:02:00 -0500
Received: from pat.uio.no ([129.240.10.4]:23791 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1161357AbWKERB7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 12:01:59 -0500
Subject: Re: [PATCH] Fix SUNRPC wakeup/execute race condition
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Christophe Saout <christophe@saout.de>
Cc: linux-kernel@vger.kernel.org, NFS V4 Mailing List <nfsv4@linux-nfs.org>,
       "J. Bruce Fields" <bfields@citi.umich.edu>
In-Reply-To: <1162722728.19690.4.camel@leto.intern.saout.de>
References: <1157576316.3292.13.camel@dyn9047022153>
	 <20060907150146.GA22586@fieldses.org>
	 <1157731084.3292.25.camel@dyn9047022153>
	 <20060908160432.GB19234@fieldses.org>
	 <1162158228.11247.4.camel@leto.intern.saout.de>
	 <1162159282.11247.17.camel@leto.intern.saout.de>
	 <1162321027.23543.6.camel@leto.intern.saout.de>
	 <1162324141.23543.23.camel@leto.intern.saout.de>
	 <1162325490.5614.82.camel@lade.trondhjem.org>
	 <1162602386.26794.5.camel@leto.intern.saout.de>
	 <1162688688.5153.26.camel@leto.intern.saout.de>
	 <1162709441.6271.62.camel@lade.trondhjem.org>
	 <1162722728.19690.4.camel@leto.intern.saout.de>
Content-Type: text/plain
Date: Sun, 05 Nov 2006 12:01:33 -0500
Message-Id: <1162746093.5652.39.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.313, required 12,
	autolearn=disabled, AWL 1.55, RCVD_IN_SORBS_DUL 0.14,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-11-05 at 11:32 +0100, Christophe Saout wrote:
> Am Sonntag, den 05.11.2006, 01:50 -0500 schrieb Trond Myklebust:
> 
> > > --- linux-2.6.18/net/sunrpc/sched.c	2006-09-20 05:42:06.000000000 +0200
> > > +++ linux/net/sunrpc/sched.c	2006-11-04 20:38:56.000000000 +0100
> > > @@ -302,12 +302,9 @@ EXPORT_SYMBOL(__rpc_wait_for_completion_
> > >   */
> > >  static void rpc_make_runnable(struct rpc_task *task)
> > >  {
> > > -	int do_ret;
> > > -
> > >  	BUG_ON(task->tk_timeout_fn);
> > > -	do_ret = rpc_test_and_set_running(task);
> > >  	rpc_clear_queued(task);
> > > -	if (do_ret)
> > > +	if (rpc_test_and_set_running(task))
> > >  		return;
> > >  	if (RPC_IS_ASYNC(task)) {
> > >  		int status;
> > 
> > This fix looks wrong to me. If we've made it to 'rpc_make_runnable',
> > then the rpc_task will have already been removed from the
> > rpc_wait_queue.
> 
> I just flipped the two lines, changed nothing else. Why exactly do you
> think that's wrong, I don't see anything particular that could be broken
> by chaning the ordering. Anyway, the fsstress has been running for 18
> hours straight now without showing any signs of problems.

OK. I finally see the bug that you've spotted. The problem occurs when
__rpc_execute clears RPC_TASK_RUNNING after rpc_make_runnable has called
rpc_test_and_set_running, but before it has called rpc_clear_queued.

However if you just swap the two lines, you run into a new race:
__rpc_execute() may just put the rpc_task back to sleep before your call
to rpc_test_and_set_running() finishes executing.
We therefore need an extra test for RPC_IS_QUEUED() in
rpc_make_runnable().


Cheers,
  Trond

