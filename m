Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317750AbSGKDY1>; Wed, 10 Jul 2002 23:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317751AbSGKDY0>; Wed, 10 Jul 2002 23:24:26 -0400
Received: from sj-msg-core-4.cisco.com ([171.71.163.10]:36043 "EHLO
	sj-msg-core-4.cisco.com") by vger.kernel.org with ESMTP
	id <S317750AbSGKDYZ>; Wed, 10 Jul 2002 23:24:25 -0400
Message-Id: <5.1.0.14.2.20020711132113.021a6de0@mira-sjcm-3.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 11 Jul 2002 13:25:52 +1000
To: Andrew Morton <akpm@zip.com.au>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: direct-to-BIO for O_DIRECT
Cc: Benjamin LaHaise <bcrl@redhat.com>, Andrea Arcangeli <andrea@suse.de>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>, Steve Lord <lord@sgi.com>
In-Reply-To: <3D2CFA75.FBFD6D92@zip.com.au>
References: <3D2904C5.53E38ED4@zip.com.au>
 <5.1.0.14.2.20020711122101.021a5590@mira-sjcm-3.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:24 PM 10/07/2002 -0700, Andrew Morton wrote:
> >    2.5.25 ('virgin' 2.5.25 with the exception of changing PAGE_OFFSET to
> > 0x80000000 and
> >           your O_DIRECT-on-blockdev patch to stop it oopsing -- oops report
> > below)
> >       normal     167772160 blocks of 512 bytes in 607 seconds (134.81
> > mbyte/sec), CPUs 0% idle
> >       O_DIRECT   20480 blocks of 4194304 bytes in 420 seconds (194.61
> > mbyte/sec), CPUs ~93% idle
> >       /dev/rawN  20480 blocks of 4194304 bytes in 422 seconds (193.84
> > mbyte/sec), CPUs ~92% idle
>
>The 30% improvement in pagecache-buffered reads is somewhat unexpected.
>The blockdevs are not using multipage BIOs - they're still using
>buffer_head-based I/O for both reads and writes.  Are you sure that
>the 2.4 QLogic driver is using block-highmem?

pretty sure -- there's no highmem in the system: :-)
(i.e. i changed PAGE_OFFSET in order to prevent there being any highmem).

         [root@mel-stglab-host1 root]# cat /proc/meminfo
         MemTotal:      1945680 kB
         MemFree:       1853812 kB
         MemShared:           0 kB
         Cached:          29536 kB
         SwapCached:       2520 kB
         Active:          32336 kB
         Inactive:         8336 kB
         HighTotal:           0 kB
         HighFree:            0 kB
         LowTotal:      1945680 kB
         LowFree:       1853812 kB
         SwapTotal:     2047992 kB
         SwapFree:      2037268 kB
         Dirty:            1396 kB
         Writeback:           0 kB

>OK, so there's nothing there at all really (or there may be.  Hard
>to tell when the interface has saturated).
>
>But on my lowly scsi disks I was seeing no change in read bandwidth
>either.  Only writes benefitted for some reason.   Can you do
>some write testing as well?   If you test writes through the pagecache,
>use ext2 and not direct-to-blockdev please - that'll take the multipage
>BIOs, buffer_head-bypass route.  Plain old read and write of /dev/XdYY
>isn't very optimised at all.

will do.

do you have any other preferences --
  - ext2 or ext3?
  - if ext3, change the journalling mode?
  - i/o to a single large file or multiple files per spindle?

i can also add combinations of read/write & seeking also.
what kind of file-size should i be using?


cheers,

lincoln.

