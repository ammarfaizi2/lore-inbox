Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316136AbSEJVsx>; Fri, 10 May 2002 17:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316135AbSEJVsw>; Fri, 10 May 2002 17:48:52 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:10223 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316136AbSEJVsv>;
	Fri, 10 May 2002 17:48:51 -0400
Message-ID: <3CDC4037.8040104@us.ibm.com>
Date: Fri, 10 May 2002 14:48:39 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020504
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: matthew@wil.cx
CC: linux-kernel@vger.kernel.org
Subject: fs/locks.c BKL removal
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew,
Al Viro pointed me your way.

I'm looking into the fs/locks.c mess.  It appears that there was an 
attempt to convert this over to a semaphore, but it was removed just 
before the 2.4 release because of some deadlocks.

Whenever the i_flock list is traversed, the BKL is held.  It is also 
held while running through the file_lock_list which I think is used 
only for /proc/locks.

We definitely need a semaphore because of all the blocking that goes 
on.  We can either have a global lock for all of them, which I think 
was tried last time.  Or, we can split it up a bit more.  With the 
current design, there will need to be a lock for the global list, each 
individual list, and one for each individual lock to protect against 
access from the reference in the file_lock_list and the inode->i_flock 
list.

However, I think that the file_lock_list complexity may be able to be 
reduced.  If we make the file_lock_list a list of inodes (or just the 
i_flocks) with active locks, we can avoid the complexity of having an 
individual file_lock lock.  That way, we at least reduce the number of 
_types_ of locks.  It increases the number of dereferences, but this 
is /proc we're talking about.  Any comments?

Talking about locks for locks is confusing :)

-- 
Dave Hansen
haveblue@us.ibm.com

