Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264894AbUAaU60 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 15:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264905AbUAaU60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 15:58:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:41169 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264894AbUAaU6Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 15:58:24 -0500
Date: Sat, 31 Jan 2004 12:58:20 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Matthias Urlichs <smurf@smurf.noris.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BUG: NTPL: waitpid() doesn't return?
In-Reply-To: <20040131200050.GA2160@kiste>
Message-ID: <Pine.LNX.4.58.0401311223110.2105@home.osdl.org>
References: <20040131104606.GA25534@kiste> <Pine.LNX.4.58.0401311052180.2105@home.osdl.org>
 <20040131200050.GA2160@kiste>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 31 Jan 2004, Matthias Urlichs wrote:
> 
> Please look again. The above trace clearly shows that #31346 has
> exited, which is exactly the thread being waitpid()ed for.

The strace case I'm more than willing to pass off as a strace problem. 
I find it quite common that strace doesn't detach from processes, leaving 
some of them in a stopped state. So I assumed that the particular trace 
wasn't very interesting.

That's especially true since you said the behaviour doesn't actually occur
without "strace".

So considering the further details:

> What the program does is basically
> - spawn four threads or so
> - each thread forks off some process, and then waitpid()s for exactly
>   that pid
> 
> ... and all but the last waitpid() never returns even though all four
> child processes have exit_group()ed.
> 
> No SIGCHLD has been installed. (I checked the strace output.)

The bugs seems to be something totally different: you create a 
"CLONE_DETACHED" child, and then you expect to be able to wait for it. 
That's just bogus.

If the child is detached, that means that it reaps itself, and the
behaviour you _should_ see is pretty much undefined. Doing a "wait()" on a
detached child just doesn't make much sense.

So I think the "correct" behaviour actually ends up having the wait()  
pause, and once the child exits it reaps itself, and that in turn
will/should make the wait() notice that there are no children, and return
a -ENOCHLD.

Because with a detached thread, you really will never get the status - the 
child will have reaped itself and not given status to the parent.

But in theory it would be equally correct to just return ENOCHLD
_immediately_, since the clone was a DETACHED clone.

The "strace" behaviour may be a bug somewhere. I don't know if it's strace
or the kernel. But quite possibly, it's not even a "bug": exactly because 
the child was detached, when strace detaches from it, it wouldn't be 
re-attached to the parent, so there's nothing to wake the parent up again.

		Linus
