Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271320AbRHZPZS>; Sun, 26 Aug 2001 11:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271329AbRHZPZI>; Sun, 26 Aug 2001 11:25:08 -0400
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:31668 "EHLO
	mailout.plan9.de") by vger.kernel.org with ESMTP id <S271320AbRHZPYw>;
	Sun, 26 Aug 2001 11:24:52 -0400
Date: Sun, 26 Aug 2001 17:25:05 +0200
From: <pcg@goof.com ( Marc) (A.) (Lehmann )>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Message-ID: <20010826172505.E22677@cerebro.laendle>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010826165517.D22677@cerebro.laendle> <Pine.LNX.4.33L.0108261158470.5646-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0108261158470.5646-100000@imladris.rielhome.conectiva>
X-Operating-System: Linux version 2.4.8-ac8 (root@cerebro) (gcc version 3.0.1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 26, 2001 at 12:06:42PM -0300, Rik van Riel <riel@conectiva.com.br> wrote:
> > It must be enough, unfortunately ;)
> 
> Then you'll need to change the physical structure of
> your disks to eliminate seek time. ;)

well, you could send me 200GB flashdisks, that would certainly help, but
what else could I do that is hardware-cost-neutral?

(there are currently three disks on two ide channels, so there is one
obvious optimization left, but this is completely independent of the
problem ;)

I really think linux should be able to achieve what the hardwrae can,
rather than fixing linux vm shortcomings with faster disks.

(playing around with readahead did indeed give me a very noticable
performance improvement, and ~40 mbits is ok).

> Automatic scaling of readahead window and possibly more agressive
> drop-behind could help your system load.

well, the system "load" is very low (50% idle time ;) here is the top ouput
of the current (typical) load:

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
 8390 root      20   0 95312  93M  1076 S    43.9 18.5  16:03 myhttpd
 8661 root      17  -4 32464  31M   944 R <  28.4  6.2   1:07 get
 6279 root      18  14  4856 4856   524 R N  27.3  0.9 122:19 dec
 8396 root      10   0 95312  93M  1076 D     6.5 18.5   1:43 myhttpd
 8395 root      11   0 95312  93M  1076 D     5.3 18.5   1:46 myhttpd
 8394 root       9   0 95312  93M  1076 D     4.4 18.5   1:42 myhttpd
 8682 root      19   0  1012 1012   800 R     4.2  0.1   0:01 top

myhttpd is the http serverr, doing about 4MB/s now @ 743 connections.
"get" is a process that reads usenet news from many different servers and
dec is a decoder that decoded news. The news spool is on a 20Gb, 5 disk
SCSI array, together with the system itself. The machine is a dual P-II
300.

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 2  3  1      0   3004  11436 171676   0   0   225   170  303    75  30  45  25
# the above line was the total system uptime average, now vmstat 5 output:
 1  4  2      0   3056  11060 165760   0   0  7094   103 6905  1046  31  51  18
 1  4  2      0   3056  11264 165532   0   0  6173   183 6146  1051  30  41  29
 2  4  2      0   3056  10988 167656   0   0  7402   150 6706  1204  31  48  21
 0  6  0      0   3056  11196 167344   0   0  7249   265 6760  1318  30  47  23
 0  4  0      0   3056  11336 166876   0   0  1718   190 4995   582  25  19  55
 2  0  0      0   3056  11536 166988   0   0  1057   264 3264   313  22  12  65
 2  5  1      0   2880  11332 152916   0   0  1776   121 2789   280  32  22  46
 1  5  0      0  16108  11472 153984   0   0  1040   215 3255   248  29  15  56
 1  4  3      0   3056  11624 166800   0   0  4406   179 3329   653  32  23  45
 1  4  0      0   3056  10852 167636   0   0  6970   138 5521  1247  34  39  26
 2  4  0      0   3056  11016 167440   0   0  7238   162 5997  1118  36  39  25
 2  4  1      0   3056  11284 177332   0   0  6247    84 5206  1293  34  36  30
 1  4  2      0   3052  11296 181564   0   0  7800    85 5493  1399  35  41  24

There are 4 reader threads ATM, and this coincides nicely with the 4
blocked tasks.

> so we have an idea of what kind of system load we're facing, and
> the active/inactive memory lines from /proc/meminfo ?

I then did: while sleep 5; do grep "\(^In\|^Act\)" </proc/meminfo;done

Active:         144368 kB
Inact_dirty:     29048 kB
Inact_clean:       192 kB
Inact_target:    19348 kB
Active:         154012 kB
Inact_dirty:     14092 kB
Inact_clean:      5556 kB
Inact_target:    19360 kB
Active:         164908 kB
Inact_dirty:     21212 kB
Inact_clean:      5428 kB
Inact_target:    19104 kB
Active:         169788 kB
Inact_dirty:     20652 kB
Inact_clean:      1224 kB
Inact_target:    18912 kB
Active:         147280 kB
Inact_dirty:     37444 kB
Inact_clean:      5080 kB
Inact_target:    19132 kB
Active:         151400 kB
Inact_dirty:     26604 kB
Inact_clean:     10280 kB
Inact_target:    19328 kB
Active:         157288 kB
Inact_dirty:      9312 kB
Inact_clean:     20988 kB
Inact_target:    19500 kB
Active:         160456 kB
Inact_dirty:     11908 kB
Inact_clean:     12112 kB
Inact_target:    19672 kB

> Indeed, something is going wrong ;)
> 
> Lets find out exactly what so we can iron out this bug
> properly.

When that happened I can test wether massively increasing the number of
reader threads changes performance ;)

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
