Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262012AbSIQOI6>; Tue, 17 Sep 2002 10:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262915AbSIQOI6>; Tue, 17 Sep 2002 10:08:58 -0400
Received: from mailrelay1.lanl.gov ([128.165.4.101]:32657 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP
	id <S262012AbSIQOI5>; Tue, 17 Sep 2002 10:08:57 -0400
Subject: Re: [PATCH] BUG(): sched.c: Line 944
From: Steven Cole <elenstev@mesatop.com>
To: Robert Love <rml@tech9.net>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1032253191.4592.15.camel@phantasy>
References: <Pine.LNX.4.44.0209162250170.3443-100000@home.transmeta.com> 
	<1032250378.969.112.camel@phantasy>  <1032253191.4592.15.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 17 Sep 2002 08:10:20 -0600
Message-Id: <1032271821.11913.10.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-17 at 02:59, Robert Love wrote:
> On Tue, 2002-09-17 at 04:12, Robert Love wrote:
> 
> > I implemented exactly what you detailed, with one change: we need to
> > check kernel_locked() before setting lock_depth because it is valid to
> > exit() while holding the BKL.  Aside from kernel code that does it
> > intentionally, crashed code (e.g. modules) would have the same problem.
> 
> fsck, this is non-ending... obviously, this is insufficient:
> preempt_count will equal two if the BKL was previously held and
> in_atomic() will trip.
> 
> This should work:
> 
> 	if (likely(!kernel_locked())
> 		tsk->lock_depth = -2;
> 	else {
> 		/* compensate for BKL; we still cannot preempt */
> 		preempt_enable_no_resched();
> 	}
> 
Robert,

I applied the modified patch you sent at 04:51 plus the above and
had to change dump_stack() to show_stack(NULL) in sched.c due to

kernel/kernel.o: In function `schedule':
kernel/kernel.o(.text+0xf13): undefined reference to `dump_stack'

I used plain vanilla 2.5.35 to patch against.

I booted that so-patched kernel and it got much further than before,
up to where syslogd was able to write some stuff to /var/log/messages.

There were many instances of "error: scheduling while non-atomic!",
and the traces were similar.  Here is a decoded one:

[steven@spc5 linux-2.5.35]$ ksymoops -K -L -O -v vmlinux -m System.map <non-atomic.txt
ksymoops 2.4.4 on i686 2.5.35.  Options used
     -v vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m System.map (specified)

f7739f50 c0282f00 f7771960 c0337f20 c011c51b c1b0eec0 c1b71ba0 f7738000
       f7738000 f7738000 f78d4da0 c011d08b f78eb380 c012d67f f78d01c0 f78eb380
       f78eb560 f78d01c0 f78d01dc 40015000 bffffc48 c012d6c5 4213030c 00000004
Call Trace: [<c011c51b>] [<c011d08b>] [<c012d67f>] [<c012d6c5>] [<c010918f>]
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; c011c51b <put_files_struct+bb/d0>
Trace; c011d08b <do_exit+35b/370>
Trace; c012d67f <do_munmap+11f/130>
Trace; c012d6c5 <sys_munmap+35/60>
Trace; c010918f <syscall_call+7/b>

Hope this helps,
Steven


