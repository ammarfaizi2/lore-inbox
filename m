Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbTKODL7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 22:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbTKODL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 22:11:59 -0500
Received: from fw.osdl.org ([65.172.181.6]:22992 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261305AbTKODL5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 22:11:57 -0500
Date: Fri, 14 Nov 2003 19:11:55 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Mackerras <paulus@samba.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PPC32: cancel syscall restart on signal delivery
In-Reply-To: <16309.38562.950351.137425@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.44.0311141906160.9014-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 15 Nov 2003, Paul Mackerras wrote:
> 
> (Having interrupts disabled during do_signal is interesting, given
> that its subroutines call __put_user and friends. :)

Actually, look closer. We don't do that.

Why? Check out get_signal_to_deliver(). And grok the absolute horridness.

> Thus I think the race was possibly a little wider on PPC than on x86:
> we didn't have to get back to userspace, the interrupt could happen
> during do_signal.

No. If it happens during do_signal() (on x86 or ppc), we'd just not
_handle_ the signal at all. We'd return to user space, restart the system 
call, and handle the signal as the restarted system call is returning. No 
bug.

In short, even on ppc, the window _literally_ is "after we've returned, 
but before we restart". 

> Now you have me scared, because I can't see where the restart_syscall
> system call resets current_thread_info()->restart_block.fn to
> do_no_restart_syscall.

It doesn't. 

The rule is: the restart_block is _only_ meaningful if you return 
-ERESTART_BLOCK. So at any other time it contains stale data.

> Am I missing something?  Perhaps we should reset restart_block.fn in
> sys_{,rt_}sigreturn, or possibly in sys_restart_syscall.

You're missing that the only thing that ever looks at restart_block is the 
code that is inside the signal handling of ERESTART_BLOCK.

The bug was that sometimes we had _already_ done that ERESTART_BLOCK 
handling (correctly), but then basically "aborted" (thanks to another 
signal) before the restart had actually taken effect.

And that race literally is only in user mode.

		Linus

