Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279672AbRJYF7B>; Thu, 25 Oct 2001 01:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279713AbRJYF6v>; Thu, 25 Oct 2001 01:58:51 -0400
Received: from mta03ps.bigpond.com ([144.135.25.135]:49400 "EHLO
	mta03ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S279672AbRJYF6b>; Thu, 25 Oct 2001 01:58:31 -0400
Message-ID: <3BD7AA3A.8040104@bigpond.net.au>
Date: Thu, 25 Oct 2001 15:59:22 +1000
From: Steven Butler <stevenb1@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.12 i686; en-US; rv:0.9.1) Gecko/20010622
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Memory Paging and fork copy-on-write semantics
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I have been making use of copy-on-write semantics of linux fork to 
duplicate a process around 100+ times to generate client load against a 
server.  The copy-on-write allows me to run many more processes without 
swap thrashing than I'd otherwise be able to.  The client code is in 
perl, so the process sizes are in the MBs.  Using this technique I only 
need about 2 MB per user, with around 5.5 MB shared.

What I've found is that everything works fine, so long as I don't run so 
many clients that the kernel pages out part of a process.  When this 
happens, it seems (from looking at top output) that the shared memory is 
copied when it is paged-out.  What's worse is it seems that it is copied 
for each process that is sharing it.  The net effect is that one page is 
gained, but many more pages are created in the other processes that were 
sharing the memory.  I typically see shared memory in each perl process 
drop down to less than 2 MB when this occurs, so each process now 
consumes about 6 MB of unshared memory (or so top tells me).

The upshot is the VM system thrashes really badly, because now it has to 
swap more data out to disk.  The sytem becomes unresponsive and I have 
to wait minutes for keystrokes to be recognised (think CTRL-C ;) ).  The 
good news is that when the scripts complete, the system seems completely 
normal.

My sytem is a PIII-550 intel BX chipset 7200 RPM IDE drive with 384 MB 
RAM if anyone's interested.

Is this expected and reasonable behaviour?  Is it possible for pages to 
remain shared, even when they are swapped to disk?  Does that already 
happen anyway, meaning my analysis of the situation is off base?

I am currently running a vanilla 2.4.12, but have observed the same kind 
of behaviour in all linux 2.4.x series kernel with the client test 
application.  I haven't tried it with 2.2.x or Alan Cox's latest kernel 
series.

Thanks for listening and thanks to all the kernel hackers for all their 
hard work.

Cheers,
Steve Butler

