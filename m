Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422693AbWGJQsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422693AbWGJQsR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 12:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422692AbWGJQsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 12:48:17 -0400
Received: from h216-18-124-229.gtcust.grouptelecom.net ([216.18.124.229]:25233
	"EHLO mail.max-t.com") by vger.kernel.org with ESMTP
	id S1422635AbWGJQsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 12:48:16 -0400
Date: Mon, 10 Jul 2006 12:46:23 -0400 (EDT)
From: Stephane Doyon <sdoyon@max-t.com>
X-X-Sender: sdoyon@madrid.max-t.internal
To: Christoph Hellwig <hch@infradead.org>, Nathan Scott <nathans@sgi.com>
cc: Suzuki <suzuki@in.ibm.com>, linux-fsdevel@vger.kernel.org,
       "linux-aio kvack.org" <linux-aio@kvack.org>,
       lkml <linux-kernel@vger.kernel.org>, suparna <suparna@in.ibm.com>,
       akpm@osdl.org, linux-xfs@oss.sgi.com
In-Reply-To: <20060310005020.GF1135@frodo>
Message-ID: <Pine.LNX.4.64.0607101152040.3709@madrid.max-t.internal>
References: <440FDF3E.8060400@in.ibm.com> <20060309120306.GA26682@infradead.org>
 <20060309223042.GC1135@frodo> <20060309224219.GA6709@infradead.org>
 <20060309231422.GD1135@frodo> <20060310005020.GF1135@frodo>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 192.168.1.189
