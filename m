Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265203AbUBADZb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 22:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265205AbUBADZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 22:25:31 -0500
Received: from nevyn.them.org ([66.93.172.17]:30336 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S265203AbUBADZ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 22:25:28 -0500
Date: Sat, 31 Jan 2004 22:25:25 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: linux-kernel@vger.kernel.org
Subject: More waitpid issues with CLONE_DETACHED/CLONE_THREAD
Message-ID: <20040201032525.GA10254@nevyn.them.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This may be related to the python bug reported today...

I've been playing around with gdbserver support for NPTL threading all day
today.  Right now it works, except that when I say "kill" in the GDB client,
gdbserver hangs.  The problem is that we kill the child, and wait for it,
but wait never returns it.

write(2, "Killing inferior\n", 17)      = 17
ptrace(PTRACE_CONT, 8454, 0, SIG_0)     = 0
tkill(8454, SIGKILL)                    = 0
--- SIGCHLD (Child exited) @ 0 (0) ---
waitpid(8454, 0xbfffec04, WNOHANG)      = 0
waitpid(8454, 0xbfffec04, WNOHANG|__WCLONE) = -1 ECHILD (No child processes)
nanosleep({0, 1000000}, 0)              = ? ERESTART_RESTARTBLOCK (To be restarted)
--- SIGCHLD (Child exited) @ 0 (0) ---
setup()                                 = 0
waitpid(8454, 0xbfffec04, WNOHANG)      = 0
waitpid(8454, 0xbfffec04, WNOHANG|__WCLONE) = -1 ECHILD (No child processes)

and so on (looping on waitpid).  At this point, process 8454 is marked as a
zombie, and nothing can reap it.  After gdbserver is killed, it reparents to
init:

Name:   linux-dp
State:  Z (zombie)
SleepAVG:       91%
Tgid:   8454
Pid:    8454
PPid:   1
TracerPid:      0

but init can't reap it either.

8454 was the original (i.e. non-CLONE_DETACHED) thread.  Same behavior if I
use ptrace_kill.

GDB doesn't suffer from the same problem.  A little time with strace and I
found out why: GDB PTRACE_KILL's the detached threads, PTRACE_KILL's the
parent thread, waitpid's the detached threads, and then waitpid's the parent
thread.  No design, just different order of items on the linked list.

If I change gdbserver to do "kill thread; wait for thread; kill next thread;
wait for next thread; kill parent last; wait for parent last" then it
terminates and I don't get an unkillable zombie.

ptrace(PTRACE_KILL, 18348, 0, 0)        = 0
waitpid(18348, 0xbfffec04, WNOHANG)     = -1 ECHILD (No child processes)
--- SIGCHLD (Child exited) @ 0 (0) ---
waitpid(18348, [WIFSIGNALED(s) && WTERMSIG(s) == SIGKILL], WNOHANG|__WCLONE) = 18348
ptrace(PTRACE_KILL, 18349, 0, 0)        = 0
waitpid(18349, 0xbfffec04, WNOHANG)     = -1 ECHILD (No child processes)
waitpid(18349, [WIFSIGNALED(s) && WTERMSIG(s) == SIGKILL], WNOHANG|__WCLONE) = 18349
--- SIGCHLD (Child exited) @ 0 (0) ---
ptrace(PTRACE_KILL, 18350, 0, 0)        = 0
waitpid(18350, 0xbfffec04, WNOHANG)     = -1 ECHILD (No child processes)
waitpid(18350, [WIFSIGNALED(s) && WTERMSIG(s) == SIGKILL], WNOHANG|__WCLONE) = 18350
ptrace(PTRACE_KILL, 18351, 0, 0)        = 0
waitpid(18351, 0xbfffec04, WNOHANG)     = -1 ECHILD (No child processes)
waitpid(18351, [WIFSIGNALED(s) && WTERMSIG(s) == SIGKILL], WNOHANG|__WCLONE) = 18351
ptrace(PTRACE_KILL, 18352, 0, 0)        = 0
waitpid(18352, 0xbfffec04, WNOHANG)     = -1 ECHILD (No child processes)
waitpid(18352, [WIFSIGNALED(s) && WTERMSIG(s) == SIGKILL], WNOHANG|__WCLONE) = 18352
--- SIGCHLD (Child exited) @ 0 (0) ---
ptrace(PTRACE_KILL, 18329, 0, 0)        = 0
waitpid(18329, [WIFSIGNALED(s) && WTERMSIG(s) == SIGKILL], WNOHANG) = 18329
exit_group(0)                           = ?

So it looks like something gets very confused if the parent is SIGKILLed
before the children.  What should happen?

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
