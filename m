Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbTGFMhP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 08:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbTGFMhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 08:37:15 -0400
Received: from [213.39.233.138] ([213.39.233.138]:9394 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262123AbTGFMhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 08:37:14 -0400
Date: Sun, 6 Jul 2003 14:51:03 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: benh@kernel.crashing.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev@lists.linuxppc.org, linuxppc64-dev@lists.linuxppc.org
Subject: Re: [PATCH 2.5.73] Signal stack fixes #1 introduce PF_SS_ACTIVE
Message-ID: <20030706125103.GB23341@wohnheim.fh-wedel.de>
References: <20030705104428.GA19311@wohnheim.fh-wedel.de> <Pine.LNX.4.44.0307051013140.5900-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0307051013140.5900-100000@home.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 July 2003 10:16:26 -0700, Linus Torvalds wrote:
> 
> Hmm? I tried it, and for me it does:
> 
> 	torvalds@home:~> ./a.out 
> 	SIGNAL .... 11
> 	Segmentation fault

Weird.  I've fixed the bracket stuff, but that's about it.

> but I have to admit that I didn't even try it before my kernel change, so 
> maybe it worked for me before too ;)
> 
> There could easily be glibc version issues here, ie maybe your library 
> sets SA_NOMASK and mine doesn't.

Hopefully not.

But all that doesn't matter, as your change appears to be worse for
threading libraries, than mine.  Imagine a thread that almost busted
it's stack limit.  The signal code tries to add the extra stack
frames, fails, and calls force_sig(SIGSEGV).  Shooting through the
signal mask, the SIGSEGV can be handled by killing off one thread, or
maby even recovering.  With your patch, it will always get killed.

My current best idea is to check, whether the stack pointer is valid
before going to the signal stack.  As long as it points to memory that
is writable for the current process, things are not completely
hopeless.  When the stack is totally broken, kill that cancer cell.

Working on a translation to diff -u right now.

Jörn

-- 
Invincibility is in oneself, vulnerability is in the opponent.
-- Sun Tzu
