Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264510AbUAaLKy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 06:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264536AbUAaLKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 06:10:54 -0500
Received: from disk.smurf.noris.de ([192.109.102.53]:9442 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S264510AbUAaLKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 06:10:53 -0500
From: "Matthias Urlichs" <smurf@smurf.noris.de>
Date: Sat, 31 Jan 2004 11:46:06 +0100
To: linux-kernel@vger.kernel.org
Subject: BUG: NTPL: waitpid() doesn't return?
Message-ID: <20040131104606.GA25534@kiste>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This partial trace is from Debian's mini-dinstall, which is a
multithreaded Python script.

What happens here is that it spawns a bunch of threads, then some of
these fork+execve external programs which they waitpid() for.

Unfortunately, some of these waitpid() calls don't return even though 
the waited-for process clearly has exited.

This is kernel 2.6.2-rc2, unmodified (except for modularized IDE).

I've kept all the intervening clone() calls in the trace, hopefully
somebody can shed some light on what might be going on here.

(Imagine random other things happening between all of the following lines.)

31338 execve("/usr/bin/mini-dinstall", ["mini-dinstall"], [/* 12 vars */]) = 0
31338 rt_sigaction(SIGCHLD, NULL, {SIG_DFL}, 8) = 0
31338 execve("/usr/bin/mini-dinstall", ["mini-dinstall"], [/* 12 vars */]) = 0
31338 clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x4018e0c8) = 31339
31339 clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x4018e0c8) = 31340
31340 clone(child_stack=0x42edbb48, flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID|CLONE_DETACHED, parent_tidptr=0x42edbc18, {entry_number:6, base_addr:0x42edbbd0, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}, child_tidptr=0x42edbc18) = 31345
31342 clone( <unfinished ...>
31342 <... clone resumed> child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x416dbc18) = 31346
31346 execve("/usr/bin/apt-ftparchive", ["apt-ftparchive", "packages", "testing/all"], [/* 12 vars */] <unfinished ...>
31346 <... execve resumed> )            = 0
31346 exit_group(0)                     = ?
31340 --- SIGCHLD (Child exited) @ 0 (0) ---
31342 waitpid(31346,  <unfinished ...>

This last call never returns.

Any ideas?

NB: When not using strace, the waidpid() call does return;
unfortunately, it does so with "[Errno 10] No child processes".

-- 
Matthias Urlichs     |     noris network AG     |     http://smurf.noris.de/
