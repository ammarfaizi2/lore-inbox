Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266693AbSKQWxj>; Sun, 17 Nov 2002 17:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266797AbSKQWxi>; Sun, 17 Nov 2002 17:53:38 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:63248 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266693AbSKQWxh>; Sun, 17 Nov 2002 17:53:37 -0500
Date: Sun, 17 Nov 2002 15:00:24 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Ulrich Drepper <drepper@redhat.com>, Luca Barbieri <ldb@ldb.ods.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] threading fix, tid-2.5.47-A3
In-Reply-To: <Pine.LNX.4.44.0211172132070.13235-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0211171452480.13106-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 17 Nov 2002, Ingo Molnar wrote:
> 
> here are the my current TID-setting changes. It's now 3 clone flags:

Hmm.. I really ahve to say that I just prefer the current two flags, and I 
don't see any advantage to the three flag thing, and I do see 
disadvantages:

 - no real new semantic behaviour.
 - the async nature of CLONE_CHILD_SETTID is just bound to cause 
   interesting-to-debug behaviour

Basically, the current two-flag approach gives all the behaviour the 
three-flag thing does, with no downsides:

 - if the fork() is a CLONE_VM, the parent/child VM is the same, and the 
   two flags are really all you need, agreed?

 - the the for is _not_ a CLONE_VM, the child is really an independent 
   VM thing, and we should not even _allow_ the parent to change the VM of 
   the child: the SETTID behaviour (where it changes the parent VM) makes 
   sense and is good, but we should probably disallow CLEARTID altogether 
   for that case (and if the independent child wants to clear its own 
   memory space on exit, it should just do a set_tid_address() itself)

In fact, from what I can tell, your new CLONE_CHILD_SETTID really is 100% 
semantically equivalent to the child just doing a "set_tid_address()" on 
its own.

In short, I really don't see the advantage of this patch. I don't think
it's "evil and wrong" in any way, I just think that the lack of reason for
it would argue _against_ making clone() a bit more complicated and 
breaking existing behaviour..

Hmm? I _think_ NPTL is fine with the current semantics, right? It just
sets both of the current flags, and that's all it really wants? Uli?

		Linus

