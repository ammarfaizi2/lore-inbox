Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263626AbUHNO7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263626AbUHNO7t (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 10:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263640AbUHNO7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 10:59:49 -0400
Received: from 64.89.71.154.nw.nuvox.net ([64.89.71.154]:58577 "EHLO
	gate.apago.com") by vger.kernel.org with ESMTP id S263626AbUHNO7o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 10:59:44 -0400
SMTP-Relay: [0]
Message-Id: <200408141144.i7EBi3qr002285@dogwood.freil.com>
X-Mailer: exmh version 2.0.2 2/24/98
To: Darren Williams <dsw@gelato.unsw.edu.au>
cc: lef@dogwood.freil.com
Subject: Re: Serious Kernel slowdown with HIMEM (4Gig) in 2.6.7 
In-reply-to: Your message of "Sat, 14 Aug 2004 14:18:15 +1000."
             <20040814041815.GA10742@cse.unsw.EDU.AU> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 14 Aug 2004 07:42:43 -0400
From: "Lawrence E. Freil" <lef@freil.com>
Env-from: lef@freil.com
Env-To: lef
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
   The systems in question are embedded server systems with no GUI loaded.
The environment I use is a simple SSH into the system so minimal processes
are running and the load average is about as close to zero as you can get.
The exact command I am running is "/usr/bin/time ls -l MBRF >/dev/null".

The problem first appeared in relation to a foxpro database application run
off samba share from these systems (we have two identical systems that show 
this behaviour).  The customer was concerned because they upgraded from a 400Mz
celeron to a 2.5Gz P4-Xeon with double the RAM and Gigabit networking and
it was slower than before.  I traced the packets with tcpdump to both the
old and the new system and the slowdown was occuring on windows requests
to find files (mostly dll's).  On further investigation it also appeared
on simple commands like "ls" but I would not have noticed had I not been
looking.  Here are the exact timeings from one system (approx 900 files
in directory) without HIMEM and another with HIMEM on. 

yang (identical hardware and software to yin except HIMEM turned off)
0.01user 0.00system 0:00.01elapsed 87%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+350minor)pagefaults 0swaps

yin
0.70user 0.00system 0:00.71elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+350minor)pagefaults 0swaps

As you can see from this the additional time is entirely spent as user CPU 
time.  I have run these multiple times and checked for disk I/O and there
is no physical I/O operations between these two (everything is cached at this
point).  The time increase is occuring on every directory manipulation, but
read and update (as in my script that creates empty files), but does not
appear to effect sequential file read/write operations.  I have not setup
a test to see if it effects random file access which would be very similar
to the directory read/update case. 

I have run the same tests both on XFS and ext2 with identical results.  The
physical filesystem appears to have no bearing.  I also eliminated the disk
as the source of the problems.  The new systems have Serial ATA drives that
read approx 54MB/second (four times that of the old system) and in file
read tests over samba (and locally) the new systems much faster. I have also
run the tests on a a very similar system (slackware 10, but Athlon and only
512Meg of RAM) with 2.6.7 kernel and HIMEM on but did not see the problem.
I suspect it only occurs when the high memory is used for disk block buffering
but have not had time to attempt profiling the kernel to see where the CPU
time difference occurs.  I do have kernel preemption turned on.  This morning
I will generate a kernel with preemtion turned off and himem on and see if
there is an interaction with that.  I can send kernel configs if you believe
they are relevent but these are pretty much stock kernels with unused modules
turned off.

> Hi Lawrence
> 
> On Fri, 13 Aug 2004, Lawrence E. Freil wrote:
> 
> > Hello,
> >    
> > I'm following the kernel bug reporting format so:
> > 
> > 1. Linux 2.6.7 kernel slowdown in directory access with HIMEM on
> > 
> > 2. I have discovered an issue with the Linux 2.6.7 kernel when HIMEM is
> >    enabled which exhibits itself as a slowdown in directory access regardless
> >    of filesystem used.  When HIMEM is disabled the performance returns to
> >    normal.  The test I ran was a simple "/usr/bin/time ls -l" of a directory
> >    with 3000 empty files.  With HIMEM enabled in the kernel this takes
> >    approximately 1.5 seconds.  Without HIMEM it takes 0.03 seconds.  The
> >    time is 100% CPU and no I/O operations are done to disk.  "time" reports
> >    there are 460 "minor" page faults with zero "major" page faults.
> >    I believe the issue here is the mapping of pages between high-mem and
> >    lowmem in the kernel paging code.  This increase in time for directory
> >    accesses doubles to triples times for applications using samba.
> >    I have also tested this on another system which had only 512Meg of RAM
> >    but with HIMEM set in the kernel and did not experience the problem.
> >    I believe it only effects the performance when the paging buffers end
> >    up in highmem.
> > 
> > 3. Keywords: HIMEM, Performance
> > 
> Would you be running these in a gnome-terminal, I remember seeing a thread
> that discussed gnome-terminal problems though a quick search did not turn
> anything up. Here is what I get between a xterm and gnome-terminal.
> 
> xterm
> # time ls -lR /etc
> real    0m0.381s
> user    0m0.056s
> sys     0m0.130s
> 
> gnome-terminal
> # time ls -lR /etc
> real    0m0.869s
> user    0m0.057s
> sys     0m0.141s
> 
> I ran this twice in both teminals and reported the
> second result.
> 
> system info
> P4 3.06 HT
> 2.6.7 SMP/SMT/HIGHMEM
> 1GB ram
> 
> -------------------------------------------------
> Darren Williams <dsw AT gelato.unsw.edu.au>
> Gelato@UNSW <www.gelato.unsw.edu.au>
> --------------------------------------------------

-- 
        Lawrence Freil                      Email:lef@freil.com
        1768 Old Country Place              Phone:(770) 667-9274
        Woodstock, GA 30188

