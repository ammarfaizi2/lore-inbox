Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267552AbSKQSrp>; Sun, 17 Nov 2002 13:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267553AbSKQSrp>; Sun, 17 Nov 2002 13:47:45 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13062 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267552AbSKQSro>; Sun, 17 Nov 2002 13:47:44 -0500
Date: Sun, 17 Nov 2002 10:54:42 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ulrich Drepper <drepper@redhat.com>
cc: Ingo Molnar <mingo@elte.hu>, Luca Barbieri <ldb@ldb.ods.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] threading fix, tid-2.5.47-A3
In-Reply-To: <3DD7E3E7.6040403@redhat.com>
Message-ID: <Pine.LNX.4.44.0211171047160.22525-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 17 Nov 2002, Ulrich Drepper wrote:
> 
> It doesn't do this.  Ingo's description simply wasn't right.
> 
> The syscall is used in one place and this is when the thread library
> gets initialized.  I never gets used unconditionally and in situations
> where the process is not prepared.

Ok, good. That means that "sys_set_userpid()" is fine with me.

That still leaves the other part of the patch. I do not think that SETTID
and CLEARTID should be mixed together. There are perfectly valid reasons
why a parent wants SETTID even when it _doesn't_ want CLEARTID.

In fact, SETTID is clearly useful even without threads, and exactly for
the case that Ingo apparently broke with his patch: the parent wants to
atomically save the TID of the child in the _parents_ address space (so
that a immediate SIGCHLD won't be racy with saving off the pid by the
parent).

So Ingo, please send me just the sys_set_userpid() parts, and revert your 
broken code that made SETTID do bad things and only work for threads.

There's no reason to make SETTID/CLEARTID be one flag, since they are
clearly different things, and NPTL can just always set both bits if that
is the behaviour glibc wants (and I agree with that behaviour, of course. 
I just disagree with not allowing others to do different things).

			Linus


