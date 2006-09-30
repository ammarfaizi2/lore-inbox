Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbWI3RbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbWI3RbK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 13:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbWI3RbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 13:31:10 -0400
Received: from mga03.intel.com ([143.182.124.21]:21640 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1751283AbWI3RbI convert rfc822-to-8bit
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 13:31:08 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,240,1157353200"; 
   d="scan'208"; a="125253466:sNHT25090009"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Postal 56% waits for flock_lock_file_wait
Date: Sat, 30 Sep 2006 21:26:40 +0400
Message-ID: <B41635854730A14CA71C92B36EC22AAC3AD92D@mssmsx411>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Postal 56% waits for flock_lock_file_wait
Thread-Index: Acbkof3Lqy94qeO2QhKIq8bZeBW9DQAEGifw
From: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
To: "Trond Myklebust" <trond.myklebust@fys.uio.no>
Cc: "Linux Kernel Mailing List" <Linux-Kernel@vger.kernel.org>
X-OriginalArrivalTime: 30 Sep 2006 17:30:44.0438 (UTC) FILETIME=[28AF0F60:01C6E4B6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On which filesystem were the above results obtained if it was not
ext2?
The default ext3 fs was used.

> All the above results are telling you is that your test involves
several
> processes contending for the same lock, and so all of them barring the
> one process that actually holds the lock are idle.

Yes. It is  flock_lock_file_wait.

Leonid
-----Original Message-----
From: Trond Myklebust [mailto:trond.myklebust@fys.uio.no] 
Sent: Saturday, September 30, 2006 7:06 PM
To: Ananiev, Leonid I
Cc: Linux Kernel Mailing List
Subject: Re: Postal 56% waits for flock_lock_file_wait

On Sat, 2006-09-30 at 09:25 +0400, Ananiev, Leonid I wrote:
> A benchmark
>              'postal -p 16 localhost list_of_1000_users'
> 56% of run time waits for flock_lock_file_wait;
> Vmstat reports that 66% cpu is idle and  vmstat bi+bo=3600 (far from
> max).
> Postfix server with FD_SETSIZE=2048 was used.
> Similar results got for sendmail. 
> Wchan is counted by
>             while :; do
>                         ps -o user,wchan=WIDE-WCHAN-COLUMN,comm;
> sleep 1;
>            done | awk '/ postfix /{a[$2]++}END{for (i in a) print
> a[i]"\t"i}'
> If ext2 fs is used the Postal throughput is twice more and bi+bo by
50%
> less while  flock_lock_file_wait 60% still.

On which filesystem were the above results obtained if it was not ext2?

> Is flock_lock_file_wait considered as a performance limiting waiting
for
> similar applications in smp?

All the above results are telling you is that your test involves several
processes contending for the same lock, and so all of them barring the
one process that actually holds the lock are idle.

As for the throughput issue, that really depends on the filesystem you
are measuring. For remote filesystems like NFS, locks can _really_ slow
down performance because they are often required to flush all dirty data
to disk prior to releasing the lock (so that it becomes visible to
processes on other clients that might subsequently obtain the lock).

Cheers,
  Trond
