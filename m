Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267899AbTBYK1N>; Tue, 25 Feb 2003 05:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267900AbTBYK1N>; Tue, 25 Feb 2003 05:27:13 -0500
Received: from trappist.elis.rug.ac.be ([157.193.67.1]:29319 "EHLO
	trappist.elis.rug.ac.be") by vger.kernel.org with ESMTP
	id <S267899AbTBYK1M>; Tue, 25 Feb 2003 05:27:12 -0500
Date: Tue, 25 Feb 2003 11:36:44 +0100 (CET)
From: fcorneli@elis.rug.ac.be
To: Manfred Spraul <manfred@colorfullife.com>
cc: Daniel Jacobowitz <dan@debian.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ptrace PTRACE_READDATA/WRITEDATA, kernel 2.5.62
In-Reply-To: <3E5A6298.3030601@colorfullife.com>
Message-ID: <Pine.LNX.4.44.0302251113050.2572-100000@tom.elis.rug.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> >+		ret = 0;
> >+		res = ptrace_readdata(child, addr, (void *)addr2, data);
> >+		if (res == data)
> >+			break;
> >  
> >
> You mention sparc - have you tested if that works on sparc?
> ptrace_readdata assumes that addr2 is a pointer to kernel space, not 
> user space. It works by chance on i386, but that's not acceptable for 
> merging.
> You must double buffer, check mem_read in fs/proc/base.c

I don't own a sparc so I couldn't test it. But since the ptrace_readdata 
lives in the kernel tree for some time now and nobody is complaining about 
it I assume the sparc usage of ptrace_readdata is OK. I did test it on 
i386 and it works just fine.

When I look at the implementation of ptrace_readdata the dst (3th arg) has 
to be a pointer to user space; see: copy_to_user(dst, buf, retval). Only 
access_process_vm wants a kernel pointer. Anyway access_process_vm has 
some known issues, see:
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.62/2.5.62-mm3/broken-out/ptrace-flush.patch
but it's getting fixed I hope.

As for that double buffering, it's already there. See usage of: 
kernel/ptrace.c:ptrace_readdata:char buf[128];
Please notice this double buffering can be eliminated as done in my 
exptrace patch, available at:
http://www.elis.rug.ac.be/~fcorneli/downloads/devel/exptrace-0.3.6pre7-2.4.20.patch
This speeds up everything... but the code needs some more testing, and a 
port to 2.5.

Regards,
Frank.


