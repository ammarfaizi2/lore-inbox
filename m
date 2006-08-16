Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751042AbWHPLdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbWHPLdf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 07:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbWHPLde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 07:33:34 -0400
Received: from spirit.analogic.com ([204.178.40.4]:36618 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751042AbWHPLde convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 07:33:34 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 16 Aug 2006 11:33:33.0206 (UTC) FILETIME=[CE15D360:01C6C127]
Content-class: urn:content-classes:message
Subject: Re: Maximum number of processes in Linux
Date: Wed, 16 Aug 2006 07:33:31 -0400
Message-ID: <Pine.LNX.4.61.0608160720210.4352@chaos.analogic.com>
In-Reply-To: <44E2ED07.6070203@aitel.hist.no>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Maximum number of processes in Linux
thread-index: AcbBJ84fPpQ7gKBlQMaT0GcoKhLfCw==
References: <3420082f0608151059s40373a0bg4a1af3618c2b1a05@mail.gmail.com> <Pine.LNX.4.61.0608151419120.13947@chaos.analogic.com> <20060815182219.GL8776@1wt.eu> <Pine.LNX.4.61.0608151511310.3138@chaos.analogic.com> <44E2ED07.6070203@aitel.hist.no>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Helge Hafting" <helge.hafting@aitel.hist.no>
Cc: "Willy Tarreau" <w@1wt.eu>, "Irfan Habib" <irfan.habib@gmail.com>,
       "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 16 Aug 2006, Helge Hafting wrote:

> linux-os (Dick Johnson) wrote:
>> Yep....
>>
>> #include <stdio.h>
>> #include <signal.h>
>> int main()
>> {
>>      unsigned long i;
>>      for(i = 0; ; i++)
>>      {
>>          switch(fork())
>>          {
>>          case 0:		// kid
>>  	pause();
>>          break;
>>          case -1:	// Failed
>>          printf("%lu\n", i);
>>              kill(0, SIGTERM);
>>              exit(0);
>>          default:
>>              break;
>>          }
>>      }
>>      return 0;
>> }
>>
>> Shows a consistent 6140.
>>
> Doesn't work here.  Without ulimit, I wasn't surprised
> about the resulting OOM mess.
>
> Problem was, it never stopped.  I expected OOM to kill
> this program, and quite possibly lots of other running programs
> as well.  What I got, was ever-rolling OOM messages
> with stack traces inbetween.
> 2.6.18-rc4-mm1 never recovered and had to be killed by sysrq.
>
> Helge Hafting

Script started on Wed 16 Aug 2006 07:18:48 AM EDT
LINUX> gcc -o xxx xxx.c
LINUX> ./xxx
6138
Terminated
LINUX> ./xxx
6138
Terminated
LINUX> ./xxx
6138
Terminated
LINUX> ulimit
unlimited
LINUX> uname -r
2.6.16.24
LINUX> cat /proc/meminfo
MemTotal:       774572 kB
MemFree:        381984 kB
Buffers:        154120 kB
Cached:          31000 kB
SwapCached:          0 kB
Active:          74908 kB
Inactive:       130816 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       774572 kB
LowFree:        381984 kB
SwapTotal:      907664 kB
SwapFree:       907660 kB
Dirty:              28 kB
Writeback:           0 kB
Mapped:          34100 kB
Slab:           177948 kB
CommitLimit:   1294948 kB
Committed_AS:    31080 kB
PageTables:        804 kB
VmallocTotal:   515796 kB
VmallocUsed:      3524 kB
VmallocChunk:   511568 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     4096 kB
LINUX> exit
Script done on Wed 16 Aug 2006 07:19:48 AM EDT

Runs fine here. I'm using 2.6.14.24. Maybe your kernel version still
has an OEM bug???

Since the forked process never touches any of its memory, it
shouldn't use anything except space in the kernel for a new task-
structure and space in user-space for stack. COW wouldn't have
happened yet. I don't see how you get out of memory before you
run out of PIDs!

The first instance of the fork failing should cause a signal
to be sent to all the children, killing them:

         case -1:	// Failed
         printf("%lu\n", i);
             kill(0, SIGTERM);
             exit(0);


I can set /proc/sys/vm/overcommit_memory to either 1 or 0 with
the same effect, no out-of-memory errors. Maybe your kernel
version has a bug?



Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.62 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
