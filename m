Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261501AbUJaFD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbUJaFD2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 01:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbUJaFD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 01:03:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:30592 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261501AbUJaFDW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 01:03:22 -0400
Date: Sat, 30 Oct 2004 22:03:20 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Roland Dreier <roland@topspin.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Sparse "context" checking..
In-Reply-To: <52d5yzwmqb.fsf@topspin.com>
Message-ID: <Pine.LNX.4.58.0410302158230.28839@ppc970.osdl.org>
References: <Pine.LNX.4.58.0410302005270.28839@ppc970.osdl.org>
 <52d5yzwmqb.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 30 Oct 2004, Roland Dreier wrote:
>
>     Linus> In particular, this is designed for doing things like
>     Linus> matching up a "lock" with the pairing "unlock", and right
>     Linus> now that's exactly what the code does: it makes each
>     Linus> spinlock count as "+1" in the context, and each spinunlock
>     Linus> count as "-1", and then hopefully it should all add up.
> 
> Do you have a plan for how to handle functions like spin_trylock()?  I
> notice in the current tree you just didn't annotate spin_trylock().

Actually, the _current_ tree does actually annotate spin_trylock() (as of
just before I sent out the email). It looks like

	#define spin_trylock(lock)      __cond_lock(_spin_trylock(lock))

where __cond_lock() for sparse is

	include/linux/compiler.h:# define __cond_lock(x)        ((x) ? ({ __context__(1); 1; }) : 0)

ie we add a "+1" context marker for the success case.

NOTE! This works with sparse only because sparse does immediate constant 
folding, so if you do

	if (spin_trylock(lock)) {
		..
		spin_unlock(lock);
	}

sparse linearizes that the right way unconditionally, and even though 
there is a data-dependency, the data depenency is constant. However, if 
some code does

	success = spin_trylock(lock);
	if (success) {
		..
		spin_unlock(lock);
	}

sparse would complain about it, because sparse doesn't do any _real_ data 
flow analysis.

So sparse can follow all the obvious cases, including trylock and
"atomic_dec_and_lock()".

			Linus
