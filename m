Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263893AbUH0MXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263893AbUH0MXf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 08:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263971AbUH0MXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 08:23:35 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:47830
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S263893AbUH0MXb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 08:23:31 -0400
Message-ID: <412F27C1.6030100@bio.ifi.lmu.de>
Date: Fri, 27 Aug 2004 14:23:29 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.8.1+patches: Still a memory leak with cdrecord
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the cdrecord memory leak with atapi cdwriters and dma-over-cpu
seems still to be there, and it happens with *data* images
(I haven't tried audio at all). Before I was just reading about
problems with audio CDs, but here it definitely happens with
data images.

I run kernel 2.6.8.1 and have applied both bio_uncopy_user-mem-leak.patch
and bio_uncopy_user-mem-leak-fix.patch.

When I write a cd or dvd image with

cdrecord dev=ATAPI:/dev/hdd -dao -data bla.img

and DMA is turned off (checked with hdparm -d), memory is running
full during the write process, until oom killer jumps in (see below).
The problem occurs with a NEC ND-1300A and a PlexWriter W5224TA.
With DMA turned on with hdparm, everything goes fine.

Most of the PCs I tested are Athlon XP 3000+. On a dual-cpu
Athlon MP2800+, the leaking is also visiable, but the memory
fills much slower while the burning speed (mb/s) is the same.
Just like only every second page was not released anymore on the
dual cpu machine...

I'm not able to really track the problem down, because it is not
permanent. PCs that were leaking yesterday, went fine this morning
for the first 2-3 CDs, then started leaking again. Another PC
that was leaking first, is now burning CDs without problems. All
that with DMA always off for all the burners. I've also one
PC that is always burning CDs without any leak (and they
are all running the same kernel and have the same distribution/
packet selection installed...).

I've no idea what's causing that flip-flop between leaking/non-leaking
behaviour, but some bug is still there. What can I do to provide
useful debugging information?

Following is the output of the oom killer.

cu,
Frank


Aug 26 14:13:42 wirth kernel: oom-killer: gfp_mask=0xd0
Aug 26 14:13:42 wirth kernel: DMA per-cpu:
Aug 26 14:13:42 wirth kernel: cpu 0 hot: low 2, high 6, batch 1
Aug 26 14:13:42 wirth kernel: cpu 0 cold: low 0, high 2, batch 1
Aug 26 14:13:42 wirth kernel: Normal per-cpu:
Aug 26 14:13:42 wirth kernel: cpu 0 hot: low 32, high 96, batch 16
Aug 26 14:13:42 wirth kernel: cpu 0 cold: low 0, high 32, batch 16
Aug 26 14:13:42 wirth kernel: HighMem per-cpu:
Aug 26 14:13:42 wirth kernel: cpu 0 hot: low 32, high 96, batch 16
Aug 26 14:13:42 wirth kernel: cpu 0 cold: low 0, high 32, batch 16
Aug 26 14:13:42 wirth kernel:
Aug 26 14:13:42 wirth kernel: Free pages:      107700kB (105792kB HighMem)
Aug 26 14:13:42 wirth kernel: Active:13356 inactive:253643 dirty:0 writeback:0 unstable:0 free:26925 slab:2333 mapped:12041 pagetables:151
Aug 26 14:13:42 wirth kernel: DMA free:44kB min:16kB low:32kB high:48kB active:4kB inactive:0kB present:16384kB
Aug 26 14:13:42 wirth kernel: protections[]: 8 476 732
Aug 26 14:13:42 wirth kernel: Normal free:1864kB min:936kB low:1872kB high:2808kB active:1236kB inactive:1060kB present:901120kB
Aug 26 14:13:42 wirth kernel: protections[]: 0 468 724
Aug 26 14:13:42 wirth kernel: HighMem free:105792kB min:512kB low:1024kB high:1536kB active:52184kB inactive:1013512kB present:1179632kB
Aug 26 14:13:42 wirth kernel: protections[]: 0 0 256
Aug 26 14:13:42 wirth kernel: DMA: 1*4kB 1*8kB 0*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 44kB
Aug 26 14:13:42 wirth kernel: Normal: 0*4kB 1*8kB 0*16kB 0*32kB 1*64kB 0*128kB 1*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB = 1864kB
Aug 26 14:13:42 wirth kernel: HighMem: 222*4kB 417*8kB 216*16kB 96*32kB 121*64kB 42*128kB 8*256kB 6*512kB 1*1024kB 1*2048kB 18*4096kB = 105792kB
Aug 26 14:13:42 wirth kernel: Swap cache: add 0, delete 0, find 0/0, race 0+0
Aug 26 14:13:42 wirth kdm[6478]: Greeter exited unexpectedly
Aug 26 14:13:42 wirth kernel: Out of Memory: Killed process 6906 (kdm_greet).
...
(continues to kill processes)


-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049
* Rekursion kann man erst verstehen, wenn man Rekursion verstanden hat. *
