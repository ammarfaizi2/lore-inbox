Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266005AbUGOFqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266005AbUGOFqX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 01:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266048AbUGOFqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 01:46:23 -0400
Received: from cantor.suse.de ([195.135.220.2]:20460 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266005AbUGOFqU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 01:46:20 -0400
Date: Thu, 15 Jul 2004 07:46:18 +0200
From: Andi Kleen <ak@suse.de>
To: Roland McGrath <roland@redhat.com>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       jparadis@redhat.com, cagney@redhat.com, discuss@x86-64.org
Subject: Re: [PATCH] x86-64 singlestep through sigreturn system call
Message-Id: <20040715074618.4c33bd31.ak@suse.de>
In-Reply-To: <200407150056.i6F0uQMa010372@magilla.sf.frob.com>
References: <20040713092344.39ea00a3.ak@suse.de>
	<200407150056.i6F0uQMa010372@magilla.sf.frob.com>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jul 2004 17:56:26 -0700
Roland McGrath <roland@redhat.com> wrote:

[adding discuss@x86-64.org, maybe someone there knows more about the SYSRET
behaviour]

> > > This patch fixes the problem by forcing a fake single-step trap at the end
> > > of rt_sigreturn when PTRACE_SINGLESTEP was used to enter the system call.
> > 
> > I don't like this very much, see previous mail.
> 
> The previous mail addressed the subject of changing the behavior of i386
> processes, where single-stepping any system call misses a trap.  The native
> x86-64 behavior is different, and so this issue is really separate from
> that one.  By the way, I would love it if you could explain to me with
> references to the x86-64 chip documentation why restoring TF with sysret
> seems to trap before executing the next user instruction in 64-bit mode,
> while restoring TF with sysexit to 32-bit user mode behaves like native
> 32-bit mode (as documented) and executes one instruction before taking the
> single-step trap.

I don't think it's documented anywhere. Even the old SYSCALL/SYSRET Athlon
application note doesn't say anything about how single step is supposed
to work with this. It's probably an artifact of the first implementation
that has been faithfully reproduced since then.

> Anyway, on native x86-64 single-stepping into `syscall' already works like
> a user would expect, and takes a single-step trap immediately on return
> from the system call before executing the first user instruction.  Only
> stepping into an `rt_sigreturn' call behaves otherwise.

and a few other calls who use iret, like iopl() or sigaltstack().

Anyways, I don't have any plans to change the 64bit behaviour. gdb will
have to live with a few minor inconsistencies as price for faster system
calls. 


> > If you really wanted to do it:
> > 
> > Wouldn't it be simpler to just copy the TF bit from the previous Eflags? 
> > This special case looks quite ugly.
> 
> I would expect that to work from the behavior I think I see with other
> system calls.  But I've tried it and it doesn't work.  Setting TF this way
> behaves like the i386 does: it executes one user instruction at the
> restored PC and then traps.  I certainly find this confusing, but as I said
> above I still haven't explained to myself why it doesn't behave that way
> for normal system calls (that don't change the PC being returned to).

The normal syscalls use SYSRET, the special syscalls use IRET. That's required
because SYSRET cannot restore all registers, so sometimes a slow path out
must be taken.

-Andi

