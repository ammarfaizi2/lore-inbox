Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135403AbRDWBF2>; Sun, 22 Apr 2001 21:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135486AbRDWBFT>; Sun, 22 Apr 2001 21:05:19 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:55329 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S135403AbRDWBFA>; Sun, 22 Apr 2001 21:05:00 -0400
Date: Mon, 23 Apr 2001 03:04:41 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "D . W . Howells" <dhowells@astarte.free-online.co.uk>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, dhowells@redhat.com
Subject: Re: [PATCH] rw_semaphores, optimisations
Message-ID: <20010423030441.D21558@athlon.random>
In-Reply-To: <01042223522900.05293@orion.ddi.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01042223522900.05293@orion.ddi.co.uk>; from dhowells@astarte.free-online.co.uk on Sun, Apr 22, 2001 at 11:52:29PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 22, 2001 at 11:52:29PM +0100, D . W . Howells wrote:
> Hello Andrea,
> 
> Interesting benchmarks... did you compile the test programs with "make 
> SCHED=yes" by any chance? Also what other software are you running?

No I never tried the SCHED=yes. However in my modification of the rwsem-rw bench
I dropped the #ifdef SCHED completly and I schedule the right way (first
checking need_resched) in a more interesting place (in the middle of the
critical section).

> The reason I ask is that running a full blown KDE setup running in the 
> background, I get the following numbers on the rwsem-ro test (XADD optimised 
> kernel):
> 
>     SCHED: 4615646, 4530769, 4534453 and 4628365
>     no SCHED: 6311620, 6312776, 6327772 and 6325508

No absolutely not, that machine has nearly only the kernel daemons running
in background (even cron is disabled to make sure it doesn't screwup
the benchmarks). This is how the machine looks like before running the
bench.

andrea@laser:~ > ps xa
  PID TTY      STAT   TIME COMMAND
    1 ?        S      0:03 init [2] 
    2 ?        SW     0:00 [keventd]
    3 ?        SW     0:00 [kswapd]
    4 ?        SW     0:00 [kreclaimd]
    5 ?        SW     0:00 [bdflush]
    6 ?        SW     0:00 [kupdated]
    7 ?        SW<    0:00 [mdrecoveryd]
  123 ?        S      0:00 /sbin/dhcpcd -d eth0
  150 ?        S      0:00 /sbin/portmap
  168 ?        S      0:00 /usr/sbin/syslogd -m 1000
  172 ?        S      0:00 /usr/sbin/klogd -c 5
  220 ?        S      0:00 /usr/sbin/sshd
  254 ?        S      0:00 /usr/sbin/automount /misc file /etc/auto.misc
  256 ?        S      0:00 /usr/sbin/automount /net program /etc/auto.net
  271 ?        S      0:00 /usr/sbin/rpc.kstatd
  276 ?        S      0:00 /usr/sbin/rpc.kmountd
  278 ?        SW     0:00 [nfsd]
  279 ?        SW     0:00 [nfsd]
  280 ?        SW     0:00 [nfsd]
  281 ?        SW     0:00 [nfsd]
  282 ?        SW     0:00 [lockd]
  283 ?        SW     0:00 [rpciod]
  459 ?        S      0:00 /usr/sbin/inetd
  461 tty1     S      0:00 /sbin/mingetty --noclear tty1
  462 tty2     S      0:00 /sbin/mingetty tty2
  463 tty3     S      0:00 /sbin/mingetty tty3
  464 tty4     S      0:00 /sbin/mingetty tty4
  465 tty5     S      0:00 /sbin/mingetty tty5
  466 tty6     S      0:00 /sbin/mingetty tty6
 1177 ?        S      0:00 in.rlogind
 1178 pts/0    S      0:00 login -- andrea                    
 1179 pts/0    S      0:00 -bash
 1186 pts/0    R      0:00 ps xa
andrea@laser:~ > 

> > (ah and btw the machine is a 2-way PII 450mhz). 
> 
> Your numbers were "4274607" and "4280280" for this kernel and test This I 
> find a little suprising. I'd expect them to be about 10% higher than I get on 
> my machine given your faster CPUs.
> 
> What compiler are you using? I'm using the following:
> 
>    Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
>    gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-80)

andrea@athlon:~ > gcc -v
Reading specs from /home/andrea/bin/i686/gcc-2_95-branch-20010325/lib/gcc-lib/i686-pc-linux-gnu/2.95.4/specs
gcc version 2.95.4 20010319 (prerelease)
andrea@athlon:~ > 

ah and btw, I also used the builtin expect in all the fast path but they were
compiled out by the preprocessor because I'm compiling with <96.

> Something else that I noticed: Playing a music CD appears to improve the 
> benchmarks all round:-) Must be some interrupt effect of some sort, or maybe 
> they just like the music...

The machine is a test box without soundcard, disk was idle.

> > rwsem-2.4.4-pre6 + my new generic rwsem (fast path in C inlined)
> 
> Linus wants out of line generic code only, I believe. Hence why I made my 
> generic code out of line.

I also did a run with my code out of line of course and as you can see
it's not a relevant penality.

> I have noticed one glaring potential slowdown in my generic code's down 
> functions. I've got the following in _both_ fastpaths!:
> 
>     struct task_struct *tsk = current;

that is supposed to be a performance optimization, I do the same too in my code.

> It's also interesting that your generic out-of-line semaphores are faster 
> given the fact that you muck around with EFLAGS and CLI/STI, and I don't. 

as said in my last email I changed the semantics and you cannot call up_* from
irq context anymore, so in short I'm not mucking with cli/sti/eflags anymore.

Note that I didn't released anything but the bench yet, I am finishing to
plugin an asm fast path on top of my slow path and then I will run new
benchmark and post some code.

But my generic semaphore is also smaller, it's 16 byte in size even in SMP both
the asm optimized rwsem and the C generic one (of course on 32bit archs, for
64bit archs is slightly bigger than 16 bytes).

Andrea
