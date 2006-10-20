Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992725AbWJTXiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992725AbWJTXiE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 19:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161162AbWJTXiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 19:38:03 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:41106 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161154AbWJTXiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 19:38:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=fnlja6bovlyg/VYQFg7+j2zMdW+LOJFtyWKxCabXE9HJVMyKp4bYvkrk41Py8AVZwGSCJbkyxccl5wRSnekrz0H9uvao9te8ZabX2Of3t+6V61WkLxUFUNIYK/bP+oJHPmcuk7eYZFWw6x1BFs2kWxOpKLn5q4TQVgjP8zXi7X4=
Date: Sat, 21 Oct 2006 03:38:03 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Enforce "unsigned long flags;" when spinlocking
Message-ID: <20061020233803.GA5344@martell.zuzino.mipt.ru>
References: <20061020131544.GC17199@martell.zuzino.mipt.ru> <20061020114640.9231b18f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061020114640.9231b18f.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2006 at 11:46:40AM -0700, Andrew Morton wrote:
> On Fri, 20 Oct 2006 17:15:44 +0400
> Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > Make it break or warn if you pass to spin_lock_irqsave() and friends
> > something different from "unsigned long flags;". Suprisingly large amount of
> > these was caught by recent commit c53421b18f205c5f97c604ae55c6a921f034b0f6 .
> >
> > Idea is largely from FRV typechecking.
> >
> > Note #1: checking with sparse is still needed, because a driver can save and
> >          pass around flags or something. So far patch is very intrusive.
> > Note #2: techically, we should break only if sizeof(flags) < sizeof(unsigned long),
> >          but hey, there is opportunity to escalate. Thus !=
> > Note #3: yes, would break every single buggy out-of-tree module.
> >
>
> This is a pretty ugly-looking patch.
>
> >
> > +		BUILD_BUG_ON(sizeof(flags) != sizeof(unsigned long));	\
> > +		typecheck(unsigned long, flags);			\
> > ...
> > +		BUILD_BUG_ON(sizeof(flags) != sizeof(unsigned long));	\
> > +		typecheck(unsigned long, flags);			\
> > ...
> > +		BUILD_BUG_ON(sizeof(flags) != sizeof(unsigned long));	\
> > +		typecheck(unsigned long, flags);			\
> > ...
> > +		BUILD_BUG_ON(sizeof(flags) != sizeof(unsigned long));	\
> > +		typecheck(unsigned long, flags);			\
> > ...
> > +		BUILD_BUG_ON(sizeof(flags) != sizeof(unsigned long));	\
> > +		typecheck(unsigned long, flags);			\
> > ...
>
> starting to see a pattern here?

OK, a pattern.

> If we're going to do this then a helper macro build_check_irq_flags() would
> help clean things up.  It will also allow us to centralise the
> warning-vs-error policy decision.

I will find a common header. kernel.h probably.

> I'm not sure that we need both, do we?

I very much ask to do both.

I want build system, compiler, headers etc to do everything against
compiling buggy code. Similar to dropping rogue packets, you drop them
at the first firewall, even if your central box runs OpenBSD with all
ports closed.

In most cases it is impossible, in some cases it's cheap and simple.

So far the tower of usefullness is

	a) compiler refuses to compile
	b) linker refuses to link
	c) compiler spits warning
	d) sparse spits (endian) warning

a) is paragon of escalation.
b) is close: developer patches code, test-compile _just_one_ file and happily
   send patch. Maintatiner gets patch, does allmodconfig before sending to
   Linus, swears, fixes.
c) is also very visible, except GCC 4 doing strong as default compiler in
   distros, deprecation and must check threats; folks also drink coffee while
   Linux compiles. IIRC, there was seriously looking bug because of missed
   header => missed prototype => missed warning
			      => compiler pushes junk to stack
d) is OK, except number of people runnning sparse is orders of magnitude
   smaller that number of people compiling, consequently noticed by
   sparse bugs stay longer in tree. Add non-x86 and endian warnings not
   being default to the picture.

Enough words. The closer to a) you are, the better. There is cheap and
simple way to be there.

> If it spits a warning then it'll get fixed soon enough.

:^) You apply patch to -mm and start waiting on how soon someone will fix
gregkh-driver-nozomi.patch so it wouldn't do

	u32 flags;
but
	unsigned long flags;

everywhere.

