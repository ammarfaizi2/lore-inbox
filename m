Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266585AbTGKBrR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 21:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266584AbTGKBrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 21:47:16 -0400
Received: from dp.samba.org ([66.70.73.150]:40664 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266585AbTGKBrG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 21:47:06 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: davidm@hpl.hp.com
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com, ak@suse.de
Subject: Re: per_cpu fixes 
In-reply-to: Your message of "Thu, 10 Jul 2003 10:55:06 MST."
             <16141.43130.657025.952793@napali.hpl.hp.com> 
Date: Fri, 11 Jul 2003 12:01:08 +1000
Message-Id: <20030711020147.96A282C113@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <16141.43130.657025.952793@napali.hpl.hp.com> you write:
> You mean there would be three primitives:
> 
>  (1) get value from a per-CPU variable
>  (2) set value of a per-CPU variable
>  (3) get the (canonical) address of a per-CPU variable
> 
> ?

Almost, #3 would actually be "get lvalue", as now.

The only problem is that a quick audit of 2.5.75 reveals 16 places in
generic code where set/get primitives would work without jumping
through hoops, out of 43.

New idea:

Provide cpu_local_inc(var)/cpu_local_dec(var) and __cpu_local_inc(var)
and __cpu_local_dec(var).  Generic implementation:

  /* This is local.h */
  typedef atomic_t local_t;

  #define local_inc(l) atomic_inc(l)
  #define local_dec(l) atomic_dec(l)

  /* l is a per-cpu local_t.  Increment it atomically. */
  #define cpu_local_inc(l) local_inc(&__get_cpu_var(l))
  #define cpu_local_dec(l) local_dec(&__get_cpu_var(l))

  /* Increment non-atomically (must have preempt disabled) */
  #define __cpu_local_inc(l) \
	atomic_set(&__get_cpu_var(l), atomic_read(&__get_cpu_var(l)) + 1)
  #define __cpu_local_dec(l) \
	atomic_set(&__get_cpu_var(l), atomic_read(&__get_cpu_var(l)) - 1)

This catches one common case for ia64 to use the magic pinned area,
and also allows x86 to use its incl/decl instructions, which both
networking stats and module refcounts have wanted for a while.

Thoughts?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
