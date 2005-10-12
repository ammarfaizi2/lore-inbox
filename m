Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751354AbVJLI3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbVJLI3A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 04:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbVJLI27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 04:28:59 -0400
Received: from mail6.hitachi.co.jp ([133.145.228.41]:59632 "EHLO
	mail6.hitachi.co.jp") by vger.kernel.org with ESMTP
	id S1751354AbVJLI27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 04:28:59 -0400
Date: Wed, 12 Oct 2005 17:28:44 +0900 (JST)
Message-Id: <20051012.172844.59463643.noboru.obata.ar@hitachi.com>
To: pavel@ucw.cz
Cc: hyoshiok@miraclelinux.com, linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Dump Summit 2005
From: OBATA Noboru <noboru.obata.ar@hitachi.com>
In-Reply-To: <20051010084535.GA2298@elf.ucw.cz>
References: <20051010084535.GA2298@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Pavel,

On Mon, 10 Oct 2005, Pavel Machek wrote:
> 
> > Compressing a 32GB dump file took about 40 minutes on Pentium 4
> > Xeon 3.0GHz, which is not good enough because the dump without
> > compression took only 5 minutes; eight times slower.
> 
> ....you probably want to look at suspend2.net project. They have
> special compressor aimed at compressing exactly this kind of data,
> fast enough to be improvement.

Thank you for pointing me to the interesting project.

I looked at their patch to find that the special compressor uses
the LZF compression algorithm.  (Correct me if I'm wrong.)

So I made a quick comparison between cp, lzf(*) and gzip as
follows.  The INFILE is a file that showed the worst compression
ratio last time.

(*) A simple compress tool based on LZF algorithm included in
    liblzf, available from http://www.goof.com/pcg/marc/liblzf.html


$ cp INFILE /dev/null           # this puts whole INFILE in a cache

$ /usr/bin/time cp INFILE /mnt/OUTFILE-cp
0.23user 14.16system 0:35.94elapsed 40%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (115major+15minor)pagefaults 0swaps

$ /usr/bin/time ./lzf -c < INFILE > /mnt/OUTFILE-lzf
35.04user 13.10system 0:54.30elapsed 88%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (84major+74minor)pagefaults 0swaps

$ /usr/bin/time gzip -1c < INFILE > /mnt/OUTFILE-gzip-1
186.84user 11.73system 3:20.36elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (90major+93minor)pagefaults 0swaps


The results can be summarized as follows.  The lzf tool is
slower than cp (normal file copy) only by a factor of 1.5,
achieving the compress ratio close to gzip -1.


   CMD     | NET TIME (in seconds)          | OUTPUT SIZE (in bytes)
  ---------+--------------------------------+------------------------
   cp      |  35.94 (usr 0.23, sys 14.16)   | 2,121,438,352 (100.0%)
   lzf     |  54.30 (usr 35.04, sys 13.10)  | 1,959,473,330 ( 92.3%)
   gzip -1 | 200.36 (usr 186.84, sys 11.73) | 1,938,686,487 ( 91.3%)
  ---------+--------------------------------+------------------------


Although it is too early to say lzf's compress ratio is good
enough, its compression speed is impressive indeed.  And the
result also suggests that it is too early to give up the idea of
full dump with compression.

Pavel, thank you again for your advice and I'll welcome further
suggestions.

-- 
OBATA Noboru (noboru.obata.ar@hitachi.com)

