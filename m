Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261637AbULIV4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbULIV4p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 16:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261636AbULIV4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 16:56:45 -0500
Received: from mail00hq.adic.com ([63.81.117.10]:25961 "EHLO mail00hq.adic.com")
	by vger.kernel.org with ESMTP id S261646AbULIVzx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 16:55:53 -0500
Message-ID: <41B8C8F0.8000705@xfs.org>
Date: Thu, 09 Dec 2004 15:51:44 -0600
From: Steve Lord <lord@xfs.org>
User-Agent: Mozilla Thunderbird 1.0RC1 (X11/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: negative dentry_stat.nr_unused causes aggressive dcache pruning
References: <41B77D54.4080909@xfs.org>	<20041209020919.6f17e322.akpm@osdl.org>	<41B8BB96.4040006@xfs.org> <20041209131949.7862f0c8.akpm@osdl.org>
In-Reply-To: <20041209131949.7862f0c8.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Dec 2004 21:55:46.0284 (UTC) FILETIME=[D64932C0:01C4DE39]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Steve Lord <lord@xfs.org> wrote:

>>
>>I still do not know exactly how the count gets negative, but I tracked it
>>down to a user space app from emulex called HBAanywhere. The only thing I
>>can see this doing which might be related is attempting to open a lot of
>>non-existant /proc entries:
>>
>>	/proc/scsi//120
>>	/proc/scsi//121
>>	etc...
>>
>>Yes there is a // in there.
>>
>>I ran with a BUG call if we manipulate nr_unused without the dcache lock
>>and it never tripped. All very wierd.
>>
> 
> 
> Is that 2.4 or 2.6?
> 
> I'd be expecting a systematic counting bug.  After all, nr_unused would
> normally be in the thousands and it'd take a lot of races to get that down
> to zero.
> 

  2.4.20-31.9 (aka Yea Olde Kernel), it is a redhat 9.0 update from the
  fedora legacy project.

Something is pushing down hard on the dcache, I can watch the numbers
drop after boot up. They start out a few hundred but within a few
minutes they go negative.

I have a fiber channel driver from out the tree loaded (emulex lpfcdd)
but it does not appear to mess with dcache entries itself. Nothing else
from outside the tree. I have not had a chance to try 2.6 yet, not
even sure this code would run on 2.6.

I don't have the source of this app, so all I can do is strace it and
watch that. Actually I don't even need the app, so I can make the problem
go away, but it seems very odd that a user space program can do this.

If I start up the program and watch /proc/sys/fs/dentry-state every second
or so I see a sequence something like this:
slord@k4> cat /proc/sys/fs/dentry-state
368     22      45      0       0       0
slord@k4> cat /proc/sys/fs/dentry-state
364     18      45      0       0       0
slord@k4> cat /proc/sys/fs/dentry-state
363     16      45      0       0       0
slord@k4> cat /proc/sys/fs/dentry-state
361     14      45      0       0       0
slord@k4> cat /proc/sys/fs/dentry-state
361     14      45      0       0       0
slord@k4> cat /proc/sys/fs/dentry-state
359     13      45      0       0       0
slord@k4> cat /proc/sys/fs/dentry-state
359     13      45      0       0       0
slord@k4> cat /proc/sys/fs/dentry-state
359     13      45      0       0       0
slord@k4> cat /proc/sys/fs/dentry-state
359     13      45      0       0       0
slord@k4> cat /proc/sys/fs/dentry-state
348     5       45      0       0       0
slord@k4> cat /proc/sys/fs/dentry-state
332     -16     45      0       0       0
slord@k4> cat /proc/sys/fs/dentry-state
332     -16     45      0       0       0
slord@k4> cat /proc/sys/fs/dentry-state
332     -16     45      0       0       0
slord@k4> cat /proc/sys/fs/dentry-state
332     -16     45      0       0       0
slord@k4> cat /proc/sys/fs/dentry-state
332     -16     45      0       0       0

Its not like I am low on memory though:
slord@k4> free
              total       used       free     shared    buffers     cached
Mem:       1030108     244932     785176          0      15012     147808
-/+ buffers/cache:      82112     947996
Swap:      1574360         76    1574284

All I can see the program doing is attempting to open these non-existent
/proc entries and doing an ioctl FIBMAP on a /dev/ device bound to the fiber
channel driver. Of course, FIBMAP is not FIBMAP in this driver.

It looks like a steaming pile in there, and I think I am just going to
assume the driver is guilty until proven innocent.


Steve


