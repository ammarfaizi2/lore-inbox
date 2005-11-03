Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030422AbVKCTJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030422AbVKCTJK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 14:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030444AbVKCTJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 14:09:10 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:43196 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030422AbVKCTJI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 14:09:08 -0500
Date: Thu, 3 Nov 2005 11:09:16 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, oleg@tv-sign.ru,
       dipankar@in.ibm.com, suzannew@cs.pdx.edu
Subject: Re: [PATCH] Fixes for RCU handling of task_struct
Message-ID: <20051103190916.GA13417@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20051031020535.GA46@us.ibm.com> <20051031140459.GA5664@elte.hu> <20051031205119.5bd897f3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051031205119.5bd897f3.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2005 at 08:51:19PM -0800, Andrew Morton wrote:
> Ingo Molnar <mingo@elte.hu> wrote:
> >
> > @@ -1433,7 +1485,16 @@ send_group_sigqueue(int sig, struct sigq
> >   	int ret = 0;
> >   
> >   	BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
> >  -	read_lock(&tasklist_lock);
> >  +
> >  +	while(!read_trylock(&tasklist_lock)) {
> >  +		if (!p->sighand)
> >  +			return -1;
> >  +		cpu_relax();
> >  +	}
> 
> This looks kind of ugly and quite unobvious.
> 
> What's going on there?

This was discussed in the following thread:

	http://marc.theaimsgroup.com/?l=linux-kernel&m=112756875713008&w=2

Looks like its author asked for it to be withdrawn in favor of Roland's
"[PATCH] Call exit_itimers from do_exit, not __exit_signal" patch:

	http://marc.theaimsgroup.com/?l=linux-kernel&m=113008567108608&w=2

My guess is that "Roland" is "Roland McGrath", but I cannot find the
referenced patch.  Oleg, any enlightenment?

						Thanx, Paul
