Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbTEKP2u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 11:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbTEKP2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 11:28:50 -0400
Received: from siaag2ac.compuserve.com ([149.174.40.133]:62404 "EHLO
	siaag2ac.compuserve.com") by vger.kernel.org with ESMTP
	id S261704AbTEKP2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 11:28:48 -0400
Date: Sun, 11 May 2003 11:37:17 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Problem: strace -ff fails on 2.4.21-rc1
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-ID: <200305111140_MC3-1-385D-EEF@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carl-Daniel Hailfinger wrote:

> Chuck Ebbert wrote:
> >   I just found out minicom is spawing /sbin/lockdev which is setgrp
> > 'lock'.  Would that cause ptrace failure??
>
> AFAIK that could have caused the failure. Please test 2.4.21-rc2 whcih
> has fixes for many ptrace problems.

  I can now strace minicom and its children with 2.4.21-rc2-ac1 but it
hangs on exit.  Both child processes exit successfully:

 # tail -5 minicom.trc.5775

10:16:49.299253 kill(5774, SIG_0)       = 0
10:16:49.299418 unlink("/var/lock/LOCKDEV") = 0
10:16:49.299649 close(3)                = 0
10:16:49.299849 umask(022)              = 02
10:16:49.300043 _exit(0)                = ?

 # tail -8 minicom.trc.5776

10:17:05.497676 kill(5774, SIG_0)       = 0
10:17:05.497845 unlink("/var/lock/LCK...5774") = 0
10:17:05.498068 unlink("/var/lock/LCK..ttyS1") = 0
10:17:05.498283 unlink("/var/lock/LCK.004.065") = 0
10:17:05.498616 unlink("/var/lock/LOCKDEV") = 0
10:17:05.498870 close(4)                = 0
10:17:05.499065 umask(022)              = 02
10:17:05.499337 _exit(0)                = ?

However strace and minicom are hung up somehow and the screen is
black with a blinking cursor at row 1 column 1.  The other ttys all
work OK and killing minicom cleans everything up.

 # tail -3 minicom.trc

10:17:05.499678 --- SIGCHLD (Child exited) ---
10:17:05.499760 rt_sigaction(SIGCHLD, {SIG_DFL}, {SIG_IGN}, 8) = 0
10:17:05.499971 close(3


strace        S C015FF82   960  5773    822  5774               (NOTLB)
Call Trace:    [<c015ff82>] [<c011dba8>] [<c0108b73>]
minicom       S 00000000  2400  5774   5773                     (NOTLB)
Call Trace:    [<c0122f24>] [<c0124095>] [<c021195b>] [<c0220d79>] [<c020d997>]
  [<c0124095>] [<c0124159>] [<c020e01a>] [<c013c52e>] [<c01183a1>] [<c013b1d5>]
  [<c013b23b>] [<c0108bdf>]

Proc;  strace
>>EIP; c015ff82 <ext3_file_write+22/b0>   <=====
Trace; c015ff82 <ext3_file_write+22/b0>
Trace; c011dba8 <sys_wait4+3c8/400>
Trace; c0108b73 <system_call+33/38>
Proc;  minicom
>>EIP; 00000000 Before first symbol
Trace; c0122f24 <schedule_timeout+14/a0>
Trace; c0124095 <wake_up_parent+25/40>
Trace; c021195b <tty_wait_until_sent+9b/e0>
Trace; c0220d79 <rs_close+129/1f0>
Trace; c020d997 <release_dev+247/500>
Trace; c0124095 <wake_up_parent+25/40>
Trace; c0124159 <do_notify_parent+a9/c0>
Trace; c020e01a <tty_release+2a/60>
Trace; c013c52e <fput+4e/100>
Trace; c01183a1 <schedule+351/3b0>
Trace; c013b1d5 <filp_close+95/a0>
Trace; c013b23b <sys_close+5b/70>
Trace; c0108bdf <tracesys+1f/23>


Configuration:
        2.4.21-rc2-ac1
        SMP kernel on 1-CPU SMP machine (PII Xeon, 440GX)

To reproduce:
        # strace -ff -q -tt -o minicom.trc minicom

Note:
        I also get lockups while minicom is running:

        Proc;  strace
        >>EIP; c015ff82 <ext3_file_write+22/b0>   <=====
        Trace; c015ff82 <ext3_file_write+22/b0>
        Trace; c011dba8 <sys_wait4+3c8/400>
        Trace; c0108b73 <system_call+33/38>
        Proc;  minicom
        >>EIP; 00000000 Before first symbol
        Trace; c0122f24 <schedule_timeout+14/a0>
        Trace; c021105a <read_chan+37a/720>
        Trace; c020cf5f <tty_read+cf/120>
        Trace; c013b706 <sys_read+96/110>
        Trace; c0108bdf <tracesys+1f/23>

