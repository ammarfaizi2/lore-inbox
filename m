Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265074AbUGOBXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265074AbUGOBXj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 21:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbUGOBXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 21:23:39 -0400
Received: from mail3.speakeasy.net ([216.254.0.203]:45743 "EHLO
	mail3.speakeasy.net") by vger.kernel.org with ESMTP id S266130AbUGOA4e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 20:56:34 -0400
Date: Wed, 14 Jul 2004 17:56:26 -0700
Message-Id: <200407150056.i6F0uQMa010372@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andi Kleen <ak@suse.de>
X-Fcc: ~/Mail/linus
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       jparadis@redhat.com, cagney@redhat.com
Subject: Re: [PATCH] x86-64 singlestep through sigreturn system call
In-Reply-To: Andi Kleen's message of  Tuesday, 13 July 2004 09:23:44 +0200 <20040713092344.39ea00a3.ak@suse.de>
X-Windows: the problem for your problem.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This patch fixes the problem by forcing a fake single-step trap at the end
> > of rt_sigreturn when PTRACE_SINGLESTEP was used to enter the system call.
> 
> I don't like this very much, see previous mail.

The previous mail addressed the subject of changing the behavior of i386
processes, where single-stepping any system call misses a trap.  The native
x86-64 behavior is different, and so this issue is really separate from
that one.  By the way, I would love it if you could explain to me with
references to the x86-64 chip documentation why restoring TF with sysret
seems to trap before executing the next user instruction in 64-bit mode,
while restoring TF with sysexit to 32-bit user mode behaves like native
32-bit mode (as documented) and executes one instruction before taking the
single-step trap.

Anyway, on native x86-64 single-stepping into `syscall' already works like
a user would expect, and takes a single-step trap immediately on return
from the system call before executing the first user instruction.  Only
stepping into an `rt_sigreturn' call behaves otherwise.

> If you really wanted to do it:
> 
> Wouldn't it be simpler to just copy the TF bit from the previous Eflags? 
> This special case looks quite ugly.

I would expect that to work from the behavior I think I see with other
system calls.  But I've tried it and it doesn't work.  Setting TF this way
behaves like the i386 does: it executes one user instruction at the
restored PC and then traps.  I certainly find this confusing, but as I said
above I still haven't explained to myself why it doesn't behave that way
for normal system calls (that don't change the PC being returned to).


Thanks,
Roland
