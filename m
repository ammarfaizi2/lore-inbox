Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbUKILdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbUKILdV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 06:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbUKILcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 06:32:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:6853 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261506AbUKIL1G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 06:27:06 -0500
Date: Tue, 9 Nov 2004 03:26:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Greg Banks <gnb@melbourne.sgi.com>
Cc: oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/11] oprofile: add check_user_page_readable()
Message-Id: <20041109032658.5d67d5e3.akpm@osdl.org>
In-Reply-To: <1099999253.1985.823.camel@hole.melbourne.sgi.com>
References: <1099996636.1985.781.camel@hole.melbourne.sgi.com>
	<20041109030403.7a306fcd.akpm@osdl.org>
	<1099999253.1985.823.camel@hole.melbourne.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Banks <gnb@melbourne.sgi.com> wrote:
>
> On Tue, 2004-11-09 at 22:04, Andrew Morton wrote:
> > Greg Banks <gnb@melbourne.sgi.com> wrote:
> > >
> > > Add check_user_page_readable() for kernel modules which need
> > >  to follow user space addresses but can't use get_user().
> > 
> > Strange.  What is the usage pattern for this?
> 
> The i386 callgraph code attempts to follow user stacks, from
> an interrupt (perfmon, NMI, or timer)

Yikes.

> where get_user() is
> explicitly disallowed by Documentation/DocBook/kernel-locking.tmpl.
> AFAICS from the ia64 and i386 page fault handlers get_user should
> "just work" and return -EFAULT if the page isn't resident or
> readable, but the doc says...
> 
> Currently this is only an issue for i386.  The ia64 code doesn't
> even try to look at user stacks (shudder).
> 
> >   And why is that usage
> > pattern not racy in the presence of paging activity?
> 
> The i386 backtracer takes the &current->mm->page_table_lock,

But that cannot be taken from interrupt context.  A trylock would be OK I
guess.

> and
> just drops out of the trace early if a page isn't resident.  It
> doesn't expect or try to page in.  After all this is only statistical
> sampling not write() data.
> 
> > 
> > Did you consider use_mm(), in conjunction with get_user()?
> 
> No, but glancing at use_mm() the comment says
> 
>  *      (Note: this routine is intended to be called only
>  *      from a kernel thread context)

It could probably be made to work from a normal process, but not from
interrupt context.

I guess I should apply the patches and take a closer look.
