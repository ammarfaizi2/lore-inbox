Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263244AbVBCWqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263244AbVBCWqi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 17:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263020AbVBCWqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 17:46:37 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:20389 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263269AbVBCWpw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 17:45:52 -0500
Date: Thu, 3 Feb 2005 14:45:38 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Andrew Morton <akpm@osdl.org>
cc: torvalds@osdl.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, jlan@sgi.com
Subject: Re: move-accounting-function-calls-out-of-critical-vm-code-paths.patch
In-Reply-To: <20050203140904.7c67a144.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0502031436460.26183@schroedinger.engr.sgi.com>
References: <20050110184617.3ca8d414.akpm@osdl.org>
 <Pine.LNX.4.58.0502031319440.25268@schroedinger.engr.sgi.com>
 <20050203140904.7c67a144.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Feb 2005, Andrew Morton wrote:

> Has any performance testing been done?

Jay did some performance testing and found minor performance increases
without my page fault patches. But then the performance without the page
fault patches is already so bad due to the page_table_lock
contention that this is not so important.

> > acct_update_integrals is only useful to call if stime changes otherwise
> > it will simply return. It is therefore best to relocate the function call
> > to acct_update_integral into the function that updates stime which is
> > account_system_time and remove it from the vm code paths.
>
> But that changes (breaks) the semantics significantly.  A task will now
> only have its BSD accounting fields updated when it happens to be
> interrupted by the timer.  Some tasks:
>
> 	for ( ; ; ) {
> 		nanosleep(2 milliseconds);
> 		do_stuff_for(0.5 milliseconds);
> 	}
>
> will see their BSD accounting fields remaining stuck firmly at zero.
>
> I think?

Accounting is only effective is stime changes even with the current
code. If the process never gets its stime increased then also the
accounting does nothing. There is no change in that behavior.

> > update_mem_hiwater finds the rss hiwater mark. RSS limits are checked in
> > account_system_time().
>
> Linux doesn't check rss limits anywhere.  We check CPU usage in
> account_system_time().

Yuck. I was mistaken in what check_rlimit does.

> Most of this could be fixed up by updating these counters at schedule()
> time as well, although that would become somewhat inaccurate if we later
> decide to implement rss enforcement at pagefault time.

Right. I hope that Roland's changes for higher resolution of cputime would
make that possible. But this is Jay's thing not mine. I just want to make
sure that the CSA patches does not get in the way of our attempts to
improve the performance of the page fault handler. In the discussions on
linux-mm there was also some concern about adding these calls.
