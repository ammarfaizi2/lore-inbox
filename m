Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272059AbTHDRtq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 13:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272060AbTHDRtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 13:49:45 -0400
Received: from vrlabserv2.epfl.ch ([128.178.78.153]:42635 "EHLO
	vrlabserv2.epfl.ch") by vger.kernel.org with ESMTP id S272059AbTHDRtl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 13:49:41 -0400
Message-ID: <3F2E9CB2.7050606@epfl.ch>
Date: Mon, 04 Aug 2003 19:49:38 +0200
From: Jan Ciger <jan.ciger@epfl.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030727 Thunderbird/0.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: threaded process stuck on 2.4.2[12]
X-Enigmail-Version: 0.81.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hello,

It seems, that 2.4.21 and 2.4.22-pre10 have a problem with
threads. Some apps hang in rt_sigsuspend() call.

How to reproduce :

1) Download OpenProducer
http://www.andesengineering.com/Producer/Download/Producer-0.8.2-2.tar.gz

2) Download OpenSceneGraph
http://www.openscenegraph.org/download/snapshots/OpenSceneGraph-0.9.4-2.tar.gz

3) build and install OpenProducer and then OpenSceneGraph

4) after installation, run e.g. osganimate

For me the application hangs, until I hit CTRL+Z (suspend) and then do
either bg or fg from the shell.

Strace shows the application hanging in :

sigreturn()                             = ? (mask now [RTMIN])
rt_sigprocmask(SIG_SETMASK, NULL, [RTMIN], 8) = 0
rt_sigsuspend([] <unfinished ...>

If I start the application in gdb, I get first SIG32, that should be OK
and then SIGTRAP. After hitting continue on SIGTRAP, the application
hangs in :

0x40fda714 in pthread_getconcurrency () from /lib/i686/libpthread.so.0

It seems, that some signal is never delivered or there is a deadlock of
sorts.

I tried another strace and it seems, that something fishy is going on :

- -----------------------

$ strace -e trace=signal -f osganimate
rt_sigaction(SIGRTMIN, {0x40544000, [], SA_RESTORER, 0x405e1488}, NULL,
8) = 0
rt_sigaction(SIGRT_1, {0x405438c0, [], SA_RESTORER, 0x405e1488}, NULL,
8) = 0
rt_sigaction(SIGRT_2, {0x40544040, [], SA_RESTORER, 0x405e1488}, NULL,
8) = 0
rt_sigprocmask(SIG_BLOCK, [RTMIN], NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [33], NULL, 8) = 0
Process 5191 attached (waiting for parent)
Process 5191 resumed (parent 5187 ready)
[pid  5191] --- SIGSTOP (Stopped (signal)) @ 0 (0) ---
[pid  5191] rt_sigprocmask(SIG_SETMASK, ~[TRAP 33], NULL, 8) = 0
[pid  5187] rt_sigprocmask(SIG_SETMASK, NULL, [RTMIN], 8) = 0
[pid  5187] rt_sigprocmask(SIG_SETMASK, NULL, [RTMIN], 8) = 0
[pid  5187] rt_sigsuspend([]Process 5192 attached
~ <unfinished ...>
[pid  5192] --- SIGSTOP (Stopped (signal)) @ 0 (0) ---
[pid  5191] kill(5187, SIGRTMIN)        = 0
[pid  5192] rt_sigprocmask(SIG_SETMASK, [RTMIN], NULL, 8) = 0
[pid  5187] --- SIGRTMIN (Unknown signal 32) @ 0 (0) ---
[pid  5192] rt_sigprocmask(SIG_SETMASK, NULL,  <unfinished ...>
[pid  5187] <... rt_sigsuspend resumed> ) = -1 EINTR (Interrupted system
call)
[pid  5192] <... rt_sigprocmask resumed> [RTMIN], 8) = 0
[pid  5187] sigreturn( <unfinished ...>
[pid  5192] rt_sigsuspend([] <unfinished ...>
[pid  5187] <... sigreturn resumed> )   = ? (mask now [RTMIN])
[pid  5187] rt_sigprocmask(SIG_SETMASK, NULL, [RTMIN], 8) = 0
[pid  5187] rt_sigprocmask(SIG_SETMASK, NULL, [RTMIN], 8) = 0
[pid  5187] rt_sigsuspend([]Process 5193 attached (waiting for parent)
Process 5193 resumed (parent 5191 ready)
~ <unfinished ...>
[pid  5193] --- SIGSTOP (Stopped (signal)) @ 0 (0) ---
[pid  5191] kill(5187, SIGRTMIN)        = 0
[pid  5193] rt_sigprocmask(SIG_SETMASK, [RTMIN], NULL, 8) = 0
[pid  5187] --- SIGRTMIN (Unknown signal 32) @ 0 (0) ---
[pid  5187] <... rt_sigsuspend resumed> ) = -1 EINTR (Interrupted system
call)
[pid  5187] sigreturn()                 = ? (mask now [RTMIN])
[pid  5187] rt_sigprocmask(SIG_SETMASK, NULL, [RTMIN], 8) = 0
[pid  5187] rt_sigsuspend([] <unfinished ...>
[pid  5193] rt_sigprocmask(SIG_SETMASK, NULL, [RTMIN], 8) = 0
[pid  5193] rt_sigprocmask(SIG_SETMASK, NULL, [RTMIN], 8) = 0
[pid  5193] rt_sigsuspend([]Process 5194 attached (waiting for parent)
Process 5194 resumed (parent 5191 ready)
~ <unfinished ...>
[pid  5194] --- SIGSTOP (Stopped (signal)) @ 0 (0) ---
[pid  5191] kill(5193, SIGRTMIN <unfinished ...>
[pid  5193] --- SIGRTMIN (Unknown signal 32) @ 0 (0) ---
Process 5193 detached

^^^^^^^^^^^^^^^^^^^^^^^^^ thread died ?

[pid  5191] <... kill resumed> )        = 0
[pid  5194] rt_sigprocmask(SIG_SETMASK, [RTMIN], NULL, 8) = 0
[pid  5194] kill(5193, SIGRTMIN)        = 0
[pid  5194] kill(5193, SIGRTMIN)        = 0

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Trying to send a signal to a dead thread, it seems and then it waits
forever for response.

When I run it inside gdb, the dead thread is in <defunct> state :-(

I am not PosixThreads expert, but this looks abnormal to me. Either some
signal got missing (SIGSEGV or SIGCHLD, for example, if something
crashed and the thread manager didn't "notice" the disappearance of one
of the threads) or there is something funny going on.

I didn't try to reproduce this problem on 2.5/6 kernels, since some
drivers my machine needs do not compile yet (like SCSI AIC7xxxx and NVidia)

My box is dual Xeon 2.2GHz with 1GB RAM, running 2.4.21-6mdk (Mandrake
enterprise kernel) now, but the same bug happens also with 2.4.22-pre10
and stock 2.4.21 compiled from source (tested yesterday and today).

I will provide more info on request, I do not want to flood the list.

Some advice would be extremely appreciated, because this is a show
stopper for me.

Regards,

Jan
- --

Jan Ciger
VRlab EPFL Switzerland
GPG public key : http://www.keyserver.net/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQE/Lpyyn11XseNj94gRAk/eAKCXI4SIakqr3/n7ZJnnn6+bukhoKACg6s78
43GodPkQAjO1ZBsKzzBpMAw=
=Lq4F
-----END PGP SIGNATURE-----


