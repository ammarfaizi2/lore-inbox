Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261565AbUJXSBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbUJXSBc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 14:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbUJXSBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 14:01:31 -0400
Received: from mail.timesys.com ([65.117.135.102]:54144 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261565AbUJXSB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 14:01:28 -0400
Message-ID: <417BEDB7.6050403@timesys.com>
Date: Sun, 24 Oct 2004 14:00:23 -0400
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chuck Harding <charding@llnl.gov>
CC: LKML <linux-kernel@vger.kernel.org>, john cooper <john.cooper@timesys.com>
Subject: Re: 2.6.9-mm1
References: <20041022032039.730eb226.akpm@osdl.org> <Pine.LNX.4.61.0410221515060.25447@ghostwheel.llnl.gov>
In-Reply-To: <Pine.LNX.4.61.0410221515060.25447@ghostwheel.llnl.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Oct 2004 17:56:16.0015 (UTC) FILETIME=[C1EFA9F0:01C4B9F2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Harding wrote:

>On Fri, 22 Oct 2004, Andrew Morton wrote:
>
>
>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9/2.6.9-mm1/
>>
>>- Lots of new patches.
>>
>>
>
>which causes the following during build:
>
>   OBJCOPY arch/i386/boot/compressed/vmlinux.bin
>BFD: Warning: Writing section `.bss' to huge (ie negative) file offset 
>0xc0435000.
>objcopy: arch/i386/boot/compressed/vmlinux.bin: File truncated
>make[2]: *** [arch/i386/boot/compressed/vmlinux.bin] Error 1
>make[1]: *** [arch/i386/boot/compressed/vmlinux] Error 2
>make: *** [bzImage] Error 2
>
This appears a result of changes in:

    arch/i386/kernel/vmlinux.lds.S

which causes the kernel start address to
change from 0xc0100000 to 0x100000 causing
objcopy to gag.  I rolled back to a 2.6.8.1
version of the above linker map file and did
get the kernel to build and [mostly] boot.
However it incorporated Ingo's RT patches and
wasn't exactly a vanilla 2.6.9-mm1.

While I don't recommend the above as a fix,
a repeat of the experiment will require adding
the following to the linker text section:

--- /user1/linux/linux-2.6.8.1/arch/i386/kernel/vmlinux.lds.S   
2004-08-14 06:54:51.000000000 -0400
+++ 
/user1/linux/ingo-preempt/linux-2.6.9-Ux/linux-2.6.9/arch/i386/kernel/vmlinux.lds.S 
2004-10-24 13:11:52.000000000 -0400
@@ -17,6 +17,7 @@
   .text : {
        *(.text)
        SCHED_TEXT
+       LOCK_TEXT
        *(.fixup)
        *(.gnu.warning)
        } = 0x9090


-- 
john.cooper@timesys.com

