Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265207AbUBAEis (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 23:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265210AbUBAEis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 23:38:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:7823 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265207AbUBAEiq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 23:38:46 -0500
Date: Sat, 31 Jan 2004 20:38:43 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Daniel Jacobowitz <dan@debian.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Roland McGrath <roland@redhat.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: More waitpid issues with CLONE_DETACHED/CLONE_THREAD
In-Reply-To: <20040201032525.GA10254@nevyn.them.org>
Message-ID: <Pine.LNX.4.58.0401312014420.2033@home.osdl.org>
References: <20040201032525.GA10254@nevyn.them.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 31 Jan 2004, Daniel Jacobowitz wrote:
>
> This may be related to the python bug reported today...

Indeed.

Having a "waitpid(x, .., WNOHANG)" return 0 is a very interesting 
condition. That condition basically guarantees that:

 - the kernel did find the child
 - but the kernel decided that the child cannot be reaped right then.

If you see the process as a Zombie in a "ps" listing, then we know that 
that isn't the reason why it couldn't be reaped. Can you verify that 
/proc/<pid>/status shows it as "Z (zombie)"?

In fact, if we see it as "Z (zombie)", we know even more: it means that 
wait_task_zombie() was never called, because that would have started out 
with changing the process state to "X (dead)".

And that in turn implies that "eligible_child()" would have returned 2.

Which is a normal occurrence: it happens when a process group leader still 
has threads attached to it. At that point it may be a Zombie, but we can't 
reap it yet. The threads have to go away before the thing can be reaped.

Can you verify that that process doesn't have any sub-threads? (Again, 
that should be easily visible in /proc/<pid>/task/).

Another alternative is that the process is a zombie, but it is being
traced. When that happens, it shows up on the "ptrace_children" list, and
we'll see in in wait4(), but we won't be able to reap it. 

Roland, Ingo - have you followed the discussion on linux-kernel? Something 
strange does seem to be going on..

		Linus
