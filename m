Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268095AbTBYR0j>; Tue, 25 Feb 2003 12:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268099AbTBYR0i>; Tue, 25 Feb 2003 12:26:38 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:51660 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S268095AbTBYR0f>;
	Tue, 25 Feb 2003 12:26:35 -0500
Message-ID: <3E5BA969.5000905@colorfullife.com>
Date: Tue, 25 Feb 2003 18:35:37 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: fcorneli@elis.rug.ac.be
CC: Daniel Jacobowitz <dan@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ptrace PTRACE_READDATA/WRITEDATA, kernel 2.5.62
References: <Pine.LNX.4.44.0302251113050.2572-100000@tom.elis.rug.ac.be>
In-Reply-To: <Pine.LNX.4.44.0302251113050.2572-100000@tom.elis.rug.ac.be>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fcorneli@elis.rug.ac.be wrote:

>But since the ptrace_readdata 
>lives in the kernel tree for some time now and nobody is complaining about 
>it I assume the sparc usage of ptrace_readdata is OK. I did test it on 
>i386 and it works just fine.
>  
>
Sorry, my fault. I remembered that someone must do double buffering. 
I've overlooked that ptrace_readdata does the double buffering.

>When I look at the implementation of ptrace_readdata the dst (3th arg) has 
>to be a pointer to user space; see: copy_to_user(dst, buf, retval). Only 
>access_process_vm wants a kernel pointer. Anyway access_process_vm has 
>some known issues, see:
>http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.62/2.5.62-mm3/broken-out/ptrace-flush.patch
>but it's getting fixed I hope.
>  
>
This patch seems to be wrong.
flush_dcache_page is not a replacement for flush_page_to_ram(): It's an 
optimized cache flush function, only valid for page cache pages:
If a page is mapped only once, then no aliasing can occur and the flush 
is not required.
For page cache pages, "mapped once" is equivalient to an empty 
page->mapping->i_mmap{,_shared}. The pages are mapped once in the page 
cache, and _if_ they are mapped in user space, then 
page->mapping->i_mmap{,_shared} is not empty.

ptrace can be called on random addresses - sysv shm, anonymous pages, 
etc. page->mapping->i_mmap{,_shared} is meaningless.
If you think about it, if ptrace accesses a page, then it's guaranteed 
to be mapped twice: once in user space, once by the kmap_atomic() for 
the kernel space access.

--
    Manfred



