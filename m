Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274368AbRJQD5f>; Tue, 16 Oct 2001 23:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274434AbRJQD50>; Tue, 16 Oct 2001 23:57:26 -0400
Received: from avocet.mail.pas.earthlink.net ([207.217.121.50]:7671 "EHLO
	avocet.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S274368AbRJQD5N>; Tue, 16 Oct 2001 23:57:13 -0400
Date: Tue, 16 Oct 2001 23:59:31 -0400
To: andrea@suse.de
Cc: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net
Subject: Re: VM test on 2.4.13-pre3aa1 (compared to 2.4.12-aa1 and 2.4.13-pre2aa1)
Message-ID: <20011016235931.A15889@earthlink.net>
In-Reply-To: <20011016081639.A209@earthlink.net> <20011017021242.S2380@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011017021242.S2380@athlon.random>; from andrea@suse.de on Wed, Oct 17, 2001 at 02:12:42AM +0200
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2001 at 02:12:42AM +0200, Andrea Arcangeli wrote:
> On Tue, Oct 16, 2001 at 08:16:39AM -0400, rwhron@earthlink.net wrote:
> > 
> > Wall clock time for this test has dropped dramatically (which
> > is good) over the last 3 Andrea Arcangeli patched kernels.
> 
> > mp3blaster sounds less pleasant though.
> 
> A (very) optimistic theory could be that the increase of the swap
> throughput is decreasing the bandiwth available to read the mp3 8). Do
> you swap on the same physical disk where you keep the mp3? But it maybe
> that I'm blocking too easily waiting for I/O completion instead, or that
> the mp3blast routines needed for the playback are been swapped out,

That theory makes sense.  2.4.13-pre3aa1 seems more aggressive at 
making memory (swap) available to memory (swap) hogs.  2.4.12aa1
would be agressive from swpd (small) to about 130000 on this machine.
2.4.13-pre2aa1 was aggressive until swpd around 280000 on this machine, 
and 2.4.13-pre3aa1 is aggressive as long as swap is needed.

I say "aggressive" based on when mp3blaster starts to sputter.

The mp3 is on the same disk as swap and everything else.  

> dunno with only this info. You can rule out the "mp3blast is been
> swapped out" by running mp3blast after an mlockall. And you can avoid
> the disk bandwith problems by putting the mp3 in a separate disk.

I didn't find a user mlockall program on freshmeat or icewalkers.


> >  3  3  0  47424   3788   1172   1412 860 40228   892 40236  789   819  12  23  66
> >  0  5  1  90244   1656   1184   1416 1032 39568  1076 39572  653   425   6   5  89
> 
> those swapins could be due mp3blast that is getting swapped out
> continously while it sleeps.  Not easy for the vm to understand it has
> to stay in cache and it makes sense it gets swapped out faster, the
> faster the swap rate is. Could you also make sure to run mp3blast with
> -20 priority and the swap-hog at +19 priority just in case?

I did 3 tests using "nice".  

1) nothing niced
2) mp3blaster not nice
3) mtest01 very nice, and mp3blaster not nice

mp3blaster uses about 11 seconds of CPU time to play a 3 minute mp3 on this machine.

Here is a bit of ps with mtest01 very nice, and mp3blaster un-nice

    F S   UID   PID  PPID  C PRI  NI ADDR    SZ WCHAN  TTY          TIME CMD
  000 S 18008 15643    93  0  59 -20    -  7455 nanosl tty3     00:00:00 mp3blaster
  002 S 18008 15644 15643  0  59 -20    -  7455 do_pol tty3     00:00:00 mp3blaster
  002 S 18008 15645 15644  1  59 -20    -  7455 nanosl tty3     00:00:15 mp3blaster
  002 S 18008 15710 15644  0  59 -20    -  7455 end    tty3     00:00:00 mp3blaster
  004 S     0 15711    91  0  79  19    -   530 wait4  tty1     00:00:00 mmtest
  004 S     0 15714 15711  0  79  19    -   331 nanosl tty1     00:00:00 vmstat
  000 R 18008 15717    98  5  75   0    -   727 -      tty8     00:00:00 ps
  000 S     0 15718 15711  0  79  19    -   318 wait4  tty1     00:00:00 time
  000 R     0 15719 15718  0  79  19    -  4686 -      tty1     00:00:00 mtest01

Changing nice values didn't really have any affect on mp3blaster's sound quality.

mp3blaster not nice, mtest01 very nice

Averages for 10 mtest01 runs
bytes allocated:                    1238577971
User time (seconds):                2.062
System time (seconds):              2.715
Elapsed (wall clock) time:          40.606
Percent of CPU this job got:        11.50
Major (requiring I/O) page faults:  108.3
Minor (reclaiming a frame) faults:  303169.0

mp3blaster not nice

Averages for 10 mtest01 runs
bytes allocated:                    1221800755
User time (seconds):                2.059
System time (seconds):              2.697
Elapsed (wall clock) time:          37.597
Percent of CPU this job got:        12.10
Major (requiring I/O) page faults:  115.2
Minor (reclaiming a frame) faults:  299073.0

no nice processes

Averages for 10 mtest01 runs
bytes allocated:                    1240045977
User time (seconds):                2.106
System time (seconds):              2.738
Elapsed (wall clock) time:          39.408
Percent of CPU this job got:        11.70
Major (requiring I/O) page faults:  110.0
Minor (reclaiming a frame) faults:  303527.4

Note the total test time is around 400 seconds (wall clock * 10).
The mp3 would play just over 120 seconds by the time mtest01 completed
10 iterations.


I did a fourth run with strace -p 15645 (mp3blaster PID using most cpu time).

read(6, "\20Ks\303\303\222\236o\272\231\177\32\316\360\341\314z"..., 4096) = 4096
nanosleep({0, 200000}, NULL)            = 0     (5 calls to nanosleep)
time([1003288001])                      = 1003288001
nanosleep({0, 200000}, NULL)            = 0     (21 calls to nanosleep)
read(6, "\356$\365\274)\332\336\277c\375\356>+\234\307q\213\6\4"..., 4096) = 4096


When not running mtest01, strace is like this:

read(6, "\317W\234\311i\230\273\221\276J5\245\310A\251\226C?\202"..., 4096) = 4096
nanosleep({0, 200000}, NULL)            = 0     (4 calls to nanosleep)
time([1003287905])                      = 1003287905
nanosleep({0, 200000}, NULL)            = 0     (3 calls to nanosleep)
read(6, "$Q\17\357aL\264\301e\357S\370h{4\322L\246\344\273y\232"..., 4096) = 4096


Oddly, it appears there are more calls to nanosleep when mp3blaster is sputtering
(and fighting for i/o or memory?)


> thanks for feedback!
> 
> Andrea

My pleasure!

-- 
Randy Hron

