Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261971AbSIYMul>; Wed, 25 Sep 2002 08:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261972AbSIYMul>; Wed, 25 Sep 2002 08:50:41 -0400
Received: from dp.samba.org ([66.70.73.150]:8593 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261971AbSIYMuk>;
	Wed, 25 Sep 2002 08:50:40 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] In-kernel module loader 1/7 
In-reply-to: Your message of "Wed, 25 Sep 2002 13:36:30 +0200."
             <Pine.LNX.4.44.0209251147250.338-100000@serv> 
Date: Wed, 25 Sep 2002 22:53:44 +1000
Message-Id: <20020925125556.6321A2C387@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0209251147250.338-100000@serv> you write:
> Rusty, have you understood, what my new module layout is all about?

Not a clue.

> If you understood it, it will be certainly no problem for you to show me,
> where my claim is flawed.

OK, assume all (sane) designs have some part inside the kernel, and
some part outside.  My version almost all kernel: "here is a module and
some args".

Once you move the linking outside the kernel, you need to communicate
more information.  You need some form of "allocate", and "here is all
the other symbol information", then "please tell me what you used so I
can update the reference counts" and "place linked module".  So you've
added some complexity to deal with synchronization of these acts with
a userspace process.

Now, say your architecture decided that it wanted to try to allocate
its modules: it wants to allocate one part for init and one for core
(so the init can be easily discarded), but if they're not close
enough, it'll give up and allocate one big one and not discard init.

But half if it is in userspace, so you have to support both in the
kernel and both in userspace while you are in transition.  Or, say the
kernel slightly changes the way it parses boot paramters and you
wanted the module to match?  Or you wanted to change the version
encoding?  Or something else I don't know about yet?

Let's look at what we can expect to remove from the kernel by moving
the linking stage out.  Probably the most complex architecture to link
is ia64.  And that linker is 507 lines (approx, it needs to be updated
to the latest patch).  x86 is 130 lines.  Add maybe 200 lines of
arch-independent code to help.

It it *now* clear why I'm not interested in saving a few hundred lines
of kernel code, even if the communication overhead didn't eat them up
again?

Hope this makes my point clear,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
