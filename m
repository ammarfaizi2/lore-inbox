Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270538AbRHHRcS>; Wed, 8 Aug 2001 13:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270534AbRHHRcJ>; Wed, 8 Aug 2001 13:32:09 -0400
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:20655 "EHLO
	mailout.plan9.de") by vger.kernel.org with ESMTP id <S270538AbRHHRb7>;
	Wed, 8 Aug 2001 13:31:59 -0400
Date: Wed, 8 Aug 2001 19:31:58 +0200
From: <pcg@goof.com ( Marc) (A.) (Lehmann )>
To: linux-kernel@vger.kernel.org
Subject: I/O very slow under 2.4 (device reading)
Message-ID: <20010808193158.A4055@cerebro.laendle>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Operating-System: Linux version 2.4.8-pre4 (root@cerebro) (gcc version 3.0.1 20010716 (prerelease)) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It might be vm related, it might be not, but I get very funny effects when
running:

   buffer -S1m -s128k -m32m </dev/hde >/dev/null

(buffer is just a fast read/write buffer reading stdin to stdout, i use it
to check wether all sectors of a disk are readable, it's similar to dd,
which creates the same effects).

The problem is that under 2.4.4, 2.4.5 and 2.4.8pre4, the machine first
reads at about 30mb/s. then, after a few minutes, it stops for small
amounts of time, and, even worse, the system becomes totally sluggish,
even unusable for parts of seconds or even a second (mouse doesn't move,
programs need ages to starte etc...)

Then, after quite some time this behaviour stops, and the command reads
only very very slowly:

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 1  0  0      0   3168 327504  51964   0   0   256     0  123   704   0  46  54
 2  0  0      0   3168 327504  51964   0   0   256     0  333  1167   0  51  49
 1  0  0      0   3168 327504  51964   0   0   256     6  141   740   0  50  50
 2  0  0      0   3172 327500  51964   0   0   256     0  110   661   0  50  50
 1  0  0      0   3128 327548  51960   0   0  8512    44  470  1595   0  45  55
 1  0  0      0   3128 327544  51960   0   0   256     2  394  2071   3  51  46
 1  0  0      0   3124 327544  51960   0   0   320     0  164   798   0  50  50
 1  0  0      0   3124 327540  51964   0   0   256     8  121   743   0  50  50
 1  0  0      0   3124 327540  51964   0   0  1280     0  176   826   0  50  50
 1  0  1      0   3120 327544  51964   0   0   320    64  201   858   0  50  50

as you can see, it reads about 256k/s only, but requires 100% cpu (it's a
dual cpu system and idle == 50 means one cpu is tied up):

   CPU1 states:  0.0% user, 100.0% system,  0.0% nice,  0.0% idle

Tied up in the kernel, btw. the rest of the system works and is fast.
hdparm reports nothing spectacular:

   /dev/hde:
   multcount    = 16 (on)
   I/O support  =  1 (32-bit)
   unmaskirq    =  1 (on)
   using_dma    =  1 (on)
   keepsettings =  1 (on)
   nowerr       =  0 (off)
   readonly     =  0 (off)
   readahead    =  8 (on)
   geometry     = 53614/16/63, sectors = 120103200, start = 0

and indeed the disk is still fast:

   cerebro:~# hdparm -tT /dev/hde

   /dev/hde:
    Timing buffer-cache reads:   128 MB in  0.76 seconds =168.42 MB/sec
    Timing buffered disk reads:  64 MB in  1.78 seconds = 35.96 MB/sec

this is, btw, WHILE the above buffer command was still running.

any ideas how to proceed with this problem?

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
