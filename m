Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbWGKNnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWGKNnF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 09:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbWGKNnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 09:43:04 -0400
Received: from h216-18-124-229.gtcust.grouptelecom.net ([216.18.124.229]:16774
	"EHLO mail.max-t.com") by vger.kernel.org with ESMTP
	id S1750764AbWGKNnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 09:43:01 -0400
Date: Tue, 11 Jul 2006 09:40:49 -0400 (EDT)
From: Stephane Doyon <sdoyon@max-t.com>
X-X-Sender: sdoyon@madrid.max-t.internal
To: Nathan Scott <nathans@sgi.com>
cc: Christoph Hellwig <hch@infradead.org>, Suzuki <suzuki@in.ibm.com>,
       linux-fsdevel@vger.kernel.org,
       "linux-aio kvack.org" <linux-aio@kvack.org>,
       lkml <linux-kernel@vger.kernel.org>, suparna <suparna@in.ibm.com>,
       akpm@osdl.org, xfs@oss.sgi.com
In-Reply-To: <20060711101817.B1702118@wobbly.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.64.0607110928010.3327@madrid.max-t.internal>
References: <440FDF3E.8060400@in.ibm.com> <20060309120306.GA26682@infradead.org>
 <20060309223042.GC1135@frodo> <20060309224219.GA6709@infradead.org>
 <20060309231422.GD1135@frodo> <20060310005020.GF1135@frodo>
 <Pine.LNX.4.64.0607101152040.3709@madrid.max-t.internal>
 <20060711101817.B1702118@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 192.168.1.189
X-SA-Exim-Mail-From: sdoyon@max-t.com
Subject: Re: [RFC] Badness in __mutex_unlock_slowpath with XFS stress tests
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-SA-Exim-Version: 4.1 (built Thu, 08 Sep 2005 14:17:48 -0500)
X-SA-Exim-Scanned: Yes (on mail.max-t.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2006, Nathan Scott wrote:

> On Mon, Jul 10, 2006 at 12:46:23PM -0400, Stephane Doyon wrote:
>> Hi,
>
> Hi Stephane,
>
>> A few months back, a fix was introduced for a mutex double unlock warning
>> related to direct I/O in XFS. I believe that fix has a lock ordering
>> problem that can cause a deadlock.
>>
>> The problem was that __blockdev_direct_IO() would unlock the i_mutex in
>> the READ and DIO_OWN_LOCKING case, and the mutex would be unlocked again
>> in xfs_read() soon after returning from __generic_file_aio_read(). Because
>> there are lots of execution paths down from __generic_file_aio_read() that
>> do not consistently release the i_mutex, the safest fix was deemed to be
>> to reacquire the i_mutex before returning from __blockdev_direct_IO(). At
>> this point however, the reader is holding an xfs ilock, and AFAICT the
>> i_mutex is usually taken BEFORE the xfs ilock.
>
> That is correct, yes.  Hmm.  Subtle.  Painful.  Thanks for the detailed
> report and your analysis.
>
>> We are seeing a deadlock between a process writing and another process
>> reading the same file, when the reader is using direct I/O. (The writer
>
> Is that a direct writer or a buffered writer?

Whichever, both cases trigger the deadlock.

>> must apparently be growing the file, using either direct or buffered
>> I/O.) Something like this, on XFS:
>> (dd if=/dev/zero of=f bs=128K count=5000 & ) ; sleep 1 ; dd of=/dev/null
>> if=f iflag=direct bs=128K count=5000
>>
>> Seen on kernels 2.6.16 and 2.6.17.
>>
>> The deadlock scenario appears to be this:
>> -The reader goes into xfs_read(), takes the i_mutex and then an xfs_ilock
>> XFS_IOLOCK_SHARED, then calls down to __generic_file_aio_read() which
>> eventually goes down to __blockdev_direct_IO(). In there it drops the
>> i_mutex.
>> -The writer goes into xfs_write() and obtains the i_mutex. It then tries
>> to get an xfs_ilock XFS_ILOCK_EXCL and must wait on it since it's held by
>> the reader.
>> -The reader, still in __blockdev_direct_IO(), executes directio_worker()
>> and then tries to reacquire the i_mutex, and must wait on it because the
>> writer has it.
>>
>> And so we have a deadlock.
>
> *nod*.  This will require some thought, I'm not sure I like the sound of
> your suggested workaround there a whole lot, unfortunately, but maybe it
> is all we can do at this stage.  Let me ponder further and get back to you

Thank you.

> (but if you want to prototype your fix further, that'd be most welcome, of
> course).

Sure, well it's not very subtle. The below patch is what I'm using for 
now. I haven't seen problems with it yet but it hasn't been seriously 
tested.

I'm assuming that it's OK to keep holding the i_mutex during the call to 
direct_io_worker(), because in the DIO_LOCKING case, direct_io_worker() 
is called with the i_mutex held, and XFS touches i_mutex only in 
xfs_read() and xfs_write(), so opefully nothing will conflict.

Signed-off-by: Stephane Doyon <sdoyon@max-t.com>
--- linux/fs/direct-io.c.orig	2006-07-11 09:23:20.000000000 -0400
+++ linux/fs/direct-io.c	2006-07-11 09:27:54.000000000 -0400
@@ -1191,7 +1191,6 @@ __blockdev_direct_IO(int rw, struct kioc
  	loff_t end = offset;
  	struct dio *dio;
  	int release_i_mutex = 0;
-	int acquire_i_mutex = 0;

  	if (rw & WRITE)
  		current->flags |= PF_SYNCWRITE;
@@ -1254,11 +1253,6 @@ __blockdev_direct_IO(int rw, struct kioc
  				goto out;
  			}

-			if (dio_lock_type == DIO_OWN_LOCKING) {
-				mutex_unlock(&inode->i_mutex);
-				acquire_i_mutex = 1;
-			}
-		}

  		if (dio_lock_type == DIO_LOCKING)
  			down_read(&inode->i_alloc_sem);
@@ -1282,8 +1276,6 @@ __blockdev_direct_IO(int rw, struct kioc
  out:
  	if (release_i_mutex)
  		mutex_unlock(&inode->i_mutex);
-	else if (acquire_i_mutex)
-		mutex_lock(&inode->i_mutex);
  	if (rw & WRITE)
  		current->flags &= ~PF_SYNCWRITE;
  	return retval;
