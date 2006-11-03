Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWKCUfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWKCUfG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 15:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbWKCUfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 15:35:06 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:38027 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932090AbWKCUfE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 15:35:04 -0500
Message-ID: <454BA7F7.8030205@vmware.com>
Date: Fri, 03 Nov 2006 12:35:03 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>,
       virtualization@lists.osdl.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH 1/7] paravirtualization: header and stubs for	paravirtualizing
 critical operations
References: <20061029024504.760769000@sous-sol.org>	<20061030231132.GA98768@muc.de>	<1162376827.23462.5.camel@localhost.localdomain> <200611030356.54074.ak@suse.de>
In-Reply-To: <200611030356.54074.ak@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Wednesday 01 November 2006 11:27, Rusty Russell wrote:
>   
>> Create a paravirt.h header for all the critical operations which need
>> to be replaced with hypervisor calls, and include that instead of
>> defining native operations, when CONFIG_PARAVIRT.
>>     
>
> Hmm, did this all ever compile in mainline? I had to do a few merges
> and in the end i get
>
> /home/lsrc/quilt/linux/kernel/spinlock.c: In function ‘_spin_lock_irqsave’:
> include2/asm/spinlock.h:59: error: invalid 'asm': operand number missing after %
> -letter
> include2/asm/spinlock.h:59: error: invalid 'asm': operand number missing after %
> -letter
> include2/asm/spinlock.h:59: error: invalid 'asm': operand number missing after %
> -letter
> include2/asm/spinlock.h:59: error: invalid 'asm': operand number missing after %
> -letter
> include2/asm/spinlock.h:59: error: invalid 'asm': operand number missing after %
> -letter
> include2/asm/spinlock.h:59: error: invalid 'asm': operand number missing after %
> -letter
> include2/asm/spinlock.h:59: error: invalid 'asm': operand number missing after %
> -letter
> include2/asm/spinlock.h:59: error: invalid 'asm': operand number missing after %
> -letter
> {standard input}: Assembler messages:
> {standard input}:593: Error: undefined symbol `paravirt_ops' in operation
> {standard input}:593: Error: undefined symbol `PARAVIRT_irq_enable' in operation
> {standard input}:605: Error: undefined symbol `paravirt_ops' in operation
> {standard input}:605: Error: undefined symbol `PARAVIRT_irq_disable' in operatio
> n
>   

Not seeing that here (on 2.6.19-rc2-mm2 with gcc 4.0.2).

> and lots of new warnings like
>
> /home/lsrc/quilt/linux/arch/i386/kernel/traps.c: In function ‘set_intr_gate’:
> /home/lsrc/quilt/linux/arch/i386/kernel/traps.c:1165: warning: implicit declarat
> ion of function ‘_set_gate’
> /home/lsrc/quilt/linux/arch/i386/kernel/cpu/common.c: In function ‘_cpu_init’:
> /home/lsrc/quilt/linux/arch/i386/kernel/cpu/common.c:754: warning: implicit decl
> aration of function ‘__set_tss_desc'
>   

Sounds like desc.h got reordered.  Somewhere, there was a broken patch 
once that did this, I thought we fixed that.

> /home/lsrc/quilt/linux/arch/i386/kernel/cpu/mcheck/p4.c: In function ‘intel_mach
> ine_check’:
> /home/lsrc/quilt/linux/arch/i386/kernel/cpu/mcheck/p4.c:158: warning: ‘dbg.eax’ 
> may be used uninitialized in this function
> /home/lsrc/quilt/linux/arch/i386/kernel/cpu/mcheck/p4.c:158: warning: ‘dbg.ebx’ 
> may be used uninitialized in this function
> /home/lsrc/quilt/linux/arch/i386/kernel/cpu/mcheck/p4.c:158: warning: ‘dbg.ecx’ 
> may be used uninitialized in this function
> /home/lsrc/quilt/linux/arch/i386/kernel/cpu/mcheck/p4.c:158: warning: ‘dbg.edx’ 
> may be used uninitialized in this function
> /home/lsrc/quilt/linux/arch/i386/kernel/cpu/mcheck/p4.c:158: warning: ‘dbg.esi’ 
> may be used uninitialized in this function
> /home/lsrc/quilt/linux/arch/i386/kernel/cpu/mcheck/p4.c:158: warning: ‘dbg.edi’ 
> may be used uninitialized in this function
> /home/lsrc/quilt/linux/arch/i386/kernel/cpu/mcheck/p4.c:158: warning: ‘dbg.ebp’ 
> may be used uninitialized in this function
> /home/lsrc/quilt/linux/arch/i386/kernel/cpu/mcheck/p4.c:158: warning: ‘dbg.esp’ 
> may be used uninitialized in this function
> /home/lsrc/quilt/linux/arch/i386/kernel/cpu/mcheck/p4.c:158: warning: ‘dbg.eflag
> s’ may be used uninitialized in this function
> /home/lsrc/quilt/linux/arch/i386/kernel/cpu/mcheck/p4.c:158: warning: ‘dbg.eip’ 
> may be used uninitialized in this function
>   

Those appear to be valid warnings, with or without paravirt, due to the 
tacky glued inline oddity of intel_get_extended_msrs.

Zach
