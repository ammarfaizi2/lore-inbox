Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751948AbWCIW0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948AbWCIW0V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 17:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751949AbWCIW0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 17:26:21 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:2225 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751948AbWCIW0V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 17:26:21 -0500
Date: Fri, 10 Mar 2006 09:22:32 +1100
From: Nathan Scott <nathans@sgi.com>
To: Suzuki <suzuki@in.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, suparna <suparna@in.ibm.com>,
       akpm@osdl.org, linux-xfs@oss.sgi.com
Subject: Re: [RFC] Badness in __mutex_unlock_slowpath with XFS stress tests
Message-ID: <20060309222232.GB1135@frodo>
References: <440FD66D.6060308@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <440FD66D.6060308@in.ibm.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 12:47:01PM +0530, Suzuki wrote:
> Hi all,

Hi there Suzuki,

> I was working on an issue with getting "Badness in
> __mutex_unlock_slowpath" and hence a stack trace, while running FS
> stress tests on XFS on 2.6.16-rc5 kernel.

Thanks for looking into this.

> The dmesg looks like :
> 
> Badness in __mutex_unlock_slowpath at kernel/mutex.c:207
>  [<c0103c0c>] show_trace+0x20/0x22
>  [<c0103d4b>] dump_stack+0x1e/0x20
>  [<c0473f1f>] __mutex_unlock_slowpath+0x12a/0x23b
>  [<c0473938>] mutex_unlock+0xb/0xd
>  [<c02a5720>] xfs_read+0x230/0x2d9
>  [<c02a1bed>] linvfs_aio_read+0x8d/0x98
>  [<c015f3df>] do_sync_read+0xb8/0x107
>  [<c015f4f7>] vfs_read+0xc9/0x19b
>  [<c015f8b2>] sys_read+0x47/0x6e
>  [<c0102db7>] sysenter_past_esp+0x54/0x75

Yeah, test 008 from the xfstests suite was reliably hitting this for
me, it'd just not percolated to the top of my todo list yet.

> This happens with XFS DIO reads. xfs_read holds the i_mutex and issues a
> __generic_file_aio_read(), which falls into __blockdev_direct_IO with
> DIO_OWN_LOCKING flag (since xfs uses own_locking ). Now
> __blockdev_direct_IO releases the i_mutex for READs with
> DIO_OWN_LOCKING.When it returns to xfs_read, it tries to unlock the
> i_mutex ( which is now already unlocked), causing the "Badness".

Indeed.  And there's the problem - why is XFS releasing i_mutex
for the direct read in xfs_read?  Shouldn't be - fs/direct-io.c
will always release i_mutex for a direct read in the own-locking
case, so XFS shouldn't be doing it too (thats what the code does
and thats what the comment preceding __blockdev_direct_IO says).

The only piece of the puzzle I don't understand is why we don't
always get that badness message at the end of every direct read.
Perhaps its some subtle fastpath/slowpath difference, or maybe
"debug_mutex_on" gets switched off after the first occurance...

Anyway, with the above change (remove 2 lines near xfs_read end),
I can no longer reproduce the problem in that previously-warning
test case, and all the other XFS tests seem to be chugging along
OK (which includes a healthy mix of dio testing).

> The possible solution which we can think of, is not to unlock the
> i_mutex for DIO_OWN_LOCKING. This will only affect the DIO_OWN_LOCKING 
> users (as of now, only XFS ) with concurrent DIO sync read requests. AIO 
> read requests would not suffer this problem since they would just return 
> once the DIO is submitted.

I don't think that level of invasiveness is necessary at this stage,
but perhaps you're seeing something that I've missed?  Do you see
any reason why removing the xfs_read unlock wont work?

> Another work around for this can  be adding a check "mutex_is_locked"
> before trying to unlock i_mutex in xfs_read. But this seems to be an
> ugly hack. :(

Hmm, that just plain wouldn't work - what if the lock was released
in generic direct IO code, and someone else had acquired it before
we got to the end of xfs_read?  Badness for sure.

cheers.

-- 
Nathan
