Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317744AbSGKDPG>; Wed, 10 Jul 2002 23:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317748AbSGKDPF>; Wed, 10 Jul 2002 23:15:05 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65040 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317744AbSGKDPF>;
	Wed, 10 Jul 2002 23:15:05 -0400
Message-ID: <3D2CFA75.FBFD6D92@zip.com.au>
Date: Wed, 10 Jul 2002 20:24:37 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Lincoln Dale <ltd@cisco.com>
CC: Benjamin LaHaise <bcrl@redhat.com>, Andrea Arcangeli <andrea@suse.de>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>, Steve Lord <lord@sgi.com>
Subject: Re: direct-to-BIO for O_DIRECT
References: <3D2904C5.53E38ED4@zip.com.au> <5.1.0.14.2.20020711122101.021a5590@mira-sjcm-3.cisco.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lincoln Dale wrote:
> 
> ...
> sorry for the delay.

Is cool.   Thanks for doing this.

> upgrading from 2.4.19 to 2.5.25 took longer than expected, since the QLogic
> FC 2300 HBA
> driver isn't part of the standard kernel, and i had to update it to reflect the
> io_request_lock -> host->host_lock, kdev_t and kbuild changes.  urgh, pain
> pain pain.
> in the process, i discovered some races in their driver, so fixed them also.
>
> the 2.5 block i/o layer is FAR superior to the 2.4 block i/o layer. kudos
> to Jens, Andrew & co for the changeover.
> 
> the results:
>    2.4.19pre8aa2 (with lockmeter and profile=2)
>       normal     167772160 blocks of 512 bytes in 778 seconds (105.27
> mbyte/sec), CPUs 0% idle
>       O_DIRECT   20480 blocks of 4194304 bytes in 430 seconds (190.47
> mbyte/sec), CPUs ~55% idle
>       /dev/rawN  20480 blocks of 4194304 bytes in 463 seconds (176.86
> mbyte/sec), CPUs ~62% idle
> 
>    2.5.25 ('virgin' 2.5.25 with the exception of changing PAGE_OFFSET to
> 0x80000000 and
>           your O_DIRECT-on-blockdev patch to stop it oopsing -- oops report
> below)
>       normal     167772160 blocks of 512 bytes in 607 seconds (134.81
> mbyte/sec), CPUs 0% idle
>       O_DIRECT   20480 blocks of 4194304 bytes in 420 seconds (194.61
> mbyte/sec), CPUs ~93% idle
>       /dev/rawN  20480 blocks of 4194304 bytes in 422 seconds (193.84
> mbyte/sec), CPUs ~92% idle

The 30% improvement in pagecache-buffered reads is somewhat unexpected.
The blockdevs are not using multipage BIOs - they're still using
buffer_head-based I/O for both reads and writes.  Are you sure that
the 2.4 QLogic driver is using block-highmem?
 
>    2.5.25 with direct-to-BIO (and PAGE_OFFSET at 0x80000000)
>       normal     167772160 blocks of 512 bytes in 615 seconds (133.06
> mbyte/sec), CPUs 0% idle
>       O_DIRECT   20480 blocks of 4194304 bytes in 421 seconds (194.37
> mbyte/sec), CPUs ~92% idle
>       /dev/rawN  20480 blocks of 4194304 bytes in 421 seconds (194.35
> mbyte/sec), CPUs ~92% idle

OK, so there's nothing there at all really (or there may be.  Hard
to tell when the interface has saturated).

But on my lowly scsi disks I was seeing no change in read bandwidth
either.  Only writes benefitted for some reason.   Can you do
some write testing as well?   If you test writes through the pagecache,
use ext2 and not direct-to-blockdev please - that'll take the multipage
BIOs, buffer_head-bypass route.  Plain old read and write of /dev/XdYY
isn't very optimised at all.

Thanks.

-
