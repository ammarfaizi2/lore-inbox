Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263461AbTETCLj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 22:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263462AbTETCLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 22:11:39 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:7115 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263461AbTETCLh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 22:11:37 -0400
Date: Mon, 19 May 2003 18:23:05 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Daniel Phillips <phillips@arcor.de>, hch@infradead.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] vm_operation to avoid pagefault/inval race
Message-ID: <20030519182305.C1813@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <200305172021.56773.phillips@arcor.de> <20030517124948.6394ded6.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030517124948.6394ded6.akpm@digeo.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 17, 2003 at 12:49:48PM -0700, Andrew Morton wrote:
> Daniel Phillips <phillips@arcor.de> wrote:
> >
> > and the only problem is, we have to change pretty well every 
> >  filesystem in and out of tree.
> 
> But it's only a one-liner per fs.

So the general idea is to do something as follows, right?
(Sorry for not just putting together a patch -- I want
to make sure I understand all of your advice first!)

o	Make all callers to do_no_page() instead call
	vma->vm_ops->nopage().

o	Make a function, perhaps named something like
	install_new_page(), that does the PTE-installation
	and RSS-adjustment tasks currently performed by
	both do_no_page() and by do_anonymous_page().
	(Not clear to me yet whether a full merge of
	these two functions is the right approach, more
	thought needed.  Note that the nopage function
	is implicitly aware of whether it is handling
	an anonymous page or not, so a pair of functions
	that both call another function containing the
	common code is reasonable, if warranted.)

	The install_new_page() function needs an additional
	argument to accept the new_page value that used
	to be returned by the nopage() function.

o	Add arguments to nopage() to allow it to invoke
	install_new_page().

o	Change all nopage() functions to invoke install_new_page(),
	but only in cases where they would -not- return
	VM_FAULT_OOM or VM_FAULT_SIGBUS.  In these cases,
	these two return codes must be handed back to the
	caller without invoking install_new_page().

o	Otherwise, the value that these nopage() functions
	would normally return must be passed to
	install_new_page(), and the value returned by
	install_new_page() must be returned to the nopage()
	function's caller.

o	Replace all occurrences of "->vm_ops = NULL" with
	"->vm_ops = anonymous_vm_ops" or some such.

o	The anonymous_vm_ops would have the following members:

	nopage: pointer to a function containing the page-allocation
		code extracted from do_anonymous_page(), followed
		by a call to install_new_page().

	populate: NULL.

	open: NULL.

	close: NULL.

Thoughts?

					Thanx, Paul
