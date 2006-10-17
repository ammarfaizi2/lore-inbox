Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030206AbWJQBXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030206AbWJQBXp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 21:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030208AbWJQBXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 21:23:45 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:53969 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030206AbWJQBXo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 21:23:44 -0400
Date: Mon, 16 Oct 2006 18:24:48 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
Message-ID: <20061017012448.GB1781@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20061013223925.GH1722@us.ibm.com> <Pine.LNX.4.44L0.0610132216290.22133-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0610132216290.22133-100000@netrider.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2006 at 10:27:36PM -0400, Alan Stern wrote:
> On Fri, 13 Oct 2006, Paul E. McKenney wrote:
> 
> > Ewww...  How about __kfifo_get() and __kfifo_put()?  These have no atomic
> > operations.  Ah, but they are restricted to pairs of tasks, so pairwise
> > memory barriers should suffice.
> 
> Tasks can migrate from one CPU to another, of course.  But that involves
> context switching and plenty of synchronization operations in the kernel,
> so you're okay in that respect.

Yep -- at least it had better be!  Careful about how you write lightweight
schedulers!  ;-)

> > For the pairwise memory barriers, I really like "conditionally precedes",
> > which makes it very clear that the observation of order is not automatic.
> > On both CPUs, and explicit memory barrier is required (with the exception
> > of MMIO, where the communication is instead with an I/O device).
> > 
> > For the single-variable case and for the single-CPU case, just plain
> > "precedes" works, at least as long as you are not doing fine-grained
> > timings that can allow you to observe cache lines in motion.  But if
> > you are doing that, you had better know what you are doing anyway.  ;-)
> 
> The reason I don't like "conditionally precedes" is because it suggests
> the ordering is not automatic even in the single-CPU case.

Aside from MMIO accesses, why would you be using memory barriers in the
single-CPU case?  If you aren't using memory barriers, then just plain
"precedes" works fine -- "conditionally precedes" applies only to memory
barriers acting on normal memory (again, MMIO is handled specially).

So, ordering is indeed automatic in the single-CPU case.  Or, more
accurately, ordering -looks- -like- it is automatic in the single-CPU
case.  Except for MMIO -- MMIO giveth ordering in SMP and it taketh
ordering away on UP.  ;-)

						Thanx, Paul
