Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272467AbRIWXTN>; Sun, 23 Sep 2001 19:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273688AbRIWXTE>; Sun, 23 Sep 2001 19:19:04 -0400
Received: from p3E9E62F9.dip.t-dialin.net ([62.158.98.249]:1540 "EHLO
	enigma.deepspace.net") by vger.kernel.org with ESMTP
	id <S272467AbRIWXSs>; Sun, 23 Sep 2001 19:18:48 -0400
Message-Id: <200109232319.BAA02449@enigma.deepspace.net>
Content-Type: text/plain; charset=US-ASCII
From: Wolly <wwolly@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Huge disk performance degradation STILL IN 2.4.10
Date: Mon, 24 Sep 2001 01:19:18 +0200
X-Mailer: KMail [version 1.2.1]
In-Reply-To: <200109211723.TAA00638@enigma.deepspace.net>
In-Reply-To: <200109211723.TAA00638@enigma.deepspace.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi kernel hackers, 

As soon as 2.4.10 was out, I got the patch and tested it again. 
The problem is still there and did not get better at all. 

Please have a look at that: 

How to reproduce: Get the slowest computer you have and 
execute the file creation script as mentioned in my previous e-mail 
(appended below). 

The faster the computer and the more RAM, the more files you have 
to create. Try increasing their number from 300 to 600 or 1000. 
Try running it several times; turn off swap. 

The symptomes are as follows: The file counter raises quickly until 
at some point it begins to raise slowly only (2-4 files/sec on a P100 
with 5 year old hardware). The hd is then accessed all the time and 
the hd's head is moved around continuously making things really slow. 

If you still cannot reproduce it, make sure you have some applications 
running (X, windowmanager, xterm) and try executing `sync' in 
another XTerm while the file creation script is running. 

When I tried, sync did not return until all files were created and 
the creation was awefully slow (steady hd accessed & head move). 

>Is there nobody out there who can try & reproduce this?!

To me, it seems this is either a cache/buffer/flush issue or a 
reiserfs journal congestion issue. 

Regards, 
Wolly

On Friday 21 September 2001 19:23, I wrote:
> I recently upgraded from 2.4.6 to 2.4.9 and since then noticed that my
> hd (old noisy thing in an old P100 box) repeatedly
> sounds strange (read on, please!) when dealing with lots of small files.
> (No physical problem; it's a kernel flushing issue.)
>
> This turned out to be the sign of a quite huge performance loss anywhere
> between 2.4.7 and 2.4.9 (sorry, using a 56k Modem, I cannot test them
> all and it's a shame that I already deleted 2.4.6 sources).
>
> I verified this on a PII-350 (440BX, 196Mb) using 600 files (instead of
> 300). I only tested things on reiserfs (v3.6. using 3.5 partitions) becuase
> I don't have ext2 around any longer.
>
> For testing purposes, I used:
> sync ; cat /proc/version ; sleep 1 ; /usr/bin/time sh -c 'declare -i cnt=0
> ; while test $cnt -lt 300 ; do echo -en "\b\b\b\b\b\b\b$cnt " ;
> dd if=/dev/zero of=file-$cnt bs=1 count=16 >/dev/null 2>&1 ;
> cnt=$cnt+1 ; done ; echo' ; rm file-*
>
> This creates lots of 16-byte files using 16 write() calls [second test
> with 160kb files using 16 write() calls] and prints out the time
> (On P-100; 72Mb, 1Gb hd; besides kernel: equal setup for
> all tests; machine idle; all tests ran several times; all kernels compiled
>
> with gcc version 2.95.2 19991024 (release)):
>        |   (dd bs=1 count=16)    | (dd bs=10240 count=16)
>
> kernel | user system elapsed CPU | user system elapsed CPU
> 2.4.9  | 3.12   5.10   32.46 25% | 3.84  14.31   73.09 24%
> 2.4.6  | 3.28   4.17    8.17 91% | 3.96  14.76   25.76 72%
> 2.2.19 | 2.82   3.75    7.12 92% | 4.42  12.90   19.26 89%
> (user, system, elapsed time in seconds)
>
> Look at the elapsed times! 2.4.9 takes >=3 times as long as 2.4.6
> (and 2.2.19 performs even better).
> This is a huge performance issue and I actually notice it using when
> squid or doing a CVS checkout with lots of small files.
>
> When listening to the hd you note a difference. While 2.4.6 does
> a clustered write call from time to time, 2.4.9 starts to burst out in
> accessing the hd (always moving the hd's head) and does not
> finish until the test is over (same with my PII-350 and IBM 12Gb)
>
> Anyone reproducing this? Reiserfs issue or cache/buffer/flush issue?
>
> Regards,
> Wolly
