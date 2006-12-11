Return-Path: <linux-kernel-owner+w=401wt.eu-S1762434AbWLKEue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762434AbWLKEue (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 23:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762428AbWLKEud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 23:50:33 -0500
Received: from smtp.osdl.org ([65.172.181.25]:42713 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762413AbWLKEuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 23:50:32 -0500
Date: Sun, 10 Dec 2006 20:49:31 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: linux@horizon.com
cc: nickpiggin@yahoo.com.au, linux-arch@vger.kernel.org,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an
In-Reply-To: <20061211023054.2622.qmail@science.horizon.com>
Message-ID: <Pine.LNX.4.64.0612102040490.12500@woody.osdl.org>
References: <20061211023054.2622.qmail@science.horizon.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 10 Dec 2006, linux@horizon.com wrote:
> 
> While I agree that LL/SC can't be part of the kernel API for people to
> get arbitrarily clever with in the device driver du jour, they are *very*
> nice abstractions for shrinking the arch-specific code size.

I'm not sure. 

The thing is, it's _really_ hard to tell the compiler to not reload values 
from memory in between two inline asm statements.

So what you easily end up with is 
 (a) yes, you can actually get the compiler to generate the "obvious" code 
     sequence 99% of the time, and it will all work fine.
 (b) but it's really hard to actually guarantee it, and some subtle things 
     can really mess you up.

An example of (b) is how we actually put some of these atomic data 
structures on the stack ("struct completion" comes to mind), and it can 
get really interesting it something works in all the tests, but then 
subtly breaks on some microarchitectures when the data structures happen 
to be on the stackjust because the compiler happened to do a register 
reload to the stack at the wrong point.

Now, if you don't inline any of these things, you can control things a lot 
better, since then you end up having a much smaller set of circumstances, 
and you never have code "around" the actual operation that changes things 
like register reload. And yes, I do think that it might be possible to 
have some kind of generic "ll/sc template" setup for that case. You can 
often make gcc generate the code you want, especially if there is no real 
register pressure and you can keep the code simple.

> The semantics are widely enough shared that it's quite possible in
> practice to write a good set of atomic primitives in terms of LL/SC
> and then let most architectures define LL/SC and simply #include the
> generic atomic op implementations.

Well, you do have to also realize that the architectures that dont' do 
ll/sc do end up limiting the number of useful primitives, especially 
considering that we know that some architectures simply cannot do a lot 
between them (which _also_ limits it).

I think we've ended up implementing most of the common ones. We have a 
fairly big set of ops like "atomic_add_return()"-like operations, and 
those are the obvious ones that can be done for _any_ ll/sc architecture 
too. So I don't think there's all that much more to be had there.

		Linus
