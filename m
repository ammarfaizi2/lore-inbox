Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266299AbTGEHZx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 03:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266301AbTGEHZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 03:25:53 -0400
Received: from [213.39.233.138] ([213.39.233.138]:35302 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S266299AbTGEHZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 03:25:51 -0400
Date: Sat, 5 Jul 2003 09:39:46 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Paul Mackerras <paulus@samba.org>
Cc: benh@kernel.crashing.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@lists.linuxppc.org, linuxppc64-dev@lists.linuxppc.org
Subject: Re: [PATCH 2.5.73] Signal stack fixes #1 introduce PF_SS_ACTIVE
Message-ID: <20030705073946.GD32363@wohnheim.fh-wedel.de>
References: <20030703202410.GA32008@wohnheim.fh-wedel.de> <20030704174339.GB22152@wohnheim.fh-wedel.de> <20030704174558.GC22152@wohnheim.fh-wedel.de> <20030704175439.GE22152@wohnheim.fh-wedel.de> <16134.2877.577780.35071@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16134.2877.577780.35071@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 July 2003 09:18:21 +1000, Paul Mackerras wrote:
> 
> This is madness.
> 
> There is nothing in POSIX that says that you have to exit a signal
> handler by returning from it (which, under Linux, ends up doing a
> sigreturn or rt_sigreturn system call).  It is explicitly permitted to
> return from a RT signal handler with setcontext(), for instance.  And
> it is at least long-standing practice to return using longjmp().
> Neither setcontext nor longjmp will do a system call (yes, setcontext
> is a system call on sparc, but it isn't on x86 AFAIK).
> 
> So - the kernel doesn't (and can't and shouldn't need to) know about
> all transitions to or from a signal stack.  Therefore the PF_SS_ACTIVE
> bit is useless since it will be wrong some of the time.

Ack.

> Anyway, what is the problem with taking a signal on the signal stack
> when you in a signal handler using the signal stack?  You just keep
> going down the stack from where you are, which is what the code
> already does.

The problem is with a broken signal handler, that moves the stack
pointer to nirvana.  You get a signal, set up the signal stack, move
the pointer to nirvana, get a signal, set up the signal stack, move
the pointer to nirvana, get a signal, ...

If I was just going down the signal stack, I would be perfectly happy,
but instead the kernel believes each signal is the very first on the
signal stack and sets it up again (and again...) each time.

> BTW, I am the PPC maintainer; Ben is the powermac maintainer.

Sorry about that.

Jörn

-- 
Measure. Don't tune for speed until you've measured, and even then
don't unless one part of the code overwhelms the rest.
-- Rob Pike
