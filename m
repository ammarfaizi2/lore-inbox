Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbVEaSV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVEaSV5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 14:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbVEaSV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 14:21:57 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:14366 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261169AbVEaSVx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 14:21:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=mndacHVbQRJ+kVCJ6pTHRakON/6tbVObKIefP8wYcsV6jl9RZBjcHLMaYaZ+YHC+8hkTO6Ebul8oUAlOTSEiwAQ7PBFGnDFPPA3/mVeXfSiLhqJppHdLt0iw+5Hm8piQkikr/gPuzsltNtT8psXVwOcaGOP7ZSxLIEq2LUl8kfM=
Message-ID: <3faf05680505311121264fab06@mail.gmail.com>
Date: Tue, 31 May 2005 23:51:53 +0530
From: vamsi krishna <vamsi.krishnak@gmail.com>
Reply-To: vamsi krishna <vamsi.krishnak@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: kernel generating SIGBUS while handling pagefault.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a program which is trying to access its virtual memory segments
(listed in /proc/<pid>/maps file). But while reading the following
virtual memory segment as below.
<-------------------------------------------------------------------------------------------------------------------->
       0x2a95556000       0x2a9566b000   0x115000          0
/lib64/ld-2.3.2.so
       0x2a9566b000       0x2a9566c000     0x1000    0x15000
/lib64/ld-2.3.2.so
<-------------------------------------------------------------------------------------------------------------------->
generate SIGBUS with siginfo as BUS_ADRERR (Non-existent physical
address), I traced back into the kernel code to get the detail on why
this BUS_ADRERR is set and found that, if the kernel could not handle
pagefault it generates BUS_ADRERR.

 In the file /usr/src/linux-2.4.21-20.EL/mm/memory.c at line 1746.
<------------------------------------------------------------------->
        new_page = vma->vm_ops->nopage(vma, address & PAGE_MASK, 0);

       if (new_page == NULL)   /* no page was available -- SIGBUS */
               return 0;
       if (new_page == NOPAGE_OOM)
               return -1;
<------------------------------------------------------------------->
So is the kernel trying to get a page (map a page) into the swap space
from file, and failing to map the file ? due to lack of swap space??.
Currently the kernel runs on a amd64 machine with 5GB RAM and 33GB
swap space.

But if I run the same program(executable) on amd64 machine with kernel
2.4.21-4 with 8GB RAM and 16GB swap space, there were no page faults
and I see only 1 virtual address mapping for /lib64/ld-2.3.2.so on
this machine.

I analyzed the strace on the machine failing with SIGBUS and found the
following in the strace output
<-------------------------------------------------------------------->
mmap(NULL, 1061968, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =
0x2a95687000 mprotect(0x2a9568b000, 1045584, PROT_NONE) = 0
mmap(0x2a95787000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED,
3, 0) = 0x2a95787000
close(3)                                = 0
mprotect(0x7fbff09000, 4096,
PROT_READ|PROT_WRITE|PROT_EXEC|PROT_GROWSDOWN) = -1 EINVAL (Invalid
argument) mprotect(0x7fbff02000, 32768,
PROT_READ|PROT_WRITE|PROT_EXEC) = -1 ENOMEM (Cannot allocate memory)
mprotect(0x7fbff06000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC) = -1
ENOMEM (Cannot allocate memory) mprotect(0x7fbff08000, 8192,
PROT_READ|PROT_WRITE|PROT_EXEC) = 0 mprotect(0x7fbff06000, 8192,
PROT_READ|PROT_WRITE|PROT_EXEC) = -1 ENOMEM (Cannot allocate memory)
mprotect(0x7fbff07000, 4096, PROT_READ|PROT_WRITE|PROT_EXEC) = -1
ENOMEM (Cannot allocate memory)
<-------------------------------------------------------------------->
I see some system calls failing with 'Cannot allocate memory', is this
because that I use only 5GB of RAM for a 64-bit machine?

Can some mm hackers kindly give some inputs in this?

Thanks in advance.

Best,
Vamsi kundeti.
India.
