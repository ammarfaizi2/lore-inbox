Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265348AbSJXIS2>; Thu, 24 Oct 2002 04:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265349AbSJXIS1>; Thu, 24 Oct 2002 04:18:27 -0400
Received: from 12-234-207-200.client.attbi.com ([12.234.207.200]:46720 "EHLO
	chrisl-um.vmware.com") by vger.kernel.org with ESMTP
	id <S265348AbSJXISY>; Thu, 24 Oct 2002 04:18:24 -0400
Date: Thu, 24 Oct 2002 01:25:05 -0700
From: chrisl@vmware.com
To: Andrew Morton <akpm@digeo.com>, andrea@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: writepage return value check in vmscan.c
Message-ID: <20021024082505.GB1471@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

It might be a silly question.

Is it a bug in vmscan.c that it do not check the return
value of writepage when shrinking the cache?

Some background of the problem:

I was tracing some heavy swapping problem relate to high memory usage
when running many virtual machines in VMware GSX server some time ago.
If the total ram size of different virtual machine add up to some level,
bigger than 2G on a 4Gmachine.Kernel will keep swapping and no response.

VMware open a tmp ram file for each virtual machine and mmap on that file
to share memory between different process.

I soon find out the hidden size limit on shmfs even though the ram file
is open on a ext2/ext3 file system. If I change the ram file open on
/dev/shm then the problem seems to go away. I guess that is because /tmp
directory is full but bigger /tmp did not help. that is another issue
though.

I try to find out what happen if user memory map a sparse file then
kernel try to write it back to disk and hit a no disk space error.
To my surprise, it seems to me that both 2.4 and 2.5 kernel do not
check the return value of "writepage". If there is an error like ENOSPC
it will just drop it on the ground? Do I miss something obvious?

BTW, I am amazed that there is so many way user can abuse the mmap system
call. e.g. open a file, ftruncate to a bigger size, unlink that file while
keep the file descriptor, mmap to some memory using that descriptor,
close that descriptor, you can still use that mmaped memory.

Cheers,

Chris
