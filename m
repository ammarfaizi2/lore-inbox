Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267364AbUHJAib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267364AbUHJAib (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 20:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267366AbUHJAib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 20:38:31 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:29155 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S267364AbUHJAi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 20:38:28 -0400
Message-ID: <41181909.3070702@comcast.net>
Date: Mon, 09 Aug 2004 20:38:33 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Locking scheme to block less
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the kernel uses only spin_locks, which are similar to mutex 
locks; locks constrict operations to being mutually exclusive.  There 
are many cases where a set of three or more operations has two or more 
which can occur concurrently, and one or more which cannot occur 
concurrently with other operations.  These are normally handled with 
read-write locks.

If the kernel provided a read-write locking semaphore, the time spent 
blocking could be greatly reduced in a safe and effective manner.  To 
maximize efficiency, the following functions would be needed:

spin_read_lock(spin_rwlock_t *lock);
Read lock a spin_rwlock_t.  Multiple concurrent read locks can be 
held, and will block write locks.  A write lock blocks read locks.

spin_write_lock(spin_rwlock_t *lock);
Write lock a spin_rwlock_t.  Only one write lock can be held at any one 
time, and no read lock may be held during write locks.  Held read locks 
block write locks; held write locks block read locks.

spin_read_to_write_lock(spin_rwlock_t *lock);
This is a read lock that will become a write lock.  It allows other read 
locks; but blocks write locks and other read_to_write locks.  It is 
blocked by write locks.

In the course of kernel execution, some functions will wish to read 
through a linked list, find a point to insert or remove data, and then 
perform the operation.  Two such operations will race for a write lock 
when they find the point in the list they wish to alter.  If the points 
are significantly close-- for example, insertion after an index to be 
deleted, or both inserting after a given index-- then a race condition 
occurs, creating an inconsistent internal state and a possible reference 
to freed memory.

A read_to_write lock will block two such operations from occuring 
concurrently, while still allowing read only operations AND still being 
blocked when switched to write mode by both read and write operations.

spin_r2w_write(spin_rwlock_t *lock);
Exchange currently held read_to_write lock for a write lock.  Same rules 
as a write lock apply; this operation is blocked by read locks and 
blocks all locks.

spin_rw_unlock(spin_rwlock_t *lock);
Unlocks a held spin_rwlockt_lock.

I believe that these locking semaphores would be generically useful in
reducing the time spent blocking in the kernel.

Notice that these are similar to pthreads rwlocks; except that there is 
a read_to_write lock specified.  This is not userspace, this is a 
kernel; nobody cares about standards internally, but everyone hates races.

-- 
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

