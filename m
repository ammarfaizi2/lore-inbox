Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317506AbSH3UyH>; Fri, 30 Aug 2002 16:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317512AbSH3UyG>; Fri, 30 Aug 2002 16:54:06 -0400
Received: from msparker.nvidia.com ([216.228.112.140]:36616 "EHLO
	msparker.nvidia.com") by vger.kernel.org with ESMTP
	id <S317506AbSH3UyF>; Fri, 30 Aug 2002 16:54:05 -0400
From: Terence Ripperda <TRipperda@nvidia.com>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
To: linux-kernel@vger.kernel.org
Date: Fri, 30 Aug 2002 15:40:22 -0500
Subject: lockup on Athlon systems, kernel race condition?
Message-ID: <20020830204022.GC736@hygelac>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.4.19 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working on a problem where leaving viewperf running overnight with our drivers on a dual Athlon system locks up. The same problem is not reproducible on a dual P3 or dual P4.

Using kdb, I was able to break in and take a look at things once they hung. It appears to be a core kernel race condition. I'm not 100% sure, so I wanted to lay the information out for you to see if the diagnosis looks correct.


The debugger breaks into cpu 1, with the following backtrace:

Entering kdb (current=0xe1eea000, pid 2103) on processor 1 due to Keyboard Entry
[1]kdb> bt
EBP        EIP        Function (args)
0xe1eeb910 0xc0115739 smp_call_function+0x99 (0xc0115550, 0x0, 0x1, 0x1, 0x400000)
                               kernel .text 0xc0100000 0xc01156a0 0xc0115790
0xe1eeb92c 0xc01155b4 flush_tlb_all+0x14 (0x1000, 0xf9b82000, 0x2d29f000, 0xc0101f9c, 0x73)
                               kernel .text 0xc0100000 0xc01155a0 0xc0115600
0xe1eeb96c 0xc011883f remap_area_pages+0x1ef (0xf9c00000, 0x2d29f000, 0x1000, 0x10, 0x1000)
                               kernel .text 0xc0100000 0xc0118650 0xc0118850
0xe1eeb994 0xc011890c __ioremap+0xbc (0x2d29f000, 0x1000, 0x10, 0xf891eb7f, 0x2d29f000)
                               kernel .text 0xc0100000 0xc0118850 0xc0118940
0xe1eeb9c4 0xf890cf3c [NVdriver]os_map_kernel_space+0x68 (0x2d29f000, 0x1000, 0x1, 0xf891da57, 0xf9b82000)
                               NVdriver .text 0xf8909060 0xf890ced4 0xf890cf80
... nvidia agp functions ...
0xe1eebf94 0xf890a7a4 [NVdriver]nv_kern_ioctl+0x2d0 (0xf5099380, 0xeb01ccc0, 0xc0284627, 0xbfffe810, 0xe1eea000)
                               NVdriver .text 0xf8909060 0xf890a4d4 0xf890a7c4
0xe1eebfbc 0xc0154d29 sys_ioctl+0x209 (0x6, 0xc0284627, 0xbfffe810, 0x2100, 0x8147048)
                               kernel .text 0xc0100000 0xc0154b20 0xc0154d90
           0xc0109415 system_call+0x55
                               kernel .text 0xc0100000 0xc01093c0 0xc010941c

the basic idea is that when handling agp allocations, we're mapping and unmapping pages, which is triggering tlb flushes. (this lockup occurs with nvagp or agpgart). I originally suspected we were causing a race condition by holding a lock, then calling a blocking kernel function, but that is not the case. We are not holding any locks here.

checking out the other cpu reveals:

[1]kdb> cpu 0

Entering kdb (current=0xf1612000, pid 1661) on processor 0 due to cpu switch
[0]kdb> bt
EBP        EIP        Function (args)
           0xc0154d97 .text.lock.ioctl+0x7
                               kernel .text 0xc0100000 0xc0154d90 0xc0154dc0
0xf1613fbc 0xc0154b8a sys_ioctl+0x6a (0x4, 0x541b, 0xbfffe15c, 0x805b050, 0x805ab10)
                               kernel .text 0xc0100000 0xc0154b20 0xc0154d90
           0xc0109415 system_call+0x55
                               kernel .text 0xc0100000 0xc01093c0 0xc010941c

disassembling the code at cpu 0's EIP shows:

0xc0154b8a <sys_ioctl+106>:     lock decb 0xc03cae40

looking up 0xc03cae40 in the System.map files shows:

c03cae40 D kernel_flag_cacheline


This code appears to be the following code from fs/ioctl.c (grabbing the big kernel lock):

asmlinkage long sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
{      
        struct file * filp;
        unsigned int flag;
        int on, error = -EBADF;

        filp = fget(fd);
        if (!filp)
                goto out;
        error = 0;
        lock_kernel();    <====
        switch (cmd) {

Recall that the earlier backtrace on cpu 1 was also handling an ioctl, which suggests cpu 1 has the big kernel lock (by nature of being in an ioctl), and cpu 0 is attempting to grab the big kernel lock. While handling the ioctl, cpu 1 is mapping/unmapping pages, which causes an IPI to flush all cpu's tlbs. cpu 0 cannot respond to the IPI, due to being in an atomic operation grabbing the big kernel lock. But cpu 1 has the lock and won't surrender the lock until cpu 0 finishes the IPI.

I believe this is a core kernel race condition. I would also suspect that the same problem could happen with other drivers when run through such a stress test. Perhaps the same problem could be reproduced with another graphics card (calling to the kernel to allocate (agp) memory) left running viewperf overnight.


Thanks,
Terence
