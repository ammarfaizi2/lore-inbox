Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964976AbWGKATE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbWGKATE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 20:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWGKATE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 20:19:04 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:27105 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751333AbWGKATB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 20:19:01 -0400
Date: Tue, 11 Jul 2006 10:18:17 +1000
From: Nathan Scott <nathans@sgi.com>
To: Stephane Doyon <sdoyon@max-t.com>
Cc: Christoph Hellwig <hch@infradead.org>, Suzuki <suzuki@in.ibm.com>,
       linux-fsdevel@vger.kernel.org,
       "linux-aio kvack.org" <linux-aio@kvack.org>,
       lkml <linux-kernel@vger.kernel.org>, suparna <suparna@in.ibm.com>,
       akpm@osdl.org, xfs@oss.sgi.com
Subject: Re: [RFC] Badness in __mutex_unlock_slowpath with XFS stress tests
Message-ID: <20060711101817.B1702118@wobbly.melbourne.sgi.com>
References: <440FDF3E.8060400@in.ibm.com> <20060309120306.GA26682@infradead.org> <20060309223042.GC1135@frodo> <20060309224219.GA6709@infradead.org> <20060309231422.GD1135@frodo> <20060310005020.GF1135@frodo> <Pine.LNX.4.64.0607101152040.3709@madrid.max-t.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.64.0607101152040.3709@madrid.max-t.internal>; from sdoyon@max-t.com on Mon, Jul 10, 2006 at 12:46:23PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2006 at 12:46:23PM -0400, Stephane Doyon wrote:
> Hi,

Hi Stephane,

> A few months back, a fix was introduced for a mutex double unlock warning 
> related to direct I/O in XFS. I believe that fix has a lock ordering 
> problem that can cause a deadlock.
> 
> The problem was that __blockdev_direct_IO() would unlock the i_mutex in 
> the READ and DIO_OWN_LOCKING case, and the mutex would be unlocked again 
> in xfs_read() soon after returning from __generic_file_aio_read(). Because 
> there are lots of execution paths down from __generic_file_aio_read() that 
> do not consistently release the i_mutex, the safest fix was deemed to be 
> to reacquire the i_mutex before returning from __blockdev_direct_IO(). At 
> this point however, the reader is holding an xfs ilock, and AFAICT the 
> i_mutex is usually taken BEFORE the xfs ilock.

That is correct, yes.  Hmm.  Subtle.  Painful.  Thanks for the detailed
report and your analysis.

> We are seeing a deadlock between a process writing and another process 
> reading the same file, when the reader is using direct I/O. (The writer 

Is that a direct writer or a buffered writer?

> must apparently be growing the file, using either direct or buffered 
> I/O.) Something like this, on XFS:
> (dd if=/dev/zero of=f bs=128K count=5000 & ) ; sleep 1 ; dd of=/dev/null 
> if=f iflag=direct bs=128K count=5000
> 
> Seen on kernels 2.6.16 and 2.6.17.
> 
> The deadlock scenario appears to be this:
> -The reader goes into xfs_read(), takes the i_mutex and then an xfs_ilock
> XFS_IOLOCK_SHARED, then calls down to __generic_file_aio_read() which
> eventually goes down to __blockdev_direct_IO(). In there it drops the 
> i_mutex.
> -The writer goes into xfs_write() and obtains the i_mutex. It then tries
> to get an xfs_ilock XFS_ILOCK_EXCL and must wait on it since it's held by 
> the reader.
> -The reader, still in __blockdev_direct_IO(), executes directio_worker() 
> and then tries to reacquire the i_mutex, and must wait on it because the 
> writer has it.
> 
> And so we have a deadlock.

*nod*.  This will require some thought, I'm not sure I like the sound of
your suggested workaround there a whole lot, unfortunately, but maybe it
is all we can do at this stage.  Let me ponder further and get back to you
(but if you want to prototype your fix further, that'd be most welcome, of
course).

cheers.

--
Nathan
