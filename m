Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314096AbSEISrb>; Thu, 9 May 2002 14:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314095AbSEISr3>; Thu, 9 May 2002 14:47:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49418 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314096AbSEISrZ>;
	Thu, 9 May 2002 14:47:25 -0400
Message-ID: <3CDAC4EB.FC4FE5CF@zip.com.au>
Date: Thu, 09 May 2002 11:50:19 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Lincoln Dale <ltd@cisco.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
In-Reply-To: <3CD9E8A7.D524671D@zip.com.au> <5.1.0.14.2.20020509193347.02ff6dc8@mira-sjcm-3.cisco.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lincoln Dale wrote:
> 
> ...
> i've validated that the performance difference is due to copy_to_user().
> i created a hack in the tree where a read() on a file opened with the
> option O_NOCOPY causes no copy_to_user() to occur. (diff at the bottom of
> this email).
> 
> on this test machine (dual P3 Xeon / 256K L2 cache, 2G PC133 SDRAM, QLogic
> 2300 FC HBA, 8 x 15K RPM disks).
> maximum theoretical performance is 2gbit/s (~200mbyte/sec).  kernel is 2.4.18.
> 
> i get the following performance numbers with 256K reads syncronously from
> the disks:

For bulk read() and write() I/O the best sized buffer is 8 kbytes.  4k is
pretty good, too.  Anything larger blows the user-side buffer out of L1.
This is for x86.

This is a pretty important point, so let's repeat it:

Userspace programmers who are writing bulk-transfer read/write loops
should use an 8 kbyte transfer buffer.

>          /dev/md0 raid-0 with O_DIRECT:          91847kbyte/sec (2781usec
> avg latency/read)
>          /dev/md0 raid-0:                                129455kbyte/sec
> (1978usec avg latency/read)
>          /dev/md0 raid-0 with O_NOCOPY:  195868kbyte/sec (1297usec avg
> latency/read)

hmm.  Why is O_DIRECT always the slowest?  (and it would presumably do
even worse with an 8k transfer size).

-
