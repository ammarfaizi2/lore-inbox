Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316145AbSETRFQ>; Mon, 20 May 2002 13:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316159AbSETRFP>; Mon, 20 May 2002 13:05:15 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:18949 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S316158AbSETRFM>; Mon, 20 May 2002 13:05:12 -0400
Date: Mon, 20 May 2002 19:05:12 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [patch *] Pull unneeded sched.h includes
Message-ID: <Pine.LNX.4.33.0205201827160.5574-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While looking for files that #include <linux/sched.h> only for the sake of 
jiffies or capable, I've stumbled across 518 files that include it for 
no apparent reason at all. I.e., they don't use any of the definitions 
in sched.h, but might need some of the 79 files that sched.h pulls in.

A patch to remove these unneeded #includes is 170kB in size (uncompressed) 
and can be found at

  http://www.physik3.uni-rostock.de/tim/kernel/2.5/sched.h-03.patch.gz

Because of it's size I only append comments on the cases where additional 
#includes where necessary to resolve broken dependencies.

I've allmost certainly missed more obscure dependencies for architectures/
drivers I didn't compile.


Tim

--------------------------------------------------------

include/linux/brlock.h wants <linux/smp.h> instead.
include/linux/device.h wants <linux/spinlock.h> instead.

These want <linux/thread_info.h> instead:
   include/asm-ia64/uaccess.h
   include/asm-x86_64/uaccess.h
   include/asm-arm/uaccess.h
   include/asm-sparc64/uaccess.h
   include/asm-alpha/uaccess.h
   include/asm-i386/uaccess.h

fs/ext2/ioctl.c now needs to include sched.h for the declaration of
capable, while it was previously included from <asm/uaccess.h>. This will
be fixed when capable moves to <linux/capability.h>.

include/linux/namespace.h now needs to include sched.h for the
declarations of task_lock() and task_unlock(), while sched.h previously
was included by all users of namespace.h .

ipc/msg.c h now needs to include sched.h for the declaration of
TASK_INTERRUPTIBLE as well as some others. sched.h was previously included
indirectly through <asm/uaccess.h>.

arch/i386/lib/delay.c and arch/x86_64/lib/delay.c want <asm/param.h>,
<asm/msr.h>, and <asm/thread_info.h> instead.

arch/sh/lib/delay.c wants <asm/param.h> instead.
   
fs/nfsd/nfscache.c now needs to include sched.h for the declaration of
jiffies. Although a patch to pull jiffies from sched.h allready exists, I
wanted to keep both patches orthogonal. This will be fixed later.


