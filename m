Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273887AbRIURXG>; Fri, 21 Sep 2001 13:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273990AbRIURW4>; Fri, 21 Sep 2001 13:22:56 -0400
Received: from p3E9E6263.dip.t-dialin.net ([62.158.98.99]:51207 "EHLO
	enigma.deepspace.net") by vger.kernel.org with ESMTP
	id <S273887AbRIURWq>; Fri, 21 Sep 2001 13:22:46 -0400
Message-Id: <200109211723.TAA00638@enigma.deepspace.net>
Content-Type: text/plain; charset=US-ASCII
From: Wolly <wwolly@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Huge disk performance degradation in 2.4.9
Date: Fri, 21 Sep 2001 19:23:16 +0200
X-Mailer: KMail [version 1.2.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry if this is already known or fixed. 
I did not find something related in the last 2.4.10-pre changelog. 

I recently upgraded from 2.4.6 to 2.4.9 and since then noticed that my 
hd (old noisy thing in an old P100 box) repeatedly 
sounds strange (read on, please!) when dealing with lots of small files. 
(No physical problem; it's a kernel flushing issue.)

This turned out to be the sign of a quite huge performance loss anywhere 
between 2.4.7 and 2.4.9 (sorry, using a 56k Modem, I cannot test them 
all and it's a shame that I already deleted 2.4.6 sources). 

I verified this on a PII-350 (440BX, 196Mb) using 600 files (instead of 300). 
I only tested things on reiserfs (v3.6. using 3.5 partitions) becuase I 
don't have ext2 around any longer. 

For testing purposes, I used: 
sync ; cat /proc/version ; sleep 1 ; /usr/bin/time sh -c 'declare -i cnt=0 ; 
while test $cnt -lt 300 ; do echo -en "\b\b\b\b\b\b\b$cnt " ; 
dd if=/dev/zero of=file-$cnt bs=1 count=16 >/dev/null 2>&1 ; 
cnt=$cnt+1 ; done ; echo' ; rm file-*

This creates lots of 16-byte files using 16 write() calls [second test 
with 160kb files using 16 write() calls] and prints out the time 
(On P-100; 72Mb, 1Gb hd; besides kernel: equal setup for 
all tests; machine idle; all tests ran several times; all kernels compiled 
with gcc version 2.95.2 19991024 (release)): 

       |   (dd bs=1 count=16)    | (dd bs=10240 count=16)
kernel | user system elapsed CPU | user system elapsed CPU
2.4.9  | 3.12   5.10   32.46 25% | 3.84  14.31   73.09 24%
2.4.6  | 3.28   4.17    8.17 91% | 3.96  14.76   25.76 72%
2.2.19 | 2.82   3.75    7.12 92% | 4.42  12.90   19.26 89%
(user, system, elapsed time in seconds)

Look at the elapsed times! 2.4.9 takes >=3 times as long as 2.4.6 
(and 2.2.19 performs even better). 
This is a huge performance issue and I actually notice it using when 
squid or doing a CVS checkout with lots of small files. 

When listening to the hd you note a difference. While 2.4.6 does 
a clustered write call from time to time, 2.4.9 starts to burst out in 
accessing the hd (always moving the hd's head) and does not 
finish until the test is over (same with my PII-350 and IBM 12Gb) 

Anyone reproducing this? Reiserfs issue or cache/buffer/flush issue? 

Regards, 
Wolly
