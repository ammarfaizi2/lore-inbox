Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267005AbTAFQBs>; Mon, 6 Jan 2003 11:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267007AbTAFQBs>; Mon, 6 Jan 2003 11:01:48 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:33284 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267005AbTAFQBq>; Mon, 6 Jan 2003 11:01:46 -0500
Date: Mon, 6 Jan 2003 08:04:48 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Luca Barbieri <ldb@ldb.ods.org>
cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Set TIF_IRET in more places
In-Reply-To: <20030106144601.GA2447@ldb>
Message-ID: <Pine.LNX.4.44.0301060755510.2084-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 6 Jan 2003, Luca Barbieri wrote:
>
> This patch adds code to set TIF_IRET in sigsuspend and rt_sigsuspend
> (since they change registers to invoke signal handlers) and ptrace
> setregs.  This prevents clobbering of %ecx and %edx.

Hmm.. I explicitly thought about signals for sysenter, and I don't think 
any of these are needed. In particular, here's my logic:

 - ptrace only acts on a child that is stopped in the signal handling 
   path, so if signal handling i scorrect, then so is ptrace. So no 
   special case handling needed in ptrace.c

 - [rt_]sigsuspend() has two exit cases: (a) the signal handler we 
   invoced, and (b) the point that signal handler will eventually return
   to (ie the system call return point)

	In the eventual return case, we don't care about ecx/edx, since 
	they will have been saved on the stack by the trampoline anyway.

	In the signal handler we invoce, we also don't care about ecx/edx, 
	since they aren't part of the calling convention, and will in fact 
	have random values anyway (do_signal() will re-initialize the FP
	state, but leaves the integer regs untouched.

 - note that for normal asynchronous signals, it _is_ important that we 
   return with all registers saved, but right now that is handled by the 
   fact that the signal trampoline we build in do_signal() will always use
   "int 0x80" for the sys_sigreturn() call, and will thus use "iret" when 
   restoring the registers. The synchronous "[rt_]sigsuspend()" really is 
   a special case in that respect.

So I _think_ these are all unnecessary, but I may have missed something. 
So patch not applied, but you can certainly convince me otherwise. And 
even if I'm right, maybe it needs a comment?

		Linus

