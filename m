Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283615AbRLEA1w>; Tue, 4 Dec 2001 19:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283616AbRLEA1n>; Tue, 4 Dec 2001 19:27:43 -0500
Received: from manotes3.ma.lycos.com ([209.202.247.138]:22792 "EHLO
	manotes3.ma.lycos.com") by vger.kernel.org with ESMTP
	id <S283615AbRLEA1a>; Tue, 4 Dec 2001 19:27:30 -0500
Subject: NFS Performance on Linux 2.2.19 (RedHat version) -- lstat64() ?
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFEE87D44A.D1899606-ON85256B19.00026956@ma.lycos.com>
From: Joe.Pranevich@corp.terralycos.com
Date: Tue, 4 Dec 2001 19:27:38 -0500
X-MIMETrack: Serialize by Router on MANOTES3/Lycos(Release 5.0.8 |June 18, 2001) at 12/04/2001
 07:27:30 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm currently involved in porting one of our properties over to Linux from
Solaris and have noticed some disparities in NFS client performance between
Linux and Solaris and I thought I'd ask about it. (The property is almost
100% NFS-based with a couple terabytes of storage on the backend in a sort
of hashed directory structure.) The NFS servers that we are using are all
NetApps.

I have run quick benchmarks (dd'ing from /dev/zero to files on the nfs
mount, then reading them back on other hosts) and have seen good
performance for Linux all around. (The servers that we are using are IBM
dual 800 mhz jobs w/ 2 Gig RAM vs a Sun E450) Under these simple
circumstances, Linux ranges from almost as good as Solaris (writing to NFS)
to almost twice as good (reading from NFS)-- at least how we have things
setup, but not in a precise testing environment. Where my confusion comes
in is that a simple "ls" against a directory with a couple files takes
approximately 4-5 times as long under Linux as on Solaris. Doing a "strace
-c" on the ls process shows that nearly all of the time is being spent in
lstat64(). (And yes, I was using "ls --color=none" :) ) (Our application
does a lot of similar operations, so this is a valid test.)

Is this a known issue or is there are workaround that might allow me to
improve performance? Although I'm running a RedHat kernel (which I
understand is based on one of the AC kernels, partly), there may be a newer
version of the NFS client software that I could try. (I found the
SourceForge site for the server software, but not the client.) Does the 2.4
kernel have significantly better NFS performance or any advantage that
might be worth the effort of switching for benchmarking? (You'd think I
might know the answer to that, wouldn't you...)

(And yes, I know that this is an apples-to-oranges comparison, but since
we're mostly network bound I don't think it's likely to be much of a deal.)

Thanks so much for your help, I've appended some additional information to
this mail that may make things clearer.

Joe Pranevich (wearing his Lycos hat)
Production Service Manager
Lycos Personal Publishing

--

NFS options:

hard,nfsvers=3,intr,rsize=8192,wsize=8192,bg

(similar trials were performed with NFS v2, and both TCP and UDP modes.)

Ethernet cards are eepro100 cards using the Linux "eepro100.o" driver. I
did a benchmark with Intel's e100.o driver and it was twice as slow, even
with hardware checksumming enabled. Note that I'm forcing duplex and speed,
but not doing any other trickery.

strace -c -f ls -alF --color=none

% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 99.82    4.184893        3532      1185           lstat64
  0.12    0.005008         218        23         5 open
  0.04    0.001773         253         7           getdents
  0.01    0.000292          14        21           write
  0.00    0.000116          10        12           read
  0.00    0.000109           5        24           old_mmap
  0.00    0.000074           4        21           close
  0.00    0.000057           6         9           munmap
  0.00    0.000046           5        10           brk
  0.00    0.000029          15         2           socket
  0.00    0.000025           5         5           fcntl
  0.00    0.000025           2        13           fstat
  0.00    0.000019          10         2         2 connect
  0.00    0.000016           3         5           mprotect
  0.00    0.000014           2         6           fstat64
  0.00    0.000010           2         5           lseek
  0.00    0.000008           4         2         2 ioctl
  0.00    0.000006           6         1           getpid
  0.00    0.000005           5         1           time
  0.00    0.000002           2         1           personality
------ ----------- ----------- --------- --------- ----------------
100.00    4.192527                  1355         9 total

Same directory on Sun: (although their truss adds two seconds to this
command. When done un-trussed using "time", it's only one second. Linux
isn't as affected as such.)

syscall      seconds   calls  errors
_exit            .00       1
read             .00       1
write            .02      11
open             .00       6      1
close            .00       6
time             .00       1
brk              .00      60
stat             .00       1
fstat            .00       3
ioctl            .01       2      2
execve           .00       1
fcntl            .00       2
mmap             .00       7
munmap           .00       2
memcntl          .00       1
llseek           .00       1
acl              .14    1185
door             .00       4
getdents64       .00      53
lstat64          .40    1185
fstat64          .00       2
open64           .00       2
                ----     ---    ---
sys totals:      .57    2537      3
usr time:        .33
elapsed:        3.05




