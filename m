Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267016AbSLXAMH>; Mon, 23 Dec 2002 19:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267019AbSLXAMH>; Mon, 23 Dec 2002 19:12:07 -0500
Received: from sabre.velocet.net ([216.138.209.205]:2566 "HELO
	sabre.velocet.net") by vger.kernel.org with SMTP id <S267016AbSLXAMF>;
	Mon, 23 Dec 2002 19:12:05 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.5.52 process in disk wait for long time reading from cd 
From: Gregory Stark <gsstark@mit.edu>
Date: 23 Dec 2002 19:20:13 -0500
Message-ID: <877ke0z2rm.fsf@stark.dyndns.tv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


More info on the problem I reported earlier. I tested kernel 2.5.52 and the
same problem occurs. Occasionally read syscalls to the DVD device take over a
second to return.

The only difference is that the wait channel on 2.4.x is listed as "lock_p"
but on 2.5.52 it's listed as "io_sch".

Linux stark.dyndns.tv 2.5.52 #5 Sat Dec 21 12:07:03 EST 2002 i686 unknown unknown GNU/Linux

The device it's reading from is /dev/hdd. DMA is enabled on all the ide
devices.

The following is output from ogle, combined with stracing the process that
blocks grepping for syscalls taking over a second to return, combined with
running ps on the same process grepping for it not blocking on msgrcv which is
the normal synchronization primitive ogle uses.

As you can see, every time ogle gets out of sync and prints the message about
"resyncing" it's following ogle_mpeg_ps blocking in a read syscall waiting on
"io_sch".

The only suggestion I've heard so far is that the DVD-Rom is bad. But to
confirm that I would need some data from the ide driver. As it is there are no
ide errors in the kernel log, no information from the driver on what operation
was being attempted and took inordinately long to complete. Nothing to report
to the vendor as evidence of a hardware defect.

Someone suggested I try raw devices. Is that possible for cdrom devices? Where
do I find the raw devices?

display: frame rate: 22.891 fps
0 T stark    18562 18559  2  76   0 -  2399 syscal 18:24 pts/6    00:00:07 ogle_mpeg_ps -m 32768
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:07 ogle_mpeg_ps -m 32768
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:07 ogle_mpeg_ps -m 32768
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:07 ogle_mpeg_ps -m 32768
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:07 ogle_mpeg_ps -m 32768
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:07 ogle_mpeg_ps -m 32768
read(3, "\0\0\1\272D\32\334\253\345\231\1\211\303\370\0\0\1\340"..., 487424) = 487424 <1.596222>
Debug[ogle_audio]: 1.+084663240 s off, resyncing
!0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:07 ogle_mpeg_ps -m 32768
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:07 ogle_mpeg_ps -m 32768
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:07 ogle_mpeg_ps -m 32768
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:07 ogle_mpeg_ps -m 32768
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:07 ogle_mpeg_ps -m 32768
read(3, "\0\0\1\272D\33\16\373\364\241\1\211\303\370\0\0\1\340\7"..., 532480) = 532480 <1.602640>
Debug[ogle_audio]: 1.+297135680 s off, resyncing
display: frame rate: 18.582 fps
display: frame rate: 23.977 fps
display: frame rate: 24.000 fps
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:08 ogle_mpeg_ps -m 32768
display: frame rate: 23.951 fps
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:08 ogle_mpeg_ps -m 32768
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:08 ogle_mpeg_ps -m 32768
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:08 ogle_mpeg_ps -m 32768
read(3, "\0\0\1\272D\35^\321\f\361\1\211\303\370\0\0\1\340\7\354"..., 323584) = 323584 <1.287339>
Debug[ogle_audio]: 0.+879741440 s off, resyncing
0 T stark    18562 18559  2  76   0 -  2399 syscal 18:24 pts/6    00:00:08 ogle_mpeg_ps -m 32768
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:08 ogle_mpeg_ps -m 32768
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:08 ogle_mpeg_ps -m 32768
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:08 ogle_mpeg_ps -m 32768
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:08 ogle_mpeg_ps -m 32768
read(3, "\0\0\1\272D\35\214z\366I\1\211\303\370\0\0\1\340\7\354"..., 323584) = 323584 <1.171526>
Debug[ogle_audio]: 0.+485963520 s off, resyncing
read(3, "\0\0\1\272D\35\254\331\356E\1\211\303\370\0\0\1\340\7\354"..., 325632) = 325632 <0.109438>
0 T stark    18562 18559  2  76   0 -  2399 syscal 18:24 pts/6    00:00:08 ogle_mpeg_ps -m 32768
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:08 ogle_mpeg_ps -m 32768
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:08 ogle_mpeg_ps -m 32768
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:08 ogle_mpeg_ps -m 32768
read(3, "\0\0\1\272D\35\277\375\324\235\1\211\303\370\0\0\1\340"..., 339968) = 339968 <1.068391>
Debug[ogle_audio]: 0.+381795280 s off, resyncing
0 R stark    18562 18559  2  76   0 -  2399 -      18:24 pts/6    00:00:08 ogle_mpeg_ps -m 32768
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:08 ogle_mpeg_ps -m 32768
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:08 ogle_mpeg_ps -m 32768
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:08 ogle_mpeg_ps -m 32768
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:08 ogle_mpeg_ps -m 32768
read(3, "\0\0\1\272D\35\356\21%\225\1\211\303\370\0\0\1\340\7\354"..., 421888) = 421888 <1.126259>
Debug[ogle_audio]: 0.+381624160 s off, resyncing
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:08 ogle_mpeg_ps -m 32768
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:08 ogle_mpeg_ps -m 32768
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:08 ogle_mpeg_ps -m 32768
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:08 ogle_mpeg_ps -m 32768
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:08 ogle_mpeg_ps -m 32768
read(3, "\0\0\1\272D\36\6\10\315A\1\211\303\370\0\0\1\340\7\354"..., 423936) = 423936 <1.593315>
Debug[ogle_audio]: 1.+098514880 s off, resyncing
0 T stark    18562 18559  2  75   0 -  2399 syscal 18:24 pts/6    00:00:08 ogle_mpeg_ps -m 32768
display: frame rate: 17.287 fps
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:08 ogle_mpeg_ps -m 32768
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:08 ogle_mpeg_ps -m 32768
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:08 ogle_mpeg_ps -m 32768
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:08 ogle_mpeg_ps -m 32768
read(3, "\0\0\1\272D\36&%\\\225\1\211\303\370\0\0\1\340\7\354\201"..., 378880) = 378880 <1.295461>
##Debug[ogle_audio]: 0.+731835080 s off, resyncing
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:08 ogle_mpeg_ps -m 32768
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:08 ogle_mpeg_ps -m 32768
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:08 ogle_mpeg_ps -m 32768
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:08 ogle_mpeg_ps -m 32768
read(3, "\0\0\1\272D\36]\272}\231\1\211\303\370\0\0\1\340\7\354"..., 501760) = 501760 <1.071489>
##Debug[ogle_audio]: 0.+521272280 s off, resyncing
0 T stark    18562 18559  2  76   0 -  2399 syscal 18:24 pts/6    00:00:08 ogle_mpeg_ps -m 32768
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:08 ogle_mpeg_ps -m 32768
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:08 ogle_mpeg_ps -m 32768
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:08 ogle_mpeg_ps -m 32768
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:08 ogle_mpeg_ps -m 32768
read(3, "\0\0\1\272D\36tZ\275I\1\211\303\370\0\0\1\340\7\354\201"..., 362496) = 362496 <1.581139>
##Debug[ogle_audio]: 1.+038802240 s off, resyncing
Debug[ogle_audio]: 0.+024722640 s off, resyncing
0 R stark    18562 18559  2  76   0 -  2399 -      18:24 pts/6    00:00:08 ogle_mpeg_ps -m 32768
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:08 ogle_mpeg_ps -m 32768
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:08 ogle_mpeg_ps -m 32768
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:08 ogle_mpeg_ps -m 32768
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:08 ogle_mpeg_ps -m 32768
read(3, "\0\0\1\272D\36}\276\365\361\1\211\303\370\0\0\1\340\7\354"..., 356352) = 356352 <1.438772>
##Debug[ogle_audio]: 1.+115369160 s off, resyncing
read(3, "\0\0\1\272D\36\2070\346E\1\211\303\370\0\0\1\340\7\354"..., 354304) = 354304 <0.136682>
0 T stark    18562 18559  2  75   0 -  2399 syscal 18:24 pts/6    00:00:08 ogle_mpeg_ps -m 32768
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:09 ogle_mpeg_ps -m 32768
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:09 ogle_mpeg_ps -m 32768
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:09 ogle_mpeg_ps -m 32768
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:09 ogle_mpeg_ps -m 32768
0 D stark    18562 18559  2  75   0 -  2399 io_sch 18:24 pts/6    00:00:09 ogle_mpeg_ps -m 32768
read(3, "\0\0\1\272D\36\2472\6A\1\211\303\370\0\0\1\340\7\354\201"..., 561152) = 561152 <1.575937>
##Debug[ogle_audio]: 0.+879007520 s off, resyncing


-- 
greg

