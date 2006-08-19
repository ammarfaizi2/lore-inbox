Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbWHSPYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWHSPYN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 11:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbWHSPYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 11:24:12 -0400
Received: from mx2.rowland.org ([192.131.102.7]:63751 "HELO mx2.rowland.org")
	by vger.kernel.org with SMTP id S1750776AbWHSPYM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 11:24:12 -0400
Date: Sat, 19 Aug 2006 11:24:10 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Alexey Dobriyan <adobriyan@gmail.com>
cc: Jeff Garzik <jeff@garzik.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
       Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: Complaint about return code convention in queue_work() etc.
In-Reply-To: <20060818232910.GA5221@martell.zuzino.mipt.ru>
Message-ID: <Pine.LNX.4.44L0.0608191050170.30951-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Aug 2006, Alexey Dobriyan wrote:

> On Fri, Aug 18, 2006 at 05:43:18PM -0400, Jeff Garzik wrote:
> > Alan Stern wrote:
> > >I'd like to lodge a bitter complaint about the return codes used by
> > >queue_work() and related functions:
> > >
> > >	Why do the damn things return 0 for error and 1 for success???
> > >	Why don't they use negative error codes for failure, like
> > >	everything else in the kernel?!!
> >
> > It's a standard programming idiom:  return false (0) for failure, true
> > (non-zero) for success.  Boolean.
> 
> There are at least 3 idioms:
> 
> 1) return 0 on success, -E on fail¹.
> 
> 	rv = foo();
> 	if (rv < 0)
> 		...
> 
> 2) return 1 on YES, 0 on NO.
> 3) return valid pointer on OK, NULL on fail.
> 
> 	p = kmalloc();
> 	if (!p)
> 		...
> 
> #2 should only be used if condition in question is spelled nice:
> 
> 	if (license_is_gpl_compatible())
> 		...
> 	else
> 		ATI_you_can_fuck_off_too();
> 
> The question is into which category queue_work() fails.

Here's a general discussion...

Functions can return values of many different kinds, and one of the most
common is a value indicating whether the function succeeded or failed.  
Such a value can be represented as a "status" integer (0 = success, -Exxx
= failure) or a "succeeded" boolean (1 = success, 0 = failure).

Mixing up these two sorts of representations is a fertile source of
difficult-to-find bugs.  If the C language included a strong distinction
between integers and booleans then the compiler would find these mistakes
for us... but it doesn't.  To help prevent such errors, I suggest that the
following convention be implemented and added to
Documentation/CodingStyle:

	If the name of a function is an action or an imperative command,
	the function should return a "status" integer.  If the name is a
	predicate, the function should return a "succeeded" boolean.

	All EXPORTed functions must follow this rule, and all public
	functions should follow it.  Private (static) functions need
	not, but it is recommended that they do.

	Functions whose return value is an actual result of a computation, 
	rather than an indication of whether the computation succeeded, 
	are not subject to this rule.  Generally they indicate failure by
	returning some out-of-range result.  Typical examples would be
	functions that return pointers; they use NULL or the ERR_PTR
	mechanism to report failure.

queue_work() and friends flagrantly violate this convention.  The name 
"queue_work" clearly indicates an action or a command.  If the name were 
changed to "queue_work_succeeded" then it would be a predicate, and the 
1=success representation would be appropriate.  However this would be a 
bizarre name, since it would place more emphasis on the success of the 
operation than on the operation itself.

Other violators are down_read_trylock() and down_write_trylock().  Again,
the names suggest an action ("try to lock the rw-semaphore") and not a
predicate.  In addition, the return value meanings are opposite those
of down_trylock()!  Talk about potential for confusion...

No doubt there are other violators as well, but I can't think of any 
offhand.  People are invited to contribute a list of offenders.


On Fri, 18 Aug 2006, Andrew Morton wrote:

> The predominant convention in the kernel is 0==success and I do think that
> the change which Alan suggests would be kinder to the
> principle-of-least-surprise.
> 
> But if you're going to change the function's return conventions, please
> also rename the function.

Will do.

Alan Stern