X-SA-Exim-Mail-From: sdoyon@max-t.com
Subject: Re: [RFC] Badness in __mutex_unlock_slowpath with XFS stress tests
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-SA-Exim-Version: 4.1 (built Thu, 08 Sep 2005 14:17:48 -0500)
X-SA-Exim-Scanned: Yes (on mail.max-t.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A few months back, a fix was introduced for a mutex double unlock warning 
related to direct I/O in XFS. I believe that fix has a lock ordering 
problem that can cause a deadlock.

The problem was that __blockdev_direct_IO() would unlock the i_mutex in 
the READ and DIO_OWN_LOCKING case, and the mutex would be unlocked again 
in xfs_read() soon after returning from __generic_file_aio_read(). Because 
there are lots of execution paths down from __generic_file_aio_read() that 
do not consistently release the i_mutex, the safest fix was deemed to be 
to reacquire the i_mutex before returning from __blockdev_direct_IO(). At 
this point however, the reader is holding an xfs ilock, and AFAICT the 
i_mutex is usually taken BEFORE the xfs ilock.

We are seeing a deadlock between a process writing and another process 
reading the same file, when the reader is using direct I/O. (The writer 
must apparently be growing the file, using either direct or buffered 
I/O.) Something like this, on XFS:
(dd if=/dev/zero of=f bs=128K count=5000 & ) ; sleep 1 ; dd of=/dev/null 
if=f iflag=direct bs=128K count=5000

Seen on kernels 2.6.16 and 2.6.17.

The deadlock scenario appears to be this:
-The reader goes into xfs_read(), takes the i_mutex and then an xfs_ilock
XFS_IOLOCK_SHARED, then calls down to __generic_file_aio_read() which
eventually goes down to __blockdev_direct_IO(). In there it drops the 
i_mutex.
-The writer goes into xfs_write() and obtains the i_mutex. It then tries
to get an xfs_ilock XFS_ILOCK_EXCL and must wait on it since it's held by 
the reader.
-The reader, still in __blockdev_direct_IO(), executes directio_worker() 
and then tries to reacquire the i_mutex, and must wait on it because the 
writer has it.

And so we have a deadlock.

I leave it to the experts to figure out what the right fix for this might 
be. A workaround might be to not release the i_mutex during 
__blockdev_direct_IO().

Thanks

On Thu, 9 Mar 2006, Christoph Hellwig wrote:

> On Thu, Mar 09, 2006 at 01:24:38PM +0530, Suzuki wrote:
>>
>> Missed out linux-aio & linux-fs-devel lists. Forwarding.
>>
>> Comments ?
>
> I've seen this too.  The problem is that __generic_file_aio_read can return
> with or without the i_mutex locked in the direct I/O case for filesystems
> that set DIO_OWN_LOCKING.  It's a nasty one and I haven't found a better solution
> than copying lots of code from filemap.c into xfs.
>
>
>

On Fri, 10 Mar 2006, Nathan Scott wrote:

> On Thu, Mar 09, 2006 at 12:47:01PM +0530, Suzuki wrote:
>> Hi all,
>
> Hi there Suzuki,
>
>> I was working on an issue with getting "Badness in
>> __mutex_unlock_slowpath" and hence a stack trace, while running FS
>> stress tests on XFS on 2.6.16-rc5 kernel.
>
> Thanks for looking into this.
>
>> The dmesg looks like :
>>
>> Badness in __mutex_unlock_slowpath at kernel/mutex.c:207
>>  [<c0103c0c>] show_trace+0x20/0x22
>>  [<c0103d4b>] dump_stack+0x1e/0x20
>>  [<c0473f1f>] __mutex_unlock_slowpath+0x12a/0x23b
>>  [<c0473938>] mutex_unlock+0xb/0xd
>>  [<c02a5720>] xfs_read+0x230/0x2d9
>>  [<c02a1bed>] linvfs_aio_read+0x8d/0x98
>>  [<c015f3df>] do_sync_read+0xb8/0x107
>>  [<c015f4f7>] vfs_read+0xc9/0x19b
>>  [<c015f8b2>] sys_read+0x47/0x6e
>>  [<c0102db7>] sysenter_past_esp+0x54/0x75
>
> Yeah, test 008 from the xfstests suite was reliably hitting this for
> me, it'd just not percolated to the top of my todo list yet.
>
>> This happens with XFS DIO reads. xfs_read holds the i_mutex and issues a
>> __generic_file_aio_read(), which falls into __blockdev_direct_IO with
>> DIO_OWN_LOCKING flag (since xfs uses own_locking ). Now
>> __blockdev_direct_IO releases the i_mutex for READs with
>> DIO_OWN_LOCKING.When it returns to xfs_read, it tries to unlock the
>> i_mutex ( which is now already unlocked), causing the "Badness".
>
> Indeed.  And there's the problem - why is XFS releasing i_mutex
> for the direct read in xfs_read?  Shouldn't be - fs/direct-io.c
> will always release i_mutex for a direct read in the own-locking
> case, so XFS shouldn't be doing it too (thats what the code does
> and thats what the comment preceding __blockdev_direct_IO says).
>
> The only piece of the puzzle I don't understand is why we don't
> always get that badness message at the end of every direct read.
> Perhaps its some subtle fastpath/slowpath difference, or maybe
> "debug_mutex_on" gets switched off after the first occurance...
>
> Anyway, with the above change (remove 2 lines near xfs_read end),
> I can no longer reproduce the problem in that previously-warning
> test case, and all the other XFS tests seem to be chugging along
> OK (which includes a healthy mix of dio testing).
>
>> The possible solution which we can think of, is not to unlock the
>> i_mutex for DIO_OWN_LOCKING. This will only affect the DIO_OWN_LOCKING
>> users (as of now, only XFS ) with concurrent DIO sync read requests. AIO
>> read requests would not suffer this problem since they would just return
>> once the DIO is submitted.
>
> I don't think that level of invasiveness is necessary at this stage,
> but perhaps you're seeing something that I've missed?  Do you see
> any reason why removing the xfs_read unlock wont work?
>
>> Another work around for this can  be adding a check "mutex_is_locked"
>> before trying to unlock i_mutex in xfs_read. But this seems to be an
>> ugly hack. :(
>
> Hmm, that just plain wouldn't work - what if the lock was released
> in generic direct IO code, and someone else had acquired it before
> we got to the end of xfs_read?  Badness for sure.
>
> cheers.
>
>

On Fri, 10 Mar 2006, Nathan Scott wrote:

> On Fri, Mar 10, 2006 at 10:14:22AM +1100, Nathan Scott wrote:
>> On Thu, Mar 09, 2006 at 10:42:19PM +0000, Christoph Hellwig wrote:
>>> On Fri, Mar 10, 2006 at 09:30:42AM +1100, Nathan Scott wrote:
>>>> Not for reads AFAICT - __generic_file_aio_read + own-locking
>>>> should always have released i_mutex at the end of the direct
>>>> read - are you thinking of writes or have I missed something?
>>>
>>> if an error occurs before a_ops->direct_IO is called __generic_file_aio_read
>>> will return with i_mutex still locked.  Note that checking for negative
>>> return values is not enough as __blockdev_direct_IO can return errors
>>> aswell.
>>
>> *groan* - right you are.  Another option may be to have the
>> generic dio+own-locking case reacquire i_mutex if it drops
>> it, before returning... thoughts?  Seems alot less invasive
>> than the filemap.c code dup'ing thing.
>
> Something like this (works OK for me)...
>
> cheers.
>
>
