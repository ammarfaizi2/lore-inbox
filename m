Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263927AbUAaUKz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 15:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264095AbUAaUKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 15:10:54 -0500
Received: from disk.smurf.noris.de ([192.109.102.53]:52379 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S263927AbUAaUKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 15:10:53 -0500
From: "Matthias Urlichs" <smurf@smurf.noris.de>
Date: Sat, 31 Jan 2004 21:00:50 +0100
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BUG: NTPL: waitpid() doesn't return?
Message-ID: <20040131200050.GA2160@kiste>
References: <20040131104606.GA25534@kiste> <Pine.LNX.4.58.0401311052180.2105@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401311052180.2105@home.osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Linus Torvalds:
> 
> "Clearly" is not correct. What I bet happens is:
> 
> > 31346 execve("/usr/bin/apt-ftparchive", ["apt-ftparchive", "packages", "testing/all"], [/* 12 vars */] <unfinished ...>
> > 31346 <... execve resumed> )            = 0
> > 31346 exit_group(0)                     = ?
> > 31340 --- SIGCHLD (Child exited) @ 0 (0) ---
> > 31342 waitpid(31346,  <unfinished ...>
> 
> Notice how you do "waitpid()" for a _specific_ thread when you get a 
> SIGCHLD.
> 
> How the heck do you know _which_ thread it was that exited?

Please look again. The above trace clearly shows that #31346 has
exited, which is exactly the thread being waitpid()ed for.

What the program does is basically
- spawn four threads or so
- each thread forks off some process, and then waitpid()s for exactly
  that pid

... and all but the last waitpid() never returns even though all four
child processes have exit_group()ed.

> Rule: never EVER wait for a specific thread in a SIGCHLD handler. When you 
> get a SIGCHLD, your signal handler should just wait for "any thread". 

No SIGCHLD has been installed. (I checked the strace output.)

-- 
Matthias Urlichs     |     noris network AG     |     http://smurf.noris.de/
