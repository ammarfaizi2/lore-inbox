Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267360AbSLERUp>; Thu, 5 Dec 2002 12:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267359AbSLERUp>; Thu, 5 Dec 2002 12:20:45 -0500
Received: from pc1-cwma1-5-cust42.swan.cable.ntl.com ([80.5.120.42]:23977 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267360AbSLERUd>; Thu, 5 Dec 2002 12:20:33 -0500
Subject: Re: Process verification while running
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Airlie <airlied@linux.ie>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0212050125420.14956-100000@skynet>
References: <Pine.LNX.4.44.0212050125420.14956-100000@skynet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Dec 2002 18:03:00 +0000
Message-Id: <1039111380.19636.23.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-12-05 at 01:34, Dave Airlie wrote:
> kernel and userspace) to protect against memory issue and tampering. I

Well it wont protect you from tampering, there isnt really a way to do
that

> For the kernel I'm going to add a kernel thread that loops over the text
> segment verifying integrity.

Kernel module code lives outside that. You also have to make sure you 
check the exception handlers area as part of your text.

> For userspace I was initially going to use a userspace daemon that reads
> via /proc/pid/mem interface and tests the text segments against what I
> hope is in there.. but this seems to be a problem as I need to ptrace
> attach the process (which starts sending SIGSTOPs around when the process
> gets a signal) to get a /proc/pid/mem.

You need to stop a process to do the check. You also need to audit its
mappings, check any trampolines on the stack, check any data which is
used for things like syscall numbering etc. Since there are function
pointers all over the place in the data segment it wont help you one
iota against tampering by competent bodies.

> My other option is to implement my own kernel module to do the work, and
> have a kernel thread running around.. I'd have to feed it the CRCs and
> stuff at the start and let it go...

That may be easier since you can then lock the mm, walk and verify it,
then unlock the mm.
> 
> Could I remove the check that stops other processes reading /proc/pid/mem?
> safely enough considering this system runs embedded with very little scope
> for outside interference...

You need to be very careful or you may make your box less not more
secure. In addition you have to handle shared memory and memory mapped
i/o mmap spaces, which is another reason you have to lock all users of
that mm or stop them.

Alan



