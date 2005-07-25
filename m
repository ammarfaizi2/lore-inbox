Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbVGYPgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVGYPgJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 11:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbVGYPgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 11:36:08 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:45838 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261178AbVGYPgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 11:36:08 -0400
Date: Mon, 25 Jul 2005 17:24:26 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Andreas Baer <lnx1@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with Asus P4C800-DX and P4 -Northwood-
Message-ID: <20050725152425.GA24568@alpha.home.local>
References: <42E4373D.1070607@gmx.net> <20050725051236.GS8907@alpha.home.local> <42E4E4B0.6050904@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42E4E4B0.6050904@gmx.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2005 at 03:10:08PM +0200, Andreas Baer wrote:
(...)
> I have (S-ATA-150 Disk 80GB)
> 
>          /dev/sda:  50.59 MB/sec
>          /dev/sda1: 50.62 MB/sec    (Windows FAT32)
>          /dev/sda6: 41.63 MB/sec    (Linux ReiserFS)
> 
> On the Notebook I have at most an ATA-100 Disk with 80GB and it shows the 
> same declension.
> 
> Here I have
> 
>          /dev/hda:  26.91 MB/sec
>          /dev/hda1: 26.90 MB/sec    (Windows FAT32)
>          /dev/hda7: 17.89 MB/sec    (Linux EXT3)
> 
> Could you give me a reason how this is possible?

a reason for what ? the fact that the notebook performs faster than the
desktop while slower on I/O ?

> Vmstat for Notebook P4 3.0 GHz 512 MB RAM:

Your Notebook's P4 has HT enabled (50% apparent idle remain permanently during
operation). But you'll note that your load is 60% system + 40% user there, and
that you do absolutely no I/O (I presume it's the second run and it's cached).

> procs -----------memory---------- ---swap-- -----io---- --system-- 
> ----cpu----
>  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy 
>  id wa
>  1  0      0 179620  14812 228832    0    0    33    21  557   184  3  1 
>  95  1
>  2  0      0 178828  14812 228832    0    0     0     0 1295   819  6  2 
>  92  0
>  1  0      0 175948  14812 228832    0    0     0     0 1090   111 37 17 
>  46  0
>  1  0      0 175948  14812 228832    0    0     0     0 1064   101 23 28 
>  50  0
>  1  0      0 175948  14812 228832    0    0     0     0 1066   100 20 31 
>  49  0
>  1  0      0 175980  14820 228824    0    0     0    48 1066   119 20 30 
>  50  0
>  1  0      0 175980  14820 228824    0    0     0     0 1067    86 19 31 
>  50  0
>  1  0      0 175988  14820 228824    0    0     0     0 1064   115 20 30 
>  50  0

(...)
 
> Vmstat for Desktop P4 2.4 GHz 1024 MB RAM:

This one's hyperthreaded too (apparent consumption never goes above 50%).
However, while not doing any I/O either, you're always spending only 4% in
user and 96% in system. This means that it might take 10x more time to
complete the same operations, had it been user-cpu bound. And this is about
what you observe.

There clearly is a problem on the system installed on this machine. You should
use strace to see what this machine does all the time, it is absolutely not
expected that the user/system ratios change so much between two nearly
identical systems. So there are system calls which eat all CPU. You may want
to try strace -Tttt on the running process during a few tens of seconds. I
guess you'll immediately find the culprit amongst the syscalls, and it might
give you a clue.

> procs -----------memory---------- ---swap-- -----io---- --system-- 
> ----cpu----
>  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy 
>  id wa
>  1  0      0 594688  39340 292228    0    0    52    29  581   484  5  2 
>  92  2
>  1  0      0 591208  39340 292228    0    0     0    68 1116   545 15 14 
>  71  0
>  1  0      0 591208  39340 292228    0    0     0     0 1090   112  3 48 
>  50  0
>  1  0      0 591208  39340 292228    0    0     0     0 1089   124  2 48 
>  50  0
>  1  0      0 591208  39340 292228    0    0     0     0 1089   114  3 48 
>  50  0
>  1  0      0 591208  39340 292228    0    0     0     0 1090   120  1 49 
>  50  0
>  1  0      0 591208  39340 292228    0    0     0    24 1094   138  2 49 
>  50  0
>  1  0      0 591256  39340 292228    0    0     0     0 1090   118  2 48 
>  50  0

(...)

Regards,
Willy

