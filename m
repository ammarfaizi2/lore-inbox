Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265063AbUAaTCZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 14:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265081AbUAaTCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 14:02:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:35470 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265063AbUAaTCW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 14:02:22 -0500
Date: Sat, 31 Jan 2004 11:02:15 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Matthias Urlichs <smurf@smurf.noris.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BUG: NTPL: waitpid() doesn't return?
In-Reply-To: <20040131104606.GA25534@kiste>
Message-ID: <Pine.LNX.4.58.0401311052180.2105@home.osdl.org>
References: <20040131104606.GA25534@kiste>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 31 Jan 2004, Matthias Urlichs wrote:
>
> This partial trace is from Debian's mini-dinstall, which is a
> multithreaded Python script.

Looks buggy.

> What happens here is that it spawns a bunch of threads, then some of
> these fork+execve external programs which they waitpid() for.
> 
> Unfortunately, some of these waitpid() calls don't return even though 
> the waited-for process clearly has exited.

"Clearly" is not correct. What I bet happens is:

> 31339 clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x4018e0c8) = 31340
> 31340 clone(child_stack=0x42edbb48, flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID|CLONE_DETACHED, parent_tidptr=0x42edbc18, {entry_number:6, base_addr:0x42edbbd0, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}, child_tidptr=0x42edbc18) = 31345
> 31342 clone( <unfinished ...>
> 31342 <... clone resumed> child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x416dbc18) = 31346
> 31346 execve("/usr/bin/apt-ftparchive", ["apt-ftparchive", "packages", "testing/all"], [/* 12 vars */] <unfinished ...>
> 31346 <... execve resumed> )            = 0
> 31346 exit_group(0)                     = ?
> 31340 --- SIGCHLD (Child exited) @ 0 (0) ---
> 31342 waitpid(31346,  <unfinished ...>

Notice how you do "waitpid()" for a _specific_ thread when you get a 
SIGCHLD.

How the heck do you know _which_ thread it was that exited?

In other words, I suspect that you got a SIGCHILD for some _other_ thread, 
and now you're waitpid'ing for the wrong thread. And while you do so, the 
thread you wait for may well be waiting for you to do something.

Rule: never EVER wait for a specific thread in a SIGCHLD handler. When you 
get a SIGCHLD, your signal handler should just wait for "any thread". 
Because SIGCHLD isn't specific enough (well, you could get the pid from 
siginfo, but because SIGCHLD isn't queued, that wouldn't really work 
either).

So your SIHCHLD handler should _always_ look like this:

	for (;;) {
		int status;
		int pid = waitpid(NULL, &status, WNOHANG);
		if (pid < 0)
			break;
		handle_exit(pid, status);
	}

and anything else is basically a bug in your program (well, your SIGCHLD 
handler might choose to just set a flag, and let the main loop do the 
above: that usually makes some races much simpler to handle, since the 
signal handler really _really_ shouldn't be taking any threading locks or 
anythign like that).

> Any ideas?

Fix your thing to use NULL and WNOHANG.

> NB: When not using strace, the waidpid() call does return;
> unfortunately, it does so with "[Errno 10] No child processes".

Probably just timing changes where strace effectively serializes something
(ie you probably have other threads that also get signals and do waitpid).

		Linus
