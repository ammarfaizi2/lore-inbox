Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264779AbTAJKNB>; Fri, 10 Jan 2003 05:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264815AbTAJKNA>; Fri, 10 Jan 2003 05:13:00 -0500
Received: from dp.samba.org ([66.70.73.150]:23748 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264779AbTAJKM7>;
	Fri, 10 Jan 2003 05:12:59 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: Another idea for simplifying locking in kernel/module.c 
In-reply-to: Your message of "Fri, 10 Jan 2003 01:10:13 -0800."
             <200301100910.BAA31409@adam.yggdrasil.com> 
Date: Fri, 10 Jan 2003 21:11:41 +1100
Message-Id: <20030110102144.404492C0A6@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200301100910.BAA31409@adam.yggdrasil.com> you write:
> Rusty Russell wrote:
> >In message <200301070219.SAA12905@adam.yggdrasil.com> you write:
> >> 	Here is a way to replace all of the specialized "stop CPU"
> >> locking code in kernel/module.c with an rw_semaphore by using
> >> down_read_trylock in try_module_get() and down_write when beginning to
> >> unload the module.
> 
> >And now you can't modularize netfilter modules.
> 
> 	Why not?  Last time you went looking in the networking code
> for an example of something that had to increment a module reference
> in a context where blocking was not allowed you ended up conceding
> that you example was incorrect.

No, you're thinking of the IPv4 stack.  I didn't use netfilter as an
example, because that opens me to "well, FIX NETFILTER then!".  If it
were the only case, it's probably arguable.

The problems with netfilter modules are exactly why I started looking
at module locking over two years ago.

> 	I just booted my gateway machine to a kernel using my
> aforemetioned patch and various netfilter modules.  I've surfed the
> web, FTP'ed file and run irc through it.  It seems to be okay.

Sure!  That's because the netfilter modules use a horrific hack, by
keeping their own "usage" counts and then spinning (potentially
forever) on unload until it hits zero.

Logically the skb->nfct would have an owner field in it.

Now, performance.  You want a brlock, at least: the performance of
either the security infrastructure or netfilter modules is going to
suck horribly with anything else.  And the bogolock used in module.c
is even lighter weight than a brlock, with its associated atomic ops.

Hope that clarifies...
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
