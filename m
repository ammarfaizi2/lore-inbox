Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266214AbTGDXED (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 19:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266222AbTGDXEC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 19:04:02 -0400
Received: from dp.samba.org ([66.70.73.150]:61654 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266214AbTGDXDw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 19:03:52 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <16134.2877.577780.35071@cargo.ozlabs.ibm.com>
Date: Sat, 5 Jul 2003 09:18:21 +1000
From: Paul Mackerras <paulus@samba.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: benh@kernel.crashing.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@lists.linuxppc.org, linuxppc64-dev@lists.linuxppc.org
Subject: Re: [PATCH 2.5.73] Signal stack fixes #1 introduce PF_SS_ACTIVE
In-Reply-To: <20030704175439.GE22152@wohnheim.fh-wedel.de>
References: <20030703202410.GA32008@wohnheim.fh-wedel.de>
	<20030704174339.GB22152@wohnheim.fh-wedel.de>
	<20030704174558.GC22152@wohnheim.fh-wedel.de>
	<20030704175439.GE22152@wohnheim.fh-wedel.de>
X-Mailer: VM 7.16 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel writes:

> This should be the ppc specific part of the signal stack fixes.  It sets the
> flag, when switching to the signal stack and clears it, when switching
> back.  When the kernel tries to switch to the signal stack again,   
> without switching back, the process screwed up the signal stack, so we
> kill it with a SIGSEGV.

This is madness.

There is nothing in POSIX that says that you have to exit a signal
handler by returning from it (which, under Linux, ends up doing a
sigreturn or rt_sigreturn system call).  It is explicitly permitted to
return from a RT signal handler with setcontext(), for instance.  And
it is at least long-standing practice to return using longjmp().
Neither setcontext nor longjmp will do a system call (yes, setcontext
is a system call on sparc, but it isn't on x86 AFAIK).

So - the kernel doesn't (and can't and shouldn't need to) know about
all transitions to or from a signal stack.  Therefore the PF_SS_ACTIVE
bit is useless since it will be wrong some of the time.

Anyway, what is the problem with taking a signal on the signal stack
when you in a signal handler using the signal stack?  You just keep
going down the stack from where you are, which is what the code
already does.

BTW, I am the PPC maintainer; Ben is the powermac maintainer.

Paul.
