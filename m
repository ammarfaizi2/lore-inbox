Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265096AbTAFVZk>; Mon, 6 Jan 2003 16:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267170AbTAFVZk>; Mon, 6 Jan 2003 16:25:40 -0500
Received: from egil.codesourcery.com ([66.92.14.122]:16008 "EHLO
	egil.codesourcery.com") by vger.kernel.org with ESMTP
	id <S265096AbTAFVZj>; Mon, 6 Jan 2003 16:25:39 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Set TIF_IRET in more places
From: Zack Weinberg <zack@codesourcery.com>
Date: Mon, 06 Jan 2003 13:34:16 -0800
Message-ID: <87isx2dktj.fsf@egil.codesourcery.com>
User-Agent: Gnus/5.090011 (Oort Gnus v0.11) Emacs/21.2 (i386-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus Torvalds wrote:

> - note that for normal asynchronous signals, it _is_ important that
>   we return with all registers saved, but right now that is handled
>   by the fact that the signal trampoline we build in do_signal()
>   will always use "int 0x80" for the sys_sigreturn() call, and will
>   thus use "iret" when restoring the registers. The synchronous
>   "[rt_]sigsuspend()" really is a special case in that respect.

Consider SA_RESTORER - there isn't a guarantee that user space will
use the same code as the kernel's trampoline.  glibc happens to, but
only because GDB has a hardwired idea of what a signal trampoline
looks like.  Of course, you could simply document that sigreturn() is
another of the system calls that must be made through int 0x80.

It occurs to me that the kernel-provided signal trampoline could go in
the page at 0xffff0000, instead of on the user stack, which would
eliminate the need for glibc to set SA_RESTORER (it's a pure
optimization).

Tangentially, I've seen people claim that the trampoline ought to be
able to avoid entering the kernel, although I'm not convinced (how
does the signal mask get reset, otherwise?)

zw
