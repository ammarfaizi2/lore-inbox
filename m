Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbVDHWkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbVDHWkc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 18:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbVDHWkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 18:40:21 -0400
Received: from kanga.kvack.org ([66.96.29.28]:58071 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S261155AbVDHWkD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 18:40:03 -0400
Date: Fri, 8 Apr 2005 18:39:27 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Christoph Hellwig <hch@infradead.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       linux-aio@kvack.org
Subject: Re: [RFC] Add support for semaphore-like structure with support for asynchronous I/O
Message-ID: <20050408223927.GA22217@kvack.org>
References: <1112224663.18019.39.camel@lade.trondhjem.org> <1112309586.27458.19.camel@lade.trondhjem.org> <20050331161350.0dc7d376.akpm@osdl.org> <1112318537.11284.10.camel@lade.trondhjem.org> <20050401141225.GA3707@in.ibm.com> <20050404155245.GA4659@in.ibm.com> <20050404162216.GA18469@kvack.org> <1112637395.10602.95.camel@lade.trondhjem.org> <20050405154641.GA27279@kvack.org> <20050407114302.GA13363@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050407114302.GA13363@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 12:43:02PM +0100, Christoph Hellwig wrote:
>  - switch all current semaphore users that don't need counting semaphores
>    over to use a mutex_t type.  For now it can map to struct semaphore.
>  - rip out all existing complicated struct semaphore implementations and
>    replace it with a portable C implementation.  There's not a lot of users
>    anyway.  Add a mutex_t implementation that allows sensible assembly hooks
>    for architectures instead of reimplementing all of it
>  - add more features to mutex_t where nessecary

Oh dear, this is going to take a while.  In any case, here is such a 
first step in creating such a sequence of patches.  Located at 
http://www.kvack.org/~bcrl/patches/mutex-A0/ are the following patches:

	00_mutex.diff	- Introduces the basic mutex abstraction on top 
			  of the existing semaphore implementation.
	01_i_sem.diff	- Converts all users of i_sem to use the mutex 
			  abstraction.
	10_new_mutex.diff - Replaces the semphore mutex with a new mutex 
			    derrived from Trond's iosem patch.  Note that 
			    this fixes a serious bug in iosems: see the 
			    change in mutex_lock_wake_function that ignores 
			    the return value of default_wake_function, as 
			    on SMP a process might still be running while 
			    we actually made progress.
	sem-test.c	- A basic stress tester for the mutex / semaphore.

I'm still not convinced that introducing the mutex type is the best 
approach, especially given the history of the up()/down() implementation.

On the aio side of things, I introduced the owner field in the mutex (as 
opposed to the flag in Trond's iosem) for the next patch in the series to 
enable something like the following api:

	int aio_lock_mutex(struct mutex *lock, struct iocb *iocb);

	...generic_file_read....
	{
		ret = mutex_lock_aio(&inode->i_sem, iocb);
		if (ret)
			return ret; /* aio_lock_mutex can return -EIOCBQUEUED */
		...
		mutex_unlock(&inode->i_sem);
	}

mutex_lock_aio will attempt to take the lock if the iocb is not the owner, 
otherwise it returns immediately (ie ->owner == iocb).  This will allow for 
code paths that support aio to follow a fairly similar coding style to the 
synchronous io path.

More next week...

		-ben
-- 
"Time is what keeps everything from happening all at once." -- John Wheeler
