Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266448AbRHWNzP>; Thu, 23 Aug 2001 09:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266488AbRHWNzF>; Thu, 23 Aug 2001 09:55:05 -0400
Received: from web13601.mail.yahoo.com ([216.136.175.112]:43538 "HELO
	web13601.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S266448AbRHWNy6>; Thu, 23 Aug 2001 09:54:58 -0400
Message-ID: <20010823135514.93176.qmail@web13601.mail.yahoo.com>
Date: Thu, 23 Aug 2001 06:55:14 -0700 (PDT)
From: Ivan Kalvatchev <iive@yahoo.com>
Subject: if (malloc() == HORROR_WITHIN) BUG();
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: kernelbug <linux-kernel@vger.kernel.org>,
        Andrey Savochkin <saw@saw.sw.com.sg>,
        Szabolcs Szakacsits <szaka@f-secure.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Actually i cannot understand how this "optimistic
memory allocation strategy" works. 
It is normal all requested memory to be allocated
before malloc returns any result. At this moment it
seem to be something like alloc on demand, and this
requires special flag, otherwise there gonna be
CoreDump.
I don't have glibc sources but i assume that malloc is
translated to vmalloc.
Malloc should be able to alloc pages in ram and swap.
Currently the memory management seems to be separated
in two independent parts, RAM management and swap
transfer. Instead of working as one, the swap is used
to keep amount of pages free. In this situation it is
impossible to make correct routine that allocates more
memory than are available as free pages. And even
worse, kswapd is called 0.5 times per second, or on
page fault. At least it should be linked with routines
that allocate memory. But in this implementation the
effect could be negative. More, kswapd is used to
reduce buffer and cache.

 The 2.4.x memory management should be fixed now. 
The quick fix could be to use
mm/mmap::vm_enough_memory, to check amount of free
pages in vmalloc. The strange thing is that this
function is used in shmem.c that hold tmpfs. So
please, synchronize this with
mm/oom_kill.c::out_of_memory. And please don't balance
things out, be more paranoid.
I first thought to use out_of_memory (with some
tweaking) to check vmalloc, because this will force
use of oom_kill only after huge kmalloc.
This optimistic allocation should be removed , because
there are some horrible workarounds for this. 
About the beancounter: I don't know this algorithm,
but i don't need group based resources accounting. For
me the things are simple - give memory if there is
any. If there is not don't give loans, Linux is not a
bank!!!! :)

__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
