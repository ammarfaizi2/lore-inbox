Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273957AbSISX77>; Thu, 19 Sep 2002 19:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273983AbSISX77>; Thu, 19 Sep 2002 19:59:59 -0400
Received: from dp.samba.org ([66.70.73.150]:12486 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S273957AbSISX76>;
	Thu, 19 Sep 2002 19:59:58 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: kaos@ocs.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] In-kernel module loader 1/7 
In-reply-to: Your message of "Thu, 19 Sep 2002 15:54:40 +0200."
             <Pine.LNX.4.44.0209191532110.8911-100000@serv> 
Date: Fri, 20 Sep 2002 09:44:23 +1000
Message-Id: <20020920000502.242CF2C100@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0209191532110.8911-100000@serv> you write:
> Hi,
> 
> On Thu, 19 Sep 2002, Rusty Russell wrote:
> 
> > If every single object in the kernel is reference counted, *yes* you
> > can do this.  But they're not, and they will never be.  Changing them
> > over to use try_module_get() is feasible, though.
> 
> Rusty, slowly I'm pissed. :(

Sorry if I haven't been as clear as I might wish.  I shall try: I do
appreciate your patience.

1) You keep ignoring the load race problem.  Your solution does not
   solve that, so you will need something else as well.

2) Several places in the kernel do *not* keep reference counts, for
   example net/core/dev.c's dev_add_pack and dev_remove_pack.  You
   want to add reference counts to all of them, but the only reason
   for the reference counts is for module unload: you are penalizing
   everyone just *in case* one is a module.

3) The cost of doing atomic_incs and decs on eg. our network performance
   is simply unacceptable.  The only way to avoid hitting the same
   cacheline all the time is to use bigrefs, and the kernel bloat will
   kill us (and they're still not free for the 99% of people who don't
   have IPv4 and TCP as modules).

4) Your solution does not allow implementation of "rmmod -f" which
   prevents module count from increasing, and removes it when it is
   done.  This is very nice when your usage count is controlled by an
   external source (eg. your network).

Now, your proposal *can* be modified to address these things, but I'm
not sure you'll like your proposale when that's done 8(

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
