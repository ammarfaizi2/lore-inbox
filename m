Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317471AbSGXSnF>; Wed, 24 Jul 2002 14:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317472AbSGXSnE>; Wed, 24 Jul 2002 14:43:04 -0400
Received: from zmamail02.zma.compaq.com ([161.114.64.102]:38671 "EHLO
	zmamail02.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S317471AbSGXSnD>; Wed, 24 Jul 2002 14:43:03 -0400
Date: Wed, 24 Jul 2002 13:43:59 -0500
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Subject: ioremap question, powerpc vs. x86
Message-ID: <20020724134359.B31993@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been playing around with ioremap and noticed some
different behavior on x86 vs. powerpc platforms.  I asked
about it on the powerpc embedded mailing list, but no luck,
so I thought I'd try here, as maybe it's a more generic kernel
question anyway.

I have a couple machines, each with 128Mb RAM.  One is x86, one
is powerpc.  I boot both wtih kernel parameters "mem=64M", then
do this, within a kernel module:

	ioremapped_memory = ioremap(1024*1024*64, 1024*1024*64);

to get to the remaining 64Mb.  So far so good.
I can memcpy or memset all of ioremapped_memory just fine.

Then, I try to use this buffer to receive from sock_recvmsg().
sock_recvmsg eventually calles __copy_tofrom_user() to copy
its data into this buffer.  Well, this works fine on x86, but
panics on powerpc.

To get around this, I renamed __copy_tofrom_user9) __real_copy_tofrom_user()
and created my own __copy_tofrom_user() which checks the to and from addresses
and if either is within the ioremapped buffer, then it calls memcpy()
otherwise it calls __real_copy_tofrom_user().  This avoids the problem,
and it's all working fine now, but, I'm still confused.

My question is why do powerpc and x86 behave differently here?
Is in not ok to call copy_to_user when the destination is really
a kernel virtual address, yet it only coincidentally works on x86?
Or, is it supposed to work, but things are broken in some way on 
powerpc?

(I have seen it said that you _must_ use readb()/writeb(), etc. with 
ioremapped memory, but I had presumed this was because 99% of the time
when you use ioremap, you are using it to map, e.g. a pci device's
registers/memory into the processor's address space.  In my case, I'm
using it to map the hosts own RAM into the cpu's address space, so
accessing the memory as though it were ordinary memory should be ok,
since it is in fact, ordinary memory.  Or so I would think.

Thanks for any explanation,

-- steve

