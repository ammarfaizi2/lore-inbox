Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266251AbTGJBh3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 21:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266258AbTGJBh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 21:37:29 -0400
Received: from dp.samba.org ([66.70.73.150]:31885 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266251AbTGJBh2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 21:37:28 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: davidm@hpl.hp.com
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com, ak@suse.de
Subject: Re: per_cpu fixes 
In-reply-to: Your message of "Wed, 09 Jul 2003 14:20:29 MST."
             <200307092120.h69LKTBH002759@napali.hpl.hp.com> 
Date: Thu, 10 Jul 2003 11:41:07 +1000
Message-Id: <20030710015208.1E7A22C44B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200307092120.h69LKTBH002759@napali.hpl.hp.com> you write:
> Rusty,
> 
> Care needs to be taken when taking the address of a CPU-local
> variable, because otherwise things may break when comparing addresses
> on a platform which uses virtual remapping to implement such
> variables.  In particular, it's almost always unsafe to use the
> address of a per-CPU variable which contains a "struct list", because
> the list-manipulation routines use the list-head address to detect the
> end of the list etc.

The horror.  Such rules are entirely too much problem to push on the
poor programmer 8(

When I implemented this, I imagined archs putting their per-cpu offset
inside a register, so they could get to their vars in one instruction,
but not the IA64 remapping thing.  We are now suffering because of my
limited imagination (which David has commented on before 8).

A compromise is possible.  I believe that the address of a per-cpu
variable *must* be the same everywhere, but we can provide get & set
macros which never expose an lvalue, and on IA64 could use the pinned
TLB thing:

/* Usage: set_cpu_local(myint, = 1), or set_cpu_local(mystruct,.member = 1) */
#define set_cpu_local(var, assign) ...

/* Usage: get_cpu_local(myint), or get_cpu_local(mystruct).member */
#define get_cpu_local(var) ...

I rejected such an approach before when Andi Kleen asked for it (IIRC
he wanted to use %gs as the per-cpu ptr, but couldn't easily produce
an lvalue), because I wanted a nice, clean interface.  However, recent
gcc handles the struct result of the statement expression flawlessly
AFAICT, so I'm less inclined to resist.

Thoughts?
Rusty.
PS. David, this is your revenge for making more work for you, isn't it?
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
