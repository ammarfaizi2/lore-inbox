Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270528AbRHWVgR>; Thu, 23 Aug 2001 17:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270546AbRHWVgH>; Thu, 23 Aug 2001 17:36:07 -0400
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:42937 "EHLO
	mailout.plan9.de") by vger.kernel.org with ESMTP id <S270528AbRHWVfs>;
	Thu, 23 Aug 2001 17:35:48 -0400
Date: Thu, 23 Aug 2001 23:35:57 +0200
From: <pcg@goof.com ( Marc) (A.) (Lehmann )>
To: linux-kernel@vger.kernel.org
Cc: oesi@plan9.de
Subject: very slow parallel read performance
Message-ID: <20010823233557.A12873@cerebro.laendle>
Mail-Followup-To: linux-kernel@vger.kernel.org, oesi
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Operating-System: Linux version 2.4.8-ac8 (root@cerebro) (gcc version 3.0.1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tested the following under linux-2.4.8-ac8, linux-2.4.8pre4 and
2.4.5pre4, all had similar behaviour.

I have written a webserver that serves many large files, and thus, the
disks are the bottleneck. To get around the problem of blocking reads
(this killed thttpd's performance totally, for example) I can start one or
more reader threads. And strace of them under load looks like this:

     0.000400 read(6, "\300g#\v", 4)    = 4 <0.000091>
     0.000315 lseek(1129, 70376488, SEEK_SET) = 70376488 <0.000088>
     0.000287 read(1129, "\212\266\233^\250\23\256D\21E\'#c\242\351pp`:Q[\22/:\27"..., 65536) = 65536 <0.047408>
     0.051059 write(9, "\300g#\v", 4)   = 4 <0.000052>
     0.000222 read(6, "@\3755\r", 4)    = 4 <0.000036>
     0.000187 lseek(946, 26180056, SEEK_SET) = 26180056 <0.000035>
     0.000162 read(946, "\0\20\24\0\330\6\30\264\345\263\247\213\264\0\274\4\340"..., 65536) = 65536 <0.029500>
     0.029976 write(9, "@\3755\r", 4)   = 4 <0.000098>
     0.000331 read(6, "\300\373j\r", 4) = 4 <0.000088>
     0.000309 lseek(944, 33816188, SEEK_SET) = 33816188 <0.000090>
     0.000287 read(944, "\210]\360C\340\200\315\363@\205\203\250\316\256\"\34,E"..., 65536) = 65536 <0.043455>
     0.043885 write(9, "\300\373j\r", 4) = 4 <0.000042>
     0.000200 read(6, "\0\227M\r", 4)   = 4 <0.000035>
     0.000191 lseek(315, 1310720, SEEK_SET) = 1310720 <0.000034>
     0.000162 read(315, "\7\17\376\250\37\312m\210\24\215s\257v\246\354\272\253"..., 65536) = 65536 <0.025821>
     0.026236 write(9, "\0\227M\r", 4)  = 4 <0.000040>

filehandles 6 and 9 are request / result filehandles, i.e. the thread(s)
read the request on filehandle 6, execute it (e.g. lseek/read) and then
write the result back to fh 9.

as you can see, the read-request/lseek/write-result syscalls are very
fast, while the read-from-file-call totally dominates the runtime, which
is sensible, since the disks can only seek so-and-so-many times per
second. under this config the server steadily delivers about 23mbits/s.

Now I thought I'd start more threads to give the kernel elevator more
chances to optimize reads, however, it gets much slower. when I start 128
threads, the strace of one thread now looks like this:

     0.002181 read(6, "\300\311\205\f", 4) = 4 <0.000091>
     0.000351 lseek(857, 12798664, SEEK_SET) = 12798664 <0.000087>
     0.000292 read(857, "^0\260\274\363\3078\314\373\343\254h\360\276\347\332\305"..., 65536) = 65536 <28.176472>
    28.177062 write(9, "\300\311\205\f", 4) = 4 <0.000039>
     0.000200 read(6, "@\2\265\10", 4)  = 4 <0.000033>
     0.000480 lseek(471, 6553600, SEEK_SET) = 6553600 <0.000033>
     0.000182 read(471, "\244\t*\\\225`+\270@\210\206\367\10\261\4m\32\206\377x"..., 65536) = 65536 <36.023682>
    36.025902 write(9, "@\2\265\10", 4) = 4 <0.000107>
     0.000422 read(6, "\0A\235\r", 4)   = 4 <0.000107>
     0.000335 lseek(1239, 7143424, SEEK_SET) = 7143424 <0.000088>
     0.000309 read(1239, "\'\213\315\372\331+x\271\234Bx\255\274\"G\202\264L+>\266"..., 65536) = 65536 <0.154575>
     0.155760 write(9, "\0A\235\r", 4)  = 4 <0.000093>
     0.000337 read(6, "@G\235\r", 4)    = 4 <0.000387>
     0.000676 lseek(998, 4989944, SEEK_SET) = 4989944 <0.000093>
     0.000357 read(998, "\214P\325|k\226\260\31\351\260\10\10:\23d`\271Tu\32\252"..., 65536) = 65536 <36.512863>
    36.513243 write(9, "@G\235\r", 4)   = 4 <0.002407>

as you can see, read request now can take about ten times longer than they
should (30 / 128 = 0.2). as a result, webserver thruput decreases to a
mere 4mbits/s.

I would have expected a slight slowdown at most (more processing, maybe
cache effects), but not that much. any ideas why this is so and what could
be done against it?

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
