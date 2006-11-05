Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932628AbWKEKcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932628AbWKEKcO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 05:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932629AbWKEKcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 05:32:14 -0500
Received: from websrv.werbeagentur-aufwind.de ([88.198.253.206]:44446 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S932628AbWKEKcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 05:32:13 -0500
Subject: Re: [PATCH] Fix SUNRPC wakeup/execute race condition
From: Christophe Saout <christophe@saout.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org, NFS V4 Mailing List <nfsv4@linux-nfs.org>,
       "J. Bruce Fields" <bfields@citi.umich.edu>
In-Reply-To: <1162709441.6271.62.camel@lade.trondhjem.org>
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
Content-Type: text/plain
Date: Sun, 05 Nov 2006 11:32:08 +0100
Message-Id: <1162722728.19690.4.camel@leto.intern.saout.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, den 05.11.2006, 01:50 -0500 schrieb Trond Myklebust:

> > --- linux-2.6.18/net/sunrpc/sched.c	2006-09-20 05:42:06.000000000 +0200
> > +++ linux/net/sunrpc/sched.c	2006-11-04 20:38:56.000000000 +0100
> > @@ -302,12 +302,9 @@ EXPORT_SYMBOL(__rpc_wait_for_completion_
> >   */
> >  static void rpc_make_runnable(struct rpc_task *task)
> >  {
> > -	int do_ret;
> > -
> >  	BUG_ON(task->tk_timeout_fn);
> > -	do_ret = rpc_test_and_set_running(task);
> >  	rpc_clear_queued(task);
> > -	if (do_ret)
> > +	if (rpc_test_and_set_running(task))
> >  		return;
> >  	if (RPC_IS_ASYNC(task)) {
> >  		int status;
> 
> This fix looks wrong to me. If we've made it to 'rpc_make_runnable',
> then the rpc_task will have already been removed from the
> rpc_wait_queue.

I just flipped the two lines, changed nothing else. Why exactly do you
think that's wrong, I don't see anything particular that could be broken
by chaning the ordering. Anyway, the fsstress has been running for 18
hours straight now without showing any signs of problems.


