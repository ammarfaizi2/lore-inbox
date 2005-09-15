Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964869AbVIOUlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbVIOUlW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 16:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965282AbVIOUlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 16:41:22 -0400
Received: from mf00.sitadelle.com ([212.94.174.67]:54915 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S964869AbVIOUlW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 16:41:22 -0400
Message-ID: <4329DC6B.2040803@cosmosbay.com>
Date: Thu, 15 Sep 2005 22:41:15 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Sonny Rao <sonny@burdell.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: "Read my lips: no more merges" - aka Linux 2.6.14-rc1
References: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org> <20050913063359.GA29715@kevlar.burdell.org> <43267A00.1010405@cosmosbay.com> <20050915201356.GA20966@kvack.org>
In-Reply-To: <20050915201356.GA20966@kvack.org>
Content-Type: multipart/mixed;
 boundary="------------030609060303080306080309"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030609060303080306080309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Benjamin LaHaise a écrit :
> On Tue, Sep 13, 2005 at 09:04:32AM +0200, Eric Dumazet wrote:
> 
>>I wish a process param could allow open() to take any free fd available, 
>>not the lowest one. One can always use fcntl(fd, F_DUPFD, slot) to move a 
>>fd on a specific high slot and always keep the 64 first fd slots free to 
>>speedup the kernel part at open()/dup()/socket() time.
> 
> 
> The overhead is easy to avoid by making use of dup2() and close() to keep 
> the lowest file descriptors in the table free, allowing open() and socket() 
> to always return 3 or 4.

Yes, this is what I described :) Maybe this was not clear.

> 
> Alternatively, the kernel could track available file descriptors using a 
> tree to efficiently insert freed slots into an ordered list of free 
> regions (something similar to the avl tree used in vmas).  Is it worth 
> doing?

Well no, since a user app can manage itself this part if it happens to be 
performance critical.


Sample of a user land lib : Each time a new fd is returned by 
open()/socket()/pipe()/accept()... the thread should call

fd = fdcache_dupfd(fd);

And close the file using  fdcache_closefd(fd) instead of close(fd);

Eric

--------------030609060303080306080309
Content-Type: text/plain;
 name="fastfdlib.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fastfdlib.c"

/*
 * Unix kernel has an expensive get_unused_fd() function :
 * This is because semantics of Unix mandates that a open()/pipe()/socket()/ call always returns the lowest fd, not a random one.
 * Linux use a linear scan of a table of bits.
 * A program handling 1.000.000 files scans about 128 KB of ram, with a spinlock held : No other thread can get a fd.
 *
 * The trick is to use this library to make sure 64 low fds are available, so that the standard unix functions 
 * dont have to scan a lot of fd before finding a free one.
 * And remap them using fcntl(F_DUPFD) at precise slots we manage ourselfs.
 */
#include <pthread.h>
#include <fcntl.h>
#include <stdlib.h>
#include <unistd.h>

# define MAXFDS 1500000

struct {
	pthread_mutex_t lock;
	unsigned int cache_fd;
	unsigned int next_alloc;
	unsigned int *cache_tab;
	} fdd;


void fdcache_init()
{
	pthread_mutex_init(&fdd.lock, NULL);
	fdd.cache_tab = calloc(MAXFDS, sizeof(unsigned int));
	fdd.next_alloc = 64;
}

int fdcache_dupfd(int fd)
{
	int ret;
	pthread_mutex_lock(&fdd.lock);
	if (fdd.cache_fd == 0)
		fdd.cache_fd = fdd.next_alloc++;
	ret = fcntl(fd, F_DUPFD, fdd.cache_fd);
	if (ret != -1) {
		fdd.cache_fd = fdd.cache_tab[ret];
		pthread_mutex_unlock(&fdd.lock);
		close(fd);
		return ret;
	}
	else {
		pthread_mutex_unlock(&fdd.lock);
		return fd;
	}
}

void fdcache_closefd(int fd)
{
	if (fd == -1)
		return;

	close(fd);

	pthread_mutex_lock(&fdd.lock);
	fdd.cache_tab[fd] = fdd.cache_fd;
	fdd.cache_fd = fd;
	pthread_mutex_unlock(&fdd.lock);
}

--------------030609060303080306080309--
