Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264285AbTKZSpx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 13:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264287AbTKZSpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 13:45:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:36060 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264285AbTKZSpv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 13:45:51 -0500
Date: Wed, 26 Nov 2003 10:45:41 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Bruce Perens <bruce@perens.com>
cc: Ulrich Drepper <drepper@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Never mind. Re: Signal left blocked after signal handler.
In-Reply-To: <3FC4F248.8060307@perens.com>
Message-ID: <Pine.LNX.4.58.0311261037370.1524@home.osdl.org>
References: <20031126173953.GA3534@perens.com> <Pine.LNX.4.58.0311260945030.1524@home.osdl.org>
 <3FC4ED5F.4090901@perens.com> <3FC4EF24.9040307@perens.com>
 <3FC4F248.8060307@perens.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 26 Nov 2003, Bruce Perens wrote:
>
> The test code works on 2.4, but the electric fence confidence test does
> not. Maybe something odd with SIGSEGV, which is
> what that confidence test is catching. I will go back and see why.

One difference in 2.4.x and 2.6.x is the signal blocking wrt blocked
signals that are _forced_ (ie anything that is thread-synchronous, like a
SIGSEGV/SIGTRAP/SIGBUS that happens as a result of a fault):

 - in 2.4.x they will just punch through the block
 - in 2.6.x they will refuse to punch through a blocked signal, but
   since they can't be delivered they will cause the process to be
   killed.

Trivial test program:

	#include <signal.h>
	#include <stdlib.h>

	void sigsegv(int sig)
	{
		*(int *)0=0;
	}

	int main(int argc, char **argv)
	{
		struct sigaction sa = { .sa_handler = sigsegv };

		sigaction(SIGSEGV, &sa, NULL);
		*(int *)0 = 0;
	}

and in 2.4.x this will cause infinte SIGSEGV's (well, they'll be caught by
the stack size eventually, but you see the problem: do a "strace" to see
what's going on). In 2.6.x the second SIGSEGV will just kill the program
immediately.

If you _want_ the recursive behaviour, you should add

	.sa_flags = SA_NODEFER

to the sigaction initializer.

I don't understand why your test-program works differently on 2.4.x,
though, since a "kill()" system call is _not_ thread-synchronous, and
should never punch through anything. Not even on 2.4.x.

		Linus
