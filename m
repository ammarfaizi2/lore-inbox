Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135293AbRDWRk3>; Mon, 23 Apr 2001 13:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135380AbRDWRkT>; Mon, 23 Apr 2001 13:40:19 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:35079 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135293AbRDWRkG>; Mon, 23 Apr 2001 13:40:06 -0400
Date: Mon, 23 Apr 2001 10:39:28 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Eric W. Biederman" <ebiederman@lnxi.com>
cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Longstanding elf fix (2.4.3 fix)
In-Reply-To: <m3snizbo0c.fsf@DLT.linuxnetworx.com>
Message-ID: <Pine.LNX.4.21.0104231035240.13206-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 23 Apr 2001, Eric W. Biederman wrote:
> 
> ptrace is protected by the big kernel lock, but exec isn't so that
> doesn't help.  Hmm.  ptrace does require that the process be stopped
> in all cases

Right. Ptrace definitely cannot access a process at "arbitrary" times. In
fact, it is very serialized indeed, in that it can only access a process
at "signal points", ie effectively when it is returning to user space.

With threads, of course, that doesn't help us. But with threads, the other
threads could have caused the same page faults, so ptrace() isn't actually
adding any "new" cases in that sense.

I'd be a lot more worried about /proc accesses.

execve() doesn't really need the mm semaphore, but on the other hand it
would be cleaner to get it, and it won't really hurt (there can not be any
real contention on it anyway - the only contention might come through
/proc, and I haven't looked at what that might imply).

load-library should definitely get it. I thought it did already, but..

Did you have a patch? Maybe I missed it.

		Linus

