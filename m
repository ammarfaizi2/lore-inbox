Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261511AbUKILdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbUKILdW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 06:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbUKILcB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 06:32:01 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:17550 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261536AbUKILVI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 06:21:08 -0500
Subject: Re: [PATCH 1/11] oprofile: add check_user_page_readable()
From: Greg Banks <gnb@melbourne.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: OProfile List <oprofile-list@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041109030403.7a306fcd.akpm@osdl.org>
References: <1099996636.1985.781.camel@hole.melbourne.sgi.com>
	 <20041109030403.7a306fcd.akpm@osdl.org>
Content-Type: text/plain
Organization: Silicon Graphics Inc, Australian Software Group.
Message-Id: <1099999253.1985.823.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 09 Nov 2004 22:20:53 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-09 at 22:04, Andrew Morton wrote:
> Greg Banks <gnb@melbourne.sgi.com> wrote:
> >
> > Add check_user_page_readable() for kernel modules which need
> >  to follow user space addresses but can't use get_user().
> 
> Strange.  What is the usage pattern for this?

The i386 callgraph code attempts to follow user stacks, from
an interrupt (perfmon, NMI, or timer) where get_user() is
explicitly disallowed by Documentation/DocBook/kernel-locking.tmpl.
AFAICS from the ia64 and i386 page fault handlers get_user should
"just work" and return -EFAULT if the page isn't resident or
readable, but the doc says...

Currently this is only an issue for i386.  The ia64 code doesn't
even try to look at user stacks (shudder).

>   And why is that usage
> pattern not racy in the presence of paging activity?

The i386 backtracer takes the &current->mm->page_table_lock, and
just drops out of the trace early if a page isn't resident.  It
doesn't expect or try to page in.  After all this is only statistical
sampling not write() data.

> 
> Did you consider use_mm(), in conjunction with get_user()?

No, but glancing at use_mm() the comment says

 *      (Note: this routine is intended to be called only
 *      from a kernel thread context)

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.


