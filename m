Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263573AbTETGOa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 02:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263580AbTETGOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 02:14:30 -0400
Received: from mx2.elte.hu ([157.181.151.9]:58526 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id S263573AbTETGO3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 02:14:29 -0400
Date: Tue, 20 May 2003 08:27:03 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Ulrich Drepper <drepper@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] futex requeueing feature, futex-requeue-2.5.69-D3 
In-Reply-To: <20030520014836.C7BDE2C069@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0305200821010.2445-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 20 May 2003, Rusty Russell wrote:

> > It wasn't Ingo's idea.  I suggested it.  Overloading parameter types is
> > evil.  This isn't an issue anymore if the extension is implemented as a
> > new syscall which certainly is better.
> 
> People are using the interface, [...]

it's a _new_ argument, only used by new glibc. Like i mentioned it in the
original announcement, it's fully backwards compatible with any older app.
This is a minimum requirement for a live syscall!

> [...] so I don't think changing it because "it's nicer this way" is
> worthwhile: Ingo's "new syscall" patch has backwards compat code for the
> old syscalls.  That's fugly 8(

yes, but the damage has been done already, and now we've got to start the
slow wait for the old syscall to flush out of our tree. It will a few
years to get rid of the compat code, but we better start now. hch is
perfectly right that the old futex multiplexer interface is quite ugly,
the requeue op only made this even more prominent.

> Comment says: /* Must be "naturally" aligned */.  This used to be true
> in a much earlier version of the code, now AFAICT the requirement test
> should be:
> 
> 	/* Handling futexes on multiple pages?  -ETOOHARD */
> 	if (pos_in_page + sizeof(u32) > PAGE_SIZE)
> 		return -EINVAL;

yes - but i'd rather enforce this for every futex, than to hit it in every
1000th app that manages to misalign a futex _and_ lay it across two pages.  

Also, it's only x86 that guarantees atomic instructions on misaligned
futexes (even then it comes with a cycle penalty), are you sure this also
works on other architectures? So i'd rather be a bit more strict with this
requirement.

	Ingo

