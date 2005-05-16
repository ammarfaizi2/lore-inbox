Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261598AbVEPM6D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbVEPM6D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 08:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbVEPM6C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 08:58:02 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:7767 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S261598AbVEPM4v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 08:56:51 -0400
Message-ID: <42889890.8090505@tls.msk.ru>
Date: Mon, 16 May 2005 16:56:48 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roberto Fichera <kernel@tekno-soft.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: How to use memory over 4GB
References: <6.2.1.2.2.20050516142516.0313e860@mail.tekno-soft.it>
In-Reply-To: <6.2.1.2.2.20050516142516.0313e860@mail.tekno-soft.it>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roberto Fichera wrote:
> Hi All,
> 
> I've a dual Xeon 3.2GHz HT with 8GB of memory running kernel 2.6.11.
> I whould like to know the way how to use all the memory in a single
> process, the application is a big simulation which needs big memory
> chuncks.
> I have readed about hugetlbfs, shmfs and tmpfs, but don't understand how
> I can access
> the whole memory. Ok! I can create a big file on tmpfs using shm_open() and
> than map it by using mmap() or mmap2() but how can I access over 4GB using
> standard pointers (if I had to use it)?

There's no "standard" and simple way to utilize more than 4Gb memory on
i386 hardware, especially in a userspace.  That is, the size of a pointer
is 32bits, which is 4GB addresspace maximum.  i386 architecture just can't
have a pointer of greather size.

All "extra" (>4GB) space can be used like a file in a filesystem, not like
a plain memory.  Think of read()/write() (or pread()/pwrite() for that matter),
but much faster ones compared to disk-based storage -- in tmpfs.  You can
also mmap() *parts* of such a file, but will be still limited to 4GB at
once -- in order to have more, you will have to unmap() something.

All the "large applications" (most notable large database systems such as
Oracle) can't use more than 4GB memory directly, but can utilize it for
database cache.  In directly-addressible space there's a "table of content"
of cached buffers is keept, and when a buffer is needed, it is mmap()'ed
into the application's address space, and unmapped right away when it isn't
needed anymore (but it is still in memory).  Ofcourse you can't have
usual pointers into that memory, but you can use something like
(block-number,offset) instead of a pointer (pagetables).

/mjt
