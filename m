Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265144AbUJBNB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265144AbUJBNB7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 09:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265211AbUJBNB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 09:01:59 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:49382 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S265144AbUJBNBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 09:01:55 -0400
Message-ID: <415EA6C0.9020008@comcast.net>
Date: Sat, 02 Oct 2004 09:01:52 -0400
From: Ed Sweetman <safemode@comcast.net>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Cambrant <cambrant@acc.umu.se>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-rc3-mm1 build failure
References: <20041002091644.GA8431@gamma.logic.tuwien.ac.at> <20041002022921.0e1aceb3.akpm@osdl.org> <20041002105038.GB2470@stusta.mhn.de> <20041002105853.GD11386@shaka.acc.umu.se>
In-Reply-To: <20041002105853.GD11386@shaka.acc.umu.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Cambrant wrote:

>On Sat, Oct 02, 2004 at 12:50:38PM +0200, Adrian Bunk wrote:
>  
>
>>On Sat, Oct 02, 2004 at 02:29:21AM -0700, Andrew Morton wrote:
>>    
>>
>>>Norbert Preining <preining@logic.at> wrote:
>>>      
>>>
>>>>..
>>>>   LD      .tmp_vmlinux1
>>>> arch/i386/kernel/built-in.o(.text+0x111f5): In function `end_level_ioapic_irq':
>>>> : undefined reference to `irq_mis_count'
>>>> kernel/built-in.o(.text+0x1eba7): In function `ack_none':
>>>> : undefined reference to `ack_APIC_irq'
>>>> make[1]: *** [.tmp_vmlinux1] Fehler 1
>>>> make[1]: Leaving directory `/usr/src/linux-2.6.9-rc3-mm1'
>>>>        
>>>>
>>>hm, that's clever.
>>>
>>>See if arch/i386/kernel/io_apic.c needs
>>>      
>>>
>>s/io_apic.c/irq.c/ and it should solve Norberts problem.
>>
>>    
>>
>>>#include <asm/io_apic.h>
>>>...
>>>      
>>>
>
>Sorry, forgot to cc LKML. The following patch works for me.
>
>
>--- linux-2.6.9-rc3-mm1/arch/i386/kernel/irq.c.orig     2004-10-02 12:52:57.833294096 +0200
>+++ linux-2.6.9-rc3-mm1/arch/i386/kernel/irq.c  2004-10-02 12:53:14.935694136 +0200
>@@ -17,6 +17,7 @@
> 
> #include <asm/uaccess.h>
> #include <asm/hardirq.h>
>+#include <asm/io_apic.h>
> 
> #ifdef CONFIG_4KSTACKS
> /*
>
>
>  
>
asm/io_apic.h is the file that seems to be missing all the 
declarations.  When i included it in irq.c as the above patch does, my 
build immediately failed with this.   My config is for uni-processor 
with io-apic enabled in config.

In file included from arch/i386/kernel/irq.c:20:
include/asm/io_apic.h: At top level:
include/asm/io_apic.h:108: error: `MAX_IO_APICS' undeclared here (not in 
a function)
include/asm/io_apic.h:154: error: `MAX_IO_APICS' undeclared here (not in 
a function)
include/asm/io_apic.h: In function `io_apic_read':
include/asm/io_apic.h:167: warning: implicit declaration of function 
`__fix_to_virt'
include/asm/io_apic.h:167: error: `FIX_IO_APIC_BASE_0' undeclared (first 
use in this function)
include/asm/io_apic.h:167: error: (Each undeclared identifier is 
reported only once
include/asm/io_apic.h:167: error: for each function it appears in.)
include/asm/io_apic.h: In function `io_apic_write':
include/asm/io_apic.h:173: error: `FIX_IO_APIC_BASE_0' undeclared (first 
use in this function)
include/asm/io_apic.h: In function `io_apic_modify':
include/asm/io_apic.h:187: error: `FIX_IO_APIC_BASE_0' undeclared (first 
use in this function)
make[1]: *** [arch/i386/kernel/irq.o] Error 1

