Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317752AbSHPAGt>; Thu, 15 Aug 2002 20:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317836AbSHPAGt>; Thu, 15 Aug 2002 20:06:49 -0400
Received: from mx1.elte.hu ([157.181.1.137]:32656 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317752AbSHPAGs>;
	Thu, 15 Aug 2002 20:06:48 -0400
Date: Fri, 16 Aug 2002 02:11:14 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] user-vm-unlock-2.5.31-A2
In-Reply-To: <Pine.LNX.4.44.0208151703310.15744-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208160205190.6746-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 15 Aug 2002, Linus Torvalds wrote:

> 	process X
> 
> 	fork()			
> 			------->	Process Y
> 					clone()
> 								----> thread Z
> 
> 					exit()
> 					THIS MUST NOT
> 					WRITE TO MEMORY
> 					IN Z!!

i guess i'm just being difficult, but process (thread) Y and thread Z
share the same VM, right? So it's a threaded application, and as such i'd
expect it to free its state when exiting. Ie. it must write to memory in
Z. Now since the ->user_tid address is in thread Y's thread control block
(or any similar thread state descriptor), i cannot see any problem why
zeroing this TID value would be incorrect.

> Notice how the exit() in Y will never be able to write into the address
> space of X - it would only write into the address space of Z, and Z is
> not expecting that at all!

i think i see where the misunderstanding comes from: thread Y does not
want to get into the address space of X - this is how the current
CLEAR_TID code works and is expected to work. Threads always free their
*own* thread state descriptor upon exit (eg. they set a flag in their own
thread descriptor), not some field in the parent's domain. So thread Y
does not ever want to write into X's address space - it wants to write
into the VM that it's part of currently - if a fork() created a new VM
then so be it, it's not attached to X in any way.

	Ingo

