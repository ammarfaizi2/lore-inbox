Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263739AbTIBKwT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 06:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263751AbTIBKwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 06:52:19 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:5287 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S263739AbTIBKwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 06:52:05 -0400
Date: Tue, 02 Sep 2003 19:52:51 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: Re: cache limit
In-reply-to: <20030827113646.GC4306@holomorphy.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
Message-id: <23C371405B0858indou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.04 (WinNT,501)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <20030827113646.GC4306@holomorphy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Aug 2003 04:36:46 -0700, William Lee Irwin III wrote:

>On Wed, 27 Aug 2003 02:45:12 -0700, William Lee Irwin III wrote:
>>> How do you know most of it is unmapped?
>
>On Wed, Aug 27, 2003 at 08:14:12PM +0900, Takao Indoh wrote:
>> I checked /proc/meminfo.
>> For example, this is my /proc/meminfo(kernel 2.5.73)
>[...]
>> Buffers:         18520 kB
>> Cached:         732360 kB
>> SwapCached:          0 kB
>> Active:         623068 kB
>> Inactive:       179552 kB
>[...]
>> Dirty:           33204 kB
>> Writeback:           0 kB
>> Mapped:          73360 kB
>> Slab:            32468 kB
>> Committed_AS:   167396 kB
>[...]
>> According to this information, I thought that
>> all pagecache was 732360 kB and all mapped page was 73360 kB, so
>> almost of pagecache was not mapped...
>> Do I misread meminfo?
>
>No. Most of your pagecache is unmapped pagecache. This would correspond
>to memory that caches files which are not being mmapped by any process.
>This could result from either the page replacement policy favoring
>filesystem cache too heavily or from lots of io causing the filesystem
>cache to be too bloated and so defeating the swapper's heuristics (you
>can do this by generating large amounts of read() traffic).
>
>Limiting unmapped pagecache would resolve your issue. Whether it's the
>right thing to do is still open to question without some knowledge of
>application behavior (for instance, teaching userspace to do fadvise()
>may be right thing to do as opposed to the /proc/ tunable).
>
>Can you gather traces of system calls being made by the applications?
>
>
>-- wli

This is an output of strace -cf.

% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 47.91   57.459696          65    885531           read
 20.27   24.309112          33    727702           write
 17.01   20.405231        1058     19292           vfork
 13.41   16.087846          11   1524468           lseek
  0.32    0.379605          10     38586           close
  0.31    0.368272          19     19290           wait4
  0.27    0.326425          17     19292           pipe
  0.19    0.227052          12     19296           old_mmap
  0.16    0.192420          10     19291           munmap
  0.13    0.158041           8     19302           fstat64
  0.01    0.009983        4992         2           fsync
  0.00    0.001233           6       202           brk
  0.00    0.001029         515         2           unlink
  0.00    0.000173          25         7         1 open
  0.00    0.000128          64         2           chmod
  0.00    0.000092           7        13         6 stat64
  0.00    0.000019          19         1           getcwd
  0.00    0.000016           5         3           access
  0.00    0.000015           4         4           shmat
  0.00    0.000012           3         4           rt_sigaction
  0.00    0.000007           7         1           mprotect
  0.00    0.000002           2         1           getpid
------ ----------- ----------- --------- --------- ----------------
100.00  119.926409               3292292         7 total

According to this information, many I/O increase pagecache and cause
memory shortage.

fadvise may be effective, but fadvise always releases cache
even if there are enough free memory, and may degrade performance.
In the case of /proc tunable,
pagecache is not released until system memory become lack.


On Thu, 28 Aug 2003 01:02:45 +0900, YoshiyaETO wrote:

>> On Wed, 27 Aug 2003 02:45:12 -0700, William Lee Irwin III wrote:
>> >> How do you know it would be effective? Have you written a patch to
>> >> limit it in some way and tried running it?
>>
>> On Wed, Aug 27, 2003 at 08:14:12PM +0900, Takao Indoh wrote:
>> > It's just my guess. You mean that "index cache" is on the pagecache?
>> > "index cache" is allocated in the user space by malloc,
>> > so I think it is not on the pagecache.
>>
>> That will be in the pagecache.
>
>    No. DBMS usually uses DIRECTIO that bypass the pagecache.
>So, "index caches" in the DBMS user space will not be in pagecache.

If so, limiting pagecache seems to be effective for DBMS.

--------------------------------------------------
Takao Indoh
 E-Mail : indou.takao@soft.fujitsu.com
