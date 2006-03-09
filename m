Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751418AbWCIHLW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbWCIHLW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 02:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751771AbWCIHLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 02:11:22 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:44679 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751418AbWCIHLW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 02:11:22 -0500
Message-ID: <440FD66D.6060308@in.ibm.com>
Date: Thu, 09 Mar 2006 12:47:01 +0530
From: Suzuki <suzuki@in.ibm.com>
Organization: IBM Software Labs
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: suparna <suparna@in.ibm.com>, akpm@osdl.org
Subject: [RFC] Badness in __mutex_unlock_slowpath with XFS stress tests
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,


I was working on an issue with getting "Badness in
__mutex_unlock_slowpath" and hence a stack trace, while running FS
stress tests on XFS on 2.6.16-rc5 kernel.

The dmesg looks like :

Badness in __mutex_unlock_slowpath at kernel/mutex.c:207
  [<c0103c0c>] show_trace+0x20/0x22
  [<c0103d4b>] dump_stack+0x1e/0x20
  [<c0473f1f>] __mutex_unlock_slowpath+0x12a/0x23b
  [<c0473938>] mutex_unlock+0xb/0xd
  [<c02a5720>] xfs_read+0x230/0x2d9
  [<c02a1bed>] linvfs_aio_read+0x8d/0x98
  [<c015f3df>] do_sync_read+0xb8/0x107
  [<c015f4f7>] vfs_read+0xc9/0x19b
  [<c015f8b2>] sys_read+0x47/0x6e
  [<c0102db7>] sysenter_past_esp+0x54/0x75


This happens with XFS DIO reads. xfs_read holds the i_mutex and issues a
__generic_file_aio_read(), which falls into __blockdev_direct_IO with
DIO_OWN_LOCKING flag (since xfs uses own_locking ). Now
__blockdev_direct_IO releases the i_mutex for READs with
DIO_OWN_LOCKING.When it returns to xfs_read, it tries to unlock the
i_mutex ( which is now already unlocked), causing the "Badness".

The possible solution which we can think of, is not to unlock the
i_mutex for DIO_OWN_LOCKING. This will only affect the DIO_OWN_LOCKING 
users (as of now, only XFS ) with concurrent DIO sync read requests. AIO 
read requests would not suffer this problem since they would just return 
once the DIO is submitted.

Another work around for this can  be adding a check "mutex_is_locked"
before trying to unlock i_mutex in xfs_read. But this seems to be an
ugly hack. :(

Comments ?


thanks,

Suzuki

