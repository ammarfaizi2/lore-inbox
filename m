Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268268AbTBMTOH>; Thu, 13 Feb 2003 14:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268269AbTBMTOG>; Thu, 13 Feb 2003 14:14:06 -0500
Received: from [213.86.99.237] ([213.86.99.237]:7883 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S268268AbTBMTOD>; Thu, 13 Feb 2003 14:14:03 -0500
Subject: Re: Fix stack handling in acpi_wakeup.S
From: David Woodhouse <dwmw2@infradead.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20030211184452.GA24966@elf.ucw.cz>
References: <20030211184452.GA24966@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045163832.304.46.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 13 Feb 2003 19:17:13 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-02-11 at 18:44, Pavel Machek wrote:
> Hi!
> 
> This fixes stack handling in acpi_wakeup.S, and makes stack smaller so
> that wakeup code actually fits inside memory allocated for it. Plus
> someone renamed .L1432 to something meaningfull. Please apply,

I am confused. If I apply your patch, I get a failure to resume (precise
symptoms below) on both boards I've tried it on. Applying this obviously
broken patch 'fixes' it:

--- arch/i386/kernel/acpi.c.orig        Thu Feb 13 19:07:34 2003
+++ arch/i386/kernel/acpi.c     Thu Feb 13 19:07:36 2003
@@ -483,6 +483,7 @@
        if (!acpi_wakeup_address)
                return 1;
        init_low_mapping(swapper_pg_dir, USER_PTRS_PER_PGD);
+       memset((void *)acpi_wakeup_address, 0, 0x3000);
        memcpy((void *) acpi_wakeup_address, &wakeup_start, &wakeup_end
- &wakeup_start);
        acpi_copy_wakeup_routine(acpi_wakeup_address);
  

If I reserve the whole three pages I scribble on in the above patch (and
which we used to scribble on), by calling alloc_bootmem_low(3*PAGE_SIZE)
in acpi_reserve_bootmem(), then the failure to resume returns. I _need_
to scribble on whatever's after us :)

Failure mode is as follows:

Upon resume, _all_ processes with a userspace VM will oops on being
rescheduled. In every case, %eip is zero and %esp is the very top of the
8KiB area allocated for the task structure and stack. For example:

 portmap left refrigerator
Unable to handle kernel NULL pointer dereference at virtual address
00000000
 printing eip:
00000000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<00000000>]    Not tainted
EFLAGS: 00010046
EIP is at 0x0
eax: 000000a8   ebx: 08054db0   ecx: 00000003   edx: ffffffff
esi: 08054db0   edi: 08054db0   ebp: bffffd3c   esp: ce14e000
ds: 007b   es: 007b   ss: 0068
Process portmap (pid: 550, threadinfo=ce14c000 task=ce4f80a0)
Stack:
Call Trace:
                                                                                                                                                      
Code:  Bad EIP value.

-- 
dwmw2
