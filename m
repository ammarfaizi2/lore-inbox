Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266838AbUHJDU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266838AbUHJDU0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 23:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267415AbUHJDU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 23:20:26 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:34020 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S266838AbUHJDUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 23:20:22 -0400
Message-ID: <41183EFA.5090600@comcast.net>
Date: Mon, 09 Aug 2004 23:20:26 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Locking scheme to block less
References: <Pine.LNX.4.44.0408092133390.25913-100000@dhcp83-102.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0408092133390.25913-100000@dhcp83-102.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Rik van Riel wrote:
> On Mon, 9 Aug 2004, John Richard Moser wrote:
> 
> 
>>Currently, the kernel uses only spin_locks,
> 
> 
> Oh ?   Haven't you seen the read/write locks in
> include/linux/spinlock.h or the lockless synchronisation
> provided by include/linux/rcu.h ?
> 

No, last I looked was in 2.4, and it was a passing glance long ago.

> 
>>If the kernel provided a read-write locking semaphore,
> 
> 
> Funny, it does.  You're not looking at a 2.0 kernel, are
> you?
> 
> 
>>spin_read_to_write_lock(spin_rwlock_t *lock);
>

[Reinsert->]
This is a read lock that will become a write lock.  It allows other read 
locks; but blocks write locks and other read_to_write locks.  It is 
blocked by write locks [and other read_to_write locks](sorry).
> 
>>A read_to_write lock will block two such operations from occuring 
>>concurrently, while still allowing read only operations AND still being 
>>blocked when switched to write mode by both read and write operations.
> 
> 
> In fact, two threads trying to upgrade their read lock to a
> write lock simultaneously will block EACH OTHER, FOREVER.
> 

What no, read that.  It blocks write locks and other read_to_write 
locks.  It should have the above ammendment that it blocks other 
read_to_write locks from beginning, although it is mentioned that this 
DOES block its own kind.  I guess I need to repete myself sometimes.

The point is to prevent operations that find an index on a linked list 
to insert/remove at from altering while something could be reading. 
Concurrent read locks can both find nearby indicies, then race for a 
write lock, leaving the first to clobber the second.

With this type of semaphore (am I using this word correctly?), any 
number of readlocks can exist concurrently with exactly one 
read_write_lock, but will block that read_write_lock from transforming 
to write mode.  Similarly, only one read_write_lock can actually be 
unblocked at any one time, to prevent these races.

> Sounds like an exceedingly bad idea to me ;)
> 

I've seen bad things.

-- 
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

